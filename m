Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63557597A9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 02:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiHRAZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 20:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiHRAZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 20:25:27 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BE68A61C4
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 17:25:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-52-176.pa.nsw.optusnet.com.au [49.181.52.176])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0E19010E8AC0;
        Thu, 18 Aug 2022 10:25:22 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oOTLd-00EOMC-5N; Thu, 18 Aug 2022 10:25:21 +1000
Date:   Thu, 18 Aug 2022 10:25:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: folio_map
Message-ID: <20220818002521.GB3144495@dread.disaster.area>
References: <YvvdFrtiW33UOkGr@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvvdFrtiW33UOkGr@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62fd86f4
        a=O3n/kZ8kT9QBBO3sWHYIyw==:117 a=O3n/kZ8kT9QBBO3sWHYIyw==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8
        a=oRO1myKlDp8gOIH6g8oA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 07:08:22PM +0100, Matthew Wilcox wrote:
> Some of you will already know all this, but I'll go into a certain amount
> of detail for the peanut gallery.
> 
> One of the problems that people want to solve with multi-page folios
> is supporting filesystem block sizes > PAGE_SIZE.  Such filesystems
> already exist; you can happily create a 64kB block size filesystem on
> a PPC/ARM/... today, then fail to mount it on an x86 machine.

The XFS buffer cache already supports 64kB block sizes on 4kB page
size machines - we do this with bulk page allocation and
vm_map_ram()/vm_unmap_ram() of the page arrays that are built.

These mappings are persistent (i.e. cannot be local), but if you
want to prototype something before the page cache has been
completely modified to support BS > PS, then the XFS buffer
cache already does what you need. Just make XFS filesystems with
"-n size=64k" to use directory block sizes of 64kB and do lots of
work with directory operations on large directories.

> kmap_local_folio() only lets you map a single page from a folio.
> This works for the majority of cases (eg ->write_begin() works on a
> per-page basis *anyway*, so we can just map a single page from the folio).
> But this is somewhat hampering for ext2_get_page(), used for directory
> handling.  A directory record may cross a page boundary (because it
> wasn't a page boundary on the machine which created the filesystem),
> and juggling two pages being mapped at once is tricky with the stack
> model for kmap_local.

Yup, that's exactly the problem we avoid by using mapped buffers in
XFS.

> I don't particularly want to invest heavily in optimising for HIGHMEM.
> The number of machines which will use multi-page folios and HIGHMEM is
> not going to be large, one hopes, as 64-bit kernels are far more common.
> I'm happy for 32-bit to be slow, as long as it works.

Fully agree.

> For these reasons, I proposing the logical equivalent to this:
> 
> +void *folio_map_local(struct folio *folio)
> +{
> +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> +               return folio_address(folio);
> +       if (!folio_test_large(folio))
> +               return kmap_local_page(&folio->page);
> +       return vmap_folio(folio);
> +}
> +
> +void folio_unmap_local(const void *addr)
> +{
> +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> +               return;
> +       if (is_vmalloc_addr(addr))
> +               vunmap(addr);
> +	else
> +       	kunmap_local(addr);
> +}
> 
> (where vmap_folio() is a new function that works a lot like vmap(),
> chunks of this get moved out-of-line, etc, etc., but this concept)

*nod*

> Does anyone have any better ideas?  If it'd be easy to map N pages
> locally, for example ... looks like we only support up to 16 pages
> mapped per CPU at any time, so mapping all of a 64kB folio would
> almost always fail, and even mapping a 32kB folio would be unlikely
> to succeed.

FWIW, what I really want for the XFS buffer cache is a large folio
aware variant of vm_map_ram/vm_unmap_ram(). i.e. something we can
pass a random assortment of folios into, and it just does the right
thing to create a persistent contiguous mapping of the folios.

i.e. we have an allocation loop that tries to allocate large folios,
but then falls back to smaller folios if the large allocation cannot
be fulfilled without blocking. Then the mapping function works with
whatever we managed to allocate in the most optimal way....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
