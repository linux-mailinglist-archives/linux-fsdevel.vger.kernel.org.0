Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A8133A267
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Mar 2021 03:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhCNCb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 21:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhCNCbG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 21:31:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BF8C061574;
        Sat, 13 Mar 2021 18:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EnE50NkSknnpue15HbJ3Qi37ZMK01SdHagRrgb71jbQ=; b=RDqSNWQOJC9ALFwiP8EzZw1Fny
        m3YZL6xxDoiMlJGN5E2sZyaQRBn9fJsIzYKR6tN+gXo0nqmELhdF/L5OD9UamPloc4J4vel9S6xRM
        EXq4ETP03jM5h+ICgwNm1EqvBr0wnKgbU5NxJlR0W+00ruNU0Lc+rrFS+S8spYKJCPo/8g4WUEKUf
        TejesuB3jUJtfc7Ani/rLlkAceaaeCXGF3JV2f7VlZiUFELUl+rbqBgZRBUW4F4fTxUkEkLVmM8sV
        KqYSmVLCtJRKJpNbL8rLRdm3ayBw8Ud4bWnsPVo2DDuQcB2v7r/brxNG5giPsbFXQo0D6W7jBJ3ut
        XTP3Cmeg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLGWf-00FPfH-UA; Sun, 14 Mar 2021 02:30:45 +0000
Date:   Sun, 14 Mar 2021 02:30:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/25] Page folios
Message-ID: <20210314023041.GM2577561@casper.infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210313123658.ad2dcf79a113a8619c19c33b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313123658.ad2dcf79a113a8619c19c33b@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 13, 2021 at 12:36:58PM -0800, Andrew Morton wrote:
> On Fri,  5 Mar 2021 04:18:36 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > Our type system does not currently distinguish between tail pages and
> > head or single pages.  This is a problem because we call compound_head()
> > multiple times (and the compiler cannot optimise it out), bloating the
> > kernel.  It also makes programming hard as it is often unclear whether
> > a function operates on an individual page, or an entire compound page.
> > 
> > This patch series introduces the struct folio, which is a type that
> > represents an entire compound page.  This initial set reduces the kernel
> > size by approximately 6kB, although its real purpose is adding
> > infrastructure to enable further use of the folio.
> 
> Geeze it's a lot of noise.  More things to remember and we'll forever
> have a mismash of `page' and `folio' and code everywhere converting
> from one to the other.  Ongoing addition of folio
> accessors/manipulators to overlay the existing page
> accessors/manipulators, etc.
> 
> It's unclear to me that it's all really worth it.  What feedback have
> you seen from others?

Mmm.  The thing is, the alternative is ongoing bugs.  And inefficiencies.
Today, we have code everywhere converting from tail pages to head pages
-- we just don't notice it because it's all wrapped up in macros.  I
have over 10kB in text size reductions in my tree (yes, it's a monster
series of patches), almost all from removing those conversions.  And
it's far from done.

And these conversions are all in hot paths, like handling page faults
and read().  For example:

filemap_fault                               1980    1289    -691

it's two-thirds the size it was!  Surely that's not all in the hot path,
but still it's going to have some kind of effect.

As well, we have code today that _looks_ right but is buggy.  Take a
look at vfs_dedupe_file_range_compare().  There's nothing wrong with
it at first glance, until you realise that vfs_dedupe_get_page() might
return a tail page, and you can't look at page->mapping for a tail page.
Nor page->index, so vfs_lock_two_pages() is also broken.

As far as feedback, I really want more.  Particularly from filesystem
people.  I don't think a lot of them realise yet that I'm going to change
15 of the 22 address_space_ops to work with folios instead of pages.
Individual filesystems can keep working with pages, of course, until
they enable the "use multipage folios" bit.
