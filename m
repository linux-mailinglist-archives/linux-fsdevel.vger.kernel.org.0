Return-Path: <linux-fsdevel+bounces-17434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09E98AD4EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA0A1C20E72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8685F155739;
	Mon, 22 Apr 2024 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OQxY1Vp8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545B1553AD;
	Mon, 22 Apr 2024 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814333; cv=none; b=l+e5RyC3wx1kvE0HlHVTMzoWA8kRYCV0em2Aj2a+TGT8qxtXNN1OV+Mru6u5d8y3mtNqlPlxo6XTk0XeDfKeYLXVbXs5lBFxLkRBuZUAO4KoDnsPBLZpSGvOO5bmkPd0vk1k80USMn1uxfglkdtS+1gyKJVJE2PPEof+LH8kmZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814333; c=relaxed/simple;
	bh=SxSqw986WsWe51m5M0F8bbrXytz2xGOXLoYtvYrpa0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIUljn6bwZLqfAmqyOBMMB9w+RSF3ZbEUtoccFGSKvtGRB/HY/pKydvtlUJN6T0Oa8SjgjMpng/xQVt17ZWAn4ubY+wwxqVgQ6KfpPgVWmXr91n1963kKtybFCn0MSL5WpurgbGUxG3/w/XmMb59tkbjRgSL2tg1VcKTFfsQDfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OQxY1Vp8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=O5qCe9GV5hWp+SXsPtO2/rvY95DODsm8hr+fAkNqOEY=; b=OQxY1Vp8TmUivUTNk/hqZIlIto
	QkWu8Ij71nTrCv6M1bQ2gBajTHVUI+g+wwslbbPtMWJcWxMf0G+wz1Hgut+5pBFp1dyCwo7CBpdLh
	dPcq61GGgxoXPPCk1E2AaDNNQ/51HKx/cqK2d/BDrNJyIpsUEuproRAQZXgfOCLQ0ai0RevNFx94I
	03WlPYRTSRliy9FY9q1HWIlZD6kJ+7J12jNyLOJq5zHoXu8m9afN0xUeoSvy7ldg6PyjeEuccL+CH
	1j02yAFwcnfLiiJu9f/LwsQmMCB/yAMqCT27kNZKt2Ik6cfzsx3VvxCnt2NqwI3CtZPknAjkDLbxf
	geIoV53g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryzOZ-0000000EpO6-01eQ;
	Mon, 22 Apr 2024 19:32:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 01/11] ntfs3: Convert ntfs_read_folio to use a folio
Date: Mon, 22 Apr 2024 20:31:51 +0100
Message-ID: <20240422193203.3534108-2-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422193203.3534108-1-willy@infradead.org>
References: <20240422193203.3534108-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the struct page conversion, and use a folio throughout.  We still
convert back to a struct page for calling some internal functions,
but those will change soon.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 30e69177f224..bdaea9c783ad 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -710,25 +710,24 @@ static sector_t ntfs_bmap(struct address_space *mapping, sector_t block)
 
 static int ntfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
 	int err;
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
 
 	if (is_resident(ni)) {
 		ni_lock(ni);
-		err = attr_data_read_resident(ni, page);
+		err = attr_data_read_resident(ni, &folio->page);
 		ni_unlock(ni);
 		if (err != E_NTFS_NONRESIDENT) {
-			unlock_page(page);
+			folio_unlock(folio);
 			return err;
 		}
 	}
 
 	if (is_compressed(ni)) {
 		ni_lock(ni);
-		err = ni_readpage_cmpr(ni, page);
+		err = ni_readpage_cmpr(ni, &folio->page);
 		ni_unlock(ni);
 		return err;
 	}
-- 
2.43.0


