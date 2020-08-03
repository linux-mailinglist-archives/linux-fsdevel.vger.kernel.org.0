Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D47023A7BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 15:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgHCNi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 09:38:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29364 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728307AbgHCNi0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596461904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=50AbVyEEdG6Rs16oQ+jUp0/rZUjAi98apSFX2UNVhGg=;
        b=bhjlcXxTEmSFC1f+mWxtRL+3i+gW0Tobbb8V7MUxsetNF9NfbrHkol/Lb4nTjLTvhkhgVp
        /4kzHtLFJj3oMOCPEel8o8/KcJGjSGnRVOGBpfoRwAoCij8t2HeB1YmkD4fgPDLY27XPJy
        Zp2e4CHT2sjsuyodCoNxIIpeaiB5yD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-hAUOcRRuOZKmMDNSR1BBDQ-1; Mon, 03 Aug 2020 09:38:22 -0400
X-MC-Unique: hAUOcRRuOZKmMDNSR1BBDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7BE41DE2;
        Mon,  3 Aug 2020 13:38:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51D7260C47;
        Mon,  3 Aug 2020 13:38:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/18] fsinfo: Add support for AFS [ver #21]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Aug 2020 14:38:16 +0100
Message-ID: <159646189650.1784947.9331959720142566489.stgit@warthog.procyon.org.uk>
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

Add fsinfo support to the AFS filesystem.  This allows the export of server
lists, amongst other things, which is necessary to implement some of the
AFS 'fs' command set, such as "checkservers", "getserverprefs" and
"whereis".

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h           |    1 
 fs/afs/super.c              |  216 +++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fsinfo.h |   15 +++
 samples/vfs/test-fsinfo.c   |   49 ++++++++++
 4 files changed, 279 insertions(+), 2 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 792ac711985e..e775340c23c1 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -225,6 +225,7 @@ struct afs_super_info {
 	struct afs_volume	*volume;	/* volume record */
 	enum afs_flock_mode	flock_mode:8;	/* File locking emulation mode */
 	bool			dyn_root;	/* True if dynamic root */
+	bool			autocell;	/* True if autocell */
 };
 
 static inline struct afs_super_info *AFS_FS_S(struct super_block *sb)
diff --git a/fs/afs/super.c b/fs/afs/super.c
index b552357b1d13..6fe7b8a57869 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -26,9 +26,13 @@
 #include <linux/sched.h>
 #include <linux/nsproxy.h>
 #include <linux/magic.h>
+#include <linux/fsinfo.h>
 #include <net/net_namespace.h>
 #include "internal.h"
 
+#ifdef CONFIG_FSINFO
+static int afs_fsinfo(struct path *path, struct fsinfo_context *ctx);
+#endif
 static void afs_i_init_once(void *foo);
 static void afs_kill_super(struct super_block *sb);
 static struct inode *afs_alloc_inode(struct super_block *sb);
@@ -54,6 +58,9 @@ int afs_net_id;
 
 static const struct super_operations afs_super_ops = {
 	.statfs		= afs_statfs,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= afs_fsinfo,
+#endif
 	.alloc_inode	= afs_alloc_inode,
 	.drop_inode	= afs_drop_inode,
 	.destroy_inode	= afs_destroy_inode,
@@ -193,7 +200,7 @@ static int afs_show_options(struct seq_file *m, struct dentry *root)
 
 	if (as->dyn_root)
 		seq_puts(m, ",dyn");
-	if (test_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(d_inode(root))->flags))
+	if (as->autocell)
 		seq_puts(m, ",autocell");
 	switch (as->flock_mode) {
 	case afs_flock_mode_unset:	break;
@@ -470,7 +477,7 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	if (ctx->autocell || as->dyn_root)
+	if (as->autocell || as->dyn_root)
 		set_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(inode)->flags);
 
 	ret = -ENOMEM;
@@ -512,6 +519,8 @@ static struct afs_super_info *afs_alloc_sbi(struct fs_context *fc)
 			as->volume = afs_get_volume(ctx->volume,
 						    afs_volume_trace_get_alloc_sbi);
 		}
+		if (ctx->autocell)
+			as->autocell = true;
 	}
 	return as;
 }
