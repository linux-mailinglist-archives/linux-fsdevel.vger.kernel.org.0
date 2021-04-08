Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FB8357A0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 04:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhDHCIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 22:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhDHCIV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 22:08:21 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68857C061760;
        Wed,  7 Apr 2021 19:08:11 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUK4z-003Xtw-SQ; Thu, 08 Apr 2021 02:07:33 +0000
Date:   Thu, 8 Apr 2021 02:07:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] breakage in LOOKUP_MOUNTPOINT handling
Message-ID: <YG5lZcubiudwsz4I@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Brown paperbag time: dumb braino in the series that went into
5.7 broke the "don't step into ->d_weak_revalidate() when umount(2)
looks the victim up" behaviour.  Spotted only now - saw
	if (!err && unlikely(nd->flags & LOOKUP_MOUNTPOINT)) {
		err = handle_lookup_down(nd);
		nd->flags &= ~LOOKUP_JUMPED; // no d_weak_revalidate(), please...
	}
went "why do we clear that flag here - nothing below that point is going
to check it anyway" / "wait a minute, what is it doing *after* complete_walk()
(which is where we check that flag and call ->d_weak_revalidate())" / "how could
that possibly _not_ break?", followed by reproducing the breakage and verifying
that the obvious fix of that braino does, indeed, fix it.

FWIW, reproducer is (assuming that $DIR exists and is exported r/w to localhost)
mkdir $DIR/a
mkdir /tmp/foo
mount --bind /tmp/foo /tmp/foo
mkdir /tmp/foo/a
mkdir /tmp/foo/b
mount -t nfs4 localhost:$DIR/a /tmp/foo/a
mount -t nfs4 localhost:$DIR /tmp/foo/b
rmdir /tmp/foo/b/a
umount /tmp/foo/b
umount /tmp/foo/a
umount -l /tmp/foo	# will get everything under /tmp/foo, no matter what

Correct behaviour is successful umount; broken kernels (5.7-rc1 and later) get
umount.nfs4: /tmp/foo/a: Stale file handle
Note that bind mount is there to be able to recover - on broken kernels we'd
get stuck with impossible-to-umount filesystem if not for that.

	FWIW, that braino had been posted for review back then, at least
twice.  Unfortunately, the call of complete_walk() was outside of diff
context, so the bogosity hadn't been immediately obvious from the patch
alone ;-/

The following changes since commit 7d01ef7585c07afaf487759a48486228cd065726:

  Make sure nd->path.mnt and nd->path.dentry are always valid pointers (2021-04-06 12:33:07 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 4f0ed93fb92d3528c73c80317509df3f800a222b:

  LOOKUP_MOUNTPOINT: we are cleaning "jumped" flag too late (2021-04-06 20:33:00 -0400)

----------------------------------------------------------------
Al Viro (1):
      LOOKUP_MOUNTPOINT: we are cleaning "jumped" flag too late

 fs/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
