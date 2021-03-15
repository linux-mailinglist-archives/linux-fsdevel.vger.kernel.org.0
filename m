Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF8133B225
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 13:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCOMIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 08:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230092AbhCOMH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615810076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMY/gt5XSciN6cQxAWuIihEs18mKZz1X5H8/RDx4gWM=;
        b=HgmQ8CUk2HLG+++tkakaRvyhvUDRueQTL6HFrc+1hQ7zRIXVKht9q2dLyJ5Oj/JZhw0Nmj
        Pc8CUZROw6AOGS1rwdl7r0DZKLx0uXNaMh3BHCqlhJFbN4tVuQNnd4f9NDqOmf6jtAYYfa
        yCEiYAbYtHhDn+4Gy0W4WM7sbZ2kTCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-ZF6FC_whPi2H-3mRCduqRw-1; Mon, 15 Mar 2021 08:07:52 -0400
X-MC-Unique: ZF6FC_whPi2H-3mRCduqRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12F3993920;
        Mon, 15 Mar 2021 12:07:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7C9710190A7;
        Mon, 15 Mar 2021 12:07:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/3] vfs: Use an xarray in the mount namespace to handle
 /proc/mounts list
From:   David Howells <dhowells@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 Mar 2021 12:07:47 +0000
Message-ID: <161581006790.2850696.15507933486273306779.stgit@warthog.procyon.org.uk>
In-Reply-To: <161581005972.2850696.12854461380574304411.stgit@warthog.procyon.org.uk>
References: <161581005972.2850696.12854461380574304411.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an xarray to the mount namespace and use this to perform a mnt_id to
mount object mapping for the namespace.  Make use of xa_reserve() to
perform preallocation before taking the mount_lock.

This will allow the set of mount objects in a namespace to be iterated
using xarray iteration and without the need to insert and remove fake
mounts as bookmarks - which cause issues for other trawlers of the list.

As a bonus, if we want to allow it, lseek() can be used to start at a
particular mount - though there's no easy way to limit the return to just a
single entry or enforce a failure if that mount doesn't exist, but a later
one does.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Matthew Wilcox <willy@infradead.org>
---

 fs/mount.h     |    2 +
 fs/namespace.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 0b6e08cf8afb..455f4d293a65 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -4,6 +4,7 @@
 #include <linux/poll.h>
 #include <linux/ns_common.h>
 #include <linux/fs_pin.h>
