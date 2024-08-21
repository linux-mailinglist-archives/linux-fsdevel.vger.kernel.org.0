Return-Path: <linux-fsdevel+bounces-26434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B9295949B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C9A1C20B92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E5C16EC12;
	Wed, 21 Aug 2024 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P7KDAz1v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AE416EB7A;
	Wed, 21 Aug 2024 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221882; cv=none; b=UK8u6FL0BJX2tsPLMMSVUJhF8xYHMvKPpzNQ/0xzkqSL7JINQuQl/gYP8FJnvTMqgHcYoxkZn1C11QZ0RXnwEMTTIT4jBexBGjI51eqcAlfLcTeGvTq0TYf6Y6yCntLFEYCdfMf9jD34ML7LfYRzhl7yAzzoFhbg+94P3lOl8jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221882; c=relaxed/simple;
	bh=bihyqydYFKfzTaXuZ2S9clUXwfenW/sw8KoT0bP+1S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Np3hGDlXT5cYeKEKPJDztfXhysTPI0Kgt1BD9exJ4aTKhELbUPNFJf2xG/o7TsafxwtY+Cy0BykBpg8HzCc2b6JIvX6zhtLJKz1/l2J32MWGd0wM1LNoAUUpkdPNSeDc1i44ZGZvUpKmQcIPje1xMD4lioVPjSryAXRoS2APfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P7KDAz1v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6MbFIEF/SNjmvutaYshVdlkOcLhSj+pDkyYWHzba+A4=; b=P7KDAz1vD6+smaDPnxYL+NjWzo
	YjBOZfO96MLNswb+nQVBeIF1MhTWTR928iQzXy6EPXnlypcNlUfmhkg0wn3EAlWOky02TA8RkfOhQ
	OEOtC7+gpom0P8U4TFF2dQp/AyFTxZluFJP6bn98sXbs8RKUzJb1yaAAzGoBFasgBAaPXlM/VEm5+
	AFwzBzA9aIWEcTcmKtU7sEK4u9ZvHWTjNwGsd7hyaRsOaOl2o9UASufAoG9tsbevDKUHOE5NkyZlN
	cKmc2pUSjwotZjoPp/u8YqxVxyKi/26lGJybQVs4O6rCUs5M62s7u7u8WZpStDA9G+ThwcE94j5UQ
	EHH0rdRQ==;
Received: from 2a02-8389-2341-5b80-94d5-b2c4-989b-ff6e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:94d5:b2c4:989b:ff6e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgesI-00000007iSq-3fYE;
	Wed, 21 Aug 2024 06:31:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 3/6] fs: sort out the fallocate mode vs flag mess
Date: Wed, 21 Aug 2024 08:30:29 +0200
Message-ID: <20240821063108.650126-4-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821063108.650126-1-hch@lst.de>
References: <20240821063108.650126-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The fallocate system call takes a mode argument, but that argument
contains a wild mix of exclusive modes and an optional flags.

Replace FALLOC_FL_SUPPORTED_MASK with FALLOC_FL_MODE_MASK, which excludes
the optional flag bit, so that we can use switch statement on the value
to easily enumerate the cases while getting the check for duplicate modes
for free.

To make this (and in the future the file system implementations) more
readable also add a symbolic name for the 0 mode used to allocate blocks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/open.c                   | 53 ++++++++++++++++++-------------------
 include/linux/falloc.h      | 18 ++++++++-----
 include/uapi/linux/falloc.h |  1 +
 3 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 22adbef7ecc2a6..c598d2071c45cc 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -252,42 +252,41 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (offset < 0 || len <= 0)
 		return -EINVAL;
 
-	/* Return error if mode is not supported */
-	if (mode & ~FALLOC_FL_SUPPORTED_MASK)
+	if (mode & ~(FALLOC_FL_MODE_MASK | FALLOC_FL_KEEP_SIZE))
 		return -EOPNOTSUPP;
 
