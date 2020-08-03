Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB8F23A7A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 15:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgHCNhn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 09:37:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41703 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728071AbgHCNhn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596461860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WzdBajwIoxe9KX6fUWaAWs3z3GLUUdDxwCWsSn+einQ=;
        b=GzGBToYGScNfKui5D1Yw5vlmo4i4YO8Gd6TDdbEBS5QndXtOV7sTY4R/RKxCbIQfrtH5zW
        ZE1dSlrOgVTc595HDtZHRQdgwEIPyARjvmxc/T+SvE6niRlfw7hZr3pUFUk4x9vnCLb/v7
        4DTnVMSp7YUzyFULrDiYeZlnVKcZYeI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-nSEzgzNsP7myyIs9IwAEHg-1; Mon, 03 Aug 2020 09:37:39 -0400
X-MC-Unique: nSEzgzNsP7myyIs9IwAEHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 312621800D42;
        Mon,  3 Aug 2020 13:37:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8939660BF4;
        Mon,  3 Aug 2020 13:37:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/18] fsinfo: Allow mount topology and propagation info to be
 retrieved [ver #21]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Aug 2020 14:37:33 +0100
Message-ID: <159646185371.1784947.14555585307218856883.stgit@warthog.procyon.org.uk>
In-Reply-To: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a couple of attributes to allow information about the mount topology
and propagation to be retrieved:

 (1) FSINFO_ATTR_MOUNT_TOPOLOGY.

     Information about a mount's parentage in the mount topology tree and
     its propagation attributes.

     This has to be collected with the VFS namespace lock held, so it's
     separate from FSINFO_ATTR_MOUNT_INFO.  The topology change counter
     that a subsequent patch will export can be used to work out from the
     cheaper _INFO attribute as to whether the more expensive _TOPOLOGY
     attribute needs requerying.

     MOUNT_PROPAGATION_* flags are added to linux/mount.h for UAPI
     consumption.  At some point a mount_setattr() system call needs to be
     added.

 (2) FSINFO_ATTR_MOUNT_CHILDREN.

     Information about a mount's children in the mount topology tree.

     This is formatted as an array of structures, one for each child and
     capped with one for the argument mount (checked after listing all the
     children).  Each element contains the static IDs of the respective
     mount object along with a sum of its change attributes.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsinfo.c                 |    2 +
 fs/internal.h               |    2 +
 fs/namespace.c              |   94 +++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fsinfo.h |   27 ++++++++++++
 include/uapi/linux/mount.h  |   13 +++++-
 samples/vfs/test-fsinfo.c   |   55 +++++++++++++++++++++++++
 6 files changed, 192 insertions(+), 1 deletion(-)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index f276857709ee..0540cce89555 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -291,9 +291,11 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, (void *)123UL),
 
 	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_INFO,	fsinfo_generic_mount_info),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_TOPOLOGY,	fsinfo_generic_mount_topology),
 	FSINFO_STRING	(FSINFO_ATTR_MOUNT_PATH,	fsinfo_generic_seq_read),
 	FSINFO_STRING	(FSINFO_ATTR_MOUNT_POINT,	fsinfo_generic_mount_point),
 	FSINFO_STRING	(FSINFO_ATTR_MOUNT_POINT_FULL,	fsinfo_generic_mount_point_full),
+	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_children),
 	{}
 };
 
diff --git a/fs/internal.h b/fs/internal.h
index a56008b7f3ec..cb5edcc7125a 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -98,8 +98,10 @@ extern void dissolve_on_fput(struct vfsmount *);
 extern int lookup_mount_object(struct path *, unsigned int, struct path *);
 extern int fsinfo_generic_mount_source(struct path *, struct fsinfo_context *);
 extern int fsinfo_generic_mount_info(struct path *, struct fsinfo_context *);
+extern int fsinfo_generic_mount_topology(struct path *, struct fsinfo_context *);
 extern int fsinfo_generic_mount_point(struct path *, struct fsinfo_context *);
 extern int fsinfo_generic_mount_point_full(struct path *, struct fsinfo_context *);
