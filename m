Return-Path: <linux-fsdevel+bounces-42995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2284CA4CA9B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 19:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEAB1886DCE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0368219A90;
	Mon,  3 Mar 2025 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YgwKMYWd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0C72153C4
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024870; cv=none; b=sjsroW4rMIhCAJ/vqqZRX8ku0GlEB6ZxC9Dv4mwrWr80mMWeejmxsvX1NDbSV+tRtMaN8BajyOVDk082PV44aM44rqlYL1ou1ns+N/+tNla/Izu1zbvbxfGSQifEx0XWCrBpwWtCl9tAPcXikkxwKMzbNtB4GnPSd25xsTsIbl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024870; c=relaxed/simple;
	bh=N+f7VhgLvEt1EOwjm0WQnntkrOyK2xWskl47TmAl+wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMXj00Om4bFKz4nsx5+Uju8opRCEjFLSx0oljjAYnEOPIJcjeEyDj9K4FpiMzBqH/Cp9c7Ae85tFJ6kFJ6XwjnjJuAPMhqU4UwOFCb4PMOFlaJRQVenXqAcOIZU/3EtkS8M6XO5Rl8XF9JCtVx08/Vw3QKBHElTIEPYGY1+tpd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YgwKMYWd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4Fso8EI/ac8noZP5COjS8e1jpZSdYEWCWF69/ISSz5w=; b=YgwKMYWdVA6BXZ0zMwzEmFFQ5L
	bWYLvSkcg6+F0gfp9f94CTLp7+znhPYmWCXrVR6anLxEJisRZtad8sbHkKBeu9vJHmI+B84lZJbg6
	og15e7PyL7AmgxL7jdV1fz9jWBcGSkDxUciKsrI5dBC79Eyc0zWAjzm9mnbFMzBB0TgiDER6FPniM
	tVtq73LP01vEW9VTQlMtABHCk5XhezymXUaz1msmzOabtvZhA0lZ41jr05dbHOADtO/WfyMvXnrdF
	R8e/o0005bXw1XQ/UHrygEgM+g3bl79+PJXR8NKAd1K6PkATw1RDEDdp1+5sQVHQbl9iEm7PJKzqA
	EjECnNtA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpA4G-0000000Dp9Y-1iRM;
	Mon, 03 Mar 2025 17:59:26 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/6] pagemap: Remove find_subpage()
Date: Mon,  3 Mar 2025 17:53:13 +0000
Message-ID: <20250303175317.3277891-4-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303175317.3277891-1-willy@infradead.org>
References: <20250303175317.3277891-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All users of this function now call folio_file_page() instead.
Delete it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 798e2e39c6e2..e51c0febd036 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -945,19 +945,6 @@ static inline bool folio_contains(struct folio *folio, pgoff_t index)
 	return index - folio_index(folio) < folio_nr_pages(folio);
 }
 
-/*
- * Given the page we found in the page cache, return the page corresponding
- * to this index in the file
- */
-static inline struct page *find_subpage(struct page *head, pgoff_t index)
-{
-	/* HugeTLBfs wants the head page regardless */
-	if (PageHuge(head))
-		return head;
-
-	return head + (index & (thp_nr_pages(head) - 1));
-}
-
 unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch);
 unsigned filemap_get_folios_contig(struct address_space *mapping,
-- 
2.47.2


