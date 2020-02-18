Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD6C162B6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 18:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgBRRGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 12:06:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55383 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726556AbgBRRG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582045587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C5FXYmEGRSxaAFJZXip91MbP49g44hDbt/lqD+LbF98=;
        b=hlp8RoPPnQgDqY/kBLRm6WBRDGWTKUOoBCXQBuKlgA2HbEQOIuPc0M+FHtrzN8hV0eA7cO
        258RwzTPzYqWUEq98rOITPyO/qSISu290hyLyN+Q+GXfTtzPeuRUu8yFAeY6R3Iff4VUL1
        RmPHwqkt+mMn9RragMAYpIzfyy9E5A4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-u41oLHYIPSWR76dFrpjPmA-1; Tue, 18 Feb 2020 12:06:25 -0500
X-MC-Unique: u41oLHYIPSWR76dFrpjPmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B08058017DF;
        Tue, 18 Feb 2020 17:06:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4AA590089;
        Tue, 18 Feb 2020 17:06:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/19] afs: Support fsinfo() [ver #16]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 17:06:21 +0000
Message-ID: <158204558110.3299825.5080605285325995873.stgit@warthog.procyon.org.uk>
In-Reply-To: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add fsinfo support to the AFS filesystem.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h           |    1 
 fs/afs/super.c              |  229 ++++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/fsinfo.h |   15 +++
 samples/vfs/test-fsinfo.c   |   51 ++++++++++
 4 files changed, 291 insertions(+), 5 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 1d81fc4c3058..b4b2a8a18e9f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -248,6 +248,7 @@ struct afs_super_info {
 	struct afs_volume	*volume;	/* volume record */
 	enum afs_flock_mode	flock_mode:8;	/* File locking emulation mode */
 	bool			dyn_root;	/* True if dynamic root */
+	bool			autocell;	/* True if autocell */
 };
 
 static inline struct afs_super_info *AFS_FS_S(struct super_block *sb)
diff --git a/fs/afs/super.c b/fs/afs/super.c
index dda7a9a66848..e13167a9a2f8 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -26,9 +26,14 @@
 #include <linux/sched.h>
 #include <linux/nsproxy.h>
 #include <linux/magic.h>
+#include <linux/fsinfo.h>
 #include <net/net_namespace.h>
 #include "internal.h"
 
+#ifdef CONFIG_FSINFO
+static const struct fsinfo_attribute afs_fsinfo_attributes[];
+static const struct fsinfo_attribute afs_dyn_fsinfo_attributes[];
+#endif
 static void afs_i_init_once(void *foo);
 static void afs_kill_super(struct super_block *sb);
 static struct inode *afs_alloc_inode(struct super_block *sb);
@@ -54,6 +59,23 @@ int afs_net_id;
 
 static const struct super_operations afs_super_ops = {
 	.statfs		= afs_statfs,
+#ifdef CONFIG_FSINFO
+	.fsinfo_attributes = afs_fsinfo_attributes,
+#endif
+	.alloc_inode	= afs_alloc_inode,
+	.drop_inode	= afs_drop_inode,
+	.destroy_inode	= afs_destroy_inode,
+	.free_inode	= afs_free_inode,
+	.evict_inode	= afs_evict_inode,
+	.show_devname	= afs_show_devname,
+	.show_options	= afs_show_options,
+};
+
+static const struct super_operations afs_dyn_super_ops = {
+	.statfs		= afs_statfs,
+#ifdef CONFIG_FSINFO
+	.fsinfo_attributes = afs_dyn_fsinfo_attributes,
+#endif
 	.alloc_inode	= afs_alloc_inode,
 	.drop_inode	= afs_drop_inode,
 	.destroy_inode	= afs_destroy_inode,
@@ -193,7 +215,7 @@ static int afs_show_options(struct seq_file *m, struct dentry *root)
 
 	if (as->dyn_root)
 		seq_puts(m, ",dyn");
-	if (test_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(d_inode(root))->flags))
+	if (as->autocell)
 		seq_puts(m, ",autocell");
 	switch (as->flock_mode) {
 	case afs_flock_mode_unset:	break;
@@ -432,9 +454,12 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 	sb->s_blocksize_bits	= PAGE_SHIFT;
 	sb->s_maxbytes		= MAX_LFS_FILESIZE;
 	sb->s_magic		= AFS_FS_MAGIC;
-	sb->s_op		= &afs_super_ops;
-	if (!as->dyn_root)
+	if (!as->dyn_root) {
+		sb->s_op	= &afs_super_ops;
 		sb->s_xattr	= afs_xattr_handlers;
+	} else {
+		sb->s_op	= &afs_dyn_super_ops;
+	}
 	ret = super_setup_bdi(sb);
 	if (ret)
 		return ret;
@@ -444,7 +469,7 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 	if (as->dyn_root) {
 		inode = afs_iget_pseudo_dir(sb, true);
 	} else {
-		sprintf(sb->s_id, "%llu", as->volume->vid);
+		sprintf(sb->s_id, "%llx", as->volume->vid);
 		afs_activate_volume(as->volume);
 		iget_data.fid.vid	= as->volume->vid;
 		iget_data.fid.vnode	= 1;
@@ -458,7 +483,7 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	if (ctx->autocell || as->dyn_root)
+	if (as->autocell || as->dyn_root)
 		set_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(inode)->flags);
 
 	ret = -ENOMEM;
@@ -498,6 +523,8 @@ static struct afs_super_info *afs_alloc_sbi(struct fs_context *fc)
 			as->cell = afs_get_cell(ctx->cell);
 			as->volume = __afs_get_volume(ctx->volume);
 		}
+		if (ctx->autocell)
+			as->autocell = true;
 	}
 	return as;
 }
