Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D61922C6C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 15:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgGXNhE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 09:37:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34612 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbgGXNhD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595597821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0m18DK1BQvP5OzWETtH5jp0KxfksI/bzYAI7MB9JPV8=;
        b=P4TdJhcSsf4uldq8J9IV2ZpZx9x/4ywFnSf5BqX2LgmOVNd9bQgemA2fl1EcI/QfXFM6tX
        FY9MzEUBFL94qC4d+8ym5NS364aIwuHNZN9KZJu8Pmdp2G1hmCdrCi949Yh4vmdstzZm6c
        IZEeb3ikOeLO8FqlGxXYOi234eBHhAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-VLaFfNjePN6F1MHja_AnEQ-1; Fri, 24 Jul 2020 09:36:59 -0400
X-MC-Unique: VLaFfNjePN6F1MHja_AnEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A599D800C64;
        Fri, 24 Jul 2020 13:36:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5894610013C4;
        Fri, 24 Jul 2020 13:36:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/17] fsinfo: Add an attribute that lists all the visible
 mounts in a namespace [ver #20]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Jul 2020 14:36:54 +0100
Message-ID: <159559781457.2144584.16532913492732387261.stgit@warthog.procyon.org.uk>
In-Reply-To: <159559768062.2144584.13583793543173131929.stgit@warthog.procyon.org.uk>
References: <159559768062.2144584.13583793543173131929.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a filesystem attribute that exports a list of all the visible mounts in
a namespace, given the caller's chroot setting.  The returned list is an
array of:

	struct fsinfo_mount_child {
		__u64	mnt_unique_id;
		__u32	mnt_id;
		__u32	parent_id;
		__u32	mnt_notify_sum;
		__u32	sb_notify_sum;
	};

where each element contains a once-in-a-system-lifetime unique ID, the
mount ID (which may get reused), the parent mount ID and sums of the
notification/change counters for the mount and its superblock.

This works with a read lock on the namespace_sem, but ideally would do it
under the RCU read lock only.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsinfo.c                 |    1 +
 fs/internal.h               |    1 +
 fs/namespace.c              |   37 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fsinfo.h |    4 ++++
 samples/vfs/test-fsinfo.c   |   22 ++++++++++++++++++++++
 5 files changed, 65 insertions(+)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index 0540cce89555..f230124ffdf5 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -296,6 +296,7 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_MOUNT_POINT,	fsinfo_generic_mount_point),
 	FSINFO_STRING	(FSINFO_ATTR_MOUNT_POINT_FULL,	fsinfo_generic_mount_point_full),
 	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_children),
+	FSINFO_LIST	(FSINFO_ATTR_MOUNT_ALL,		fsinfo_generic_mount_all),
 	{}
 };
 
diff --git a/fs/internal.h b/fs/internal.h
index cb5edcc7125a..267b4aaf0271 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -102,6 +102,7 @@ extern int fsinfo_generic_mount_topology(struct path *, struct fsinfo_context *)
 extern int fsinfo_generic_mount_point(struct path *, struct fsinfo_context *);
 extern int fsinfo_generic_mount_point_full(struct path *, struct fsinfo_context *);
 extern int fsinfo_generic_mount_children(struct path *, struct fsinfo_context *);
