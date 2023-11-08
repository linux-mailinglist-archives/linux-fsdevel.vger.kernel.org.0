Return-Path: <linux-fsdevel+bounces-2438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A37BB7E5F61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 21:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4466AB20DFA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB7C3716D;
	Wed,  8 Nov 2023 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LA9dtmsi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F0519460;
	Wed,  8 Nov 2023 20:46:19 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEF12132;
	Wed,  8 Nov 2023 12:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=IYjCp8rTcxEG3M279vzbbI0tfP2VMAdLWvZwpGFWngE=; b=LA9dtmsibsRBbAWigyG6Ny2I5Z
	kSVBhUGbs97uvhj7+Mn2rGkp+uAsSWEP2Wduc0+uzyWxfGaLvOLV7/6xPy7AQD+Kp4LXWjX7kQxoS
	johirG8nYCyJ5z8YzRRJiRQuufogk1Gwmu2LiitFrN83RH8Icq/kwrNnabv0SlHmkC+YGAuND2nDi
	Hw/Sw/1P/gl5OyrI0guLvLwD6Ius4vybwK3R0wAiX4DCsKHdadbbN5GHUY6MPLutdtrwkprjGQ+1y
	LXNOqQ6Zjmv/pTr8ELCD9a7caQzqcmQuMjUiR6M/Tt9KADBlNOCe1IdD/rRmXO9z1v18I9zeWLQL2
	a7Pfju9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0pRC-0037qA-2E; Wed, 08 Nov 2023 20:46:10 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] mm: Return void from folio_start_writeback() and related functions
Date: Wed,  8 Nov 2023 20:46:05 +0000
Message-Id: <20231108204605.745109-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108204605.745109-1-willy@infradead.org>
References: <20231108204605.745109-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody now checks the return value from any of these functions, so
add an assertion at the beginning of the function and return void.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h |  4 +--
 mm/folio-compat.c          |  4 +--
 mm/page-writeback.c        | 54 ++++++++++++++++++--------------------
 3 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a440062e9386..735cddc13d20 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -772,8 +772,8 @@ static __always_inline void SetPageUptodate(struct page *page)
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
 
-bool __folio_start_writeback(struct folio *folio, bool keep_write);
-bool set_page_writeback(struct page *page);
+void __folio_start_writeback(struct folio *folio, bool keep_write);
+void set_page_writeback(struct page *page);
 
 #define folio_start_writeback(folio)			\
 	__folio_start_writeback(folio, false)
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 10c3247542cb..aee3b9a16828 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -46,9 +46,9 @@ void mark_page_accessed(struct page *page)
 }
 EXPORT_SYMBOL(mark_page_accessed);
 
-bool set_page_writeback(struct page *page)
+void set_page_writeback(struct page *page)
 {
-	return folio_start_writeback(page_folio(page));
+	folio_start_writeback(page_folio(page));
 }
 EXPORT_SYMBOL(set_page_writeback);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 46f2f5d3d183..118f02b51c8d 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2982,67 +2982,63 @@ bool __folio_end_writeback(struct folio *folio)
 	return ret;
 }
 
-bool __folio_start_writeback(struct folio *folio, bool keep_write)
+void __folio_start_writeback(struct folio *folio, bool keep_write)
 {
 	long nr = folio_nr_pages(folio);
 	struct address_space *mapping = folio_mapping(folio);
-	bool ret;
 	int access_ret;
 
+	VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
+
 	folio_memcg_lock(folio);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		XA_STATE(xas, &mapping->i_pages, folio_index(folio));
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
 		unsigned long flags;
+		bool on_wblist;
 
 		xas_lock_irqsave(&xas, flags);
 		xas_load(&xas);
-		ret = folio_test_set_writeback(folio);
-		if (!ret) {
-			bool on_wblist;
+		folio_test_set_writeback(folio);
 
-			on_wblist = mapping_tagged(mapping,
-						   PAGECACHE_TAG_WRITEBACK);
+		on_wblist = mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 
-			xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
-			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
-				struct bdi_writeback *wb = inode_to_wb(inode);
-
-				wb_stat_mod(wb, WB_WRITEBACK, nr);
-				if (!on_wblist)
-					wb_inode_writeback_start(wb);
-			}
+		xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
+		if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
+			struct bdi_writeback *wb = inode_to_wb(inode);
 
-			/*
-			 * We can come through here when swapping
-			 * anonymous folios, so we don't necessarily
-			 * have an inode to track for sync.
-			 */
-			if (mapping->host && !on_wblist)
-				sb_mark_inode_writeback(mapping->host);
+			wb_stat_mod(wb, WB_WRITEBACK, nr);
+			if (!on_wblist)
+				wb_inode_writeback_start(wb);
 		}
+
+		/*
+		 * We can come through here when swapping anonymous
+		 * folios, so we don't necessarily have an inode to
+		 * track for sync.
+		 */
+		if (mapping->host && !on_wblist)
+			sb_mark_inode_writeback(mapping->host);
 		if (!folio_test_dirty(folio))
 			xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
 		if (!keep_write)
 			xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
 		xas_unlock_irqrestore(&xas, flags);
 	} else {
-		ret = folio_test_set_writeback(folio);
-	}
-	if (!ret) {
-		lruvec_stat_mod_folio(folio, NR_WRITEBACK, nr);
-		zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
+		folio_test_set_writeback(folio);
 	}
+
+	lruvec_stat_mod_folio(folio, NR_WRITEBACK, nr);
+	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
 	folio_memcg_unlock(folio);
+
 	access_ret = arch_make_folio_accessible(folio);
 	/*
 	 * If writeback has been triggered on a page that cannot be made
 	 * accessible, it is too late to recover here.
 	 */
 	VM_BUG_ON_FOLIO(access_ret != 0, folio);
-
-	return ret;
 }
 EXPORT_SYMBOL(__folio_start_writeback);
 
-- 
2.42.0