+extern int fsinfo_generic_mount_children(struct path *, struct fsinfo_context *);
 
 /*
  * fs_struct.c
diff --git a/fs/namespace.c b/fs/namespace.c
index c196af35d39d..b5c2a3b4f96d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4303,6 +4303,54 @@ int fsinfo_generic_mount_info(struct path *path, struct fsinfo_context *ctx)
 	return sizeof(*p);
 }
 
+/*
+ * Retrieve information about the topology at the nominated mount and
+ * its propogation attributes.
+ */
+int fsinfo_generic_mount_topology(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_mount_topology *p = ctx->buffer;
+	struct mount *m;
+	struct path root;
+
+	get_fs_root(current->fs, &root);
+
+	namespace_lock();
+
+	m = real_mount(path->mnt);
+
+	p->parent_id = m->mnt_parent->mnt_id;
+
+	if (path->mnt == root.mnt) {
+		p->parent_id = m->mnt_id;
+	} else {
+		rcu_read_lock();
+		if (!are_paths_connected(&root, path))
+			p->parent_id = m->mnt_id;
+		rcu_read_unlock();
+	}
+
+	if (IS_MNT_SHARED(m)) {
+		p->shared_group_id = m->mnt_group_id;
+		p->propagation_type |= MOUNT_PROPAGATION_SHARED;
+	} else if (IS_MNT_SLAVE(m)) {
+		int source = m->mnt_master->mnt_group_id;
+		int from = get_dominating_id(m, &root);
+		p->dependent_source_id = source;
+		if (from && from != source)
+			p->dependent_clone_of_id = from;
+		p->propagation_type |= MOUNT_PROPAGATION_DEPENDENT;
+	} else if (IS_MNT_UNBINDABLE(m)) {
+		p->propagation_type |= MOUNT_PROPAGATION_UNBINDABLE;
+	} else {
+		p->propagation_type |= MOUNT_PROPAGATION_PRIVATE;
+	}
+
+	namespace_unlock();
+	path_put(&root);
+	return sizeof(*p);
+}
+
 /*
  * Return the path of this mount relative to its parent and clipped to
  * the current chroot.
@@ -4379,4 +4427,50 @@ int fsinfo_generic_mount_point_full(struct path *path, struct fsinfo_context *ct
 	return (ctx->buffer + ctx->buf_size) - p;
 }
 
+/*
+ * Store a mount record into the fsinfo buffer.
+ */
+static void fsinfo_store_mount(struct fsinfo_context *ctx, const struct mount *p,
+			       bool is_root)
+{
+	struct fsinfo_mount_child record = {};
+	unsigned int usage = ctx->usage;
+
+	if (ctx->usage >= INT_MAX)
+		return;
+	ctx->usage = usage + sizeof(record);
+	if (!ctx->buffer || ctx->usage > ctx->buf_size)
+		return;
+
+	record.mnt_unique_id	= p->mnt_unique_id;
+	record.mnt_id		= p->mnt_id;
+	record.parent_id	= is_root ? p->mnt_id : p->mnt_parent->mnt_id;
+	memcpy(ctx->buffer + usage, &record, sizeof(record));
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
+		fsinfo_store_mount(ctx, child, false);
+	}
+
+	/* End the list with a copy of the parameter mount's details so that
+	 * userspace can quickly check for changes.
+	 */
+	fsinfo_store_mount(ctx, m, true);
+	read_sequnlock_excl(&mount_lock);
+	return ctx->usage;
+}
+
 #endif /* CONFIG_FSINFO */
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 15ef161905cd..f0a352b7028e 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -35,6 +35,8 @@
 #define FSINFO_ATTR_MOUNT_PATH		0x201	/* Bind mount/superblock path (string) */
 #define FSINFO_ATTR_MOUNT_POINT		0x202	/* Relative path of mount in parent (string) */
 #define FSINFO_ATTR_MOUNT_POINT_FULL	0x203	/* Absolute path of mount (string) */
