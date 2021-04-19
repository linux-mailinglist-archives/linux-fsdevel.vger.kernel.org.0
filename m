Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF40E363E39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 11:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbhDSJG6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 05:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238071AbhDSJG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:06:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC334C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 02:06:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h36so609724lfv.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 02:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rWuG5NeIc1o/ad5klAkavJ7HFtGU9PaK/EU9Glk/tKw=;
        b=CgI4H4+aTxyFoTO1NukOChfSc6R8+1c/waFJB6dwuDtbNvu65VayAVjZ7J1ISLnbZj
         Z2QDgrAaXKqBfnagE7Ja7IscorV16wwRAAruVDNlHt2xZhhA1IbFdppke3Uoo3bejxMI
         b/l8SfuSCQ0FY/vwzxOL6abk/qjSp3oYT4sZ1ysUg+n+JMnEqYkjwtmJe0CYVq+h2TdF
         htKBzNcJLdVbfoFjjkVKoI14O9XD7CAEPNBQh/cF9ow97L24m3EvNrstW1VHqtqi/EAi
         mnZkm3KlhfS+TqXHDsUbiX49ln1Ij7hNUgZzFI/zLFOr4U5AcwWtz1X3qsRYgC4ZHH2f
         iEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rWuG5NeIc1o/ad5klAkavJ7HFtGU9PaK/EU9Glk/tKw=;
        b=ZH/eAe27NuPBtCTJFRzPDnwnCa2/0RLZj1Nz9S8YVRZVjUSEdbs0BVllfTI+1z+K6e
         Mp5vA26CWtP8NpRZY+kq6nYkNg1tn6BcjIVLXG6c/qW3PqFYZeZPvB8MwGODg1mHLPzW
         ivrnZM9NUzLUHO8B3QXJdhsnGiPRM6KMYT8CDPEiNFYXO1/QLXndF5rQ8dproC9OTUQc
         QDeuCUsr0nk39LFfwA9AEPAXF+qZDqLQQ33NV2zLcLOLtQd1dk8x1FiCi39cIibAttkK
         pxyvz0dKOwiNvEafyZFTBKG15ZynpO/P6pWTZpy0LCyZLSrQ/A28u1iuB38CzMdKZJn5
         /juw==
X-Gm-Message-State: AOAM532sapLnMGq2O7wT1xaaIk/Li4FYxv5cWV5dYWEcD3t0vnI9VErm
        Hjr7iS+8bSey70HvAvw8ZF5HBg==
X-Google-Smtp-Source: ABdhPJyQ+cekKtiDshFu5qbboMb9ko0+ZqNUwPVYvJjUx458DCCdyMl9xVyFjwKyT1+D6M/uxZ6B0w==
X-Received: by 2002:a05:6512:b26:: with SMTP id w38mr11467105lfu.152.1618823184183;
        Mon, 19 Apr 2021 02:06:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k5sm38284ljg.33.2021.04.19.02.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 02:06:23 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A07E3102567; Mon, 19 Apr 2021 12:06:22 +0300 (+03)
Date:   Mon, 19 Apr 2021 12:06:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v7 02/28] mm: Introduce struct folio
Message-ID: <20210419090622.bjz7flufdjiaou7k@box.shutemov.name>
References: <20210409185105.188284-1-willy@infradead.org>
 <20210409185105.188284-3-willy@infradead.org>
 <20210416155516.GM2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416155516.GM2531743@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 04:55:16PM +0100, Matthew Wilcox wrote:
> On Fri, Apr 09, 2021 at 07:50:39PM +0100, Matthew Wilcox (Oracle) wrote:
> > A struct folio is a new abstraction to replace the venerable struct page.
> > A function which takes a struct folio argument declares that it will
> > operate on the entire (possibly compound) page, not just PAGE_SIZE bytes.
> > In return, the caller guarantees that the pointer it is passing does
> > not point to a tail page.
> > +++ b/include/linux/mm_types.h
> [...]
> > +static inline struct folio *page_folio(struct page *page)
> > +{
> > +	unsigned long head = READ_ONCE(page->compound_head);
> > +
> > +	if (unlikely(head & 1))
> > +		return (struct folio *)(head - 1);
> > +	return (struct folio *)page;
> > +}
> 
> I'm looking at changing this for the next revision, and basing it on
> my recent patch to make compound_head() const-preserving:
> 
> +#define page_folio(page)       _Generic((page),                        \
> +       const struct page *:    (const struct folio *)_compound_head(page), \
> +       struct page *:          (struct folio *)_compound_head(page))
> 
> I've also noticed an awkward pattern occurring that I think this makes
> less awkward:
> 
> +/**
> + * folio_page - Return a page from a folio.
> + * @folio: The folio.
> + * @n: The page number to return.
> + *
> + * @n is relative to the start of the folio.  It should be between
> + * 0 and folio_nr_pages(@folio) - 1, but this is not checked for.
> + */
> +#define folio_page(folio, n)   nth_page(&(folio)->page, n)
> 
> That lets me simplify folio_next():
> 
> +static inline struct folio *folio_next(struct folio *folio)
> +{
> +       return (struct folio *)folio_page(folio, folio_nr_pages(folio));
> +}
> 
> (it occurs to me this should also be const-preserving, but it's not clear
> that's needed yet)

Are we risking that we would need to replace inline functions with macros
all the way down? Not sure const-preserving worth it.

-- 
 Kirill A. Shutemov
