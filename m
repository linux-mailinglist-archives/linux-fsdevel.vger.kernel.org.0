Return-Path: <linux-fsdevel+bounces-17563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2688AFC4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 00:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD7528248E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 22:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE632E644;
	Tue, 23 Apr 2024 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VPD3YkPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B738DC0;
	Tue, 23 Apr 2024 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912967; cv=none; b=ggO69sfT2K8ik90Pnj1G9oQDHXerAwC/c39CBqi/2kyUv0/12vRuExT4+rSqWaLrYlORO4wqS9LDczjjIAW7Rd1t01TEpQZ2+jIZ7y+9PTiCd9SXsFj1OC71u+rvlLg+yHlUbodtmH/kVe1kGOvGXTiYzqeDJbFCiBkI28UOOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912967; c=relaxed/simple;
	bh=7byEvOBB2FsdAqIYH925KsVyTe1J2ZPjsZBYCN2u2mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLqFEc9XoaTMaUBIkoVNQr9FZ7yL5UhHJ79u9kQsFtzl+MHWm9O8ymEH/a1axIJWZvgUIG2TTAB+9t6PkPp1oflx6dusFYN3yyGdz9KGdGdiLtbhYciESg2njlyEKD9o90R13aiYN+XpFnpKdp/iw2pbWw6V/GTEeYMoZnelBuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VPD3YkPl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=KYDG6ZsjDj+2iBPQ3OajYlgseuthmwTxF2D+L3YSI+w=; b=VPD3YkPlOZgK3F00x6rBjyB/qa
	7iLvl71KcyySOFpXv6VNcIvJ4kLBFTS/SXC3ZzrjOZBGWVSosHva8VS0O89ku2EGoSb9qZG20yWz2
	gsbxrWVoRLITZhb+GHv47Fr7Tcbg/hDcEGYqKicULJLqtr7/WQI/SbIVuXP87EClD4lburQZ8Bn0E
	1sENDUkd5HyuQEQA7bd59fijov3p1eibLXaD65uZE4xl1bPmqZpVd8Bz2kpemDPimf7xp4wYx1Bts
	biZFYcGHus1s7W3aAtQd9JEgMLwAi1M2Q51JgD2jB+d0NH8QBSQz+8Dfe99630W60Xx6+tpx6+3jk
	Cq8mW83A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzP3K-0000000HG6G-1bIa;
	Tue, 23 Apr 2024 22:55:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 2/6] f2fs: Convert f2fs_clear_page_cache_dirty_tag to use a folio
Date: Tue, 23 Apr 2024 23:55:33 +0100
Message-ID: <20240423225552.4113447-3-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423225552.4113447-1-willy@infradead.org>
References: <20240423225552.4113447-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes uses of page_mapping() and page_index().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5d641fac02ba..9f74c867d790 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4100,11 +4100,12 @@ const struct address_space_operations f2fs_dblock_aops = {
 
 void f2fs_clear_page_cache_dirty_tag(struct page *page)
 {
-	struct address_space *mapping = page_mapping(page);
+	struct folio *folio = page_folio(page);
+	struct address_space *mapping = folio->mapping;
 	unsigned long flags;
 
 	xa_lock_irqsave(&mapping->i_pages, flags);
-	__xa_clear_mark(&mapping->i_pages, page_index(page),
+	__xa_clear_mark(&mapping->i_pages, folio->index,
 						PAGECACHE_TAG_DIRTY);
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 }
-- 
2.43.0