+#define FSINFO_ATTR_MOUNT_TOPOLOGY	0x204	/* Mount object topology */
+#define FSINFO_ATTR_MOUNT_CHILDREN	0x205	/* Children of this mount (list) */
 
 /*
  * Optional fsinfo() parameter structure.
@@ -102,6 +104,31 @@ struct fsinfo_mount_info {
 
 #define FSINFO_ATTR_MOUNT_INFO__STRUCT struct fsinfo_mount_info
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_MOUNT_TOPOLOGY).
+ */
+struct fsinfo_mount_topology {
+	__u32	parent_id;		/* Parent mount identifier */
+	__u32	shared_group_id;	/* Shared: mount group ID */
+	__u32	dependent_source_id;	/* Dependent: source mount group ID */
+	__u32	dependent_clone_of_id;	/* Dependent: ID of mount this was cloned from */
+	__u32	propagation_type;	/* MOUNT_PROPAGATION_* type */
+};
+
+#define FSINFO_ATTR_MOUNT_TOPOLOGY__STRUCT struct fsinfo_mount_topology
+
+/*
+ * Information struct element for fsinfo(FSINFO_ATTR_MOUNT_CHILDREN).
+ * - An extra element is placed on the end representing the parent mount.
+ */
+struct fsinfo_mount_child {
+	__u64	mnt_unique_id;		/* Kernel-lifetime unique mount ID */
+	__u32	mnt_id;			/* Mount identifier (use with AT_FSINFO_MOUNTID_PATH) */
+	__u32	parent_id;		/* Parent mount identifier */
+};
+
+#define FSINFO_ATTR_MOUNT_CHILDREN__STRUCT struct fsinfo_mount_child
+
 /*
  * Information struct for fsinfo(FSINFO_ATTR_STATFS).
  * - This gives extended filesystem information.
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 96a0240f23fe..9ac8bb708843 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -105,7 +105,7 @@ enum fsconfig_command {
 #define FSMOUNT_CLOEXEC		0x00000001
 
 /*
- * Mount attributes.
+ * Mount object attributes (these are separate to filesystem attributes).
  */
 #define MOUNT_ATTR_RDONLY	0x00000001 /* Mount read-only */
 #define MOUNT_ATTR_NOSUID	0x00000002 /* Ignore suid and sgid bits */
@@ -117,4 +117,15 @@ enum fsconfig_command {
 #define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
 #define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
 
+/*
+ * Mount object propagation type.
+ */
+enum propagation_type {
+	/* 0 is left unallocated to mean "no change" in mount_setattr()  */
+	MOUNT_PROPAGATION_UNBINDABLE	= 1, /* Make unbindable. */
+	MOUNT_PROPAGATION_PRIVATE	= 2, /* Do not receive or send mount events. */
+	MOUNT_PROPAGATION_DEPENDENT	= 3, /* Only receive mount events. */
+	MOUNT_PROPAGATION_SHARED	= 4, /* Send and receive mount events. */
+};
+
 #endif /* _UAPI_LINUX_MOUNT_H */
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index f3bebb7318d9..b7290ea8eb55 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -21,6 +21,7 @@
 #include <sys/syscall.h>
 #include <linux/fsinfo.h>
 #include <linux/socket.h>
+#include <linux/mount.h>
 #include <sys/stat.h>
 #include <arpa/inet.h>
 
@@ -305,6 +306,58 @@ static void dump_fsinfo_generic_mount_info(void *reply, unsigned int size)
 	printf("\tattr    : %x\n", r->attr);
 }
 
+static void dump_fsinfo_generic_mount_topology(void *reply, unsigned int size)
+{
+	struct fsinfo_mount_topology *r = reply;
+
+	printf("\n");
+	printf("\tparent  : %x\n", r->parent_id);
+
+	switch (r->propagation_type) {
+	case MOUNT_PROPAGATION_UNBINDABLE:
+		printf("\tpropag  : unbindable\n");
+		break;
+	case MOUNT_PROPAGATION_PRIVATE:
+		printf("\tpropag  : private\n");
+		break;
+	case MOUNT_PROPAGATION_DEPENDENT:
+		printf("\tpropag  : dependent source=%x clone_of=%x\n",
+		       r->dependent_source_id, r->dependent_clone_of_id);
+		break;
+	case MOUNT_PROPAGATION_SHARED:
+		printf("\tpropag  : shared group=%x\n", r->shared_group_id);
+		break;
+	default:
+		printf("\tpropag  : unknown type %x\n", r->propagation_type);
+		break;
+	}
+
+}
+
+static void dump_fsinfo_generic_mount_children(void *reply, unsigned int size)
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
@@ -383,9 +436,11 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	fsinfo_meta_attributes),
 
 	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_INFO,	fsinfo_generic_mount_info),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_TOPOLOGY,	fsinfo_generic_mount_topology),
 	FSINFO_STRING	(FSINFO_ATTR_MOUNT_PATH,	string),
 	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT,	string),
 	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT_FULL,	string),
+	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_children),
 	{}
 };
 


