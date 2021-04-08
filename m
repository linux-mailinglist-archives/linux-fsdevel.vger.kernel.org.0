Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B4D3580F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 12:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhDHKid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 06:38:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51176 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhDHKhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:37:51 -0400
Received: from ip5f5bf209.dynamic.kabel-deutschland.de ([95.91.242.9] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lUS2d-0004fv-0b; Thu, 08 Apr 2021 10:37:39 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] close_range fix
Date:   Thu,  8 Apr 2021 12:36:18 +0200
Message-Id: <20210408103618.1206025-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

/* Summary */
Syzbot reported a bug in close_range. Debugging this showed we didn't
recalculate the current maximum fd number for CLOSE_RANGE_UNSHARE |
CLOSE_RANGE_CLOEXEC after we unshared the file descriptors table.

So max_fd could exceed the current fdtable maximum causing us to set excessive
bits. As a concrete example, let's say the user requested everything from fd 4
to ~0UL to be closed and their current fdtable size is 256 with their highest
open fd being 4. With CLOSE_RANGE_UNSHARE the caller will end up with a new
fdtable which has room for 64 file descriptors since that is the lowest fdtable
size we accept. But now max_fd will still point to 255 and needs to be
adjusted. Fix this by retrieving the correct maximum fd value in
__range_cloexec().

I've carried this fix for a little while but since there was no linux-next
release over easter I waited until now.

With this change close_range() can be simplified a bit but imho we are in no
hurry to do that and so I'll defer this for the 5.13 merge window.

(Fwiw, the two follow-up patches sit in
 https://git.kernel.org/brauner/h/fs/close_range.)

/* Testing */
All patches have seen exposure in linux-next and are based on v5.12-rc4.
The selftests pass and the reproducer provided by syzbot did not trigger. The
patch also has a Tested-by from Dmitry but I had already pushed it out by the
time that came in so it's missing from the patch itself.

/* Conflicts */
At the time of creating this pr no merge conflicts were reported. A test merge
and build with today's master 2021-04-08 12:20:00 CET worked fine.

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2021-04-08

for you to fetch changes up to 9b5b872215fe6d1ca6a1ef411f130bd58e269012:

  file: fix close_range() for unshare+cloexec (2021-04-02 14:11:10 +0200)

Please consider pulling these changes from the signed for-linus-2021-04-08 tag.

Thanks!
Christian

----------------------------------------------------------------
for-linus-2021-04-08

----------------------------------------------------------------
Christian Brauner (1):
      file: fix close_range() for unshare+cloexec

 fs/file.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)
