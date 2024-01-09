Return-Path: <linux-fsdevel+bounces-7605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E2D828502
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 12:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A02B254B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 11:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B5D38DE6;
	Tue,  9 Jan 2024 11:26:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out187-5.us.a.mail.aliyun.com (out187-5.us.a.mail.aliyun.com [47.90.187.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE5C38DE1
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047205;MF=winters.zc@antgroup.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---.W1wcpB2_1704792285;
Received: from localhost(mailfrom:winters.zc@antgroup.com fp:SMTPD_---.W1wcpB2_1704792285)
          by smtp.aliyun-inc.com;
          Tue, 09 Jan 2024 17:24:45 +0800
From: "Zhao Chen" <winters.zc@antgroup.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu
Subject: [PATCH v4 2/2] fuse: Use the high bit of request ID for indicating resend requests
Date: Tue, 09 Jan 2024 17:24:43 +0800
Message-Id: <20240109092443.519460-3-winters.zc@antgroup.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240109092443.519460-1-winters.zc@antgroup.com>
References: <20240109092443.519460-1-winters.zc@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some FUSE daemons want to know if the received request is a resend
request. The high bit of the fuse request ID is utilized for indicating
this, enabling the receiver to perform appropriate handling.

The init flag "FUSE_HAS_RESEND" is added to indicate this feature.

Signed-off-by: Zhao Chen <winters.zc@antgroup.com>
---
 fs/fuse/dev.c             |  5 ++++-
 fs/fuse/inode.c           |  3 ++-
 include/uapi/linux/fuse.h | 11 +++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index d3f6a24475f2..437b0b78090d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -28,6 +28,7 @@ MODULE_ALIAS("devname:fuse");
 /* Ordinary requests have even IDs, while interrupts IDs are odd */
 #define FUSE_INT_REQ_BIT (1ULL << 0)
 #define FUSE_REQ_ID_STEP (1ULL << 1)
+#define FUSE_REQ_ID_MASK (~(FUSE_INT_REQ_BIT | FUSE_UNIQUE_RESEND))
 
 static struct kmem_cache *fuse_req_cachep;
 
@@ -194,7 +195,7 @@ EXPORT_SYMBOL_GPL(fuse_len_args);
 
 u64 fuse_get_unique(struct fuse_iqueue *fiq)
 {
-	fiq->reqctr += FUSE_REQ_ID_STEP;
+	fiq->reqctr = (fiq->reqctr + FUSE_REQ_ID_STEP) & FUSE_REQ_ID_MASK;
 	return fiq->reqctr;
 }
 EXPORT_SYMBOL_GPL(fuse_get_unique);
@@ -1814,6 +1815,8 @@ static void fuse_resend(struct fuse_conn *fc)
 
 	list_for_each_entry_safe(req, next, &to_queue, list) {
 		__set_bit(FR_PENDING, &req->flags);
+		/* mark the request as resend request */
+		req->in.h.unique |= FUSE_UNIQUE_RESEND;
 	}
 
 	spin_lock(&fiq->lock);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2a6d44f91729..a4f1f539d4d9 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1330,7 +1330,8 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
-		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP;
+		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
+		FUSE_HAS_RESEND;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 277dc25b7863..c0e38acee083 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -410,6 +410,8 @@ struct fuse_file_lock {
  *			symlink and mknod (single group that matches parent)
  * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
  * FUSE_DIRECT_IO_ALLOW_MMAP: allow shared mmap in FOPEN_DIRECT_IO mode.
+ * FUSE_HAS_RESEND: kernel supports resending pending requests, and the high bit
+ *		    of the request ID indicates resend requests
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -449,6 +451,7 @@ struct fuse_file_lock {
 #define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
 #define FUSE_HAS_EXPIRE_ONLY	(1ULL << 35)
 #define FUSE_DIRECT_IO_ALLOW_MMAP (1ULL << 36)
+#define FUSE_HAS_RESEND		(1ULL << 37)
 
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
@@ -961,6 +964,14 @@ struct fuse_fallocate_in {
 	uint32_t	padding;
 };
 
+/**
+ * FUSE request unique ID flag
+ *
+ * Indicates whether this is a resend request. The receiver should handle this
+ * request accordingly.
+ */
+#define FUSE_UNIQUE_RESEND (1ULL << 63)
+
 struct fuse_in_header {
 	uint32_t	len;
 	uint32_t	opcode;
-- 
2.32.0.3.g01195cf9f


