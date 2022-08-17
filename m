Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C4C5976D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 21:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbiHQTjV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 15:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiHQTjT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:39:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197C59AFC9
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WoWmxJLPPEJlc4MBe2emZrwXtinJcbksNx6kTZ5w/4A=; b=iRPQe+BSxKxiS/k952a8GmKJ3d
        mMV5tkdL9WTH1tdiBGm3mceFXv6TMrZH5BYCu2aUdp8LJMqbNlzCkVjoOOy12TluIcrKBOiHVs2ap
        yMBLC1IrclJnfO6zSsdWaRjrEfdIUVdVKrZl550Mxl3L3G3Fvw2gYmM9HgsQiIWWLexjsJrKShwa4
        P8IxH9SdmA1EDFO1d8+peik1zN2RnA1JRP3tWjkhigq6nIRVNSAsOIQAI0x4Mi/CFEGbQZ7rVDZ8B
        /1kZK81K3OXAo8h0YaqZPh1UhhpOLeF2IE7dZaoFFZG0cDSDEZO+EwRt9QR4KJy8hkI1FOV0VYok6
        SRwQuqdg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOOsO-008cve-BL; Wed, 17 Aug 2022 19:38:52 +0000
Date:   Wed, 17 Aug 2022 20:38:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: folio_map
Message-ID: <Yv1DzKKzkDjwVuKV@casper.infradead.org>
References: <YvvdFrtiW33UOkGr@casper.infradead.org>
 <20220817102935.cqcqpmuu3vanfb63@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817102935.cqcqpmuu3vanfb63@box.shutemov.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 01:29:35PM +0300, Kirill A. Shutemov wrote:
> On Tue, Aug 16, 2022 at 07:08:22PM +0100, Matthew Wilcox wrote:
> > Some of you will already know all this, but I'll go into a certain amount
> > of detail for the peanut gallery.
> > 
> > One of the problems that people want to solve with multi-page folios
> > is supporting filesystem block sizes > PAGE_SIZE.  Such filesystems
> > already exist; you can happily create a 64kB block size filesystem on
> > a PPC/ARM/... today, then fail to mount it on an x86 machine.
> > 
> > kmap_local_folio() only lets you map a single page from a folio.
> > This works for the majority of cases (eg ->write_begin() works on a
> > per-page basis *anyway*, so we can just map a single page from the folio).
> > But this is somewhat hampering for ext2_get_page(), used for directory
> > handling.  A directory record may cross a page boundary (because it
> > wasn't a page boundary on the machine which created the filesystem),
> > and juggling two pages being mapped at once is tricky with the stack
> > model for kmap_local.
> > 
> > I don't particularly want to invest heavily in optimising for HIGHMEM.
> > The number of machines which will use multi-page folios and HIGHMEM is
> > not going to be large, one hopes, as 64-bit kernels are far more common.
> > I'm happy for 32-bit to be slow, as long as it works.
> > 
> > For these reasons, I proposing the logical equivalent to this:
> > 
> > +void *folio_map_local(struct folio *folio)
> > +{
> > +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> > +               return folio_address(folio);
> > +       if (!folio_test_large(folio))
> > +               return kmap_local_page(&folio->page);
> > +       return vmap_folio(folio);
> > +}
> > +
> > +void folio_unmap_local(const void *addr)
> > +{
> > +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> > +               return;
> > +       if (is_vmalloc_addr(addr))
> > +               vunmap(addr);
> > +	else
> > +       	kunmap_local(addr);
> > +}
> > 
> > (where vmap_folio() is a new function that works a lot like vmap(),
> > chunks of this get moved out-of-line, etc, etc., but this concept)
> 
> So it aims at replacing kmap_local_page(), but for folios, right?
> kmap_local_page() interface can be used from any context, but vmap helpers
> might_sleep(). How do we rectify this?

I'm not proposing getting rid of kmap_local_folio().  That should still
exist and work for users who need to use it in atomic context.  Indeed,
I'm intending to put a note in the doc for folio_map_local() suggesting
that users may prefer to use kmap_local_folio().  Good idea to put a
might_sleep() in folio_map_local() though.
