Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB813F9F1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 20:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhH0SrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 14:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhH0SrC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 14:47:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A72C061757;
        Fri, 27 Aug 2021 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TmIFGLuzR5TKf3tBpVDD04JlWgwoS6T72CAQ6nPDOIw=; b=ut6u+4w3fu6/PUU3PCNobyymP5
        iovfucrUkllD1i8f2h2sv2LvTP3XLNPka4S2GwsmI3JC8YBGZMJ8Cn2JZIMax7T1sY5GZfbUssQBM
        LAlNGyy1wDNq6BLXk8uHoEtiZux4t6gBBpuw8YLLJ8rmOE/OaGdB1a9wTD2jhLU7Lt0lGVvDLfgdM
        pTzYqSoTXIaBMd/N1A767I/LRyy7Xaxi2/U4DdUh3E4DIZivssGA1We+VIN+4JTBVF493wj0ArTLA
        ff7hVDqdxNw6HipwmczrPP3Ea/3XbtUSBkB/219pFEgysx9EhmbasfcniBLGqNpZS7JZBozf+A+Fx
        d0qVmVzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJgq5-00Esn6-Ln; Fri, 27 Aug 2021 18:44:52 +0000
Date:   Fri, 27 Aug 2021 19:44:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSkyjcX9Ih816mB9@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YSQeFPTMn5WpwyAa@casper.infradead.org>
 <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
 <YSVMAS2pQVq+xma7@casper.infradead.org>
 <YSZeKfHxOkEAri1q@cmpxchg.org>
 <20210826004555.GF12597@magnolia>
 <YSjxlNl9jeEX2Yff@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSjxlNl9jeEX2Yff@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 10:07:16AM -0400, Johannes Weiner wrote:
> We have the same thoughts in MM and growing memory sizes. The DAX
> stuff said from the start it won't be built on linear struct page
> mappings anymore because we expect the memory modules to be too big to
> manage them with such fine-grained granularity.

Well, I did.  Then I left Intel, and Dan took over.  Now we have a struct
page for each 4kB of PMEM.  I'm not particularly happy about this change
of direction.

> But in practice, this
> is more and more becoming true for DRAM as well. We don't want to
> allocate gigabytes of struct page when on our servers only a very
> small share of overall memory needs to be managed at this granularity.

This is a much less compelling argument than you think.  I had some
ideas along these lines and I took them to a performance analysis group.
They told me that for their workloads, doubling the amount of DRAM in a
system increased performance by ~10%.  So increasing the amount of DRAM
by 1/63 is going to increase performance by 1/630 or 0.15%.  There are
more important performance wins to go after.

Even in the cloud space where increasing memory by 1/63 might increase the
number of VMs you can host by 1/63, how many PMs host as many as 63 VMs?
ie does it really buy you anything?  It sounds like a nice big number
("My 1TB machine has 16GB occupied by memmap!"), but the real benefit
doesn't really seem to be there.  And of course, that assumes that you
have enough other resources to scale to 64/63 of your current workload;
you might hit CPU, IO or some other limit first.

> Folio perpetuates the problem of the base page being the floor for
> cache granularity, and so from an MM POV it doesn't allow us to scale
> up to current memory sizes without horribly regressing certain
> filesystem workloads that still need us to be able to scale down.

The mistake you're making is coupling "minimum mapping granularity" with
"minimum allocation granularity".  We can happily build a system which
only allocates memory on 2MB boundaries and yet lets you map that memory
to userspace in 4kB granules.

> I really don't think it makes sense to discuss folios as the means for
> enabling huge pages in the page cache, without also taking a long hard
> look at the allocation model that is supposed to back them. Because
> you can't make it happen without that. And this part isn't looking so
> hot to me, tbh.

Please, don't creep the scope of this project to "first, redesign
the memory allocator".  This project is _if we can_, use larg(er)
pages to cache files.  What Darrick is talking about is an entirely
different project that I haven't signed up for and won't.

> Willy says he has future ideas to make compound pages scale. But we
> have years of history saying this is incredibly hard to achieve - and
> it certainly wasn't for a lack of constant trying.

I genuinely don't understand.  We have five primary users of memory
in Linux (once we're in a steady state after boot):

 - Anonymous memory
 - File-backed memory
 - Slab
 - Network buffers
 - Page tables

The relative importance of each one very much depends on your workload.
Slab already uses medium order pages and can be made to use larger.
Folios should give us large allocations of file-backed memory and
eventually anonymous memory.  Network buffers seem to be headed towards
larger allocations too.  Page tables will need some more thought, but
once we're no longer interleaving file cache pages, anon pages and
page tables, they become less of a problem to deal with.

Once everybody's allocating order-4 pages, order-4 pages become easy
to allocate.  When everybody's allocating order-0 pages, order-4 pages
require the right 16 pages to come available, and that's really freaking
hard.
