Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7683B3DF179
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 17:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbhHCPaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 11:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbhHCP3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:29:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230EEC0617B1;
        Tue,  3 Aug 2021 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=t61FEUzIz+i4hYWB8dvqN3tx/GWPFjFjeSeJEdSmVp0=; b=aTCl3/SGgVF3RpqyvkJ6s4Vd51
        sysSe4wYuJgU8aGTVPuTPmHjYfvy2UZMWhu2xIadARfF1x1wSbSbEbongFG9Uf1lM1zyFMYeiBejl
        zYDLPeGUCqugADQy3n3a0JSsIy/9l3vWdLgT8zngPGEssDGjlFT8pyNp+v7C46Q1pHwg/GrPzaLs8
        w0mQ7+mrtO65W8Tq4fZ0Uj7HpSuxCe+fjAKM4NYohlpJrIEiB233z3YjLBg+w0rr1ImbR5QZ3O6+M
        EPg+n87lF7nrCxswKrZeFOk5Y+XEDldi8L0A0PYk2LEn1t7RnmoYLCjwAhlX4OIrQv9pXDzvxoUWq
        quIlE1ag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAwL0-004pAm-3w; Tue, 03 Aug 2021 15:28:19 +0000
Date:   Tue, 3 Aug 2021 16:28:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Zhengyuan Liu <liuzhengyuang521@gmail.com>, yukuai3@huawei.com,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>, linux-xfs@vger.kernel.org
Subject: Dirty bits and sync writes
Message-ID: <YQlgjh2R8OzJkFoB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Back in July 2020, Zhengyuan Liu noticed a performance problem with
XFS which I've realised is going to be a problem for multi-page folios.
Much of this is iomap specific, but solution 3 is not, and perhaps the
problems pertain to other filesystems too.

The original email is here:

https://lore.kernel.org/linux-xfs/CAOOPZo45E+hVAo9S_2psMJQzrzwmVKo_WjWOM7Zwhm_CS0J3iA@mail.gmail.com/

but to summarise the workload involves doing 4kB sync writes on a
machine with a 64kB page size.  That ends up amplifying the number of
bytes written by a factor of 16 because iomap doesn't track dirtiness
on a sub-page basis.

Unfortunately, that factor is O(n^2) in the size of the page.  That is,
if you have the very reasonable workload:

dd if=/dev/zero bs=4k conv=fdatasync

If you have a 64k page, you'll write it 16 times.  If you have a 128k
page, you'll write it 32 times.  A 256k page gets written 64 times.
I don't currently have code to create multi-page folios on writes, but
if there's already a multi-page folio in the cache, this will happen.
And we should create multi-page folios on writes, because it's more
efficient for the non-sync-write case.

Solution 1: Add an array of dirty bits to the iomap_page
data structure.  This patch already exists; would need
to be adjusted slightly to apply to the current tree.
https://lore.kernel.org/linux-xfs/7fb4bb5a-adc7-5914-3aae-179dd8f3adb1@huawei.com/

Solution 2a: Replace the array of uptodate bits with an array of
dirty bits.  It is not often useful to know which parts of the page are
uptodate; usually the entire page is uptodate.  We can actually use the
dirty bits for the same purpose as uptodate bits; if a block is dirty, it
is definitely uptodate.  If a block is !dirty, and the page is !uptodate,
the block may or may not be uptodate, but it can be safely re-read from
storage without losing any data.

Solution 2b: Lose the concept of partially uptodate pages.  If we're
going to write to a partial page, just bring the entire page uptodate
first, then write to it.  It's not clear to me that partially-uptodate
pages are really useful.  I don't know of any network filesystems that
support partially-uptodate pages, for example.  It seems to have been
something we did for buffer_head based filesystems "because we could"
rather than finding a workload that actually cares.

Solution 3: Special-case sync writes.  Usually we want the page cache
to absorb a lot of writes and then write them back later.  A sync write
says to treat the page cache as writethrough.  We currently handle
this by writing into the page cache, marking the page(s) as dirty,
looking up the page(s) which are dirty in the range, starting writeback
on each of them, then waiting for writeback to finish on each of them.
See generic_write_sync() for how that happens.  What we could do is,
with the page locked in __iomap_write_end(), if the page is !dirty and
!writeback, mark the page as writeback and start writeback of just the
bytes which have been touched by this write.  generic_write_sync() will
continue to work correctly; it won't start writeback on the page(s)
because they won't be dirty.  It will wait for the writeback to end,
and then proceed to writeback the inode if it was an O_SYNC write rather
than an O_DATASYNC write.

Solutions 2a and 2b do have a bit of a problem with read errors.  If we
care about being able to recover the parts of the file which are outside
a block with read errors, by reading through the page cache, then we
need to have per-block error bits or uptodate bits.  But I don't think
this is terribly interesting; I think we can afford (at the current
low rate of storage errors) to tell users to use O_DIRECT to recover
the still-readable blocks from files.  Again, network filesystems don't
support sub-page uptodate/error bits.

(it occurs to me that solution 3 actually allows us to do IOs at storage
block size instead of filesystem block size, potentially reducing write
amplification even more, although we will need to be a bit careful if
we're doing a CoW.)
