Return-Path: <linux-fsdevel+bounces-70403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1972DC9980F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 00:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FD13A5C11
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 23:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BFF293B5F;
	Mon,  1 Dec 2025 22:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkJ340MQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90C2E427B
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629906; cv=none; b=NKNZr4NS5x1lfv61aO4karUFjHkyuulhdxO7InH2G0T0nbPPXvrkdA5NGBzwmjmxVXyEDAx/SZTNR6eVhurFzvedNjpLapuBgTiWDzKp+ajVelCOAyYb9a1pFEcnTpAbEy4ik8ht7/ti7zrAbPZZvEMHhBWILWz3/Jsk0xzInTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629906; c=relaxed/simple;
	bh=k8jYh0BI234fc0kGSaHO4a6LHOYk/SwnqwTjktiuA4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3tsiroWbsgbitgQsoGD8pXvDsuzwMsN/vlXS0Qztktmdy8myEN7h7qNFNj+UO0zzDRdZRG6OUpVBOxfeMCGvctDenYEMSVfXcwZeiIL1u2uIjsarrDGnaN9bkYXbv0AskUI8vNpDrMca8P2FwZmDirH24JI8ykbXraqeG0Pbqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UkJ340MQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764629901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ig3n4lDacU4107oHuN9fgMztG6qlnWMo9On3Lu47abI=;
	b=UkJ340MQFOCf8BwkEyfHDjwvAJGfTj37XGZoS7I6eAMGJVPwHJxUhUkF/kNUShVrhhw3Dy
	axwuQntLncCS6i/qyoBsdHYmG1qFxBKr+5qtt9X3V2KCNgZ8tcC3Rju5E5VLfj/8nc6KAd
	dvm/nVG8d/AwxeMRMkhbIxvCClIEmLo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-E-QenFeUMnS75cNOSKFv4A-1; Mon,
 01 Dec 2025 17:58:18 -0500
X-MC-Unique: E-QenFeUMnS75cNOSKFv4A-1
X-Mimecast-MFC-AGG-ID: E-QenFeUMnS75cNOSKFv4A_1764629897
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18149180048E;
	Mon,  1 Dec 2025 22:58:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DB7030001A4;
	Mon,  1 Dec 2025 22:58:14 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Stefan Metzmacher <metze@samba.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 9/9] cifs: Do some preparation prior to organising the function declarations
Date: Mon,  1 Dec 2025 22:57:30 +0000
Message-ID: <20251201225732.1520128-10-dhowells@redhat.com>
In-Reply-To: <20251201225732.1520128-1-dhowells@redhat.com>
References: <20251201225732.1520128-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Make some preparatory cleanups prior to running a script to organise the
function declarations within the fs/smb/client/ headers.  These include:

 (1) Remove "inline" from the dummy cifs_proc_init/clean() functions as
     they are in a .c file.

 (2) Move should_compress()'s kdoc comment to the .c file and remove kdoc
     markers from the comments.

 (3) Rename CIFS_ALLOW_INSECURE_LEGACY in #endif comments to have CONFIG_
     on the front to allow the script to recognise it.

 (4) Don't let comments have bare words at the left margin as that confused
     the simplistic function detection code in the script.

 (5) Adjust some argument lists so that when and if the cleanup script is
     run they don't end up over 100 chars.

 (6) Fix a few comments to have missing '*' added or the "*/" moved to
     their own lines so that checkpatch doesn't moan over the cleanup
     script patch.

 (7) Move struct cifs_calc_sig_ctx to cifsglob.h.

 (8) Remove some __KERNEL__ conditionals.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
