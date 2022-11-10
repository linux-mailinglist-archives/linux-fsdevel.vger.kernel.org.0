Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4CD624420
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 15:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiKJOVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 09:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKJOVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:21:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824701A225
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 06:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668090026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H/bZwMQ4oRwmmzeDUDUOK7dzn8rxJvv59NqX3inkHU4=;
        b=gJ9eWRMl1W2zuUinF2PInx5hje3/iLcE2Qv2a358BceTLuBIY0mlVaDH5mX5MPtXhR94QM
        YBIcvI2gAmho6v9Gs5GSQV/YptyvgzpyrxjcfYBuxlt2yXxULDx8k1s72kpLK/c+P9JXfA
        I78nkyoXfsRBsawu26I1b396D4sIqko=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-110-NgjwVOzIO2uJpVSEwylJjg-1; Thu, 10 Nov 2022 09:20:25 -0500
X-MC-Unique: NgjwVOzIO2uJpVSEwylJjg-1
Received: by mail-ed1-f69.google.com with SMTP id e15-20020a056402190f00b00461b0576620so1619226edz.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 06:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/bZwMQ4oRwmmzeDUDUOK7dzn8rxJvv59NqX3inkHU4=;
        b=o0tGB/srlcfYgIZa+m1j4/i0Poh0SyEXYKbsFjymt0B9D6hmIS5+dcGoprzKRgBWjG
         I66RPAr5O17pF4RsC1kCLtwgnkKvCc2+expMpBL/zQ+g+xQnUQmNAZHr14OxaGrNe0+T
         iV5mn8JtrRW2r72MUNAcu5TlVc/laYfVEBHXu6WIR6ESyawO+ZOEI24hsXQR5lyR/Omf
         SiPW4TnpFjDErTKMdW2D6lWwBLs2gyZ9IJZ8DQaw9H7spO9wuboiFs20EQIOYwX4fPiO
         OUpfAY9uEYBQ2VwAVp6geGecNqXXTAyEX3U4sVEZ1/tzcMLVDdFBf1LHK8ow+Wpvxh2X
         EGkw==
X-Gm-Message-State: ACrzQf3M/Ww61Jh92MvKmzgkN4iFn2M+uKY6LqMw1cs/19Yvt9lssuky
        13nW1vQpszRNRz5+QFXbT/CsyfK1YS2BQ5CVP8PnmAtmtprufRXOG7/b9U8UBd6yW1N3ujWsRO+
        gvvzP8mKpJeXkbxCgHM0v/Pbf0RfPQWza8HpIDequ+C8iTBhuK2q0bNUwrEDrIbLY3daiF3NVCV
        7vqA==
X-Received: by 2002:a17:906:5242:b0:7ad:e161:b026 with SMTP id y2-20020a170906524200b007ade161b026mr2991080ejm.760.1668090023071;
        Thu, 10 Nov 2022 06:20:23 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6WdKzcm+dNTDbiC03eiSaldoYWv/3lQLuYuf4QugPaGm598/xlsUHHFyeN7lTYGKdoJY969A==
X-Received: by 2002:a17:906:5242:b0:7ad:e161:b026 with SMTP id y2-20020a170906524200b007ade161b026mr2991067ejm.760.1668090022690;
        Thu, 10 Nov 2022 06:20:22 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (91-83-33-160.pool.digikabel.hu. [91.83.33.160])
        by smtp.gmail.com with ESMTPSA id f27-20020a17090631db00b0073ae9ba9ba8sm7227006ejf.3.2022.11.10.06.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:20:21 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        German Maglione <gmaglione@redhat.com>
Subject: [PATCH 0/2] supplementary group extension
Date:   Thu, 10 Nov 2022 15:20:18 +0100
Message-Id: <20221110142020.191487-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a protocol extension to send supplementary groups to the server.

This series just enables sending a single group (the one matching the
parent directory group) in create requests.  This should be sufficient to
allow for remote permission checking.

The protocol itself is generic and could be used to send all the groups in
all request types in the future.

Tested with the following patch against libfuse HEAD.

