Return-Path: <linux-fsdevel+bounces-9927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E768463A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4813A1C25FC5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAE946535;
	Thu,  1 Feb 2024 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BNo3y0s8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803D846439
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827571; cv=none; b=n0cfgUkwoAmtfk+TGnGBEtPr2kOloiSDvuY90jRpA3vJowFPhCC/AUwDpKJSY4uxwuIiBVO73GZP0p4K/ii8ap99LiDdn+i1C3LwN9trFpg2RZnEEeUFh1JK2IIdGM22LXkyOp4km6jn/NOC06ICh7fUKDlIQ0Bg1VuHKkoamMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827571; c=relaxed/simple;
	bh=KnJJCpTcdUhV3W47B8I2pmRC5IRBCRmUcD0PS4pSasY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVObidYaR7awPDAHnIhnmQuYJtHYvBZFwLhTtUwcCCtMsd4Dr0U2yXF2fw1M1K44k5sctmgPhRQyLqdCmu0E1cGGkGQP1JC7o6nZkeG0E16reD5wXjhui1ljHqiOC1eaV7diRHjxw1utxdmzuzA8sXiuvjqqPbevg/+DHU+MSSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BNo3y0s8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=D9EBnQ6ShJLhbDLeJCMWhwk0es97hySDrklC2B03Dko=; b=BNo3y0s812ggs9a+/zqw96bcKO
	qcO8ok3ZvxEu5/6tZ4ajf5XB9SA/BDPF6qtgOyAtDX42jYBMSQHQYBSqGTZimg6CyvCRHbFQ8uRos
	FcEkIU7FcDBRVGBw9qBdayGgWTW7VUupim93zEHvoiRu2a24TWYJcXBRgsC32qVnOAMMGsYSwrks9
	dwciRqnj26MyZaX+hTEN3R+CgU2wLNerLRg7XRN+e1Uf/qK8N76aRcoa5Swh1QzDQf55yttYY9gRs
	Jf/0JXj0c5LEikKnfYA+QQ9+xBEKcBp2N/9ae8CI7eb95W3BKBnGM6pJCOZ/2DFYy+a7vNb66S1Zj
	a3tu8ESg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVfot-0000000H18L-2BVO;
	Thu, 01 Feb 2024 22:46:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/13] jfs; Convert release_metapage to use a folio
Date: Thu,  1 Feb 2024 22:45:54 +0000
Message-ID: <20240201224605.4055895-6-willy@infradead.org>
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

Convert mp->page to a folio and remove 7 hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 6fa7023f5bc9..4515dc1ac40e 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -749,37 +749,35 @@ void put_metapage(struct metapage *mp)
 
 void release_metapage(struct metapage * mp)
 {
-	struct page *page = mp->page;
+	struct folio *folio = page_folio(mp->page);
 	jfs_info("release_metapage: mp = 0x%p, flag = 0x%lx", mp, mp->flag);
 
-	BUG_ON(!page);
-
-	lock_page(page);
+	folio_lock(folio);
 	unlock_metapage(mp);
 
 	assert(mp->count);
 	if (--mp->count || mp->nohomeok) {
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		return;
 	}
 
 	if (test_bit(META_dirty, &mp->flag)) {
-		set_page_dirty(page);
+		folio_mark_dirty(folio);
 		if (test_bit(META_sync, &mp->flag)) {
 			clear_bit(META_sync, &mp->flag);
-			if (metapage_write_one(page))
+			if (metapage_write_one(&folio->page))
 				jfs_error(mp->sb, "metapage_write_one() failed\n");
-			lock_page(page);
+			folio_lock(folio);
 		}
 	} else if (mp->lsn)	/* discard_metapage doesn't remove it */
 		remove_from_logsync(mp);
 
 	/* Try to keep metapages from using up too much memory */
-	drop_metapage(page, mp);
+	drop_metapage(&folio->page, mp);
 
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 }
 
 void __invalidate_metapages(struct inode *ip, s64 addr, int len)
-- 
2.43.0


