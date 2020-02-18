Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBD0162DFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 19:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBRSNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 13:13:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42660 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726444AbgBRSNL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582049588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4eE3N1CdVZF/ZVYXzz5xUNy+xrY3tmF2z/vaSgzdeZo=;
        b=X1lfVMB60HQ4n8ypufKA8e/tnFibrU/7VhlR7WxxmLRl//BSLmKsueDsm1sAL6oKnKwgR6
        cxxIBEJc5yVkDyHvfGYSSSBfhsxh8Av7oKZNW5fzDxfPAnD72SA/YgVznXiXPWpj6/8Rk5
        q1uD622lKn3mPX3CoQ4+UtFbCYMJ7X0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-QnVHHboXNuCk_6620iqIVw-1; Tue, 18 Feb 2020 13:13:04 -0500
X-MC-Unique: QnVHHboXNuCk_6620iqIVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DD5A107ACC7;
        Tue, 18 Feb 2020 18:13:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 447E790526;
        Tue, 18 Feb 2020 18:13:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <158204564600.3299825.1942403408111770890.stgit@warthog.procyon.org.uk>
References: <158204564600.3299825.1942403408111770890.stgit@warthog.procyon.org.uk> <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 19/19] nfs: Add example filesystem information [ver #16]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3306458.1582049579.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 18 Feb 2020 18:12:59 +0000
Message-ID: <3306459.1582049579@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oops.  I forgot to add a couple of files before committing.  Here's the
corrected patch.

David
---
nfs: Add example filesystem information

Add the ability to list NFS server addresses and hostname, timestamp
information and capabilities as an example.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-nfs@vger.kernel.org

---
 fs/nfs/Makefile              |    1 =

 fs/nfs/fsinfo.c              |  225 +++++++++++++++++++++++++++++++++++++=
++++++
 fs/nfs/internal.h            |    8 +
 fs/nfs/nfs4super.c           |    1 =

 fs/nfs/super.c               |    1 =

 include/uapi/linux/fsinfo.h  |   29 +++++
 include/uapi/linux/windows.h |   35 ++++++
 samples/vfs/test-fsinfo.c    |   40 +++++++
 8 files changed, 340 insertions(+)

diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 2433c3e03cfa..20fbc9596833 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -13,6 +13,7 @@ nfs-y 			:=3D client.o dir.o file.o getroot.o inode.o su=
per.o \
 nfs-$(CONFIG_ROOT_NFS)	+=3D nfsroot.o
 nfs-$(CONFIG_SYSCTL)	+=3D sysctl.o
 nfs-$(CONFIG_NFS_FSCACHE) +=3D fscache.o fscache-index.o
+nfs-$(CONFIG_FSINFO)	+=3D fsinfo.o
 =

 obj-$(CONFIG_NFS_V2) +=3D nfsv2.o
 nfsv2-y :=3D nfs2super.o proc.o nfs2xdr.o
diff --git a/fs/nfs/fsinfo.c b/fs/nfs/fsinfo.c
new file mode 100644
index 000000000000..22f7e6a16cb4
--- /dev/null
+++ b/fs/nfs/fsinfo.c
@@ -0,0 +1,225 @@
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
+static const struct fsinfo_timestamp_info nfs_timestamp_info =3D {
+	.atime =3D {
+		.minimum	=3D 0,
+		.maximum	=3D UINT_MAX,
+		.gran_mantissa	=3D 1,
+		.gran_exponent	=3D 0,
+	},
+	.mtime =3D {
+		.minimum	=3D 0,
+		.maximum	=3D UINT_MAX,
+		.gran_mantissa	=3D 1,
+		.gran_exponent	=3D 0,
+	},
+	.ctime =3D {
+		.minimum	=3D 0,
+		.maximum	=3D UINT_MAX,
+		.gran_mantissa	=3D 1,
+		.gran_exponent	=3D 0,
+	},
+	.btime =3D {
+		.minimum	=3D 0,
+		.maximum	=3D UINT_MAX,
+		.gran_mantissa	=3D 1,
+		.gran_exponent	=3D 0,
+	},
+};
+
+static int nfs_fsinfo_get_timestamp_info(struct path *path, struct fsinfo=
_context *ctx)
+{
+	const struct nfs_server *server =3D NFS_SB(path->dentry->d_sb);
+	struct fsinfo_timestamp_info *r =3D ctx->buffer;
+	unsigned long long nsec;
+	unsigned int rem, mant;
+	int exp =3D -9;
+
+	*r =3D nfs_timestamp_info;
+
+	nsec =3D server->time_delta.tv_nsec;
+	nsec +=3D server->time_delta.tv_sec * 1000000000ULL;
+	if (nsec =3D=3D 0)
+		goto out;
+
+	do {
+		mant =3D nsec;
+		rem =3D do_div(nsec, 10);
+		if (rem)
+			break;
+		exp++;
+	} while (nsec);
+
+	r->atime.gran_mantissa =3D mant;
+	r->atime.gran_exponent =3D exp;
+	r->btime.gran_mantissa =3D mant;
+	r->btime.gran_exponent =3D exp;
+	r->ctime.gran_mantissa =3D mant;
+	r->ctime.gran_exponent =3D exp;
+	r->mtime.gran_mantissa =3D mant;
+	r->mtime.gran_exponent =3D exp;
+
+out:
+	return sizeof(*r);
+}
+
+static int nfs_fsinfo_get_info(struct path *path, struct fsinfo_context *=
ctx)
+{
+	const struct nfs_server *server =3D NFS_SB(path->dentry->d_sb);
+	const struct nfs_client *clp =3D server->nfs_client;
+	struct fsinfo_nfs_info *r =3D ctx->buffer;
+
+	r->version		=3D clp->rpc_ops->version;
+	r->minor_version	=3D clp->cl_minorversion;
+	r->transport_proto	=3D clp->cl_proto;
+	return sizeof(*r);
+}
+
+static int nfs_fsinfo_get_server_name(struct path *path, struct fsinfo_co=
ntext *ctx)
+{
+	const struct nfs_server *server =3D NFS_SB(path->dentry->d_sb);
+	const struct nfs_client *clp =3D server->nfs_client;
+
+	return fsinfo_string(clp->cl_hostname, ctx);
+}
+
+static int nfs_fsinfo_get_server_addresses(struct path *path, struct fsin=
fo_context *ctx)
+{
+	const struct nfs_server *server =3D NFS_SB(path->dentry->d_sb);
+	const struct nfs_client *clp =3D server->nfs_client;
+	struct fsinfo_nfs_server_address *addr =3D ctx->buffer;
+	int ret;
+
+	ret =3D 1 * sizeof(*addr);
+	if (ret <=3D ctx->buf_size)
+		memcpy(&addr[0].address, &clp->cl_addr, clp->cl_addrlen);
+	return ret;
+
+}
+
+static int nfs_fsinfo_get_gssapi_name(struct path *path, struct fsinfo_co=
ntext *ctx)
+{
+	const struct nfs_server *server =3D NFS_SB(path->dentry->d_sb);
+	const struct nfs_client *clp =3D server->nfs_client;
+
+	return fsinfo_string(clp->cl_acceptor, ctx);
+}
+
+static int nfs_fsinfo_get_limits(struct path *path, struct fsinfo_context=
 *ctx)
+{
+	const struct nfs_server *server =3D NFS_SB(path->dentry->d_sb);
+	struct fsinfo_limits *lim =3D ctx->buffer;
+
+	lim->max_file_size.hi	=3D 0;
+	lim->max_file_size.lo	=3D server->maxfilesize;
+	lim->max_ino.hi		=3D 0;
+	lim->max_ino.lo		=3D U64_MAX;
+	lim->max_hard_links	=3D UINT_MAX;
+	lim->max_uid		=3D UINT_MAX;
+	lim->max_gid		=3D UINT_MAX;
+	lim->max_filename_len	=3D NAME_MAX - 1;
+	lim->max_symlink_len	=3D PATH_MAX - 1;
+	return sizeof(*lim);
+}
+
+static int nfs_fsinfo_get_supports(struct path *path, struct fsinfo_conte=
xt *ctx)
+{
+	const struct nfs_server *server =3D NFS_SB(path->dentry->d_sb);
+	struct fsinfo_supports *sup =3D ctx->buffer;
+
+	/* Don't set STATX_INO as i_ino is fabricated and may not be unique. */
+
+	if (!(server->caps & NFS_CAP_MODE))
+		sup->stx_mask |=3D STATX_TYPE | STATX_MODE;
+	if (server->caps & NFS_CAP_OWNER)
+		sup->stx_mask |=3D STATX_UID;
+	if (server->caps & NFS_CAP_OWNER_GROUP)
+		sup->stx_mask |=3D STATX_GID;
+	if (server->caps & NFS_CAP_ATIME)
+		sup->stx_mask |=3D STATX_ATIME;
+	if (server->caps & NFS_CAP_CTIME)
+		sup->stx_mask |=3D STATX_CTIME;
+	if (server->caps & NFS_CAP_MTIME)
+		sup->stx_mask |=3D STATX_MTIME;
+	if (server->attr_bitmask[0] & FATTR4_WORD0_SIZE)
+		sup->stx_mask |=3D STATX_SIZE;
+	if (server->attr_bitmask[1] & FATTR4_WORD1_NUMLINKS)
+		sup->stx_mask |=3D STATX_NLINK;
+
+	if (server->attr_bitmask[0] & FATTR4_WORD0_ARCHIVE)
+		sup->win_file_attrs |=3D ATTR_ARCHIVE;
+	if (server->attr_bitmask[0] & FATTR4_WORD0_HIDDEN)
+		sup->win_file_attrs |=3D ATTR_HIDDEN;
+	if (server->attr_bitmask[1] & FATTR4_WORD1_SYSTEM)
+		sup->win_file_attrs |=3D ATTR_SYSTEM;
+
+	sup->stx_attributes =3D STATX_ATTR_AUTOMOUNT;
+	return sizeof(*sup);
+}
+
+static int nfs_fsinfo_get_features(struct path *path, struct fsinfo_conte=
xt *ctx)
+{
+	const struct nfs_server *server =3D NFS_SB(path->dentry->d_sb);
+	struct fsinfo_features *ft =3D ctx->buffer;
+
+	fsinfo_set_feature(ft, FSINFO_FEAT_IS_NETWORK_FS);
+	fsinfo_set_feature(ft, FSINFO_FEAT_AUTOMOUNTS);
+	fsinfo_set_feature(ft, FSINFO_FEAT_O_SYNC);
+	fsinfo_set_feature(ft, FSINFO_FEAT_O_DIRECT);
+	fsinfo_set_feature(ft, FSINFO_FEAT_ADV_LOCKS);
+	fsinfo_set_feature(ft, FSINFO_FEAT_DEVICE_FILES);
+	fsinfo_set_feature(ft, FSINFO_FEAT_UNIX_SPECIALS);
+	if (server->nfs_client->rpc_ops->version =3D=3D 4) {
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
+const struct fsinfo_attribute nfs_fsinfo_attributes[] =3D {
+	FSINFO_VSTRUCT	(FSINFO_ATTR_TIMESTAMP_INFO,	nfs_fsinfo_get_timestamp_inf=
o),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_LIMITS,		nfs_fsinfo_get_limits),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_SUPPORTS,		nfs_fsinfo_get_supports),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		nfs_fsinfo_get_features),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_NFS_INFO,		nfs_fsinfo_get_info),
+	FSINFO_STRING	(FSINFO_ATTR_NFS_SERVER_NAME,	nfs_fsinfo_get_server_name),
+	FSINFO_LIST	(FSINFO_ATTR_NFS_SERVER_ADDRESSES, nfs_fsinfo_get_server_add=
resses),
+	FSINFO_STRING	(FSINFO_ATTR_NFS_GSSAPI_NAME,	nfs_fsinfo_get_gssapi_name),
+	{}
+};
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index f80c47d5ff27..4ddf0da25740 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -10,6 +10,7 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/nfs_page.h>
 #include <linux/wait_bit.h>
