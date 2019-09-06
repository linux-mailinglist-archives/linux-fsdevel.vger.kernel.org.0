Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B24AB9D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 15:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404520AbfIFNwS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 09:52:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44401 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404398AbfIFNwR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:52:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id p2so5191704edx.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 06:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pSwKQqKejHvomA4UPmYTw+LwVuiZyDGPrk1Lq89yOlc=;
        b=krIXjZuVxCJl33L5P7YERwE4VpW6UrHy0iuJSfbsUbAM2HhB6s8TIJj2x5Hf3zSSY1
         MGNmvNeJHedKm9o8yTZ4y3OWRnSZpy1E89bkh8N6KCZcGEvnUD2QDqGx4aWMI4mJGvcL
         Ppngok3/qzQFA60NDMu9y3Q2d+DBULexYZr3CRhAE2biifMMgReAKg2wLCahJVaZmLIe
         U6QyykZqKzBuNjnaOLd6b5CpCS7/4xcWLvjvu94C9WJ0MilQrePsupa948MD7IKO/fA+
         lBnIO/x45lK43GFvdSCfU7J+usjhIpohx3G5q9zUwCDJbMKC787DRIQfcSfSI0yFIUE6
         9ARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pSwKQqKejHvomA4UPmYTw+LwVuiZyDGPrk1Lq89yOlc=;
        b=su3D/Bk0bBmx4eY+kqB3fTJf64OwCWyZ/iG5HdkeY66HqgP3vhDyF8K+XefCwDkAdt
         KAHQ23WS8AYmYTP4xTehTTGoCgq0QQnu+HpYg6xXAtwdpDQCBJoHTzfaqpV1zMTkfArX
         p9Pbz1V+4OOYMfr+vH3GeK98aGFT5zKgChUWQy0Xr5oUS8JjMDdG/aLBD+XcM/3FfVAN
         HK6sVF4oIS5Bzg0OBHInH7SdX6Lb9jP9sAAIYdcHhoco+NOCXmkl8NkYDYypScLcFhyw
         SA4VOfdzR4BfQwSLmObB1OhfO71M5YRsSAuCQlrX3PoM+8z//7GHBuostEi8pbKv9a3w
         miBA==
X-Gm-Message-State: APjAAAUpk/BTnk5q9Glybe9Y65aBvXUXjDsS4EEqvh2h7JpwM32uTltC
        JaY77PCTCbKXMcmzB1dz2Kmn5Q==
X-Google-Smtp-Source: APXvYqw0w8tC1bR5JsQaeK6MSBWtjs6baFEFAYcol6N9qf3I0kpnA/iP0itaefwAoZGEL3PxWMG0Pg==
X-Received: by 2002:aa7:df1a:: with SMTP id c26mr9588705edy.106.1567777936212;
        Fri, 06 Sep 2019 06:52:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g6sm955486edk.40.2019.09.06.06.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 06:52:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4DA191049F1; Fri,  6 Sep 2019 16:52:15 +0300 (+03)
Date:   Fri, 6 Sep 2019 16:52:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH 3/3] mm: Allow find_get_page to be used for large pages
Message-ID: <20190906135215.f4qvsswrjaentvmi@box>
References: <20190905182348.5319-1-willy@infradead.org>
 <20190905182348.5319-4-willy@infradead.org>
 <20190906125928.urwopgpd66qibbil@box>
 <20190906134145.GW29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906134145.GW29434@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 06:41:45AM -0700, Matthew Wilcox wrote:
> On Fri, Sep 06, 2019 at 03:59:28PM +0300, Kirill A. Shutemov wrote:
> > > +/**
> > > + * __find_get_page - Find and get a page cache entry.
> > > + * @mapping: The address_space to search.
> > > + * @offset: The page cache index.
> > > + * @order: The minimum order of the entry to return.
> > > + *
> > > + * Looks up the page cache entries at @mapping between @offset and
> > > + * @offset + 2^@order.  If there is a page cache page, it is returned with
> > 
> > Off by one? :P
> 
> Hah!  I thought it reasonable to be ambiguous in the English description
> ...  it's not entirely uncommon to describe something being 'between A
> and B' when meaning ">= A and < B".

It is reasable. I was just a nitpick.

> > > +	if (compound_order(page) < order) {
> > > +		page = XA_RETRY_ENTRY;
> > > +		goto out;
> > > +	}
> > 
> > compound_order() is not stable if you don't have pin on the page.
> > Check it after page_cache_get_speculative().
> 
> Maybe check both before and after?  If we check it before, we don't bother
> to bump the refcount on a page which is too small.

Makes sense. False-positives should be rare enough to ignore them.

> > > @@ -1632,6 +1696,10 @@ EXPORT_SYMBOL(find_lock_entry);
> > >   * - FGP_FOR_MMAP: Similar to FGP_CREAT, only we want to allow the caller to do
> > >   *   its own locking dance if the page is already in cache, or unlock the page
> > >   *   before returning if we had to add the page to pagecache.
> > > + * - FGP_PMD: We're only interested in pages at PMD granularity.  If there
> > > + *   is no page here (and FGP_CREATE is set), we'll create one large enough.
> > > + *   If there is a smaller page in the cache that overlaps the PMD page, we
> > > + *   return %NULL and do not attempt to create a page.
> > 
> > Is it really the best inteface?
> > 
> > Maybe allow user to ask bitmask of allowed orders? For THP order-0 is fine
> > if order-9 has failed.
> 
> That's the semantics that filemap_huge_fault() wants.  If the page isn't
> available at order-9, it needs to return VM_FAULT_FALLBACK (and the VM
> will call into filemap_fault() to handle the regular sized fault).

Ideally, we should not have division between ->fault and ->huge_fault.
Integrating them together will give a shorter fallback loop and more
flexible inteface here would give benefit.

But I guess it's out-of-scope of the patchset.

-- 
 Kirill A. Shutemov
