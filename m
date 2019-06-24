Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D23C50D71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbfFXOKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:10:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbfFXOKW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:10:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 886AB87638;
        Mon, 24 Jun 2019 14:10:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D98B35D9C5;
        Mon, 24 Jun 2019 14:10:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/25] vfs: Allow mount information to be queried by
 fsinfo() [ver #14]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 15:10:20 +0100
Message-ID: <156138542011.25627.17245518783942568567.stgit@warthog.procyon.org.uk>
In-Reply-To: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 24 Jun 2019 14:10:22 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow mount information, including information about the topology tree to
be queried with the fsinfo() system call.  Usage of AT_FSINFO_MOUNTID_PATH
allows overlapping mounts to be queried.

To this end, four fsinfo() attributes are provided:

 (1) FSINFO_ATTR_MOUNT_INFO.

     This is a structure providing information about a mount, including:

	- Mounted superblock ID.
	- Mount ID (as AT_FSINFO_MOUNTID_PATH).
	- Parent mount ID.
	- Mount attributes (eg. R/O, NOEXEC).
	- Number of change notifications generated.

     Note that the parent mount ID is overridden to the ID of the queried
     mount if the parent lies outside of the chroot or dfd tree.

 (2) FSINFO_ATTR_MOUNT_DEVNAME.

     This a string providing the device name associated with the mount.

     Note that the device name may be a path that lies outside of the root.

 (3) FSINFO_ATTR_MOUNT_CHILDREN.

     This produces an array of structures, one for each child and capped
     with one for the argument mount (checked after listing all the
     children).  Each element contains the mount ID and the notification
     counter of the respective mount object.

 (4) FSINFO_ATTR_MOUNT_SUBMOUNT.

     This is a 1D array of strings, indexed with struct fsinfo_params::Nth.
     Each string is the relative pathname of the corresponding child
     returned by FSINFO_ATTR_MOUNT_CHILDREN.

     Note that paths in the mount at the base of the tree (whether that be
     dfd or chroot) are relative to the base of the tree, not the root
     directory of that mount.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/d_path.c                 |    2 
 fs/fsinfo.c                 |    8 ++
 fs/internal.h               |    9 ++
 fs/namespace.c              |  177 +++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fsinfo.h |   28 +++++++
 samples/vfs/test-fsinfo.c   |   47 +++++++++++
 6 files changed, 267 insertions(+), 4 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index a7d0a96b35ce..89d77c264c5f 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -227,7 +227,7 @@ static int prepend_unreachable(char **buffer, int *buflen)
 	return prepend(buffer, buflen, "(unreachable)", 13);
 }
 
