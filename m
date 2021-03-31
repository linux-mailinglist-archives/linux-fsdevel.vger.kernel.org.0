Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D1B34F6FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 04:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhCaCtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 22:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbhCaCtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:49:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B19BC061574;
        Tue, 30 Mar 2021 19:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GNF6gUQ9773ceOlNU3m/mpbqKb9xhW/a2GyF7cConwU=; b=nRVKKIXaglkLCMARHOWC59RNot
        hTB/jGCE1di9WNFl31vMF72sUMsUy4EeOSwvYXrwtut6DtqP7N6z3Ful/+bZQjmO6d9C9yIMAcX1U
        74avSpgbRtc13i9xHbHKUO8DXG+inffHoyS+I0z8SN/KyORKV/KMCkY7etm1c4GgfdtotT+4Os9Fq
        QMGz/7kkVbOWdJNdnm40VF6QodjkWjzfcPe4LVJcnyqy65abSOy7F+HAx+X5zpJM0rY0A6KZqVcF2
        N6pfa1MIrJFGXCs2eHW13PisFNru6dNbLRbgY3WeOZ1iyhFkFEtl4DbPwhB35Hozi8CtPZ+v+Cnzy
        +IQXQSPg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRQuv-003vev-Iv; Wed, 31 Mar 2021 02:49:20 +0000
Date:   Wed, 31 Mar 2021 03:49:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!mapping_empty(&inode->i_data))
Message-ID: <20210331024913.GS351017@casper.infradead.org>
References: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 06:30:22PM -0700, Hugh Dickins wrote:
> Running my usual tmpfs kernel builds swapping load, on Sunday's rc4-mm1
> mmotm (I never got to try rc3-mm1 but presume it behaved the same way),
> I hit clear_inode()'s BUG_ON(!mapping_empty(&inode->i_data)); on two
> machines, within an hour or few, repeatably though not to order.
> 
> The stack backtrace has always been clear_inode < ext4_clear_inode <
> ext4_evict_inode < evict < dispose_list < prune_icache_sb <
> super_cache_scan < do_shrink_slab < shrink_slab_memcg < shrink_slab <
> shrink_node_memgs < shrink_node < balance_pgdat < kswapd.
> 
> ext4 is the disk filesystem I read the source to build from, and also
> the filesystem I use on a loop device on a tmpfs file: I have not tried
> with other filesystems, nor checked whether perhaps it happens always on
> the loop one or always on the disk one.  I have not seen it happen with
> tmpfs - probably because its inodes cannot be evicted by the shrinker
> anyway; I have not seen it happen when "rm -rf" evicts ext4 or tmpfs
> inodes (but suspect that may be down to timing, or less pressure).
> I doubt it's a matter of filesystem: think it's an XArray thing.
> 
> Whenever I've looked at the XArray nodes involved, the root node
> (shift 6) contained one or three (adjacent) pointers to empty shift
> 0 nodes, which each had offset and parent and array correctly set.
> Is there some way in which empty nodes can get left behind, and so
> fail eviction's mapping_empty() check?

There isn't _supposed_ to be.  The XArray is supposed to delete nodes
whenever the ->count reaches zero.  It might give me a clue if you could
share a dump of the tree, if you still have that handy.

> I did wonder whether some might get left behind if xas_alloc() fails
> (though probably the tree here is too shallow to show that).  Printks
> showed that occasionally xas_alloc() did fail while testing (maybe at
> memcg limit), but there was no correlation with the BUG_ONs.

This is a problem inherited from the radix tree, and I really want to
justify fixing it ... I think I may have enough infrastructure in place
to do it now (as part of the xas_split() commit we can now allocate
multiple xa_nodes in xas->xa_alloc).  But you're right; if we allocated
all the way down to an order-0 node, then this isn't the bug.

Were you using the ALLOW_ERROR_INJECTION feature on
__add_to_page_cache_locked()?  I haven't looked into how that works,
and maybe that could leave us in an inconsistent state.

> I did wonder whether this is a long-standing issue, which your new
> BUG_ON is the first to detect: so tried 5.12-rc5 clear_inode() with
> a BUG_ON(!xa_empty(&inode->i_data.i_pages)) after its nrpages and
> nrexceptional BUG_ONs.  The result there surprised me: I expected
> it to behave the same way, but it hits that BUG_ON in a minute or
> so, instead of an hour or so.  Was there a fix you made somewhere,
> to avoid the BUG_ON(!mapping_empty) most of the time? but needs
> more work. I looked around a little, but didn't find any.

I didn't make a fix for this issue; indeed I haven't observed it myself.
It seems like cgroups are a good way to induce allocation failures, so
I should play around with that a bit.  The userspace test-suite has a
relatively malicious allocator that will fail every allocation not marked
as GFP_KERNEL, so it always exercises the fallback path for GFP_NOWAIT,
but then it will always succeed eventually.

> I had hoped to work this out myself, and save us both some writing:
> but better hand over to you, in the hope that you'll quickly guess
> what's up, then I can try patches. I do like the no-nrexceptionals
> series, but there's something still to be fixed.

Agreed.  It seems like it's unmasking a bug that already existed, so
it's not an argument for dropping the series, but we should fix the bug
so we don't crash people's machines.

Arguably, the condition being checked for is not serious enough for a
BUG_ON.  A WARN_ON, yes, and dump the tree for later perusal, but it's
just a memory leak, and not (I think?) likely to lead to later memory
corruption.  The nodes don't contain any pages, so there's nothing to
point to the mapping.
