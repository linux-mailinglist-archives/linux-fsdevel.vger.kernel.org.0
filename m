Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8E665265A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Dec 2022 19:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiLTSe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 13:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiLTSez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:34:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02672283;
        Tue, 20 Dec 2022 10:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i/0dNg/LAcrE2r3WsBk6QSdMSI82eF4SrtzGc5f53Nc=; b=WQfWVJi0VNAvTVOO5wgus+nc32
        isjT3Rizfb3MM+/hgYvU6o9t6QOAzWAxzYy9xI2iFVDN/gGLzZd0J/3GtoKGUybfzFKDTDPlh3Lx6
        IZPTxZDEt4W9MqWxfJian1GVAAyb+3k/DEURgq6GdmByLTBGWNjroZnudSu9e1xcGeNFkrk8JObUB
        b7958Jxr5Hvo1MV/atr9grn2gHiO+4xC2gvzKEhTNaqRkvcDvX3Qft6OHQrXBtfbqGLlSBPi8mby1
        3e2zRQNQmTFmSy5s/qMTOmPp3A3gUaoSjQWn+h58Gd/XdBdWFn6Sc0+5lbFBZblJ1dNEiPwwdeybt
        F/c77JXA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7hS5-00246z-Ol; Tue, 20 Dec 2022 18:34:57 +0000
Date:   Tue, 20 Dec 2022 18:34:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, reiserfs-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 5/8] reiserfs: Convert do_journal_end() to use
 kmap_local_folio()
Message-ID: <Y6IAUetp7nihz9Qu@casper.infradead.org>
References: <20221216205348.3781217-1-willy@infradead.org>
 <20221216205348.3781217-6-willy@infradead.org>
 <Y55WUrzblTsw6FfQ@iweiny-mobl>
 <Y6GB75HMEKfcGcsO@casper.infradead.org>
 <20221220111801.jhukawk3lbuonxs3@quack3>
 <Y6HpzAFNA33jQ3bl@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6HpzAFNA33jQ3bl@iweiny-desk3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 20, 2022 at 08:58:52AM -0800, Ira Weiny wrote:
> On Tue, Dec 20, 2022 at 12:18:01PM +0100, Jan Kara wrote:
> > On Tue 20-12-22 09:35:43, Matthew Wilcox wrote:
> > > But that doesn't solve the "What about fs block size > PAGE_SIZE"
> > > problem that we also want to solve.  Here's a concrete example:
> > > 
> > >  static __u32 jbd2_checksum_data(__u32 crc32_sum, struct buffer_head *bh)
> > >  {
> > > -       struct page *page = bh->b_page;
> > > +       struct folio *folio = bh->b_folio;
> > >         char *addr;
> > >         __u32 checksum;
> > >  
> > > -       addr = kmap_atomic(page);
> > > -       checksum = crc32_be(crc32_sum,
> > > -               (void *)(addr + offset_in_page(bh->b_data)), bh->b_size);
> > > -       kunmap_atomic(addr);
> > > +       BUG_ON(IS_ENABLED(CONFIG_HIGHMEM) && bh->b_size > PAGE_SIZE);
> > > +
> > > +       addr = kmap_local_folio(folio, offset_in_folio(folio, bh->b_data));
> > > +       checksum = crc32_be(crc32_sum, addr, bh->b_size);
> > > +       kunmap_local(addr);
> > >  
> > >         return checksum;
> > >  }
> > > 
> > > I don't want to add a lot of complexity to handle the case of b_size >
> > > PAGE_SIZE on a HIGHMEM machine since that's not going to benefit terribly
> > > many people.  I'd rather have the assertion that we don't support it.
> > > But if there's a good higher-level abstraction I'm missing here ...
> > 
> > Just out of curiosity: So far I was thinking folio is physically contiguous
> > chunk of memory. And if it is, then it does not seem as a huge overkill if
> > kmap_local_folio() just maps the whole folio?
> 
> Willy proposed that previously but we could not come to a consensus on how to
> do it.
> 
> https://lore.kernel.org/all/Yv2VouJb2pNbP59m@iweiny-desk3/
> 
> FWIW I still think increasing the entries to cover any foreseeable need would
> be sufficient because HIGHMEM does not need to be optimized.  Couldn't we hide
> the entry count into some config option which is only set if a FS needs a
> larger block size on a HIGHMEM system?

"any foreseeable need"?  I mean ... I'd like to support 2MB folios,
even on HIGHMEM machines, and that's 512 entries.  If we're doing
memcpy_to_folio(), we know that's only one mapping, but still, 512
entries is _a lot_ of address space to be reserving on a 32-bit machine.
I don't know exactly what the address space layout is on x86-PAE or
ARM-PAE these days, but as I recall, the low 3GB is user and the high
1GB is divided between LOWMEM and VMAP space; something like 800MB of
LOWMEM and 200MB of vmap/kmap/PCI iomem/...

Where I think we can absolutely get away with this reasoning is having
a kmap_local_buffer().  It's perfectly reasonable to restrict fs block
size to 64kB (after all, we've been limiting it to 4kB on x86 for thirty
years), and having a __kmap_local_pfns(pfn, n, prot) doesn't seem like
a terribly bad idea to me.

So ... is this our path forward:

 - Introduce a complex memcpy_to/from_folio() in highmem.c that mirrors
   zero_user_segments()
 - Have a simple memcpy_to/from_folio() in highmem.h that mirrors
   zero_user_segments()
 - Convert __kmap_local_pfn_prot() to __kmap_local_pfns()
 - Add kmap_local_buffer() that can handle buffer_heads up to, say, 16x
   PAGE_SIZE