-static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
+void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
 {
 	unsigned seq;
 
diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index 3b218f9fedb7..61f00f375fd2 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -348,6 +348,10 @@ int generic_fsinfo(struct path *path, struct fsinfo_kparams *params)
 	case _genf(PARAM_SPECIFICATION,	param_specification);
 	case _genf(PARAM_ENUM,		param_enum);
 	case _genp(PARAMETERS,		parameters);
+	case _genp(MOUNT_INFO,		mount_info);
+	case _genp(MOUNT_DEVNAME,	mount_devname);
+	case _genp(MOUNT_CHILDREN,	mount_children);
+	case _genp(MOUNT_SUBMOUNT,	mount_submount);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -627,6 +631,10 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
 	FSINFO_OPAQUE		(PARAMETERS,		-),
 	FSINFO_OPAQUE		(LSM_PARAMETERS,	-),
+	FSINFO_STRUCT		(MOUNT_INFO,		mount_info),
+	FSINFO_STRING		(MOUNT_DEVNAME,		mount_devname),
+	FSINFO_STRUCT_ARRAY	(MOUNT_CHILDREN,	mount_child),
+	FSINFO_STRING_N		(MOUNT_SUBMOUNT,	mount_submount),
 };
 
 /**
diff --git a/fs/internal.h b/fs/internal.h
index 074b1c65e3bd..bb3d8efa7f49 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -53,6 +53,11 @@ void __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
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
@@ -98,6 +103,10 @@ extern void __mnt_drop_write_file(struct file *);
 
 extern void dissolve_on_fput(struct vfsmount *);
 extern int lookup_mount_object(struct path *, int, struct path *);
+extern int fsinfo_generic_mount_info(struct path *, struct fsinfo_kparams *);
+extern int fsinfo_generic_mount_devname(struct path *, struct fsinfo_kparams *);
+extern int fsinfo_generic_mount_children(struct path *, struct fsinfo_kparams *);
+extern int fsinfo_generic_mount_submount(struct path *, struct fsinfo_kparams *);
 
 /*
  * fs_struct.c
diff --git a/fs/namespace.c b/fs/namespace.c
index 1450faab96b9..2ec7d9d1905a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -29,6 +29,7 @@
 #include <linux/sched/task.h>
 #include <uapi/linux/mount.h>
 #include <linux/fs_context.h>
+#include <linux/fsinfo.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -4112,3 +4113,179 @@ int lookup_mount_object(struct path *root, int mnt_id, struct path *_mntpt)
 	unlock_mount_hash();
 	goto out_unlock;
 }
+
+#ifdef CONFIG_FSINFO
+int fsinfo_generic_mount_info(struct path *path, struct fsinfo_kparams *params)
+{
+	struct fsinfo_mount_info *p = params->buffer;
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
+	p->notify_counter	= atomic_read(&m->mnt_notify_counter);
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
+int fsinfo_generic_mount_devname(struct path *path, struct fsinfo_kparams *params)
+{
+	struct mount *m;
+	size_t len;
+
+	if (!path->mnt)
+		return -ENODATA;
+
+	m = real_mount(path->mnt);
+	len = strlen(m->mnt_devname);
+	memcpy(params->buffer, m->mnt_devname, len);
+	return len;
+}
+
+/*
+ * Store a mount record into the fsinfo buffer.
+ */
+static void store_mount_fsinfo(struct fsinfo_kparams *params,
+			       struct fsinfo_mount_child *child)
+{
+	unsigned int usage = params->usage;
+	unsigned int total = sizeof(*child);
+
+	if (params->usage >= INT_MAX)
+		return;
+	params->usage = usage + total;
+	if (params->buffer && params->usage <= params->buf_size)
+		memcpy(params->buffer + usage, child, total);
+}
+
+/*
+ * Return information about the submounts relative to path.
+ */
+int fsinfo_generic_mount_children(struct path *path, struct fsinfo_kparams *params)
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
+		record.notify_counter = atomic_read(&child->mnt_notify_counter);
+		store_mount_fsinfo(params, &record);
+	}
+	rcu_read_unlock();
+
+	/* End the list with a copy of the parameter mount's details so that
+	 * userspace can quickly check for changes.
+	 */
+	record.mnt_id = m->mnt_id;
+	record.notify_counter = atomic_read(&m->mnt_notify_counter);
+	store_mount_fsinfo(params, &record);
+	return params->usage;
+}
+
+/*
+ * Return the path of the Nth submount relative to path.  This is derived from
+ * d_path(), but the root determination is more complicated.
+ */
+int fsinfo_generic_mount_submount(struct path *path, struct fsinfo_kparams *params)
+{
+	struct mountpoint *mp;
+	struct mount *m, *child;
+	struct path mountpoint, root;
+	unsigned int n = params->Nth;
+	size_t len;
+	void *p;
+
+	if (!path->mnt)
+		return -ENODATA;
+
+	rcu_read_lock();
+
+	m = real_mount(path->mnt);
+	list_for_each_entry_rcu(child, &m->mnt_mounts, mnt_child) {
+		mp = READ_ONCE(child->mnt_mp);
+		if (child->mnt_parent != m || !mp)
+			continue;
+		if (n-- == 0)
+			goto found;
+	}
+	rcu_read_unlock();
+	return -ENODATA;
+
+found:
+	mountpoint.mnt = path->mnt;
+	mountpoint.dentry = READ_ONCE(mp->m_dentry);
+
+	get_fs_root_rcu(current->fs, &root);
+	if (root.mnt != path->mnt) {
+		root.mnt = path->mnt;
+		root.dentry = path->mnt->mnt_root;
+	}
+
+	p = __d_path(&mountpoint, &root, params->buffer, params->buf_size);
+	rcu_read_unlock();
+
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+	if (!p)
+		return -EPERM;
+
+	len = (params->buffer + params->buf_size) - p;
+	memmove(params->buffer, p, len);
+	return len;
+}
+#endif /* CONFIG_FSINFO */
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index bae0bdc9ace9..88e1d004ac6c 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -32,6 +32,10 @@ enum fsinfo_attribute {
 	FSINFO_ATTR_PARAM_ENUM		= 14,	/* Nth enum-to-val */
 	FSINFO_ATTR_PARAMETERS		= 15,	/* Mount parameters (large string) */
 	FSINFO_ATTR_LSM_PARAMETERS	= 16,	/* LSM Mount parameters (large string) */
+	FSINFO_ATTR_MOUNT_INFO		= 17,	/* Mount object information */
+	FSINFO_ATTR_MOUNT_DEVNAME	= 18,	/* Mount object device name (string) */
+	FSINFO_ATTR_MOUNT_CHILDREN	= 19,	/* Submount list (array) */
+	FSINFO_ATTR_MOUNT_SUBMOUNT	= 20,	/* Relative path of Nth submount (string) */
 	FSINFO_ATTR__NR
 };
 
@@ -276,4 +280,28 @@ struct fsinfo_param_enum {
 	char		name[252];	/* Name of the enum value */
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
+	__u32		notify_counter;	/* Number of notifications generated. */
+	__u32		__reserved[1];
+};
+
+/*
+ * Information struct element for fsinfo(FSINFO_ATTR_MOUNT_CHILDREN).
+ * - An extra element is placed on the end representing the parent mount.
+ */
+struct fsinfo_mount_child {
+	__u32		mnt_id;		/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
+	__u32		notify_counter;	/* Number of notifications generated on mount. */
+};
+
 #endif /* _UAPI_LINUX_FSINFO_H */
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index fadc5e1384fc..ab32a15d4c5b 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -21,10 +21,10 @@
 #include <errno.h>
 #include <time.h>
 #include <math.h>
