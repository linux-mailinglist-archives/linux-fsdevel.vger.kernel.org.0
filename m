Return-Path: <linux-fsdevel+bounces-17063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9768A7257
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 19:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F2A28234F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 17:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E901134404;
	Tue, 16 Apr 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="atsqtowk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB22133982;
	Tue, 16 Apr 2024 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288563; cv=none; b=T8fP7SCOohTHjBhZqyAQFHdjwbFVj9hsnpTFkn10tRJofU4WbWPmNFLj0V1DHznPOl1G8xHqglmne82cj1lqlohc0W/+MzlgAB2GgvTXaxBod13Th0vYkXXCURYR+2vho1pRYjb24+Yfw7J+EJ3Q7j7WO6zgrd43zZ9g3aUdOCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288563; c=relaxed/simple;
	bh=H3sAZrVcRVwXbTF6OQcW3kqHsui4B9DnClG+Qr7StmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBssLs0MAwfibRaCCTFoCIB4UjpHBpqABXnGt5qDaDgoKo05WY40Po2UzCCll7l3WENhzJ1wl+1D47JtKp4fBdbJvBk3OspxTzHVICgsTFxfqFgUH8Kc2o92Xyn37Vn31441g9Dnvp8TIokx86z2EduYkGmD5slfEqapTMzv/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=atsqtowk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=DWfSGd1fMqhaOSHtrzDMm5FJGpBXBmh/XpmokkXqtXw=; b=atsqtowkjGF9n4acXJ+0DKDx/q
	wUbOrSrmG1Dm8P9iGX60tesj+b1HUfqivVQoLXA9nrjVJaqlDyoqq8NxhqTIOVBpYRSgwC2IVfKd6
	5vqihDmtnbiq7WGqs5j4ic3wbyiSQsGGJmQy201aQhkfrFu5KMzthjkYrPzUPS/JyRYWWkhrRGJ3P
	PYCUR9XOl1lm+73+yF4zl3pcIO2zy1Co6OrlHhddAITADjwHM2QxFy0uzfYG+JU7bftGV4gWfLtFL
	j4WHtimAPC2B7e12Fh+tboWLQ59spUM0QaqXzeinHIVYfDNU47MN4Stwl0+dtyjKSPKu5Y6vXL/NF
	u/2X+SMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwmcF-000000011eX-099L;
	Tue, 16 Apr 2024 17:29:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] ext4: Convert ac_bitmap_page to ac_bitmap_folio
Date: Tue, 16 Apr 2024 18:28:57 +0100
Message-ID: <20240416172900.244637-5-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416172900.244637-1-willy@infradead.org>
References: <20240416172900.244637-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This just carries around the bd_bitmap_folio so should also be a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/mballoc.c | 8 ++++----
 fs/ext4/mballoc.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 50bdf3646d45..b2ea016f259d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2153,8 +2153,8 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	 * double allocate blocks. The reference is dropped
 	 * in ext4_mb_release_context
 	 */
-	ac->ac_bitmap_page = &e4b->bd_bitmap_folio->page;
-	get_page(ac->ac_bitmap_page);
+	ac->ac_bitmap_folio = e4b->bd_bitmap_folio;
+	folio_get(ac->ac_bitmap_folio);
 	ac->ac_buddy_page = &e4b->bd_buddy_folio->page;
 	get_page(ac->ac_buddy_page);
 	/* store last allocated for subsequent stream allocation */
@@ -5993,8 +5993,8 @@ static void ext4_mb_release_context(struct ext4_allocation_context *ac)
 
 		ext4_mb_put_pa(ac, ac->ac_sb, pa);
 	}
-	if (ac->ac_bitmap_page)
-		put_page(ac->ac_bitmap_page);
+	if (ac->ac_bitmap_folio)
+		folio_put(ac->ac_bitmap_folio);
 	if (ac->ac_buddy_page)
 		put_page(ac->ac_buddy_page);
 	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC)
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 720fb277abd2..ec1348fe1c04 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -204,7 +204,7 @@ struct ext4_allocation_context {
 	__u8 ac_2order;		/* if request is to allocate 2^N blocks and
 				 * N > 0, the field stores N, otherwise 0 */
 	__u8 ac_op;		/* operation, for history only */
-	struct page *ac_bitmap_page;
+	struct folio *ac_bitmap_folio;
 	struct page *ac_buddy_page;
 	struct ext4_prealloc_space *ac_pa;
 	struct ext4_locality_group *ac_lg;
-- 
2.43.0