---
 fs/smb/client/cifs_debug.c   |  4 ++--
 fs/smb/client/cifs_spnego.h  |  2 --
 fs/smb/client/cifs_unicode.h |  3 ---
 fs/smb/client/cifsfs.c       |  5 +++--
 fs/smb/client/cifsglob.h     |  8 +++++++-
 fs/smb/client/cifsproto.h    |  7 +------
 fs/smb/client/compress.c     | 21 ++++++++++++++++++---
 fs/smb/client/compress.h     | 19 ++-----------------
 fs/smb/client/dir.c          |  2 +-
 fs/smb/client/dns_resolve.h  |  4 ----
 fs/smb/client/fs_context.c   |  2 +-
 fs/smb/client/misc.c         |  1 +
 fs/smb/client/netmisc.c      |  2 +-
 fs/smb/client/smb2file.c     |  3 ++-
 fs/smb/client/smb2inode.c    |  1 -
 fs/smb/client/smb2maperror.c |  3 +--
 fs/smb/client/smb2ops.c      |  4 ++--
 fs/smb/client/smb2pdu.c      |  5 +++--
 fs/smb/client/smb2proto.h    |  2 ++
 19 files changed, 47 insertions(+), 51 deletions(-)

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index 881d3a88d683..2cb234d4bd2f 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -1318,11 +1318,11 @@ static const struct proc_ops cifs_mount_params_proc_ops = {
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
diff --git a/fs/smb/client/cifs_spnego.h b/fs/smb/client/cifs_spnego.h
index e4d751b0c812..e70929db3611 100644
--- a/fs/smb/client/cifs_spnego.h
+++ b/fs/smb/client/cifs_spnego.h
@@ -27,10 +27,8 @@ struct cifs_spnego_msg {
 	uint8_t		data[];
 };
 
-#ifdef __KERNEL__
 extern struct key_type cifs_spnego_key_type;
 extern struct key *cifs_get_spnego_key(struct cifs_ses *sesInfo,
 				       struct TCP_Server_Info *server);
-#endif /* KERNEL */
 
 #endif /* _CIFS_SPNEGO_H */
diff --git a/fs/smb/client/cifs_unicode.h b/fs/smb/client/cifs_unicode.h
index e137a0dfbbe9..6e4b99786498 100644
--- a/fs/smb/client/cifs_unicode.h
+++ b/fs/smb/client/cifs_unicode.h
@@ -54,7 +54,6 @@
 #define SFM_MAP_UNI_RSVD	1
 #define SFU_MAP_UNI_RSVD	2
 
-#ifdef __KERNEL__
 int cifs_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
 		    const struct nls_table *cp, int map_type);
 int cifs_utf16_bytes(const __le16 *from, int maxbytes,
@@ -69,8 +68,6 @@ extern int cifs_remap(struct cifs_sb_info *cifs_sb);
 extern __le16 *cifs_strndup_to_utf16(const char *src, const int maxlen,
 				     int *utf16_len, const struct nls_table *cp,
 				     int remap);
-#endif
-
 wchar_t cifs_toupper(wchar_t in);
 
 #endif /* _CIFS_UNICODE_H */
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 44d3dec9743b..00eef3a6dc0e 100644
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
index a8cfe9b87a20..f9c1f553ffd0 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -2118,7 +2118,7 @@ extern struct smb_version_operations smb1_operations;
 extern struct smb_version_values smb1_values;
 extern struct smb_version_operations smb20_operations;
 extern struct smb_version_values smb20_values;
-#endif /* CIFS_ALLOW_INSECURE_LEGACY */
+#endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 extern struct smb_version_operations smb21_operations;
 extern struct smb_version_values smb21_values;
 extern struct smb_version_values smbdefault_values;
@@ -2286,4 +2286,10 @@ static inline void mid_execute_callback(struct TCP_Server_Info *server,
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
index 5d54de12f0f4..823ca4f36914 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -594,7 +594,7 @@ extern int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 			   const struct nls_table *nls_codepage, int remap);
 extern int CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
 			const int netfid, __u64 *pExtAttrBits, __u64 *pMask);
-#endif /* CIFS_ALLOW_INSECURE_LEGACY */
+#endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 extern void cifs_autodisable_serverino(struct cifs_sb_info *cifs_sb);
 extern bool couldbe_mf_symlink(const struct cifs_fattr *fattr);
 extern int check_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
@@ -626,11 +626,6 @@ int cifs_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
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
diff --git a/fs/smb/client/compress.c b/fs/smb/client/compress.c
index f03dd9804427..e0c44b46080e 100644
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
index f3ed1d3e52fb..63aea32fbe92 100644
--- a/fs/smb/client/compress.h
+++ b/fs/smb/client/compress.h
@@ -29,26 +29,11 @@
 #ifdef CONFIG_CIFS_COMPRESSION
 typedef int (*compress_send_fn)(struct TCP_Server_Info *, int, struct smb_rqst *);
 