Thanks,
Miklos

---
Miklos Szeredi (2):
  fuse: add request extension
  fuse: optional supplementary group in create requests

 fs/fuse/dev.c             |   2 +
 fs/fuse/dir.c             | 124 +++++++++++++++++++++++++++++---------
 fs/fuse/fuse_i.h          |   9 ++-
 fs/fuse/inode.c           |   4 +-
 include/uapi/linux/fuse.h |  45 +++++++++++++-
 5 files changed, 152 insertions(+), 32 deletions(-)

-- 
2.38.1

---
 include/fuse_kernel.h   |  255 +++++++++++++++++++++++++++++++++++++++++++++---
 include/fuse_lowlevel.h |    6 +
 lib/fuse_lowlevel.c     |   48 ++++++++-
 3 files changed, 294 insertions(+), 15 deletions(-)

--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -38,6 +38,43 @@
  *
  * Protocol changelog:
  *
+ * 7.1:
+ *  - add the following messages:
+ *      FUSE_SETATTR, FUSE_SYMLINK, FUSE_MKNOD, FUSE_MKDIR, FUSE_UNLINK,
+ *      FUSE_RMDIR, FUSE_RENAME, FUSE_LINK, FUSE_OPEN, FUSE_READ, FUSE_WRITE,
+ *      FUSE_RELEASE, FUSE_FSYNC, FUSE_FLUSH, FUSE_SETXATTR, FUSE_GETXATTR,
+ *      FUSE_LISTXATTR, FUSE_REMOVEXATTR, FUSE_OPENDIR, FUSE_READDIR,
+ *      FUSE_RELEASEDIR
+ *  - add padding to messages to accommodate 32-bit servers on 64-bit kernels
+ *
+ * 7.2:
+ *  - add FOPEN_DIRECT_IO and FOPEN_KEEP_CACHE flags
+ *  - add FUSE_FSYNCDIR message
+ *
+ * 7.3:
+ *  - add FUSE_ACCESS message
+ *  - add FUSE_CREATE message
+ *  - add filehandle to fuse_setattr_in
+ *
+ * 7.4:
+ *  - add frsize to fuse_kstatfs
+ *  - clean up request size limit checking
+ *
+ * 7.5:
+ *  - add flags and max_write to fuse_init_out
+ *
+ * 7.6:
+ *  - add max_readahead to fuse_init_in and fuse_init_out
+ *
+ * 7.7:
+ *  - add FUSE_INTERRUPT message
+ *  - add POSIX file lock support
+ *
+ * 7.8:
+ *  - add lock_owner and flags fields to fuse_release_in
+ *  - add FUSE_BMAP message
+ *  - add FUSE_DESTROY message
+ *
  * 7.9:
  *  - new fuse_getattr_in input argument of GETATTR
  *  - add lk_flags in fuse_lk_in
@@ -133,6 +170,40 @@
  *
  *  7.31
  *  - add FUSE_WRITE_KILL_PRIV flag
+ *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
+ *  - add map_alignment to fuse_init_out, add FUSE_MAP_ALIGNMENT flag
+ *
+ *  7.32
+ *  - add flags to fuse_attr, add FUSE_ATTR_SUBMOUNT, add FUSE_SUBMOUNTS
+ *
+ *  7.33
+ *  - add FUSE_HANDLE_KILLPRIV_V2, FUSE_WRITE_KILL_SUIDGID, FATTR_KILL_SUIDGID
+ *  - add FUSE_OPEN_KILL_SUIDGID
+ *  - extend fuse_setxattr_in, add FUSE_SETXATTR_EXT
+ *  - add FUSE_SETXATTR_ACL_KILL_SGID
+ *
+ *  7.34
+ *  - add FUSE_SYNCFS
+ *
+ *  7.35
+ *  - add FOPEN_NOFLUSH
+ *
+ *  7.36
+ *  - extend fuse_init_in with reserved fields, add FUSE_INIT_EXT init flag
+ *  - add flags2 to fuse_init_in and fuse_init_out
+ *  - add FUSE_SECURITY_CTX init flag
+ *  - add security context to create, mkdir, symlink, and mknod requests
+ *  - add FUSE_HAS_INODE_DAX, FUSE_ATTR_DAX
+ *
+ *  7.37
+ *  - add FUSE_TMPFILE
+ *
+ *  7.38
+ *  - add FUSE_EXPIRE_ONLY flag to fuse_notify_inval_entry
+ *  - add FOPEN_PARALLEL_DIRECT_WRITES
+ *  - add total_extlen to fuse_in_header
+ *  - add FUSE_EXT_GROUPS
+ *  - add FUSE_CREATE_SUPP_GROUP
  */
 
 #ifndef _LINUX_FUSE_H
