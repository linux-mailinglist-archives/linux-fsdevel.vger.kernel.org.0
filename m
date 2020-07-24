Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C611322C6A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 15:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgGXNgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 09:36:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42652 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726931AbgGXNgC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595597760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fotUKMptHkYQQHndl5BpnjiJX3mD8PFHbtajrsB9/tY=;
        b=BCruDuz76yO+8xsHCjoCe3Wm3rCFM/oJoShEvza687dkyuw1nxqF/Mtlh/earqA+fO2Hb1
        Kny/CAuqRQvYgVczhjmCIFHbecCTZwJcov14C5axfUzepirp4e7uKcnMIb1ypKieOnE3O+
        Wl8fKTOo5uu30gnebQDUxVibYZnIGv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-8QZ4OOrSNEGj1obkYhxw6w-1; Fri, 24 Jul 2020 09:35:54 -0400
X-MC-Unique: 8QZ4OOrSNEGj1obkYhxw6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E9A010059A9;
        Fri, 24 Jul 2020 13:35:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C83CC183AB;
        Fri, 24 Jul 2020 13:35:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/17] fsinfo: Allow mount information to be queried [ver #20]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Jul 2020 14:35:48 +0100
Message-ID: <159559774897.2144584.567467595900151004.stgit@warthog.procyon.org.uk>
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

Allow mount information, including information about a mount object to be
queried with the fsinfo() system call.  Setting FSINFO_FLAGS_QUERY_MOUNT
allows overlapping mounts to be queried by indicating that the syscall
should interpret the pathname as a number indicating the mount ID.

To this end, a number of fsinfo() attributes are provided:

 (1) FSINFO_ATTR_MOUNT_INFO.

     This is a structure providing information about a mount, including:

	- Mount ID (can be used with FSINFO_FLAGS_QUERY_MOUNT).
	- Mount uniquifier ID.
	- Mount attributes (eg. R/O, NOEXEC).
	- Mount change/notification counters.
	- Superblock ID.
	- Superblock change/notification counters.

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

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/d_path.c                 |    2 -
 fs/fsinfo.c                 |   12 +++++
 fs/internal.h               |    9 +++
 fs/namespace.c              |  114 +++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fsinfo.h |   17 ++++++
 samples/vfs/test-fsinfo.c   |   16 ++++++
 6 files changed, 169 insertions(+), 1 deletion(-)

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
index 8ccbcddb4f16..f276857709ee 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -252,6 +252,13 @@ static int fsinfo_generic_seq_read(struct path *path, struct fsinfo_context *ctx
 			ret = sb->s_op->show_options(&m, path->mnt->mnt_root);
 		break;
 
+	case FSINFO_ATTR_MOUNT_PATH:
+		if (sb->s_op->show_path)
+			ret = sb->s_op->show_path(&m, path->mnt->mnt_root);
+		else
+			seq_dentry(&m, path->mnt->mnt_root, " \t\n\\");
+		break;
+
 	case FSINFO_ATTR_FS_STATISTICS:
 		if (sb->s_op->show_stats)
 			ret = sb->s_op->show_stats(&m, path->mnt->mnt_root);
@@ -282,6 +289,11 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	(void *)123UL),
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, (void *)123UL),
+
+	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_INFO,	fsinfo_generic_mount_info),
+	FSINFO_STRING	(FSINFO_ATTR_MOUNT_PATH,	fsinfo_generic_seq_read),
+	FSINFO_STRING	(FSINFO_ATTR_MOUNT_POINT,	fsinfo_generic_mount_point),
+	FSINFO_STRING	(FSINFO_ATTR_MOUNT_POINT_FULL,	fsinfo_generic_mount_point_full),
 	{}
 };
 
diff --git a/fs/internal.h b/fs/internal.h
index 84bbb743a5ac..a56008b7f3ec 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -15,6 +15,7 @@ struct mount;
 struct shrink_control;
 struct fs_context;
 struct user_namespace;
