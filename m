Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40FA31C09D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 18:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhBOR3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 12:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbhBOR2L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 12:28:11 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B282C061574;
        Mon, 15 Feb 2021 09:19:29 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBhWs-00EJN2-TZ; Mon, 15 Feb 2021 17:19:23 +0000
Date:   Mon, 15 Feb 2021 17:19:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [git pull] namei stuff
Message-ID: <YCqtGm78miQQVJ7n@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Most of that pile is LOOKUP_CACHED series; the rest is a couple of
misc cleanups in the general area...

	There's a minor bisect hazard in the end of series, and normally
I would've just folded the fix into the previous commit, but this branch is
shared with Jens' tree, with stuff on top of it in there, so that would've
required rebases outside of vfs.git.

	NOTE: I'm less than thrilled by the "let's allow offloading pathwalks
to helper threads" push, but LOOKUP_CACHED is useful on its own.

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.namei

for you to fetch changes up to 1bef30105aefa3aaa7fb0de046c35d37ad5201aa:

  fix handling of nd->depth on LOOKUP_CACHED failures in try_to_unlazy* (2021-02-15 12:11:40 -0500)

----------------------------------------------------------------
Al Viro (3):
      do_tmpfile(): don't mess with finish_open()
      saner calling conventions for unlazy_child()
      fix handling of nd->depth on LOOKUP_CACHED failures in try_to_unlazy*

Jens Axboe (3):
      fs: make unlazy_walk() error handling consistent
      fs: add support for LOOKUP_CACHED
      fs: expose LOOKUP_CACHED through openat2() RESOLVE_CACHED

Steven Rostedt (VMware) (1):
      fs/namei.c: Remove unlikely of status being -ECHILD in lookup_fast()

 fs/namei.c                   | 88 ++++++++++++++++++++++----------------------
 fs/open.c                    |  6 +++
 include/linux/fcntl.h        |  2 +-
 include/linux/namei.h        |  1 +
 include/uapi/linux/openat2.h |  4 ++
 5 files changed, 55 insertions(+), 46 deletions(-)
