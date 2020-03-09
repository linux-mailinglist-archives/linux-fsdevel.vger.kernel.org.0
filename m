Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92ED917E1F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 15:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCIOBp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 10:01:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47672 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726809AbgCIOBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583762503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vLc2aoxqR3+89WVhyY9y4RDzZzD5K/s0Bffdg5mmLyg=;
        b=MlmbwJBGA5DufpRXIIZ5YuypDWnMiFght/h5W6CK9LanThy9Rx7XrtRhU4edwvWSzRdYgF
        6OEMebe6JFLWi4cPXgMHLLJ9yww6OW8Zo3Hen2wjDdEoPIPUIalQdus8S0ceFwdANzckp1
        29bTmM6/3Az2HOV9rUSJ53N03vdz91U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-8c1ahr2RNsydi7NQny8S0g-1; Mon, 09 Mar 2020 10:01:42 -0400
X-MC-Unique: 8c1ahr2RNsydi7NQny8S0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FF798017CC;
        Mon,  9 Mar 2020 14:01:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C1985C1C3;
        Mon,  9 Mar 2020 14:01:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/14] fsinfo: Allow fsinfo() to look up a mount object by ID
 [ver #18]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 14:01:35 +0000
Message-ID: <158376249579.344135.17817110035727617263.stgit@warthog.procyon.org.uk>
In-Reply-To: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow the fsinfo() syscall to look up a mount object by ID rather than by
pathname.  This is necessary as there can be multiple mounts stacked up at
the same pathname and there's no way to look through them otherwise.

This is done by passing FSINFO_FLAGS_QUERY_MOUNT to fsinfo() in the
parameters and then passing the mount ID as a string to fsinfo() in place
of the filename:

	struct fsinfo_params params = {
		.flags	 = FSINFO_FLAGS_QUERY_MOUNT,
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

 fs/fsinfo.c                 |   53 +++++++++++++++++++
 fs/internal.h               |    1 
 fs/namespace.c              |  117 ++++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/fsinfo.h |    1 
 samples/vfs/test-fsinfo.c   |    7 ++-
 5 files changed, 175 insertions(+), 4 deletions(-)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index 9562bce5253c..bafeb73feaf4 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -547,6 +547,56 @@ static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_context *ctx)
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
+			    struct fsinfo_context *ctx)
+{
+	struct path path;
+	struct fd f = {};
+	char *name;
+	long mnt_id;
+	int ret;
+
+	if (!filename)
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
+	ret = vfs_fsinfo(&path, ctx);
+	path_put(&path);
+out_fd:
+	fdput(f);
+out_name:
+	kfree(name);
+	return ret;
+}
+
 /**
  * sys_fsinfo - System call to get filesystem information
  * @dfd: Base directory to pathwalk from or fd referring to filesystem.
@@ -620,6 +670,9 @@ SYSCALL_DEFINE6(fsinfo,
 			return -EINVAL;
 		ret = vfs_fsinfo_fd(dfd, &ctx);
 		break;
+	case FSINFO_FLAGS_QUERY_MOUNT:
+		ret = vfs_fsinfo_mount(dfd, pathname, &ctx);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/fs/internal.h b/fs/internal.h
index 6f2cc77bf38d..abbd5299e7dc 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -91,6 +91,7 @@ extern int __mnt_want_write_file(struct file *);
 extern void __mnt_drop_write_file(struct file *);
 
 extern void dissolve_on_fput(struct vfsmount *);
+extern int lookup_mount_object(struct path *, int, struct path *);
 extern int fsinfo_generic_mount_source(struct path *, struct fsinfo_context *);
 
 /*
diff --git a/fs/namespace.c b/fs/namespace.c
index e26e06447993..f33cec5fe885 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -64,7 +64,7 @@ static int __init set_mphash_entries(char *str)
 __setup("mphash_entries=", set_mphash_entries);
 
 static u64 event;
-static DEFINE_IDA(mnt_id_ida);
+static DEFINE_IDR(mnt_id_ida);
 static DEFINE_IDA(mnt_group_ida);
 
 static struct hlist_head *mount_hashtable __read_mostly;
@@ -105,17 +105,27 @@ static inline struct hlist_head *mp_hash(struct dentry *dentry)
 
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
@@ -959,6 +969,7 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
 	lock_mount_hash();
 	list_add_tail(&mnt->mnt_instance, &mnt->mnt.mnt_sb->s_mounts);
 	unlock_mount_hash();
+	mnt_publish_id(mnt);
 	return &mnt->mnt;
 }
 EXPORT_SYMBOL(vfs_create_mount);
@@ -1052,6 +1063,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	lock_mount_hash();
 	list_add_tail(&mnt->mnt_instance, &sb->s_mounts);
 	unlock_mount_hash();
+	mnt_publish_id(mnt);
 
 	if ((flag & CL_SLAVE) ||
 	    ((flag & CL_SHARED_TO_SLAVE) && IS_MNT_SHARED(old))) {
@@ -4035,4 +4047,103 @@ int fsinfo_generic_mount_source(struct path *path, struct fsinfo_context *ctx)
 	return m.count;
 }
 
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
+
 #endif /* CONFIG_FSINFO */
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 253b5213a775..491a59e8cc95 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -42,6 +42,7 @@ struct fsinfo_params {
 #define FSINFO_FLAGS_QUERY_MASK	0x0007 /* What object should fsinfo() query? */
 #define FSINFO_FLAGS_QUERY_PATH	0x0000 /* - path, specified by dirfd,pathname,AT_EMPTY_PATH */
 #define FSINFO_FLAGS_QUERY_FD	0x0001 /* - fd specified by dirfd */
+#define FSINFO_FLAGS_QUERY_MOUNT 0x0002	/* - mount object (path=>mount_id, dirfd=>subtree) */
 	__u32	resolve_flags;	/* RESOLVE_* flags */
 	__u32	request;	/* ID of requested attribute */
 	__u32	Nth;		/* Instance of it (some may have multiple) */
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 1002b718cdbc..c407bda4134f 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -579,7 +579,7 @@ int main(int argc, char **argv)
 	bool meta = false;
 	int raw = 0, opt, Nth, Mth;
 
-	while ((opt = getopt(argc, argv, "Madlr"))) {
+	while ((opt = getopt(argc, argv, "Madmlr"))) {
 		switch (opt) {
 		case 'M':
 			meta = true;
@@ -595,6 +595,10 @@ int main(int argc, char **argv)
 			params.resolve_flags &= ~RESOLVE_NO_TRAILING_SYMLINKS;
 			params.flags = FSINFO_FLAGS_QUERY_PATH;
 			continue;
+		case 'm':
+			params.resolve_flags = 0;
+			params.flags = FSINFO_FLAGS_QUERY_MOUNT;
+			continue;
 		case 'r':
 			raw = 1;
 			continue;
@@ -607,6 +611,7 @@ int main(int argc, char **argv)
 
 	if (argc != 1) {
 		printf("Format: test-fsinfo [-Madlr] <path>\n");
+		printf("Format: test-fsinfo [-Mdr] -m <mnt_id>\n");
 		exit(2);
 	}
 


