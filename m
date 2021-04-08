Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFFD358F23
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 23:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhDHVaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 17:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbhDHVaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:30:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B53C061760;
        Thu,  8 Apr 2021 14:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FMwsbzIx2vhE3AUqGng1fDydGgdG4KsD5JUXQdwoJ+w=; b=ZxjfWMBPLVX108xUoD3fxC9LtV
        GXYGhxpBrxOZBsUh44HUWr/CHWB9mc+dHoAoJXCPYBBcg6r9FWxoWze7gYmBh/InxbGY+oZiib2/e
        uSiPXADkWIuCB7BPPYc8jAI8K5299K4EmEGVIsMuhq6WN6HzH44P5V6ehuhmAYrlbvRIpvlkZj3QB
        vMAlYFJ0RSwGbaABVxZ55vWznbJtOhiytyUr8lsGvOGsVUjuqNqgv3OmXc6nD2marT8BrKu+l3du0
        2Ll4ZUu8wtjpPHQ15i/yRYnEFgA52ZX9NSdHi71qA4xU4ABcomSEwgISzH37BDAugOThzCej9KTH4
        ou83SQiw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUcDP-00Gtps-RP; Thu, 08 Apr 2021 21:29:33 +0000
Date:   Thu, 8 Apr 2021 22:29:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, hannes@cmpxchg.org,
        yhs@fb.com
Subject: Re: [RFC bpf-next 1/1] bpf: Introduce iter_pagecache
Message-ID: <20210408212927.GQ2531743@casper.infradead.org>
References: <cover.1617831474.git.dxu@dxuuu.xyz>
 <22bededbd502e0df45326a54b3056941de65a101.1617831474.git.dxu@dxuuu.xyz>
 <20210408061401.GI2531743@casper.infradead.org>
 <20210408194849.wmueo74qcxghhf2d@dlxu-fedora-R90QNFJV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408194849.wmueo74qcxghhf2d@dlxu-fedora-R90QNFJV>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 12:48:49PM -0700, Daniel Xu wrote:
> No reason other than I didn't know about the latter. Thanks for the
> hint. find_get_entries() seems to return a pagevec of entries which
> would complicate the iteration (a 4th layer of things to iterate over).
> 
> But I did find find_get_pages_range() which I think can be used to find
> 1 page at a time. I'll look into it further.

Please don't, that's going to be a pagevec too.

> > I'm not really keen on the idea of random BPF programs being able to poke
> > at pages in the page cache like this.  From your initial description,
> > it sounded like all you needed was a list of which pages are present.
> 
> Could you elaborate on what "list of which pages are present" implies?
> The overall goal with this patch is to detect duplicate content in the
> page cache. So anything that helps achieve that goal I would (in theory)
> be OK with.
> 
> My understanding is the user would need to hash the contents
> of each page in the page cache. And BPF provides the flexibility such
> that this work could be reused for currently unanticipated use cases.

But if you need the contents, then you'll need to kmap() the pages.
I don't see people being keen on exposing kmap() to bpf either.  I think
you're much better off providing an interface that returns a hash of
each page to the BPF program.

> Furthermore, bpf programs could already look at all the pages in the
> page cache by hooking into tracepoint:filemap:mm_filemap_add_to_page_cache,
> albeit at a much slower rate. I figure the downside of adding this
> page cache iterator is we're explicitly condoning the behavior.

That should never have been exposed.  It's only supposed to be for error
injection.  If people have started actually using it for something,
then it's time we delete that tracepoint.

> The idea behind the radix tree was to deduplicate the mounts by
> superblock. Because a single filesystem may be mounted in different
> locations. I didn't find a set data structure I could reuse so I
> figured radix tree / xarray would work too.
> 
> Happy to take any better ideas too.
> 
> > If you don't understand why this is so bad, call xa_dump() on it after
> > constructing it.  I'll wait.
> 
> I did a dump and got the following results: http://ix.io/2VpY .
> 
> I receieved a hint that you may be referring to how the xarray/radix
> tree would be as large as the largest pointer. To my uneducated eye it
> doesn't look like that's the case in this dump. Could you please
> clarify?

We get seven nodes per 4kB page.

$ grep -c 'value 0' 2VpY 
15
$ grep -c node 2VpY 
43

so we use 6+1/7 pages in order to store 15 values.  That's 387 cache
lines, for the amount of data that could fit in two.

Liam and I are working on a data structure that would support doing
something along these lines in an efficient manner, but it's not
ready yet.
