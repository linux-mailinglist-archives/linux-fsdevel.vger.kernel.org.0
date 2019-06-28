Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E8159F34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfF1PpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:45:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfF1PpJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:45:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7883B30BB523;
        Fri, 28 Jun 2019 15:45:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D330226E64;
        Fri, 28 Jun 2019 15:45:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/11] afs: Support fsinfo() [ver #15]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:45:02 +0100
Message-ID: <156173670210.14042.7296305860822953053.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
References: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 28 Jun 2019 15:45:08 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add fsinfo support to the AFS filesystem.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h           |    1 
 fs/afs/super.c              |  180 +++++++++++++++++++++++++++++++++++++++++++
 fs/fsinfo.c                 |    3 +
 include/uapi/linux/fsinfo.h |   12 +++
 samples/vfs/test-fsinfo.c   |   33 ++++++++
 5 files changed, 227 insertions(+), 2 deletions(-)

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
index f18911e8d770..d6c9742c0165 100644
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
@@ -765,3 +774,170 @@ static int afs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	return ret;
 }
+
+#ifdef CONFIG_FSINFO
+static const struct fsinfo_timestamp_info afs_timestamp_info = {
+	.atime = {
+		.minimum	= 0,
+		.maximum	= UINT_MAX,
+		.gran_mantissa	= 1,
+		.gran_exponent	= 0,
+	},
+	.mtime = {
+		.minimum	= 0,
+		.maximum	= UINT_MAX,
+		.gran_mantissa	= 1,
+		.gran_exponent	= 0,
+	},
+	.ctime = {
+		.minimum	= 0,
+		.maximum	= UINT_MAX,
+		.gran_mantissa	= 1,
+		.gran_exponent	= 0,
+	},
+	.btime = {
+		.minimum	= 0,
+		.maximum	= UINT_MAX,
+		.gran_mantissa	= 1,
+		.gran_exponent	= 0,
+	},
+};
+
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
+		*tsinfo = afs_timestamp_info;
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
+	case FSINFO_ATTR_AFS_CELL_NAME:
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
+		fsinfo_note_sb_params(params, dentry->d_sb->s_flags);
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
index 45bfb10eb8d9..b3f605c39eb5 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -582,6 +582,9 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
 	FSINFO_OPAQUE		(PARAMETERS),
 	FSINFO_OPAQUE		(LSM_PARAMETERS),
+	FSINFO_STRING_N		(SERVER_NAME),
+	FSINFO_STRUCT_NM	(SERVER_ADDRESS,	server_address),
+	FSINFO_STRING		(AFS_CELL_NAME),
 };
 
 /**
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 0d57d37311fc..58a50207256f 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -32,6 +32,9 @@ enum fsinfo_attribute {
 	FSINFO_ATTR_PARAM_ENUM		= 14,	/* Nth enum-to-val */
 	FSINFO_ATTR_PARAMETERS		= 15,	/* Mount parameters (large string) */
 	FSINFO_ATTR_LSM_PARAMETERS	= 16,	/* LSM Mount parameters (large string) */
+	FSINFO_ATTR_SERVER_NAME		= 17,	/* Name of the Nth server (string) */
+	FSINFO_ATTR_SERVER_ADDRESS	= 18,	/* Mth address of the Nth server */
+	FSINFO_ATTR_AFS_CELL_NAME	= 19,	/* AFS cell name (string) */
 	FSINFO_ATTR__NR
 };
 
@@ -276,4 +279,13 @@ struct fsinfo_param_enum {
 	char		name[252];	/* Name of the enum value */
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
index f865bc1af16f..6389ae781cbb 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -83,6 +83,9 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
 	FSINFO_OVERLARGE	(PARAMETERS,		-),
 	FSINFO_OVERLARGE	(LSM_PARAMETERS,	-),
+	FSINFO_STRING_N		(SERVER_NAME,		server_name),
+	FSINFO_STRUCT_NM	(SERVER_ADDRESS,	server_address),
+	FSINFO_STRING		(AFS_CELL_NAME,		-),
 };
 
 #define FSINFO_NAME(X,Y) [FSINFO_ATTR_##X] = #Y
@@ -104,6 +107,9 @@ static const char *fsinfo_attr_names[FSINFO_ATTR__NR] = {
 	FSINFO_NAME		(PARAM_ENUM,		param_enum),
 	FSINFO_NAME		(PARAMETERS,		parameters),
 	FSINFO_NAME		(LSM_PARAMETERS,	lsm_parameters),
+	FSINFO_NAME		(SERVER_NAME,		server_name),
+	FSINFO_NAME		(SERVER_ADDRESS,	server_address),
+	FSINFO_NAME		(AFS_CELL_NAME,		afs_cell_name),
 };
 
 union reply {
@@ -116,6 +122,7 @@ union reply {
 	struct fsinfo_capabilities caps;
 	struct fsinfo_timestamp_info timestamps;
 	struct fsinfo_volume_uuid uuid;
+	struct fsinfo_server_address srv_addr;
 };
 
 static void dump_hex(unsigned int *data, int from, int to)
@@ -318,6 +325,31 @@ static void dump_attr_VOLUME_UUID(union reply *r, int size)
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
 /*
  *
  */
@@ -333,6 +365,7 @@ static const dumper_t fsinfo_attr_dumper[FSINFO_ATTR__NR] = {
 	FSINFO_DUMPER(CAPABILITIES),
 	FSINFO_DUMPER(TIMESTAMP_INFO),
 	FSINFO_DUMPER(VOLUME_UUID),
+	FSINFO_DUMPER(SERVER_ADDRESS),
 };
 
 static void dump_fsinfo(enum fsinfo_attribute attr,