@@ -760,3 +787,195 @@ static int afs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
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
+static int afs_fsinfo_get_timestamp(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_timestamp_info *tsinfo = ctx->buffer;
+	*tsinfo = afs_timestamp_info;
+	return sizeof(*tsinfo);
+}
+
+static int afs_fsinfo_get_limits(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_limits *lim = ctx->buffer;
+
+	lim->max_file_size.hi	= 0;
+	lim->max_file_size.lo	= MAX_LFS_FILESIZE;
+	/* Inode numbers can be 96-bit on YFS, but that's hard to determine. */
+	lim->max_ino.hi		= 0;
+	lim->max_ino.lo		= UINT_MAX;
+	lim->max_hard_links	= UINT_MAX;
+	lim->max_uid		= UINT_MAX;
+	lim->max_gid		= UINT_MAX;
+	lim->max_filename_len	= AFSNAMEMAX - 1;
+	lim->max_symlink_len	= AFSPATHMAX - 1;
+	return sizeof(*lim);
+}
+
+static int afs_fsinfo_get_supports(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_supports *sup = ctx->buffer;
+
+	sup = ctx->buffer;
+	sup->stx_mask = (STATX_TYPE | STATX_MODE |
+			 STATX_NLINK |
+			 STATX_UID | STATX_GID |
+			 STATX_MTIME | STATX_INO |
+			 STATX_SIZE);
+	sup->stx_attributes = STATX_ATTR_AUTOMOUNT;
+	return sizeof(*sup);
+}
+
+static int afs_fsinfo_get_features(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_features *ft = ctx->buffer;
+
+	fsinfo_set_feature(ft, FSINFO_FEAT_IS_NETWORK_FS);
+	fsinfo_set_feature(ft, FSINFO_FEAT_AUTOMOUNTS);
+	fsinfo_set_feature(ft, FSINFO_FEAT_ADV_LOCKS);
+	fsinfo_set_feature(ft, FSINFO_FEAT_UIDS);
+	fsinfo_set_feature(ft, FSINFO_FEAT_GIDS);
+	fsinfo_set_feature(ft, FSINFO_FEAT_VOLUME_ID);
+	fsinfo_set_feature(ft, FSINFO_FEAT_VOLUME_NAME);
+	fsinfo_set_feature(ft, FSINFO_FEAT_IVER_MONO_INCR);
+	fsinfo_set_feature(ft, FSINFO_FEAT_SYMLINKS);
+	fsinfo_set_feature(ft, FSINFO_FEAT_HARD_LINKS_1DIR);
+	fsinfo_set_feature(ft, FSINFO_FEAT_HAS_MTIME);
+	fsinfo_set_feature(ft, FSINFO_FEAT_HAS_INODE_NUMBERS);
+	return sizeof(*ft);
+}
+
+static int afs_dyn_fsinfo_get_features(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_features *ft = ctx->buffer;
+
+	fsinfo_set_feature(ft, FSINFO_FEAT_IS_AUTOMOUNTER_FS);
+	fsinfo_set_feature(ft, FSINFO_FEAT_AUTOMOUNTS);
+	return sizeof(*ft);
+}
+
+static int afs_fsinfo_get_volume_name(struct path *path, struct fsinfo_context *ctx)
+{
+	struct afs_super_info *as = AFS_FS_S(path->dentry->d_sb);
+	struct afs_volume *volume = as->volume;
+
+	memcpy(ctx->buffer, volume->name, volume->name_len);
+	return volume->name_len;
+}
+
+static int afs_fsinfo_get_cell_name(struct path *path, struct fsinfo_context *ctx)
+{
+	struct afs_super_info *as = AFS_FS_S(path->dentry->d_sb);
+	struct afs_cell *cell = as->cell;
+
+	memcpy(ctx->buffer, cell->name, cell->name_len);
+	return cell->name_len;
+}
+
+static int afs_fsinfo_get_server_name(struct path *path, struct fsinfo_context *ctx)
+{
+	struct afs_server_list *slist;
+	struct afs_super_info *as = AFS_FS_S(path->dentry->d_sb);
+	struct afs_volume *volume = as->volume;
+	struct afs_server *server;
+	int ret = -ENODATA;
+
+	read_lock(&volume->servers_lock);
+	slist = volume->servers;
+	if (slist) {
+		if (ctx->Nth < slist->nr_servers) {
+			server = slist->servers[ctx->Nth].server;
+			ret = sprintf(ctx->buffer, "%pU", &server->uuid);
+		}
+	}
+
+	read_unlock(&volume->servers_lock);
+	return ret;
+}
+
+static int afs_fsinfo_get_server_address(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_afs_server_address *addr = ctx->buffer;
+	struct afs_server_list *slist;
+	struct afs_super_info *as = AFS_FS_S(path->dentry->d_sb);
+	struct afs_addr_list *alist;
+	struct afs_volume *volume = as->volume;
+	struct afs_server *server;
+	struct afs_net *net = afs_d2net(path->dentry);
+	unsigned int i;
+	int ret = -ENODATA;
+
+	read_lock(&volume->servers_lock);
+	slist = afs_get_serverlist(volume->servers);
+	read_unlock(&volume->servers_lock);
+
+	if (ctx->Nth >= slist->nr_servers)
+		goto put_slist;
+	server = slist->servers[ctx->Nth].server;
+
+	read_lock(&server->fs_lock);
+	alist = afs_get_addrlist(rcu_access_pointer(server->addresses));
+	read_unlock(&server->fs_lock);
+	if (!alist)
+		goto put_slist;
+
+	ret = alist->nr_addrs * sizeof(*addr);
+	if (ret <= ctx->buf_size) {
+		for (i = 0; i < alist->nr_addrs; i++)
+			memcpy(&addr[i].address, &alist->addrs[i],
+			       sizeof(struct sockaddr_rxrpc));
+	}
+
+	afs_put_addrlist(alist);
+put_slist:
+	afs_put_serverlist(net, slist);
+	return ret;
+}
+
+static const struct fsinfo_attribute afs_fsinfo_attributes[] = {
+	FSINFO_VSTRUCT	(FSINFO_ATTR_TIMESTAMP_INFO,	afs_fsinfo_get_timestamp),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_LIMITS,		afs_fsinfo_get_limits),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_SUPPORTS,		afs_fsinfo_get_supports),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		afs_fsinfo_get_features),
+	FSINFO_STRING	(FSINFO_ATTR_VOLUME_NAME,	afs_fsinfo_get_volume_name),
+	FSINFO_STRING	(FSINFO_ATTR_AFS_CELL_NAME,	afs_fsinfo_get_cell_name),
+	FSINFO_STRING_N	(FSINFO_ATTR_AFS_SERVER_NAME,	afs_fsinfo_get_server_name),
+	FSINFO_LIST_N	(FSINFO_ATTR_AFS_SERVER_ADDRESSES, afs_fsinfo_get_server_address),
+	{}
+};
+
+static const struct fsinfo_attribute afs_dyn_fsinfo_attributes[] = {
+	FSINFO_VSTRUCT(FSINFO_ATTR_TIMESTAMP_INFO,	afs_fsinfo_get_timestamp),
+	FSINFO_VSTRUCT(FSINFO_ATTR_FEATURES,		afs_dyn_fsinfo_get_features),
+	{}
+};
+
+#endif /* CONFIG_FSINFO */
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index bf12900455b8..5926b16aac4e 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -33,6 +33,10 @@
 #define FSINFO_ATTR_MOUNT_POINT		0x202	/* Relative path of mount in parent (string) */
 #define FSINFO_ATTR_MOUNT_CHILDREN	0x203	/* Children of this mount (list) */
 
