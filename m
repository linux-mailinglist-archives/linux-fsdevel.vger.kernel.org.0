Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709F36536CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 20:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiLUTEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 14:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUTEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:04:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E93A23E9F;
        Wed, 21 Dec 2022 11:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1EaAEVRpfZISdwMc1aLC3alNH8vvsLi8U0NKwKj+Wkk=; b=SwizxruY+dHp/KiljsE2YRzrhM
        dTqCcjfK4s7CMc/J895hWRErI6g+mLHCYt90hgXw1S/53PD2MauntrrJPG38AJN3+MgQ8ynq7anXq
        8q3oT8+JJQ52sxeSHwbOpJMyIrzASYx+zL2bNulXMuBeeuP/cJHSPS+C1bpwYw8pXH9SHDb96m458
        m+8PYJa17TPXGO7CIVftewe0/eiAmZDqRfrLrd7p5hmA9dHpN2gO3AKCbGRz3h3Ew5P3rn3IoOHn3
        f5GGj4vSp24Fw0mezudP+0OH1YgN5GfAxMs2vCoA7YKSJGKOF/CR3KffK7A6vVBuSd7/wZEei3pZo
        LYK2V3OQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p84Nm-0030Ha-Q6; Wed, 21 Dec 2022 19:04:02 +0000
Date:   Wed, 21 Dec 2022 19:04:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, reiserfs-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 5/8] reiserfs: Convert do_journal_end() to use
 kmap_local_folio()
Message-ID: <Y6NYonXNGL58+rV8@casper.infradead.org>
References: <20221216205348.3781217-1-willy@infradead.org>
 <20221216205348.3781217-6-willy@infradead.org>
 <Y55WUrzblTsw6FfQ@iweiny-mobl>
 <Y6GB75HMEKfcGcsO@casper.infradead.org>
 <20221220111801.jhukawk3lbuonxs3@quack3>
 <Y6HpzAFNA33jQ3bl@iweiny-desk3>
 <Y6IAUetp7nihz9Qu@casper.infradead.org>
 <Y6JMazsjbPRJ7oMM@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6JMazsjbPRJ7oMM@iweiny-desk3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 20, 2022 at 03:59:39PM -0800, Ira Weiny wrote:
> On Tue, Dec 20, 2022 at 06:34:57PM +0000, Matthew Wilcox wrote:
> > On Tue, Dec 20, 2022 at 08:58:52AM -0800, Ira Weiny wrote:
> > > On Tue, Dec 20, 2022 at 12:18:01PM +0100, Jan Kara wrote:
> > > > On Tue 20-12-22 09:35:43, Matthew Wilcox wrote:
> > > > > But that doesn't solve the "What about fs block size > PAGE_SIZE"
> > > > > problem that we also want to solve.  Here's a concrete example:
> > > > > 
> > > > >  static __u32 jbd2_checksum_data(__u32 crc32_sum, struct buffer_head *bh)
> > > > >  {
> > > > > -       struct page *page = bh->b_page;
> > > > > +       struct folio *folio = bh->b_folio;
> > > > >         char *addr;
> > > > >         __u32 checksum;
> > > > >  
> > > > > -       addr = kmap_atomic(page);
> > > > > -       checksum = crc32_be(crc32_sum,
> > > > > -               (void *)(addr + offset_in_page(bh->b_data)), bh->b_size);
> > > > > -       kunmap_atomic(addr);
> > > > > +       BUG_ON(IS_ENABLED(CONFIG_HIGHMEM) && bh->b_size > PAGE_SIZE);
> > > > > +
> > > > > +       addr = kmap_local_folio(folio, offset_in_folio(folio, bh->b_data));
> > > > > +       checksum = crc32_be(crc32_sum, addr, bh->b_size);
> > > > > +       kunmap_local(addr);
> > > > >  
> > > > >         return checksum;
> > > > >  }
> > > > > 
> > > > > I don't want to add a lot of complexity to handle the case of b_size >
> > > > > PAGE_SIZE on a HIGHMEM machine since that's not going to benefit terribly
> > > > > many people.  I'd rather have the assertion that we don't support it.
> > > > > But if there's a good higher-level abstraction I'm missing here ...
> > > > 
> > > > Just out of curiosity: So far I was thinking folio is physically contiguous
> > > > chunk of memory. And if it is, then it does not seem as a huge overkill if
> > > > kmap_local_folio() just maps the whole folio?
> > > 
> > > Willy proposed that previously but we could not come to a consensus on how to
> > > do it.
> > > 
> > > https://lore.kernel.org/all/Yv2VouJb2pNbP59m@iweiny-desk3/
> > > 
> > > FWIW I still think increasing the entries to cover any foreseeable need would
> > > be sufficient because HIGHMEM does not need to be optimized.  Couldn't we hide
> > > the entry count into some config option which is only set if a FS needs a
> > > larger block size on a HIGHMEM system?
> > 
> > "any foreseeable need"?  I mean ... I'd like to support 2MB folios,
> > even on HIGHMEM machines, and that's 512 entries.  If we're doing
> > memcpy_to_folio(), we know that's only one mapping, but still, 512
> > entries is _a lot_ of address space to be reserving on a 32-bit machine.
> 
> I'm confused.  A memcpy_to_folio() could loop to map the pages as needed
> depending on the amount of data to copy.  Or just map/unmap in a loop.
> 
> This seems like an argument to have a memcpy_to_folio() to hide such nastiness
> on HIGHMEM from the user.