+extern int fsinfo_generic_mount_all(struct path *, struct fsinfo_context *);
 
 /*
  * fs_struct.c
diff --git a/fs/namespace.c b/fs/namespace.c
index 2205b1e52a41..7e2b66eb4f75 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4494,4 +4494,41 @@ int fsinfo_generic_mount_children(struct path *path, struct fsinfo_context *ctx)
 	return ctx->usage;
 }
 
+/*
+ * Return information about all the mounts in the namespace referenced by the
+ * path.
+ */
+int fsinfo_generic_mount_all(struct path *path, struct fsinfo_context *ctx)
+{
+	struct mnt_namespace *ns;
+	struct mount *m, *p;
+	struct path chroot;
+	bool allow;
+
+	m = real_mount(path->mnt);
+	ns = m->mnt_ns;
+
+	get_fs_root(current->fs, &chroot);
+	rcu_read_lock();
+	allow = are_paths_connected(&chroot, path) || capable(CAP_SYS_ADMIN);
+	rcu_read_unlock();
+	path_put(&chroot);
+	if (!allow)
+		return -EPERM;
+
+	down_read(&namespace_sem);
+
+	list_for_each_entry(p, &ns->list, mnt_list) {
+		struct path mnt_root;
+
+		mnt_root.mnt	= &p->mnt;
+		mnt_root.dentry	= p->mnt.mnt_root;
+		if (are_paths_connected(path, &mnt_root))
+			fsinfo_store_mount(ctx, p, p == m);
+	}
+
+	up_read(&namespace_sem);
+	return ctx->usage;
+}
+
 #endif /* CONFIG_FSINFO */
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index e53bb50a61e2..6f71d66d1112 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -37,6 +37,7 @@
 #define FSINFO_ATTR_MOUNT_POINT_FULL	0x203	/* Absolute path of mount (string) */
 #define FSINFO_ATTR_MOUNT_TOPOLOGY	0x204	/* Mount object topology */
 #define FSINFO_ATTR_MOUNT_CHILDREN	0x205	/* Children of this mount (list) */
+#define FSINFO_ATTR_MOUNT_ALL		0x206	/* List all mounts in a namespace (list) */
 
 #define FSINFO_ATTR_AFS_CELL_NAME	0x300	/* AFS cell name (string) */
 #define FSINFO_ATTR_AFS_SERVER_NAME	0x301	/* Name of the Nth server (string) */
@@ -129,6 +130,8 @@ struct fsinfo_mount_topology {
 /*
  * Information struct element for fsinfo(FSINFO_ATTR_MOUNT_CHILDREN).
  * - An extra element is placed on the end representing the parent mount.
+ *
+ * Information struct element for fsinfo(FSINFO_ATTR_MOUNT_ALL).
  */
 struct fsinfo_mount_child {
 	__u64	mnt_unique_id;		/* Kernel-lifetime unique mount ID */
@@ -140,6 +143,7 @@ struct fsinfo_mount_child {
 };
 
 #define FSINFO_ATTR_MOUNT_CHILDREN__STRUCT struct fsinfo_mount_child
+#define FSINFO_ATTR_MOUNT_ALL__STRUCT struct fsinfo_mount_child
 
 /*
  * Information struct for fsinfo(FSINFO_ATTR_STATFS).
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 462dae1d0423..5209b6a44fb0 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -363,6 +363,27 @@ static void dump_fsinfo_generic_mount_children(void *reply, unsigned int size)
 	       r->mnt_notify_sum, mp);
 }
 
+static void dump_fsinfo_generic_mount_all(void *reply, unsigned int size)
+{
+	struct fsinfo_mount_child *r = reply;
+	ssize_t mplen;
+	char path[32], *mp;
+
+	struct fsinfo_params params = {
+		.flags		= FSINFO_FLAGS_QUERY_MOUNT,
+		.request	= FSINFO_ATTR_MOUNT_POINT_FULL,
+	};
+
+	sprintf(path, "%u", r->mnt_id);
+	mplen = get_fsinfo(path, "FSINFO_ATTR_MOUNT_POINT_FULL", &params, (void **)&mp);
+	if (mplen < 0)
+		mp = "-";
+
+	printf("%5x %5x %12llx %10u %s\n",
+	       r->mnt_id, r->parent_id, (unsigned long long)r->mnt_unique_id,
+	       r->mnt_notify_sum, mp);
+}
+
 static void dump_afs_fsinfo_server_address(void *reply, unsigned int size)
 {
 	struct fsinfo_afs_server_address *f = reply;
@@ -490,6 +511,7 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT,	string),
 	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT_FULL,	string),
 	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_children),
+	FSINFO_LIST	(FSINFO_ATTR_MOUNT_ALL,		fsinfo_generic_mount_all),
 
 	FSINFO_STRING	(FSINFO_ATTR_AFS_CELL_NAME,	string),
 	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	string),


