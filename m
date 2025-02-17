Return-Path: <linux-fsdevel+bounces-41890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C462A38C3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 20:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF863B150D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B5B237162;
	Mon, 17 Feb 2025 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kCCxbnbo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F723537B
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820014; cv=none; b=MbJXKrl65Ly5Gz6Ajx9SE7kYEf+gtvy0fhoG8hsmgUPhQxNpnSxj8kKkivTfUkvnOPHoHK0tqtzO6ttQ80UsEJ9q1XSWtm9CP/pJBfj+NYWqMreYmn0o4K7qjnT1eKhP/zJBy3WFa3zEMYC/pDDMSF7ffyr5m5jlXzddegQ47xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820014; c=relaxed/simple;
	bh=GteIYcq/HHG7jREu0VRvdKhtZGG9kNxJH3ms/IPmvvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzi9dZ+K3nFfu/bXunatvx6AN+xaZNytNLS5UYD7YXwr9752iU66StNUuSwzTAUgCbl7CCE37BM4dseGHmCWCZWbEBuOW1vd/1WzNTt3N/qznW1Ez3pj4bzcHBIj8kWZdie7p22L7comeuSXGJFBcKjtRUAbbV0cJfDPFiWKOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kCCxbnbo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=HMl82HmKutSPx3lxyiWh5KoO2mHO29+UbXsPUZ6OrWI=; b=kCCxbnbowrCoqBW9n7zeTDAGkl
	MkugdkfNC8lYRUzKe3ZPVRT7v7z2taIwLqc9k0dypf4Bs51JDXEq9y3qcr/7YHct7vym+JhllT+0H
	N2ELoeHHCptsrP8LxqMtGgXDKHfzT5s30IRpG8FX7QIRMwa9IHedmjjLpl+Cc8b7s/lIiu2LXjv9n
	dPybuw9cbtvs95pmK+ZMFrBFCiI4TSGWZJCGlcd0I1ajMT94CsnbsAC+3+gMX26nGyb2Upe8XNs/Z
	S/ob/QjAELhmNqgEhakysbganXiauVWXN4Wa1XluE+fnPp1LxVqkkHWm9tjIJj1istS36eBLR1u06
	9Do3Wuxw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6f5-00000001pvS-2S1p;
	Mon, 17 Feb 2025 19:20:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] fs: Remove page_file_mapping()
Date: Mon, 17 Feb 2025 19:20:07 +0000
Message-ID: <20250217192009.437916-2-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217192009.437916-1-willy@infradead.org>
References: <20250217192009.437916-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This wrapper has no more callers.  Delete it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 47bfc6b1b632..975c56fb4f85 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -575,11 +575,6 @@ static inline struct address_space *folio_flush_mapping(struct folio *folio)
 	return folio_mapping(folio);
 }
 
-static inline struct address_space *page_file_mapping(struct page *page)
-{
-	return folio_file_mapping(page_folio(page));
-}
-
 /**
  * folio_inode - Get the host inode for this folio.
  * @folio: The folio.
-- 
2.47.2


