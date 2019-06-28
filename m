Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B81659F56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfF1PrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:47:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfF1PrK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:47:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A8E88CB51;
        Fri, 28 Jun 2019 15:47:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FC0A60BE0;
        Fri, 28 Jun 2019 15:47:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/6] vfs: Allow fsinfo() to look up a mount object by ID
 [ver #15]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:47:07 +0100
Message-ID: <156173682756.14728.4150013552549151751.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173681842.14728.9331700785061885270.stgit@warthog.procyon.org.uk>
References: <156173681842.14728.9331700785061885270.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 28 Jun 2019 15:47:10 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow the fsinfo() syscall to look up a mount object by ID rather than by
pathname.  This is necessary as there can be multiple mounts stacked up at
the same pathname and there's no way to look through them otherwise.

This is done by passing AT_FSINFO_MOUNTID_PATH to fsinfo() in the
parameters and then passing the mount ID as a string to fsinfo() in place
of the filename:

	struct fsinfo_params params = {
		.at_flags = AT_FSINFO_MOUNTID_PATH,
		.request = FSINFO_ATTR_IDS,
	};

	ret = fsinfo(AT_FDCWD, "21", &params, buffer, sizeof(buffer));

The caller is only permitted to query a mount object if the root directory
of that mount connects directly to the current chroot if dfd == AT_FDCWD[*]
or the directory specified by dfd otherwise.  Note that this is not
available to the pathwalk of any other syscall.

[*] This needs to be something other than AT_FDCWD, perhaps AT_FDROOT.

[!] This probably needs an LSM hook.

[!] This might want to check the permissions on all the intervening dirs -
    but it would have to do that under RCU conditions.

[!] This might want to check a CAP_* flag.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsinfo.c                |   56 +++++++++++++++++++++
 fs/internal.h              |    2 +
 fs/namespace.c             |  117 +++++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/fcntl.h |    1 
 4 files changed, 173 insertions(+), 3 deletions(-)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index b3f605c39eb5..4eaa33b2188b 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -522,6 +522,57 @@ static int vfs_fsinfo_fscontext(int fd, struct fsinfo_kparams *params)
 	return ret;
 }
 
+/*
+ * Look up the root of a mount object.  This allows access to mount objects
+ * (and their attached superblocks) that can't be retrieved by path because
+ * they're entirely covered.
+ *
+ * We only permit access to a mount that has a direct path between either the
+ * dentry pointed to by dfd or to our chroot (if dfd is AT_FDCWD).
+ */
+static int vfs_fsinfo_mount(int dfd, const char __user *filename,
+			    struct fsinfo_kparams *params)
+{
+	struct path path;
+	struct fd f = {};
+	char *name;
+	long mnt_id;
+	int ret;
+
+	if ((params->at_flags & ~AT_FSINFO_MOUNTID_PATH) ||
+	    !filename)
+		return -EINVAL;
+
+	name = strndup_user(filename, 32);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+	ret = kstrtoul(name, 0, &mnt_id);
+	if (ret < 0)
+		goto out_name;
+	if (mnt_id > INT_MAX)
+		goto out_name;
+
+	if (dfd != AT_FDCWD) {
+		ret = -EBADF;
+		f = fdget_raw(dfd);
+		if (!f.file)
+			goto out_name;
+	}
+
+	ret = lookup_mount_object(f.file ? &f.file->f_path : NULL,
+				  mnt_id, &path);
+	if (ret < 0)
+		goto out_fd;
+
+	ret = vfs_fsinfo(&path, params);
+	path_put(&path);
+out_fd:
+	fdput(f);
+out_name:
+	kfree(name);
+	return ret;
+}
+
 /*
  * Return buffer information by requestable attribute.
  *
@@ -638,6 +689,9 @@ SYSCALL_DEFINE5(fsinfo,
 
 		if ((kparams.at_flags & AT_FSINFO_FROM_FSOPEN) && pathname)
 			return -EINVAL;
+		if ((kparams.at_flags & (AT_FSINFO_FROM_FSOPEN | AT_FSINFO_MOUNTID_PATH)) ==
+		    (AT_FSINFO_FROM_FSOPEN | AT_FSINFO_MOUNTID_PATH))
+			return -EINVAL;
 	} else {
 		kparams.request = FSINFO_ATTR_STATFS;
 	}
@@ -696,6 +750,8 @@ SYSCALL_DEFINE5(fsinfo,
 
 	if (kparams.at_flags & AT_FSINFO_FROM_FSOPEN)
 		ret = vfs_fsinfo_fscontext(dfd, &kparams);
+	else if (kparams.at_flags & AT_FSINFO_MOUNTID_PATH)
+		ret = vfs_fsinfo_mount(dfd, pathname, &kparams);
 	else if (pathname)
 		ret = vfs_fsinfo_path(dfd, pathname, &kparams);
 	else
diff --git a/fs/internal.h b/fs/internal.h
index 0010889f2e85..d5283a55b25d 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -96,6 +96,8 @@ extern int __mnt_want_write_file(struct file *);
 extern void __mnt_drop_write_file(struct file *);
 
 extern void dissolve_on_fput(struct vfsmount *);
+extern int lookup_mount_object(struct path *, int, struct path *);
+
 /*
  * fs_struct.c
  */
diff --git a/fs/namespace.c b/fs/namespace.c
index ffb13f0562b0..d96bc1dfab03 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -62,7 +62,7 @@ static int __init set_mphash_entries(char *str)
 __setup("mphash_entries=", set_mphash_entries);
 
 static u64 event;
-static DEFINE_IDA(mnt_id_ida);
+static DEFINE_IDR(mnt_id_ida);
 static DEFINE_IDA(mnt_group_ida);
 
 static struct hlist_head *mount_hashtable __read_mostly;
