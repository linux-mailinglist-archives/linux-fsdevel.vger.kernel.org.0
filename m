Return-Path: <linux-fsdevel+bounces-69600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72866C7E9EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 00:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC2EF344617
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 23:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA7C254AE1;
	Sun, 23 Nov 2025 23:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRQOtud8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2339023ABA9
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763941983; cv=none; b=D1mmbUup2udgisAKUpGVgg4zbggt0BmoPPGvQWDLAekbadYdLK0izZFmisxakNhCKjHIYvk4KB3zTj6afh/DuO5kWdY3lZxQ6RK6HV+AWYX+bQU0DzwNgmWA85GRh4/BnbzROIUcOoVlLRHz8/Kf7OaJZ8rpWbosb8SPfUjFmcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763941983; c=relaxed/simple;
	bh=it4y4o4ZoWWtwGSENe9/bdGZDFzypoRd1JPYspGsGzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYvXDjKhTeHcswxvKv3sT4eKzvePMeLN4LRq4zsvBnm0EvhVjsChJcorz3BF7zg96tntxYifQYg7jx8NGvy2jCt2tPJlU1Ha+ckN1ni0ywdX0XUVqOLIrptgJT7pc5Yo1EFmaIjRv/9lguVXHkQgGgIT8ETMesSB7+G6OQ2bT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRQOtud8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763941980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7k7Yeowxqm1Xzo2ObbiaRIMOUXxrHTXydH1NWoFTWTc=;
	b=IRQOtud8vli3Xveb5MQzr3XWumgc2zRoUeQQ9Hzf7QRcUluM9kLf54GgYgqXGDscyOgFL+
	esI9pnwbQxhX+vS5IE7zoYGnbkM3orYV9zY5+GwDCQ+z3Vohrzbt5/2mro9bb+hWEYZoQD
	nOlv3BeWdctpqbyGZguQ/ID20obIsqw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-mqGLciFzNCK3nLx7fb3cwg-1; Sun,
 23 Nov 2025 18:52:54 -0500
X-MC-Unique: mqGLciFzNCK3nLx7fb3cwg-1
X-Mimecast-MFC-AGG-ID: mqGLciFzNCK3nLx7fb3cwg_1763941972
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2FA41800451;
	Sun, 23 Nov 2025 23:52:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98B6C3003761;
	Sun, 23 Nov 2025 23:52:49 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Stefan Metzmacher <metze@samba.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/12] cifs: Do some preparation prior to organising the function declarations
Date: Sun, 23 Nov 2025 23:52:28 +0000
Message-ID: <20251123235242.3361706-2-dhowells@redhat.com>
In-Reply-To: <20251123235242.3361706-1-dhowells@redhat.com>
References: <20251123235242.3361706-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Make some preparatory changes prior to running a script to organise the
function declarations within the fs/smb/client/ headers.  These include:

 (1) Creating an smb1proto.h file and #including it in places that will
     need it.  It will be populated by a script in a follow on patch.

 (2) Insert a line saying "/* PROTOTYPES */" in the target headers to set
     the point at which prototypes should be inserted in that file.

 (3) Remove "inline" from the dummy cifs_proc_init/clean() functions as
     they are in a .c file.

 (4) Move should_compress()'s kdoc comment to the .c file and remove kdoc
     markers from the comments.

 (5) Rename CIFS_ALLOW_INSECURE_LEGACY in #endif comments to have CONFIG_
     on the front to allow the script to recognise it.

 (6) Don't let comments have bare words at the left margin as that confused
     the simplistic function detection code in the script.

 (7) Adjust some argument lists so that when the cleanup script is run they
     don't end up over 100 chars.

 (8) Fix a few comments to have missing '*' added or the "*/" moved to
     their own lines so that checkpatch doesn't moan over the cleanup
     script patch.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
