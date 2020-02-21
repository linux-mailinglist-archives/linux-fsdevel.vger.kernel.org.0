Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEFA21685EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgBUSDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:03:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38469 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727891AbgBUSDI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582308187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8hE7f5bpXUbOg4S9Js2bk8wnXI6wwlWkawXl8l+lKXo=;
        b=dN+lD21O3+etreT1+zx2E79irGRVXThagdE82uBGo8tOLugf4w/+aposwTgWuuLPe56leY
        llzvW5n9EtrX0r22X+z+Wke/IsqJpczHFSouQyKjGVxTH4lOmE3I4BtiRnarMwLnibJHan
        trT7cXNC4a/APxN8F/AIgQ/RjK3jMP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-1X5F1jzyOUuQEHuUr3v6Kw-1; Fri, 21 Feb 2020 13:03:04 -0500
X-MC-Unique: 1X5F1jzyOUuQEHuUr3v6Kw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6192A100550E;
        Fri, 21 Feb 2020 18:03:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BEBE5DA76;
        Fri, 21 Feb 2020 18:03:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/17] fsinfo: Allow fsinfo() to look up a mount object by ID
 [ver #17]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Feb 2020 18:03:00 +0000
Message-ID: <158230818093.2185128.14307281032993574387.stgit@warthog.procyon.org.uk>
In-Reply-To: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 fs/internal.h               |    2 +
 fs/namespace.c              |  117 ++++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/fsinfo.h |    1 
 samples/vfs/test-fsinfo.c   |   11 +++-
 5 files changed, 179 insertions(+), 5 deletions(-)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index f423a4c5afd9..9712d340dd7d 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -496,6 +496,56 @@ static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_context *ctx)
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
@@ -565,6 +615,9 @@ SYSCALL_DEFINE5(fsinfo,
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
index f3f280b952a3..2ccd2b2eae88 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -91,6 +91,8 @@ extern int __mnt_want_write_file(struct file *);
 extern void __mnt_drop_write_file(struct file *);
 
 extern void dissolve_on_fput(struct vfsmount *);
+extern int lookup_mount_object(struct path *, int, struct path *);
+
 /*
  * fs_struct.c
  */
diff --git a/fs/namespace.c b/fs/namespace.c
index 668f797ae3bd..696fcc5010ca 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -63,7 +63,7 @@ static int __init set_mphash_entries(char *str)
 __setup("mphash_entries=", set_mphash_entries);
 
 static u64 event;
-static DEFINE_IDA(mnt_id_ida);
+static DEFINE_IDR(mnt_id_ida);
 static DEFINE_IDA(mnt_group_ida);
 
 static struct hlist_head *mount_hashtable __read_mostly;
@@ -104,17 +104,27 @@ static inline struct hlist_head *mp_hash(struct dentry *dentry)
 
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
@@ -958,6 +968,7 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
 	lock_mount_hash();
 	list_add_tail(&mnt->mnt_instance, &mnt->mnt.mnt_sb->s_mounts);
 	unlock_mount_hash();
+	mnt_publish_id(mnt);
 	return &mnt->mnt;
 }
 EXPORT_SYMBOL(vfs_create_mount);
@@ -1051,6 +1062,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	lock_mount_hash();
 	list_add_tail(&mnt->mnt_instance, &sb->s_mounts);
 	unlock_mount_hash();
+	mnt_publish_id(mnt);
 
 	if ((flag & CL_SLAVE) ||
 	    ((flag & CL_SHARED_TO_SLAVE) && IS_MNT_SHARED(old))) {
@@ -3997,3 +4009,102 @@ const struct proc_ns_operations mntns_operations = {
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
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index d7f24da36f0e..3ce7810d96b4 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -39,6 +39,7 @@ struct fsinfo_params {
 #define FSINFO_FLAGS_QUERY_MASK	0x0007 /* What object should fsinfo() query? */
 #define FSINFO_FLAGS_QUERY_PATH	0x0000 /* - path, specified by dirfd,pathname,AT_EMPTY_PATH */
 #define FSINFO_FLAGS_QUERY_FD	0x0001 /* - fd specified by dirfd */
+#define FSINFO_FLAGS_QUERY_MOUNT 0x0002	/* - mount object (path=>mount_id, dirfd=>subtree) */
 	__u32	request;	/* ID of requested attribute */
 	__u32	Nth;		/* Instance of it (some may have multiple) */
 	__u32	Mth;		/* Subinstance of Nth instance */
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 7f49c2125ed3..546bf4f530d0 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -555,16 +555,22 @@ int main(int argc, char **argv)
 	bool meta = false;
 	int raw = 0, opt, Nth, Mth;
 
-	while ((opt = getopt(argc, argv, "adlmr"))) {
+	while ((opt = getopt(argc, argv, "Madlmr"))) {
 		switch (opt) {
+		case 'M':
+			params.at_flags = 0;
+			params.flags = FSINFO_FLAGS_QUERY_MOUNT;
+			continue;
 		case 'a':
 			params.at_flags |= AT_NO_AUTOMOUNT;
+			params.flags |= FSINFO_FLAGS_QUERY_PATH;
 			continue;
 		case 'd':
 			debug = true;
 			continue;
 		case 'l':
 			params.at_flags &= ~AT_SYMLINK_NOFOLLOW;
+			params.flags |= FSINFO_FLAGS_QUERY_PATH;
 			continue;
 		case 'm':
 			meta = true;
@@ -580,7 +586,8 @@ int main(int argc, char **argv)
 	argv += optind;
 
 	if (argc != 1) {
-		printf("Format: test-fsinfo [-alr] <file>\n");
+		printf("Format: test-fsinfo [-adlr] <file>\n");
+		printf("Format: test-fsinfo [-dr] -M <mnt_id>\n");
 		exit(2);
 	}
 


