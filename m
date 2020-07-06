Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017742159CB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 16:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgGFOnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 10:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbgGFOnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:43:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F06C061755
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2020 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VD2eTpv/dPofadULvyAlvcBsQkpHPtWNIJfEVK/jT00=; b=g6oJzEent+MAMiCgnq6Ez/tYdq
        mgf7/+52rKkl+3QHGV8g0kwNX60NaYs2sHE1YzttAU/+iVqkxzd3NJJukmuOAtjlT05rFWn7ADhIL
        K3IwjgMQh/VzmUob8osXiEa+gWtc2XPqJ/cEnK0XcsBPVIzL5G1xk7cK1UG7ztXNzZB8A9+BEML32
        q2Wn/5YHatEYz12bNAj+XrQ0nHR5hDW+qMIp44Sz8ktxRGtAl31hKZlqMFlBSyviBpTaHUy4sgo1s
        vErtOX/B0oxZ6vW/WZsLEKUD+KURpccPKYwA0Nlk1MRfKLBJgoUozgQZYoQ1/U/S32hPgeCYJYgUf
        caP4+0mA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsSL2-0005O7-2f; Mon, 06 Jul 2020 14:43:20 +0000
Date:   Mon, 6 Jul 2020 15:43:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] Use multi-index entries in the page cache
Message-ID: <20200706144320.GB25523@casper.infradead.org>
References: <20200629152033.16175-1-willy@infradead.org>
 <alpine.LSU.2.11.2007041206270.1056@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2007041206270.1056@eggly.anvils>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 04, 2020 at 01:20:19PM -0700, Hugh Dickins wrote:
> On Mon, 29 Jun 2020, Matthew Wilcox (Oracle) wrote:
> > Hugh, I would love it if you could test this.  It didn't introduce any new
> > regressions to the xfstests, but shmem does exercise different paths and
> > of course I don't have a clean xfstests run yet, so there could easily
> > still be bugs.
> 
> I have been trying it, and it's not good yet. I had hoped to work
> out what's wrong and send a patch, but I'm not making progress,
> so better hand back to you with what I've found.

Thank you so much!  I've made some progress.

> First problem was that it did not quite build on top of 5.8-rc3
> plus your 1-7 THP prep patches: was there some other series we
> were supposed to add in too? If so, that might make a big difference,
> but I fixed up __add_to_page_cache_locked() as in the diff below
> (and I'm not bothering about hugetlbfs, so haven't looked to see if
> its page indexing is or isn't still exceptional with your series).

Oops.  I shifted some patches around and clearly didn't get it quite
right.  I'll fix it up.

> Second problem was fs/inode.c:530 BUG_ON(inode->i_data.nrpages),
> after warning from shmem_evict_inode(). Surprisingly, that first
> happened on a machine with CONFIG_TRANSPARENT_HUGEPAGE not set,
> while doing an "rm -rf".

I've seen that occasionally too.

> The original non-THP machine ran the same load for
> ten hours yesterday, but hit no problem. The only significant
> difference in what ran successfully, is that I've been surprised
> by all the non-zero entries I saw in xarray nodes, exceeding
> total entry "count" (I've also been bothered by non-zero "offset"
> at root, but imagine that's just noise that never gets used).
> So I've changed the kmem_cache_alloc()s in lib/radix-tree.c to
> kmem_cache_zalloc()s, as in the diff below: not suggesting that
> as necessary, just a temporary precaution in case something is
> not being initialized as intended.

Umm.  ->count should always be accurate and match the number of non-NULL
entries in a node.  the zalloc shouldn't be necessary, and will probably
break the workingset code.  Actually, it should BUG because we have both
a constructor and an instruction to zero the allocation, and they can't
both be right.

You're right that ->offset is never used at root.  I had plans to
repurpose that to support smaller files more efficiently, but never
got round to implementing those plans.

> These problems were either mm/filemap.c:1565 find_lock_entry()
> VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page); or hangs, which
> (at least the ones that I went on to investigate) turned out also to be
> find_lock_entry(), circling around with page_mapping(page) != mapping.
> It seems that find_get_entry() is sometimes supplying the wrong page,
> and you will work out why much quicker than I shall.  (One tantalizing
> detail of the bad offset crashes: very often page pgoff is exactly one
> less than the requested offset.)

I added this:

@@ -1535,6 +1535,11 @@ struct page *find_get_entry(struct address_space *mapping, pgoff_t offset)
                goto repeat;
        }
        page = find_subpage(page, offset);
+       if (page_to_index(page) != offset) {
+               printk("offset %ld xas index %ld offset %d\n", offset, xas.xa_index, xas.xa_offset);
+               dump_page(page, "index mismatch");
+               printk("xa_load %p\n", xa_load(&mapping->i_pages, offset));
+       }
 out:
        rcu_read_unlock();
 
and I have a good clue now:

1322 offset 631 xas index 631 offset 48
1322 page:000000008c9a9bc3 refcount:4 mapcount:0 mapping:00000000d8615d47 index:0x276
1322 flags: 0x4000000000002026(referenced|uptodate|active|private)
1322 mapping->aops:0xffffffff88a2ebc0 ino 1800b82 dentry name:"f1141"
1322 raw: 4000000000002026 dead000000000100 dead000000000122 ffff98ff2a8b8a20
1322 raw: 0000000000000276 ffff98ff1ac271a0 00000004ffffffff 0000000000000000
1322 page dumped because: index mismatch
1322 xa_load 000000008c9a9bc3

0x276 is decimal 630.  So we're looking up a tail page and getting its
erstwhile head page.  I'll dig in and figure out exactly how that's
happening.

