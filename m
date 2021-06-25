Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3AC3B3AA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 03:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhFYCAE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 22:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhFYCAE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 22:00:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FB2C061574;
        Thu, 24 Jun 2021 18:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MXjKTNHOnjltT/dot/g0YTpYEVLMdUkJzO1LZTVDP6o=; b=JZhNvXWvrjI4O4uDc3UFXGdV6+
        6qiO/mBCCwvyi9o5MzFKjhi271ph7C+nds62urru+bHOUPNaTv/1PJQpTjSwbKNkP0qPttjibrZI6
        lEVx1xji8mb51FWW0rLvgp8CdyYSQo0ghjYDuqcB+MXq9KY8DAZdYrZdXecj7qnVlWolkM5iZfcmO
        MhfpnOFM+47D67scmXfYV8tv2z97pEM6u19Ii1MtmufPshdMkSxUrAVx2ziAlhZjiv7quQO5KGgn5
        QS2X50QIHG0cQ5lSJ8ogV8/0xcLgL+6CPww/br5vmRUZ9xzpYl4JsYD6sLvyTnrUR1Cwj19bb70eH
        2CpZoB2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwb5s-00HDJz-Cr; Fri, 25 Jun 2021 01:57:22 +0000
Date:   Fri, 25 Jun 2021 02:57:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 43/46] mm/filemap: Add filemap_add_folio
Message-ID: <YNU4AALw2QLZ06ML@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-44-willy@infradead.org>
 <YNMbPBIngFe2VOzc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNMbPBIngFe2VOzc@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 01:30:04PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 22, 2021 at 01:15:48PM +0100, Matthew Wilcox (Oracle) wrote:
> > Pages being added to the page cache should already be folios, so
> > just cast the page to a folio in the add_to_page_cache_lru() wrapper.
> > Saves 96 bytes of text.
> 
> modulo the casting:

ok.  Moved add_to_page_cache_lru() into folio-compat.c, added the call
to page_folio() and also added:

        if (!huge) {
+               VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
                error = folio_charge_cgroup(folio, current->mm, gfp);

as we don't want pages added at an unaligned index in the file.

> Reviewed-by: Christoph Hellwig <hch@lst.de>
