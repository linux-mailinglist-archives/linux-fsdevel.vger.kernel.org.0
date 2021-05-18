Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C097387FDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 20:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351651AbhERSrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 14:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbhERSrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 14:47:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF5CC06175F;
        Tue, 18 May 2021 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nwQB61PCdJJerfmFhe3lzFG5sVzdOBlAtF2vq2SQHdQ=; b=qHrbkPb7HeA1rGif0FSFLD9xDy
        ytBSCOdjFx16YofUOdk798ddRAaxsnL9kdxiT3FVlw4sAN9LA6xbMTvr54BQm3Lin3GtI3ZMOURQe
        mQMe9kQQhXBUaR/Zl3VQS9/gcHKZ4D3zKbSJAYyeQLRr6JqisgMwZrFYw3D0/m7tQet+AOOxLGGVO
        5mFYISrv2hQTzM5YNPZGiDz5U5tsIgh8ilT1KCYkpLx19c9q2t/TGa0Os4kk03+dP5U3Tw5Jr799I
        kQzleeOuiEWvDh4fW1gS8sutu6za/Q3EknBc7vukfq+UsyOPGNejBr6WkGQ8QENcxUobdxyPu+UK/
        G6fiNP1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lj4ii-00EGFe-F9; Tue, 18 May 2021 18:45:42 +0000
Date:   Tue, 18 May 2021 19:45:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v10 16/33] mm: Add folio_mapcount
Message-ID: <YKQLTC1/E8+/hzcC@casper.infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511214735.1836149-17-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 10:47:18PM +0100, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of page_mapcount().
[...]
>  
> +/**
> + * folio_mapcount - The number of mappings of this folio.
> + * @folio: The folio.
> + *
> + * The result includes the number of times any of the pages in the
> + * folio are mapped to userspace.

I thought it did, but it doesn't.  It returns the number of times
the head/base page of this folio is mapped into userspace, which is not
a terribly useful concept.  I suspect this should call total_mapcount()
instead.  Looking through the complete set of patches, it's only used
in debugging code (unaccount_page_cache_page() and dump_page()).
I'm going to withdraw this patch from the next submission until I've
had the chance to think about it some more.

