Return-Path: <linux-fsdevel+bounces-41948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9366AA39337
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D59A1891C02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE751C700B;
	Tue, 18 Feb 2025 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TYZC6Ztv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910011B21B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857931; cv=none; b=dlv/DL29AHhsCzdcdxho7sfd/TfS3VMiOwvQ+4lQGstE0Jk8t9gLhEAQZziHuiBhjLiYJrG/IiogX4cShshY7VJvvCsSSRN63mH77228GGqOWRHJ8aRTENLqR3Ux7cX+e+Lipvrycgw3NuOeTAZqGYgCoL7fCtabdtLxFl3Amg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857931; c=relaxed/simple;
	bh=UTwCLOHEgutyH3OB1zkMrf/v+zsNWvhkh+JQ/yOhXWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKycj3M3mX32X2+ipBFlKC2Kx5JKBdP4snjAqrbZDwI65RAm0fECGlWL2z9JR/cxO2IYktKqq46IH8QnIbLtChs4tG5J8O7LsiTTy2B1bMnS7TKZQ0p3DcKDhkualkVgIovCLA64/EBCKlN3An0KIvQwPLuPW2A1iQuBapzWjbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TYZC6Ztv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=e/scrlPF9Nuommu0AaLdjJYTM9nSFLlyoatgBo1kEyk=; b=TYZC6ZtvhUAGk4adZthzzV3cqA
	908B3Js9iNm9pVV3EqQdbKM1uo7cd2AOCDl9zAK4M36zd75QB1PVmZi02zP3l95tsZaGpaOvC9esb
	7kyD7f+VH5SX060P7gr5zwZ/oDSGCMQNm2h4FLI5Oprk0l9fptdCXwqms2oybocHRN6o7WH6p5RGL
	D07vUeiiygerUtG9VRYIa4CR+hO3u1+8vF+ss1QeEQ3jgass6pMsSF3QM8VZ40cuwUHD4pEfJ/tdY
	z9BEx/xMt8O1BySP5zxOYKCcfrR2xyvlwimmC014QSXvlZPVJXNBADHILwOXFx+NUDr+lyKTbc5PH
	JPwbmdQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWd-00000002Tsu-3s4X;
	Tue, 18 Feb 2025 05:52:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/27] f2fs: Use a folio throughout f2fs_truncate_inode_blocks()
Date: Tue, 18 Feb 2025 05:51:52 +0000
Message-ID: <20250218055203.591403-19-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use f2fs_get_node_folio() to get a folio and use it throughout.  Remove a
few calls to compound_head() and a reference to page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/node.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2d161ddda9c3..e1ed7ccfb690 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1130,7 +1130,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 	unsigned int nofs = 0;
 	struct f2fs_inode *ri;
 	struct dnode_of_data dn;
-	struct page *page;
+	struct folio *folio;
 
 	trace_f2fs_truncate_inode_blocks_enter(inode, from);
 
@@ -1140,16 +1140,16 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 		return level;
 	}
 
-	page = f2fs_get_node_page(sbi, inode->i_ino);
-	if (IS_ERR(page)) {
-		trace_f2fs_truncate_inode_blocks_exit(inode, PTR_ERR(page));
-		return PTR_ERR(page);
+	folio = f2fs_get_node_folio(sbi, inode->i_ino);
+	if (IS_ERR(folio)) {
+		trace_f2fs_truncate_inode_blocks_exit(inode, PTR_ERR(folio));
+		return PTR_ERR(folio);
 	}
 
-	set_new_dnode(&dn, inode, page, NULL, 0);
-	unlock_page(page);
+	set_new_dnode(&dn, inode, &folio->page, NULL, 0);
+	folio_unlock(folio);
 
-	ri = F2FS_INODE(page);
+	ri = F2FS_INODE(&folio->page);
 	switch (level) {
 	case 0:
 	case 1:
@@ -1178,7 +1178,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 
 skip_partial:
 	while (cont) {
-		dn.nid = get_nid(page, offset[0], true);
+		dn.nid = get_nid(&folio->page, offset[0], true);
 		switch (offset[0]) {
 		case NODE_DIR1_BLOCK:
 		case NODE_DIR2_BLOCK:
@@ -1199,7 +1199,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 			BUG();
 		}
 		if (err == -ENOENT) {
-			set_sbi_flag(F2FS_P_SB(page), SBI_NEED_FSCK);
+			set_sbi_flag(F2FS_F_SB(folio), SBI_NEED_FSCK);
 			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 			f2fs_err_ratelimited(sbi,
 				"truncate node fail, ino:%lu, nid:%u, "
@@ -1210,18 +1210,18 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 		}
 		if (err < 0)
 			goto fail;
-		if (offset[1] == 0 && get_nid(page, offset[0], true)) {
-			lock_page(page);
-			BUG_ON(page->mapping != NODE_MAPPING(sbi));
-			set_nid(page, offset[0], 0, true);
-			unlock_page(page);
+		if (offset[1] == 0 && get_nid(&folio->page, offset[0], true)) {
+			folio_lock(folio);
+			BUG_ON(folio->mapping != NODE_MAPPING(sbi));
+			set_nid(&folio->page, offset[0], 0, true);
+			folio_unlock(folio);
 		}
 		offset[1] = 0;
 		offset[0]++;
 		nofs += err;
 	}
 fail:
-	f2fs_put_page(page, 0);
+	f2fs_folio_put(folio, false);
 	trace_f2fs_truncate_inode_blocks_exit(inode, err);
 	return err > 0 ? 0 : err;
 }
-- 
2.47.2


