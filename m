Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5269C2D3550
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 22:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgLHVdg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 16:33:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:32713 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgLHVdg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 16:33:36 -0500
IronPort-SDR: VAhrJxpyKutXrvbmtA6v7zWLBfvVrMPWcbw3mLp1Yg5B2Xwl8CXA3UAdyONj9wF64o15ape3Sc
 iVz+iM5ZXafw==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="153212634"
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="153212634"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 13:32:56 -0800
IronPort-SDR: Y+f3DI1veGKmX6VjzcwgXkHwdnd1cjjstobayoJ4ZyEvwtexSao5eaJZ+ovVen+hnFysEG5mBK
 bfjh5UoYi3HQ==
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="437537590"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 13:32:55 -0800
Date:   Tue, 8 Dec 2020 13:32:55 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20201208213255.GO1563847@iweiny-DESK2.sc.intel.com>
References: <20201207225703.2033611-1-ira.weiny@intel.com>
 <20201207225703.2033611-3-ira.weiny@intel.com>
 <20201207232649.GD7338@casper.infradead.org>
 <CAPcyv4hkY-9V5Rq5s=BRku2AeWYtgs9DuVXnhdEkara2NiN9Tg@mail.gmail.com>
 <20201207234008.GE7338@casper.infradead.org>
 <CAPcyv4g+NvdFO-Coe36mGqmp5v3ZtRCGziEoxsxLKmj5vPx7kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g+NvdFO-Coe36mGqmp5v3ZtRCGziEoxsxLKmj5vPx7kA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 07, 2020 at 03:49:55PM -0800, Dan Williams wrote:
> On Mon, Dec 7, 2020 at 3:40 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Dec 07, 2020 at 03:34:44PM -0800, Dan Williams wrote:
> > > On Mon, Dec 7, 2020 at 3:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, Dec 07, 2020 at 02:57:03PM -0800, ira.weiny@intel.com wrote:
> > > > > +static inline void memcpy_page(struct page *dst_page, size_t dst_off,
> > > > > +                            struct page *src_page, size_t src_off,
> > > > > +                            size_t len)
> > > > > +{
> > > > > +     char *dst = kmap_local_page(dst_page);
> > > > > +     char *src = kmap_local_page(src_page);
> > > >
> > > > I appreciate you've only moved these, but please add:
> > > >
> > > >         BUG_ON(dst_off + len > PAGE_SIZE || src_off + len > PAGE_SIZE);
> > >
> > > I imagine it's not outside the realm of possibility that some driver
> > > on CONFIG_HIGHMEM=n is violating this assumption and getting away with
> > > it because kmap_atomic() of contiguous pages "just works (TM)".
> > > Shouldn't this WARN rather than BUG so that the user can report the
> > > buggy driver and not have a dead system?
> >
> > As opposed to (on a HIGHMEM=y system) silently corrupting data that
> > is on the next page of memory?
> 
> Wouldn't it fault in HIGHMEM=y case? I guess not necessarily...
> 
> > I suppose ideally ...
> >
> >         if (WARN_ON(dst_off + len > PAGE_SIZE))
> >                 len = PAGE_SIZE - dst_off;
> >         if (WARN_ON(src_off + len > PAGE_SIZE))
> >                 len = PAGE_SIZE - src_off;
> >
> > and then we just truncate the data of the offending caller instead of
> > corrupting innocent data that happens to be adjacent.  Although that's
> > not ideal either ... I dunno, what's the least bad poison to drink here?
> 
> Right, if the driver was relying on "corruption" for correct operation.
> 
> If corruption actual were happening in practice wouldn't there have
> been screams by now? Again, not necessarily...
> 
> At least with just plain WARN the kernel will start screaming on the
> user's behalf, and if it worked before it will keep working.

So I decided to just sleep on this because I was recently told to not introduce
new WARN_ON's[1]

I don't think that truncating len is worth the effort.  The conversions being
done should all 'work'  At least corrupting users data in the same way as it
used to...  ;-)  I'm ok with adding the WARN_ON's and I have modified the patch
to do so while I work through the 0-day issues.  (not sure what is going on
there.)

However, are we ok with adding the WARN_ON's given what Greg KH told me?  This
is a bit more critical than the PKS API in that it could result in corrupt
data.

Ira

[1] https://lore.kernel.org/linux-doc/20201103065024.GC75930@kroah.com/
