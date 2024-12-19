Return-Path: <linux-fsdevel+bounces-37852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 659199F824B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91ED71647D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8071C32FF;
	Thu, 19 Dec 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gbxRUnwE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70BF1C1F00;
	Thu, 19 Dec 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630032; cv=none; b=dFJxVcdax113GeI/xhaBLE8MjJiCFy6eUtYIhRyIx0QdphJV1sMx6jln5WIqqOFysG890yBcPKoN7xEU78QnEWemme3XNPF7x4pm/2vOn37Vk9RMHIn5zNguNNEZFehJnQOOiZJj4tI7Cy46vopvolBhUxqu9lIBArkbSCrXwRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630032; c=relaxed/simple;
	bh=mLViWgD+RtS5XadUndp2k5UhR4wOME9iyu6Gq8uUXqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCRlKICTYd53WmlR/BIfRHJTBgJEYdv9wmhYEN7yGQZRk6iuAkgaQjq3asLcyZi1xWK0fj6FCfFvS1xiTZFVKCSdsoqXcubUVXb8JNcsuJVo1hN0B4+TgWKv9dJsHwHCaa/eVt6gydQRlYuibgVfdUD6yFBzWTTOdxbmi/xcO8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gbxRUnwE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FAHPHVvSl4CDPR+og6w0xvXeVViND3rETjbXJzxK4Nc=; b=gbxRUnwEwh+Zk4yp4h9qT/HGUx
	LfJcuI8iJettesYs9/ykICLULzylGaNK06lHUEdnce7aJUdCPKYFcIdJlf5nMUrGcB/GlxdEFLC3y
	Q42chA8lFvD3qChtbhw9NBJde7QZx13a7CdGS/CNcnDoht/yoF/gAZ/wx+GnK0w4f9+wbphSOnZJQ
	5KGfibr7RBDbhtFbPoZcguuUmjMGsGpQFJkaY9rtBci6bO+ce+JrK/SEEIinrhxAh01qsZUYmtH0K
	21SaHVw9485KjM5IzvpHnewSySIuHwP4dp/WwUP8KOhOhiNpWhssoPctxOSMh8PlCSTQyifFpm7/K
	RQnkWb/g==;
Received: from [2001:4bb8:2ae:97bf:7b0d:9cbd:e369:c821] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOKVi-00000002b14-0SF0;
	Thu, 19 Dec 2024 17:40:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/10] iomap: pass private data to iomap_page_mkwrite
Date: Thu, 19 Dec 2024 17:39:13 +0000
Message-ID: <20241219173954.22546-9-hch@lst.de>
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
 fs/iomap/buffered-io.c | 4 +++-
 fs/xfs/xfs_file.c      | 3 ++-
 fs/zonefs/file.c       | 2 +-
 include/linux/iomap.h  | 5 ++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 06b90d859d74..e33309fa0a11 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1489,11 +1489,13 @@ static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
 	return length;
 }
 
-vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
+vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
+		void *private)
 {
 	struct iomap_iter iter = {
 		.inode		= file_inode(vmf->vma->vm_file),
 		.flags		= IOMAP_WRITE | IOMAP_FAULT,
+		.private	= private,
 	};
 	struct folio *folio = page_folio(vmf->page);
 	ssize_t ret;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 9a435b1ff264..2b6d4c71994d 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1498,7 +1498,8 @@ xfs_write_fault(
 	if (IS_DAX(inode))
 		ret = xfs_dax_fault_locked(vmf, order, true);
 	else
-		ret = iomap_page_mkwrite(vmf, &xfs_buffered_write_iomap_ops);
+		ret = iomap_page_mkwrite(vmf, &xfs_buffered_write_iomap_ops,
+				NULL);
 	xfs_iunlock(ip, lock_mode);
 
 	sb_end_pagefault(inode->i_sb);
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 35166c92420c..42e2c0065bb3 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -299,7 +299,7 @@ static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)
 
 	/* Serialize against truncates */
 	filemap_invalidate_lock_shared(inode->i_mapping);
-	ret = iomap_page_mkwrite(vmf, &zonefs_write_iomap_ops);
+	ret = iomap_page_mkwrite(vmf, &zonefs_write_iomap_ops, NULL);
 	filemap_invalidate_unlock_shared(inode->i_mapping);
 
 	sb_end_pagefault(inode->i_sb);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 1ef4c44fa36f..6697da4610cc 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -316,9 +316,8 @@ int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops);
 int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
-vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
-			const struct iomap_ops *ops);
-
+vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops,
+		void *private);
 typedef void (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length,
 		struct iomap *iomap);
 void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
-- 
2.45.2


