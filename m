Return-Path: <linux-fsdevel+bounces-9937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FA78463BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970D31C2603C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA2E47F57;
	Thu,  1 Feb 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qfnHg624"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CFC405CF
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827574; cv=none; b=sr1BVI8Z07PeiBVDvCrZf05uduFG562dC7QGtVpe2IWHgg+FdoCCqR+D3otStJYCgDMfMR1YURSsMXQyKXJYC6vJa3Y/ZUbnM9C4aJArT7zOLEmvfPO7LeqfLxmwJFMYWEaLV91u5K8TXkJov+cQnW3IZZYtyZ6BgHsGNESixD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827574; c=relaxed/simple;
	bh=e6P1wMHtswPqTsN1jezfotusjcw5ZXEf1LNdqHUQhM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnWCx2Bs2Ff/myjXTxO9GEKPD2J8iECpkcnvLUGxReoFigYGQdUhiUcnClFdqgqH0JCQy0Eok6oE2PA3i3DlRV7JIiSnUNOVp0U7xpTv4PvrtezMvFiGAUkQt8q2vBJweq7yCXMAGHcUyYhH9kC2Abgyb9IAVLu7QG1MSVCDucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qfnHg624; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=LToxImH7Ggtjf8LnUXIYlXIE9yIbwLP7ppNPw0lx91E=; b=qfnHg624No/qd5VmwS6PL8PMQs
	0TwpPi/IAjClOPJSeqjHcwm3JKYrXfQO2suiDu/AEnAdeXNOonwTM7NMZtuuAVd1P6OBnGEvTSEJ/
	myx1Z0plxW0QxVPVXYyyQzGGhc8LWfIINcKKqqe0wIA20UuuR1FHBp/cuQ4Iga18Ttcy+YECX7aHU
	zucWkEAYJ9E5NslQYYeOYRV/+K9gtYH8e1BLUC+9/KqMu2tE9iHvp0kBj5tQ0aN9xN9eoSu3NOKt1
	3RpWGdk1PexYY6ONm3I9a65rrleLLFDAgzAijZcZH68J3EogBktep4t5T+IoExuDyxpWozRHbNwn7
	k05HmS2w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVfot-0000000H18g-3hdA;
	Thu, 01 Feb 2024 22:46:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/13] jfs; Convert __invalidate_metapages to use a folio
Date: Thu,  1 Feb 2024 22:45:57 +0000
Message-ID: <20240201224605.4055895-9-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201224605.4055895-1-willy@infradead.org>
References: <20240201224605.4055895-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Retrieve a folio from the page cache instead of a page.  Saves a
couple of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 552e6e97537c..2eb9db0184c1 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -791,7 +791,6 @@ void __invalidate_metapages(struct inode *ip, s64 addr, int len)
 	struct address_space *mapping =
 		JFS_SBI(ip->i_sb)->direct_inode->i_mapping;
 	struct metapage *mp;
-	struct page *page;
 	unsigned int offset;
 
 	/*
@@ -800,11 +799,12 @@ void __invalidate_metapages(struct inode *ip, s64 addr, int len)
 	 */
 	for (lblock = addr & ~(BlocksPerPage - 1); lblock < addr + len;
 	     lblock += BlocksPerPage) {
-		page = find_lock_page(mapping, lblock >> l2BlocksPerPage);
-		if (!page)
+		struct folio *folio = filemap_lock_folio(mapping,
+				lblock >> l2BlocksPerPage);
+		if (IS_ERR(folio))
 			continue;
 		for (offset = 0; offset < PAGE_SIZE; offset += PSIZE) {
-			mp = page_to_mp(page, offset);
+			mp = page_to_mp(&folio->page, offset);
 			if (!mp)
 				continue;
 			if (mp->index < addr)
@@ -817,8 +817,8 @@ void __invalidate_metapages(struct inode *ip, s64 addr, int len)
 			if (mp->lsn)
 				remove_from_logsync(mp);
 		}
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 }
 
-- 
2.43.0


