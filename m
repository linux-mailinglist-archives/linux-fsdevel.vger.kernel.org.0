Return-Path: <linux-fsdevel+bounces-43432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C123A56992
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EDC1892EB7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217E221ADC1;
	Fri,  7 Mar 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nnGr+Xt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1121A92F
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355660; cv=none; b=Rx5rjEANWDhKUGCGOdahf/ue85bclO0eNaaeC6yYp8IsnskpVV+RJ+8a5lHoRJJ788ogF6cL2rayrjzlkbDx0a+P1D9sCNJXIZf32dkOFAuia7SJAE5WxL7xKc2ojP14dXMUAatBrel3xFhPLcy2/9kSDDxn92fQjufntjtAVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355660; c=relaxed/simple;
	bh=CEGXIWn/1l5S0j/7hNwbS5YhciyTTzqptoAUkwUhhRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRDejYWwl42hDFzapZV3UKVRGWuQUjyG1JVseihmKWj7b41Edk5KAESbv3rxgoeXPxciZ4hFnlbvNe9RHa+CSlIMLMhZWqeGMvcfvYpPtAThBGo1fgUUWZo93M5t8aZi9UqzOwwaekcJ98r7exCeplgm37pFSvqFiI5b+WVN6TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nnGr+Xt3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=T8fXRyaYOssoLEG59sUpr97PSMqTmPmVh2Clh/QPZVU=; b=nnGr+Xt3+97jZBGQECj87NaDqI
	XK8uVQj8thhehM0zZlfDnmvlOXcBQ7SO/K8NTEb3FRquZXAarnz7wDTJEkwev+safNXqNwMRfnaif
	+pAsjoSitQfyymKZLmoU50i4NHcwZ0cC5EuNc9jfgqDK6BdkWuzJg40ZAJJ3uBIMmknep94icuZG/
	C6WPgd5F3oI4SCW3MO4/ii3C5CxeWkeuBT+bEHgvTn8os3y6u2ttvT+5+8RkNI7GuVwyyXf3aIW0y
	qaE5ugvrhoXw5fNciwFpeMMJFukQfyGGRVImUAaBUB6ZgY8zt4atiw2YWormv0v03A69cDNPIGN6s
	cML+42aA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqY9X-0000000CXG1-3uYy;
	Fri, 07 Mar 2025 13:54:15 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 03/11] f2fs: Remove f2fs_write_meta_page()
Date: Fri,  7 Mar 2025 13:54:03 +0000
Message-ID: <20250307135414.2987755-4-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307135414.2987755-1-willy@infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mappings which implement writepages should not implement writepage
as it can only harm writeback patterns.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/checkpoint.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a35595f8d3f5..412282f50cbb 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -381,12 +381,6 @@ static int __f2fs_write_meta_page(struct page *page,
 	return AOP_WRITEPAGE_ACTIVATE;
 }
 
-static int f2fs_write_meta_page(struct page *page,
-				struct writeback_control *wbc)
-{
-	return __f2fs_write_meta_page(page, wbc, FS_META_IO);
-}
-
 static int f2fs_write_meta_pages(struct address_space *mapping,
 				struct writeback_control *wbc)
 {
@@ -507,7 +501,6 @@ static bool f2fs_dirty_meta_folio(struct address_space *mapping,
 }
 
 const struct address_space_operations f2fs_meta_aops = {
-	.writepage	= f2fs_write_meta_page,
 	.writepages	= f2fs_write_meta_pages,
 	.dirty_folio	= f2fs_dirty_meta_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
-- 
2.47.2


