Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0FB317E1FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 15:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgCIOCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 10:02:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44277 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727075AbgCIOCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583762522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uQeiiqSYLfDnJUom0XBp5WsDXNbdwa2GkXPl/Fv1nog=;
        b=Q7cP+rFbrmi2gVx9RWLiijExbkVXDm3me5y+vK43IkXefmt55HOnYWYVIlb18zPRLML7j+
        tf2t95+2shNUGq3RLXqcxQN4SqMPwVxfz7ppEw15JOsqYRJAwxyCpFExAWGO0C6cy6/l8h
        pJkwCCdzNxIl/TczjbO6ak1RR58Xg6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-fjF9UD7mMc2JIYw7uG-C9w-1; Mon, 09 Mar 2020 10:01:58 -0400
X-MC-Unique: fjF9UD7mMc2JIYw7uG-C9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 872A4190D341;
        Mon,  9 Mar 2020 14:01:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A668A5C13D;
        Mon,  9 Mar 2020 14:01:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/14] fsinfo: Allow mount information to be queried [ver #18]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 14:01:52 +0000
Message-ID: <158376251286.344135.12815432977346939752.stgit@warthog.procyon.org.uk>
In-Reply-To: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow mount information, including information about the topology tree to
be queried with the fsinfo() system call.  Setting AT_FSINFO_QUERY_MOUNT
allows overlapping mounts to be queried by indicating that the syscall
should interpet the pathname as a number indicating the mount ID.

To this end, a number of fsinfo() attributes are provided:

 (1) FSINFO_ATTR_MOUNT_INFO.

     This is a structure providing information about a mount, including:

	- Mounted superblock ID (mount ID uniquifier).
	- Mount ID (can be used with AT_FSINFO_QUERY_MOUNT).
	- Parent mount ID.
	- Mount attributes (eg. R/O, NOEXEC).
	- Mount change/notification counter.

     Note that the parent mount ID is overridden to the ID of the queried
     mount if the parent lies outside of the chroot or dfd tree.

 (2) FSINFO_ATTR_MOUNT_PATH.

     This a string providing information about a bind mount relative the
     the root that was bound off, though it may get overridden by the
     filesystem (NFS unconditionally sets it to "/", for example).

 (3) FSINFO_ATTR_MOUNT_POINT.

     This is a string indicating the name of the mountpoint within the
     parent mount, limited to the parent's mounted root and the chroot.

 (4) FSINFO_ATTR_MOUNT_POINT_FULL.

     This is a string indicating the full path of the mountpoint, limited to
     the chroot.

 (5) FSINFO_ATTR_MOUNT_CHILDREN.

     This produces an array of structures, one for each child and capped
     with one for the argument mount (checked after listing all the
     children).  Each element contains the mount ID and the change counter
     of the respective mount object.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/d_path.c                 |    2 
 fs/fsinfo.c                 |   14 +++
 fs/internal.h               |   10 ++
 fs/namespace.c              |  177 +++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fsinfo.h |   36 +++++++++
 samples/vfs/test-fsinfo.c   |   43 ++++++++++
 6 files changed, 281 insertions(+), 1 deletion(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index 0f1fc1743302..4c203f64e45e 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -229,7 +229,7 @@ static int prepend_unreachable(char **buffer, int *buflen)
 	return prepend(buffer, buflen, "(unreachable)", 13);
 }
 
-static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
+void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
 {
 	unsigned seq;
 
diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index bafeb73feaf4..6d2bc03998e4 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -236,6 +236,14 @@ static int fsinfo_generic_seq_read(struct path *path, struct fsinfo_context *ctx
 			ret = sb->s_op->show_options(&m, path->mnt->mnt_root);
 		break;
 
+	case FSINFO_ATTR_MOUNT_PATH:
+		if (sb->s_op->show_path) {
+			ret = sb->s_op->show_path(&m, path->mnt->mnt_root);
+		} else {
+			seq_dentry(&m, path->mnt->mnt_root, " \t\n\\");
+		}
+		break;
+
 	case FSINFO_ATTR_FS_STATISTICS:
 		if (sb->s_op->show_stats)
 			ret = sb->s_op->show_stats(&m, path->mnt->mnt_root);
@@ -270,6 +278,12 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	(void *)123UL),
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, (void *)123UL),
+
+	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_INFO,	fsinfo_generic_mount_info),
+	FSINFO_STRING	(FSINFO_ATTR_MOUNT_PATH,	fsinfo_generic_seq_read),
+	FSINFO_STRING	(FSINFO_ATTR_MOUNT_POINT,	fsinfo_generic_mount_point),
+	FSINFO_STRING	(FSINFO_ATTR_MOUNT_POINT_FULL,	fsinfo_generic_mount_point_full),
+	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_children),
 	{}
 };
 
