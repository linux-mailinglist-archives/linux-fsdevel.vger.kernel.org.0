Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FCE788F95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjHYUNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 16:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjHYUMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:12:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A10E268F;
        Fri, 25 Aug 2023 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ELagD2aOgt6ixf7oF8s2S5SoqYM3wQ/LmYSEHizmfB0=; b=ildkXC1FRkJc6vIhDXN9KIrscJ
        5QEhVMgHXKcWTBFya93q4bDdZpA20cs/zgohZqN60FToc44tDTjhVtUe6AvnwoByGOyhVXXotqeFp
        lx8T3L7lsfuiWqLFh1iEzNQaiwczyDS+F4akGUn7f9BjAdjNUhlpThh9euQ26B8vz+Csqd8Cv5pk8
        q3O7n7q/4/vPp44BuWi2jx/hp6hr7Hz0jR1Rh42NyD2QEfVWOEg5Qrm7RiybY9jPrrC9GE7ReT7lh
        mXrz9w8i7EainOVqqqAIvVwP0ESMT97OlP9+zpfShjjIcuFxqQw5HTi6JMJFOH4sYC3dhXQa+5o8s
        KcOyqhwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZdAW-001SaZ-IU; Fri, 25 Aug 2023 20:12:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/15] netfs: Remove unused functions
Date:   Fri, 25 Aug 2023 21:12:25 +0100
Message-Id: <20230825201225.348148-16-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230825201225.348148-1-willy@infradead.org>
References: <20230825201225.348148-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

set_page_fscache(), wait_on_page_fscache() and
wait_on_page_fscache_killable() have no more users.  Remove them and
update the documentation to describe their folio equivalents.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 .../filesystems/caching/netfs-api.rst         | 30 +++++++++----------
 include/linux/netfs.h                         | 15 ----------
 2 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/Documentation/filesystems/caching/netfs-api.rst b/Documentation/filesystems/caching/netfs-api.rst
index 665b27f1556e..6285c1433ac5 100644
--- a/Documentation/filesystems/caching/netfs-api.rst
+++ b/Documentation/filesystems/caching/netfs-api.rst
@@ -374,7 +374,7 @@ Caching of Local Modifications
 ==============================
 
 If a network filesystem has locally modified data that it wants to write to the
-cache, it needs to mark the pages to indicate that a write is in progress, and
+cache, it needs to mark the folios to indicate that a write is in progress, and
 if the mark is already present, it needs to wait for it to be removed first
 (presumably due to an already in-progress operation).  This prevents multiple
 competing DIO writes to the same storage in the cache.
@@ -384,14 +384,14 @@ like::
 
 	bool caching = fscache_cookie_enabled(cookie);
 
-If caching is to be attempted, pages should be waited for and then marked using
+If caching is to be attempted, folios should be waited for and then marked using
 the following functions provided by the netfs helper library::
 
-	void set_page_fscache(struct page *page);
-	void wait_on_page_fscache(struct page *page);
-	int wait_on_page_fscache_killable(struct page *page);
+	void folio_start_fscache(struct folio *folio);
+	void folio_wait_fscache(struct folio *folio);
+	int folio_wait_fscache_killable(struct folio *folio);
 
-Once all the pages in the span are marked, the netfs can ask fscache to
+Once all the folios in the span are marked, the netfs can ask fscache to
 schedule a write of that region::
 
 	void fscache_write_to_cache(struct fscache_cookie *cookie,
@@ -408,7 +408,7 @@ by calling::
 				     loff_t start, size_t len,
 				     bool caching)
 
-In these functions, a pointer to the mapping to which the source pages are
+In these functions, a pointer to the mapping to which the source folios are
 attached is passed in and start and len indicate the size of the region that's
 going to be written (it doesn't have to align to page boundaries necessarily,
 but it does have to align to DIO boundaries on the backing filesystem).  The
@@ -421,29 +421,29 @@ and term_func indicates an optional completion function, to which
 term_func_priv will be passed, along with the error or amount written.
 
 Note that the write function will always run asynchronously and will unmark all
-the pages upon completion before calling term_func.
+the folios upon completion before calling term_func.
 
 
-Page Release and Invalidation
-=============================
+Folio Release and Invalidation
+===================================
 
 Fscache keeps track of whether we have any data in the cache yet for a cache
 object we've just created.  It knows it doesn't have to do any reading until it
-has done a write and then the page it wrote from has been released by the VM,
+has done a write and then the folio it wrote from has been released by the VM,
 after which it *has* to look in the cache.
 
-To inform fscache that a page might now be in the cache, the following function
+To inform fscache that a folio might now be in the cache, the following function
 should be called from the ``release_folio`` address space op::
 
 	void fscache_note_page_release(struct fscache_cookie *cookie);
 
 if the page has been released (ie. release_folio returned true).
 
-Page release and page invalidation should also wait for any mark left on the
+Folio release and folio invalidation should also wait for any mark left on the
 page to say that a DIO write is underway from that page::
 
-	void wait_on_page_fscache(struct page *page);
-	int wait_on_page_fscache_killable(struct page *page);
+	void folio_wait_fscache(struct folio *folio);
+	int folio_wait_fscache_killable(struct folio *folio);
 
 
 API Function Reference
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index b11a84f6c32b..5e43e7010ff5 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -89,26 +89,11 @@ static inline int folio_wait_fscache_killable(struct folio *folio)
 	return folio_wait_private_2_killable(folio);
 }
 
-static inline void set_page_fscache(struct page *page)
-{
-	folio_start_fscache(page_folio(page));
-}
-
 static inline void end_page_fscache(struct page *page)
 {
 	folio_end_private_2(page_folio(page));
 }
 
-static inline void wait_on_page_fscache(struct page *page)
-{
-	folio_wait_private_2(page_folio(page));
-}
-
-static inline int wait_on_page_fscache_killable(struct page *page)
-{
-	return folio_wait_private_2_killable(page_folio(page));
-}
-
 enum netfs_io_source {
 	NETFS_FILL_WITH_ZEROES,
 	NETFS_DOWNLOAD_FROM_SERVER,
-- 
2.40.1

