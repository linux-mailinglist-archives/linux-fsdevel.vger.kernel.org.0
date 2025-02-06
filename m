Return-Path: <linux-fsdevel+bounces-41034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3891A2A120
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 07:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A233A82C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBA4224B08;
	Thu,  6 Feb 2025 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z6gO0Ty0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1C520B208;
	Thu,  6 Feb 2025 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824061; cv=none; b=nyJ2absm7SjbGlsurHZJswjivxS/6/7sfd3OvHb2foiG3hdDsNNu/do0g6yyBE0w28KgwmUDQlHQyoEgaWQDn3OvmXZU+UiBfHaLBQIjf2p6CprgRaay3kiYAxjz9nGxOom0uol9GmqndxvX/LyUuQaM6SOGMM01K0KLO1W9rjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824061; c=relaxed/simple;
	bh=l39YiphIDxPXHbGAHvGGAon/fSCtCvTx2iGaIGe1LI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FywLFprdzbwfzel59Ac/KHDYlpf5BFD6xYrGMTQfxExaj7XO6dPxSUzL2JqBnlBZibMWodegVhuxFP2/1J/vRtW+3EvBI0ZQr5DREHuUsCkX7ViSPpWdlQNCenmPzUQkIHcraTop0UxD8bBcPVFO4L3fwWSaJwJc2V0IbC3bKJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z6gO0Ty0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GDuI/a4YXG2UnPiXWB+G8EJSxX8sTPJQxgvr4O+BVTg=; b=z6gO0Ty0u+GPOG04svhhdsuKBm
	ja3iH3dlL5a0UAAH/WewpAwEbsf6ICjURBVXeSNKmmBlfoCjN20rnePtjEgJ5Mv6BjOHutZYcv/yJ
	n85L1oFYbs1DgOtEgr4oPezVd83al998dvfX5EQWF/qEILLALicRQD/x5SrOgktM1XaW3YHF8ywAt
	XV4FM1sY+vT0RapD2O8qLWqUctfFqrJFwOqCh8d2L6JJZ8N84QW1mGIia5b/7uQnDc45euOyFt5UW
	KF3kiMTBHGE78Rf2flzn+HP+FXUCB1K7HFEsbCaURgly9exAb+ZzZHy6WBAZsLYofyS2vUQcPUcs8
	Wvkl1k2A==;
Received: from 2a02-8389-2341-5b80-9d5d-e9d2-4927-2bd6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9d5d:e9d2:4927:2bd6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfvZL-00000005PXA-10w9;
	Thu, 06 Feb 2025 06:40:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/11] iomap: pass private data to iomap_page_mkwrite
Date: Thu,  6 Feb 2025 07:40:07 +0100
Message-ID: <20250206064035.2323428-10-hch@lst.de>
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
 fs/iomap/buffered-io.c | 4 +++-
 fs/xfs/xfs_file.c      | 3 ++-
 fs/zonefs/file.c       | 2 +-
 include/linux/iomap.h  | 5 ++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4abff64998fe..8c24d8611edf 100644
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
index f7a7d89c345e..785f6bbf1406 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1511,7 +1511,8 @@ xfs_write_fault(
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
index b4be07e8ec94..d528eb4d5cfe 100644
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


