Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DA4380F3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 19:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhENRuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 13:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbhENRuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 13:50:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DE8C061574;
        Fri, 14 May 2021 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2pAe91SWzc/6riCJTnq7kqxW30iWZ5ZzX7m8q/+xTL0=; b=pxBgiq2xmX4brOJjhFnslcv0it
        MmKEA6uhuUypxWEc3UG6F1Wp650xb/5yQzn09Tqc9aJ4pnsXBpgk2zl5T/eiWto8mOykLDJ1lbnf1
        6ZyM7o7qGX3h6fHDf5e2mcVTXr2BCpli8AJsT2vKKgaWdmw6EAZbo4LtKmdz5VmuJAeyJ/kdfOuj7
        4b9SOEQPkp96VlcfvuqnozuLOQ3koM0kxl6BiARLyqvR/gq2ISejZm3FjS6N027kuaqQdSfAQSV72
        y2x/473TwS/oB+ykEC+G0nCJblIVfUMF9LU+lz/5Gn+n9u0pXX+cUIhlqb5WhazNmPjaYln0v3z4b
        eyqkiIBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lhbvG-00AaXL-9i; Fri, 14 May 2021 17:48:31 +0000
Date:   Fri, 14 May 2021 18:48:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] Memory folios
Message-ID: <YJ636tQhuc9X7ZzR@casper.infradead.org>
References: <YJlzwcADaxO/JHRE@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJlzwcADaxO/JHRE@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 06:56:17PM +0100, Matthew Wilcox wrote:
> I don't know exactly how much will be left to discuss about supporting
> larger memory allocation units in the page cache by December.  In my
> ideal world, all the patches I've submitted so far are accepted, I
> persuade every filesystem maintainer to convert their own filesystem
> and struct page is nothing but a bad memory by December.  In reality,
> I'm just not that persuasive.
> 
> So, probably some kind of discussion will be worthwhile about
> converting the remaining filesystems to use folios, when it's worth
> having filesystems opt-in to multi-page folios, what we can do about
> buffer-head based filesystems, and so on.
> 
> Hopefully we aren't still discussing whether folios are a good idea
> or not by then.

I got an email from Hannes today asking about memory folios as they
pertain to the block layer, and I thought this would be a good chance
to talk about them.  If you're not familiar with the term "folio",
https://lore.kernel.org/lkml/20210505150628.111735-10-willy@infradead.org/
is not a bad introduction.

Thanks to the work done by Ming Lei in 2017, the block layer already
supports multipage bvecs, so to a first order of approximation, I don't
need anything from the block layer on down through the various storage
layers.  Which is why I haven't been talking to anyone in storage!

It might change (slightly) the contents of bios.  For example,
bvec[n]->bv_offset might now be larger than PAGE_SIZE.  Drivers should
handle this OK, but probably haven't been audited to make sure they do.
Mostly, it's simply that drivers will now see fewer, larger, segments
in their bios.  Once a filesystem supports multipage folios, we will
allocate order-N pages as part of readahead (and sufficiently large
writes).  Dirtiness is tracked on a per-folio basis (not per page),
so folios take trips around the LRU as a single unit and finally make
it to being written back as a single unit.

Drivers still need to cope with sub-folio-sized reads and writes.
O_DIRECT still exists and (eg) doing a sub-page, block-aligned write
will not necessarily cause readaround to happen.  Filesystems may read
and write their own metadata at whatever granularity and alignment they
see fit.  But the vast majority of pagecache I/O will be folio-sized
and folio-aligned.

I do have two small patches which make it easier for the one
filesystem that I've converted so far (iomap/xfs) to add folios to bios
and get folios back out of bios:

https://lore.kernel.org/lkml/20210505150628.111735-72-willy@infradead.org/
https://lore.kernel.org/lkml/20210505150628.111735-73-willy@infradead.org/

as well as a third patch that estimates how large a bio to allocate,
given the current folio that it's working on:
https://git.infradead.org/users/willy/pagecache.git/commitdiff/89541b126a59dc7319ad618767e2d880fcadd6c2

It would be possible to make other changes in future.  For example, if
we decide it'd be better, we could change bvecs from being (page, offset,
length) to (folio, offset, length).  I don't know that it's worth doing;
it would need to be evaluated on its merits.  Personally, I'd rather
see us move to a (phys_addr, length) pair, but I'm a little busy at the
moment.

Hannes has some fun ideas about using the folio work to support larger
sector sizes, and I think they're doable.
