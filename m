Return-Path: <linux-fsdevel+bounces-20262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E29488D08CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D68E1C21849
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 16:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10E315A855;
	Mon, 27 May 2024 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K2OYVydg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF83D155C96;
	Mon, 27 May 2024 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827788; cv=none; b=Xbv3V1kLBGKa+R7qPrbOR7BiX4qKOwll3wHFadHdQC+x4jIU6I19CDztxcEkN0W/B6GjRWl2YVwRDLgTros+tc8v82ozi1nr5nb3RiCiNuFmNcT7M/Cx2QPiFOwX0qinxWNRZo87A3tILtR39JDSX+sI4gVc/8GIxZ1JBjL2O6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827788; c=relaxed/simple;
	bh=6XZlotLjP3r5f5t9P/KPPR+9SK+bBfdsrRTz57vSURc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTkFXVGhfM7AfwxBSX8xhFZsQ4ukf+efjTCvTWWzWRbkeqSQCeitgduxhKPjgZzrMnKrUp6H+aB6CPi5CTjpyLAyrWkekMnwGJcPCT7Vp3sH2PfZnNkkOV3x5WbHRO493Nbt4wrhun4LUlpJVFVMILReq3JWQ9mt9/Ovkgn2IbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K2OYVydg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=K4Mxq5Sr+5purWqI8GGeOoyAJxibrH1gh6qH/UJ9bOw=; b=K2OYVydgR+//Tm+fbwytqZykcF
	MrgUbGSku0QuXH1fWLVjNH2ND/9nYF9fqS34hhFdndgKYKYGc2T7RsAgcq628Wt96VO7vdDbnlTBu
	VztbKpmWjw6h0VkDDqTBOiVaWP29qg6arvApSZmKPwVX7r4Z5wm8MR0CI4Ibaepbk7JmSMJIYgnea
	BiKHFs1s6lcYlvMC7PplksdiAm/46rv7/lwE5V+dszHmcsdmdLtYNqirCe7R1X2o6MCFlr0bj0VNX
	G3+N+JdoLsFxUOpLA9+t+uHTKLsp7hOl3z5FLNSqG+XkXX33/C9pqnIvse9fHjugysF+ilMEOpuWA
	r1uXFRRw==;
Received: from 2a02-8389-2341-5b80-3177-e4c1-2108-f294.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3177:e4c1:2108:f294] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBdKj-0000000Ft6i-2WfQ;
	Mon, 27 May 2024 16:36:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] nfs: add support for large folios
Date: Mon, 27 May 2024 18:36:09 +0200
Message-ID: <20240527163616.1135968-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527163616.1135968-1-hch@lst.de>
References: <20240527163616.1135968-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

NFS already is void of folio size assumption, so just pass the chunk size
to __filemap_get_folio and set the large folio address_space flag for all
regular files.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/file.c  | 4 +++-
 fs/nfs/inode.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 6bd127e6683dce..7f1295475a90fd 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -339,6 +339,7 @@ static int nfs_write_begin(struct file *file, struct address_space *mapping,
 			   loff_t pos, unsigned len, struct page **pagep,
 			   void **fsdata)
 {
+	fgf_t fgp = FGP_WRITEBEGIN;
 	struct folio *folio;
 	int once_thru = 0;
 	int ret;
@@ -346,8 +347,9 @@ static int nfs_write_begin(struct file *file, struct address_space *mapping,
 	dfprintk(PAGECACHE, "NFS: write_begin(%pD2(%lu), %u@%lld)\n",
 		file, mapping->host->i_ino, len, (long long) pos);
 
+	fgp |= fgf_set_order(len);
 start:
-	folio = __filemap_get_folio(mapping, pos >> PAGE_SHIFT, FGP_WRITEBEGIN,
+	folio = __filemap_get_folio(mapping, pos >> PAGE_SHIFT, fgp,
 				    mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index acef52ecb1bb7e..6d185af4cb29d4 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -491,6 +491,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 			inode->i_fop = NFS_SB(sb)->nfs_client->rpc_ops->file_ops;
 			inode->i_data.a_ops = &nfs_file_aops;
 			nfs_inode_init_regular(nfsi);
+			mapping_set_large_folios(inode->i_mapping);
 		} else if (S_ISDIR(inode->i_mode)) {
 			inode->i_op = NFS_SB(sb)->nfs_client->rpc_ops->dir_inode_ops;
 			inode->i_fop = &nfs_dir_operations;
-- 
2.43.0