+#include <linux/xarray.h>
 
 struct mnt_namespace {
 	struct ns_common	ns;
@@ -14,6 +15,7 @@ struct mnt_namespace {
 	 * - taking namespace_sem for read AND taking .ns_lock.
 	 */
 	struct list_head	list;
+	struct xarray		mounts_by_id; /* List of mounts by mnt_id */
 	spinlock_t		ns_lock;
 	struct user_namespace	*user_ns;
 	struct ucounts		*ucounts;
diff --git a/fs/namespace.c b/fs/namespace.c
index 56bb5a5fdc0d..5c9bcaeac4de 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -901,6 +901,57 @@ void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct m
 	mnt_add_count(old_parent, -1);
 }
 
+/*
+ * Reserve slots in the mnt_id-to-mount mapping in a namespace.  This gets the
+ * memory allocation done upfront.
+ */
+static int reserve_mnt_id_one(struct mount *mnt, struct mnt_namespace *ns)
+{
+	struct mount *m;
+	int ret;
+
+	ret = xa_reserve(&ns->mounts_by_id, mnt->mnt_id, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	list_for_each_entry(m, &mnt->mnt_list, mnt_list) {
+		ret = xa_reserve(&ns->mounts_by_id, m->mnt_id, GFP_KERNEL);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int reserve_mnt_id_list(struct hlist_head *tree_list)
+{
+	struct mount *child;
+	int ret;
+
+	hlist_for_each_entry(child, tree_list, mnt_hash) {
+		ret = reserve_mnt_id_one(child, child->mnt_parent->mnt_ns);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+static void add_mnt_to_ns(struct mount *m, struct mnt_namespace *ns)
+{
+	void *x;
+
+	m->mnt_ns = ns;
+	x = xa_store(&ns->mounts_by_id, m->mnt_id, m, GFP_ATOMIC);
+	WARN(xa_err(x), "Couldn't store mnt_id %x\n", m->mnt_id);
+}
+
+static void remove_mnt_from_ns(struct mount *mnt)
+{
+	if (mnt->mnt_ns && mnt->mnt_ns != MNT_NS_INTERNAL)
+		xa_erase(&mnt->mnt_ns->mounts_by_id, mnt->mnt_id);
+	mnt->mnt_ns = NULL;
+}
+
 /*
  * vfsmount lock must be held for write
  */
@@ -914,8 +965,9 @@ static void commit_tree(struct mount *mnt)
 	BUG_ON(parent == mnt);
 
 	list_add_tail(&head, &mnt->mnt_list);
-	list_for_each_entry(m, &head, mnt_list)
-		m->mnt_ns = n;
+	list_for_each_entry(m, &head, mnt_list) {
+		add_mnt_to_ns(m, n);
+	}
 
 	list_splice(&head, n->list.prev);
 
@@ -1529,7 +1581,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 			ns->mounts--;
 			__touch_mnt_namespace(ns);
 		}
-		p->mnt_ns = NULL;
+		remove_mnt_from_ns(p);
 		if (how & UMOUNT_SYNC)
 			p->mnt.mnt_flags |= MNT_SYNC_UMOUNT;
 
@@ -2144,6 +2196,13 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		err = count_mounts(ns, source_mnt);
 		if (err)
 			goto out;
+
+		/* Reserve id-to-mount mapping slots in the namespace we're
+		 * going to use.
+		 */
+		err = reserve_mnt_id_one(source_mnt, dest_mnt->mnt_ns);
+		if (err)
+			goto out;
 	}
 
 	if (IS_MNT_SHARED(dest_mnt)) {
@@ -2151,6 +2210,8 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		if (err)
 			goto out;
 		err = propagate_mnt(dest_mnt, dest_mp, source_mnt, &tree_list);
+		if (!err && !moving)
+			err = reserve_mnt_id_list(&tree_list);
 		lock_mount_hash();
 		if (err)
 			goto out_cleanup_ids;
@@ -3260,6 +3321,7 @@ static void dec_mnt_namespaces(struct ucounts *ucounts)
 
 static void free_mnt_ns(struct mnt_namespace *ns)
 {
+	WARN_ON(!xa_empty(&ns->mounts_by_id));
 	if (!is_anon_ns(ns))
 		ns_free_inum(&ns->ns);
 	dec_mnt_namespaces(ns->ucounts);
@@ -3306,6 +3368,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 	INIT_LIST_HEAD(&new_ns->list);
 	init_waitqueue_head(&new_ns->poll);
 	spin_lock_init(&new_ns->ns_lock);
+	xa_init(&new_ns->mounts_by_id);
 	new_ns->user_ns = get_user_ns(user_ns);
 	new_ns->ucounts = ucounts;
 	return new_ns;
@@ -3362,7 +3425,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	p = old;
 	q = new;
 	while (p) {
-		q->mnt_ns = new_ns;
+		add_mnt_to_ns(q, new_ns);
 		new_ns->mounts++;
 		if (new_fs) {
 			if (&p->mnt == new_fs->root.mnt) {
@@ -3404,7 +3467,7 @@ struct dentry *mount_subtree(struct vfsmount *m, const char *name)
 		mntput(m);
 		return ERR_CAST(ns);
 	}
-	mnt->mnt_ns = ns;
+	add_mnt_to_ns(mnt, ns);
 	ns->root = mnt;
 	ns->mounts++;
 	list_add(&mnt->mnt_list, &ns->list);
@@ -3583,7 +3646,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 		goto err_path;
 	}
 	mnt = real_mount(newmount.mnt);
-	mnt->mnt_ns = ns;
+	add_mnt_to_ns(mnt, ns);
 	ns->root = mnt;
 	ns->mounts = 1;
 	list_add(&mnt->mnt_list, &ns->list);
@@ -4193,7 +4256,7 @@ static void __init init_mount_tree(void)
 	if (IS_ERR(ns))
 		panic("Can't allocate initial namespace");
 	m = real_mount(mnt);
-	m->mnt_ns = ns;
+	add_mnt_to_ns(m, ns);
 	ns->root = m;
 	ns->mounts = 1;
 	list_add(&m->mnt_list, &ns->list);
@@ -4270,7 +4333,7 @@ void kern_unmount(struct vfsmount *mnt)
 {
 	/* release long term mount so mount point can be released */
 	if (!IS_ERR_OR_NULL(mnt)) {
-		real_mount(mnt)->mnt_ns = NULL;
+		remove_mnt_from_ns(real_mount(mnt));
 		synchronize_rcu();	/* yecchhh... */
 		mntput(mnt);
 	}
@@ -4283,7 +4346,7 @@ void kern_unmount_array(struct vfsmount *mnt[], unsigned int num)
 
 	for (i = 0; i < num; i++)
 		if (mnt[i])
-			real_mount(mnt[i])->mnt_ns = NULL;
+			remove_mnt_from_ns(real_mount(mnt[i]));
 	synchronize_rcu_expedited();
 	for (i = 0; i < num; i++)
 		mntput(mnt[i]);


