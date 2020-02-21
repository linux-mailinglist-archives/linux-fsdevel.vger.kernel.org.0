Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F8016860A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgBUSEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:04:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46509 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729717AbgBUSEL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582308249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTR7TIFunaHPQk8Jj6RfsUAuES8pA/5eG3mFQwx4mfM=;
        b=Q1d7BQvhMBbjqW1FqOo8jWwb5Ph4j3OaJqxf/ejnWY1QZurH4yyy3QPxXB/h44m7IyUyAf
        0CVAtJ1xE1F8nIM4SVzGNr5VBnUtB8+PL2qKtqFmKefdbcUcwYQf3VwKee6x5SuaKv3mf+
        mCcAJ8gDSJe2WKfV0kY5/jCV9OMMdj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-QBBLnKXOPoWoB_ugI9l9gw-1; Fri, 21 Feb 2020 13:04:07 -0500
X-MC-Unique: QBBLnKXOPoWoB_ugI9l9gw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 730061005513;
        Fri, 21 Feb 2020 18:04:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 899575C28E;
        Fri, 21 Feb 2020 18:04:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/17] fsinfo: Add example support for NFS [ver #17]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Feb 2020 18:04:03 +0000
Message-ID: <158230824387.2185128.15121791656930144608.stgit@warthog.procyon.org.uk>
In-Reply-To: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the ability to list NFS server addresses and hostname, timestamp
information and capabilities as an example.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-nfs@vger.kernel.org
---

 fs/nfs/Makefile              |    1 
 fs/nfs/fsinfo.c              |  230 ++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/internal.h            |    6 +
 fs/nfs/nfs4super.c           |    3 +
 fs/nfs/super.c               |    3 +
 include/uapi/linux/fsinfo.h  |   29 +++++
 include/uapi/linux/windows.h |   35 ++++++
 samples/vfs/test-fsinfo.c    |   40 +++++++
 8 files changed, 347 insertions(+)
 create mode 100644 fs/nfs/fsinfo.c
 create mode 100644 include/uapi/linux/windows.h

diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 2433c3e03cfa..20fbc9596833 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -13,6 +13,7 @@ nfs-y 			:= client.o dir.o file.o getroot.o inode.o super.o \
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o
 nfs-$(CONFIG_SYSCTL)	+= sysctl.o
 nfs-$(CONFIG_NFS_FSCACHE) += fscache.o fscache-index.o
+nfs-$(CONFIG_FSINFO)	+= fsinfo.o
 
 obj-$(CONFIG_NFS_V2) += nfsv2.o
 nfsv2-y := nfs2super.o proc.o nfs2xdr.o
diff --git a/fs/nfs/fsinfo.c b/fs/nfs/fsinfo.c
new file mode 100644
index 000000000000..a0299ec27efd
--- /dev/null
+++ b/fs/nfs/fsinfo.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Filesystem information for NFS
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/nfs_fs.h>
+#include <linux/windows.h>
+#include "internal.h"
+
+static const struct fsinfo_timestamp_info nfs_timestamp_info = {
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
+static int nfs_fsinfo_get_timestamp_info(struct path *path, struct fsinfo_context *ctx)
+{
+	const struct nfs_server *server = NFS_SB(path->dentry->d_sb);
+	struct fsinfo_timestamp_info *r = ctx->buffer;
+	unsigned long long nsec;
+	unsigned int rem, mant;
+	int exp = -9;
+
+	*r = nfs_timestamp_info;
+
+	nsec = server->time_delta.tv_nsec;
+	nsec += server->time_delta.tv_sec * 1000000000ULL;
+	if (nsec == 0)
+		goto out;
+
+	do {
+		mant = nsec;
+		rem = do_div(nsec, 10);
+		if (rem)
+			break;
+		exp++;
+	} while (nsec);
+
+	r->atime.gran_mantissa = mant;
+	r->atime.gran_exponent = exp;
+	r->btime.gran_mantissa = mant;
+	r->btime.gran_exponent = exp;
+	r->ctime.gran_mantissa = mant;
+	r->ctime.gran_exponent = exp;
+	r->mtime.gran_mantissa = mant;
+	r->mtime.gran_exponent = exp;
+
+out:
+	return sizeof(*r);
+}
+
+static int nfs_fsinfo_get_info(struct path *path, struct fsinfo_context *ctx)
+{
+	const struct nfs_server *server = NFS_SB(path->dentry->d_sb);
+	const struct nfs_client *clp = server->nfs_client;
+	struct fsinfo_nfs_info *r = ctx->buffer;
+
+	r->version		= clp->rpc_ops->version;
+	r->minor_version	= clp->cl_minorversion;
+	r->transport_proto	= clp->cl_proto;
+	return sizeof(*r);
+}
+
+static int nfs_fsinfo_get_server_name(struct path *path, struct fsinfo_context *ctx)
+{
+	const struct nfs_server *server = NFS_SB(path->dentry->d_sb);
+	const struct nfs_client *clp = server->nfs_client;
+
+	return fsinfo_string(clp->cl_hostname, ctx);
+}
+
+static int nfs_fsinfo_get_server_addresses(struct path *path, struct fsinfo_context *ctx)
+{
+	const struct nfs_server *server = NFS_SB(path->dentry->d_sb);
+	const struct nfs_client *clp = server->nfs_client;
+	struct fsinfo_nfs_server_address *addr = ctx->buffer;
+	int ret;
+
+	ret = 1 * sizeof(*addr);
+	if (ret <= ctx->buf_size)
+		memcpy(&addr[0].address, &clp->cl_addr, clp->cl_addrlen);
+	return ret;
+
+}
+
+static int nfs_fsinfo_get_gssapi_name(struct path *path, struct fsinfo_context *ctx)
+{
+	const struct nfs_server *server = NFS_SB(path->dentry->d_sb);
+	const struct nfs_client *clp = server->nfs_client;
+
+	return fsinfo_string(clp->cl_acceptor, ctx);
+}
+
+static int nfs_fsinfo_get_limits(struct path *path, struct fsinfo_context *ctx)
+{
+	const struct nfs_server *server = NFS_SB(path->dentry->d_sb);
+	struct fsinfo_limits *lim = ctx->buffer;
+
+	lim->max_file_size.hi	= 0;
+	lim->max_file_size.lo	= server->maxfilesize;
+	lim->max_ino.hi		= 0;
+	lim->max_ino.lo		= U64_MAX;
+	lim->max_hard_links	= UINT_MAX;
+	lim->max_uid		= UINT_MAX;
+	lim->max_gid		= UINT_MAX;
+	lim->max_filename_len	= NAME_MAX - 1;
+	lim->max_symlink_len	= PATH_MAX - 1;
+	return sizeof(*lim);
+}
+
+static int nfs_fsinfo_get_supports(struct path *path, struct fsinfo_context *ctx)
+{
+	const struct nfs_server *server = NFS_SB(path->dentry->d_sb);
+	struct fsinfo_supports *sup = ctx->buffer;
+
+	/* Don't set STATX_INO as i_ino is fabricated and may not be unique. */
+
+	if (!(server->caps & NFS_CAP_MODE))
+		sup->stx_mask |= STATX_TYPE | STATX_MODE;
+	if (server->caps & NFS_CAP_OWNER)
+		sup->stx_mask |= STATX_UID;
+	if (server->caps & NFS_CAP_OWNER_GROUP)
+		sup->stx_mask |= STATX_GID;
+	if (server->caps & NFS_CAP_ATIME)
+		sup->stx_mask |= STATX_ATIME;
+	if (server->caps & NFS_CAP_CTIME)
+		sup->stx_mask |= STATX_CTIME;
+	if (server->caps & NFS_CAP_MTIME)
+		sup->stx_mask |= STATX_MTIME;
+	if (server->attr_bitmask[0] & FATTR4_WORD0_SIZE)
+		sup->stx_mask |= STATX_SIZE;
+	if (server->attr_bitmask[1] & FATTR4_WORD1_NUMLINKS)
+		sup->stx_mask |= STATX_NLINK;
+
+	if (server->attr_bitmask[0] & FATTR4_WORD0_ARCHIVE)
+		sup->win_file_attrs |= ATTR_ARCHIVE;
+	if (server->attr_bitmask[0] & FATTR4_WORD0_HIDDEN)
+		sup->win_file_attrs |= ATTR_HIDDEN;
+	if (server->attr_bitmask[1] & FATTR4_WORD1_SYSTEM)
+		sup->win_file_attrs |= ATTR_SYSTEM;
+
+	sup->stx_attributes = STATX_ATTR_AUTOMOUNT;
+	return sizeof(*sup);
+}
+
+static int nfs_fsinfo_get_features(struct path *path, struct fsinfo_context *ctx)
+{
+	const struct nfs_server *server = NFS_SB(path->dentry->d_sb);
+	struct fsinfo_features *ft = ctx->buffer;
+
+	fsinfo_set_feature(ft, FSINFO_FEAT_IS_NETWORK_FS);
+	fsinfo_set_feature(ft, FSINFO_FEAT_AUTOMOUNTS);
+	fsinfo_set_feature(ft, FSINFO_FEAT_O_SYNC);
+	fsinfo_set_feature(ft, FSINFO_FEAT_O_DIRECT);
+	fsinfo_set_feature(ft, FSINFO_FEAT_ADV_LOCKS);
+	fsinfo_set_feature(ft, FSINFO_FEAT_DEVICE_FILES);
+	fsinfo_set_feature(ft, FSINFO_FEAT_UNIX_SPECIALS);
+	if (server->nfs_client->rpc_ops->version == 4) {
+		fsinfo_set_feature(ft, FSINFO_FEAT_LEASES);
+		fsinfo_set_feature(ft, FSINFO_FEAT_IVER_ALL_CHANGE);
+	}
+
+	if (server->caps & NFS_CAP_OWNER)
+		fsinfo_set_feature(ft, FSINFO_FEAT_UIDS);
+	if (server->caps & NFS_CAP_OWNER_GROUP)
+		fsinfo_set_feature(ft, FSINFO_FEAT_GIDS);
+	if (!(server->caps & NFS_CAP_MODE))
+		fsinfo_set_feature(ft, FSINFO_FEAT_NO_UNIX_MODE);
+	if (server->caps & NFS_CAP_ACLS)
+		fsinfo_set_feature(ft, FSINFO_FEAT_HAS_ACL);
+	if (server->caps & NFS_CAP_SYMLINKS)
+		fsinfo_set_feature(ft, FSINFO_FEAT_SYMLINKS);
+	if (server->caps & NFS_CAP_HARDLINKS)
+		fsinfo_set_feature(ft, FSINFO_FEAT_HARD_LINKS);
+	if (server->caps & NFS_CAP_ATIME)
+		fsinfo_set_feature(ft, FSINFO_FEAT_HAS_ATIME);
+	if (server->caps & NFS_CAP_CTIME)
+		fsinfo_set_feature(ft, FSINFO_FEAT_HAS_CTIME);
+	if (server->caps & NFS_CAP_MTIME)
+		fsinfo_set_feature(ft, FSINFO_FEAT_HAS_MTIME);
+
+	if (server->attr_bitmask[0] & FATTR4_WORD0_CASE_INSENSITIVE)
+		fsinfo_set_feature(ft, FSINFO_FEAT_NAME_CASE_INDEP);
+	if ((server->attr_bitmask[0] & FATTR4_WORD0_ARCHIVE) ||
+	    (server->attr_bitmask[0] & FATTR4_WORD0_HIDDEN) ||
+	    (server->attr_bitmask[1] & FATTR4_WORD1_SYSTEM))
+		fsinfo_set_feature(ft, FSINFO_FEAT_WINDOWS_ATTRS);
+
+	return sizeof(*ft);
+}
+
+static const struct fsinfo_attribute nfs_fsinfo_attributes[] = {
+	FSINFO_VSTRUCT	(FSINFO_ATTR_TIMESTAMP_INFO,	nfs_fsinfo_get_timestamp_info),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_LIMITS,		nfs_fsinfo_get_limits),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_SUPPORTS,		nfs_fsinfo_get_supports),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		nfs_fsinfo_get_features),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_NFS_INFO,		nfs_fsinfo_get_info),
+	FSINFO_STRING	(FSINFO_ATTR_NFS_SERVER_NAME,	nfs_fsinfo_get_server_name),
+	FSINFO_LIST	(FSINFO_ATTR_NFS_SERVER_ADDRESSES, nfs_fsinfo_get_server_addresses),
+	FSINFO_STRING	(FSINFO_ATTR_NFS_GSSAPI_NAME,	nfs_fsinfo_get_gssapi_name),
+	{}
+};
+
+int nfs_fsinfo(struct path *path, struct fsinfo_context *ctx)
+{
+	return fsinfo_get_attribute(path, ctx, nfs_fsinfo_attributes);
+}
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index f80c47d5ff27..59e407066b45 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -10,6 +10,7 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/nfs_page.h>
 #include <linux/wait_bit.h>
