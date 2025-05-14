Return-Path: <linux-fsdevel+bounces-48987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A17AB724D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 19:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743D61B683F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198BC2749E3;
	Wed, 14 May 2025 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ktTN6aWL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9347927F747;
	Wed, 14 May 2025 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242378; cv=none; b=gnVXynErqIIzaufqT/1KUYAboqZw5rP7rd+UKHPxuWwyLtGYlTyrlQKPlvE+8JCG8pKdKr5aRAGlg4n5+2NEyrlnsyRavdfne0EFpd6OyZa95qMUooCnAjS+MEV0oMqCSIRgVAYzSFkSAGz7vbI/5NcZFUXvbq5r0HP6tGFJeVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242378; c=relaxed/simple;
	bh=XqL7Pdzl6R44ZlUwl4s7z/y+eiTe3nHaItxkjQ+dQrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9jo+IRVGyk32nXY6IWQq/UIxGhkdJ7PO7ljqowVRpFrOTB8Q2gy1u4NgcQBmEIdMtCCmdqGrfS7CqTmnHjMa5pbe2QsRXFAMsTlay/WmGKbIUwQtQV6NF1qyBCCV7SLsrZPMfxnw7CTs+xciKwnhfT31nCLKlcuqYNx7+yFda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ktTN6aWL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QIP/rHjINrJ5Ni5+lZKt00BgN3DmtdYKNBZJi9LlujY=; b=ktTN6aWLboPg8RRtuHowj055yI
	5BNKpu9DCOyR8lO09SYykWdCBjOVaqrswNmwV7cOEWdE3WYs0NKxZIM8+uJjUQGpjJxsv1iSQmy+N
	hszPebTIiTLmgBnCEKky4kdGru6r0oJpRWzTqxvuidvX7mwsLNAVGlfhHl1XD2vtYQqB7uH2EzRNP
	xfCjh+zUZSq6KulNQIz6r/YhLYMoTXsMqfQFy2+oKTsPtZ7xt50anXkQKNAMeGZ0/+DSIKUFi7Z/K
	wpWce5OnORGq9dv3WpB/fYZXnHLSyzX0YNAYCjEKC/rZNXag7JhVB47Yqe/rgtRj5xEkd+htoTlw5
	2TWtn39Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFFYW-0000000CahV-3QRd;
	Wed, 14 May 2025 17:06:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH 3/3] iov: Remove copy_page_from_iter_atomic()
Date: Wed, 14 May 2025 18:06:04 +0100
Message-ID: <20250514170607.3000994-4-willy@infradead.org>
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

All callers now use copy_folio_from_iter_atomic(), so convert
copy_page_from_iter_atomic().  While I'm in there, use kmap_local_folio()
and pagefault_disable() instead of kmap_atomic().  That allows preemption
and/or task migration to happen during the copy_from_user().  Also use
the new folio_test_partial_kmap() predicate instead of open-coding it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/uio.h | 10 ++--------
 lib/iov_iter.c      | 29 +++++++++++++----------------
 2 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 49ece9e1888f..e46477482663 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -176,8 +176,6 @@ static inline size_t iov_length(const struct iovec *iov, unsigned long nr_segs)
 	return ret;
 }
 
-size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
-				  size_t bytes, struct iov_iter *i);
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
 size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t bytes);
@@ -187,6 +185,8 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
+size_t copy_folio_from_iter_atomic(struct folio *folio, size_t offset,
+		size_t bytes, struct iov_iter *i);
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
@@ -204,12 +204,6 @@ static inline size_t copy_folio_from_iter(struct folio *folio, size_t offset,
 	return copy_page_from_iter(&folio->page, offset, bytes, i);
 }
 
-static inline size_t copy_folio_from_iter_atomic(struct folio *folio,
-		size_t offset, size_t bytes, struct iov_iter *i)
-{
-	return copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
-}
-
 size_t copy_page_to_iter_nofault(struct page *page, unsigned offset,
 				 size_t bytes, struct iov_iter *i);
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index d9e19fb2dcf3..969d4ad510df 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -457,38 +457,35 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_zero);
 
-size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
+size_t copy_folio_from_iter_atomic(struct folio *folio, size_t offset,
 		size_t bytes, struct iov_iter *i)
 {
 	size_t n, copied = 0;
-	bool uses_kmap = IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) ||
-			 PageHighMem(page);
 
-	if (!page_copy_sane(page, offset, bytes))
+	if (!page_copy_sane(&folio->page, offset, bytes))
 		return 0;
 	if (WARN_ON_ONCE(!i->data_source))
 		return 0;
 
 	do {
-		char *p;
+		char *to = kmap_local_folio(folio, offset);
 
 		n = bytes - copied;
-		if (uses_kmap) {
-			page += offset / PAGE_SIZE;
-			offset %= PAGE_SIZE;
-			n = min_t(size_t, n, PAGE_SIZE - offset);
-		}
-
-		p = kmap_atomic(page) + offset;
-		n = __copy_from_iter(p, n, i);
-		kunmap_atomic(p);
+		if (folio_test_partial_kmap(folio) &&
+		    n > PAGE_SIZE - offset_in_page(offset))
+			n = PAGE_SIZE - offset_in_page(offset);
+
+		pagefault_disable();
+		n = __copy_from_iter(to, n, i);
+		pagefault_enable();
+		kunmap_local(to);
 		copied += n;
 		offset += n;
-	} while (uses_kmap && copied != bytes && n > 0);
+	} while (copied != bytes && n > 0);
 
 	return copied;
 }
-EXPORT_SYMBOL(copy_page_from_iter_atomic);
+EXPORT_SYMBOL(copy_folio_from_iter_atomic);
 
 static void iov_iter_bvec_advance(struct iov_iter *i, size_t size)
 {
-- 
2.47.2


