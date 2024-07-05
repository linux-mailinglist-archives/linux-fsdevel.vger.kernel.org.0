Return-Path: <linux-fsdevel+bounces-23192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD7C928658
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 12:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B874E284CE0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB09514659F;
	Fri,  5 Jul 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IfU3jKQt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B643213B5BB;
	Fri,  5 Jul 2024 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720173896; cv=none; b=RkDlx2C9W6SV13IMy+L5tXkvd2TrG/Yz7m/Lv17+2MsYddXtRddNnfHq4bOfGVJZx6q+b1VxesWtmE4lds0+442C2TXVuP1Jaq9YiGm7al+DpPBlIelPZhMXpuel7Up6SaStTJ5MaW/95kXjRzh7wYIWBEIdHxEYXmH0GtlSOg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720173896; c=relaxed/simple;
	bh=F7nUwAR8SeYGFj74FbaBXKFyLdvn5T8izhlRdu/CSvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qKIcOw88E45+BioX8d88FYDvuvQ7UMfKviEieQS1tkSl5VkST/Zm2+zTosxW9GQNW7d+eE7Bs5n1Gr4o9qmtlMsqiw9II0BYoIJTBuyT0tTIIl8boOkdUBFdBYh30C6RI0COOYDMXUZ4KCrcDT3a6vt4EZoWFXXCiqV2dhNWEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IfU3jKQt; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720173890; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=YZdiToWG6qpYt+f0otSLNv0meCfVIiY67seAf3aZq88=;
	b=IfU3jKQtgvr56xK+ZeiV6EKZktynjTjsLDbK3K3r2g5FwQ92fnWoM2qgsnX09GBpaWRfmn1pfwzXxuWUqyfripZcVmtjGBd00cmZbVowLy7KoQKKQIA+ure2n7vITI05RcUrDudEutqy5IECDcdvZxAIl+tnYhxDohC+GhQyKNA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W9ubLef_1720173889;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W9ubLef_1720173889)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 18:04:50 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: make foffset alignment opt-in for optimum backend performance
Date: Fri,  5 Jul 2024 18:04:49 +0800
Message-Id: <20240705100449.60891-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes the file offset alignment needs to be opt-in to achieve the
optimum performance at the backend store.

For example when ErasureCode [1] is used at the backend store, the
optimum write performance is achieved when the WRITE request is aligned
with the stripe size of ErasureCode.  Otherwise a non-aligned WRITE
request needs to be split at the stripe size boundary.  It is quite
costly to handle these split partial requests, as firstly the whole
stripe to which the split partial request belongs needs to be read out,
then overwrite the read stripe buffer with the request, and finally write
the whole stripe back to the persistent storage.

Thus the backend store can suffer severe performance degradation when
WRITE requests can not fit into one stripe exactly.  The write performance
can be 10x slower when the request is 256KB in size given 4MB stripe size.
Also there can be 50% performance degradation in theory if the request
is not stripe boundary aligned.

Besides, the conveyed test indicates that, the non-alignment issue
becomes more severe when decreasing fuse's max_ratio, maybe partly
because the background writeback now is more likely to run parallelly
with the dirtier.

fuse's max_ratio	ratio of aligned WRITE requests
----------------	-------------------------------
70			99.9%
40			74%
20			45%
10			20%

With the patched version, which makes the alignment constraint opt-in
when constructing WRITE requests, the ratio of aligned WRITE requests
increases to 98% (previously 20%) when fuse's max_ratio is 10.

[1] https://lore.kernel.org/linux-fsdevel/20240124070512.52207-1-jefflexu@linux.alibaba.com/T/#m9bce469998ea6e4f911555c6f7be1e077ce3d8b4
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/file.c            | 4 ++++
 fs/fuse/fuse_i.h          | 6 ++++++
 fs/fuse/inode.c           | 9 +++++++++
 include/uapi/linux/fuse.h | 9 ++++++++-
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..f9b477016c2e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2246,6 +2246,10 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *page,
 	if (ap->num_pages == data->max_pages && !fuse_pages_realloc(data))
 		return true;
 
+	/* Reached alignment */
+	if (fc->opt_alignment && !(page->index % fc->opt_alignment_pages))
+		return true;
+
 	return false;
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..5963571b394c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -860,6 +860,9 @@ struct fuse_conn {
 	/** Passthrough support for read/write IO */
 	unsigned int passthrough:1;
 
+	/* Foffset alignment required for optimum performance */
+	unsigned int opt_alignment:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
@@ -917,6 +920,9 @@ struct fuse_conn {
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
+
+	/* The foffset alignment in PAGE_SIZE */
+	unsigned int opt_alignment_pages;
 };
 
 /*
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..9266b22cce8e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1331,6 +1331,15 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_NO_EXPORT_SUPPORT)
 				fm->sb->s_export_op = &fuse_export_fid_operations;
+
+			/* fallback to default if opt_alignment <= PAGE_SHIFT */
+			if (flags & FUSE_OPT_ALIGNMENT) {
+				if (arg->opt_alignment > PAGE_SHIFT) {
+					fc->opt_alignment = 1;
+					fc->opt_alignment_pages = 1 <<
+						(arg->opt_alignment - PAGE_SHIFT);
+				}
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..2c6ad1577591 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -217,6 +217,9 @@
  *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
  *  - add FUSE_NO_EXPORT_SUPPORT init flag
  *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
+ *
+ *  7.41
+ *  - add opt_alignment to fuse_init_out, add FUSE_OPT_ALIGNMENT init flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -421,6 +424,8 @@ struct fuse_file_lock {
  * FUSE_NO_EXPORT_SUPPORT: explicitly disable export support
  * FUSE_HAS_RESEND: kernel supports resending pending requests, and the high bit
  *		    of the request ID indicates resend requests
+ * FUSE_OPT_ALIGNMENT: init_out.opt_alignment contains log2(byte alignment) for
+ *		       foffset alignment for optimum write performance
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -463,6 +468,7 @@ struct fuse_file_lock {
 #define FUSE_PASSTHROUGH	(1ULL << 37)
 #define FUSE_NO_EXPORT_SUPPORT	(1ULL << 38)
 #define FUSE_HAS_RESEND		(1ULL << 39)
+#define FUSE_OPT_ALIGNMENT	(1ULL << 40)
 
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
@@ -893,7 +899,8 @@ struct fuse_init_out {
 	uint16_t	map_alignment;
 	uint32_t	flags2;
 	uint32_t	max_stack_depth;
-	uint32_t	unused[6];
+	uint32_t	opt_alignment;
+	uint32_t	unused[5];
 };
 
 #define CUSE_INIT_INFO_MAX 4096
-- 
2.19.1.6.gb485710b


