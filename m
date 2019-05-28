Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E9B2C9F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfE1PNT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 11:13:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbfE1PNT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 11:13:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6B4330BC100;
        Tue, 28 May 2019 15:13:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F39252D1B1;
        Tue, 28 May 2019 15:13:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/25] afs: Support fsinfo() [ver #13]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Tue, 28 May 2019 16:13:11 +0100
Message-ID: <155905639137.1662.16805896138242925406.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 28 May 2019 15:13:18 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add fsinfo support to the AFS filesystem.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h           |    1 
 fs/afs/super.c              |  155 ++++++++++++++++++++++++++++++++++++++++++-
 fs/fsinfo.c                 |    3 +
 include/uapi/linux/fsinfo.h |   12 +++
 samples/vfs/test-fsinfo.c   |   33 +++++++++
 5 files changed, 202 insertions(+), 2 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 2073c1a3ab4b..da40ea036c6a 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -254,6 +254,7 @@ struct afs_super_info {
 	struct afs_volume	*volume;	/* volume record */
 	enum afs_flock_mode	flock_mode:8;	/* File locking emulation mode */
 	bool			dyn_root;	/* True if dynamic root */
+	bool			autocell;	/* True if autocell */
 };
 
 static inline struct afs_super_info *AFS_FS_S(struct super_block *sb)
diff --git a/fs/afs/super.c b/fs/afs/super.c
index f18911e8d770..2b1f37aa1b37 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -26,6 +26,7 @@
 #include <linux/sched.h>
 #include <linux/nsproxy.h>
 #include <linux/magic.h>
+#include <linux/fsinfo.h>
 #include <net/net_namespace.h>
 #include "internal.h"
 
@@ -35,6 +36,9 @@ static struct inode *afs_alloc_inode(struct super_block *sb);
 static void afs_destroy_inode(struct inode *inode);
 static void afs_free_inode(struct inode *inode);
 static int afs_statfs(struct dentry *dentry, struct kstatfs *buf);
+#ifdef CONFIG_FSINFO
+static int afs_fsinfo(struct path *path, struct fsinfo_kparams *params);
+#endif
 static int afs_show_devname(struct seq_file *m, struct dentry *root);
 static int afs_show_options(struct seq_file *m, struct dentry *root);
 static int afs_init_fs_context(struct fs_context *fc);
@@ -54,6 +58,9 @@ int afs_net_id;
 
 static const struct super_operations afs_super_ops = {
 	.statfs		= afs_statfs,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= afs_fsinfo,
+#endif
 	.alloc_inode	= afs_alloc_inode,
 	.drop_inode	= afs_drop_inode,
 	.destroy_inode	= afs_destroy_inode,
@@ -199,7 +206,7 @@ static int afs_show_options(struct seq_file *m, struct dentry *root)
 
 	if (as->dyn_root)
 		seq_puts(m, ",dyn");
-	if (test_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(d_inode(root))->flags))
+	if (as->autocell)
 		seq_puts(m, ",autocell");
 	switch (as->flock_mode) {
 	case afs_flock_mode_unset:	break;
@@ -463,7 +470,7 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	if (ctx->autocell || as->dyn_root)
+	if (as->autocell || as->dyn_root)
 		set_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(inode)->flags);
 
 	ret = -ENOMEM;
@@ -503,6 +510,8 @@ static struct afs_super_info *afs_alloc_sbi(struct fs_context *fc)
 			as->cell = afs_get_cell(ctx->cell);
 			as->volume = __afs_get_volume(ctx->volume);
 		}
+		if (ctx->autocell)
+			as->autocell = true;
 	}
 	return as;
 }
@@ -765,3 +774,145 @@ static int afs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	return ret;
 }