@@ -771,3 +780,206 @@ static int afs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	op->ops			= &afs_get_volume_status_operation;
 	return afs_do_sync_operation(op);
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
+	struct fsinfo_supports *p = ctx->buffer;
+
+	p->stx_mask = (STATX_TYPE | STATX_MODE |
+		       STATX_NLINK |
+		       STATX_UID | STATX_GID |
+		       STATX_MTIME | STATX_INO |
+		       STATX_SIZE);
+	p->stx_attributes = STATX_ATTR_AUTOMOUNT;
+	return sizeof(*p);
+}
+
+static int afs_fsinfo_get_features(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_features *p = ctx->buffer;
+
+	fsinfo_set_feature(p, FSINFO_FEAT_IS_NETWORK_FS);
+	fsinfo_set_feature(p, FSINFO_FEAT_AUTOMOUNTS);
+	fsinfo_set_feature(p, FSINFO_FEAT_ADV_LOCKS);
+	fsinfo_set_feature(p, FSINFO_FEAT_UIDS);
+	fsinfo_set_feature(p, FSINFO_FEAT_GIDS);
+	fsinfo_set_feature(p, FSINFO_FEAT_VOLUME_ID);
+	fsinfo_set_feature(p, FSINFO_FEAT_VOLUME_NAME);
+	fsinfo_set_feature(p, FSINFO_FEAT_IVER_MONO_INCR);
+	fsinfo_set_feature(p, FSINFO_FEAT_SYMLINKS);
+	fsinfo_set_feature(p, FSINFO_FEAT_HARD_LINKS_1DIR);
+	fsinfo_set_feature(p, FSINFO_FEAT_HAS_MTIME);
+	fsinfo_set_feature(p, FSINFO_FEAT_HAS_INODE_NUMBERS);
+	return sizeof(*p);
+}
+
+static int afs_dyn_fsinfo_get_features(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_features *p = ctx->buffer;
+
+	fsinfo_set_feature(p, FSINFO_FEAT_IS_AUTOMOUNTER_FS);
+	fsinfo_set_feature(p, FSINFO_FEAT_AUTOMOUNTS);
+	return sizeof(*p);
+}
+
+static int afs_fsinfo_get_volume_name(struct path *path, struct fsinfo_context *ctx)
+{
+	struct afs_super_info *as = AFS_FS_S(path->dentry->d_sb);
+	struct afs_volume *volume = as->volume;
+
+	return fsinfo_opaque(volume->name, ctx, volume->name_len + 1);
+}
+
+static int afs_fsinfo_get_cell_name(struct path *path, struct fsinfo_context *ctx)
+{
+	struct afs_super_info *as = AFS_FS_S(path->dentry->d_sb);
+	struct afs_cell *cell = as->cell;
+
+	return fsinfo_opaque(cell->name, ctx, cell->name_len + 1);
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
+			ret = sprintf(ctx->buffer, "%pU", &server->uuid) + 1;
+		}
+	}
+
+	read_unlock(&volume->servers_lock);
+	return ret;
+}
+
+static int afs_fsinfo_get_server_address(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_afs_server_address *p = ctx->buffer;
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
+	alist = afs_get_addrlist(rcu_dereference_protected(
+					 server->addresses,
+					 lockdep_is_held(&server->fs_lock)));
+	read_unlock(&server->fs_lock);
+	if (!alist)
+		goto put_slist;
+
+	ret = alist->nr_addrs * sizeof(*p);
+	if (ret <= ctx->buf_size) {
+		for (i = 0; i < alist->nr_addrs; i++)
+			memcpy(&p[i].address, &alist->addrs[i],
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
+static int afs_fsinfo(struct path *path, struct fsinfo_context *ctx)
+{
+	struct afs_super_info *as = AFS_FS_S(path->dentry->d_sb);
+	int ret;
+
+	if (as->dyn_root)
+		ret = fsinfo_get_attribute(path, ctx, afs_dyn_fsinfo_attributes);
+	else
+		ret = fsinfo_get_attribute(path, ctx, afs_fsinfo_attributes);
+	return ret;
+}
+
+#endif /* CONFIG_FSINFO */
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index b021466dee0f..81329de6905e 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -38,6 +38,10 @@
 #define FSINFO_ATTR_MOUNT_TOPOLOGY	0x204	/* Mount object topology */
 #define FSINFO_ATTR_MOUNT_CHILDREN	0x205	/* Children of this mount (list) */
 
+#define FSINFO_ATTR_AFS_CELL_NAME	0x300	/* AFS cell name (string) */
+#define FSINFO_ATTR_AFS_SERVER_NAME	0x301	/* Name of the Nth server (string) */
+#define FSINFO_ATTR_AFS_SERVER_ADDRESSES 0x302	/* List of addresses of the Nth server */
+
 /*
  * Optional fsinfo() parameter structure.
  *
@@ -309,4 +313,15 @@ struct fsinfo_volume_uuid {
 
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
index 620a02477aa8..374825ab85b0 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -24,6 +24,7 @@
 #include <linux/mount.h>
 #include <sys/stat.h>
 #include <arpa/inet.h>
+#include <linux/rxrpc.h>
 
 #ifndef __NR_fsinfo
 #define __NR_fsinfo -1
@@ -364,6 +365,50 @@ static void dump_fsinfo_generic_mount_children(void *reply, unsigned int size)
 	       (unsigned long long)r->mnt_notify_sum, mp);
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
@@ -447,6 +492,10 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT,	string),
 	FSINFO_STRING_N	(FSINFO_ATTR_MOUNT_POINT_FULL,	string),
 	FSINFO_LIST	(FSINFO_ATTR_MOUNT_CHILDREN,	fsinfo_generic_mount_children),
+
+	FSINFO_STRING	(FSINFO_ATTR_AFS_CELL_NAME,	string),
+	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	string),
+	FSINFO_LIST_N	(FSINFO_ATTR_AFS_SERVER_ADDRESSES, afs_fsinfo_server_address),
 	{}
 };
 