diff --git a/fs/internal.h b/fs/internal.h
index abbd5299e7dc..1a318dc85f2f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -15,6 +15,7 @@ struct mount;
 struct shrink_control;
 struct fs_context;
 struct user_namespace;
+struct fsinfo_context;
 
 /*
  * block_dev.c
@@ -47,6 +48,11 @@ extern int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
  */
 extern void __init chrdev_init(void);
 
+/*
+ * d_path.c
+ */
+extern void get_fs_root_rcu(struct fs_struct *fs, struct path *root);
+
 /*
  * fs_context.c
  */
@@ -93,6 +99,10 @@ extern void __mnt_drop_write_file(struct file *);
 extern void dissolve_on_fput(struct vfsmount *);
 extern int lookup_mount_object(struct path *, int, struct path *);
 extern int fsinfo_generic_mount_source(struct path *, struct fsinfo_context *);
+extern int fsinfo_generic_mount_info(struct path *, struct fsinfo_context *);
+extern int fsinfo_generic_mount_point(struct path *, struct fsinfo_context *);
+extern int fsinfo_generic_mount_point_full(struct path *, struct fsinfo_context *);
+extern int fsinfo_generic_mount_children(struct path *, struct fsinfo_context *);
 
 /*
  * fs_struct.c
diff --git a/fs/namespace.c b/fs/namespace.c
index 54e8eb93fdd6..a6cb8c6b004f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4149,4 +4149,181 @@ int lookup_mount_object(struct path *root, int mnt_id, struct path *_mntpt)
 	goto out_unlock;
 }
 
+/*
+ * Retrieve information about the nominated mount.
+ */
+int fsinfo_generic_mount_info(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_mount_info *p = ctx->buffer;
+	struct super_block *sb;
+	struct mount *m;
+	struct path root;
+	unsigned int flags;
+
+	m = real_mount(path->mnt);
+	sb = m->mnt.mnt_sb;
+
+	p->sb_unique_id		= sb->s_unique_id;
+	p->mnt_unique_id	= m->mnt_unique_id;
+	p->mnt_id		= m->mnt_id;
+	p->parent_id		= m->mnt_parent->mnt_id;
+
+	get_fs_root(current->fs, &root);
+	if (path->mnt == root.mnt) {
+		p->parent_id = p->mnt_id;
+	} else {
+		rcu_read_lock();
+		if (!are_paths_connected(&root, path))
+			p->parent_id = p->mnt_id;
+		rcu_read_unlock();
+	}
+	if (IS_MNT_SHARED(m))
+		p->group_id = m->mnt_group_id;
+	if (IS_MNT_SLAVE(m)) {
+		int master = m->mnt_master->mnt_group_id;
+		int dom = get_dominating_id(m, &root);
+		p->master_id = master;
+		if (dom && dom != master)
+			p->from_id = dom;
+	}
+	path_put(&root);
+
+	flags = READ_ONCE(m->mnt.mnt_flags);
+	if (flags & MNT_READONLY)
+		p->attr |= MOUNT_ATTR_RDONLY;
+	if (flags & MNT_NOSUID)
+		p->attr |= MOUNT_ATTR_NOSUID;
+	if (flags & MNT_NODEV)
+		p->attr |= MOUNT_ATTR_NODEV;
+	if (flags & MNT_NOEXEC)
+		p->attr |= MOUNT_ATTR_NOEXEC;
+	if (flags & MNT_NODIRATIME)
+		p->attr |= MOUNT_ATTR_NODIRATIME;
+
+	if (flags & MNT_NOATIME)
+		p->attr |= MOUNT_ATTR_NOATIME;
+	else if (flags & MNT_RELATIME)
+		p->attr |= MOUNT_ATTR_RELATIME;
+	else
+		p->attr |= MOUNT_ATTR_STRICTATIME;
+	return sizeof(*p);
+}
+
+/*
+ * Return the path of this mount relative to its parent and clipped to
+ * the current chroot.
+ */
+int fsinfo_generic_mount_point(struct path *path, struct fsinfo_context *ctx)
+{
+	struct mountpoint *mp;
+	struct mount *m, *parent;
+	struct path mountpoint, root;
+	void *p;
+
+	rcu_read_lock();
+
+	m = real_mount(path->mnt);
+	parent = m->mnt_parent;
+	if (parent == m)
+		goto skip;
+	mp = READ_ONCE(m->mnt_mp);
+	if (mp)
+		goto found;
+skip:
+	rcu_read_unlock();
+	return -ENODATA;
+
+found:
+	mountpoint.mnt = &parent->mnt;
+	mountpoint.dentry = READ_ONCE(mp->m_dentry);
+
+	get_fs_root_rcu(current->fs, &root);
+	if (path->mnt == root.mnt) {
+		rcu_read_unlock();
+		return fsinfo_string("/", ctx);
+	}
+
+	if (root.mnt != &parent->mnt) {
+		root.mnt = &parent->mnt;
+		root.dentry = parent->mnt.mnt_root;
+	}
+
+	p = __d_path(&mountpoint, &root, ctx->buffer, ctx->buf_size);
+	rcu_read_unlock();
+
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+	if (!p)
+		return -EPERM;
+
+	ctx->skip = p - ctx->buffer;
+	return (ctx->buffer + ctx->buf_size) - p;
+}
+
+/*
+ * Return the path of this mount from the current chroot.
+ */
+int fsinfo_generic_mount_point_full(struct path *path, struct fsinfo_context *ctx)
+{
+	struct path root;
+	void *p;
+
+	rcu_read_lock();
+	get_fs_root_rcu(current->fs, &root);
+	p = __d_path(path, &root, ctx->buffer, ctx->buf_size);
+	rcu_read_unlock();
+
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+	if (!p)
+		return -EPERM;
+
+	ctx->skip = p - ctx->buffer;
+	return (ctx->buffer + ctx->buf_size) - p;
+}
+
+/*
+ * Store a mount record into the fsinfo buffer.
+ */
+static void fsinfo_store_mount(struct fsinfo_context *ctx, const struct mount *p)
+{
+	struct fsinfo_mount_child record = {};
+	unsigned int usage = ctx->usage;
+
+	if (ctx->usage >= INT_MAX)
+		return;
+	ctx->usage = usage + sizeof(record);
+
+	if (ctx->buffer && ctx->usage <= ctx->buf_size) {
+		record.mnt_unique_id	= p->mnt_unique_id;
+		record.mnt_id		= p->mnt_id;
+		memcpy(ctx->buffer + usage, &record, sizeof(record));
+	}
+}
+
+/*
+ * Return information about the submounts relative to path.
+ */
+int fsinfo_generic_mount_children(struct path *path, struct fsinfo_context *ctx)
+{
+	struct mount *m, *child;
+
+	m = real_mount(path->mnt);
+
+	read_seqlock_excl(&mount_lock);
+
+	list_for_each_entry_rcu(child, &m->mnt_mounts, mnt_child) {
+		if (child->mnt_parent != m)
+			continue;
+		fsinfo_store_mount(ctx, child);
+	}
+
+	/* End the list with a copy of the parameter mount's details so that
+	 * userspace can quickly check for changes.
+	 */
+	fsinfo_store_mount(ctx, m);
+	read_sequnlock_excl(&mount_lock);
+	return ctx->usage;
+}
+
 #endif /* CONFIG_FSINFO */
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 491a59e8cc95..7a8b577f54b7 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -31,6 +31,12 @@
 #define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO 0x100	/* Information about attr N (for path) */
 #define FSINFO_ATTR_FSINFO_ATTRIBUTES	0x101	/* List of supported attrs (for path) */
 