+#define FSINFO_ATTR_AFS_CELL_NAME	0x300	/* AFS cell name (string) */
+#define FSINFO_ATTR_AFS_SERVER_NAME	0x301	/* Name of the Nth server (string) */
+#define FSINFO_ATTR_AFS_SERVER_ADDRESSES 0x302	/* List of addresses of the Nth server */
+
 /*
  * Optional fsinfo() parameter structure.
  *
@@ -296,4 +300,15 @@ struct fsinfo_volume_uuid {
 
 #define FSINFO_ATTR_VOLUME_UUID__STRUCT struct fsinfo_volume_uuid
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_AFS_SERVER_ADDRESSES).
+ *
+ * Get the addresses of the Nth server for a network filesystem.
+ */
+struct fsinfo_afs_server_address {
+	struct __kernel_sockaddr_storage address;
+};
+
+#define FSINFO_ATTR_AFS_SERVER_ADDRESSES__STRUCT struct fsinfo_afs_server_address
+
 #endif /* _UAPI_LINUX_FSINFO_H */
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 1411cadc4a90..6ad0f84c4327 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -23,6 +23,7 @@
 #include <linux/socket.h>
 #include <sys/stat.h>
 #include <arpa/inet.h>
+#include <linux/rxrpc.h>
 
 #ifndef __NR_fsinfo
 #define __NR_fsinfo -1
