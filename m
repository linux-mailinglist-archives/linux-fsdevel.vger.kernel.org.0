Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCC43B1935
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 13:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFWLqm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 07:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFWLqk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:46:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6B5C061574;
        Wed, 23 Jun 2021 04:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QwteTGrc0JgAloV5P52YrryUR2KVU5hH5kPJQKfDHfk=; b=ag/lJ35ZaNavbqZxjrmgN1wCrX
        C/rEq5d/WBDZuCphrOpS64vxBbBY/XCqPFwRUEUlmBw1FIKz8qZ9/qX1XRYlj5y57hgLjeCHgKRmo
        Aoz/Yhc6FwaHTZVNgqH9D/8hJrJxPijS3GEBUZuLo3VuTFLPTtWaHuECSgHsbKo5I9OQQ4SBF2Lgk
        yH9KQZfa0Wwk2T0H8ZY+GokLy8Jzn5/dUD9xuCR/2J+T1A47MODpbvGYIqsqSh6f1wYyNEXe6LHw/
        idSK1er37ymneA0yTanZJW+y3YLJE+Ni4gxIwVcRvdGxxSGjrtaUpVo6+2QL4c+Bn4m1FKtY3BqJq
        J35QLhlw==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw1I3-00FNKb-Id; Wed, 23 Jun 2021 11:43:34 +0000
Date:   Wed, 23 Jun 2021 13:43:30 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 46/46] mm/filemap: Add FGP_STABLE
Message-ID: <YNMeYqPkzESAkojd@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-47-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-47-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:51PM +0100, Matthew Wilcox (Oracle) wrote:
> Allow filemap_get_folio() to wait for writeback to complete (if the
> filesystem wants that behaviour).  This is the folio equivalent of
> grab_cache_page_write_begin(), which is moved into the folio-compat
> file as a reminder to migrate all the code using it.  This paves the
> way for getting rid of AOP_FLAG_NOFS once grab_cache_page_write_begin()
> is removed.

We actually should kill FGP_NOFS as well by switching everything over
to memalloc_nofs_{save, restore} eventually, given how error prone
all these manual flags settings are.

> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index 78365eaee7d3..206bedd621d0 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -115,6 +115,7 @@ void lru_cache_add(struct page *page)
>  }
>  EXPORT_SYMBOL(lru_cache_add);
>  
> +noinline
>  struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
>  		int fgp_flags, gfp_t gfp)

How did that sneak in here?

Otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>