@@ -168,7 +239,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 31
+#define FUSE_KERNEL_MINOR_VERSION 38
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -192,7 +263,7 @@ struct fuse_attr {
 	uint32_t	gid;
 	uint32_t	rdev;
 	uint32_t	blksize;
-	uint32_t	padding;
+	uint32_t	flags;
 };
 
 struct fuse_kstatfs {
@@ -229,6 +300,7 @@ struct fuse_file_lock {
 #define FATTR_MTIME_NOW	(1 << 8)
 #define FATTR_LOCKOWNER	(1 << 9)
 #define FATTR_CTIME	(1 << 10)
+#define FATTR_KILL_SUIDGID	(1 << 11)
 
 /**
  * Flags returned by the OPEN request
@@ -239,6 +311,7 @@ struct fuse_file_lock {
  * FOPEN_CACHE_DIR: allow caching this directory
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
+ * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -246,6 +319,7 @@ struct fuse_file_lock {
 #define FOPEN_CACHE_DIR		(1 << 3)
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
+#define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
 
 /**
  * INIT request/reply flags
@@ -276,6 +350,23 @@ struct fuse_file_lock {
  * FUSE_CACHE_SYMLINKS: cache READLINK responses
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
+ * FUSE_MAP_ALIGNMENT: init_out.map_alignment contains log2(byte alignment) for
+ *		       foffset and moffset fields in struct
+ *		       fuse_setupmapping_out and fuse_removemapping_one.
+ * FUSE_SUBMOUNTS: kernel supports auto-mounting directory submounts
+ * FUSE_HANDLE_KILLPRIV_V2: fs kills suid/sgid/cap on write/chown/trunc.
+ *			Upon write/truncate suid/sgid is only killed if caller
+ *			does not have CAP_FSETID. Additionally upon
+ *			write/truncate sgid is killed only if file has group
+ *			execute permission. (Same as Linux VFS behavior).
+ * FUSE_SETXATTR_EXT:	Server supports extended struct fuse_setxattr_in
+ * FUSE_INIT_EXT: extended fuse_init_in request
+ * FUSE_INIT_RESERVED: reserved, do not use
+ * FUSE_SECURITY_CTX:	add security context to create, mkdir, symlink, and
+ *			mknod
+ * FUSE_HAS_INODE_DAX:  use per inode DAX
+ * FUSE_CREATE_SUPP_GROUP: add supplementary group info to create, mkdir,
+ *			symlink and mknod (single group that matches parent)
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -312,6 +403,7 @@ struct fuse_file_lock {
 /* bits 32..63 get shifted down 32 bits into the flags2 field */
 #define FUSE_SECURITY_CTX	(1ULL << 32)
 #define FUSE_HAS_INODE_DAX	(1ULL << 33)
+#define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
 
 /**
  * CUSE INIT request/reply flags
@@ -341,11 +433,14 @@ struct fuse_file_lock {
  *
  * FUSE_WRITE_CACHE: delayed write from page cache, file handle is guessed
  * FUSE_WRITE_LOCKOWNER: lock_owner field is valid
- * FUSE_WRITE_KILL_PRIV: kill suid and sgid bits
+ * FUSE_WRITE_KILL_SUIDGID: kill suid and sgid bits
  */
 #define FUSE_WRITE_CACHE	(1 << 0)
 #define FUSE_WRITE_LOCKOWNER	(1 << 1)
-#define FUSE_WRITE_KILL_PRIV	(1 << 2)
+#define FUSE_WRITE_KILL_SUIDGID (1 << 2)
+
+/* Obsolete alias; this flag implies killing suid/sgid only. */
+#define FUSE_WRITE_KILL_PRIV	FUSE_WRITE_KILL_SUIDGID
 
 /**
  * Read flags
@@ -387,6 +482,44 @@ struct fuse_file_lock {
  */
 #define FUSE_FSYNC_FDATASYNC	(1 << 0)
 
+/**
+ * fuse_attr flags
+ *
+ * FUSE_ATTR_SUBMOUNT: Object is a submount root
+ * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
+ */
+#define FUSE_ATTR_SUBMOUNT      (1 << 0)
+#define FUSE_ATTR_DAX		(1 << 1)
+
+/**
+ * Open flags
+ * FUSE_OPEN_KILL_SUIDGID: Kill suid and sgid if executable
+ */
+#define FUSE_OPEN_KILL_SUIDGID	(1 << 0)
+
+/**
+ * setxattr flags
+ * FUSE_SETXATTR_ACL_KILL_SGID: Clear SGID when system.posix_acl_access is set
+ */
+#define FUSE_SETXATTR_ACL_KILL_SGID	(1 << 0)
+
+/**
+ * notify_inval_entry flags
+ * FUSE_EXPIRE_ONLY
+ */
+#define FUSE_EXPIRE_ONLY		(1 << 0)
+
+/**
+ * extension type
+ * FUSE_MAX_NR_SECCTX: maxium value of &fuse_secctx_header.nr_secctx
+ * FUSE_EXT_GROUPS: &fuse_supp_groups extension
+ */
+enum fuse_ext_type {
+	/* Types 0..31 are reserved for fuse_secctx_header */
+	FUSE_MAX_NR_SECCTX	= 31,
+	FUSE_EXT_GROUPS		= 32,
+};
+
 enum fuse_opcode {
 	FUSE_LOOKUP		= 1,
 	FUSE_FORGET		= 2,  /* no reply */
@@ -433,9 +566,17 @@ enum fuse_opcode {
 	FUSE_RENAME2		= 45,
 	FUSE_LSEEK		= 46,
 	FUSE_COPY_FILE_RANGE	= 47,
+	FUSE_SETUPMAPPING	= 48,
+	FUSE_REMOVEMAPPING	= 49,
+	FUSE_SYNCFS		= 50,
+	FUSE_TMPFILE		= 51,
 
 	/* CUSE specific operations */
-	CUSE_INIT		= 4096
+	CUSE_INIT		= 4096,
+
+	/* Reserved opcodes: helpful to detect structure endian-ness */
+	CUSE_INIT_BSWAP_RESERVED	= 1048576,	/* CUSE_INIT << 8 */
+	FUSE_INIT_BSWAP_RESERVED	= 436207616,	/* FUSE_INIT << 24 */
 };
 
 enum fuse_notify_code {
@@ -445,7 +586,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_STORE = 4,
 	FUSE_NOTIFY_RETRIEVE = 5,
 	FUSE_NOTIFY_DELETE = 6,
-	FUSE_NOTIFY_CODE_MAX
+	FUSE_NOTIFY_CODE_MAX,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -542,14 +683,14 @@ struct fuse_setattr_in {
 
 struct fuse_open_in {
 	uint32_t	flags;
-	uint32_t	unused;
+	uint32_t	open_flags;	/* FUSE_OPEN_... */
 };
 
 struct fuse_create_in {
 	uint32_t	flags;
 	uint32_t	mode;
 	uint32_t	umask;
-	uint32_t	padding;
+	uint32_t	open_flags;	/* FUSE_OPEN_... */
 };
 
 struct fuse_open_out {
@@ -611,9 +752,13 @@ struct fuse_fsync_in {
 	uint32_t	padding;
 };
 
+#define FUSE_COMPAT_SETXATTR_IN_SIZE 8
+
 struct fuse_setxattr_in {
 	uint32_t	size;
 	uint32_t	flags;
+	uint32_t	setxattr_flags;
+	uint32_t	padding;
 };
 
 struct fuse_getxattr_in {
@@ -758,7 +903,8 @@ struct fuse_in_header {
 	uint32_t	uid;
 	uint32_t	gid;
 	uint32_t	pid;
-	uint32_t	padding;
+	uint16_t	total_extlen; /* length of extensions in 8byte units */
+	uint16_t	padding;
 };
 
 struct fuse_out_header {
@@ -775,9 +921,12 @@ struct fuse_dirent {
 	char name[];
 };
 
-#define FUSE_NAME_OFFSET offsetof(struct fuse_dirent, name)
-#define FUSE_DIRENT_ALIGN(x) \
+/* Align variable length records to 64bit boundary */
+#define FUSE_REC_ALIGN(x) \
 	(((x) + sizeof(uint64_t) - 1) & ~(sizeof(uint64_t) - 1))
+
+#define FUSE_NAME_OFFSET offsetof(struct fuse_dirent, name)
+#define FUSE_DIRENT_ALIGN(x) FUSE_REC_ALIGN(x)
 #define FUSE_DIRENT_SIZE(d) \
 	FUSE_DIRENT_ALIGN(FUSE_NAME_OFFSET + (d)->namelen)
 
@@ -800,7 +949,7 @@ struct fuse_notify_inval_inode_out {
 struct fuse_notify_inval_entry_out {
 	uint64_t	parent;
 	uint32_t	namelen;
-	uint32_t	padding;
+	uint32_t	flags;
 };
 
 struct fuse_notify_delete_out {
@@ -836,7 +985,8 @@ struct fuse_notify_retrieve_in {
 };
 
 /* Device ioctls: */
-#define FUSE_DEV_IOC_CLONE	_IOR(229, 0, uint32_t)
+#define FUSE_DEV_IOC_MAGIC		229
+#define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
@@ -859,4 +1009,83 @@ struct fuse_copy_file_range_in {
 	uint64_t	flags;
 };
 
+#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
+#define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
+struct fuse_setupmapping_in {
+	/* An already open handle */
+	uint64_t	fh;
+	/* Offset into the file to start the mapping */
+	uint64_t	foffset;
+	/* Length of mapping required */
+	uint64_t	len;
+	/* Flags, FUSE_SETUPMAPPING_FLAG_* */
+	uint64_t	flags;
+	/* Offset in Memory Window */
+	uint64_t	moffset;
+};
+
+struct fuse_removemapping_in {
+	/* number of fuse_removemapping_one follows */
+	uint32_t        count;
+};
+
+struct fuse_removemapping_one {
+	/* Offset into the dax window start the unmapping */
+	uint64_t        moffset;
+	/* Length of mapping required */
+	uint64_t	len;
+};
+
+#define FUSE_REMOVEMAPPING_MAX_ENTRY   \
+		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
+
+struct fuse_syncfs_in {
+	uint64_t	padding;
+};
+
+/*
+ * For each security context, send fuse_secctx with size of security context
+ * fuse_secctx will be followed by security context name and this in turn
+ * will be followed by actual context label.
+ * fuse_secctx, name, context
+ */
+struct fuse_secctx {
+	uint32_t	size;
+	uint32_t	padding;
+};
+
+/*
+ * Contains the information about how many fuse_secctx structures are being
+ * sent and what's the total size of all security contexts (including
+ * size of fuse_secctx_header).
+ *
+ */
+struct fuse_secctx_header {
+	uint32_t	size;
+	uint32_t	nr_secctx;
+};
+
+/**
+ * struct fuse_ext_header - extension header
+ * @size: total size of this extension including this header
+ * @type: type of extension
+ *
+ * This is made compatible with fuse_secctx_header by using type values >
+ * FUSE_MAX_NR_SECCTX
+ */
+struct fuse_ext_header {
+	uint32_t	size;
+	uint32_t	type;
+};
+
+/**
+ * struct fuse_supp_groups - Supplementary group extension
+ * @nr_groups: number of supplementary groups
+ * @groups: flexible array of group IDs
+ */
+struct fuse_supp_groups {
+	uint32_t	nr_groups;
+	uint32_t	groups[];
+};
+
 #endif /* _LINUX_FUSE_H */
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -120,6 +120,12 @@ struct fuse_ctx {
 
 	/** Umask of the calling process */
 	mode_t umask;
+
+	/** Number of supplementary groups */
+	unsigned int nr_groups;
+
+	/** Supplementary groups */
+	gid_t *groups;
 };
 
 struct fuse_forget_data {
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -125,6 +125,7 @@ static void destroy_req(fuse_req_t req)
 {
 	assert(req->ch == NULL);
 	pthread_mutex_destroy(&req->lock);
+	free(req->ctx.groups);
 	free(req);
 }
 
@@ -2108,6 +2109,8 @@ void do_init(fuse_req_t req, fuse_ino_t
 	if (se->conn.want & FUSE_CAP_EXPLICIT_INVAL_DATA)
 		outargflags |= FUSE_EXPLICIT_INVAL_DATA;
 
+	outargflags |= FUSE_CREATE_SUPP_GROUP;
+
 	if (inargflags & FUSE_INIT_EXT) {
 		outargflags |= FUSE_INIT_EXT;
 		outarg.flags2 = outargflags >> 32;
@@ -2282,7 +2285,7 @@ int fuse_lowlevel_notify_inval_entry(str
 
 	outarg.parent = parent;
 	outarg.namelen = namelen;
-	outarg.padding = 0;
+	outarg.flags = 0;
 
 	iov[1].iov_base = &outarg;
 	iov[1].iov_len = sizeof(outarg);
@@ -2560,6 +2563,40 @@ void fuse_session_process_buf(struct fus
 	fuse_session_process_buf_int(se, buf, NULL);
 }
 
+static int fuse_process_req_ext(struct fuse_req *req, struct fuse_in_header *in)
+{
+	void *end = (void *) in + in->len;
+	size_t extlen = in->total_extlen * 8;
+	struct fuse_ext_header *xh = end - extlen;
+	struct fuse_supp_groups *sg;
+	unsigned int i;
+
+	assert(extlen < in->len);
+	for (; (void *) xh < end; xh = (void *) xh + xh->size) {
+		if (xh->type == FUSE_EXT_GROUPS) {
+			sg = (void *) &xh[1];
+			req->ctx.nr_groups = sg->nr_groups;
+			req->ctx.groups = calloc(sg->nr_groups,
+						 sizeof(req->ctx.groups[0]));
+			if (!req->ctx.groups)
+				return -ENOMEM;
+
+			for (i = 0; i < sg->nr_groups; i++)
+				req->ctx.groups[i] = sg->groups[i];
+		}
+	}
+	assert(xh == end);
+
+	if (req->se->debug && req->ctx.nr_groups) {
+		fuse_log(FUSE_LOG_DEBUG, "groups: %u", req->ctx.groups[0]);
+		for (i = 1; i < req->ctx.nr_groups; i++)
+			fuse_log(FUSE_LOG_DEBUG, ", %u", req->ctx.groups[i]);
+		fuse_log(FUSE_LOG_DEBUG, "\n");
+	}
+
+	return 0;
+}
+
 void fuse_session_process_buf_int(struct fuse_session *se,
 				  const struct fuse_buf *buf, struct fuse_chan *ch)
 {
@@ -2684,8 +2721,15 @@ void fuse_session_process_buf_int(struct
 		do_write_buf(req, in->nodeid, inarg, buf);
 	else if (in->opcode == FUSE_NOTIFY_REPLY)
 		do_notify_reply(req, in->nodeid, inarg, buf);
-	else
+	else {
+		assert(buf->size == in->len);
+		res = fuse_process_req_ext(req, in);
+		err = -res;
+		if (res < 0)
+			goto reply_err;
+
 		fuse_ll_ops[in->opcode].func(req, in->nodeid, inarg);
+	}
 
 out_free:
 	free(mbuf);

