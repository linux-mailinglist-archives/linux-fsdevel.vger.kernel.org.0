Return-Path: <linux-fsdevel+bounces-41946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BE4A39333
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26C716E7D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489F41C5D6E;
	Tue, 18 Feb 2025 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WctRG+C4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730561B21AC
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857930; cv=none; b=Dl1h5EIheb3HO2+8T1wQtPx+zAujDuZ0OhC5trCIfJqvPichXSRN729OMu2cu0cqf9hnSxRBt8aQLwS9i7uS6HwrfDPC7azm4XDMQxbpdGSHyIn92jzfzOIcGQhN5sRP2ZfTV7izWnL0F+2diiUc5BzfTLAZcO+WWm6jkHTDZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857930; c=relaxed/simple;
	bh=7gjeFdrpF9DXJEHkm7PmZFbKBM9P+b0kCi+vJVipZJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMhh4D1bROP4r3+mXZ1u2nmywOiEa4csjXICjt7xfiZSd9VKPBlVzFj9UEDMT/KNrXMVCGRwXixM3L7R+h3MXDGsiNXiEH2KZTs4JevGMsxmrMTawqLto5hIjs6KXDLm3lKktTq1tu31Q0TwTEjT1AJCdm/5b/OQTzrp6kp3XiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WctRG+C4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+Syw2hpXqanXPir38dFqOWLHHdVuEk3K5wwtxHpZ/n4=; b=WctRG+C4lsUZm+Zrddr4t3s0gi
	of/RkQflhhZ8vazQsxlQW3tw+X2p1IBuoiljtcJXf2c1FwKu4ew7MY8aMX/0UZbzwRgDvj3WARn01
	q+PLjAelPSitbzHTrPcY5Xp6emsgV3zXBeK0vMv953eb+0hD3ZzoRrZ2jZf2eMpVf0CeOCwFn1FML
	i+y2dtv8lCfKsXGJGEDQ5+8fmk3GwlKObGXrVxrohJCP2mZKmgO7wFtom0ascQwPjDsYyLc+QlULT
	CaGvwklCWYz78eFU2d6cbojv5tpKcZomUGxwNjIildopRHoHfuUQwYLGMZSgUKOxrb6VU7Ze8gFcg
	1aHC1yxA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWc-00000002Ts5-3AXx;
	Tue, 18 Feb 2025 05:52:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/27] mm: Remove grab_cache_page_write_begin()
Date: Tue, 18 Feb 2025 05:51:45 +0000
Message-ID: <20250218055203.591403-12-willy@infradead.org>
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

All callers have now been converted to use folios, so remove this
compatibility wrapper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 3 ---
 mm/folio-compat.c       | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a19d8e334194..45817e2106ee 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -990,9 +990,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, xa_mark_t tag, struct folio_batch *fbatch);
 
-struct page *grab_cache_page_write_begin(struct address_space *mapping,
-			pgoff_t index);
-
 /*
  * Returns locked page at given index in given cache, creating it if needed.
  */
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 5766d135af1e..45540942d148 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -84,11 +84,3 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 	return folio_file_page(folio, index);
 }
 EXPORT_SYMBOL(pagecache_get_page);
-
-struct page *grab_cache_page_write_begin(struct address_space *mapping,
-					pgoff_t index)
-{
-	return pagecache_get_page(mapping, index, FGP_WRITEBEGIN,
-			mapping_gfp_mask(mapping));
-}
-EXPORT_SYMBOL(grab_cache_page_write_begin);
-- 
2.47.2


