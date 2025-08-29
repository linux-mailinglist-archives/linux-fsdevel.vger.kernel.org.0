Return-Path: <linux-fsdevel+bounces-59694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815E5B3C5EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C334A08C30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040713148D2;
	Fri, 29 Aug 2025 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuL4xl1/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37B3148B2;
	Fri, 29 Aug 2025 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511917; cv=none; b=RqmgBf8W++YXUD+Y+NjffEx3aRXwYGmyh5f6L4hCNNSKUIn3Tncc8iDqSHuI5Fr3dNDmX0d7XR6MIsTGo5xlodtOsvLGm3WZiQ/S2HgqBhyObu/xiv4dffwcYm31L5g4kxUxSkNPubW3Rjzi+J0msRkmnMsJ9fhCUXvomD0WUSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511917; c=relaxed/simple;
	bh=Rtg7m1XguZak3npPdJbgIu1zThVR4TtsNFTq0BiHB6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YujfvmTXrFtj3mRtgufsODLjH4tyqirzfitZmRl7xKI6jlTlh9kHNsFXaaEZeTnDqeQbt9t8GjOEyAbI2tN0Ax4DfjgnAtgZPPfLKrewlO70YReCCY8nfo8sZ7k7Va17+UazvoXqOUd8D6rB3XAzKqhgEXAThrLRWcb6woP4Csg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuL4xl1/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso2363340b3a.2;
        Fri, 29 Aug 2025 16:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511915; x=1757116715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fL+amsE1a41SdTAwSMoRoUShOwhuzGv/nQVPODLuOY=;
        b=TuL4xl1/1QlzR6yW7OIjJBkDCJl0mtelnfwZiBaAZPiRkw8hCZ3mUrXzIGKyT+POuH
         ADWx7nBYQMIvCCAo+g1ySBkDVv/oS3pcXqBsc2bx85Gxcdx1mkTVpwZQ1no62xdiMlUi
         pF6kYMNrouwkA2LE5cNKR7JfogXs9hbwCwFdGqPu9xQjRDxFrewKeEFyNRcbr6adTeh3
         +4rBn3PAY+Y2Ya7rvYfwe9rI2cp2r9/1LWVddMdcjknJ8bMVXHzQyKpy6o8Wa+W6P6VI
         fdMACzUKRyPRpYwDaZfmO2JODZ7FQvpp83GrowNLZjUzloAgKNrXtrpA+DzSNsSNGFDX
         pGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511915; x=1757116715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fL+amsE1a41SdTAwSMoRoUShOwhuzGv/nQVPODLuOY=;
        b=r0EVIztwGi3Bq0RmjGTbWWGkjPPqqrUVrVW07uJj5A3REM2R7F2Ng/GR8mcl9kUlZ4
         qwMrVQMaF/I/swJBW4C/R3oOuReQTBePJn7msycvS+ZYZKibw5HdTb290jDiwIfrlrs+
         cLZ28n4k9slNTBFIIzxz1QD7UB9RI8GXXYjz3G50KaJRzVXB0kUGLOVJLRTRpQFGgc7k
         9Fm2szrxYK+7B0v31aQxRwA7R3H1sZNsgTm0YwqEmVMOGIvy3f2jgIHlkvWQoMWR32GO
         GFY3JsixeXH4uk0rUwkPkDrWYCqZ7mVo+15w3xvvGzy+e6NLHo/5si0im1kJZtAcEom7
         SrkA==
X-Forwarded-Encrypted: i=1; AJvYcCU3m+GJFaBcgVwyFJfNnnl3Ji/QDYpTtpM450oovUhBB1IgGPI9t/8QTa70TJnQdg43HxOUZ89X6x3q9aDPpg==@vger.kernel.org, AJvYcCUtO7YxwdiJIhSkTSX2O1f2wYXhmUx3ziLydgElCc01IbUKMbOVH4hYEIWUp/B8Fd07pQVc6pkCcA1T@vger.kernel.org, AJvYcCWpj2d3TTAjm0Txx3e5n4D3jtYA0dz2wYujU3u2tfHOfaJvztHcwAHHZexJGwl3ItxV5IJAlG0mfF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymVdzywsGZ983RrItyAaK6Ibr8eN+sio2pYL2sPMLueGmBe/9K
	hjPXJkTWxOGbztqWCIvyui59juE/qkJPqRWsVFO4evbE7ptBR6P8hpwIA3ZmhQ==
