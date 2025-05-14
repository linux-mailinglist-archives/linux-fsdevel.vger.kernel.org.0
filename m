Return-Path: <linux-fsdevel+bounces-48989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F13A5AB7250
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 19:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718C13A78A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408727FB2B;
	Wed, 14 May 2025 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wI2sBA2N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6393923CE;
	Wed, 14 May 2025 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242383; cv=none; b=ZUddKFHznBWep9maaVflSk8SP+aXhaDKnCYnxKrFtwIhhs3yGNTVt2M0dc9b8QQQYqfzDYX4JnEDiasJ1YeAGomL8HXa+TrPhBNoI16KI2NxPMcsM7XKma1tgoycYXskuulQlsT/305xAoaGk5bFxgVBgTrdfpQgDymlwRdqhnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242383; c=relaxed/simple;
	bh=9rGXuGkkZ0VTSRH8YJSX4fIYj54UBt7k132CAwzCmaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGnsuKbZAxUTYb8DS0DLPgDagdBJPokF7eSzieuiHUgz2IyzFe31jeW0hvhMHAzObsoLXNjMcaPa8qDakYUNwV2F4W0pawGNIZwg0AaFozW9SPMp0JHR9+P/FUYSoz0QgcfEjOJZHccRtaW0wlOSGYyi67NKCbx0z7eVQJUrxgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wI2sBA2N; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=nvxMHwbFtN/5IZodo/SUuQDUvlO+06KEH0aMqbrLT/0=; b=wI2sBA2N5LdezR9W5D/YNOFXxb
	bNJsqPMabq5+cJB1jzKYUfCbDF6qoGstba6uXPNINUojJ/562Ct+QQh3jw/5D2+QzYvpQRLHjiCAg
	Cw8QbKq8Z1uX6Xko/1uWAentLryFL2Ygb7dpdee9rsL9rRrBA695wf3g/FN1Bi4OOdCx392gSVqtp
	xP0nieYaSWthtW1LNyJe/Q7D5MRZW4XcPw6Y8dXLjr/KbLxWtRG4SX7Uu7J3OYCzkiZ8adq6oHi3k
	++hHnfm4xiQAhvadmO0PgvGG9HPZvRmZ/eSFxF1mEreyzGw94eD0+FYcD+VtmDPYwuLQHZHt+oy2K
	AXlvo04g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFFYW-0000000CahR-2bDZ;
	Wed, 14 May 2025 17:06:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Hugh Dickins <hughd@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] highmem: Add folio_test_partial_kmap()
Date: Wed, 14 May 2025 18:06:02 +0100
Message-ID: <20250514170607.3000994-2-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514170607.3000994-1-willy@infradead.org>
References: <20250514170607.3000994-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit c749d9b7ebbc (iov_iter: fix copy_page_from_iter_atomic() if
KMAP_LOCAL_FORCE_MAP), Hugh correctly noted that if KMAP_LOCAL_FORCE_MAP
is enabled, we must limit ourselves to PAGE_SIZE bytes per call
to kmap_local().  The same problem exists in memcpy_from_folio(),
memcpy_to_folio(), folio_zero_tail(), folio_fill_tail() and
memcpy_from_file_folio(), so add folio_test_partial_kmap() to do this
more succinctly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: 00cdf76012ab (mm: add memcpy_from_file_folio())
Cc: stable@vger.kernel.org
---
 include/linux/highmem.h    | 10 +++++-----
 include/linux/page-flags.h |  7 +++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 5c6bea81a90e..c698f8415675 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -461,7 +461,7 @@ static inline void memcpy_from_folio(char *to, struct folio *folio,
 		const char *from = kmap_local_folio(folio, offset);
 		size_t chunk = len;
 
-		if (folio_test_highmem(folio) &&
+		if (folio_test_partial_kmap(folio) &&
 		    chunk > PAGE_SIZE - offset_in_page(offset))
 			chunk = PAGE_SIZE - offset_in_page(offset);
 		memcpy(to, from, chunk);
@@ -489,7 +489,7 @@ static inline void memcpy_to_folio(struct folio *folio, size_t offset,
 		char *to = kmap_local_folio(folio, offset);
 		size_t chunk = len;
 
-		if (folio_test_highmem(folio) &&
+		if (folio_test_partial_kmap(folio) &&
 		    chunk > PAGE_SIZE - offset_in_page(offset))
 			chunk = PAGE_SIZE - offset_in_page(offset);
 		memcpy(to, from, chunk);
@@ -522,7 +522,7 @@ static inline __must_check void *folio_zero_tail(struct folio *folio,
 {
 	size_t len = folio_size(folio) - offset;
 
-	if (folio_test_highmem(folio)) {
+	if (folio_test_partial_kmap(folio)) {
 		size_t max = PAGE_SIZE - offset_in_page(offset);
 
 		while (len > max) {
@@ -560,7 +560,7 @@ static inline void folio_fill_tail(struct folio *folio, size_t offset,
 
 	VM_BUG_ON(offset + len > folio_size(folio));
 
-	if (folio_test_highmem(folio)) {
+	if (folio_test_partial_kmap(folio)) {
 		size_t max = PAGE_SIZE - offset_in_page(offset);
 
 		while (len > max) {
@@ -597,7 +597,7 @@ static inline size_t memcpy_from_file_folio(char *to, struct folio *folio,
 	size_t offset = offset_in_folio(folio, pos);
 	char *from = kmap_local_folio(folio, offset);
 
-	if (folio_test_highmem(folio)) {
+	if (folio_test_partial_kmap(folio)) {
 		offset = offset_in_page(offset);
 		len = min_t(size_t, len, PAGE_SIZE - offset);
 	} else
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index e6a21b62dcce..3b814ce08331 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -615,6 +615,13 @@ FOLIO_FLAG(dropbehind, FOLIO_HEAD_PAGE)
 PAGEFLAG_FALSE(HighMem, highmem)
 #endif
 
+/* Does kmap_local_folio() only allow access to one page of the folio? */
+#ifdef CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
+#define folio_test_partial_kmap(f)	true
+#else
+#define folio_test_partial_kmap(f)	folio_test_highmem(f)
+#endif
+
 #ifdef CONFIG_SWAP
 static __always_inline bool folio_test_swapcache(const struct folio *folio)
 {
-- 
2.47.2