-int smb_compress(struct TCP_Server_Info *server, struct smb_rqst *rq, compress_send_fn send_fn);
 
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
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 4ad69dc77e09..747256025e49 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -457,7 +457,7 @@ static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned
 
 int
 cifs_atomic_open(struct inode *inode, struct dentry *direntry,
-		 struct file *file, unsigned oflags, umode_t mode)
+		 struct file *file, unsigned int oflags, umode_t mode)
 {
 	int rc;
 	unsigned int xid;
diff --git a/fs/smb/client/dns_resolve.h b/fs/smb/client/dns_resolve.h
index 0dc706f2c422..36bc4a6a55bf 100644
--- a/fs/smb/client/dns_resolve.h
+++ b/fs/smb/client/dns_resolve.h
@@ -15,8 +15,6 @@
 #include "cifsglob.h"
 #include "cifsproto.h"
 
-#ifdef __KERNEL__
-
 int dns_resolve_name(const char *dom, const char *name,
 		     size_t namelen, struct sockaddr *ip_addr);
 
@@ -36,6 +34,4 @@ static inline int dns_resolve_unc(const char *dom, const char *unc,
 	return dns_resolve_name(dom, name, namelen, ip_addr);
 }
 
-#endif /* KERNEL */
-
 #endif /* _DNS_RESOLVE_H */
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 2a0d8b87bd8e..0a96bd9d0a16 100644
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
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index eb7368367c14..9529fa385938 100644
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
diff --git a/fs/smb/client/netmisc.c b/fs/smb/client/netmisc.c
index e5a465a018c0..ae15f0bef009 100644
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
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index 68d37f11f3f3..7f11ae6bb785 100644
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
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 3e45e41f5713..2ded3246600c 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -21,7 +21,6 @@
 #include "cifs_unicode.h"
 #include "fscache.h"
 #include "smb2glob.h"
-#include "smb2pdu.h"
 #include "smb2proto.h"
 #include "cached_dir.h"
 #include "../common/smb2status.h"
diff --git a/fs/smb/client/smb2maperror.c b/fs/smb/client/smb2maperror.c
index b179d7369fba..4fc22456c39e 100644
--- a/fs/smb/client/smb2maperror.c
+++ b/fs/smb/client/smb2maperror.c
@@ -11,10 +11,9 @@
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "cifs_debug.h"
-#include "smb2pdu.h"
 #include "smb2proto.h"
-#include "../common/smb2status.h"
 #include "smb2glob.h"
+#include "../common/smb2status.h"
 #include "trace.h"
 
 struct status_to_posix_error {
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 3328d6a89038..a16ded46b5a2 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -17,9 +17,9 @@
 #include <uapi/linux/magic.h>
 #include "cifsfs.h"
 #include "cifsglob.h"
-#include "smb2pdu.h"
-#include "smb2proto.h"
 #include "cifsproto.h"
+#include "smb2proto.h"
+#include "smb2pdu.h"
 #include "cifs_debug.h"
 #include "cifs_unicode.h"
 #include "../common/smb2status.h"
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 1aefe5079362..2a822a5188aa 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -26,8 +26,8 @@
 #include <linux/netfs.h>
 #include <trace/events/netfs.h>
 #include "cifsglob.h"
-#include "cifsacl.h"
 #include "cifsproto.h"
+#include "cifsacl.h"
 #include "smb2proto.h"
 #include "cifs_unicode.h"
 #include "cifs_debug.h"
@@ -3949,7 +3949,8 @@ int SMB2_query_info(const unsigned int xid, struct cifs_tcon *tcon,
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
index 441df217c796..152e888512aa 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -9,8 +9,10 @@
  */
 #ifndef _SMB2PROTO_H
 #define _SMB2PROTO_H
+
 #include <linux/nls.h>
 #include <linux/key-type.h>
+#include "cached_dir.h"
 
 struct statfs;
 struct smb_rqst;


