Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBC92A76B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 05:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbgKEEwS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 23:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731609AbgKEEwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 23:52:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4F8C0613D2
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 20:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u6fBPwyTRrh+e2Eau2U5HFdwEzK88/S/i+bqRXzF+iI=; b=k+BmWiuGzGI7gXLcnZjxHItpwg
        R1gNDzPH/0UXy7SfP/8ESnvhv8qd/sj7eTDeaJl+uUPn/TxRIP78RcoX7LVxxgTxanHKduaB4scj0
        qLueyIo3q2TapJXs1OeLgzAMi1ogX4/dOSI+2EE7YTopN5ZL4uVWDp4ooPuZuk1Q5g2EtprMo72AV
        cC7O3sXEUOYZIDWwzIFsL8VhHiPENYG2osO2IjCU3ql1wbt1buXw+tlG5Ex6snPLqtGz4xklSa4kK
        V4yKSYOVUuefsHC3QEl8uagiAbTWOQK8a2zipolFOQdWYWqhZaU/0NojTu9vx/umMOljXOwmUPea+
        PshdfcCw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaXFu-00030d-I8; Thu, 05 Nov 2020 04:52:14 +0000
Date:   Thu, 5 Nov 2020 04:52:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH v2 02/18] mm/filemap: Remove dynamically allocated array
 from filemap_read
Message-ID: <20201105045214.GH17076@casper.infradead.org>
References: <20201104204219.23810-1-willy@infradead.org>
 <20201104204219.23810-3-willy@infradead.org>
 <20201104213005.GB3365678@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104213005.GB3365678@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 04, 2020 at 04:30:05PM -0500, Kent Overstreet wrote:
> On Wed, Nov 04, 2020 at 08:42:03PM +0000, Matthew Wilcox (Oracle) wrote:
> > Increasing the batch size runs into diminishing returns.  It's probably
> > better to make, eg, three calls to filemap_get_pages() than it is to
> > call into kmalloc().
> 
> I have to disagree. Working with PAGEVEC_SIZE pages is eventually going to be
> like working with 4k pages today, and have you actually read the slub code for
> the kmalloc fast path? It's _really_ fast, there's no atomic operations and it
> doesn't even have to disable preemption - which is why you never see it showing
> up in profiles ever since we switched to slub.

I've been puzzling over this, and trying to run some benchmarks to figure
it out.  My test VM is too noisy though; the error bars are too large to
get solid data.

There are three reasons why I think we hit diminishing returns:

1. Cost of going into the slab allocator (one alloc, one free).
Maybe that's not as high as I think it is.

2. Let's say the per-page overhead of walking i_pages is 10% of the
CPU time for a 128kB I/O with a batch size of 1.  Increasing the batch
size to 15 means we walk the array 3 times instead of 32 times, or 0.7%
of the CPU time -- total reduction in CPU time of 9.3%.  Increasing the
batch size to 32 means we only walk the array once, which cuts it down
from 10% to 0.3% -- reduction in CPU time of 9.7%.

If we are doing 2MB I/Os (and most applications I've looked at recently
only do 128kB), and the 10% remains constant, then the batch-size-15
case walks the tree 17 times instead of 512 times -- 0.6%, whereas the
batch-size-512 case walks the tree once -- 0.02%.  But that only loks
like an overall savings of 9.98% versus 9.4%.  And is an extra 0.6%
saving worth it?

3. By the time we're doing such large I/Os, we're surely dominated by
memcpy() and not walking the tree.  Even if the file you're working on
is a terabyte in size, the radix tree is only 5 layers deep.  So that's
five pointer dereferences to find the struct page, and they should stay
in cache (maybe they'd fall out to L2, but surely not as far as L3).
And generally radix tree cachelines stay clean so there shouldn't be any
contention on them from other CPUs unless they're dirtying the pages or
writing them back.

