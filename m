Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61A67BB5C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 13:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjJFLBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 07:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjJFLBb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:01:31 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4A4CE;
        Fri,  6 Oct 2023 04:01:28 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4S258N085Bz9sp9;
        Fri,  6 Oct 2023 13:01:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1696590084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Xbpc76QqDf9iPooRjIH3Xrrud0vO4BKu7rmjONR5S4=;
        b=RRNKycN0CdxUtskp7qqEKSR0HoUKIzy9XEteOBbIh8fZe061MJQlcu0FSZ0sqy6UG0TbKW
        UG+NmEczMEGdqQleZEkZjt/JRy2j0X5+Hl1up+8FitOPTXzuFhh+XDq6g5pUUVg+FDgS6e
        dLSA21gaVfCD1ybLSxr0NoIsYIy7igKAfWcGscbJM2bNdTHn8PYMsrBqDOSFiHfTPAofc4
        wZROTi0Bo/aheTNRURsc4fM8WdzVgpcpoeXcZHjB7r3IqGqDXeeocya1ymoaTeH+aLjY3c
        H4tsbeIvpJ2aLn87xnHA0++awUSVarHa8BRFRskcnRTxtNFQ19c/RQDWrp8rVg==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     willy@infradead.org, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        gost.dev@samsung.com, linux-kernel@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] filemap: call filemap_get_folios_tag() from filemap_get_folios()
Date:   Fri,  6 Oct 2023 13:01:20 +0200
Message-Id: <20231006110120.136809-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4S258N085Bz9sp9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pankaj Raghav <p.raghav@samsung.com>

filemap_get_folios() is filemap_get_folios_tag() with XA_PRESENT as the
tag that is being matched. Return filemap_get_folios_tag() with
XA_PRESENT as the tag instead of duplicating the code in
filemap_get_folios().

No functional changes.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/filemap.c | 45 ++++++++-------------------------------------
 1 file changed, 8 insertions(+), 37 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 695cf0e643da..525b8d68b4b1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2120,48 +2120,13 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
  * index @start and up to index @end (inclusive).  The folios are returned
  * in @fbatch with an elevated reference count.
  *
- * The first folio may start before @start; if it does, it will contain
- * @start.  The final folio may extend beyond @end; if it does, it will
- * contain @end.  The folios have ascending indices.  There may be gaps
- * between the folios if there are indices which have no folio in the
- * page cache.  If folios are added to or removed from the page cache
- * while this is running, they may or may not be found by this call.
- *
  * Return: The number of folios which were found.
  * We also update @start to index the next folio for the traversal.
  */
 unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch)
 {
-	XA_STATE(xas, &mapping->i_pages, *start);
-	struct folio *folio;
-
-	rcu_read_lock();
-	while ((folio = find_get_entry(&xas, end, XA_PRESENT)) != NULL) {
-		/* Skip over shadow, swap and DAX entries */
-		if (xa_is_value(folio))
-			continue;
-		if (!folio_batch_add(fbatch, folio)) {
-			unsigned long nr = folio_nr_pages(folio);
-			*start = folio->index + nr;
-			goto out;
-		}
-	}
-
-	/*
-	 * We come here when there is no page beyond @end. We take care to not
-	 * overflow the index @start as it confuses some of the callers. This
-	 * breaks the iteration when there is a page at index -1 but that is
-	 * already broken anyway.
-	 */
-	if (end == (pgoff_t)-1)
-		*start = (pgoff_t)-1;
-	else
-		*start = end + 1;
-out:
-	rcu_read_unlock();
-
-	return folio_batch_count(fbatch);
+	return filemap_get_folios_tag(mapping, start, end, XA_PRESENT, fbatch);
 }
 EXPORT_SYMBOL(filemap_get_folios);
 
@@ -2240,7 +2205,13 @@ EXPORT_SYMBOL(filemap_get_folios_contig);
  * @tag:        The tag index
  * @fbatch:     The batch to fill
  *
- * Same as filemap_get_folios(), but only returning folios tagged with @tag.
+ * The first folio may start before @start; if it does, it will contain
+ * @start.  The final folio may extend beyond @end; if it does, it will
+ * contain @end.  The folios have ascending indices.  There may be gaps
+ * between the folios if there are indices which have no folio in the
+ * page cache.  If folios are added to or removed from the page cache
+ * while this is running, they may or may not be found by this call.
+ * Only returns folios that are tagged with @tag.
  *
  * Return: The number of folios found.
  * Also update @start to index the next folio for traversal.
-- 
2.40.1

