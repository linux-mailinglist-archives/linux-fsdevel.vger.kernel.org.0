Return-Path: <linux-fsdevel+bounces-9931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEAA8463B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA3B1C26033
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8171747796;
	Thu,  1 Feb 2024 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vS/jQ5T+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434545C14
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827572; cv=none; b=iNHhjrmJEa3UV7QCB/RE0gsPkrGV1K4cxS46Kk4RXV+xVGa6noISlZ7dgDA9hY9HANahG3uRriMJ3oJgTYQkLQmgs/zgTGjtTRgQeLLJpBMkfnE8Uy2HgkbdCrCn8stfwykGZTynBsWq3WaUgpGrp/ICie9nO22ZksuY2N4OQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827572; c=relaxed/simple;
	bh=OVPeEFLCpx6xGvib1I1i/DO171ij4Lze5tqqB1wGrjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zw4a72/sLCP72HU6CtwJGzP1QLSPI6qh/mBBFyI5Nk2UuXPB1cJY9ZVvc3ynHKVUS9nNQzQOWGeWQDu2HmrWniImwcMeOqz6ksgTJPIQgTT0VkJcvGEVf1EdtC/P6MdEFbfVTjWIeqtU3Mx4ta7UAPF+oXiJyliIJ13bbTxxSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vS/jQ5T+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=W4VqD8jq2dSVicm/surzXwnOz2JGwjwbYjUpLghwCiE=; b=vS/jQ5T+YNnpZm+KPgzE7k0M4g
	8A2BoR3mAssqfH3JJ9AmKaIB2RCq1D7A3KNc18V1MVoiJXElM1VNAoKXC3MdHnj9MdovbPfo8D8Lf
	9PjiLFWeW9qD/1cbovDMK2U/qvB7lD35tLajc7MM77eZ9jejcrrpw8PnqPzZjI6AGngDKiPLTps9e
	D45+VcLZjWJ+OlML3z3RcAwJ4mY03UnEytHfpE8kX4vT7/L9lsgLSN44OFKBxpXe/vHUkX6PL6m/p
	2iVFOJpiF+mb35oPYOkWASi+5ARulQ4VWFgy68DahpCJZY9+EcP/sKc38vszWgVGzDT8kck8xU78k
	R7f5UwcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVfou-0000000H19F-20f0;
	Thu, 01 Feb 2024 22:46:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/13] fs: Remove i_blocks_per_page
Date: Thu,  1 Feb 2024 22:46:02 +0000
Message-ID: <20240201224605.4055895-14-willy@infradead.org>
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

The last caller has been converted to i_blocks_per_folio() so we
can remove this wrapper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 431b12a23299..66fb5924dc53 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1556,10 +1556,4 @@ unsigned int i_blocks_per_folio(struct inode *inode, struct folio *folio)
 {
 	return folio_size(folio) >> inode->i_blkbits;
 }
-
-static inline
-unsigned int i_blocks_per_page(struct inode *inode, struct page *page)
-{
-	return i_blocks_per_folio(inode, page_folio(page));
-}
 #endif /* _LINUX_PAGEMAP_H */
-- 
2.43.0