-#include <fcntl.h>
 #include <sys/syscall.h>
 #include <linux/fsinfo.h>
 #include <linux/socket.h>
+#include <linux/fcntl.h>
 #include <sys/stat.h>
 #include <arpa/inet.h>
 
@@ -83,6 +83,10 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
 	FSINFO_OVERLARGE	(PARAMETERS,		-),
 	FSINFO_OVERLARGE	(LSM_PARAMETERS,	-),
+	FSINFO_STRUCT		(MOUNT_INFO,		mount_info),
+	FSINFO_STRING		(MOUNT_DEVNAME,		mount_devname),
+	FSINFO_STRUCT_ARRAY	(MOUNT_CHILDREN,	mount_child),
+	FSINFO_STRING_N		(MOUNT_SUBMOUNT,	mount_submount),
 };
 
 #define FSINFO_NAME(X,Y) [FSINFO_ATTR_##X] = #Y
@@ -104,6 +108,10 @@ static const char *fsinfo_attr_names[FSINFO_ATTR__NR] = {
 	FSINFO_NAME		(PARAM_ENUM,		param_enum),
 	FSINFO_NAME		(PARAMETERS,		parameters),
 	FSINFO_NAME		(LSM_PARAMETERS,	lsm_parameters),
+	FSINFO_NAME		(MOUNT_INFO,		mount_info),
+	FSINFO_NAME		(MOUNT_DEVNAME,		mount_devname),
+	FSINFO_NAME		(MOUNT_CHILDREN,	mount_children),
+	FSINFO_NAME		(MOUNT_SUBMOUNT,	mount_submount),
 };
 
 union reply {
@@ -116,6 +124,8 @@ union reply {
 	struct fsinfo_capabilities caps;
 	struct fsinfo_timestamp_info timestamps;
 	struct fsinfo_volume_uuid uuid;
+	struct fsinfo_mount_info mount_info;
+	struct fsinfo_mount_child mount_children[1];
 };
 
 static void dump_hex(unsigned int *data, int from, int to)
@@ -319,6 +329,29 @@ static void dump_attr_VOLUME_UUID(union reply *r, int size)
 	       f->uuid[14], f->uuid[15]);
 }
 
+static void dump_attr_MOUNT_INFO(union reply *r, int size)
+{
+	struct fsinfo_mount_info *f = &r->mount_info;
+
+	printf("\n");
+	printf("\tsb_id   : %llx\n", (unsigned long long)f->f_sb_id);
+	printf("\tmnt_id  : %x\n", f->mnt_id);
+	printf("\tparent  : %x\n", f->parent_id);
+	printf("\tgroup   : %x\n", f->group_id);
+	printf("\tattr    : %x\n", f->attr);
+	printf("\tnotifs  : %x\n", f->notify_counter);
+}
+
+static void dump_attr_MOUNT_CHILDREN(union reply *r, int size)
+{
+	struct fsinfo_mount_child *f = r->mount_children;
+	int i = 0;
+
+	printf("\n");
+	for (; size >= sizeof(*f); size -= sizeof(*f), f++)
+		printf("\t[%u] %8x %8x\n", i++, f->mnt_id, f->notify_counter);
+}
+
 /*
  *
  */
@@ -334,6 +367,8 @@ static const dumper_t fsinfo_attr_dumper[FSINFO_ATTR__NR] = {
 	FSINFO_DUMPER(CAPABILITIES),
 	FSINFO_DUMPER(TIMESTAMP_INFO),
 	FSINFO_DUMPER(VOLUME_UUID),
+	FSINFO_DUMPER(MOUNT_INFO),
+	FSINFO_DUMPER(MOUNT_CHILDREN),
 };
 
 static void dump_fsinfo(enum fsinfo_attribute attr,
@@ -536,16 +571,21 @@ int main(int argc, char **argv)
 	unsigned int attr;
 	int raw = 0, opt, Nth, Mth;
 
-	while ((opt = getopt(argc, argv, "adlr"))) {
+	while ((opt = getopt(argc, argv, "Madlr"))) {
 		switch (opt) {
+		case 'M':
+			params.at_flags = AT_FSINFO_MOUNTID_PATH;
+			continue;
 		case 'a':
 			params.at_flags |= AT_NO_AUTOMOUNT;
+			params.at_flags &= ~AT_FSINFO_MOUNTID_PATH;
 			continue;
 		case 'd':
 			debug = true;
 			continue;
 		case 'l':
 			params.at_flags &= ~AT_SYMLINK_NOFOLLOW;
+			params.at_flags &= ~AT_FSINFO_MOUNTID_PATH;
 			continue;
 		case 'r':
 			raw = 1;
@@ -558,7 +598,8 @@ int main(int argc, char **argv)
 	argv += optind;
 
 	if (argc != 1) {
-		printf("Format: test-fsinfo [-alr] <file>\n");
+		printf("Format: test-fsinfo [-adlr] <file>\n");
+		printf("Format: test-fsinfo [-dr] -M <mnt_id>\n");
 		exit(2);
 	}
 

