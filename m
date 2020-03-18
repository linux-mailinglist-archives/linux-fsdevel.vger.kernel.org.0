Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7EB3189F46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 16:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgCRPJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 11:09:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58670 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbgCRPJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584544157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yr7RBrGsnvqBeiyEVsEzFF2CR35CcmggYDXS0ISiK8=;
        b=FO0EFYbIh9tnO3iGGHCWx5P+694Pq65OOPwZiryHFQtvSeoZdUsNtek8UtZVu0aghTkxmR
        oY91hMpTzEYteLfHC7LkhkrRFKRlYc3pB+S7w2HaG+vCObK1nrmyzxw7yOvCjXJceFnVZl
        D8xrsNzVLYmNFTJQKvqzN0V2I7Ln0/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-WfqCMQwoMgOqMrCPC0lbBg-1; Wed, 18 Mar 2020 11:09:15 -0400
X-MC-Unique: WfqCMQwoMgOqMrCPC0lbBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 529C91083E83;
        Wed, 18 Mar 2020 15:09:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A18BE60BEC;
        Wed, 18 Mar 2020 15:09:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/13] fsinfo: Allow mount topology and propagation info to be
 retrieved [ver #19]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Mar 2020 15:09:10 +0000
Message-ID: <158454415081.2864823.16161601504717586678.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
References: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
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
 fs/namespace.c              |   91 +++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fsinfo.h |   27 +++++++++++++
 include/uapi/linux/mount.h  |   10 ++++-
 samples/vfs/test-fsinfo.c   |   38 ++++++++++++++++++
 6 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index a08b172f71d2..eccea3b1579a 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -280,9 +280,11 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
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
index 68e300a1e9a3..6a30320ea2f8 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -100,8 +100,10 @@ extern void dissolve_on_fput(struct vfsmount *);
 extern int lookup_mount_object(struct path *, int, struct path *);
 extern int fsinfo_generic_mount_source(struct path *, struct fsinfo_context *);
 extern int fsinfo_generic_mount_info(struct path *, struct fsinfo_context *);
+extern int fsinfo_generic_mount_topology(struct path *, struct fsinfo_context *);
 extern int fsinfo_generic_mount_point(struct path *, struct fsinfo_context *);
 extern int fsinfo_generic_mount_point_full(struct path *, struct fsinfo_context *);
+extern int fsinfo_generic_mount_children(struct path *, struct fsinfo_context *);
 
 /*
  * fs_struct.c
diff --git a/fs/namespace.c b/fs/namespace.c
index 483fbbde5c28..61b110149fc5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4187,6 +4187,53 @@ int fsinfo_generic_mount_info(struct path *path, struct fsinfo_context *ctx)
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
+		p->group_id = m->mnt_group_id;
+		p->propagation |= MOUNT_PROPAGATION_SHARED;
+	}
+	if (IS_MNT_SLAVE(m)) {
+		int master = m->mnt_master->mnt_group_id;
+		int dom = get_dominating_id(m, &root);
+		p->master_id = master;
+		if (dom && dom != master)
+			p->from_id = dom;
+		p->propagation |= MOUNT_PROPAGATION_SLAVE;
+	}
+	if (IS_MNT_UNBINDABLE(m))
+		p->propagation |= MOUNT_PROPAGATION_UNBINDABLE;
+
+	namespace_unlock();
+	path_put(&root);
+	return sizeof(*p);
+}
+
 /*
  * Return the path of this mount relative to its parent and clipped to
  * the current chroot.
@@ -4260,4 +4307,48 @@ int fsinfo_generic_mount_point_full(struct path *path, struct fsinfo_context *ct
 	return (ctx->buffer + ctx->buf_size) - p;
 }
 
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
index df96301dc612..9410e320d824 100644
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
+	__u32	group_id;		/* Mount group ID */
+	__u32	master_id;		/* Slave master group ID */
+	__u32	from_id;		/* Slave propagated from ID */
+	__u32	propagation;		/* MOUNT_PROPAGATION_* flags */
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
+	__u32	__padding[1];
+};
+
+#define FSINFO_ATTR_MOUNT_CHILDREN__STRUCT struct fsinfo_mount_child
+
 /*
  * Information struct for fsinfo(FSINFO_ATTR_STATFS).
  * - This gives extended filesystem information.
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 96a0240f23fe..c18b21de3fdd 100644
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
@@ -117,4 +117,12 @@ enum fsconfig_command {
 #define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
 #define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
 
+/*
+ * Mount object propagation attributes.
+ */
+#define MOUNT_PROPAGATION_UNBINDABLE	0x00000001 /* Mount is unbindable */
+#define MOUNT_PROPAGATION_SLAVE		0x00000002 /* Mount is slave */
+#define MOUNT_PROPAGATION_PRIVATE	0x00000000 /* Mount is private (ie. not shared) */
+#define MOUNT_PROPAGATION_SHARED	0x00000004 /* Mount is shared */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index b23d0d56988f..762ab4517cd9 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -299,6 +299,42 @@ static void dump_fsinfo_generic_mount_info(void *reply, unsigned int size)
 	printf("\tattr    : %x\n", r->attr);
 }
 
+static void dump_fsinfo_generic_mount_topology(void *reply, unsigned int size)
+{
+	struct fsinfo_mount_topology *r = reply;
+
+	printf("\n");
+	printf("\tparent  : %x\n", r->parent_id);
+	printf("\tgroup   : %x\n", r->group_id);
+	printf("\tmaster  : %x\n", r->master_id);
+	printf("\tfrom    : %x\n", r->from_id);
+	printf("\tpropag  : %x\n", r->propagation);
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
@@ -377,9 +413,11 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	fsinfo_meta_attributes),
 
 	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_INFO,	fsinfo_generic_mount_info),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_MOUNT_TOPOLOGY,	fsinfo_generic_mount_topology),
 	FSINFO_STRING	(FSINFO_ATTR_MOUNT_PATH,	string),
 	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT,	string),
 	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT_FULL,	string),
+	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_children),
 	{}
 };
 