---
 fs/smb/client/cached_dir.h    |  1 +
 fs/smb/client/cifs_debug.c    |  4 ++--
 fs/smb/client/cifs_debug.h    |  2 ++
 fs/smb/client/cifs_swn.h      |  2 ++
 fs/smb/client/cifs_unicode.c  |  1 +
 fs/smb/client/cifsacl.c       |  1 +
 fs/smb/client/cifsfs.c        |  5 +++--
 fs/smb/client/cifsglob.h      |  8 +++++++-
 fs/smb/client/cifsproto.h     | 14 ++------------
 fs/smb/client/cifssmb.c       |  1 +
 fs/smb/client/cifstransport.c |  1 +
 fs/smb/client/compress.c      | 21 ++++++++++++++++++---
 fs/smb/client/compress.h      | 20 +++-----------------
 fs/smb/client/connect.c       |  1 +
 fs/smb/client/dir.c           |  3 ++-
 fs/smb/client/file.c          |  1 +
 fs/smb/client/fs_context.c    |  2 +-
 fs/smb/client/fscache.h       |  4 +---
 fs/smb/client/inode.c         |  1 +
 fs/smb/client/ioctl.c         |  1 +
 fs/smb/client/link.c          |  1 +
 fs/smb/client/misc.c          |  3 ++-
 fs/smb/client/netlink.h       |  1 +
 fs/smb/client/netmisc.c       |  2 +-
 fs/smb/client/sess.c          |  1 +
 fs/smb/client/smb1ops.c       |  2 ++
 fs/smb/client/smb1proto.h     | 20 ++++++++++++++++++++
 fs/smb/client/smb2file.c      |  3 ++-
 fs/smb/client/smb2pdu.c       |  3 ++-
 fs/smb/client/smb2proto.h     |  9 ++++-----
 fs/smb/client/smbdirect.h     |  2 ++
 31 files changed, 90 insertions(+), 51 deletions(-)
 create mode 100644 fs/smb/client/smb1proto.h

diff --git a/fs/smb/client/cached_dir.h b/fs/smb/client/cached_dir.h
index 1e383db7c337..b843442db2d4 100644
--- a/fs/smb/client/cached_dir.h
+++ b/fs/smb/client/cached_dir.h
@@ -77,6 +77,7 @@ is_valid_cached_dir(struct cached_fid *cfid)
 	return cfid->time && cfid->has_lease;
 }
 
+/* PROTOTYPES */
 extern struct cached_fids *init_cached_dirs(void);
 extern void free_cached_dirs(struct cached_fids *cfids);
 extern int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index 1fb71d2d31b5..08538ad0f8dc 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -1307,11 +1307,11 @@ static const struct proc_ops cifs_mount_params_proc_ops = {
 };
 
 #else
-inline void cifs_proc_init(void)
+void cifs_proc_init(void)
 {
 }
 
-inline void cifs_proc_clean(void)
+void cifs_proc_clean(void)
 {
 }
 #endif /* PROC_FS */
diff --git a/fs/smb/client/cifs_debug.h b/fs/smb/client/cifs_debug.h
index ce5cfd236fdb..526afdb33cc6 100644
--- a/fs/smb/client/cifs_debug.h
+++ b/fs/smb/client/cifs_debug.h
@@ -14,6 +14,8 @@
 
 #define pr_fmt(fmt) "CIFS: " fmt
 
+/* PROTOTYPES */
+
 void cifs_dump_mem(char *label, void *data, int length);
 void cifs_dump_detail(void *buf, struct TCP_Server_Info *ptcp_info);
 void cifs_dump_mids(struct TCP_Server_Info *);
diff --git a/fs/smb/client/cifs_swn.h b/fs/smb/client/cifs_swn.h
index 8a9d2a5c9077..7063539c41c8 100644
--- a/fs/smb/client/cifs_swn.h
+++ b/fs/smb/client/cifs_swn.h
@@ -14,6 +14,8 @@ struct sk_buff;
 struct genl_info;
 
 #ifdef CONFIG_CIFS_SWN_UPCALL
+
+/* PROTOTYPES */
 extern int cifs_swn_register(struct cifs_tcon *tcon);
 
 extern int cifs_swn_unregister(struct cifs_tcon *tcon);
diff --git a/fs/smb/client/cifs_unicode.c b/fs/smb/client/cifs_unicode.c
index f8659d36793f..f9d519ed3a37 100644
--- a/fs/smb/client/cifs_unicode.c
+++ b/fs/smb/client/cifs_unicode.c
@@ -9,6 +9,7 @@
 #include "cifs_fs_sb.h"
 #include "cifs_unicode.h"
 #include "cifspdu.h"
+#include "cifsproto.h"
 #include "cifsglob.h"
 #include "cifs_debug.h"
 
diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index ce2ebc213a1d..7b88ef38bdf4 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -21,6 +21,7 @@
 #include "cifsglob.h"
 #include "cifsacl.h"
 #include "cifsproto.h"
+#include "smb1proto.h"
 #include "cifs_debug.h"
 #include "fs_context.h"
 #include "cifs_fs_sb.h"
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 185ac41bd7e9..cbb34e3e2862 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -28,6 +28,8 @@
 #include <linux/splice.h>
 #include <linux/uuid.h>
 #include <linux/xattr.h>
+#include <linux/mm.h>
+#include <linux/key-type.h>
 #include <uapi/linux/magic.h>
 #include <net/ipv6.h>
 #include "cifsfs.h"
@@ -35,10 +37,9 @@
 #define DECLARE_GLOBALS_HERE
 #include "cifsglob.h"
 #include "cifsproto.h"
+#include "smb2proto.h"
 #include "cifs_debug.h"
 #include "cifs_fs_sb.h"
-#include <linux/mm.h>
-#include <linux/key-type.h>
 #include "cifs_spnego.h"
 #include "fscache.h"
 #ifdef CONFIG_CIFS_DFS_UPCALL
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 0c76e0a31386..f859c5407fbc 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -2114,7 +2114,7 @@ extern struct smb_version_operations smb1_operations;
 extern struct smb_version_values smb1_values;
 extern struct smb_version_operations smb20_operations;
 extern struct smb_version_values smb20_values;
-#endif /* CIFS_ALLOW_INSECURE_LEGACY */
+#endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 extern struct smb_version_operations smb21_operations;
 extern struct smb_version_values smb21_values;
 extern struct smb_version_values smbdefault_values;
@@ -2369,4 +2369,10 @@ static inline void mid_execute_callback(struct mid_q_entry *mid)
 	 (le32_to_cpu((tcon)->fsAttrInfo.Attributes) & \
 	  FILE_SUPPORTS_REPARSE_POINTS))
 
+struct cifs_calc_sig_ctx {
+	struct md5_ctx *md5;
+	struct hmac_sha256_ctx *hmac;
+	struct shash_desc *shash;
+};
+
 #endif	/* _CIFS_GLOB_H */
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 3528c365a452..7ec2623cf2a0 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -9,7 +9,6 @@
 #define _CIFSPROTO_H
 #include <linux/nls.h>
 #include <linux/ctype.h>
-#include "cifsglob.h"
 #include "trace.h"
 #ifdef CONFIG_CIFS_DFS_UPCALL
 #include "dfs_cache.h"
@@ -19,11 +18,7 @@ struct statfs;
 struct smb_rqst;
 struct smb3_fs_context;
 
-/*
- *****************************************************************
- * All Prototypes
- *****************************************************************
- */
+/* PROTOTYPES */
 
 extern struct smb_hdr *cifs_buf_get(void);
 extern void cifs_buf_release(void *);
@@ -603,7 +598,7 @@ extern int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 			   const struct nls_table *nls_codepage, int remap);
 extern int CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
 			const int netfid, __u64 *pExtAttrBits, __u64 *pMask);
-#endif /* CIFS_ALLOW_INSECURE_LEGACY */
+#endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 extern void cifs_autodisable_serverino(struct cifs_sb_info *cifs_sb);
 extern bool couldbe_mf_symlink(const struct cifs_fattr *fattr);
 extern int check_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
@@ -635,11 +630,6 @@ int cifs_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 			   struct cifs_sb_info *cifs_sb,
 			   const unsigned char *path, char *pbuf,
 			   unsigned int *pbytes_written);
