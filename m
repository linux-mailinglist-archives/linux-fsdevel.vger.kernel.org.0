Return-Path: <linux-fsdevel+bounces-41035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6AFA2A11D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 07:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B423F167ADF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94F9224AFA;
	Thu,  6 Feb 2025 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JVE0GqeN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239C224AF3;
	Thu,  6 Feb 2025 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824064; cv=none; b=fD1/Tq3M8gLr6egMmGl1RrfICArwN1+FUew5W9DuSb9PrAXafqr+oWoy4ML1eNYavoNiCLnxWwO+xc18we6bzXkpcn3eS7GnrxWOpCQ8FKb/D/oFQ2RNro3/zpU53EGu0kxnNNpcoeMTTYct42MQGw4qbHX7yM624TW1x38Mpqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824064; c=relaxed/simple;
	bh=1rbNPIzgGVWBOPGzHsf4srMxAD31nPdCb/NvadTmr0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qp+Nkq93HMhzZfmIhG1wI4BJJg4O9FE4HZICama0YV/dNHrBR7o+tvAE2DP1Vi8WiSXjL8lzP1mPR8q9l2dKIOf0Yli/LZS0Oh3PIAPhNuQcU2i8EnqTu2irwrIUEgj0y2/FEFzP80T/un1v7bUIg+P6+uXRpGgK6Loa7+iTQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JVE0GqeN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SKDogZTfDA4Zq3N6wovueoXhg/QQa2CymY2pwDvTzSA=; b=JVE0GqeN+CM221vZBpsdWlc/Dm
	bJxfNu7Nt7kvNH1Y1K7G3dc1jovWlAkVNvN8D2RwLpOw8M2HcuDxt/aq7EAwks2VkRPcIC/X6nGcF
	/ckr+xkgX0eEdjnoK89h6aFgspyxaE1DVOkb6y5HpF9allP6GzY6yTqj1W0FE5u2pacsRTIv5HTVF
	5xawMW0k84leZlXTzMBBM9GeJuV1MSc+iK6l5v3ZLkpE3A93uK0BfbypPWuBmgDTxoB0ySotwLLtF
	7dnRZxjPjtkjefjr4U1tXPxrJYXClJsdlM5iqgMJvMhXOLn7mFGDuBzh5VcX+K8jOLRBRTqSiuNb5
	SMOuo4GQ==;
Received: from 2a02-8389-2341-5b80-9d5d-e9d2-4927-2bd6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9d5d:e9d2:4927:2bd6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfvZO-00000005PYr-0yE0;
	Thu, 06 Feb 2025 06:41:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/11] iomap: pass private data to iomap_zero_range
Date: Thu,  6 Feb 2025 07:40:08 +0100
Message-ID: <20250206064035.2323428-11-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206064035.2323428-1-hch@lst.de>
References: <20250206064035.2323428-1-hch@lst.de>
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/gfs2/bmap.c         | 3 ++-
 fs/iomap/buffered-io.c | 6 ++++--
 fs/xfs/xfs_iomap.c     | 2 +-
 include/linux/iomap.h  | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 1795c4e8dbf6..366516b98b3f 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1300,7 +1300,8 @@ static int gfs2_block_zero_range(struct inode *inode, loff_t from,
 				 unsigned int length)
 {
 	BUG_ON(current->journal_info);
-	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops);
+	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops,
+			NULL);
 }
 
 #define GFS2_JTRUNC_REVOKES 8192
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8c24d8611edf..382647fda1d1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1391,13 +1391,14 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 
 int
 iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
-		const struct iomap_ops *ops)
+		const struct iomap_ops *ops, void *private)
 {
 	struct iomap_iter iter = {
 		.inode		= inode,
 		.pos		= pos,
 		.len		= len,
 		.flags		= IOMAP_ZERO,
+		.private	= private,
 	};
 	struct address_space *mapping = inode->i_mapping;
 	unsigned int blocksize = i_blocksize(inode);
@@ -1465,7 +1466,8 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 	/* Block boundary? Nothing to do */
 	if (!off)
 		return 0;
-	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops);
+	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops,
+			NULL);
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index d61460309a78..483dec1475d2 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1495,7 +1495,7 @@ xfs_zero_range(
 		return dax_zero_range(inode, pos, len, did_zero,
 				      &xfs_dax_write_iomap_ops);
 	return iomap_zero_range(inode, pos, len, did_zero,
-				&xfs_buffered_write_iomap_ops);
+				&xfs_buffered_write_iomap_ops, NULL);
 }
 
 int
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index d528eb4d5cfe..eddf524ac749 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -313,7 +313,7 @@ bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
-		bool *did_zero, const struct iomap_ops *ops);
+		bool *did_zero, const struct iomap_ops *ops, void *private);
 int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
-- 
2.45.2