X-Gm-Gg: ASbGncsMh0RQHJ27cX/tJrzCJQxwRZAfK7gyLmHq0yVGGOGdIM+Nui0pExV/rWhNfo+
	E7LGNwEjTwzHqfu+mW/578SzgZC2QFB3TIS+OMCMyfq/cKWW+ye+i23k0i9gFJXS38GkKCABg//
	O4K+z3gjpvJZ5pXZxoht3I8BYwvYynzuSPjAKPnBxwKAGco9VMnXkcKmiXwM7adkjf0vSXWBF0J
	639I0x2kF5jR5Ev3iBiSZVpX+jQs6MtIq3e+dJgygar9arrpQyJH9ZZUBwIr1hp+A02YqP418gQ
	18k6QWmNB70eUEldlcX+j2R3+Mma5CvHosO3yzUKYyKjxQsnAQmYdtaemABL6FkN0LLuCAN356y
	9GeWTDf5Vccqtij4eyA==
X-Google-Smtp-Source: AGHT+IEW4jxjv7e6F4zJbIXkypoXO2BTz+JmryZJ+p5EZkl8bPCyK3R+7EwgsytMcZX8qg1xTBzvmg==
X-Received: by 2002:a05:6a00:2d13:b0:772:2fad:ff64 with SMTP id d2e1a72fcca58-7723e257daamr506009b3a.8.1756511914924;
        Fri, 29 Aug 2025 16:58:34 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e4383sm3453313b3a.82.2025.08.29.16.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:34 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 13/16] iomap: add a private arg for read and readahead
Date: Fri, 29 Aug 2025 16:56:24 -0700
Message-ID: <20250829235627.4053234-14-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829235627.4053234-1-joannelkoong@gmail.com>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a void *private arg for read and readahead which filesystems that
pass in custom read callbacks can use. Stash this in the existing
private field in the iomap_iter.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 block/fops.c           | 4 ++--
 fs/erofs/data.c        | 4 ++--
 fs/gfs2/aops.c         | 4 ++--
 fs/iomap/buffered-io.c | 8 ++++++--
 fs/xfs/xfs_aops.c      | 4 ++--
 fs/zonefs/file.c       | 4 ++--
 include/linux/iomap.h  | 4 ++--
 7 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index b42e16d0eb35..57ae886c7b1a 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -533,12 +533,12 @@ const struct address_space_operations def_blk_aops = {
 #else /* CONFIG_BUFFER_HEAD */
 static int blkdev_read_folio(struct file *file, struct folio *folio)
 {
-	return iomap_read_folio(folio, &blkdev_iomap_ops, NULL);
+	return iomap_read_folio(folio, &blkdev_iomap_ops, NULL, NULL);
 }
 
 static void blkdev_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &blkdev_iomap_ops, NULL);
+	iomap_readahead(rac, &blkdev_iomap_ops, NULL, NULL);
 }
 
 static ssize_t blkdev_writeback_range(struct iomap_writepage_ctx *wpc,
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index ea451f233263..2ea338448ca1 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -371,7 +371,7 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 {
 	trace_erofs_read_folio(folio, true);
 
-	return iomap_read_folio(folio, &erofs_iomap_ops, NULL);
+	return iomap_read_folio(folio, &erofs_iomap_ops, NULL, NULL);
 }
 
 static void erofs_readahead(struct readahead_control *rac)
@@ -379,7 +379,7 @@ static void erofs_readahead(struct readahead_control *rac)
 	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
 					readahead_count(rac), true);
 
