Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BCD3F5347
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 00:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhHWWRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 18:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbhHWWRc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:17:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5C6C061575;
        Mon, 23 Aug 2021 15:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pVjiEy2fsTH4DnOyPDw2jxP691ZcqhnaXmaTSEFlHYE=; b=TxHua4Xuhg/eP92Su3OzAwUKWO
        G8d0t5Z1o21ISerIBJFo7Cr5TGhmIOLY1kdkepo7u+AFwbkX4k4s+Jyw74nj2LoaP61aI9rM8WZpY
        WQzsJ8yUBQcvBDdRW3pKMJBaRVHBr9euhguNbp/00chI7cca+7lRzxsrPqGbE3RrH9yTKWwc/SyOc
        nhACC7Z7CmsPr1l1hK+LNT+YyI45ETO0pHbGgbre0QJ/cHcMKOQAxwJShdw8I6a8dhWnQeJhY/1t0
        KjRFp2dxW/X8cmwCZV6YYY/SbG2GzmbLZ/iN8SWyl8jRcQuB/yZo6KIoSBZEJyIuO3gNWFD026Rko
        H4783giQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIIEO-00AFuA-Ur; Mon, 23 Aug 2021 22:15:57 +0000
Date:   Mon, 23 Aug 2021 23:15:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSQeFPTMn5WpwyAa@casper.infradead.org>
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
> On Mon, Aug 23, 2021 at 08:01:44PM +0100, Matthew Wilcox wrote:
> Just to clarify, I'm only on this list because I acked 3 smaller,
> independent memcg cleanup patches in this series. I have repeatedly
> expressed strong reservations over folios themselves.

I thought I'd addressed all your concerns.  I'm sorry I misunderstood
and did not intend to misrepresent your position.

> The arguments for a better data interface between mm and filesystem in
> light of variable page sizes are plentiful and convincing. But from an
> MM point of view, it's all but clear where the delineation between the
> page and folio is, and what the endgame is supposed to look like.
> 
> One one hand, the ambition appears to substitute folio for everything
> that could be a base page or a compound page even inside core MM
> code. Since there are very few places in the MM code that expressly
> deal with tail pages in the first place, this amounts to a conversion
> of most MM code - including the LRU management, reclaim, rmap,
> migrate, swap, page fault code etc. - away from "the page".

I would agree with all of those except the page fault code; I believe
that needs to continue to work in terms of pages in order to support
misaligned mappings.

> However, this far exceeds the goal of a better mm-fs interface. And
> the value proposition of a full MM-internal conversion, including
> e.g. the less exposed anon page handling, is much more nebulous. It's
> been proposed to leave anon pages out, but IMO to keep that direction
> maintainable, the folio would have to be translated to a page quite
> early when entering MM code, rather than propagating it inward, in
> order to avoid huge, massively overlapping page and folio APIs.

I only intend to leave anonymous memory out /for now/.  My hope is
that somebody else decides to work on it (and indeed Google have
volunteered someone for the task).

> It's also not clear to me that using the same abstraction for compound
> pages and the file cache object is future proof. It's evident from
> scalability issues in the allocator, reclaim, compaction, etc. that
> with current memory sizes and IO devices, we're hitting the limits of
> efficiently managing memory in 4k base pages per default. It's also
> clear that we'll continue to have a need for 4k cache granularity for
> quite a few workloads that work with large numbers of small files. I'm
> not sure how this could be resolved other than divorcing the idea of a
> (larger) base page from the idea of cache entries that can correspond,
> if necessary, to memory chunks smaller than a default page.

That sounds to me exactly like folios, except for the naming.  From the
MM point of view, it's less churn to do it your way, but from the
point of view of the rest of the kernel, there's going to be unexpected
consequences.  For example, btrfs didn't support page size != block size
until just recently (and I'm not sure it's entirely fixed yet?)

And there's nobody working on your idea.  At least not that have surfaced
so far.  The folio patch is here now.

Folios are also variable sized.  For files which are small, we still only
allocate 4kB to cache them.  If the file is accessed entirely randomly,
we only allocate 4kB chunks at a time.  We only allocate larger folios
when we think there is an advantage to doing so.

This benefit is retained if someone does come along to change PAGE_SIZE
to 16KiB (or whatever).  Folios can still be composed of multiple pages,
no matter what the PAGE_SIZE is.

> A longer thread on that can be found here:
> https://lore.kernel.org/linux-fsdevel/YFja%2FLRC1NI6quL6@cmpxchg.org/
> 
> As an MM stakeholder, I don't think folios are the answer for MM code.