+#include <linux/fsinfo.h>
 
 #define NFS_SB_MASK (SB_RDONLY|SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
 
@@ -247,6 +248,11 @@ extern const struct svc_version nfs4_callback_version4;
 /* fs_context.c */
 extern struct file_system_type nfs_fs_type;
 
+/* fsinfo.c */
+#ifdef CONFIG_FSINFO
+extern int nfs_fsinfo(struct path *path, struct fsinfo_context *ctx);
+#endif
+
 /* pagelist.c */
 extern int __init nfs_init_nfspagecache(void);
 extern void nfs_destroy_nfspagecache(void);
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 1475f932d7da..cd38da87cbd3 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -26,6 +26,9 @@ static const struct super_operations nfs4_sops = {
 	.write_inode	= nfs4_write_inode,
 	.drop_inode	= nfs_drop_inode,
 	.statfs		= nfs_statfs,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= nfs_fsinfo,
+#endif
 	.evict_inode	= nfs4_evict_inode,
 	.umount_begin	= nfs_umount_begin,
 	.show_options	= nfs_show_options,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index dada09b391c6..27ac751d3789 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -76,6 +76,9 @@ const struct super_operations nfs_sops = {
 	.write_inode	= nfs_write_inode,
 	.drop_inode	= nfs_drop_inode,
 	.statfs		= nfs_statfs,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= nfs_fsinfo,
+#endif
 	.evict_inode	= nfs_evict_inode,
 	.umount_begin	= nfs_umount_begin,
 	.show_options	= nfs_show_options,
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 6a8a7a8e4910..d5c4fe681333 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -39,6 +39,11 @@
 
 #define FSINFO_ATTR_EXT4_TIMESTAMPS	0x400	/* Ext4 superblock timestamps */
 
+#define FSINFO_ATTR_NFS_INFO		0x500	/* Information about an NFS mount */
+#define FSINFO_ATTR_NFS_SERVER_NAME	0x501	/* Name of the server (string) */
+#define FSINFO_ATTR_NFS_SERVER_ADDRESSES 0x502	/* List of addresses of the server */
+#define FSINFO_ATTR_NFS_GSSAPI_NAME	0x503	/* GSSAPI acceptor name */
+
 /*
  * Optional fsinfo() parameter structure.
  *
@@ -329,4 +334,28 @@ struct fsinfo_ext4_timestamps {
 
 #define FSINFO_ATTR_EXT4_TIMESTAMPS__STRUCT struct fsinfo_ext4_timestamps
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_NFS_INFO).
+ *
+ * Get information about an NFS mount.
+ */
+struct fsinfo_nfs_info {
+	__u32		version;
+	__u32		minor_version;
+	__u32		transport_proto;
+};
+
+#define FSINFO_ATTR_NFS_INFO__STRUCT struct fsinfo_nfs_info
+
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_NFS_SERVER_ADDRESSES).
+ *
+ * Get the addresses of the server for an NFS mount.
+ */
+struct fsinfo_nfs_server_address {
+	struct __kernel_sockaddr_storage address;
+};
+
+#define FSINFO_ATTR_NFS_SERVER_ADDRESSES__STRUCT struct fsinfo_nfs_server_address
+
 #endif /* _UAPI_LINUX_FSINFO_H */
diff --git a/include/uapi/linux/windows.h b/include/uapi/linux/windows.h
new file mode 100644
index 000000000000..17efb9a40529
--- /dev/null
+++ b/include/uapi/linux/windows.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Common windows attributes
+ */
+#ifndef _UAPI_LINUX_WINDOWS_H
+#define _UAPI_LINUX_WINDOWS_H
+
+/*
+ * File Attribute flags
+ */
+#define ATTR_READONLY		0x0001
+#define ATTR_HIDDEN		0x0002
+#define ATTR_SYSTEM		0x0004
+#define ATTR_VOLUME		0x0008
+#define ATTR_DIRECTORY		0x0010
+#define ATTR_ARCHIVE		0x0020
+#define ATTR_DEVICE		0x0040
+#define ATTR_NORMAL		0x0080
+#define ATTR_TEMPORARY		0x0100
+#define ATTR_SPARSE		0x0200
+#define ATTR_REPARSE		0x0400
+#define ATTR_COMPRESSED		0x0800
+#define ATTR_OFFLINE		0x1000	/* ie file not immediately available -
+					   on offline storage */
+#define ATTR_NOT_CONTENT_INDEXED 0x2000
+#define ATTR_ENCRYPTED		0x4000
+#define ATTR_POSIX_SEMANTICS	0x01000000
+#define ATTR_BACKUP_SEMANTICS	0x02000000
+#define ATTR_DELETE_ON_CLOSE	0x04000000
+#define ATTR_SEQUENTIAL_SCAN	0x08000000
+#define ATTR_RANDOM_ACCESS	0x10000000
+#define ATTR_NO_BUFFERING	0x20000000
+#define ATTR_WRITE_THROUGH	0x80000000
+
+#endif /* _UAPI_LINUX_WINDOWS_H */
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index df8d2449fc22..87239f0b6a50 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -391,6 +391,40 @@ static void dump_ext4_fsinfo_timestamps(void *reply, unsigned int size)
 	printf("\tlast-err: %s\n", dump_ext4_time(buffer, r->last_error_time));
 }
 
