Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424A874012A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjF0Q3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjF0Q3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:29:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB44C4201;
        Tue, 27 Jun 2023 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zMBaNMY5fxWhxCjUL+Yr5OIpVUpaci+VFgSAIS/t+aY=; b=clZ8OCMIypKVF8eyO8py8YFl/R
        9lWRIHvfIoVH+2U7LTKG/mvhLkOxBtepRGgVbVtUtpWzSXOLQE9BxSjsaKJiD9bI0el8zbBWUXv2G
        pwhNxKNz1JPO2fSWOahBUEqbeA5KvwN27ZEdh+W6gWrCRfjryWk3nQcej1HlEUha7yGsWBVrmeRFQ
        zhI5GWVFJ4I6/iuXBs5kserKxHGM3U16c6/4S5yu3H3lOr/Ard8OB8wDJN4QrX+IJSSMEErp8JQRz
        XW/wKaT1HgJnMRkFWf9mVpLqWnbuaznEVTBcD7jEfUjKsj/aB8r2azCkpBNeb+fgT665Q6A63TZo7
        Ja3jRrZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEBYK-00Ddjx-0M;
        Tue, 27 Jun 2023 16:28:28 +0000
Date:   Tue, 27 Jun 2023 09:28:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 09/12] writeback: Factor writeback_iter_next() out of
 write_cache_pages()
Message-ID: <ZJsOLJLtc+SRUU/L@infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <20230626173521.459345-10-willy@infradead.org>
 <ZJpoCy7oWtqy2FoW@infradead.org>
 <ZJsAxVRZSEvdmlfB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJsAxVRZSEvdmlfB@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 04:31:17PM +0100, Matthew Wilcox wrote:
> It makes the callers neater.  Compare:
> 
>                if (!folio)
>                         return writeback_finish(mapping, wbc, false);
> vs
> 		if (!folio) {
> 			writeback_finish(mapping, wbc, false);
> 			return NULL;
> 		}
> 
> Similarly for the other two callers.

Not sure I agree.  See my quickly cooked up patch below.  But in the
end this completely superficial and I won't complain, do it the way
your prefer.

> 
> > > +		if (error == AOP_WRITEPAGE_ACTIVATE) {
> > > +			folio_unlock(folio);
> > > +			error = 0;
> > 
> > Note there really shouldn't be any need for this in outside of the
> > legacy >writepage case.  But it might make sense to delay the removal
> > until after ->writepage is gone to avoid bugs in conversions.
> 
> ext4_journalled_writepage_callback() still returns
> AOP_WRITEPAGE_ACTIVATE, and that's used by a direct call to
> write_cache_pages().

Yeah.  But that could trivially do the open coded unlock_page.
But probably not worth mixing into this series.

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 55832679af2194..07bbbc0dec4d00 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2360,7 +2360,7 @@ void tag_pages_for_writeback(struct address_space *mapping,
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
-static struct folio *writeback_finish(struct address_space *mapping,
+static void writeback_finish(struct address_space *mapping,
 		struct writeback_control *wbc, bool done)
 {
 	folio_batch_release(&wbc->fbatch);
@@ -2374,8 +2374,6 @@ static struct folio *writeback_finish(struct address_space *mapping,
 		wbc->done_index = 0;
 	if (wbc->range_cyclic || (wbc->range_whole && wbc->nr_to_write > 0))
 		mapping->writeback_index = wbc->done_index;
-
-	return NULL;
 }
 
 static struct folio *writeback_get_next(struct address_space *mapping,
@@ -2435,20 +2433,19 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 {
 	struct folio *folio;
 
-	for (;;) {
-		folio = writeback_get_next(mapping, wbc);
-		if (!folio)
-			return writeback_finish(mapping, wbc, false);
+	while ((folio = writeback_get_next(mapping, wbc))) {
 		wbc->done_index = folio->index;
 
 		folio_lock(folio);
-		if (likely(should_writeback_folio(mapping, wbc, folio)))
-			break;
+		if (likely(should_writeback_folio(mapping, wbc, folio))) {
+			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
+			return folio;
+		}
 		folio_unlock(folio);
 	}
 
-	trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
-	return folio;
+	writeback_finish(mapping, wbc, false);
+	return NULL;
 }
 
 struct folio *writeback_iter_init(struct address_space *mapping,
@@ -2494,7 +2491,7 @@ struct folio *writeback_iter_next(struct address_space *mapping,
 			wbc->err = error;
 			wbc->done_index = folio->index +
 					folio_nr_pages(folio);
-			return writeback_finish(mapping, wbc, true);
+			goto done;
 		}
 		if (!wbc->err)
 			wbc->err = error;
@@ -2507,9 +2504,12 @@ struct folio *writeback_iter_next(struct address_space *mapping,
 	 * to entering this loop.
 	 */
 	if (--wbc->nr_to_write <= 0 && wbc->sync_mode == WB_SYNC_NONE)
-		return writeback_finish(mapping, wbc, true);
+		goto done;
 
 	return writeback_get_folio(mapping, wbc);
+done:
+	writeback_finish(mapping, wbc, true);
+	return NULL;
 }
 
 /**