@@ -305,6 +306,50 @@ static void dump_fsinfo_generic_mount_child(void *reply, unsigned int size)
 	printf("%8x %8x\n", f->mnt_id, f->change_counter);
 }
 
+static void dump_afs_fsinfo_server_address(void *reply, unsigned int size)
+{
+	struct fsinfo_afs_server_address *f = reply;
+	struct sockaddr_storage *ss = (struct sockaddr_storage *)&f->address;
+	struct sockaddr_rxrpc *srx;
+	struct sockaddr_in6 *sin6;
+	struct sockaddr_in *sin;
+	char proto[32], buf[1024];
+
+	if (ss->ss_family == AF_RXRPC) {
+		srx = (struct sockaddr_rxrpc *)ss;
+		printf("%5u ", srx->srx_service);
+		switch (srx->transport_type) {
+		case SOCK_DGRAM:
+			sprintf(proto, "udp");
+			break;
+		case SOCK_STREAM:
+			sprintf(proto, "tcp");
+			break;
+		default:
+			sprintf(proto, "%3u", srx->transport_type);
+			break;
+		}
+		ss = (struct sockaddr_storage *)&srx->transport;
+	}
+
+	switch (ss->ss_family) {
+	case AF_INET:
+		sin = (struct sockaddr_in *)ss;
+		if (!inet_ntop(AF_INET, &sin->sin_addr, buf, sizeof(buf)))
+			break;
+		printf("%5u/%s %s\n", ntohs(sin->sin_port), proto, buf);
+		return;
+	case AF_INET6:
+		sin6 = (struct sockaddr_in6 *)ss;
+		if (!inet_ntop(AF_INET6, &sin6->sin6_addr, buf, sizeof(buf)))
+			break;
+		printf("%5u/%s %s\n", ntohs(sin6->sin6_port), proto, buf);
+		return;
+	}
+
+	printf("family=%u\n", ss->ss_family);
+}
+
 static void dump_string(void *reply, unsigned int size)
 {
 	char *s = reply, *p;
@@ -334,6 +379,8 @@ static void dump_string(void *reply, unsigned int size)
 #define dump_fsinfo_generic_volume_name		dump_string
 #define dump_fsinfo_generic_mount_devname	dump_string
 #define dump_fsinfo_generic_mount_point		dump_string
+#define dump_afs_cell_name			dump_string
+#define dump_afs_server_name			dump_string
 
 /*
  *
@@ -374,6 +421,10 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_MOUNT_DEVNAME,	fsinfo_generic_mount_devname),
 	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_child),
 	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT,	fsinfo_generic_mount_point),
+
+	FSINFO_STRING	(FSINFO_ATTR_AFS_CELL_NAME,	afs_cell_name),
+	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	afs_server_name),
+	FSINFO_LIST_N	(FSINFO_ATTR_AFS_SERVER_ADDRESSES, afs_fsinfo_server_address),
 	{}
 };
 