-	/* Punch hole and zero range are mutually exclusive */
-	if ((mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)) ==
-	    (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE))
-		return -EOPNOTSUPP;
-
-	/* Punch hole must have keep size set */
-	if ((mode & FALLOC_FL_PUNCH_HOLE) &&
-	    !(mode & FALLOC_FL_KEEP_SIZE))
+	/*
+	 * Modes are exclusive, even if that is not obvious from the encoding
+	 * as bit masks and the mix with the flag in the same namespace.
+	 *
+	 * To make things even more complicated, FALLOC_FL_ALLOCATE_RANGE is
+	 * encoded as no bit set.
+	 */
+	switch (mode & FALLOC_FL_MODE_MASK) {
+	case FALLOC_FL_ALLOCATE_RANGE:
+	case FALLOC_FL_UNSHARE_RANGE:
+	case FALLOC_FL_ZERO_RANGE:
+		break;
+	case FALLOC_FL_PUNCH_HOLE:
+		if (!(mode & FALLOC_FL_KEEP_SIZE))
+			return -EOPNOTSUPP;
+		break;
+	case FALLOC_FL_COLLAPSE_RANGE:
+	case FALLOC_FL_INSERT_RANGE:
+		if (mode & FALLOC_FL_KEEP_SIZE)
+			return -EOPNOTSUPP;
+		break;
+	default:
 		return -EOPNOTSUPP;
-
-	/* Collapse range should only be used exclusively. */
-	if ((mode & FALLOC_FL_COLLAPSE_RANGE) &&
-	    (mode & ~FALLOC_FL_COLLAPSE_RANGE))
-		return -EINVAL;
-
-	/* Insert range should only be used exclusively. */
-	if ((mode & FALLOC_FL_INSERT_RANGE) &&
-	    (mode & ~FALLOC_FL_INSERT_RANGE))
-		return -EINVAL;
-
-	/* Unshare range should only be used with allocate mode. */
-	if ((mode & FALLOC_FL_UNSHARE_RANGE) &&
-	    (mode & ~(FALLOC_FL_UNSHARE_RANGE | FALLOC_FL_KEEP_SIZE)))
-		return -EINVAL;
+	}
 
 	if (!(file->f_mode & FMODE_WRITE))
 		return -EBADF;
 
 	/*
-	 * We can only allow pure fallocate on append only files
+	 * We can only allow pure space allocation on append only files.
 	 */
-	if ((mode & ~FALLOC_FL_KEEP_SIZE) && IS_APPEND(inode))
+	if (mode != FALLOC_FL_ALLOCATE_RANGE && IS_APPEND(inode))
 		return -EPERM;
 
 	if (IS_IMMUTABLE(inode))
diff --git a/include/linux/falloc.h b/include/linux/falloc.h
index f3f0b97b167579..3f49f3df6af5fb 100644
--- a/include/linux/falloc.h
+++ b/include/linux/falloc.h
@@ -25,12 +25,18 @@ struct space_resv {
 #define FS_IOC_UNRESVSP64	_IOW('X', 43, struct space_resv)
 #define FS_IOC_ZERO_RANGE	_IOW('X', 57, struct space_resv)
 
-#define	FALLOC_FL_SUPPORTED_MASK	(FALLOC_FL_KEEP_SIZE |		\
-					 FALLOC_FL_PUNCH_HOLE |		\
-					 FALLOC_FL_COLLAPSE_RANGE |	\
-					 FALLOC_FL_ZERO_RANGE |		\
-					 FALLOC_FL_INSERT_RANGE |	\
-					 FALLOC_FL_UNSHARE_RANGE)
+/*
+ * Mask of all supported fallocate modes.  Only one can be set at a time.
+ *
+ * In addition to the mode bit, the mode argument can also encode flags.
+ * FALLOC_FL_KEEP_SIZE is the only supported flag so far.
+ */
+#define FALLOC_FL_MODE_MASK	(FALLOC_FL_ALLOCATE_RANGE |	\
+				 FALLOC_FL_PUNCH_HOLE |		\
+				 FALLOC_FL_COLLAPSE_RANGE |	\
+				 FALLOC_FL_ZERO_RANGE |		\
+				 FALLOC_FL_INSERT_RANGE |	\
+				 FALLOC_FL_UNSHARE_RANGE)
 
 /* on ia32 l_start is on a 32-bit boundary */
 #if defined(CONFIG_X86_64)
diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
index 51398fa57f6cdf..5810371ed72bbd 100644
--- a/include/uapi/linux/falloc.h
+++ b/include/uapi/linux/falloc.h
@@ -2,6 +2,7 @@
 #ifndef _UAPI_FALLOC_H_
 #define _UAPI_FALLOC_H_
 
+#define FALLOC_FL_ALLOCATE_RANGE 0x00 /* allocate range */
 #define FALLOC_FL_KEEP_SIZE	0x01 /* default is extend size */
 #define FALLOC_FL_PUNCH_HOLE	0x02 /* de-allocates range */
 #define FALLOC_FL_NO_HIDE_STALE	0x04 /* reserved codepoint */
-- 
2.43.0