+#define FSINFO_ATTR_MOUNT_INFO		0x200	/* Mount object information */
+#define FSINFO_ATTR_MOUNT_PATH		0x201	/* Bind mount/superblock path (string) */
+#define FSINFO_ATTR_MOUNT_POINT		0x202	/* Relative path of mount in parent (string) */
+#define FSINFO_ATTR_MOUNT_POINT_FULL	0x203	/* Absolute path of mount (string) */
+#define FSINFO_ATTR_MOUNT_CHILDREN	0x204	/* Children of this mount (list) */
+
 /*
  * Optional fsinfo() parameter structure.
  *
@@ -71,6 +77,7 @@ struct fsinfo_attribute_info {
 	unsigned int		size;		/* - Value size (FSINFO_STRUCT/FSINFO_LIST) */
 };
 
+#define FSINFO_ATTR_FSINFO_ATTRIBUTES__STRUCT __u32
 #define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO__STRUCT struct fsinfo_attribute_info
 #define FSINFO_ATTR_FSINFO_ATTRIBUTES__STRUCT __u32
 
@@ -84,6 +91,35 @@ struct fsinfo_u128 {
 #endif
 };
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_MOUNT_INFO).
+ */
+struct fsinfo_mount_info {
+	__u64	sb_unique_id;		/* Kernel-lifetime unique superblock ID */
+	__u64	mnt_unique_id;		/* Kernel-lifetime unique mount ID */
+	__u32	mnt_id;			/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
+	__u32	parent_id;		/* Parent mount identifier */
+	__u32	group_id;		/* Mount group ID */
+	__u32	master_id;		/* Slave master group ID */
+	__u32	from_id;		/* Slave propagated from ID */
+	__u32	attr;			/* MOUNT_ATTR_* flags */
+	__u32	__padding[1];
+};
+
+#define FSINFO_ATTR_MOUNT_INFO__STRUCT struct fsinfo_mount_info
+
+/*
+ * Information struct element for fsinfo(FSINFO_ATTR_MOUNT_CHILDREN).
+ * - An extra element is placed on the end representing the parent mount.
+ */
+struct fsinfo_mount_child {
+	__u64	mnt_unique_id;		/* Kernel-lifetime unique mount ID */
+	__u32	mnt_id;			/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
+	__u32	__padding[1];
+};
+
+#define FSINFO_ATTR_MOUNT_CHILDREN__STRUCT struct fsinfo_mount_child
+
 /*
  * Information struct for fsinfo(FSINFO_ATTR_STATFS).
  * - This gives extended filesystem information.
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index c407bda4134f..2f9fe3b24bca 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -288,6 +288,43 @@ static void dump_fsinfo_generic_volume_uuid(void *reply, unsigned int size)
 	       f->uuid[14], f->uuid[15]);
 }
 
+static void dump_fsinfo_generic_mount_info(void *reply, unsigned int size)
+{
+	struct fsinfo_mount_info *r = reply;
+
+	printf("\n");
+	printf("\tsb_uniq : %llx\n", (unsigned long long)r->sb_unique_id);
+	printf("\tmnt_uniq: %llx\n", (unsigned long long)r->mnt_unique_id);
+	printf("\tmnt_id  : %x\n", r->mnt_id);
+	printf("\tparent  : %x\n", r->parent_id);
+	printf("\tgroup   : %x\n", r->group_id);
+	printf("\tattr    : %x\n", r->attr);
+}
+
+static void dump_fsinfo_generic_mount_child(void *reply, unsigned int size)
+{
+	struct fsinfo_mount_child *r = reply;
+	ssize_t mplen;
+	char path[32], *mp;
+
+	struct fsinfo_params params = {
+		.flags		= FSINFO_FLAGS_QUERY_MOUNT,
+		.request	= FSINFO_ATTR_MOUNT_POINT,
+	};
+
+	if (!list_last) {
+		sprintf(path, "%u", r->mnt_id);
+		mplen = get_fsinfo(path, "FSINFO_ATTR_MOUNT_POINT", &params, (void **)&mp);
+		if (mplen < 0)
+			mp = "-";
+	} else {
+		mp = "<this>";
+	}
+
+	printf("%8x %16llx %s\n",
+	       r->mnt_id, (unsigned long long)r->mnt_unique_id, mp);
+}
+
 static void dump_string(void *reply, unsigned int size)
 {
 	char *s = reply, *p;
@@ -364,6 +401,12 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, fsinfo_meta_attribute_info),
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	fsinfo_meta_attributes),
+
+	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_INFO,	fsinfo_generic_mount_info),
+	FSINFO_STRING	(FSINFO_ATTR_MOUNT_PATH,	string),
+	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT,	string),
+	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT_FULL,	string),
+	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_child),
 	{}
 };
 


