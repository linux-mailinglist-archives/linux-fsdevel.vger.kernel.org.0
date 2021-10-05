Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C80D4229F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 16:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhJEOFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 10:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbhJEOEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:04:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426DCC09427F;
        Tue,  5 Oct 2021 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fPliqX+4y/fXYKkrPsdcJN5EsDLXmdXa3jrI3RxuZqo=; b=HWNkq0kUiHpUTPpZafcDeNnk43
        lkwTkf/5ITfsDQOECQdIGNOHHYcRVdjV/7W4WGkVi9lmiM7NQkiG4vJL148Qg/kaLh1urI/5lFSy2
        z5d2Ry0WkueUJLM80zgcGTQ9BR6Jr71tVs9UHjeHnn6YFLrEI9dApUnQVPajkltcj3+VWsvHNvGn7
        kgkiPHsiY0DkUSROcMdMGdfYsDtu+8geX3OxcYJRpwtoEntkZf7c6vhTB+ww87EwDRgefqg0294kb
        3Pv0wDaTD0pFucG/MuxqfjQedQMHHFECN2QrfQpzeTpsMzZgnbGKvc47H25ofF66k92entMll6Nbm
        OwCmf/dg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXkrR-000VHF-9k; Tue, 05 Oct 2021 13:52:41 +0000
Date:   Tue, 5 Oct 2021 14:52:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YVxYgQa1cECYMtOL@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSQSkSOWtJCE4g8p@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 23, 2021 at 05:26:41PM -0400, Johannes Weiner wrote:
> One one hand, the ambition appears to substitute folio for everything
> that could be a base page or a compound page even inside core MM
> code. Since there are very few places in the MM code that expressly
> deal with tail pages in the first place, this amounts to a conversion
> of most MM code - including the LRU management, reclaim, rmap,
> migrate, swap, page fault code etc. - away from "the page".
> 
> However, this far exceeds the goal of a better mm-fs interface. And
> the value proposition of a full MM-internal conversion, including
> e.g. the less exposed anon page handling, is much more nebulous. It's
> been proposed to leave anon pages out, but IMO to keep that direction
> maintainable, the folio would have to be translated to a page quite
> early when entering MM code, rather than propagating it inward, in
> order to avoid huge, massively overlapping page and folio APIs.

Here's an example where our current confusion between "any page"
and "head page" at least produces confusing behaviour, if not an
outright bug, isolate_migratepages_block():

                page = pfn_to_page(low_pfn);
...
                if (PageCompound(page) && !cc->alloc_contig) {
                        const unsigned int order = compound_order(page);

                        if (likely(order < MAX_ORDER))
                                low_pfn += (1UL << order) - 1;
                        goto isolate_fail;
                }

compound_order() does not expect a tail page; it returns 0 unless it's
a head page.  I think what we actually want to do here is:

		if (!cc->alloc_contig) {
			struct page *head = compound_head(page);
			if (PageHead(head)) {
				const unsigned int order = compound_order(head);

				low_pfn |= (1UL << order) - 1;
				goto isolate_fail;
			}
		}

Not earth-shattering; not even necessarily a bug.  But it's an example
of the way the code reads is different from how the code is executed,
and that's potentially dangerous.  Having a different type for tail
and not-tail pages prevents the muddy thinking that can lead to
tail pages being passed to compound_order().
