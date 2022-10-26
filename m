Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604B760E52E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 18:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiJZQCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 12:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiJZQCY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:02:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7B14314D;
        Wed, 26 Oct 2022 09:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9y9m9otalywWzoGvSHtu1e01bQrx9OTbpDapeszo2KA=; b=O51igS0MsMbF+jUOJyTYhhLyyd
        b/n2CUMLRbNwrkTK6ozOw9vQ6b2Vvart7diDjRHm9uveLB58B7WRvNFVD9x6UsS2FXbtLsSTwis0O
        IHMhl141MwIRHqy9v/zZLa2UgnRFUGnQNkM4KcvfMSO9YVRGfEuCbjNyaolgUqcRIeO2KpMso9grJ
        P0bblg/8SBQJVDvloxiAZ3SKFVdvwO5/z71f7SlV9zT0e2SFm52+nhrFn9wRkn/MVZp5R5mvGvfRT
        C6sT/Tij1yyoBwcMQD3ev7E0r36cjjtnpM053pJB+Yay7YNhjAbomBXqXk8kulfdW+V/gl9fEAPAK
        y4e1cQCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oniqr-00H7Uj-Hv; Wed, 26 Oct 2022 16:01:57 +0000
Date:   Wed, 26 Oct 2022 17:01:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
Message-ID: <Y1lZ9Rm87GpFRM/Q@casper.infradead.org>
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org>
 <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
 <Y017BeC64GDb3Kg7@casper.infradead.org>
 <CAGWkznEdtGPPZkHrq6Y_+XLL37w12aC8XN8R_Q-vhq48rFhkSA@mail.gmail.com>
 <Y04Y3RNq6D2T9rVw@casper.infradead.org>
 <20221018223042.GJ2703033@dread.disaster.area>
 <Y1AWXiJdyjdLmO1E@casper.infradead.org>
 <20221019220424.GO2703033@dread.disaster.area>
 <Y1HDDu3UV0L3cDwE@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1HDDu3UV0L3cDwE@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:52:14PM +0100, Matthew Wilcox wrote:
> But I think the tests you've done refute that theory.  I'm all out of
> ideas at the moment.

I have a new idea.  In page_cache_delete_batch(), we don't set the
order of the entry before calling xas_store().  That means we can end
up in a situation where we have an order-2 folio in the page cache,
delete it and end up with a NULL pointer at (say) index 20 and sibling
entries at indices 21-23.  We can come along (potentially much later)
and put an order-0 folio back at index 20.  Now all of indices 20-23
point to the index-20, order-0 folio.  Worse, the xarray node can be
freed with the sibling entries still intact and then be reallocated by
an entirely different xarray.

I don't know if this is going to fix the problem you're seeing.  I can't
quite draw a line from this situation to your symptoms.  I came across
it while auditing all the places which set folio->mapping to NULL.
I did notice a mis-ordering; all the other places first remove the folio
from the xarray before setting folio to NULL, but I have a hard time
connecting that to your symptoms either.

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 44dd6d6e01bc..cc1fd1f849a7 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1617,6 +1617,12 @@ static inline void xas_advance(struct xa_state *xas, unsigned long index)
 	xas->xa_offset = (index >> shift) & XA_CHUNK_MASK;
 }
 
+static inline void xas_adjust_order(struct xa_state *xas, unsigned int order)
+{
+	xas->xa_shift = order - (order % XA_CHUNK_SHIFT);
+	xas->xa_sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
+}
+
 /**
  * xas_set_order() - Set up XArray operation state for a multislot entry.
  * @xas: XArray operation state.
@@ -1628,8 +1634,7 @@ static inline void xas_set_order(struct xa_state *xas, unsigned long index,
 {
 #ifdef CONFIG_XARRAY_MULTI
 	xas->xa_index = order < BITS_PER_LONG ? (index >> order) << order : 0;
-	xas->xa_shift = order - (order % XA_CHUNK_SHIFT);
-	xas->xa_sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
+	xas_adjust_order(xas, order);
 	xas->xa_node = XAS_RESTART;
 #else
 	BUG_ON(order > 0);
diff --git a/mm/filemap.c b/mm/filemap.c
index 08341616ae7a..6e3f486131e4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -305,11 +305,13 @@ static void page_cache_delete_batch(struct address_space *mapping,
 
 		WARN_ON_ONCE(!folio_test_locked(folio));
 
+		if (!folio_test_hugetlb(folio))
+			xas_adjust_order(&xas, folio_order(folio));
+		xas_store(&xas, NULL);
 		folio->mapping = NULL;
 		/* Leave folio->index set: truncation lookup relies on it */
 
 		i++;
-		xas_store(&xas, NULL);
 		total_pages += folio_nr_pages(folio);
 	}
 	mapping->nrpages -= total_pages;
