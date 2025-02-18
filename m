Return-Path: <linux-fsdevel+bounces-41949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E0FA39336
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C60165515
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735491C7010;
	Tue, 18 Feb 2025 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k48cTfr2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E741B423D
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857931; cv=none; b=Oh2E4FgzuaX0p6KqgSdYoGns/4yvH+uOUEHztU46njZbsvARRohPEt197gVpvNaxpvIeLE+TnPwY1aA+7ua0BYnPV51pdgztdUeOaLqRB9lFTCUfd5fdT60HfA0Pvg9S9Ou/uEEVg7ocFkb8x9awY7ggfRcKg8Vs9UEczUmCY+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857931; c=relaxed/simple;
	bh=X69FFXztQktD/ksSZZzHJK1WHM/pjEeAR2SCLxtDUg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqK+A5YH76pZ59gOkPwkN7LJC+ye3PJJPff3X3rIhuJLn8ZnAeZgKCjDNiT2rF554b51gdQJYtOaOCWIOyn4C4dsgj8xZUZYr1kdLGUEu2d3kp4R3naT8E1etm6gXsyxsaBdS+4SePSUkyhAqPjZdYvYaC4VdwoZRYrrJXw3fUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k48cTfr2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=s1CFGYWZAtt7BsUGV9ZEVbRTHj4UASOxllRmfzj9/2A=; b=k48cTfr23zhiHyZ58KKy63TFud
	eoc5G6DuJaxFkoC8o5ucq2aZ4wrhOo4yPMrgsT1T6Sfv5fUZINCmFaeenyJHv9AlqsM4fRqXCB5in
	BDIN/XHcoSGDhTxFWvQQmVu+0rGIsCur/WBIWDD9ved0DuIi7gOA6lAJsAkSu+HGQT2OlPijN8DM5
	f+cBmEa+eLuKlSTmjnrnNZBhFyga6mjjYAKzLUh6wjq8Sg7O6bi4p5hlQ/iHrPMgxBO7+pKKnoedx
	RTA5dj+Ry/jaBdh4JegKohB2ND9+QLAomyNrGyNLB06ALDVEO1VKTOQmx3y+42OAtMpHg+oT0FYZk
	K+kKvrYw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWd-00000002Tsn-3LWo;
	Tue, 18 Feb 2025 05:52:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/27] f2fs: Add f2fs_get_node_folio()
Date: Tue, 18 Feb 2025 05:51:51 +0000
Message-ID: <20250218055203.591403-18-willy@infradead.org>
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

Change __get_node_page() to return a folio and convert back to a page in
f2fs_get_node_page() and f2fs_get_node_page_ra().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/node.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bbaa61da83a8..8f23bb082c6f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3689,6 +3689,7 @@ struct page *f2fs_new_inode_page(struct inode *inode);
 struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
 void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
 struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
+struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid);
 struct page *f2fs_get_node_page_ra(struct page *parent, int start);
 int f2fs_move_node_page(struct page *node_page, int gc_type);
 void f2fs_flush_inline_data(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index da28e295c701..2d161ddda9c3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1449,7 +1449,7 @@ void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 	f2fs_put_page(apage, err ? 1 : 0);
 }
 
-static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
+static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 					struct page *parent, int start)
 {
 	struct folio *folio;
@@ -1462,7 +1462,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 repeat:
 	folio = f2fs_grab_cache_folio(NODE_MAPPING(sbi), nid, false);
 	if (IS_ERR(folio))
-		return ERR_CAST(folio);
+		return folio;
 
 	err = read_node_page(&folio->page, 0);
 	if (err < 0) {
@@ -1493,7 +1493,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 	}
 page_hit:
 	if (likely(nid == nid_of_node(&folio->page)))
-		return &folio->page;
+		return folio;
 
 	f2fs_warn(sbi, "inconsistent node block, nid:%lu, node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
 			  nid, nid_of_node(&folio->page), ino_of_node(&folio->page),
@@ -1512,17 +1512,25 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 	return ERR_PTR(err);
 }
 
+struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid)
+{
+	return __get_node_folio(sbi, nid, NULL, 0);
+}
+
 struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
 {
-	return __get_node_page(sbi, nid, NULL, 0);
+	struct folio *folio = __get_node_folio(sbi, nid, NULL, 0);
+
+	return &folio->page;
 }
 
 struct page *f2fs_get_node_page_ra(struct page *parent, int start)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(parent);
 	nid_t nid = get_nid(parent, start, false);
+	struct folio *folio = __get_node_folio(sbi, nid, parent, start);
 
-	return __get_node_page(sbi, nid, parent, start);
+	return &folio->page;
 }
 
 static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
-- 
2.47.2