+
+#ifdef CONFIG_FSINFO
+/*
+ * Get filesystem information.
+ */
+static int afs_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct fsinfo_timestamp_info *tsinfo;
+	struct fsinfo_server_address *addr;
+	struct fsinfo_capabilities *caps;
+	struct fsinfo_supports *sup;
+	struct dentry *dentry = path->dentry;
+	struct afs_server_list *slist;
+	struct afs_super_info *as = AFS_FS_S(dentry->d_sb);
+	struct afs_addr_list *alist;
+	struct afs_server *server;
+	struct afs_volume *volume = as->volume;
+	struct afs_cell *cell = as->cell;
+	struct afs_net *net = afs_d2net(dentry);
+	bool dyn_root = as->dyn_root;
+	int ret;
+
+	switch (params->request) {
+	case FSINFO_ATTR_TIMESTAMP_INFO:
+		tsinfo = params->buffer;
+		tsinfo->minimum_timestamp = 0;
+		tsinfo->maximum_timestamp = UINT_MAX;
+		tsinfo->mtime_gran_mantissa = 1;
+		tsinfo->mtime_gran_exponent = 0;
+		return sizeof(*tsinfo);
+
+	case FSINFO_ATTR_SUPPORTS:
+		sup = params->buffer;
+		sup->stx_mask = (STATX_TYPE | STATX_MODE |
+				 STATX_NLINK |
+				 STATX_UID | STATX_GID |
+				 STATX_MTIME | STATX_INO |
+				 STATX_SIZE);
+		sup->stx_attributes = STATX_ATTR_AUTOMOUNT;
+		return sizeof(*sup);
+
+	case FSINFO_ATTR_CAPABILITIES:
+		caps = params->buffer;
+		if (dyn_root) {
+			fsinfo_set_cap(caps, FSINFO_CAP_IS_AUTOMOUNTER_FS);
+			fsinfo_set_cap(caps, FSINFO_CAP_AUTOMOUNTS);
+		} else {
+			fsinfo_set_cap(caps, FSINFO_CAP_IS_NETWORK_FS);
+			fsinfo_set_cap(caps, FSINFO_CAP_AUTOMOUNTS);
+			fsinfo_set_cap(caps, FSINFO_CAP_ADV_LOCKS);
+			fsinfo_set_cap(caps, FSINFO_CAP_UIDS);
+			fsinfo_set_cap(caps, FSINFO_CAP_GIDS);
+			fsinfo_set_cap(caps, FSINFO_CAP_VOLUME_ID);
+			fsinfo_set_cap(caps, FSINFO_CAP_VOLUME_NAME);
+			fsinfo_set_cap(caps, FSINFO_CAP_IVER_MONO_INCR);
+			fsinfo_set_cap(caps, FSINFO_CAP_SYMLINKS);
+			fsinfo_set_cap(caps, FSINFO_CAP_HARD_LINKS_1DIR);
+			fsinfo_set_cap(caps, FSINFO_CAP_HAS_MTIME);
+		}
+		return sizeof(*caps);
+
+	case FSINFO_ATTR_VOLUME_NAME:
+		if (dyn_root)
+			return -EOPNOTSUPP;
+		memcpy(params->buffer, volume->name, volume->name_len);
+		return volume->name_len;
+
+	case FSINFO_ATTR_CELL_NAME:
+		if (dyn_root)
+			return -EOPNOTSUPP;
+		memcpy(params->buffer, cell->name, cell->name_len);
+		return cell->name_len;
+
+	case FSINFO_ATTR_SERVER_NAME:
+		if (dyn_root)
+			return -EOPNOTSUPP;
+		read_lock(&volume->servers_lock);
+		slist = afs_get_serverlist(volume->servers);
+		read_unlock(&volume->servers_lock);
+
+		if (params->Nth < slist->nr_servers) {
+			server = slist->servers[params->Nth].server;
+			ret = sprintf(params->buffer, "%pU", &server->uuid);
+		} else {
+			ret = -ENODATA;
+		}
+
+		afs_put_serverlist(net, slist);
+		return ret;
+
+	case FSINFO_ATTR_SERVER_ADDRESS:
+		addr = params->buffer;
+		if (dyn_root)
+			return -EOPNOTSUPP;
+		read_lock(&volume->servers_lock);
+		slist = afs_get_serverlist(volume->servers);
+		read_unlock(&volume->servers_lock);
+
+		ret = -ENODATA;
+		if (params->Nth >= slist->nr_servers)
+			goto put_slist;
+		server = slist->servers[params->Nth].server;
+
+		read_lock(&server->fs_lock);
+		alist = afs_get_addrlist(rcu_access_pointer(server->addresses));
+		read_unlock(&server->fs_lock);
+		if (!alist)
+			goto put_slist;
+
+		if (params->Mth >= alist->nr_addrs)
+			goto put_alist;
+
+		memcpy(addr, &alist->addrs[params->Mth],
+		       sizeof(struct sockaddr_rxrpc));
+		ret = sizeof(*addr);
+
+	put_alist:
+		afs_put_addrlist(alist);
+	put_slist:
+		afs_put_serverlist(net, slist);
+		return ret;
+
+	case FSINFO_ATTR_PARAMETERS:
+		if (!dyn_root)
+			fsinfo_note_paramf(params, "source", "%c%s:%s%s",
+					   volume->type == AFSVL_RWVOL ? '%' : '#',
+					   cell->name,
+					   volume->name,
+					   volume->type == AFSVL_RWVOL ? "" :
+					   volume->type == AFSVL_ROVOL ? ".readonly" :
+					   ".backup");
+		if (as->autocell)
+			fsinfo_note_param(params, "autocell", NULL);
+		if (dyn_root)
+			fsinfo_note_param(params, "dyn", NULL);
+		return params->usage;
+
+	default:
+		return generic_fsinfo(path, params);
+	}
+}
+#endif /* CONFIG_FSINFO */
diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index b9f8712907dc..3ec64d3cba08 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -603,6 +603,9 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRING		(MOUNT_DEVNAME,		mount_devname),
 	FSINFO_STRUCT_ARRAY	(MOUNT_CHILDREN,	mount_child),
 	FSINFO_STRING_N		(MOUNT_SUBMOUNT,	mount_submount),
