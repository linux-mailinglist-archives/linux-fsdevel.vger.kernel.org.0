Return-Path: <linux-fsdevel+bounces-52671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 441D5AE59FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF717174EF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDCE248880;
	Tue, 24 Jun 2025 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkemvVXL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDED23BCF5;
	Tue, 24 Jun 2025 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731795; cv=none; b=UA+rlVvEfCr2uG6tS9i6PavRbaK1z9gPFS+baGn/pPQRqw4zEAZFP45P/jAp0Rg3bxI72fQ0XX3AqduOG0y9YwDjuPCvZCcwqWWKbwld3f5Rikte61015OdmvoS3CE0LmPTT8vqRrF/JuWBiZBBo6ez/EbbY+Hvb3kRRNt5hmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731795; c=relaxed/simple;
	bh=pRtLNn+K+f0dljnBu0Wr54Jv7D0qPpSdWn2mTd1El68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOoGDiOdqfIP+kmaO3h0wzuHjMYEA29UGOYGilMoTtQ09QqSo6YH3RAKIwhYWiUVGiNZ0K//xYfU8Mn46S8QF2lvq//sSc6OMTtcahK5p2G4CRlDnEVh9AJfEtMTnSerepi5Kq13LQZbh3Yp+pPc5aOTNOp4en2KGZQAta86OgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkemvVXL; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so3534023b3a.0;
        Mon, 23 Jun 2025 19:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731793; x=1751336593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GtAeER6c1CahXSofSbmzClYLDOBpPxRoXtNiXwnYsM=;
        b=YkemvVXLdol8/YVPEv6uR75UXpIbDGsc3q51bq7qOgS/kRn+MRbNcq/yTagXWDz1Wo
         f0tObrH6Zsb94c/W9lL7heaynDApz1IYTUigcXzPv5CPgXKcagYNu7ryelI+kLnv+UFl
         MtrVUyYiVmA9conFnh3jcp/1P3b59MY1jjrYvIVlCwDnQ8i2zvntIgnhYHW/z+tcKG5B
         xyWbdsW8Yh3puAS983L7lz7C09tfQHG0qwgd/c01tWJWIoGz4WOkregfAEK6tE9961rf
         0MhG1O3HwfmJ0pU4vVbFAhuQCzB3SDsraCaILO1UgybJ0fvM+/0alnJ1gb20tUGodACr
         AY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731793; x=1751336593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GtAeER6c1CahXSofSbmzClYLDOBpPxRoXtNiXwnYsM=;
        b=Hb4DAr4cXFgda9F6sS+6Tcf7PHIukOSRQtS/r+P8qB60JPb5MCWxYwi0rvlcc6+Sn8
         wzQRAJb5fLeugj4XmcJ3EAHI9MXqlbwF/OFSXaNhvrJNWhbDl1wW7lRNP7KP7erzfi3/
         f7gfkuhNa6j0hhU2X39GhyLXNMf4zjp+l3fF8WTJggRNqU2E+qP7FFVjnArcerE3Kr35
         5ajaqVoa1O/XCRG7t4vAfIku02olm8ITsKB/Q5cpcnKSoCkTk/g0PDEueXu8ZpMBc6JQ
         2b/LnGHJDVnuOmqUrKGbQyUZLBmVwredFuBTQNJjTB07tsQ7AkfdO8MFqutFIPE/RvMU
         M9UA==
X-Forwarded-Encrypted: i=1; AJvYcCU7NZDrRL5Oz9E3OcUskRBD2aK8CfYFvE79IQVPtRAXXcp0T5icCMTTRujzpmXT2koaPJpVZMzlylL4@vger.kernel.org, AJvYcCW5MIDzM6/B4fIUn25o1tnPcSSBZfpjTacOwOBMGWn3+VYlVtaulBzBJ9Sx4QO15uWjgo3ET65o7XP/fw==@vger.kernel.org, AJvYcCXsjX6BSTu5TC9vFo7Xu5TiDEs8l/DuMfbq99a6ciw+nIkm3SDUK2Q+/6SzusjIi1nzRUQI0hUb7sMt@vger.kernel.org
X-Gm-Message-State: AOJu0YxLH1mT+XB9rcbLSU/pUzEOBwCFcW4zK1gl/jzvqn2JyQsNfJsC
	CsJTaBbe3A0EsUSFPU9/uV5DC85sCQN0FrfOr5ChFc33SlH2OWViNLOlBC5WGQ==
