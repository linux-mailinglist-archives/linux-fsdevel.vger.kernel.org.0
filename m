Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5733FC561
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 12:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbhHaKDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 06:03:39 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:53018
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240802AbhHaKDj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:03:39 -0400
Received: from wittgenstein.fritz.box (i577BC18B.versanet.de [87.123.193.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 997E13F355;
        Tue, 31 Aug 2021 10:02:42 +0000 (UTC)
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] close_range updates
Date:   Tue, 31 Aug 2021 12:02:39 +0200
Message-Id: <20210831100239.2297934-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

/* Summary */
This is a cleanup for close_range() which was sent as part of a bugfix we did
some time ago in 9b5b872215fe ("file: fix close_range() for unshare+cloexec").
We used to share more code between some helpers for close_range() which made
retrieving the maximum number of open fds before calling into the helpers
sensible. But with the introduction of CLOSE_RANGE_CLOEXEC and the need to
retrieve the number of maximum fds once more for CLOSE_RANGE_CLOEXEC that
stopped making sense. So the code was in a dumb in-limbo state. Fix this by
simplifying the code a bit.

The bugfix itself in 9b5b872215fe ("file: fix close_range() for
unshare+cloexec") was either applied directly by you or I sent it as a separate
PR. In any case, the idea was to only fix the bug itself and make backporting
easy. And since the cleanup wasn't very pressing I left it in linux-next for a
very long time. Note, I didn't pull the patches from the list again back then
which is why they don't have lore-links. I'm listing them here explicitly
though:
03ba0fe4d09f ("file: simplify logic in __close_range()")
Link: https://lore.kernel.org/linux-fsdevel/20210402123548.108372-3-brauner@kernel.org

f49fd6d3c070 ("file: let pick_file() tell caller it's done")
Link: https://lore.kernel.org/linux-fsdevel/20210402123548.108372-4-brauner@kernel.org

/* Testing */
All patches have been in linux-next since 5.12-rc4. No build failures or
warnings were observed. All old and new tests are passing.

(In case any question come up I'll be on vacation next week so responding might
 take a while.)

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with current
mainline.

The following changes since commit 9b5b872215fe6d1ca6a1ef411f130bd58e269012:

  file: fix close_range() for unshare+cloexec (2021-04-02 14:11:10 +0200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.close_range.v5.15

for you to fetch changes up to 03ba0fe4d09f2eb0a91888caaa057ed67462ae2d:

  file: simplify logic in __close_range() (2021-04-02 14:11:10 +0200)

Please consider pulling these changes from the signed fs.close_range.v5.15 tag.

Thanks!
Christian

----------------------------------------------------------------
fs.close_range.v5.15

----------------------------------------------------------------
Christian Brauner (2):
      file: let pick_file() tell caller it's done
      file: simplify logic in __close_range()

 fs/file.c | 64 +++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 24 deletions(-)
