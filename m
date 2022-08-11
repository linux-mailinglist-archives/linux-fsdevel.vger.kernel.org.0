Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBD1590813
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 23:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiHKVb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 17:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiHKVbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:31:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB9D45F79;
        Thu, 11 Aug 2022 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RAKwc334guoPBQoyyKOu50SCJZQyroHMyPY+vcCwB70=; b=qcM5CcBkmEzt24t4j92hRBTvEX
        ntOytKlPDWc7Yk5GQSfyLaM8vzHJNxFQDpHlUGj4hbCTPuAL8PCbQDBGoAWivtMoS+w7bHWEZd1rt
        176Y6Q3BHNqS42WqBjpTRuYBGyEa0daUGPnWj1VIS+6MDlYnzhbyilNCrABDcLtNuzfrhz9Z8HQwz
        AQ/h3wa2iLy1pswApy/G6HiE4NVAVSYSfgtZ750H5VnabctiGpTJoQbNU2xI/s81qBL2kI7FMO/SB
        Il1SLXAS0t7waiTfc221knYG+Lcm+tRLepvVs9hZwbM4V0HcYxiuNw1exN6eys/n3KJipbKB4Q/QJ
        8QsF5kZg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMFlx-001ITh-Iu; Thu, 11 Aug 2022 21:31:21 +0000
Date:   Thu, 11 Aug 2022 22:31:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: State of the Page (August 2022)
Message-ID: <YvV1KTyzZ+Jrtj9x@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

==============================
State Of The Page, August 2022
==============================

I thought I'd write down where we are with struct page and where
we're going, just to make sure we're all (still?) pulling in a similar
direction.

Destination
===========

For some users, the size of struct page is simply too large.  At 64
bytes per 4KiB page, memmap occupies 1.6% of memory.  If we can get
struct page down to an 8 byte tagged pointer, it will be 0.2% of memory,
which is an acceptable overhead.

   struct page {
      unsigned long mem_desc;
   };

Types of memdesc
----------------

This is very much subject to change as new users present themselves.
Here are the current ones in-plan:

 - Undescribed.  Instead of the rest of the word being a pointer,
   there are 2^28 subtypes available:
   - Unmappable.  Typically device drivers allocating private memory.
   - Reserved.  These pages are not allocatable.
   - HWPoison
   - Offline (eg balloon)
   - Guard (see debug_pagealloc)
 - Slab
 - Anon Folio
 - File Folio
 - Buddy (ie free -- also for PCP?)
 - Page Table
 - Vmalloc
 - Net Pool
 - Zsmalloc
 - Z3Fold
 - Mappable.  Typically device drivers mapping memory to userspace

That implies 4 bits needed for the tag, so all memdesc allocations
must be 16-byte aligned.  That is not an undue burden.  Memdescs
must also be TYPESAFE_BY_RCU if they are mappable to userspace or
can be stored in a file's address_space.

It may be worth distinguishing between vmalloc-mappable and
vmalloc-unmappable to prevent some things being mapped to userspace
inadvertently.

Contents of a memdesc
---------------------

At least initially, the first word of a memdesc must be identical to the
current page flags.  That allows various functions (eg set_page_dirty())
to work on any kind of page without needing to know whether it's a device
driver page, a vmalloc page, anon or file folio.

Similarly, both anon and file folios must have the list_head in the
same place so they can be placed on the same LRU list.  Whether anon
and file folios become separate types is still unclear to me.

Mappable
--------

All pages mapped to userspace must have:

 - A refcount
 - A mapcount

Preferably in the same place in the memdesc so we can handle them without
having separate cases for each type of memdesc.  It would be nice to have
a pincount as well, but that's already an optional feature.

I propose:

   struct mappable {
       unsigned long flags;	/* contains dirty flag */
       atomic_t _refcount;
       atomic_t _mapcount;
   };

   struct folio {
      union {
         unsigned long flags;
         struct mappable m;
      };
      ...
   };

Memdescs which should never be mapped to userspace (eg slab, page tables,
zsmalloc) do not need to contain such a struct.

Mapcount
--------

While discussed above, handling mapcount is tricky enough to need its
own section.  Since folios can be mapped unaligned, we may need to
increment mapcount once per page table entry that refers to it.  This
is different from how THPs are handled today (one refcount per page
plus a compound_mapcount for how many times the entire THP is mapped).
So splitting a PMD entry results in incrementing mapcount by
(PTRS_PER_PMD - 1).

If the mapcount is raised to dangerously high levels, we can split
the page.  This should not happen in normal operation.

Extended Memdescs
-----------------

One of the things we're considering is that maybe a filesystem will
want to have private data allocated with its folios.  Instead of hanging
extra stuff off folio->private, they could embed a struct folio inside
a struct ext4_folio.

Buddy memdesc
-------------

I need to firm up a plan for this.  Allocating memory in order to free
memory is generally a bad idea, so we either have to coopt the contents
of other memdescs (and some allocations don't have memdescs!) or we
need to store everything we need in the remainder of the unsigned long.
I'm not yet familiar enough with the page allocator to have a clear
picture of what is needed.

Where are we?
=============

v5.17:

 - Slab was broken out from struct page in 5.17 (thanks to Vlastimil).
 - XFS & iomap mostly converted from pages to folios
 - Block & page cache mostly have the folio interfaces in place

v5.18:

 - Large folio (multiple page) support added for filesystems that opt in
 - File truncation converted to folios
 - address_space_operations (aops) ->set_page_dirty converted to ->dirty_folio
 - Much of get_user_page() converted to folios
 - rmap_walk() converted to folios

v5.19:

 - Most aops now converted to folios
 - More folio conversions in migration, shmem, swap, vmscan 

v6.0:

 - aops->migratepage became migrate_folio
 - isolate_page and putback_page removed from aops
 - More folio conversions in migration, shmem, swap, vmscan 

Todo
====

Well, most of the above!

 - Individual filesystems need converting from pages to folios
 - Zsmalloc, z3fold, page tables, netpools need to be split from
   struct page into their own types
 - Anywhere referring to page->... needs to be converted to folio
   or some other type.

Help with any of this gratefully appreciated.  Especially if you're the
maintainer of a thing and want to convert it yourself.  I'd rather help
explain the subtleties of folios / mappables / ... to you than try
to figure out the details of your code to convert it myself (and get
it wrong).  Please contact me to avoid multiple people working on
the same thing.
