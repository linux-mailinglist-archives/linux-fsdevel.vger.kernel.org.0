Return-Path: <linux-fsdevel+bounces-38886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B433CA0978B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 17:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EC51889F52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FBA212D83;
	Fri, 10 Jan 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dt+oyK2P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7B212B2D
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526788; cv=none; b=sczNEsZnwrW51n+hJyG9OtcyDJsUiZtuq6QAEbrJdLGlTLCNdRIk3f3NHMmsA9ao/4GYp0JmgR8LgzGI6L5W6Qg1sAkIKXW0EujnmyFIZZd+SqtrJi1nBUf6d8g06bKBhz0S+JodqWT7+iNI2f5uB9KJ0BXpDjErVWUJ9NaBP0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526788; c=relaxed/simple;
	bh=FS96Xtr0TvvSmGEoIVtbkxgnDeIXPINwUTajJDG3rCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ri8N8lZwGAa62mpcOaSQUXtzgBQxEkkq2nJt6OaC1ynZ+CXWTuo5mJsGyxWIyDBsy4hd/UVI4EiAxKgpXzSnRWOaTWnHD0LQ4lkzKzFRCJExhW4X0grj9zpoxgDLc4ljca7fbUgsSOTaqqh6hsDDWTPabSDOZ5GKd7p9peoFDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dt+oyK2P; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=DH+Cxm6d8lwPux5CX2sjl6rLlWpVJbxOakxzkL9rSrg=; b=dt+oyK2PWWQthDsLKdUanaCqQT
	FkxaXu0YSv9JpiQOp0CqsWnEnioXQ+64fQFRy3cazHsCtp3KMELYscWqW8wod/sMW59uywJ+ll6c0
	NrI1om93APA6SPI1dKXdYd7DGBaDFuu3hir5feSHExbcfT2goxTzOI7grJiBD/nXnEEctKbdKYbxk
	gwcP3vC70+xHVEr27sqGy7W+bRbVYbTnTPNFELg+WyWhlFm55J7CiXNLD6Xkz+J17F4ubi8mn7tly
	ZME5dArbOpMMz68tCCtCwa4ay1Je/itsX2TA6t0gr6XBZyNz4gBvRH5Zsk9w179qG9XqPc8W6yClg
	0677aJ5g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHwU-0000000E2XI-1H75;
	Fri, 10 Jan 2025 16:33:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	squashfs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH 2/2] squashfs: Fix "convert squashfs_fill_page() to take a folio"
Date: Fri, 10 Jan 2025 16:32:58 +0000
Message-ID: <20250110163300.3346321-2-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110163300.3346321-1-willy@infradead.org>
References: <20250110163300.3346321-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I got the polarity of "uptodate" wrong.  Rename it.  Thanks to
Ryan for testing; please fold into above named patch, and he'd like
you to add

Tested-by: Ryan Roberts <ryan.roberts@arm.com>

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/squashfs/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index da25d6fa45ce..018f0053a4f5 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -400,7 +400,7 @@ void squashfs_copy_cache(struct folio *folio,
 			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
 		struct folio *push_folio;
 		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
-		bool uptodate = true;
+		bool updated = false;
 
 		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
 
@@ -415,9 +415,9 @@ void squashfs_copy_cache(struct folio *folio,
 		if (folio_test_uptodate(push_folio))
 			goto skip_folio;
 
-		uptodate = squashfs_fill_page(push_folio, buffer, offset, avail);
+		updated = squashfs_fill_page(push_folio, buffer, offset, avail);
 skip_folio:
-		folio_end_read(push_folio, uptodate);
+		folio_end_read(push_folio, updated);
 		if (i != folio->index)
 			folio_put(push_folio);
 	}
-- 
2.45.2


