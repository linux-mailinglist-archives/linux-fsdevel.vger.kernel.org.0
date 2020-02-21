Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69F1A1685EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgBUSDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:03:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45239 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726946AbgBUSDQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582308195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+8bdzcPvK7VukzYPxxOK7S4lzkR998bwGqjZTrZWM+E=;
        b=STRzwvZ2bWEJNQuhHvfgj40WEafJrbfWY/nW7MreFb3V5IwJuIIGCJtnnilQWz5/ZUgNaF
        JWhwi0BW4IIw0roF2O5gwMhsvDlqezXsDKdXKqyQlYABIACt2p8j/gXBdEnL5se4K13GrO
        vc0CbpkLZIULrsSd9EQ4QesuEDaJMKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-uaPpYhJ6O2-U6R0YBBl1lA-1; Fri, 21 Feb 2020 13:03:13 -0500
X-MC-Unique: uaPpYhJ6O2-U6R0YBBl1lA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 690CF1034B49;
        Fri, 21 Feb 2020 18:03:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B3355DA76;
        Fri, 21 Feb 2020 18:03:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/17] fsinfo: Allow mount information to be queried [ver #17]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Feb 2020 18:03:08 +0000
Message-ID: <158230818859.2185128.8921928947340497977.stgit@warthog.procyon.org.uk>
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

Allow mount information, including information about the topology tree to
be queried with the fsinfo() system call.  Setting AT_FSINFO_QUERY_MOUNT
allows overlapping mounts to be queried by indicating that the syscall
should interpet the pathname as a number indicating the mount ID.

To this end, four fsinfo() attributes are provided:

 (1) FSINFO_ATTR_MOUNT_INFO.

     This is a structure providing information about a mount, including:

	- Mounted superblock ID.
	- Mount ID (can be used with AT_FSINFO_QUERY_MOUNT).
	- Parent mount ID.
	- Mount attributes (eg. R/O, NOEXEC).
	- A change counter.

     Note that the parent mount ID is overridden to the ID of the queried
     mount if the parent lies outside of the chroot or dfd tree.

 (2) FSINFO_ATTR_MOUNT_DEVNAME.

     This a string providing the device name associated with the mount.

     Note that the device name may be a path that lies outside of the root.

 (3) FSINFO_ATTR_MOUNT_POINT.

     This is a string indicating the name of the mountpoint within the
     parent mount, limited to the parent's mounted root and the chroot.

 (4) FSINFO_ATTR_MOUNT_CHILDREN.

     This produces an array of structures, one for each child and capped
     with one for the argument mount (checked after listing all the
     children).  Each element contains the mount ID and the change counter
     of the respective mount object.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/d_path.c                 |    2 
 fs/fsinfo.c                 |    5 +
 fs/internal.h               |   10 ++
 fs/namespace.c              |  179 +++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fsinfo.h |   34 ++++++++
 samples/vfs/test-fsinfo.c   |   27 ++++++
 6 files changed, 256 insertions(+), 1 deletion(-)

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
index 9712d340dd7d..e3377842a2c1 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -229,6 +229,11 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	(void *)123UL),
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, (void *)123UL),
+
+	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_INFO,	fsinfo_generic_mount_info),
+	FSINFO_STRING	(FSINFO_ATTR_MOUNT_DEVNAME,	fsinfo_generic_mount_devname),
+	FSINFO_STRING	(FSINFO_ATTR_MOUNT_POINT,	fsinfo_generic_mount_point),
+	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_children),
 	{}
 };
 
diff --git a/fs/internal.h b/fs/internal.h
index 2ccd2b2eae88..6804cf54846d 100644
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
@@ -92,6 +98,10 @@ extern void __mnt_drop_write_file(struct file *);
 
 extern void dissolve_on_fput(struct vfsmount *);
 extern int lookup_mount_object(struct path *, int, struct path *);