+#include <linux/fsinfo.h>
 =

 #define NFS_SB_MASK (SB_RDONLY|SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOU=
S)
 =

@@ -247,6 +248,13 @@ extern const struct svc_version nfs4_callback_version=
4;
 /* fs_context.c */
 extern struct file_system_type nfs_fs_type;
 =

+/* fsinfo.c */
+#ifdef CONFIG_FSINFO
+extern const struct fsinfo_attribute nfs_fsinfo_attributes[];
+#else
+#define nfs_fsinfo_attributes NULL
+#endif
+
 /* pagelist.c */
 extern int __init nfs_init_nfspagecache(void);
 extern void nfs_destroy_nfspagecache(void);
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 1475f932d7da..1b75144e24f4 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -26,6 +26,7 @@ static const struct super_operations nfs4_sops =3D {
 	.write_inode	=3D nfs4_write_inode,
 	.drop_inode	=3D nfs_drop_inode,
 	.statfs		=3D nfs_statfs,
+	.fsinfo_attributes =3D nfs_fsinfo_attributes,
 	.evict_inode	=3D nfs4_evict_inode,
 	.umount_begin	=3D nfs_umount_begin,
 	.show_options	=3D nfs_show_options,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index dada09b391c6..fbc2cf5f803b 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -76,6 +76,7 @@ const struct super_operations nfs_sops =3D {
 	.write_inode	=3D nfs_write_inode,
 	.drop_inode	=3D nfs_drop_inode,
 	.statfs		=3D nfs_statfs,
+	.fsinfo_attributes =3D nfs_fsinfo_attributes,
 	.evict_inode	=3D nfs_evict_inode,
 	.umount_begin	=3D nfs_umount_begin,
 	.show_options	=3D nfs_show_options,
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index da9a6f48ec5b..7c97d65333ec 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -40,6 +40,11 @@
 =

 #define FSINFO_ATTR_EXT4_TIMESTAMPS	0x400	/* Ext4 superblock timestamps *=
/
 =

+#define FSINFO_ATTR_NFS_INFO		0x500	/* Information about an NFS mount */
+#define FSINFO_ATTR_NFS_SERVER_NAME	0x501	/* Name of the server (string) =
*/
+#define FSINFO_ATTR_NFS_SERVER_ADDRESSES 0x502	/* List of addresses of th=
e server */
+#define FSINFO_ATTR_NFS_GSSAPI_NAME	0x503	/* GSSAPI acceptor name */
+
 /*
  * Optional fsinfo() parameter structure.
  *
@@ -339,4 +344,28 @@ struct fsinfo_ext4_timestamps {
 =

 #define FSINFO_ATTR_EXT4_TIMESTAMPS__STRUCT struct fsinfo_ext4_timestamps
 =

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
+#define FSINFO_ATTR_NFS_SERVER_ADDRESSES__STRUCT struct fsinfo_nfs_server=
_address
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
index 53251ee98d1c..68652db686e8 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -393,6 +393,40 @@ static void dump_ext4_fsinfo_timestamps(void *reply, =
unsigned int size)
 	printf("\tlast-err: %s\n", dump_ext4_time(buffer, r->last_error_time));
 }
 =

+static void dump_nfs_fsinfo_info(void *reply, unsigned int size)
+{
+	struct fsinfo_nfs_info *r =3D reply;
+
+	printf("ver=3D%u.%u proto=3D%u\n", r->version, r->minor_version, r->tran=
sport_proto);
+}
+
+static void dump_nfs_fsinfo_server_addresses(void *reply, unsigned int si=
ze)
+{
+	struct fsinfo_nfs_server_address *r =3D reply;
+	struct sockaddr_storage *ss =3D (struct sockaddr_storage *)&r->address;
+	struct sockaddr_in6 *sin6;
+	struct sockaddr_in *sin;
+	char buf[1024];
+
+	switch (ss->ss_family) {
+	case AF_INET:
+		sin =3D (struct sockaddr_in *)ss;
+		if (!inet_ntop(AF_INET, &sin->sin_addr, buf, sizeof(buf)))
+			break;
+		printf("%5u %s\n", ntohs(sin->sin_port), buf);
+		return;
+	case AF_INET6:
+		sin6 =3D (struct sockaddr_in6 *)ss;
+		if (!inet_ntop(AF_INET6, &sin6->sin6_addr, buf, sizeof(buf)))
+			break;
+		printf("%5u %s\n", ntohs(sin6->sin6_port), buf);
+		return;
+	default:
+		printf("family=3D%u\n", ss->ss_family);
+		return;
+	}
+}
+
 static void dump_string(void *reply, unsigned int size)
 {
 	char *s =3D reply, *p;
@@ -424,6 +458,8 @@ static void dump_string(void *reply, unsigned int size=
)
 #define dump_fsinfo_generic_mount_point		dump_string
 #define dump_afs_cell_name			dump_string
 #define dump_afs_server_name			dump_string
+#define dump_nfs_fsinfo_server_name		dump_string
+#define dump_nfs_fsinfo_gssapi_name		dump_string
 =

 /*
  *
@@ -468,6 +504,10 @@ static const struct fsinfo_attribute fsinfo_attribute=
s[] =3D {
 	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	afs_server_name),
 	FSINFO_LIST_N	(FSINFO_ATTR_AFS_SERVER_ADDRESSES, afs_fsinfo_server_addre=
ss),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_EXT4_TIMESTAMPS,	ext4_fsinfo_timestamps),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_NFS_INFO,		nfs_fsinfo_info),
+	FSINFO_STRING	(FSINFO_ATTR_NFS_SERVER_NAME,	nfs_fsinfo_server_name),
+	FSINFO_LIST	(FSINFO_ATTR_NFS_SERVER_ADDRESSES, nfs_fsinfo_server_address=
es),
+	FSINFO_STRING	(FSINFO_ATTR_NFS_GSSAPI_NAME,	nfs_fsinfo_gssapi_name),
 	{}
 };
 =

