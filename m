Return-Path: <linux-fsdevel+bounces-23497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8889A92D59B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 18:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94571C2367B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86CF194C7B;
	Wed, 10 Jul 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gmzMK5JO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF99194A68
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627193; cv=none; b=Lhz8nXeiOqQAJ5POdfjGFB4HvICvpBSANwsuAWp3fZ3KQKaAtSdgy7V2Pl4595BBjizDzskEDQWumQ5IcjBBrVMKM+5qLcH2wOfnJRESOldGopzL8TsodAX/6v3ngKUyRXUjOfr/4xGwcEQyXLKAUgeTxm9T50XYepmpWA9ooyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627193; c=relaxed/simple;
	bh=oaJnMNnOr6wsn9R96CPUpJZpneobj8WjtenNHWqobgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALLc2s9OT9B8zOxw0NCxWYUWYeN2yv1Ed3Ab1ihSMNY4b/in4ZvR88PuUWkQTA4+P/ADSMUg2hCTdXdJz8GbywNCDRfz8peqxNmEEjzk7F3H5A882sc9NzSFiXQNvkANjDSkkF3Nl3OYxdwtle8FmZiE/3gTONJxhz1wk85OZbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gmzMK5JO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gbFge8k7xQLezmU1IbmhkccbHir+6ZsrSbpp01H5LV8=; b=gmzMK5JOUgPV3Kg2OqOhE75u99
	FrYfX1MsIj0f+uTKBWHATzlngoCAcpp4KoI0ymBfrmNWwriUOxyKkNXFZC32THtUdve1mIZToojuT
	5uuGscv+UhWQhiMVFkKHMBc812v1poqMnBjw570j5yhdUBX00QXuOEe0Ycl8cU+zjqpv6itUE+m2I
	EdZEHCKVO9gA4RO+47/W1ivHZHsXdEzEAuvAxU4HjD5Z2fYn5MWUxxxNEllYUcHfKsjACHvBSDrzh
	xGXmocONLfPxBD5i6gNGnpl5LqfM3BsgCWSa/cGkiJbqsMiK2G7irUYrNIa5I+yOTemjLRxXlBJGl
	OFI5j8ng==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRZjR-00000009TEP-0Ysb;
	Wed, 10 Jul 2024 15:59:49 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3/6] qnx6: Convert qnx6_longname() to take a folio
Date: Wed, 10 Jul 2024 16:59:41 +0100
Message-ID: <20240710155946.2257293-4-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710155946.2257293-1-willy@infradead.org>
References: <20240710155946.2257293-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes a conversion from folio to page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/qnx6/dir.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/qnx6/dir.c b/fs/qnx6/dir.c
index daf9a335ba22..0de2a047a174 100644
--- a/fs/qnx6/dir.c
+++ b/fs/qnx6/dir.c
@@ -46,19 +46,20 @@ static unsigned last_entry(struct inode *inode, unsigned long page_nr)
 
 static struct qnx6_long_filename *qnx6_longname(struct super_block *sb,
 					 struct qnx6_long_dir_entry *de,
-					 struct page **p)
+					 struct folio **foliop)
 {
 	struct qnx6_sb_info *sbi = QNX6_SB(sb);
 	u32 s = fs32_to_cpu(sbi, de->de_long_inode); /* in block units */
 	u32 n = s >> (PAGE_SHIFT - sb->s_blocksize_bits); /* in pages */
-	/* within page */
-	u32 offs = (s << sb->s_blocksize_bits) & ~PAGE_MASK;
+	u32 offs;
 	struct address_space *mapping = sbi->longfile->i_mapping;
-	struct page *page = read_mapping_page(mapping, n, NULL);
-	if (IS_ERR(page))
-		return ERR_CAST(page);
-	kmap(*p = page);
-	return (struct qnx6_long_filename *)(page_address(page) + offs);
+	struct folio *folio = read_mapping_folio(mapping, n, NULL);
+
+	if (IS_ERR(folio))
+		return ERR_CAST(folio);
+	offs = offset_in_folio(folio, s << sb->s_blocksize_bits);
+	*foliop = folio;
+	return kmap(&folio->page) + offs;
 }
 
 static int qnx6_dir_longfilename(struct inode *inode,
@@ -69,7 +70,7 @@ static int qnx6_dir_longfilename(struct inode *inode,
 	struct qnx6_long_filename *lf;
 	struct super_block *s = inode->i_sb;
 	struct qnx6_sb_info *sbi = QNX6_SB(s);
-	struct page *page;
+	struct folio *folio;
 	int lf_size;
 
 	if (de->de_size != 0xff) {
@@ -78,7 +79,7 @@ static int qnx6_dir_longfilename(struct inode *inode,
 		pr_err("invalid direntry size (%i).\n", de->de_size);
 		return 0;
 	}
-	lf = qnx6_longname(s, de, &page);
+	lf = qnx6_longname(s, de, &folio);
 	if (IS_ERR(lf)) {
 		pr_err("Error reading longname\n");
 		return 0;
@@ -89,7 +90,7 @@ static int qnx6_dir_longfilename(struct inode *inode,
 	if (lf_size > QNX6_LONG_NAME_MAX) {
 		pr_debug("file %s\n", lf->lf_fname);
 		pr_err("Filename too long (%i)\n", lf_size);
-		qnx6_put_page(page);
+		qnx6_put_page(&folio->page);
 		return 0;
 	}
 
@@ -102,11 +103,11 @@ static int qnx6_dir_longfilename(struct inode *inode,
 	pr_debug("qnx6_readdir:%.*s inode:%u\n",
 		 lf_size, lf->lf_fname, de_inode);
 	if (!dir_emit(ctx, lf->lf_fname, lf_size, de_inode, DT_UNKNOWN)) {
-		qnx6_put_page(page);
+		qnx6_put_page(&folio->page);
 		return 0;
 	}
 
-	qnx6_put_page(page);
+	qnx6_put_page(&folio->page);
 	/* success */
 	return 1;
 }
@@ -180,23 +181,23 @@ static unsigned qnx6_long_match(int len, const char *name,
 {
 	struct super_block *s = dir->i_sb;
 	struct qnx6_sb_info *sbi = QNX6_SB(s);
-	struct page *page;
+	struct folio *folio;
 	int thislen;
-	struct qnx6_long_filename *lf = qnx6_longname(s, de, &page);
+	struct qnx6_long_filename *lf = qnx6_longname(s, de, &folio);
 
 	if (IS_ERR(lf))
 		return 0;
 
 	thislen = fs16_to_cpu(sbi, lf->lf_size);
 	if (len != thislen) {
-		qnx6_put_page(page);
+		qnx6_put_page(&folio->page);
 		return 0;
 	}
 	if (memcmp(name, lf->lf_fname, len) == 0) {
-		qnx6_put_page(page);
+		qnx6_put_page(&folio->page);
 		return fs32_to_cpu(sbi, de->de_inode);
 	}
-	qnx6_put_page(page);
+	qnx6_put_page(&folio->page);
 	return 0;
 }
 
-- 
2.43.0


