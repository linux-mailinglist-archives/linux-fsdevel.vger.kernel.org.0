Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7104D5978FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 23:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbiHQVeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 17:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiHQVeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:34:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936915A2E6
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 14:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EayHNGi0pRhHNgL/20r+RzO2uKpWZWhIdgjKyNhLt2k=; b=VpbvrLD0GQjIVsBjr1O/QP8kGT
        DDvkWGB+qGDAEabUmHNC1uMHaAq/0MyZMPzCoOqtvVaq+amVLuY70F2AQ6xN0BZ8EBdJYAPWPNix+
        E2YH7ANtF0pW0M4wbv2jE3XiZ1OHLP1Vzu34bhT4tnKlYf1CJJwWkBBrmwUpzVneFkutqoDtWSMI2
        SmwH0sa1KDgcEJ2mpu1qghFcdl3sYSHTwSkSJNErNS52+mcoFX8mJ3a7T7AhIrNTPenZKOJ86mg2m
        6bcYKs1A1oYCHqi/3owozlKsigXECtZFRcAWS1jjwsu5f7pthA/7lc7rmNFO8UGzoW1W0rmDpUj8B
        9ouR/usQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOQft-008kla-5u; Wed, 17 Aug 2022 21:34:05 +0000
Date:   Wed, 17 Aug 2022 22:34:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: folio_map
Message-ID: <Yv1ezcVV62w0O87V@casper.infradead.org>
References: <YvvdFrtiW33UOkGr@casper.infradead.org>
 <20220817102935.cqcqpmuu3vanfb63@box.shutemov.name>
 <Yv1DzKKzkDjwVuKV@casper.infradead.org>
 <Yv1OTWPVooKJivsL@iweiny-desk3>
 <Yv1VETRRT95mV2d3@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv1VETRRT95mV2d3@iweiny-desk3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 01:52:33PM -0700, Ira Weiny wrote:
> On Wed, Aug 17, 2022 at 01:23:41PM -0700, Ira wrote:
> > On Wed, Aug 17, 2022 at 08:38:52PM +0100, Matthew Wilcox wrote:
> > > On Wed, Aug 17, 2022 at 01:29:35PM +0300, Kirill A. Shutemov wrote:
> > > > On Tue, Aug 16, 2022 at 07:08:22PM +0100, Matthew Wilcox wrote:
> > > > > Some of you will already know all this, but I'll go into a certain amount
> > > > > of detail for the peanut gallery.
> > > > > 
> > > > > One of the problems that people want to solve with multi-page folios
> > > > > is supporting filesystem block sizes > PAGE_SIZE.  Such filesystems
> > > > > already exist; you can happily create a 64kB block size filesystem on
> > > > > a PPC/ARM/... today, then fail to mount it on an x86 machine.
> > > > > 
> > > > > kmap_local_folio() only lets you map a single page from a folio.
> > > > > This works for the majority of cases (eg ->write_begin() works on a
> > > > > per-page basis *anyway*, so we can just map a single page from the folio).
> > > > > But this is somewhat hampering for ext2_get_page(), used for directory
> > > > > handling.  A directory record may cross a page boundary (because it
> > > > > wasn't a page boundary on the machine which created the filesystem),
> > > > > and juggling two pages being mapped at once is tricky with the stack
> > > > > model for kmap_local.
> > > > > 
> > > > > I don't particularly want to invest heavily in optimising for HIGHMEM.
> > > > > The number of machines which will use multi-page folios and HIGHMEM is
> > > > > not going to be large, one hopes, as 64-bit kernels are far more common.
> > > > > I'm happy for 32-bit to be slow, as long as it works.
> > > > > 
> > > > > For these reasons, I proposing the logical equivalent to this:
> > > > > 
> > > > > +void *folio_map_local(struct folio *folio)
> > > > > +{
> > > > > +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> > > > > +               return folio_address(folio);
> > > > > +       if (!folio_test_large(folio))
> > > > > +               return kmap_local_page(&folio->page);
> > > > > +       return vmap_folio(folio);
> > > > > +}
> > > > > +
> > > > > +void folio_unmap_local(const void *addr)
> > > > > +{
> > > > > +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> > > > > +               return;
> > > > > +       if (is_vmalloc_addr(addr))
> > > > > +               vunmap(addr);
> > > > > +	else
> > > > > +       	kunmap_local(addr);
> > > > > +}
> > > > > 
> > > > > (where vmap_folio() is a new function that works a lot like vmap(),
> > > > > chunks of this get moved out-of-line, etc, etc., but this concept)
> > > > 
> > > > So it aims at replacing kmap_local_page(), but for folios, right?
> > > > kmap_local_page() interface can be used from any context, but vmap helpers
> > > > might_sleep(). How do we rectify this?
> > > 
> > > I'm not proposing getting rid of kmap_local_folio().  That should still
> > > exist and work for users who need to use it in atomic context.  Indeed,
> > > I'm intending to put a note in the doc for folio_map_local() suggesting
> > > that users may prefer to use kmap_local_folio().  Good idea to put a
> > > might_sleep() in folio_map_local() though.
> > 
> > There is also a semantic miss-match WRT the unmapping order.  But I think
> > Kirill brings up a bigger issue.

I don't see the semantic mismatch?

> > How many folios do you think will need to be mapped at a time?  And is there
> > any practical limit on their size?  Are 64k blocks a reasonable upper bound
> > until highmem can be deprecated completely?
> > 
> > I say this because I'm not sure that mapping a 64k block would always fail.
> > These mappings are transitory.  How often will a filesystem be mapping more
> > than 2 folios at once?
> 
> I did the math wrong but I think my idea can still work.

The thing is that kmap_local_page() can be called from interrupt context
(how often is it?  no idea).  So you map two 64kB folios (at 16 entries
each) and that consumes 32 entries for this CPU, now you take an interrupt
and that's 33.  I don't know how deep that goes; can we have some mapped
in userspace, some mapped in softirq and then another interrupt causes
more to be mapped in hardirq?  I don't really want to find out, so I'd
rather always punt to vmap() for multipage folios.

Is there a reason you want to make folio_map_local() more efficient
on HIGHMEM systems?

> > 
> > In our conversions most of the time 2 pages are mapped at once,
> > source/destination.
> > 
> > That said, to help ensure that a full folio map never fails we could increase
> > the number of pages supported by kmap_local_page().  At first, I was not a fan
> > but that would only be a penalty for HIGHMEM systems.  And as we are not
> > optimizing for such systems I'm not sure I see a downside to increasing the
> > limit to 32 or even 64.  I'm also inclined to believe that HIGHMEM systems are
> > smaller core counts.  So I don't think this is likely to multiply the space
> > wasted much.
> > 
> > Would doubling the support within kmap_local_page() be enough?
> > 
> > A final idea would be to hide the increase behind a 'support large block size
> > filesystems' config option under HIGHMEM systems.  But I'm really not sure that
> > is even needed.
> > 
> > Ira
> > 
