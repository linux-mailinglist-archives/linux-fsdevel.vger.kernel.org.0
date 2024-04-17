Return-Path: <linux-fsdevel+bounces-17192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91EC8A8AA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3B91C2405F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D83175570;
	Wed, 17 Apr 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rAz1G4SX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CF173335
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376625; cv=none; b=eBxIJlBHBP+RpTl5GJhKZZnNKIpfg58zxourTuRXcW2ZAiAjt8Ru2cTVKOzfNuYzJoJIt+xe2/fUSSV5T9cATBOzet2ISpGJkePbfI532s2gO5W8/PuFS6mpU8PIgJDk+1fs4/69htvxSeXUWR65auti2vxQ2u1BRRVgPCK5My4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376625; c=relaxed/simple;
	bh=ptPAZsmbxQ6USaurnluHSs0lhBDnfDdqmcYkfpdFAU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ob+oF3xRwlXFdt8WdEpOja85dPCVoMt5QVUK46Q1bBIMT0GXSQ6fV6h6UdIpF03vepr8MJdsL2FaFzfrtaTWqlo+PcUL73YQNAqLxocsW+mLrvh9OhOj/uHr7BJqOICIJf18glVm7UfWPDcEs4WdvOVmfd7do3LwUOAtGRXBuNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rAz1G4SX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xdctCk7WpjDOZwE/Xja38nor8XSItWxpytbQ6MyEJpI=; b=rAz1G4SXWFTkPW5I2H5XmxO/my
	kJAGcuZxfJt9Oj0yGvJMzMle+wS0iUJwLTPpEuQ06C/IbbxyRaGZtUso5w+gxYSMeSjk10qqgWck5
	y0/znq6tNrBZ/6V36MOSgjTC0UySBaTcunB65i23bOXwBuGnbzRia8Q0hJ5X9Szf4EFaAq/LQYJqV
	2hqHAGvg2qNUydZZigkmE4qndPWzm4Dg50tVJa+idhaTBE4PBWAvE/EG+Dfm+2/VdqjyE+7TOn7eW
	mVPTWANzF0KLbilSZ6R3HC0EF5Y7rme+HXQhLbmLIgslO3nKfv5LKlHSXp0jhgMM0WT8T2EHzOioK
	1zriOjtA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9Wo-00000003QtT-0P1s;
	Wed, 17 Apr 2024 17:57:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 08/13] jfs; Convert __invalidate_metapages to use a folio
Date: Wed, 17 Apr 2024 18:56:52 +0100
Message-ID: <20240417175659.818299-9-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417175659.818299-1-willy@infradead.org>
References: <20240417175659.818299-1-willy@infradead.org>
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
index dd540df0a617..90a284d3bef7 100644
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


