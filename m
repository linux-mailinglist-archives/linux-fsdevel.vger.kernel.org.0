Return-Path: <linux-fsdevel+bounces-37033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F4B9EC7D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 09:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC92287C90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EF51EC4E1;
	Wed, 11 Dec 2024 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wOj3muKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FBF1EC4C9;
	Wed, 11 Dec 2024 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907282; cv=none; b=Se01080FF0d7UBv8ozO7dcrk5ZCAcUX2yFo64VDSk+bnODTMGFRd87JB2MjpEDE1tTfOTfUdSdZ4uEkc0AXFZabv40zUFBaumv2bTQL9sbyKV+uRHPh0DAucmMDDiPVmWtQ+ogmDRkmhokccZ2H0vGpNYNlShJCVRKoxvrGLY8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907282; c=relaxed/simple;
	bh=22xKvtQB3hBt/wMbK4K7m+N/OlXqBjzTgqnNyjU9cv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldwx0nsdX1aAIPn7CdGEyvCxA+8gJY9psFFqPbe1eA8aOhE3Gf7sP7vUYZRMaRN+s0EMrDAIAUZhlzMKWhBFQ1Q4snBu+pfIVvi2Nj2bz0ymoFKSgXenA0cYfSsWxQ4OinNmiqTpNJ7HU0Y6ZpT43Sub9rvuewlqBaB+TUnqmCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wOj3muKk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JWrQTLPJj9WrrvCZEaj3bZMKArTx3YfKO/qtnfa2R0k=; b=wOj3muKkP/8NKEhlWYmnZBnGSm
	eyHfo01zBzMqMObOCmj3ChLcvIW+iAUf002yMfalBoVyKeeqwneZUoVthpYBKN4ZgsXw3p6gjIPc1
	F0VY/Hs1LRS5qqnERCOVCbtf68ttOn4AmIcPNrUa/7nMiMViy9VVfjM0b55stklAFe/+6LuJFj95O
	UsaoSZlMFfG9qb7X2Un+zZ/BZifod7qkYznZ/RANC/7hw62z/UWQP+LL6nrFHkUkEjbPBLDiRqCm0
	jj/lTNrmpLa1NgEZEZ3pgmFCqm8bu9eThGs3buYM971Pjl+76oO6/DCx/+O21M4dHsVXByu6y9X1W
	uA9lBsBg==;
Received: from [2001:4bb8:2ae:8817:935:3eb8:759c:c417] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLIUS-0000000EIPq-301Q;
	Wed, 11 Dec 2024 08:54:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/8] iomap: pass private data to iomap_page_mkwrite
Date: Wed, 11 Dec 2024 09:53:46 +0100
Message-ID: <20241211085420.1380396-7-hch@lst.de>
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
 fs/iomap/buffered-io.c | 4 +++-
 fs/xfs/xfs_file.c      | 3 ++-
 fs/zonefs/file.c       | 2 +-
 include/linux/iomap.h  | 5 ++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ceca9473a09c..0863c78dc69f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1495,11 +1495,13 @@ static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
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
index f6943c80e5fd..2d1c53024ed1 100644
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


