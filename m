Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE13F3C23
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Aug 2021 20:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhHUStH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Aug 2021 14:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhHUStH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Aug 2021 14:49:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FABC061575;
        Sat, 21 Aug 2021 11:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y+SHGRYZ6q5sk+kjn9pjpKk095saNNvdcL2W/RGfeXU=; b=FloXxzzbcRyIpFAcyyAaxejdh7
        p5Fv/EOhyEFdbmXN21jBgGrYM6Mb88zAXoreW12qJ4LNuHiUOAbPWk0WuRhViuMZTEi/QJA5UDsq6
        CiF8IylI3eFPmDDU6UPH/PTvTJrG7/SM61dYhDh9cXZkGkw8I6KTTHDi5PGgiQ/zAXuvvYEB4itKD
        cBCWgsO9WONjG3Lv71u9kRm+VMZTbyIc3a0nobaQjCXNC0ozA8Gxty2d40gOUN8NxJwezXeD5GuNs
        9yh6b7ehDDiWgXXa002B9xEp8XcrQa9luk5KCnlgNT3uwTQuY0cormIGsEYtjfDBb+PzOYTCmpq/S
        AelJ8XLg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mHW2L-007q6p-WD; Sat, 21 Aug 2021 18:48:19 +0000
Date:   Sat, 21 Aug 2021 19:48:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 112/138] mm/filemap: Convert filemap_get_read_batch
 to use folios
Message-ID: <YSFKab7Md+L0bZMg@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-113-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-113-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:38AM +0100, Matthew Wilcox (Oracle) wrote:
>  	rcu_read_lock();
> -	for (head = xas_load(&xas); head; head = xas_next(&xas)) {
> -		if (xas_retry(&xas, head))
> +	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
> +		if (xas_retry(&xas, folio))
>  			continue;
> -		if (xas.xa_index > max || xa_is_value(head))
> +		if (xas.xa_index > max || xa_is_value(folio))
>  			break;
> -		if (!page_cache_get_speculative(head))
> +		if (!folio_try_get_rcu(folio))
>  			goto retry;
>  
> -		/* Has the page moved or been split? */
> -		if (unlikely(head != xas_reload(&xas)))
> +		if (unlikely(folio != xas_reload(&xas)))
>  			goto put_page;
>  
> -		if (!pagevec_add(pvec, head))
> +		if (!pagevec_add(pvec, &folio->page))
>  			break;
> -		if (!PageUptodate(head))
> +		if (!folio_test_uptodate(folio))
>  			break;
> -		if (PageReadahead(head))
> +		if (folio_test_readahead(folio))
>  			break;
> -		xas.xa_index = head->index + thp_nr_pages(head) - 1;
> +		xas.xa_index = folio->index + folio_nr_pages(folio) - 1;
>  		xas.xa_offset = (xas.xa_index >> xas.xa_shift) & XA_CHUNK_MASK;
>  		continue;

It's not a bug in _this_ patch, but these last two lines become a bug
once the page cache is converted to store folios as multi-index entries
(as opposed to now when it replicates an order-N entry 2^N times).
I should not have used xas.xa_shift (which is the shift of the entry
we're looking for and is always 0), but xas.xa_node->shift (which is
the shift of the entry that we found).

If you have an order-7 page, occupying (say) indices 128-255, we set
xa_index to 255, but instead of setting xa_offset to 3, we set it to 63.
That tricks __xas_next() into going up to the parent node, and then back
down, which might mean that we terminate the scan early, or that we skip
over all the other entries in the node.  What I actually noticed was a
crash where we ended up loading an internal entry out of the XArray.

It's all a bit complicated really.  That calls for a helper, and this is
my current candidate:

+static inline void xas_advance(struct xa_state *xas, unsigned long index)
+{
+       unsigned char shift = xas_is_node(xas) ? xas->xa_node->shift : 0;
+
+       xas->xa_index = index;
+       xas->xa_offset = (index >> shift) & XA_CHUNK_MASK;
+}
...
-               xas.xa_index = folio->index + folio_nr_pages(folio) - 1;
-               xas.xa_offset = (xas.xa_index >> xas.xa_shift) & XA_CHUNK_MASK;
+               xas_advance(&xas, folio->index + folio_nr_pages(folio) - 1);

This is coming up on 4 hours of continuous testing using generic/559.
Without it, it would usually crash in about 40 minutes.
