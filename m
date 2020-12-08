Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583E02D359B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 22:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbgLHVvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 16:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729323AbgLHVvR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 16:51:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF981C0613D6;
        Tue,  8 Dec 2020 13:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DYsse9W76whGjoHmMZxw0YkyPt6KIsCHj+NH/lrBlYk=; b=mOQ48H7nc0k+2I7h+BwMy31BfF
        iLgV3xXOj/eZBIhCmO04pdfv9GvFWSMrX2qxQshjy8AUM3ReRrPoG6rV1EHk0QjpD7LKkLC2EGjjJ
        Gp6da0OP6jYAn/Km9/LJIOcON3sVxc/nZdvk48uPMOm1B4FW8kj8aa66nn++vFIrgu8Y1DK/c16/3
        cIY4zZ7ROUZ2Fanqmyxf7pdiV571/TZjFwi1KUtWqzyDntnAXYqYQC5IgEmRsSA4hCeMYiNC5KVX5
        AkiUm1dJ/RUn5iku+DFhv4MmhJsVoArAtqjpfSEnUo36nTPHuarpty/BXFrSVwminLTxCGQKElOmO
        89Mu033Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmksO-0004D6-F3; Tue, 08 Dec 2020 21:50:28 +0000
Date:   Tue, 8 Dec 2020 21:50:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] mm/highmem: Lift memcpy_[to|from]_page to core
Message-ID: <20201208215028.GK7338@casper.infradead.org>
References: <20201207225703.2033611-1-ira.weiny@intel.com>
 <20201207225703.2033611-3-ira.weiny@intel.com>
 <20201207232649.GD7338@casper.infradead.org>
 <CAPcyv4hkY-9V5Rq5s=BRku2AeWYtgs9DuVXnhdEkara2NiN9Tg@mail.gmail.com>
 <20201207234008.GE7338@casper.infradead.org>
 <CAPcyv4g+NvdFO-Coe36mGqmp5v3ZtRCGziEoxsxLKmj5vPx7kA@mail.gmail.com>
 <20201208213255.GO1563847@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208213255.GO1563847@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 01:32:55PM -0800, Ira Weiny wrote:
> On Mon, Dec 07, 2020 at 03:49:55PM -0800, Dan Williams wrote:
> > On Mon, Dec 7, 2020 at 3:40 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Dec 07, 2020 at 03:34:44PM -0800, Dan Williams wrote:
> > > > On Mon, Dec 7, 2020 at 3:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Mon, Dec 07, 2020 at 02:57:03PM -0800, ira.weiny@intel.com wrote:
> > > > > > +static inline void memcpy_page(struct page *dst_page, size_t dst_off,
> > > > > > +                            struct page *src_page, size_t src_off,
> > > > > > +                            size_t len)
> > > > > > +{
> > > > > > +     char *dst = kmap_local_page(dst_page);
> > > > > > +     char *src = kmap_local_page(src_page);
> > > > >
> > > > > I appreciate you've only moved these, but please add:
> > > > >
> > > > >         BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
> > > >
> > > > I imagine it's not outside the realm of possibility that some driver
> > > > on CONFIG_HIGHMEM=n is violating this assumption and getting away with
> > > > it because kmap_atomic() of contiguous pages "just works (TM)".
> > > > Shouldn't this WARN rather than BUG so that the user can report the
> > > > buggy driver and not have a dead system?
> > >
> > > As opposed to (on a HIGHMEM=y system) silently corrupting data that
> > > is on the next page of memory?
> > 
> > Wouldn't it fault in HIGHMEM=y case? I guess not necessarily...
> > 
> > > I suppose ideally ...
> > >
> > >         if (WARN_ON(dst_off + len > PAGE_SIZE))
> > >                 len = PAGE_SIZE - dst_off;
> > >         if (WARN_ON(src_off + len > PAGE_SIZE))
> > >                 len = PAGE_SIZE - src_off;
> > >
> > > and then we just truncate the data of the offending caller instead of
> > > corrupting innocent data that happens to be adjacent.  Although that's
> > > not ideal either ... I dunno, what's the least bad poison to drink here?
> > 
> > Right, if the driver was relying on "corruption" for correct operation.
> > 
> > If corruption actual were happening in practice wouldn't there have
> > been screams by now? Again, not necessarily...
> > 
> > At least with just plain WARN the kernel will start screaming on the
> > user's behalf, and if it worked before it will keep working.
> 
> So I decided to just sleep on this because I was recently told to not introduce
> new WARN_ON's[1]
> 
> I don't think that truncating len is worth the effort.  The conversions being
> done should all 'work'  At least corrupting users data in the same way as it
> used to...  ;-)  I'm ok with adding the WARN_ON's and I have modified the patch
> to do so while I work through the 0-day issues.  (not sure what is going on
> there.)
> 
> However, are we ok with adding the WARN_ON's given what Greg KH told me?  This
> is a bit more critical than the PKS API in that it could result in corrupt
> data.

zero_user_segments contains:

        BUG_ON(end1 > page_size(page) || end2 > page_size(page));

These should be consistent.  I think we've demonstrated that there is
no good option here.