-struct cifs_calc_sig_ctx {
-	struct md5_ctx *md5;
-	struct hmac_sha256_ctx *hmac;
-	struct shash_desc *shash;
-};
 int __cifs_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 			  char *signature, struct cifs_calc_sig_ctx *ctx);
 enum securityEnum cifs_select_sectype(struct TCP_Server_Info *,
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 257a6beb4b7d..6bb0ec6420d2 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -31,6 +31,7 @@
 #include "cifsglob.h"
 #include "cifsacl.h"
 #include "cifsproto.h"
+#include "smb1proto.h"
 #include "cifs_unicode.h"
 #include "cifs_debug.h"
 #include "fscache.h"
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index 4c4f5befb6d3..9b3711af6038 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -26,6 +26,7 @@
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "cifs_debug.h"
+#include "smb1proto.h"
 #include "smb2proto.h"
 #include "smbdirect.h"
 #include "compress.h"
diff --git a/fs/smb/client/compress.c b/fs/smb/client/compress.c
index db709f5cd2e1..fb2a48f1d2ad 100644
--- a/fs/smb/client/compress.c
+++ b/fs/smb/client/compress.c
@@ -44,7 +44,7 @@ struct bucket {
 	unsigned int count;
 };
 
-/**
+/*
  * has_low_entropy() - Compute Shannon entropy of the sampled data.
  * @bkt:	Bytes counts of the sample.
  * @slen:	Size of the sample.
@@ -82,7 +82,7 @@ static bool has_low_entropy(struct bucket *bkt, size_t slen)
 #define BYTE_DIST_BAD		0
 #define BYTE_DIST_GOOD		1
 #define BYTE_DIST_MAYBE		2
-/**
+/*
  * calc_byte_distribution() - Compute byte distribution on the sampled data.
  * @bkt:	Byte counts of the sample.
  * @slen:	Size of the sample.
@@ -182,7 +182,7 @@ static int collect_sample(const struct iov_iter *source, ssize_t max, u8 *sample
 	return s;
 }
 
-/**
+/*
  * is_compressible() - Determines if a chunk of data is compressible.
  * @data: Iterator containing uncompressed data.
  *
@@ -261,6 +261,21 @@ static bool is_compressible(const struct iov_iter *data)
 	return ret;
 }
 
+/*
+ * should_compress() - Determines if a request (write) or the response to a
+ *		       request (read) should be compressed.
+ * @tcon: tcon of the request is being sent to
+ * @rqst: request to evaluate
+ *
+ * Return: true iff:
+ * - compression was successfully negotiated with server
+ * - server has enabled compression for the share
+ * - it's a read or write request
+ * - (write only) request length is >= SMB_COMPRESS_MIN_LEN
+ * - (write only) is_compressible() returns 1
+ *
+ * Return false otherwise.
+ */
 bool should_compress(const struct cifs_tcon *tcon, const struct smb_rqst *rq)
 {
 	const struct smb2_hdr *shdr = rq->rq_iov->iov_base;
diff --git a/fs/smb/client/compress.h b/fs/smb/client/compress.h
index f3ed1d3e52fb..d843274e2a3d 100644
--- a/fs/smb/client/compress.h
+++ b/fs/smb/client/compress.h
@@ -29,26 +29,12 @@
 #ifdef CONFIG_CIFS_COMPRESSION
 typedef int (*compress_send_fn)(struct TCP_Server_Info *, int, struct smb_rqst *);
 
-int smb_compress(struct TCP_Server_Info *server, struct smb_rqst *rq, compress_send_fn send_fn);
+/* PROTOTYPES */
 
-/**
- * should_compress() - Determines if a request (write) or the response to a
- *		       request (read) should be compressed.
- * @tcon: tcon of the request is being sent to
- * @rqst: request to evaluate
- *
- * Return: true iff:
- * - compression was successfully negotiated with server
- * - server has enabled compression for the share
- * - it's a read or write request
- * - (write only) request length is >= SMB_COMPRESS_MIN_LEN
- * - (write only) is_compressible() returns 1
- *
- * Return false otherwise.
- */
+int smb_compress(struct TCP_Server_Info *server, struct smb_rqst *rq, compress_send_fn send_fn);
 bool should_compress(const struct cifs_tcon *tcon, const struct smb_rqst *rq);
 
-/**
+/*
  * smb_compress_alg_valid() - Validate a compression algorithm.
  * @alg: Compression algorithm to check.
  * @valid_none: Conditional check whether NONE algorithm should be
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index f236f4e3b128..338f11a9e4ad 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -42,6 +42,7 @@
 #include "nterr.h"
 #include "rfc1002pdu.h"
 #include "fscache.h"
+#include "smb1proto.h"
 #include "smb2proto.h"
 #include "smbdirect.h"
 #include "dns_resolve.h"
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index da5597dbf5b9..2cf0c4f1746d 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -17,6 +17,7 @@
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
+#include "smb1proto.h"
 #include "cifs_debug.h"
 #include "cifs_fs_sb.h"
 #include "cifs_unicode.h"
@@ -457,7 +458,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 
 int
 cifs_atomic_open(struct inode *inode, struct dentry *direntry,
-		 struct file *file, unsigned oflags, umode_t mode)
+		 struct file *file, unsigned int oflags, umode_t mode)
 {
 	int rc;
 	unsigned int xid;
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 474dadeb1593..0939b91c5acc 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -27,6 +27,7 @@
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
+#include "smb1proto.h"
 #include "smb2proto.h"
 #include "cifs_unicode.h"
 #include "cifs_debug.h"
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 0f894d09157b..5843f8adaa18 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -505,7 +505,7 @@ cifs_parse_smb_version(struct fs_context *fc, char *value, struct smb3_fs_contex
 	case Smb_20:
 		cifs_errorf(fc, "vers=2.0 mount not permitted when legacy dialects disabled\n");
 		return 1;
-#endif /* CIFS_ALLOW_INSECURE_LEGACY */
+#endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 	case Smb_21:
 		ctx->ops = &smb21_operations;
 		ctx->vals = &smb21_values;
diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
index f06cb24f5f3c..162865381dac 100644
--- a/fs/smb/client/fscache.h
+++ b/fs/smb/client/fscache.h
@@ -35,9 +35,7 @@ struct cifs_fscache_inode_coherency_data {
 
 #ifdef CONFIG_CIFS_FSCACHE
 
-/*
- * fscache.c
- */
+/* PROTOTYPES */
 extern int cifs_fscache_get_super_cookie(struct cifs_tcon *);
 extern void cifs_fscache_release_super_cookie(struct cifs_tcon *);
 
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index c2ac39d89df2..a6489517495d 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -18,6 +18,7 @@
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
+#include "smb1proto.h"
 #include "smb2proto.h"
 #include "cifs_debug.h"
 #include "cifs_fs_sb.h"
diff --git a/fs/smb/client/ioctl.c b/fs/smb/client/ioctl.c
index 0a9935ce05a5..356dd46b017b 100644
--- a/fs/smb/client/ioctl.c
+++ b/fs/smb/client/ioctl.c
@@ -19,6 +19,7 @@
 #include "cifs_debug.h"
 #include "cifsfs.h"
 #include "cifs_ioctl.h"
+#include "smb1proto.h"
 #include "smb2proto.h"
 #include "smb2glob.h"
 #include <linux/btrfs.h>
diff --git a/fs/smb/client/link.c b/fs/smb/client/link.c
index 70f3c0c67eeb..d92eb14b97dd 100644
--- a/fs/smb/client/link.c
+++ b/fs/smb/client/link.c
@@ -17,6 +17,7 @@
 #include "cifs_debug.h"
 #include "cifs_fs_sb.h"
 #include "cifs_unicode.h"
+#include "smb1proto.h"
 #include "smb2proto.h"
 #include "cifs_ioctl.h"
 #include "fs_context.h"
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 340c44dc7b5b..8967c771bdb2 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -18,6 +18,7 @@
 #include "nterr.h"
 #include "cifs_unicode.h"
 #include "smb2pdu.h"
+#include "smb2proto.h"
 #include "cifsfs.h"
 #ifdef CONFIG_CIFS_DFS_UPCALL
 #include "dns_resolve.h"
@@ -265,7 +266,7 @@ free_rsp_buf(int resp_buftype, void *rsp)
 /* NB: MID can not be set if treeCon not passed in, in that
    case it is responsibility of caller to set the mid */
 void
-header_assemble(struct smb_hdr *buffer, char smb_command /* command */ ,
+header_assemble(struct smb_hdr *buffer, char smb_command,
 		const struct cifs_tcon *treeCon, int word_count
 		/* length of fixed section (word count) in two byte units  */)
 {
diff --git a/fs/smb/client/netlink.h b/fs/smb/client/netlink.h
index e2fa8ed24c54..9d73b23858b8 100644
--- a/fs/smb/client/netlink.h
+++ b/fs/smb/client/netlink.h
@@ -10,6 +10,7 @@
 
 extern struct genl_family cifs_genl_family;
 
+/* PROTOTYPES */
 extern int cifs_genl_init(void);
 extern void cifs_genl_exit(void);
 
diff --git a/fs/smb/client/netmisc.c b/fs/smb/client/netmisc.c
index 9ec20601cee2..4e0bb1920eae 100644
--- a/fs/smb/client/netmisc.c
+++ b/fs/smb/client/netmisc.c
@@ -200,7 +200,7 @@ cifs_set_port(struct sockaddr *addr, const unsigned short int port)
 }
 
 /*****************************************************************************
-convert a NT status code to a dos class/code
+ *convert a NT status code to a dos class/code
  *****************************************************************************/
 /* NT status -> dos error map */
 static const struct {
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index ef3b498b0a02..8af53f9b3675 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -20,6 +20,7 @@
 #include <linux/version.h>
 #include "cifsfs.h"
 #include "cifs_spnego.h"
+#include "smb1proto.h"
 #include "smb2proto.h"
 #include "fs_context.h"
 
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index a15ebd3f0d50..3af1e19e6a80 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -10,6 +10,8 @@
 #include <uapi/linux/magic.h>
 #include "cifsglob.h"
 #include "cifsproto.h"
+#include "smb1proto.h"
+#include "smb2proto.h"
 #include "cifs_debug.h"
 #include "cifspdu.h"
 #include "cifs_unicode.h"
diff --git a/fs/smb/client/smb1proto.h b/fs/smb/client/smb1proto.h
new file mode 100644
index 000000000000..68ab0447b671
--- /dev/null
+++ b/fs/smb/client/smb1proto.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
+/*
+ *
+ *   Copyright (c) International Business Machines  Corp., 2002,2008
+ *   Author(s): Steve French (sfrench@us.ibm.com)
+ *
+ */
+#ifndef _SMB1PROTO_H
+#define _SMB1PROTO_H
+
+#include <linux/nls.h>
+#include <linux/ctype.h>
+#include "trace.h"
+#ifdef CONFIG_CIFS_DFS_UPCALL
+#include "dfs_cache.h"
+#endif
+
+/* PROTOTYPES */
+
+#endif /* _SMB1PROTO_H */
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index a7f629238830..66e5d6f9e3b7 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -140,7 +140,8 @@ int smb2_parse_symlink_response(struct cifs_sb_info *cifs_sb, const struct kvec
 					 cifs_sb);
 }
 
-int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms, __u32 *oplock, void *buf)
+int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms,
+		   __u32 *oplock, void *buf)
 {
 	int rc;
 	__le16 *smb2_path;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index ef2c6ac500f7..4ec61f4f90be 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3913,7 +3913,8 @@ int SMB2_query_info(const unsigned int xid, struct cifs_tcon *tcon,
 /* currently unused, as now we are doing compounding instead (see smb311_posix_query_path_info) */
 int
 SMB311_posix_query_info(const unsigned int xid, struct cifs_tcon *tcon,
-		u64 persistent_fid, u64 volatile_fid, struct smb311_posix_qinfo *data, u32 *plen)
+			u64 persistent_fid, u64 volatile_fid,
+			struct smb311_posix_qinfo *data, u32 *plen)
 {
 	size_t output_len = sizeof(struct smb311_posix_qinfo *) +
 			(sizeof(struct smb_sid) * 2) + (PATH_MAX * 2);
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 5241daaae543..dca9bc875f8d 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -9,17 +9,16 @@
  */
 #ifndef _SMB2PROTO_H
 #define _SMB2PROTO_H
+
 #include <linux/nls.h>
 #include <linux/key-type.h>
+#include "cached_dir.h"
 
 struct statfs;
 struct smb_rqst;
 
-/*
- *****************************************************************
- * All Prototypes
- *****************************************************************
- */
+/* PROTOTYPES */
+
 extern int map_smb2_to_linux_error(char *buf, bool log_err);
 extern int smb2_check_message(char *buf, unsigned int length,
 			      struct TCP_Server_Info *server);
diff --git a/fs/smb/client/smbdirect.h b/fs/smb/client/smbdirect.h
index 577d37dbeb8a..73822800e36c 100644
--- a/fs/smb/client/smbdirect.h
+++ b/fs/smb/client/smbdirect.h
@@ -62,6 +62,8 @@ struct smbdirect_mr_io *smbd_register_mr(
 	bool writing, bool need_invalidate);
 void smbd_deregister_mr(struct smbdirect_mr_io *mr);
 
+/* PROTOTYPES */
+
 #else
 #define cifs_rdma_enabled(server)	0
 struct smbd_connection {};


