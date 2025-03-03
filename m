Return-Path: <linux-fsdevel+bounces-42997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82125A4CA9D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 19:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5EF81886FC9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A85F21B9DB;
	Mon,  3 Mar 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EC642/Q+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8BD1F2B88
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024882; cv=none; b=bdxAQkLu58P8jvx35bRWL/9YDCtJBgQksg5BmjmRHNPICRFYF5Ei8w+2cznOtrsfgf7xL4y/U9T2FFs4T4aPk969Tbrn77nV/wK3p0qfi4I768622m0r9JmstN8+jvFUrnJaBu9IFR2HsQ/WH8BEl5DXNjl57bnBeW/1O3xP6sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024882; c=relaxed/simple;
	bh=lA8N5oit7EGNRH5aGIVw8AazWSQAhu3XE0YioIePRIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W20mj7a02JEijUNUijRVE9flJI2XwK+Yb9gZUBfLfFdX503/tesk4N7yV84yppbbQgTvjl96IyBTLxIUlYDktiONwZd94TDGJmGbzFsY8/om3fhyBxPZeAHczmGgcUWItxdwkq8oHKthHdChS6uGZmvSVXkcX8ZYDf5RrJas9+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EC642/Q+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=NPQLhzTyEMzPLgCXVEdgocc34iqkc/85plAdXTJVcFA=; b=EC642/Q+e1n8Jte66sDcf2YMpk
	ik8RpSlGYjW30isIt1q9YXZgZK4A707jQZLUxBboa0n6M4VbZAlqa7ir9f6p1Z0O2GKux1uqtGS6V
	tkjojKOWm/hOmI5B6UdsrLdeLLX03J9W74sQCd+WxdJHXGNI7QOvmhFWLaUdfU59UXMkj7LY8ebHG
	OtsfLp79FfZN2RkOR/dkh7+JZAoDqzwXcePI8uNmnv1HaYcZ0yy4Cord9IV4yq2NK5P9iob8CVa7X
	DTgQ+BEVXZ55F7RWsiT/Le4rccCBbS7zoVCoPyKrSafs9RCuxYxDpSUmxcWTpFfofe9wpO7DEq/Zl
	9fkBYBkg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpA6G-0000000Dqcg-2VVL;
	Mon, 03 Mar 2025 18:01:10 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/6] pagemap: Remove readahead_page_batch()
Date: Mon,  3 Mar 2025 17:53:15 +0000
Message-ID: <20250303175317.3277891-6-willy@infradead.org>
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

This function has no more callers; delete it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f4b875b561e5..4a1c9dc92d82 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1472,20 +1472,6 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 	return i;
 }
 
-/**
- * readahead_page_batch - Get a batch of pages to read.
- * @rac: The current readahead request.
- * @array: An array of pointers to struct page.
- *
- * Context: The pages are locked and have an elevated refcount.  The caller
- * should decreases the refcount once the page has been submitted for I/O
- * and unlock the page once all I/O to that page has completed.
- * Return: The number of pages placed in the array.  0 indicates the request
- * is complete.
- */
-#define readahead_page_batch(rac, array)				\
-	__readahead_batch(rac, array, ARRAY_SIZE(array))
-
 /**
  * readahead_pos - The byte offset into the file of this readahead request.
  * @rac: The readahead request.
-- 
2.47.2


