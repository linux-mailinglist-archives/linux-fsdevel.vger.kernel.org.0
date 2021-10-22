Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4804377A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 15:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhJVNHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 09:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhJVNHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 09:07:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F98EC061764;
        Fri, 22 Oct 2021 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ceLFPSG9PwcNCS8a9ytFESTTipwib/6u0uhFzDsr/gQ=; b=hgK8dCxE5kiokMvHI8BrX1mKtt
        uSTgVRfw2SS+zqxcRwMvTW7KsBE/5jLZEwn7AeRau+yKPd1kXQhEaiCKERpKcUoIf65Hgw2fKllDe
        X05UHY/6IxtRHvBUa6xESlRKmUvsDTvbpwqKsu2TTiJrpx/TWKgfjhNL/i1V8yORkgaF+1HUu9Eyy
        kaJ9MLr18hdFV8TQYMgTUAj6vDgEJq993PdZtFSnDG4u88Zz1tykYo1vObr+OkkgLMJOIqRk++3Qt
        YVEoSTdIIbxsgYnMb1pxKO6NR9yz0ZoQsngHLniDwUpyBKIbGuggTXS41E9+zyymcnk8AlPvFWs6q
        j2CF7SGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mduAi-00Dud6-RP; Fri, 22 Oct 2021 13:01:52 +0000
Date:   Fri, 22 Oct 2021 14:01:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YXK2ICKi6fjNfr4X@casper.infradead.org>
References: <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <YXBUPguecSeSO6UD@moria.home.lan>
 <YXHdpQTL1Udz48fc@cmpxchg.org>
 <YXIZX0truEBv2YSz@casper.infradead.org>
 <326b5796-6ef9-a08f-a671-4da4b04a2b4f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <326b5796-6ef9-a08f-a671-4da4b04a2b4f@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 09:59:05AM +0200, David Hildenbrand wrote:
> something like this would roughly express what I've been mumbling about:
> 
> anon_mem    file_mem
>    |            |
>    ------|------
>       lru_mem       slab
>          |           |
>          -------------
>                |
> 	      page
> 
> I wouldn't include folios in this picture, because IMHO folios as of now
> are actually what we want to be "lru_mem", just which a much clearer
> name+description (again, IMHO).

I think folios are a superset of lru_mem.  To enhance your drawing:

page
   folio
      lru_mem
         anon_mem
	 ksm
         file_mem
      netpool
      devmem
      zonedev
   slab
   pgtable
   buddy
   zsmalloc
   vmalloc

I have a little list of memory types here:
https://kernelnewbies.org/MemoryTypes

Let me know if anything is missing.

> Going from file_mem -> page is easy, just casting pointers.
> Going from page -> file_mem requires going to the head page if it's a
> compound page.
> 
> But we expect most interfaces to pass around a proper type (e.g.,
> lru_mem) instead of a page, which avoids having to lookup the compund
> head page. And each function can express which type it actually wants to
> consume. The filmap API wants to consume file_mem, so it should use that.
> 
> And IMHO, with something above in mind and not having a clue which
> additional layers we'll really need, or which additional leaves we want
> to have, we would start with the leaves (e.g., file_mem, anon_mem, slab)
> and work our way towards the root. Just like we already started with slab.

That assumes that the "root" layers already handle compound pages
properly.  For example, nothing in mm/page-writeback.c does; it assumes
everything is an order-0 page.  So working in the opposite direction
makes sense because it tells us what has already been converted and is
thus safe to call.

And starting with file_mem makes the supposition that it's worth splitting
file_mem from anon_mem.  I believe that's one or two steps further than
it's worth, but I can be convinced otherwise.  For example, do we have
examples of file pages being passed to routines that expect anon pages?
Most routines that I've looked at expect to see both file & anon pages,
and treat them either identically or do slightly different things.
But those are just the functions I've looked at; your experience may be
quite different.