+struct fsinfo_context;
 
 /*
  * block_dev.c
@@ -46,6 +47,11 @@ extern int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
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
@@ -91,6 +97,9 @@ extern void __mnt_drop_write_file(struct file *);
 extern void dissolve_on_fput(struct vfsmount *);
 extern int lookup_mount_object(struct path *, unsigned int, struct path *);
 extern int fsinfo_generic_mount_source(struct path *, struct fsinfo_context *);
+extern int fsinfo_generic_mount_info(struct path *, struct fsinfo_context *);
+extern int fsinfo_generic_mount_point(struct path *, struct fsinfo_context *);
+extern int fsinfo_generic_mount_point_full(struct path *, struct fsinfo_context *);
 
 /*
  * fs_struct.c
diff --git a/fs/namespace.c b/fs/namespace.c
index 1db8a64cd76f..c196af35d39d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4265,4 +4265,118 @@ int lookup_mount_object(struct path *root, unsigned int mnt_id, struct path *_mn
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
+	unsigned int flags;
+
+	m = real_mount(path->mnt);
+	sb = m->mnt.mnt_sb;
+
+	p->sb_unique_id		= sb->s_unique_id;
+	p->mnt_unique_id	= m->mnt_unique_id;
+	p->mnt_id		= m->mnt_id;
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
+	((char *)ctx->buffer)[ctx->buf_size - 1] = 0;
+	p = __d_path(&mountpoint, &root, ctx->buffer, ctx->buf_size - 1);
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
+	((char *)ctx->buffer)[ctx->buf_size - 1] = 0;
+
+	rcu_read_lock();
+	get_fs_root_rcu(current->fs, &root);
+	p = __d_path(path, &root, ctx->buffer, ctx->buf_size - 1);
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
 #endif /* CONFIG_FSINFO */
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index d24e47762a07..15ef161905cd 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -31,6 +31,11 @@
 #define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO 0x100	/* Information about attr N (for path) */
 #define FSINFO_ATTR_FSINFO_ATTRIBUTES	0x101	/* List of supported attrs (for path) */
 
+#define FSINFO_ATTR_MOUNT_INFO		0x200	/* Mount object information */
+#define FSINFO_ATTR_MOUNT_PATH		0x201	/* Bind mount/superblock path (string) */
+#define FSINFO_ATTR_MOUNT_POINT		0x202	/* Relative path of mount in parent (string) */
+#define FSINFO_ATTR_MOUNT_POINT_FULL	0x203	/* Absolute path of mount (string) */
+
 /*
  * Optional fsinfo() parameter structure.
  *
@@ -85,6 +90,18 @@ struct fsinfo_u128 {
 #endif
 };
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_MOUNT_INFO).
+ */
+struct fsinfo_mount_info {
+	__u64	sb_unique_id;		/* Kernel-lifetime unique superblock ID */
+	__u64	mnt_unique_id;		/* Kernel-lifetime unique mount ID */
+	__u32	mnt_id;			/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
+	__u32	attr;			/* MOUNT_ATTR_* flags */
+};
+
+#define FSINFO_ATTR_MOUNT_INFO__STRUCT struct fsinfo_mount_info
+
 /*
  * Information struct for fsinfo(FSINFO_ATTR_STATFS).
  * - This gives extended filesystem information.
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index dfa44bba8bbd..f3bebb7318d9 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -294,6 +294,17 @@ static void dump_fsinfo_generic_volume_uuid(void *reply, unsigned int size)
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
+	printf("\tattr    : %x\n", r->attr);
+}
+
 static void dump_string(void *reply, unsigned int size)
 {
 	char *s = reply, *p;
@@ -370,6 +381,11 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, fsinfo_meta_attribute_info),
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	fsinfo_meta_attributes),
+
+	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_INFO,	fsinfo_generic_mount_info),
+	FSINFO_STRING	(FSINFO_ATTR_MOUNT_PATH,	string),
+	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT,	string),
+	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT_FULL,	string),
 	{}
 };
 