-	return iomap_readahead(rac, &erofs_iomap_ops, NULL);
+	return iomap_readahead(rac, &erofs_iomap_ops, NULL, NULL);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index bf531bcfd8a0..211a0f7b1416 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -428,7 +428,7 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 
 	if (!gfs2_is_jdata(ip) ||
 	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
-		error = iomap_read_folio(folio, &gfs2_iomap_ops, NULL);
+		error = iomap_read_folio(folio, &gfs2_iomap_ops, NULL, NULL);
 	} else if (gfs2_is_stuffed(ip)) {
 		error = stuffed_read_folio(ip, folio);
 	} else {
@@ -503,7 +503,7 @@ static void gfs2_readahead(struct readahead_control *rac)
 	else if (gfs2_is_jdata(ip))
 		mpage_readahead(rac, gfs2_block_map);
 	else
-		iomap_readahead(rac, &gfs2_iomap_ops, NULL);
+		iomap_readahead(rac, &gfs2_iomap_ops, NULL, NULL);
 }
 
 /**
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 06f2c857de64..d68dd7f63923 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -539,12 +539,13 @@ static void iomap_readfolio_complete(const struct iomap_iter *iter,
 }
 
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
-		const struct iomap_read_ops *read_ops)
+		const struct iomap_read_ops *read_ops, void *private)
 {
 	struct iomap_iter iter = {
 		.inode		= folio->mapping->host,
 		.pos		= folio_pos(folio),
 		.len		= folio_size(folio),
+		.private	= private,
 	};
 	struct iomap_readfolio_ctx ctx = {
 		.cur_folio	= folio,
@@ -591,6 +592,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
  * @rac: Describes the pages to be read.
  * @ops: The operations vector for the filesystem.
  * @read_ops: Optional ops callers can pass in if they want custom handling.
+ * @private: If passed in, this will be usable by the caller in any
+ * read_ops callbacks.
  *
  * This function is for filesystems to call to implement their readahead
  * address_space operation.
@@ -603,12 +606,13 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
  * the filesystem to be reentered.
  */
 void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops,
-		const struct iomap_read_ops *read_ops)
+		const struct iomap_read_ops *read_ops, void *private)
 {
 	struct iomap_iter iter = {
 		.inode	= rac->mapping->host,
 		.pos	= readahead_pos(rac),
 		.len	= readahead_length(rac),
+		.private = private,
 	};
 	struct iomap_readfolio_ctx ctx = {
 		.rac	= rac,
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index fb2150c0825a..5e71a3888e6d 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -742,14 +742,14 @@ xfs_vm_read_folio(
 	struct file		*unused,
 	struct folio		*folio)
 {
-	return iomap_read_folio(folio, &xfs_read_iomap_ops, NULL);
+	return iomap_read_folio(folio, &xfs_read_iomap_ops, NULL, NULL);
 }
 
 STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_readahead(rac, &xfs_read_iomap_ops, NULL);
+	iomap_readahead(rac, &xfs_read_iomap_ops, NULL, NULL);
 }
 
 static int
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 96470daf4d3f..182bb473a82b 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -112,12 +112,12 @@ static const struct iomap_ops zonefs_write_iomap_ops = {
 
 static int zonefs_read_folio(struct file *unused, struct folio *folio)
 {
-	return iomap_read_folio(folio, &zonefs_read_iomap_ops, NULL);
+	return iomap_read_folio(folio, &zonefs_read_iomap_ops, NULL, NULL);
 }
 
 static void zonefs_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &zonefs_read_iomap_ops, NULL);
+	iomap_readahead(rac, &zonefs_read_iomap_ops, NULL, NULL);
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index a7247439aeb5..9bc7900dd448 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -355,9 +355,9 @@ ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
-		const struct iomap_read_ops *read_ops);
+		const struct iomap_read_ops *read_ops, void *private);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops,
-		const struct iomap_read_ops *read_ops);
+		const struct iomap_read_ops *read_ops, void *private);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
-- 
2.47.3