X-Gm-Gg: ASbGncujjae7QWjCMycTqKbuUOUplzqCspv8wpI+0VNAtyUNvp/LMKcnsZGayCPz2oM
	XtEWT7RNEJues6nsYyaXTBPwIvv62VabO1itclNNFPqyMz5Wiu1dGPkLeFaL5uUY7Sv8UvlG3OP
	rlBfLrGZBkCIQ7EOqQO2RZfGi96bhKH8hNcKheTuYBGvEq3igmpoLF0PXgee6CK8RTJzU3SDQAo
	h464/f/ZuIFoimn/0Vwsxdi531MuQ1Z+Zqcw18hbbMnVWtrNHjG7luUxdWRFxW3DsL8D1qt4MN6
	ULHVMxurXKJL9e75mQshwbuYSsUXulIL7l68y3jUt4c7tIcJnImsds/9WA==
X-Google-Smtp-Source: AGHT+IE7bv0i6ALPDr7cw7p0PsBQNw2kOyNwlR5aRn5JcPix4coXRnKFLoiBSy2sjHoM7bpp14aqCQ==
X-Received: by 2002:a05:6a21:44ca:b0:21f:751a:dd41 with SMTP id adf61e73a8af0-22026e2a41emr27318649637.40.1750731793453;
        Mon, 23 Jun 2025 19:23:13 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8872203sm450073b3a.157.2025.06.23.19.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:13 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 11/16] iomap: add read_folio_range() handler for buffered writes
Date: Mon, 23 Jun 2025 19:21:30 -0700
Message-ID: <20250624022135.832899-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624022135.832899-1-joannelkoong@gmail.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a read_folio_range() handler for buffered writes that filesystems
may pass in if they wish to provide a custom handler for synchronously
reading in the contents of a folio.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
[hch: renamed to read_folio_range, pass less arguments]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../filesystems/iomap/operations.rst          |  6 +++++
 fs/iomap/buffered-io.c                        | 25 +++++++++++--------
 include/linux/iomap.h                         | 10 ++++++++
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 1f5732835567..813e26dbd21e 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -68,6 +68,8 @@ The following address space operations can be wrapped easily:
      void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
                        struct folio *folio);
      bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
+     int (*read_folio_range)(const struct iomap_iter *iter,
+     			struct folio *folio, loff_t pos, size_t len);
  };
 
 iomap calls these functions:
@@ -123,6 +125,10 @@ iomap calls these functions:
     ``->iomap_valid``, then the iomap should considered stale and the
     validation failed.
 
+  - ``read_folio_range``: Called to synchronously read in the range that will
+    be written to. If this function is not provided, iomap will default to
+    submitting a bio read request.
+
 These ``struct kiocb`` flags are significant for buffered I/O with iomap:
 
  * ``IOCB_NOWAIT``: Turns on ``IOMAP_NOWAIT``.
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f6e410c9ea7b..897a3ccea2df 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -667,22 +667,23 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
 					 pos + len - 1);
 }
 
-static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
-		size_t poff, size_t plen, const struct iomap *iomap)
+static int iomap_read_folio_range(const struct iomap_iter *iter,
+		struct folio *folio, loff_t pos, size_t len)
 {
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct bio_vec bvec;
 	struct bio bio;
 
-	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
-	bio_add_folio_nofail(&bio, folio, plen, poff);
+	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
+	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
+	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
 	return submit_bio_wait(&bio);
 }
 
-static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
+static int __iomap_write_begin(const struct iomap_iter *iter,
+		const struct iomap_write_ops *write_ops, size_t len,
 		struct folio *folio)
 {
-	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct iomap_folio_state *ifs;
 	loff_t pos = iter->pos;
 	loff_t block_size = i_blocksize(iter->inode);
@@ -731,8 +732,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter, size_t len,
 			if (iter->flags & IOMAP_NOWAIT)
 				return -EAGAIN;
 
-			status = iomap_read_folio_sync(block_start, folio,
-					poff, plen, srcmap);
+			if (write_ops && write_ops->read_folio_range)
+				status = write_ops->read_folio_range(iter,
+						folio, block_start, plen);
+			else
+				status = iomap_read_folio_range(iter,
+						folio, block_start, plen);
 			if (status)
 				return status;
 		}
@@ -848,7 +853,7 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(folio, pos, len, NULL, srcmap);
 	else
-		status = __iomap_write_begin(iter, len, folio);
+		status = __iomap_write_begin(iter, write_ops, len, folio);
 
 	if (unlikely(status))
 		goto out_unlock;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8d20a926b645..5ec651606c51 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -166,6 +166,16 @@ struct iomap_write_ops {
 	 * locked by the iomap code.
 	 */
 	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
+
+	/*
+	 * Optional if the filesystem wishes to provide a custom handler for
+	 * reading in the contents of a folio, otherwise iomap will default to
+	 * submitting a bio read request.
+	 *
+	 * The read must be done synchronously.
+	 */
+	int (*read_folio_range)(const struct iomap_iter *iter,
+			struct folio *folio, loff_t pos, size_t len);
 };
 
 /*
-- 
2.47.1


