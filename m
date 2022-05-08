Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522CB51F152
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiEHUfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiEHUfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE2E11C1F
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RHxad9HVpNslqwK8CBIckHgoeK7awCd5JTOwD8ARf4E=; b=CYVlSoprnS3gQ+/khJoK1ilJEJ
        Mmzf50PmXkPKqZPSNxq3VoE3a9ZvEIl9CDHTe/1WvVPwbdt/hcCHCBBs8fbp8LP0qnc4yjQ1lFfBa
        XwRbcadV/zUBY/yCtlRDWCByGmcHLTNCV2/b/sejL8w39r1UXDwrV7SW9D+xz+x0R2K21axMmLMQz
        lWfir5KVu4lZ6Rok3ZXXpr10K+uQZ2UDrEpO9zm8u8BF+qQUCC0syUs0cdHZgaxHBvmWW7GX1RESH
        hNGWH1O5G/ijU7GCJbKqQ99+Te/CMxS3Jj3LQmI1UkgYUcsWV3ZNs7iwoH64zD9AEAD6SF3izIVJd
        PvujowPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnYL-002ni4-DO; Sun, 08 May 2022 20:30:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/3] filemap: Update the folio_lock documentation
Date:   Sun,  8 May 2022 21:30:47 +0100
Message-Id: <20220508203048.667631-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203048.667631-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203048.667631-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add kernel-doc for several functions relating to take the folio lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 59 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ab47579af434..60657132080f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -888,6 +888,18 @@ bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
 void unlock_page(struct page *page);
 void folio_unlock(struct folio *folio);
 
+/**
+ * folio_trylock() - Attempt to lock a folio.
+ * @folio: The folio to attempt to lock.
+ *
+ * Sometimes it is undesirable to wait for a folio to be unlocked (eg
+ * when the locks are being taken in the wrong order, or if making
+ * progress through a batch of folios is more important than processing
+ * them in order).  Usually folio_lock() is the correct function to call.
+ *
+ * Context: Any context.
+ * Return: Whether the lock was successfully acquired.
+ */
 static inline bool folio_trylock(struct folio *folio)
 {
 	return likely(!test_and_set_bit_lock(PG_locked, folio_flags(folio, 0)));
@@ -901,6 +913,28 @@ static inline int trylock_page(struct page *page)
 	return folio_trylock(page_folio(page));
 }
 
+/**
+ * folio_lock() - Lock this folio.
+ * @folio: The folio to lock.
+ *
+ * The folio lock protects against many things, probably more than it
+ * should.  It is primarily held while a folio is being brought uptodate,
+ * either from its backing file or from swap.  It is also held while a
+ * folio is being truncated from its address_space, so holding the lock
+ * is sufficient to keep folio->mapping stable.
+ *
+ * The folio lock is also held while write() is modifying the page to
+ * provide POSIX atomicity guarantees (as long as the write does not
+ * cross a page boundary).  Other modifications to the data in the folio
+ * do not hold the folio lock and can race with writes, eg DMA and stores
+ * to mapped pages.
+ *
+ * Context: May sleep.  If you need to acquire the locks of two or
+ * more folios, they must be in order of ascending index, if they are
+ * in the same address_space.  If they are in different address_spaces,
+ * acquire the lock of the folio which belongs to the address_space which
+ * has the lowest address in memory first.
+ */
 static inline void folio_lock(struct folio *folio)
 {
 	might_sleep();
@@ -908,6 +942,17 @@ static inline void folio_lock(struct folio *folio)
 		__folio_lock(folio);
 }
 
+/**
+ * lock_page() - Lock the folio containing this page.
+ * @page: The page to lock.
+ *
+ * See folio_lock() for a description of what the lock protects.
+ * This is a legacy function and new code should probably use folio_lock()
+ * instead.
+ *
+ * Context: May sleep.  Pages in the same folio share a lock, so do not
+ * attempt to lock two pages which share a folio.
+ */
 static inline void lock_page(struct page *page)
 {
 	struct folio *folio;
@@ -918,6 +963,16 @@ static inline void lock_page(struct page *page)
 		__folio_lock(folio);
 }
 
+/**
+ * folio_lock_killable() - Lock this folio, interruptible by a fatal signal.
+ * @folio: The folio to lock.
+ *
+ * Attempts to lock the folio, like folio_lock(), except that the sleep
+ * to acquire the lock is interruptible by a fatal signal.
+ *
+ * Context: May sleep; see folio_lock().
+ * Return: 0 if the lock was acquired; -EINTR if a fatal signal was received.
+ */
 static inline int folio_lock_killable(struct folio *folio)
 {
 	might_sleep();
@@ -964,8 +1019,8 @@ int folio_wait_bit_killable(struct folio *folio, int bit_nr);
  * Wait for a folio to be unlocked.
  *
  * This must be called with the caller "holding" the folio,
- * ie with increased "page->count" so that the folio won't
- * go away during the wait..
+ * ie with increased folio reference count so that the folio won't
+ * go away during the wait.
  */
 static inline void folio_wait_locked(struct folio *folio)
 {
-- 
2.34.1