@@ -101,17 +101,27 @@ static inline struct hlist_head *mp_hash(struct dentry *dentry)
 
 static int mnt_alloc_id(struct mount *mnt)
 {
-	int res = ida_alloc(&mnt_id_ida, GFP_KERNEL);
+	int res;
 
+	/* Allocate an ID, but don't set the pointer back to the mount until
+	 * later, as once we do that, we have to follow RCU protocols to get
+	 * rid of the mount struct.
+	 */
+	res = idr_alloc(&mnt_id_ida, NULL, 0, INT_MAX, GFP_KERNEL);
 	if (res < 0)
 		return res;
 	mnt->mnt_id = res;
 	return 0;
 }
 
+static void mnt_publish_id(struct mount *mnt)
+{
+	idr_replace(&mnt_id_ida, mnt, mnt->mnt_id);
+}
+
 static void mnt_free_id(struct mount *mnt)
 {
-	ida_free(&mnt_id_ida, mnt->mnt_id);
+	idr_remove(&mnt_id_ida, mnt->mnt_id);
 }
 
 /*
@@ -974,6 +984,7 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
 	lock_mount_hash();
 	list_add_tail(&mnt->mnt_instance, &mnt->mnt.mnt_sb->s_mounts);
 	unlock_mount_hash();
+	mnt_publish_id(mnt);
 	return &mnt->mnt;
 }
 EXPORT_SYMBOL(vfs_create_mount);
@@ -1067,6 +1078,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	lock_mount_hash();
 	list_add_tail(&mnt->mnt_instance, &sb->s_mounts);
 	unlock_mount_hash();
+	mnt_publish_id(mnt);
 
 	if ((flag & CL_SLAVE) ||
 	    ((flag & CL_SHARED_TO_SLAVE) && IS_MNT_SHARED(old))) {
@@ -3986,3 +3998,102 @@ const struct proc_ns_operations mntns_operations = {
 	.install	= mntns_install,
 	.owner		= mntns_owner,
 };
+
+/*
+ * See if one path point connects directly to another by ancestral relationship
+ * across mountpoints.  Must call with the RCU read lock held.
+ */
+static bool are_paths_connected(struct path *ancestor, struct path *to_check)
+{
+	struct mount *mnt, *parent;
+	struct path cursor;
+	unsigned seq;
+	bool connected;
+
+	seq = 0;
+restart:
+	cursor = *to_check;
+
+	read_seqbegin_or_lock(&rename_lock, &seq);
+	while (cursor.mnt != ancestor->mnt) {
+		mnt = real_mount(cursor.mnt);
+		parent = READ_ONCE(mnt->mnt_parent);
+		if (mnt == parent)
+			goto failed;
+		cursor.dentry = READ_ONCE(mnt->mnt_mountpoint);
+		cursor.mnt = &parent->mnt;
+	}
+
+	while (cursor.dentry != ancestor->dentry) {
+		if (cursor.dentry == cursor.mnt->mnt_root ||
+		    IS_ROOT(cursor.dentry))
+			goto failed;
+		cursor.dentry = READ_ONCE(cursor.dentry->d_parent);
+	}
+
+	connected = true;
+out:
+	done_seqretry(&rename_lock, seq);
+	return connected;
+
+failed:
+	if (need_seqretry(&rename_lock, seq)) {
+		seq = 1;
+		goto restart;
+	}
+	connected = false;
+	goto out;
+}
+
+/**
+ * lookup_mount_object - Look up a vfsmount object by ID
+ * @root: The mount root must connect backwards to this point (or chroot if NULL).
+ * @id: The ID of the mountpoint.
+ * @_mntpt: Where to return the resulting mountpoint path.
+ *
+ * Look up the root of the mount with the corresponding ID.  This is only
+ * permitted if that mount connects directly to the specified root/chroot.
+ */
+int lookup_mount_object(struct path *root, int mnt_id, struct path *_mntpt)
+{
+	struct mount *mnt;
+	struct path stop, mntpt = {};
+	int ret = -EPERM;
+
+	if (!root)
+		get_fs_root(current->fs, &stop);
+	else
+		stop = *root;
+
+	rcu_read_lock();
+	lock_mount_hash();
+	mnt = idr_find(&mnt_id_ida, mnt_id);
+	if (!mnt)
+		goto out_unlock_mh;
+	if (mnt->mnt.mnt_flags & (MNT_SYNC_UMOUNT | MNT_UMOUNT | MNT_DOOMED))
+		goto out_unlock_mh;
+	if (mnt_get_count(mnt) == 0)
+		goto out_unlock_mh;
+	mnt_add_count(mnt, 1);
+	mntpt.mnt = &mnt->mnt;
+	mntpt.dentry = dget(mnt->mnt.mnt_root);
+	unlock_mount_hash();
+
+	if (are_paths_connected(&stop, &mntpt)) {
+		*_mntpt = mntpt;
+		mntpt.mnt = NULL;
+		mntpt.dentry = NULL;
+		ret = 0;
+	}
+
+out_unlock:
+	rcu_read_unlock();
+	if (!root)
+		path_put(&stop);
+	path_put(&mntpt);
+	return ret;
+
+out_unlock_mh:
+	unlock_mount_hash();
+	goto out_unlock;
+}
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 6a2402a8fa30..5fda91cfca8a 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -92,6 +92,7 @@
 #define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
 
 #define AT_FSINFO_FROM_FSOPEN	0x2000	/* Examine the fs_context attached to dfd by fsopen() */
+#define AT_FSINFO_MOUNTID_PATH	0x4000	/* The path is a mount object ID, not an actual path */
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 

