Return-Path: <linux-fsdevel+bounces-37035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884A19EC7DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 09:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FD1287D27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B031EC4C2;
	Wed, 11 Dec 2024 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ySnra2zJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEEE1C5CD7;
	Wed, 11 Dec 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907289; cv=none; b=rJUlT6XtTmjCTclQkeW7p/RDTJEcDXtXVwI7SH/HM9O5YhbAT9mY/xSautmuTGvMpZduQLO0lR8YUgUQngFt1+51L1Ad0UoF1WPBEZZ/+IYvK3h/kZEWvbDq9XuadhYpoBsRTUd7fQludBTs9uIIkdMr/Y/0BLa4hWJsnnIhmaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907289; c=relaxed/simple;
	bh=8VLpqizoUvWvxf1BvNJAOAxNEVLFx37ki2R3Jsl6HiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4hXgE2FpsfgiqqqpkweB9YKHX/cGBork9opz5leuFEJtdAsiw0IehzhfM2gBDZFvIGAnICLo1gEPxhiClUEtKGG1+XD2pzCS8md0TZc2rZfxFSKAXewzWuQDk121tkQSxSd4Lx9PFFQdPIz7Z4J4cP5Mipnjw3DG4X9pzK8oas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ySnra2zJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=75y2ZSAGBa241zuLn5Fzwnn53t/HVcUkpucSJles2ZE=; b=ySnra2zJaKjyfLgm7JaHFhO2eR
	qfN13t6Fa3EV1YEy6l1xVDCb9v9v+F6lyR3jN9wPXTh737skGWKEldrRXGZPcyTZyJPYiHjDjyth3
	Wi+Z5lVQUitCvDrEGAC3QO3ybdxo2zsynuPAdglzNf3Cu9rGOX0xTqMZzyT0m2m5oBalZoOqv54mY
	b8K41LDFvnFBGJ1aMjr4VXivh2IJ7SqT+8UmgO3OISephZTZtzWtejQMd9lVXPLya2Q+zHcb38ewk
	EpFOSrS/jAeYWcEpQmwV7Ovm6/Tzpm6xLewugm3p6ldPB2e4ihxBtkFWJw/G3P1qZHOQ9ytfyR5vz
	TyA6YZeA==;
Received: from [2001:4bb8:2ae:8817:935:3eb8:759c:c417] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLIUZ-0000000EITd-22Vz;
	Wed, 11 Dec 2024 08:54:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 8/8] iomap: pass private data to iomap_truncate_page
Date: Wed, 11 Dec 2024 09:53:48 +0100
Message-ID: <20241211085420.1380396-9-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211085420.1380396-1-hch@lst.de>
References: <20241211085420.1380396-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Allow the file system to pass private data which can be used by the
iomap_begin and iomap_end methods through the private pointer in the
iomap_iter structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 4 ++--
 fs/xfs/xfs_iomap.c     | 2 +-
 include/linux/iomap.h  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6bfee1c7aedb..ccb2c6cbb18e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1464,7 +1464,7 @@ EXPORT_SYMBOL_GPL(iomap_zero_range);
 
 int
 iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops)
+		const struct iomap_ops *ops, void *private)
 {
 	unsigned int blocksize = i_blocksize(inode);
 	unsigned int off = pos & (blocksize - 1);
@@ -1473,7 +1473,7 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 	if (!off)
 		return 0;
 	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops,
-			NULL);
+			private);
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 3410c55f544a..5dd0922fe2d1 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1512,5 +1512,5 @@ xfs_truncate_page(
 		return dax_truncate_page(inode, pos, did_zero,
 					&xfs_dax_write_iomap_ops);
 	return iomap_truncate_page(inode, pos, did_zero,
-				   &xfs_buffered_write_iomap_ops);
+				   &xfs_buffered_write_iomap_ops, NULL);
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 2a88dfa6ec55..19a2554622e6 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -315,7 +315,7 @@ int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops, void *private);
 int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops);
+		const struct iomap_ops *ops, void *private);
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
 		void *private);
 typedef void (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
-- 
2.45.2


