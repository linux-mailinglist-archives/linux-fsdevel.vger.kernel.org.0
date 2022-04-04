Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C1D4F1B0E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 23:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379404AbiDDVTf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379530AbiDDRYh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:24:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66C21E3E9;
        Mon,  4 Apr 2022 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=WDmJkzTOV5prGKHUXnERasOZdVdKCXK3OjDlEOEABJc=; b=iWojZFEXJ3Tl8QRYvsfIwbtRiG
        m+GXCj5t1/iaGiXDjdTwSbEX5AylKweLk7pVDRDRHMPgCDYMTtal8uqRaAmNeZ5hHiHf96eFklEFP
        tVCvbFA4PmgIPnH75yc4L73oX3dY2ITGV5FlvR+2PQJzO4+LCn1mEjkumILoSzBn7XWqtjVauGKwq
        Qn86GUMtaEBnpcu7HB1y48Y3h0+f54ICyb8N7/aZGjpNmdXZMsGMglishjW1DJJBCW6KKVoAERi29
        u7MPL84TP4KDNGX/imbgNDzdd5RrAhNHwVnEDhHANyjzbDAGW4P+/LQmOeC922QavueASF1yZaE1B
        NDQBZE4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbQPT-005uxA-WC; Mon, 04 Apr 2022 17:22:36 +0000
Date:   Mon, 4 Apr 2022 18:22:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>
Subject: [RFC] Documentation for folio_lock() and friends
Message-ID: <YkspW4HDL54xEg69@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's a shame to not have these functions documented.  I'm sure I've
missed a few things that would be useful to document here.

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ab47579af434..47b7851f1b64 100644
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
@@ -901,6 +913,26 @@ static inline int trylock_page(struct page *page)
 	return folio_trylock(page_folio(page));
 }
 
+/**
+ * folio_lock() - Lock this folio.
+ * @folio: The folio to lock.
+ *
+ * The folio lock protects against many things, probably more than it
+ * should.  It is primarily held while a folio is being read from storage,
+ * either from its backing file or from swap.  It is also held while a
+ * folio is being truncated from its address_space.
+ *
+ * Holding the lock usually prevents the contents of the folio from being
+ * modified by other kernel users, although it does not prevent userspace
+ * from modifying data if it's mapped.  The lock is not consistently held
+ * while a folio is being modified by DMA.
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
@@ -908,6 +940,17 @@ static inline void folio_lock(struct folio *folio)
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
@@ -918,6 +961,16 @@ static inline void lock_page(struct page *page)
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
@@ -964,8 +1017,8 @@ int folio_wait_bit_killable(struct folio *folio, int bit_nr);
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

