Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBC62D5355
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 06:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbgLJFfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 00:35:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:10358 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732626AbgLJFfr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 00:35:47 -0500
IronPort-SDR: apkUXebfKtTQAwTGRF6q7DTpcoDymIU77L92wTWbomsjDNBNs6IgEJdl+zuUsX7lF3w8DpFKwy
 HBELpZhcSWOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="174316243"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="174316243"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 21:35:02 -0800
IronPort-SDR: DuJBYF9pTJBnrPYlJTS2GJJytOTdUk9xbWXRB0CHvkyy7BDBnjsoSLyWENToJpO8RlXj0UMDzR
 rJYlU5tdC3kA==
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="408392632"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 21:35:02 -0800
Date:   Wed, 9 Dec 2020 21:35:02 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
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
Message-ID: <20201210053502.GS1563847@iweiny-DESK2.sc.intel.com>
References: <20201208213255.GO1563847@iweiny-DESK2.sc.intel.com>
 <20201208215028.GK7338@casper.infradead.org>
 <CAPcyv4irF7YoEjOZ1iOrPPJDsw_-j4kiaqz_6Gf=cz1y3RpdoQ@mail.gmail.com>
 <20201208223234.GL7338@casper.infradead.org>
 <20201208224555.GA605321@magnolia>
 <CAPcyv4jEmdfAz8foEUtDw4GEm2-+7J-4GULZ=6tCD+9K5CFzRw@mail.gmail.com>
 <20201209022250.GP1563847@iweiny-DESK2.sc.intel.com>
 <20201209040312.GN7338@casper.infradead.org>
 <CAPcyv4iD0eprWC_kMOdYdX-GvT-72OjZB-CKA9b5qV8BwNQ+6A@mail.gmail.com>
 <20201209201415.GT7338@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209201415.GT7338@casper.infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 08:14:15PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 09, 2020 at 11:47:56AM -0800, Dan Williams wrote:
> > On Tue, Dec 8, 2020 at 8:03 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > On Tue, Dec 08, 2020 at 06:22:50PM -0800, Ira Weiny wrote:
> > > > Therefore, I tend to agree with Dan that if anything is to be done it should be
> > > > a WARN_ON() which is only going to throw an error that something has probably
> > > > been wrong all along and should be fixed but continue running as before.
> > >
> > > Silent data corruption is for ever.  Are you absolutely sure nobody has
> > > done:
> > >
> > >         page = alloc_pages(GFP_HIGHUSER_MOVABLE, 3);
> > >         memcpy_to_page(page, PAGE_SIZE * 2, p, PAGE_SIZE * 2);
> > >
> > > because that will work fine if the pages come from ZONE_NORMAL and fail
> > > miserably if they came from ZONE_HIGHMEM.
> > 
> > ...and violently regress with the BUG_ON.
> 
> ... which is what we want, no?
> 
> > The question to me is: which is more likely that any bad usages have
> > been covered up by being limited to ZONE_NORMAL / 64-bit only, or that
> > silent data corruption has been occurring with no ill effects?
> 
> I wouldn't be at all surprised to learn that there is silent data
> corruption on 32-bit systems with HIGHMEM.  Would you?  How much testing
> do you do on 32-bit HIGHMEM systems?
> 
> Actually, I wouldn't be at all surprised if we can hit this problem today.
> Look at this:
> 
> size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
> {
>         char *to = addr;
>         if (unlikely(iov_iter_is_pipe(i))) {
>                 WARN_ON(1);
>                 return 0;
>         }
>         if (iter_is_iovec(i))
>                 might_fault();
>         iterate_and_advance(i, bytes, v,
>                 copyin((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
>                 memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
>                                  v.bv_offset, v.bv_len),
>                 memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
>         )
> 
>         return bytes;
> }
> EXPORT_SYMBOL(_copy_from_iter);
> 
> There's a lot of macrology in there, so for those following along who
> aren't familiar with the iov_iter code, if the iter is operating on a
> bvec, then iterate_and_advance() will call memcpy_from_page(), passing
> it the bv_page, bv_offset and bv_len stored in the bvec.  Since 2019,
> Linux has supported multipage bvecs (commit 07173c3ec276).  So bv_len
> absolutely *can* be > PAGE_SIZE.
> 
> Does this ever happen in practice?  I have no idea; I don't know whether
> any multipage BIOs are currently handed to copy_from_iter().  But I
> have no confidence in your audit if you didn't catch this one.

Ah...  This call site has been there since 2014 and is not a new caller I have
been 'auditing'.[1]

> 
> > > > FWIW I think this is a 'bad BUG_ON' use because we are "checking something that
> > > > we know we might be getting wrong".[1]  And because, "BUG() is only good for
> > > > something that never happens and that we really have no other option for".[2]
> > >
> > > BUG() is our only option here.  Both limiting how much we copy or
> > > copying the requested amount result in data corruption or leaking
> > > information to a process that isn't supposed to see it.
> > 
> > At a minimum I think this should be debated in a follow on patch to
> > add assertion checking where there was none before. There is no
> > evidence of a page being overrun in the audit Ira performed.
> 
> If we put in into a separate patch, someone will suggest backing out the
> patch which tells us that there's a problem.  You know, like this guy ...
> https://lore.kernel.org/linux-mm/CAPcyv4jNVroYmirzKw_=CsEixOEACdL3M1Wc4xjd_TFv3h+o8Q@mail.gmail.com/

I'm not following this.  Regardless I've already added the BUG_ON's.

Ira

[1]
commit 0dbca9a4b5d69a7e4b8c1d55b98312fcd9aafcf7
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Nov 27 14:26:43 2014 -0500

    iov_iter.c: convert copy_from_iter() to iterate_and_advance

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

