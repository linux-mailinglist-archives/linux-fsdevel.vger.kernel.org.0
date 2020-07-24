Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D32E22C69A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 15:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGXNfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 09:35:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26670 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727048AbgGXNfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595597740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncsIlp1Vs+v3SHdnqvPuUM3faShUaRc/NSthJE3GNgM=;
        b=M0FgM3R8iZpSsh6PjXrxlFCsVCZYqtA226eo35YLWCbNzRT6V1XHle04R9I8kDNIB1sdbv
        0mFcR/oULFeVPRomGeTR3Ket1EiGJXhoCaxeSPNi9epwqmlehw7vqD/Hstq9KIXkxbwSxO
        Bx/hUIPr/dM8Bv39uzenCrdDQ5atJug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-EbBPgR7UOqOY5C-r4CXn8Q-1; Fri, 24 Jul 2020 09:35:36 -0400
X-MC-Unique: EbBPgR7UOqOY5C-r4CXn8Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A0D480183C;
        Fri, 24 Jul 2020 13:35:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7EFF183AB;
        Fri, 24 Jul 2020 13:35:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/17] fsinfo: Allow fsinfo() to look up a mount object by ID
 [ver #20]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Jul 2020 14:35:31 +0100
Message-ID: <159559773194.2144584.3568145560010846330.stgit@warthog.procyon.org.uk>
In-Reply-To: <159559768062.2144584.13583793543173131929.stgit@warthog.procyon.org.uk>
References: <159559768062.2144584.13583793543173131929.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index aef7a736e8fc..8ccbcddb4f16 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -563,6 +563,56 @@ static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_context *ctx)
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
+	unsigned long mnt_id;
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
@@ -636,6 +686,9 @@ SYSCALL_DEFINE6(fsinfo,
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
index 0b57da498f06..84bbb743a5ac 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -89,6 +89,7 @@ extern int __mnt_want_write_file(struct file *);
 extern void __mnt_drop_write_file(struct file *);
 
 extern void dissolve_on_fput(struct vfsmount *);
+extern int lookup_mount_object(struct path *, unsigned int, struct path *);
 extern int fsinfo_generic_mount_source(struct path *, struct fsinfo_context *);
 
 /*
diff --git a/fs/namespace.c b/fs/namespace.c
index ead8d1a16610..b2b9920ffd3c 100644
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
@@ -975,6 +985,7 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
 	lock_mount_hash();
 	list_add_tail(&mnt->mnt_instance, &mnt->mnt.mnt_sb->s_mounts);
 	unlock_mount_hash();
+	mnt_publish_id(mnt);
 	return &mnt->mnt;
 }
 EXPORT_SYMBOL(vfs_create_mount);
@@ -1068,6 +1079,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	lock_mount_hash();
 	list_add_tail(&mnt->mnt_instance, &sb->s_mounts);
 	unlock_mount_hash();
+	mnt_publish_id(mnt);
 
 	if ((flag & CL_SLAVE) ||
 	    ((flag & CL_SHARED_TO_SLAVE) && IS_MNT_SHARED(old))) {
@@ -4151,4 +4163,103 @@ int fsinfo_generic_mount_source(struct path *path, struct fsinfo_context *ctx)
 	return m.count + 1;
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
+int lookup_mount_object(struct path *root, unsigned int mnt_id, struct path *_mntpt)
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
index a27e92b68266..d24e47762a07 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -44,6 +44,7 @@ struct fsinfo_params {
 #define FSINFO_FLAGS_QUERY_MASK	0x0007 /* What object should fsinfo() query? */
 #define FSINFO_FLAGS_QUERY_PATH	0x0000 /* - path, specified by dirfd,pathname,AT_EMPTY_PATH */
 #define FSINFO_FLAGS_QUERY_FD	0x0001 /* - fd specified by dirfd */
+#define FSINFO_FLAGS_QUERY_MOUNT 0x0002	/* - mount object (path=>mount_id, dirfd=>subtree) */
 	__u32	request;	/* ID of requested attribute */
 	__u32	Nth;		/* Instance of it (some may have multiple) */
 	__u32	Mth;		/* Subinstance of Nth instance */
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 634f30b7e67f..dfa44bba8bbd 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -593,7 +593,7 @@ int main(int argc, char **argv)
 	bool meta = false;
 	int raw = 0, opt, Nth, Mth;
 
-	while ((opt = getopt(argc, argv, "Madlr"))) {
+	while ((opt = getopt(argc, argv, "Madmlr"))) {
 		switch (opt) {
 		case 'M':
 			meta = true;
@@ -609,6 +609,10 @@ int main(int argc, char **argv)
 			params.at_flags &= ~AT_SYMLINK_NOFOLLOW;
 			params.flags = FSINFO_FLAGS_QUERY_PATH;
 			continue;
+		case 'm':
+			params.resolve_flags = 0;
+			params.flags = FSINFO_FLAGS_QUERY_MOUNT;
+			continue;
 		case 'r':
 			raw = 1;
 			continue;
@@ -621,6 +625,7 @@ int main(int argc, char **argv)
 
 	if (argc != 1) {
 		printf("Format: test-fsinfo [-Madlr] <path>\n");
+		printf("Format: test-fsinfo [-Mdr] -m <mnt_id>\n");
 		exit(2);
 	}
 


