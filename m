Return-Path: <linux-fsdevel+bounces-37853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EF99F824D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BD816613F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5021C4A01;
	Thu, 19 Dec 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m6mPbLRp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF1E1C2325;
	Thu, 19 Dec 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630035; cv=none; b=GAghswDvsr6elxkThx5h9wtCcSfaKS6mK56/J6yHXPE+ncbOqdb1LE75MmSd4GBS5crXtluWS8ZfBzJDtNlCzy9GfzPGKPsU+Ix6i6mZBcYXAvEw22ILyVTIcClH9AZ8b8cHc2ocVIR9p5BgpIBIbULSQTIa4sND4Z/UlXJQvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630035; c=relaxed/simple;
	bh=LN5OVkpX5gqGo7AsCnuvNd4thoAqFnIq92xJeLh1INs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yvl9uGMXj61R2QmS7M1Ix+AINafnCAx828+ibhP4vArSfRk7bv1Yjzu+zqnPNmhAYUKP3gKNiogZCISzzpMeW2+upA3eUcAP0WP5Y5RgIjQJ38fH2AoI99eOLPZww4FnegX2o+DM+rzTy5efdiv8C+ZQSow+wF6j0vcuDM4vxoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m6mPbLRp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jvs4ir/2IyuqXoNGN9HP44Na2dclI2gRuKoBpKcLbE4=; b=m6mPbLRpgPjoW4mgbtuKkErPok
	XhHJ3C5dVNUXMSepJEJqojzyOtcjw6x/s9rb6NoF/Vr2hf5Zlff6VnqhfPoF0a+bwU1jSYMdVFT9+
	sj6fT3p89omBfAhvT9e9Ja/VpMzQVCBinIOgB28WtVnV3T/+5RG+n6ASc74nRaGEQEbBvji+TixOF
	cY9VHeuLmtt2yGEagGBF4Ge3KSizQEqL9RtxAp1JmwM1i6OCobPwFkyIo/CR8SvkA/JU9IaFeK+PZ
	TKV3WxGbC9qCy1iaShZbZ0PvJcWEhUTlb1tHnFPYXHm5581jl6GSiiUOPAXtL2n8BVwW9viqObf9h
	Yg1tApRQ==;
Received: from [2001:4bb8:2ae:97bf:7b0d:9cbd:e369:c821] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOKVl-00000002b29-1vWL;
	Thu, 19 Dec 2024 17:40:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/10] iomap: pass private data to iomap_zero_range
Date: Thu, 19 Dec 2024 17:39:14 +0000
Message-ID: <20241219173954.22546-10-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241219173954.22546-1-hch@lst.de>
References: <20241219173954.22546-1-hch@lst.de>
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
index e33309fa0a11..c2957ec9ab8b 100644
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
index 50fa3ef89f6c..3410c55f544a 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1497,7 +1497,7 @@ xfs_zero_range(
 		return dax_zero_range(inode, pos, len, did_zero,
 				      &xfs_dax_write_iomap_ops);
 	return iomap_zero_range(inode, pos, len, did_zero,
-				&xfs_buffered_write_iomap_ops);
+				&xfs_buffered_write_iomap_ops, NULL);
 }
 
 int
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6697da4610cc..d2debb7f4344 100644
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