I see that you are confused.  What I'm not quite sure of is how I confused
you, so I'm just going to try again in different words.

Given the desire to support 2MB folios on x86/ARM PAE systems, we can't
have a kmap_local_entire_folio() because that would take up too much
address space.

But we can have a kmap_local_buffer() / kummap_local_buffer().  We can
restrict the maximum fs block size (== buffer->b-size) to a reasonably
small multiple of PAGE_SIZE, eg 16.  That will let us kmap the entire
buffer, after making some of the changes described below.

That solves the jbd2_checksum_data() problem above, but isn't necessarily
the best solution for every filesystem "need to copy to a folio" problem.
So I think we do want memcpy_to/from_folio(), split out like the current
zero_user_segments().

I also think we want a copy_folio_from_iter_atomic().  Right now
iomap_write_iter() is a bit of a mess; it retrieves a multi-page folio
from the page cache multiple times instead of copying as much as it can
from userspace to the folio.  There are some interesting issues to deal
with here, but putting it in iov_iter.c is better than hiding it in the
iomap code.

> > I don't know exactly what the address space layout is on x86-PAE or
> > ARM-PAE these days, but as I recall, the low 3GB is user and the high
> > 1GB is divided between LOWMEM and VMAP space; something like 800MB of
> > LOWMEM and 200MB of vmap/kmap/PCI iomem/...
> > 
> > Where I think we can absolutely get away with this reasoning is having
> > a kmap_local_buffer().  It's perfectly reasonable to restrict fs block
> > size to 64kB (after all, we've been limiting it to 4kB on x86 for thirty
> > years), and having a __kmap_local_pfns(pfn, n, prot) doesn't seem like
> > a terribly bad idea to me.
> > 
> > So ... is this our path forward:
> > 
> >  - Introduce a complex memcpy_to/from_folio() in highmem.c that mirrors
> >    zero_user_segments()
> >  - Have a simple memcpy_to/from_folio() in highmem.h that mirrors
> >    zero_user_segments()
> 
> I'm confused again.  What is the difference between the complex/simple other
> than inline vs not?
> 
> >  - Convert __kmap_local_pfn_prot() to __kmap_local_pfns()
> 
> I'm not sure I follow this need but I think you are speaking of having the
> mapping of multiple pages in a tight loop in the preemption disabled region?
> 
> Frankly, I think this is an over optimization for HIGHMEM.  Just loop calling
> kmap_local_page() (either with or without an unmap depending on the details.)

See the jbd2_checksum_data() example at the top, and design me a better
API that doesn't involve putting complexity into jbd2 ;-)

> >  - Add kmap_local_buffer() that can handle buffer_heads up to, say, 16x
> >    PAGE_SIZE
> 
> I really just don't know the details of the various file systems.[*]  Is this
> something which could be hidden in Kconfig magic and just call this
> kmap_local_folio()?
> 
> My gut says that HIGHMEM systems don't need large block size FS's.  So could
> large block size FS's be limited to !HIGHMEM configs?

They could, and that's the current approach, but it does seem plausible
that we could support HIGHMEM systems with fs-block-size > PAGE_SIZE
with only a little extra work.

> [*] I only play a file system developer on TV.  ;-)

That's OK, I'm only pretending to be an MM developer.  Keep quiet, and
I think we can get away with this.
