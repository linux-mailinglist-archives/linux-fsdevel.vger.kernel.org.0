Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD466ED69
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2019 05:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfGTDCV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 23:02:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43768 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbfGTDCV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 23:02:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hofda-0003Ma-2g; Sat, 20 Jul 2019 03:02:18 +0000
Date:   Sat, 20 Jul 2019 04:02:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git - dcache and mountpoint stuff
Message-ID: <20190720030217.GC17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Saner handling of refcounts to mountpoints.
Transfer the counting reference from struct mount ->mnt_mountpoint
over to struct mountpoint ->m_dentry.  That allows to get rid of
the convoluted games with ordering of mount shutdowns.  The cost
is in teaching shrink_dcache_{parent,for_umount} to cope with
mixed-filesystem shrink lists, which we'll also need for the Slab
Movable Objects patchset.

	I'm not sure what's the best way to do that pull request;
there are two branches with identical (modulo one space in comment)
contents.  The former (#work.dcache) sat in -next; the latter (#work.dcache2)
has the last commit of the former split and folded.  Said last commit is
basically what you'd asked to change - comment for locking of ex_mountpoints,
separating the default variant of put_namespace() from "save to this
list" one, having the former explicitly pass &ex_mountpoints to the
latter, comment updates.

	Conservative approach would be to pull #work.dcache, but...
consider e.g. put_mountpoint() changes in work.dcache: in the middle of
the series we have
-static void put_mountpoint(struct mountpoint *mp)
+static void put_mountpoint(struct mountpoint *mp, struct list_head *list)
...
+               if (!list)
+                       list = &ex_mountpoints;
+               dput_to_list(dentry, list);
with corresponding callers' updates (all but one passing NULL).  In this
last commit it becomes
static void __put_mountpoint(struct mountpoint *mp, struct list_head *list)
with if (!list) part gone and
+static void put_mountpoint(struct mountpoint *mp)
+{
+       __put_mountpoint(mp, &ex_mountpoints);
+}
with callers reverted to the original state.  IOW, pointless noise.
And
-static LIST_HEAD(ex_mountpoints);
+static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
is better folded into the into the commit introducing the list.

	IOW, if you are OK with pulling #work.dcache2, it would, IMO, be
better.  Below is the pull request for it; the variant for #work.dcache
would differ in having 9 commits instead of 8.  Up to you...

The following changes since commit 570d7a98e7d6d5d8706d94ffd2d40adeaa318332:

  vfs: move_mount: reject moving kernel internal mounts (2019-07-01 10:46:36 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache2

for you to fetch changes up to 56cbb429d911991170fe867b4bba14f0efed5829:

  switch the remnants of releasing the mountpoint away from fs_pin (2019-07-16 22:52:37 -0400)

----------------------------------------------------------------
Al Viro (8):
      ceph: don't open-code the check for dead lockref
      nfs: dget_parent() never returns NULL
      __detach_mounts(): lookup_mountpoint() can't return ERR_PTR() anymore
      fs/namespace.c: shift put_mountpoint() to callers of unhash_mnt()
      Teach shrink_dcache_parent() to cope with mixed-filesystem shrink lists
      make struct mountpoint bear the dentry reference to mountpoint, not struct mount
      get rid of detach_mnt()
      switch the remnants of releasing the mountpoint away from fs_pin

 fs/ceph/dir.c          |   2 +-
 fs/dcache.c            | 100 +++++++++++++++++++++++++------
 fs/fs_pin.c            |  10 +---
 fs/internal.h          |   2 +
 fs/mount.h             |   8 ++-
 fs/namespace.c         | 159 ++++++++++++++++++++++++-------------------------
 fs/nfs/super.c         |   6 +-
 include/linux/fs_pin.h |   1 -
 8 files changed, 172 insertions(+), 116 deletions(-)