+extern int fsinfo_generic_mount_info(struct path *, struct fsinfo_context *);
+extern int fsinfo_generic_mount_devname(struct path *, struct fsinfo_context *);
+extern int fsinfo_generic_mount_point(struct path *, struct fsinfo_context *);
+extern int fsinfo_generic_mount_children(struct path *, struct fsinfo_context *);
 
 /*
  * fs_struct.c
diff --git a/fs/namespace.c b/fs/namespace.c
index 696fcc5010ca..fc22aea18e2d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -30,6 +30,7 @@
 #include <uapi/linux/mount.h>
 #include <linux/fs_context.h>
 #include <linux/shmem_fs.h>
+#include <linux/fsinfo.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -4108,3 +4109,181 @@ int lookup_mount_object(struct path *root, int mnt_id, struct path *_mntpt)
 	unlock_mount_hash();
 	goto out_unlock;
 }
+
+#ifdef CONFIG_FSINFO
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
+	if (!path->mnt)
+		return -ENODATA;
+
+	m = real_mount(path->mnt);
+	sb = m->mnt.mnt_sb;
+
+	p->f_sb_id		= sb->s_unique_id;
+	p->mnt_id		= m->mnt_id;
+	p->parent_id		= m->mnt_parent->mnt_id;
+	p->change_counter	= atomic_read(&m->mnt_change_counter);
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
+int fsinfo_generic_mount_devname(struct path *path, struct fsinfo_context *ctx)
+{
+	if (!path->mnt)
+		return -ENODATA;
+
+	return fsinfo_string(real_mount(path->mnt)->mnt_devname, ctx);
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
+	size_t len;
+	void *p;
+
+	if (!path->mnt)
+		return -ENODATA;
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
+		len = snprintf(ctx->buffer, ctx->buf_size, "/");
+	} else {
+		if (root.mnt != &parent->mnt) {
+			root.mnt = &parent->mnt;
+			root.dentry = parent->mnt.mnt_root;
+		}
+
+		p = __d_path(&mountpoint, &root, ctx->buffer, ctx->buf_size);
+		rcu_read_unlock();
+
+		if (IS_ERR(p))
+			return PTR_ERR(p);
+		if (!p)
+			return -EPERM;
+
+		len = (ctx->buffer + ctx->buf_size) - p;
+		memmove(ctx->buffer, p, len);
+	}
+	return len;
+}
+
+/*
+ * Store a mount record into the fsinfo buffer.
+ */
+static void store_mount_fsinfo(struct fsinfo_context *ctx,
+			       struct fsinfo_mount_child *child)
+{
+	unsigned int usage = ctx->usage;
+	unsigned int total = sizeof(*child);
+
+	if (ctx->usage >= INT_MAX)
+		return;
+	ctx->usage = usage + total;
+	if (ctx->buffer && ctx->usage <= ctx->buf_size)
+		memcpy(ctx->buffer + usage, child, total);
+}
+
+/*
+ * Return information about the submounts relative to path.
+ */
+int fsinfo_generic_mount_children(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_mount_child record;
+	struct mount *m, *child;
+
+	if (!path->mnt)
+		return -ENODATA;
+
+	m = real_mount(path->mnt);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(child, &m->mnt_mounts, mnt_child) {
+		if (child->mnt_parent != m)
+			continue;
+		record.mnt_id = child->mnt_id;
+		record.change_counter = atomic_read(&child->mnt_change_counter);
+		store_mount_fsinfo(ctx, &record);
+	}
+	rcu_read_unlock();
+
+	/* End the list with a copy of the parameter mount's details so that
+	 * userspace can quickly check for changes.
+	 */
+	record.mnt_id = m->mnt_id;
+	record.change_counter = atomic_read(&m->mnt_change_counter);
+	store_mount_fsinfo(ctx, &record);
+	return ctx->usage;
+}
+
+#endif /* CONFIG_FSINFO */
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 3ce7810d96b4..29940d110ce3 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -27,6 +27,11 @@
 #define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO 0x100	/* Information about attr N (for path) */
 #define FSINFO_ATTR_FSINFO_ATTRIBUTES	0x101	/* List of supported attrs (for path) */
 