+static void dump_nfs_fsinfo_info(void *reply, unsigned int size)
+{
+	struct fsinfo_nfs_info *r = reply;
+
+	printf("ver=%u.%u proto=%u\n", r->version, r->minor_version, r->transport_proto);
+}
+
+static void dump_nfs_fsinfo_server_addresses(void *reply, unsigned int size)
+{
+	struct fsinfo_nfs_server_address *r = reply;
+	struct sockaddr_storage *ss = (struct sockaddr_storage *)&r->address;
+	struct sockaddr_in6 *sin6;
+	struct sockaddr_in *sin;
+	char buf[1024];
+
+	switch (ss->ss_family) {
+	case AF_INET:
+		sin = (struct sockaddr_in *)ss;
+		if (!inet_ntop(AF_INET, &sin->sin_addr, buf, sizeof(buf)))
+			break;
+		printf("%5u %s\n", ntohs(sin->sin_port), buf);
+		return;
+	case AF_INET6:
+		sin6 = (struct sockaddr_in6 *)ss;
+		if (!inet_ntop(AF_INET6, &sin6->sin6_addr, buf, sizeof(buf)))
+			break;
+		printf("%5u %s\n", ntohs(sin6->sin6_port), buf);
+		return;
+	default:
+		printf("family=%u\n", ss->ss_family);
+		return;
+	}
+}
+
 static void dump_string(void *reply, unsigned int size)
 {
 	char *s = reply, *p;
@@ -422,6 +456,8 @@ static void dump_string(void *reply, unsigned int size)
 #define dump_fsinfo_generic_mount_point		dump_string
 #define dump_afs_cell_name			dump_string
 #define dump_afs_server_name			dump_string
+#define dump_nfs_fsinfo_server_name		dump_string
+#define dump_nfs_fsinfo_gssapi_name		dump_string
 
 /*
  *
@@ -468,6 +504,10 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	afs_server_name),
 	FSINFO_LIST_N	(FSINFO_ATTR_AFS_SERVER_ADDRESSES, afs_fsinfo_server_address),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_EXT4_TIMESTAMPS,	ext4_fsinfo_timestamps),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_NFS_INFO,		nfs_fsinfo_info),
+	FSINFO_STRING	(FSINFO_ATTR_NFS_SERVER_NAME,	nfs_fsinfo_server_name),
+	FSINFO_LIST	(FSINFO_ATTR_NFS_SERVER_ADDRESSES, nfs_fsinfo_server_addresses),
+	FSINFO_STRING	(FSINFO_ATTR_NFS_GSSAPI_NAME,	nfs_fsinfo_gssapi_name),
 	{}
 };
 


