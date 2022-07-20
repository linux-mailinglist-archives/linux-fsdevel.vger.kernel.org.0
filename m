Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F38057AD61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 03:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbiGTBuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 21:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiGTBuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:50:21 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23631CFD9;
        Tue, 19 Jul 2022 18:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7FjBcFGldG0YBrtr6pP8qxoNayWyHLg/2ZOZfzNe1vM=; b=Z8J2FPRSIu2ZkJ3bNZIxtTXfc8
        5343i6Kqf8FrrhZ4ueNRdNOB6Dgp/JZUsbQHLYgsEBD/aplSrO9pwlxn8jp3MwNaDSijZt50DpGER
        S/860fU0jef3MJa8mEh/nGyH8Xipg3y5+MyIvr1d15RSjMPK72JCjyiIHedZ7eu8+9EdMUMc15POs
        nNx75FgMQjmC23V6nFUn8zORg5GJvURpOptXFP9akmHYt1UIYzJVTRMtjjNWF5r/UpEXNCn0GSVrR
        C+XOXFgHBTO11F/w1BMDf7YiSGukVDZlEygr7qaY6iBBpqgoCxNZhuB5L1/as+F+JVmmL0O7a+a/D
        0MZONUFg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oDyqp-00DwfF-0O;
        Wed, 20 Jul 2022 01:50:11 +0000
Date:   Wed, 20 Jul 2022 02:50:10 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] vfs: track count of child mounts
Message-ID: <YtdfUlO1puevbtfi@ZenIV>
References: <165751053430.210556.5634228273667507299.stgit@donald.themaw.net>
 <165751066075.210556.17270883735094115327.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165751066075.210556.17270883735094115327.stgit@donald.themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 11, 2022 at 11:37:40AM +0800, Ian Kent wrote:
> While the total reference count of a mount is mostly all that's needed
> the reference count corresponding to the mounts only is occassionally
> also needed (for example, autofs checking if a tree of mounts can be
> expired).
> 
> To make this reference count avaialble with minimal changes add a
> counter to track the number of child mounts under a given mount. This
> count can then be used to calculate the mounts only reference count.

No.  This is a wrong approach - instead of keeping track of number of
children, we should just stop having them contribute to refcount of
the parent.  Here's what I've got in my local tree; life gets simpler
that way.

commit e99f1f9cc864103f326a5352e6ce1e377613437f
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Jul 9 14:45:39 2022 -0400

    namespace: don't keep ->mnt_parent pinned
    
    makes refcounting more consistent
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/namespace.c b/fs/namespace.c
index 68789f896f08..53c29110a0cd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -906,7 +906,6 @@ void mnt_set_mountpoint(struct mount *mnt,
 			struct mount *child_mnt)
 {
 	mp->m_count++;
-	mnt_add_count(mnt, 1);	/* essentially, that's mntget */
 	child_mnt->mnt_mountpoint = mp->m_dentry;
 	child_mnt->mnt_parent = mnt;
 	child_mnt->mnt_mp = mp;
@@ -1429,22 +1428,18 @@ void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor)
 int may_umount_tree(struct vfsmount *m)
 {
 	struct mount *mnt = real_mount(m);
-	int actual_refs = 0;
-	int minimum_refs = 0;
-	struct mount *p;
 	BUG_ON(!m);
 
 	/* write lock needed for mnt_get_count */
 	lock_mount_hash();
-	for (p = mnt; p; p = next_mnt(p, mnt)) {
-		actual_refs += mnt_get_count(p);
-		minimum_refs += 2;
+	for (struct mount *p = mnt; p; p = next_mnt(p, mnt)) {
+		int allowed = p == mnt ? 2 : 1;
+		if (mnt_get_count(p) > allowed) {
+			unlock_mount_hash();
+			return 0;
+		}
 	}
 	unlock_mount_hash();
-
-	if (actual_refs > minimum_refs)
-		return 0;
-
 	return 1;
 }
 
@@ -1586,7 +1581,6 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 
 		disconnect = disconnect_mount(p, how);
 		if (mnt_has_parent(p)) {
-			mnt_add_count(p->mnt_parent, -1);
 			if (!disconnect) {
 				/* Don't forget about p */
 				list_add_tail(&p->mnt_child, &p->mnt_parent->mnt_mounts);
@@ -2892,12 +2886,8 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 		put_mountpoint(old_mp);
 out:
 	unlock_mount(mp);
-	if (!err) {
-		if (attached)
-			mntput_no_expire(parent);
-		else
-			free_mnt_ns(ns);
-	}
+	if (!err && !attached)
+		free_mnt_ns(ns);
 	return err;
 }
 
@@ -3869,7 +3859,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 		const char __user *, put_old)
 {
 	struct path new, old, root;
-	struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent, *ex_parent;
+	struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent;
 	struct mountpoint *old_mp, *root_mp;
 	int error;
 
@@ -3900,10 +3890,9 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	new_mnt = real_mount(new.mnt);
 	root_mnt = real_mount(root.mnt);
 	old_mnt = real_mount(old.mnt);
-	ex_parent = new_mnt->mnt_parent;
 	root_parent = root_mnt->mnt_parent;
 	if (IS_MNT_SHARED(old_mnt) ||
-		IS_MNT_SHARED(ex_parent) ||
+		IS_MNT_SHARED(new_mnt->mnt_parent) ||
 		IS_MNT_SHARED(root_parent))
 		goto out4;
 	if (!check_mnt(root_mnt) || !check_mnt(new_mnt))
@@ -3942,7 +3931,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	attach_mnt(root_mnt, old_mnt, old_mp);
 	/* mount new_root on / */
 	attach_mnt(new_mnt, root_parent, root_mp);
-	mnt_add_count(root_parent, -1);
 	touch_mnt_namespace(current->nsproxy->mnt_ns);
 	/* A moved mount should not expire automatically */
 	list_del_init(&new_mnt->mnt_expire);
@@ -3952,8 +3940,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	error = 0;
 out4:
 	unlock_mount(old_mp);
-	if (!error)
-		mntput_no_expire(ex_parent);
 out3:
 	path_put(&root);
 out2:
diff --git a/fs/pnode.c b/fs/pnode.c
index 1106137c747a..e2c8a4b18857 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -368,7 +368,7 @@ static inline int do_refcount_check(struct mount *mnt, int count)
  */
 int propagate_mount_busy(struct mount *mnt, int refcnt)
 {
-	struct mount *m, *child, *topper;
+	struct mount *m, *child;
 	struct mount *parent = mnt->mnt_parent;
 
 	if (mnt == parent)
@@ -384,7 +384,6 @@ int propagate_mount_busy(struct mount *mnt, int refcnt)
 
 	for (m = propagation_next(parent, parent); m;
 	     		m = propagation_next(m, parent)) {
-		int count = 1;
 		child = __lookup_mnt(&m->mnt, mnt->mnt_mountpoint);
 		if (!child)
 			continue;
@@ -392,13 +391,10 @@ int propagate_mount_busy(struct mount *mnt, int refcnt)
 		/* Is there exactly one mount on the child that covers
 		 * it completely whose reference should be ignored?
 		 */
-		topper = find_topper(child);
-		if (topper)
-			count += 1;
-		else if (!list_empty(&child->mnt_mounts))
+		if (!find_topper(child) && !list_empty(&child->mnt_mounts))
 			continue;
 
-		if (do_refcount_check(child, count))
+		if (do_refcount_check(child, 1))
 			return 1;
 	}
 	return 0;
