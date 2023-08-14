Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7DD77BBE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 16:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjHNOl3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjHNOlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:41:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18628109;
        Mon, 14 Aug 2023 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZEcKxV+OG7yAAAoqK3p3o4fR1eb6giyew8o7UtGpAeg=; b=aooSz6Do+KBjGJGkpgWrnn0vIx
        xDDRlBc70ov4lG2yocyAedKGB+FCy8SYtPtxhCawV/2FUPJZgsps7qzIGZWJQ/fSHubSDMkhg7yvs
        UYRsc2bhxBWUwlk4x2wh0vb45dfivQYCHCbDFXS3NWfZZVBw9TgB7ZggT0dhYc3nYwvD8toKPe4n0
        ZCYWtYl1+MYLOAs/GJBtJxMJ8yqHmwgM7NBxAKiLvQcfMCwNhAF0T2g66PRwTtnAG25WqqExf/a0H
        P9Ko14yTCJLTeTpnjNWj+QiaiKpTnIR6Uom/K+tDu+JZw8SF6z22VB903u3mewbr8oZnty2q6SHC0
        uGNniv7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVYkg-002VFG-TN; Mon, 14 Aug 2023 14:41:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] block: Remove special-casing of compound pages
Date:   Mon, 14 Aug 2023 15:41:00 +0100
Message-Id: <20230814144100.596749-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The special casing was originally added in pre-git history; reproducing
the commit log here:

> commit a318a92567d77
> Author: Andrew Morton <akpm@osdl.org>
> Date:   Sun Sep 21 01:42:22 2003 -0700
>
>     [PATCH] Speed up direct-io hugetlbpage handling
>
>     This patch short-circuits all the direct-io page dirtying logic for
>     higher-order pages.  Without this, we pointlessly bounce BIOs up to
>     keventd all the time.

In the last twenty years, compound pages have become used for more than
just hugetlb.  Rewrite these functions to operate on folios instead
of pages and remove the special case for hugetlbfs; I don't think
it's needed any more (and if it is, we can put it back in as a call
to folio_test_hugetlb()).

This was found by inspection; as far as I can tell, this bug can lead
to pages used as the destination of a direct I/O read not being marked
as dirty.  If those pages are then reclaimed by the MM without being
dirtied for some other reason, they won't be written out.  Then when
they're faulted back in, they will not contain the data they should.
It'll take a pretty unusual setup to produce this problem with several
races all going the wrong way.

This problem predates the folio work; it could for example have been
triggered by mmaping a THP in tmpfs and using that as the target of an
O_DIRECT read.

Fixes: 800d8c63b2e98 ("shmem: add huge pages support")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/bio.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8672179213b9..f46d8ec71fbd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1171,13 +1171,22 @@ EXPORT_SYMBOL(bio_add_folio);
 
 void __bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-	struct bvec_iter_all iter_all;
-	struct bio_vec *bvec;
+	struct folio_iter fi;
+
+	bio_for_each_folio_all(fi, bio) {
+		struct page *page;
+		size_t done = 0;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (mark_dirty && !PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
-		bio_release_page(bio, bvec->bv_page);
+		if (mark_dirty) {
+			folio_lock(fi.folio);
+			folio_mark_dirty(fi.folio);
+			folio_unlock(fi.folio);
+		}
+		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
+		do {
+			bio_release_page(bio, page++);
+			done += PAGE_SIZE;
+		} while (done < fi.length);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1455,18 +1464,12 @@ EXPORT_SYMBOL(bio_free_pages);
  * bio_set_pages_dirty() and bio_check_pages_dirty() are support functions
  * for performing direct-IO in BIOs.
  *
- * The problem is that we cannot run set_page_dirty() from interrupt context
+ * The problem is that we cannot run folio_mark_dirty() from interrupt context
  * because the required locks are not interrupt-safe.  So what we can do is to
  * mark the pages dirty _before_ performing IO.  And in interrupt context,
  * check that the pages are still dirty.   If so, fine.  If not, redirty them
  * in process context.
  *
- * We special-case compound pages here: normally this means reads into hugetlb
- * pages.  The logic in here doesn't really work right for compound pages
- * because the VM does not uniformly chase down the head page in all cases.
- * But dirtiness of compound pages is pretty meaningless anyway: the VM doesn't
- * handle them at all.  So we skip compound pages here at an early stage.
- *
  * Note that this code is very hard to test under normal circumstances because
  * direct-io pins the pages with get_user_pages().  This makes
  * is_page_cache_freeable return false, and the VM will not clean the pages.
@@ -1482,12 +1485,12 @@ EXPORT_SYMBOL(bio_free_pages);
  */
 void bio_set_pages_dirty(struct bio *bio)
 {
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (!PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
+	bio_for_each_folio_all(fi, bio) {
+		folio_lock(fi.folio);
+		folio_mark_dirty(fi.folio);
+		folio_unlock(fi.folio);
 	}
 }
 
@@ -1530,12 +1533,11 @@ static void bio_dirty_fn(struct work_struct *work)
 
 void bio_check_pages_dirty(struct bio *bio)
 {
-	struct bio_vec *bvec;
+	struct folio_iter fi;
 	unsigned long flags;
-	struct bvec_iter_all iter_all;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
+	bio_for_each_folio_all(fi, bio) {
+		if (!folio_test_dirty(fi.folio))
 			goto defer;
 	}
 
-- 
2.40.1