+#define FSINFO_ATTR_MOUNT_INFO		0x200	/* Mount object information */
+#define FSINFO_ATTR_MOUNT_DEVNAME	0x201	/* Mount object device name (string) */
+#define FSINFO_ATTR_MOUNT_POINT		0x202	/* Relative path of mount in parent (string) */
+#define FSINFO_ATTR_MOUNT_CHILDREN	0x203	/* Children of this mount (list) */
+
 /*
  * Optional fsinfo() parameter structure.
  *
@@ -69,6 +74,7 @@ struct fsinfo_attribute_info {
 	unsigned int		size;		/* - Value size (FSINFO_STRUCT/FSINFO_LIST) */
 };
 
+#define FSINFO_ATTR_FSINFO_ATTRIBUTES__STRUCT __u32
 #define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO__STRUCT struct fsinfo_attribute_info
 #define FSINFO_ATTR_FSINFO_ATTRIBUTES__STRUCT __u32
 
@@ -82,6 +88,34 @@ struct fsinfo_u128 {
 #endif
 };
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_MOUNT_INFO).
+ */
+struct fsinfo_mount_info {
+	__u64		f_sb_id;	/* Superblock ID */
+	__u32		mnt_id;		/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
+	__u32		parent_id;	/* Parent mount identifier */
+	__u32		group_id;	/* Mount group ID */
+	__u32		master_id;	/* Slave master group ID */
+	__u32		from_id;	/* Slave propagated from ID */
+	__u32		attr;		/* MOUNT_ATTR_* flags */
+	__u32		change_counter;	/* Number of changes applied. */
+	__u32		__reserved[1];
+};
+
+#define FSINFO_ATTR_MOUNT_INFO__STRUCT struct fsinfo_mount_info
+
+/*
+ * Information struct element for fsinfo(FSINFO_ATTR_MOUNT_CHILDREN).
+ * - An extra element is placed on the end representing the parent mount.
+ */
+struct fsinfo_mount_child {
+	__u32		mnt_id;		/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
+	__u32		change_counter;	/* Number of changes applied to mount. */
+};
+
+#define FSINFO_ATTR_MOUNT_CHILDREN__STRUCT struct fsinfo_mount_child
+
 /*
  * Information struct for fsinfo(FSINFO_ATTR_STATFS).
  * - This gives extended filesystem information.
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 546bf4f530d0..f761ded6a52c 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -282,6 +282,26 @@ static void dump_fsinfo_generic_volume_uuid(void *reply, unsigned int size)
 	       f->uuid[14], f->uuid[15]);
 }
 
+static void dump_fsinfo_generic_mount_info(void *reply, unsigned int size)
+{
+	struct fsinfo_mount_info *f = reply;
+
+	printf("\n");
+	printf("\tsb_id   : %llx\n", (unsigned long long)f->f_sb_id);
+	printf("\tmnt_id  : %x\n", f->mnt_id);
+	printf("\tparent  : %x\n", f->parent_id);
+	printf("\tgroup   : %x\n", f->group_id);
+	printf("\tattr    : %x\n", f->attr);
+	printf("\tchanges : %x\n", f->change_counter);
+}
+
+static void dump_fsinfo_generic_mount_child(void *reply, unsigned int size)
+{
+	struct fsinfo_mount_child *f = reply;
+
+	printf("%8x %8x\n", f->mnt_id, f->change_counter);
+}
+
 static void dump_string(void *reply, unsigned int size)
 {
 	char *s = reply, *p;
@@ -309,6 +329,8 @@ static void dump_string(void *reply, unsigned int size)
 
 #define dump_fsinfo_generic_volume_id		dump_string
 #define dump_fsinfo_generic_volume_name		dump_string
+#define dump_fsinfo_generic_mount_devname	dump_string
+#define dump_fsinfo_generic_mount_point		dump_string
 
 /*
  *
@@ -344,6 +366,11 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
 	FSINFO_STRING	(FSINFO_ATTR_VOLUME_NAME,	fsinfo_generic_volume_name),
+
+	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_INFO,	fsinfo_generic_mount_info),
+	FSINFO_STRING	(FSINFO_ATTR_MOUNT_DEVNAME,	fsinfo_generic_mount_devname),
+	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_child),
+	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT,	fsinfo_generic_mount_point),
 	{}
 };
 


