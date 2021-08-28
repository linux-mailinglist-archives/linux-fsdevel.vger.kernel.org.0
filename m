Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF403FA747
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 21:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhH1TF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 15:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhH1TF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 15:05:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C8AC061756;
        Sat, 28 Aug 2021 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=TuHgCRXfj8vRtIl2JCrQ2TAdDZ4HQm6n8/xX2K1UOSw=; b=XD2wEWxFFz9GVLE/bKHQCVY6ZB
        bEqI392gY7gLHgdyf1aCDCqtlhRNRpawo6Rn20HShARD+/ZvnuBRMFEZjVfaDXvbrFD/h7LP0e6O5
        iSs/XepkPwoQ/h3xLrxvhIdl/kQu7nKwE8yOw/lJJV2Y3Kw5iGgczWbpljRmGwKlAYrYbm2QuHmOl
        3PLca63gFFAYJ62Hy1bOSx5GK67aQZjNDefpL+onEyuku+scKS11pxAQuLLmLhT2vx9dbxTwT+Glq
        CKclkP/5wjkeaPDlamGm/Bm5+ZaloAZAI7yZyMfBDnMB8NByu7SxTZnQ3fBNJKtGuHTJeQTV2Yuav
        wHzoLNPw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mK3cl-00Fm3g-4m; Sat, 28 Aug 2021 19:04:19 +0000
Date:   Sat, 28 Aug 2021 20:04:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Discontiguous folios/pagesets
Message-ID: <YSqIry5dKg+kqAxJ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current folio work is focused on permitting the VM to use
physically contiguous chunks of memory.  Both Darrick and Johannes
have pointed out the advantages of supporting logically-contiguous,
physically-discontiguous chunks of memory.  Johannes wants to be able to
use order-0 allocations to allocate larger folios, getting the benefit
of managing the memory in larger chunks without requiring the memory
allocator to be able to find contiguous chunks.  Darrick wants to support
non-power-of-two block sizes.

Johannes' ask is more readily achievable.  It requires a bit in struct
page to distinguish between contiguous/discontiguous folios.  The biggest
change would probably be to folio_page(), which will need a way to find
each subpage given the struct folio.  There are several different ways
to accomplish this (and I don't want to get into a detailed design
discussion here).  page_folio() actually requires no change at all;
compound_head() can move to any struct page.  There are challenges with
things like adding a folio to a bio_vec.  The current code assumes
that if we can add some of the folio, we can add all of the folio,
and that's not true for discontiguous folios (we might run out of room
in the bio_vec and have to allocate a new one).  It's a SMOP to fix.
There are probably other problems I haven't thought of, but I don't
expect them to be terribly hard to fix.

Non-power-of-two folios are more awkward.  Any calls to folio_order()
and folio_shift() have to be guarded by folio_test_contig() (which will
be fine).  The bigger problem is the radix tree.  It really only works
for power-of-two sized objects (and honestly, it's not even all that
great for things which aren't a power of 64 in size).  See appendix
for more details.

Liam and I (mostly Liam) have been working on the maple tree data
structure.  It naturally supports arbitrary-sized objects.  It does not
currently support three important features:

1. It is inefficient for objects of size 1.  The leaf node currently
stores 15 indices and 16 pointers.  By adding a new leaf node type, that
can be increased to 31 pointers, effectively making it twice as dense.

2. It does not support search marks.  The page cache relies on being able
to efficiently search for pages which are marked as dirty or writeback.
Again, a new node type can fix this by sacrificing one pointer per level
of the tree in order to mark subnodes/objects.

3. It does not support the 'private_list' / xa_update_node_t, which
is used by the workingset code to prune shadow entries under memory
pressure.  I think the maple tree should take a different approach from
the radix tree.  Instead of pruning nodes which contain only shadow
entries, we should prune shadow entries from the tree which will cause
the tree to shrink.  That calls for marking inodes as containing shadow
entries, and removing old shadow entries, maybe on an LRU of some kind.
I haven't thought deeply about this one, but I'm convinced that (as with
so many things) a real tree behaves better than the radix tree.

The maple tree is also better at storing "random" power of two sizes.
In the worst case, an order-5 page will take up 32 pointers (256
bytes; 4 cache lines) in the tree.  Even an order-2 page (the most
common allocation) takes 4 pointers.  That kind of wasted space offers
considerable opportunity for the maple tree to do better than the radix
tree for real workloads.

If nobody beats me to it, I expect to spend some time on the maple
tree soon.  This is a good time to offer suggestions, as opposed to
waiting until the pull request to tell me the entire idea is wrong.


Appendix: The fsync_range problem

The radix tree works by indexing into a 64-element table 6 bits at a time.
Assuming a 64-bit lookup index, it uses the top 4 bits to choose a node
from the top-level array, then it uses bits 54-59 to choose the next
node, then bits 48-53 for the next node, and so on.  This is optimised
to start further down the tree for trees which have no entries above a
certain index, saving memory and lookup time.

When we mark a page as dirty, we set a search mark in the node that
contains that page (and recursively all its parents, up to the root
node), ensuring that when we walk the tree looking for dirty pages,
we will find it.

That search is done by vfs_fsync_range() (there are a number of syscalls
which will get us there, eg sync_file_range(), msync(), IORING_OP_FSYNC)
It calls the fs-specific ->fsync() method, which usually calls
file_write_and_wait_range(), calls __filemap_fdatawrite_range()
calls do_writepages() calls ->writepages() which usually calls
write_cache_pages() calls pagevec_lookup_range_tag() calls
find_get_pages_range_tag() calls find_get_entry().

Here's the problem.  We might have a 20kB folio at index 4095-4099
of a file.  When we dirty the page at index 4097, we mark the head
page as dirty and so we mark index 4095 as dirty (which marks the node
containing 4032-4095 as dirty, and its parent node 0-4095 as dirty, and
its parent node 0-262143 as dirty).  Then we msync() the page at index
4097, so we start a search looking for dirty pages from index 4097-4097.
Node 0-262143 is dirty, so we step down into it, but then node 4096-8193
is not dirty, so we don't even look in it.

This isn't a problem for power-of-two folios.  All subpages are in
the same node as the head page.  When the XArray does a mark search,
it actually loads the entry, even if it's not marked.  If that entry is
a sibling entry, it checks to see whether the canonical entry is marked
or not.

We can't solve this by having the filesystem "round up" its search
to the nearest multiple of 20kB.  It would fix this particular
example, but if we happen to have allocated a 40kB page at index 8190,
dirtied-and-then-searched-for index 8207, we'd be looking for a start
of 8200 and miss the dirty mark of index 8190.

We could solve this by marking every subpage as being dirty, but
that makes marking rather inefficient (we could end up having to mark
twice as many nodes as we currently do) and complicated.  I think it's
better to admit we've reached the limit of what a radix tree can do for
us and move to the maple tree.
