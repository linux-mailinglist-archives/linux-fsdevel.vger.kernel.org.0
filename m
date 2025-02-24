Return-Path: <linux-fsdevel+bounces-42484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E4A42AA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 19:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698B33B067F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91445266587;
	Mon, 24 Feb 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oEtAXBzN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06592264FA6
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420336; cv=none; b=MyO78nwqz1cGSWxuzPKSL41rwSONMU9cgmcFwzLaisO/NBGWtGP5Zzhh+fCQq6E4jHqiSyeeABZkKKb32/xn/mpwwYbEA740j5csKBZsE0zOvo9Tb5oASlIZqZsAfKAk3Ug3uz0lCxS85KGm36BNqksoxb0S8IxvNgivc6OJq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420336; c=relaxed/simple;
	bh=ruHcDVes/VWwDH6/sZK9rpjnUq4bDCDy2oTA1aknZ7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rphS5+EU89WClYr2hUaFHLaMRpgyzdv4mku18J98hGSIbafKejNAh2AeEiQVJ+kZavUeEYPEwL4PnBMjGsyFAN2uGnCXgbVhhQuD+f5PgeoGOhoe9zlJPn3LfVl4iZWF0uyDBmTmh5mDVOrDGPP9uC3MUhCu9v8WGyDB8x4UFNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oEtAXBzN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ZT1e+z5j7g0Y8+JV1Am2asZ537kvpyymY4pnooXr2r4=; b=oEtAXBzNmzKPf8R87Ay5eCTEhW
	fiBWaeVXvahcDwcLPlAICivAglJjb05VS7o2nOKRmN/a6cdE5VXHsE+vpnNTRozGy555qiRLt6gwQ
	X4xpg4Gq5yUIHyDEXGRZYwYjTZWzLZ3NJ3abCJmlqoCDfzKc5Cw4014ovGms2rXPSv8uB6yXwdbOr
	8JyNB8Ry6MsS23nlHVknQGNcOrxhYbhJnM0kPUVJmkstbVby4IWdr3gt5CCwVpv9xU3quT2aOd0el
	kILIQJmk4RFxVrS+qec0kkqq8r1WFB7dCS4YAwwfAqz1TthYphINtPb8nJkH7/FWi1yqM+fS39tTQ
	iu6EMOwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmcpg-000000082fm-1I7U;
	Mon, 24 Feb 2025 18:05:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Mike Marshall <hubcap@omnibond.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/9] orangefs: make open_for_read and open_for_write boolean
Date: Mon, 24 Feb 2025 18:05:21 +0000
Message-ID: <20250224180529.1916812-4-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224180529.1916812-1-willy@infradead.org>
References: <20250224180529.1916812-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparse currently warns:

fs/orangefs/file.c:119:32: warning: incorrect type in assignment (different base types)
fs/orangefs/file.c:119:32:    expected int open_for_write
fs/orangefs/file.c:119:32:    got restricted fmode_t

Turning open_for_write and open_for_read into booleans (which is how
they're used) removes this warning.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/orangefs/file.c         | 4 ++--
 include/linux/mm_types.h   | 6 +++---
 include/linux/nfs_page.h   | 2 +-
 include/linux/page-flags.h | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index d68372241b30..90c49c0de243 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -57,8 +57,8 @@ ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
 	int buffer_index;
 	ssize_t ret;
 	size_t copy_amount;
-	int open_for_read;
-	int open_for_write;
+	bool open_for_read;
+	bool open_for_write;
 
 	new_op = op_alloc(ORANGEFS_VFS_OP_FILE_IO);
 	if (!new_op)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e1f23c3429c9..0ca9feec67b8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -101,7 +101,7 @@ struct page {
 				struct list_head pcp_list;
 			};
 			/* See page-flags.h for PAGE_MAPPING_FLAGS */
-			struct address_space *mapping;
+			struct address_space *__folio_mapping;
 			union {
 				pgoff_t __folio_index;		/* Our offset within mapping. */
 				unsigned long share;	/* share count for fsdax */
@@ -403,7 +403,7 @@ struct folio {
 	static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
 FOLIO_MATCH(flags, flags);
 FOLIO_MATCH(lru, lru);
-FOLIO_MATCH(mapping, mapping);
+FOLIO_MATCH(__folio_mapping, mapping);
 FOLIO_MATCH(compound_head, lru);
 FOLIO_MATCH(__folio_index, index);
 FOLIO_MATCH(private, private);
@@ -499,7 +499,7 @@ struct ptdesc {
 TABLE_MATCH(flags, __page_flags);
 TABLE_MATCH(compound_head, pt_list);
 TABLE_MATCH(compound_head, _pt_pad_1);
-TABLE_MATCH(mapping, __page_mapping);
+TABLE_MATCH(__folio_mapping, __page_mapping);
 TABLE_MATCH(__folio_index, pt_index);
 TABLE_MATCH(rcu_head, pt_rcu_head);
 TABLE_MATCH(page_type, __page_type);
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 169b4ae30ff4..0db50ce065cb 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -205,7 +205,7 @@ static inline struct inode *nfs_page_to_inode(const struct nfs_page *req)
 	struct folio *folio = nfs_page_to_folio(req);
 
 	if (folio == NULL)
-		return req->wb_page->mapping->host;
+		return req->wb_folio->mapping->host;
 	return folio->mapping->host;
 }
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 36d283552f80..796fabeae46f 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -675,7 +675,7 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
 
 /*
  * Different with flags above, this flag is used only for fsdax mode.  It
- * indicates that this page->mapping is now under reflink case.
+ * indicates that this folio->mapping is now under reflink case.
  */
 #define PAGE_MAPPING_DAX_SHARED	((void *)0x1)
 
@@ -686,7 +686,7 @@ static __always_inline bool folio_mapping_flags(const struct folio *folio)
 
 static __always_inline bool PageMappingFlags(const struct page *page)
 {
-	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) != 0;
+	return ((unsigned long)page->__folio_mapping & PAGE_MAPPING_FLAGS) != 0;
 }
 
 static __always_inline bool folio_test_anon(const struct folio *folio)
@@ -714,7 +714,7 @@ static __always_inline bool __folio_test_movable(const struct folio *folio)
 
 static __always_inline bool __PageMovable(const struct page *page)
 {
-	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
+	return ((unsigned long)page->__folio_mapping & PAGE_MAPPING_FLAGS) ==
 				PAGE_MAPPING_MOVABLE;
 }
 
-- 
2.47.2