+	FSINFO_STRING_N		(SERVER_NAME,		server_name),
+	FSINFO_STRUCT_NM	(SERVER_ADDRESS,	server_address),
+	FSINFO_STRING		(CELL_NAME,		cell_name),
 };
 
 /**
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 7f7a75e9758a..7247088332c2 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -36,6 +36,9 @@ enum fsinfo_attribute {
 	FSINFO_ATTR_MOUNT_DEVNAME	= 18,	/* Mount object device name (string) */
 	FSINFO_ATTR_MOUNT_CHILDREN	= 19,	/* Submount list (array) */
 	FSINFO_ATTR_MOUNT_SUBMOUNT	= 20,	/* Relative path of Nth submount (string) */
+	FSINFO_ATTR_SERVER_NAME		= 21,	/* Name of the Nth server (string) */
+	FSINFO_ATTR_SERVER_ADDRESS	= 22,	/* Mth address of the Nth server */
+	FSINFO_ATTR_CELL_NAME		= 23,	/* Cell name (string) */
 	FSINFO_ATTR__NR
 };
 
@@ -296,4 +299,13 @@ struct fsinfo_mount_child {
 	__u32		notify_counter;	/* Number of notifications generated on mount. */
 };
 
+/*
+ * Information struct for fsinfo(fsinfo_attr_server_addresses).
+ *
+ * Find the Mth address of the Nth server for a network mount.
+ */
+struct fsinfo_server_address {
+	struct __kernel_sockaddr_storage address;
+};
+
 #endif /* _UAPI_LINUX_FSINFO_H */
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index a838adcdca9e..af29da74559e 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -87,6 +87,9 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRING		(MOUNT_DEVNAME,		mount_devname),
 	FSINFO_STRUCT_ARRAY	(MOUNT_CHILDREN,	mount_child),
 	FSINFO_STRING_N		(MOUNT_SUBMOUNT,	mount_submount),
+	FSINFO_STRING_N		(SERVER_NAME,		server_name),
+	FSINFO_STRUCT_NM	(SERVER_ADDRESS,	server_address),
+	FSINFO_STRING		(CELL_NAME,		cell_name),
 };
 
 #define FSINFO_NAME(X,Y) [FSINFO_ATTR_##X] = #Y
@@ -112,6 +115,9 @@ static const char *fsinfo_attr_names[FSINFO_ATTR__NR] = {
 	FSINFO_NAME		(MOUNT_DEVNAME,		mount_devname),
 	FSINFO_NAME		(MOUNT_CHILDREN,	mount_children),
 	FSINFO_NAME		(MOUNT_SUBMOUNT,	mount_submount),
+	FSINFO_NAME		(SERVER_NAME,		server_name),
+	FSINFO_NAME		(SERVER_ADDRESS,	server_address),
+	FSINFO_NAME		(CELL_NAME,		cell_name),
 };
 
 union reply {
@@ -126,6 +132,7 @@ union reply {
 	struct fsinfo_volume_uuid uuid;
 	struct fsinfo_mount_info mount_info;
 	struct fsinfo_mount_child mount_children[1];
+	struct fsinfo_server_address srv_addr;
 };
 
 static void dump_hex(unsigned int *data, int from, int to)
@@ -322,6 +329,31 @@ static void dump_attr_VOLUME_UUID(union reply *r, int size)
 	       f->uuid[14], f->uuid[15]);
 }
 
+static void dump_attr_SERVER_ADDRESS(union reply *r, int size)
+{
+	struct fsinfo_server_address *f = &r->srv_addr;
+	struct sockaddr_in6 *sin6;
+	struct sockaddr_in *sin;
+	char buf[1024];
+
+	switch (f->address.ss_family) {
+	case AF_INET:
+		sin = (struct sockaddr_in *)&f->address;
+		if (!inet_ntop(AF_INET, &sin->sin_addr, buf, sizeof(buf)))
+			break;
+		printf("IPv4: %s\n", buf);
+		return;
+	case AF_INET6:
+		sin6 = (struct sockaddr_in6 *)&f->address;
+		if (!inet_ntop(AF_INET6, &sin6->sin6_addr, buf, sizeof(buf)))
+			break;
+		printf("IPv6: %s\n", buf);
+		return;
+	}
+
+	printf("family=%u\n", f->address.ss_family);
+}
+
 static void dump_attr_MOUNT_INFO(union reply *r, int size)
 {
 	struct fsinfo_mount_info *f = &r->mount_info;
@@ -362,6 +394,7 @@ static const dumper_t fsinfo_attr_dumper[FSINFO_ATTR__NR] = {
 	FSINFO_DUMPER(VOLUME_UUID),
 	FSINFO_DUMPER(MOUNT_INFO),
 	FSINFO_DUMPER(MOUNT_CHILDREN),
+	FSINFO_DUMPER(SERVER_ADDRESS),
 };
 
 static void dump_fsinfo(enum fsinfo_attribute attr,

