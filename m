Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D724BD412
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 04:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbiBUDDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 22:03:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241723AbiBUDDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:03:00 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BFAE32
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Feb 2022 19:02:37 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLyyC-003TZN-00; Mon, 21 Feb 2022 03:02:36 +0000
Date:   Mon, 21 Feb 2022 03:02:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC] umount/__detach_mounts() race
Message-ID: <YhMAy1WseafC+uIv@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	umount_tree() is very definitely not supposed to be called
on MNT_UMOUNT subtrees (== stuck-together fragments that got
unmounted, but not split into individual mount nodes).  Refcounting
rules are different there and umount_tree() assumes that we start with
the normal ones.

	do_umount() appears to be checking for that:

	if (flags & MNT_DETACH) {
		if (!list_empty(&mnt->mnt_list))
			umount_tree(mnt, UMOUNT_PROPAGATE);
		retval = 0;
	} else {
		shrink_submounts(mnt);
		retval = -EBUSY;
		if (!propagate_mount_busy(mnt, 2)) {
			if (!list_empty(&mnt->mnt_list))
				umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
			retval = 0;
		}
	}

which would prevent umount_tree() on those - mnt_list eviction happens
for the same nodes that get MNT_UMOUNT.  However, shrink_submounts()
will call umount_tree() for e.g. nfs automounts it finds on victim
mount, and if ours happens to be already unmounted, with automounts
stuck to it, we have trouble.

It looks like something that should be impossible to hit, but...

A: umount(2) looks the sucker up
B: rmdir(2) in another namespace (where nothing is mounted on that mountpoint)
does __detach_mounts(), which grabs namespace_sem, sees the mount A is about
to try and kill and calls umount_tree(mnt, UMOUNT_CONNECTED).  Which detaches
our mount (and its children, automounts included) from the namespace it's in,
modifies their refcounts accordingly and keeps the entire thing in one
piece.
A: in do_umount() blocks on namespace_sem
B: drops namespace_sem
A: gets to the quoted code.  mnt is already MNT_UMOUNT (and has empty
->mnt_list), but it does have (equally MNT_UMOUNT) automounts under it,
etc.  So shrink_submounts() finds something to umount and calls umount_tree().
Buggered refcounts happen.

Does anybody see a problem with the following patch?

diff --git a/fs/namespace.c b/fs/namespace.c
index 42d4fc21263b2..1604b9d7a69d9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1654,21 +1654,20 @@ static int do_umount(struct mount *mnt, int flags)
 	lock_mount_hash();
 
 	/* Recheck MNT_LOCKED with the locks held */
+	/* ... and don't go there if we'd raced and it's already unmounted */
 	retval = -EINVAL;
-	if (mnt->mnt.mnt_flags & MNT_LOCKED)
+	if (mnt->mnt.mnt_flags & (MNT_LOCKED|MNT_UMOUNT))
 		goto out;
 
 	event++;
 	if (flags & MNT_DETACH) {
-		if (!list_empty(&mnt->mnt_list))
-			umount_tree(mnt, UMOUNT_PROPAGATE);
+		umount_tree(mnt, UMOUNT_PROPAGATE);
 		retval = 0;
 	} else {
 		shrink_submounts(mnt);
 		retval = -EBUSY;
 		if (!propagate_mount_busy(mnt, 2)) {
-			if (!list_empty(&mnt->mnt_list))
-				umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
+			umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
 			retval = 0;
 		}
 	}
