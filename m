Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4733B2D4B85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 21:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbgLIUPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 15:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730016AbgLIUPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:15:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E33C0613CF;
        Wed,  9 Dec 2020 12:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fB1ca+v0LuTk+STIe3QH7NAJWSISf+TmLjGbG0sNRFU=; b=QmFRfrUTe9D3AFHdF/jnceB22V
        NaOASlVyoW6ljHtnojtyogE91nwTI+VV02ykZFifhZ+kdsU6U4j7hVlF5yH/dDzeisiKfP2ex8QP4
        CWZAK0YwU3NG+aPBhfGhs5XahU6Kyn/0bB79m5UYOeczflCWikURV/oZ2SJ4vGZ57703r5pj0FtlN
        u9HN+ovwXIBcGNzGkRDuw/GZxCYraLeM1E3f8S25EpLTF39o/yciu4bieRiFLuHm0e1BVyKpo9d+A
        7waPlzz8HsHiHX3h8ZlUwOEzhQrHAGn0DJcjntys4HxUGcXdlR8+OWsffvl3tLU+PEyvIZrczaIG3
        lQmoTHcw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kn5qp-0006bu-4g; Wed, 09 Dec 2020 20:14:15 +0000
Date:   Wed, 9 Dec 2020 20:14:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
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
Message-ID: <20201209201415.GT7338@casper.infradead.org>
References: <CAPcyv4g+NvdFO-Coe36mGqmp5v3ZtRCGziEoxsxLKmj5vPx7kA@mail.gmail.com>
 <20201208213255.GO1563847@iweiny-DESK2.sc.intel.com>
 <20201208215028.GK7338@casper.infradead.org>
 <CAPcyv4irF7YoEjOZ1iOrPPJDsw_-j4kiaqz_6Gf=cz1y3RpdoQ@mail.gmail.com>
 <20201208223234.GL7338@casper.infradead.org>
 <20201208224555.GA605321@magnolia>
 <CAPcyv4jEmdfAz8foEUtDw4GEm2-+7J-4GULZ=6tCD+9K5CFzRw@mail.gmail.com>
 <20201209022250.GP1563847@iweiny-DESK2.sc.intel.com>
 <20201209040312.GN7338@casper.infradead.org>
 <CAPcyv4iD0eprWC_kMOdYdX-GvT-72OjZB-CKA9b5qV8BwNQ+6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iD0eprWC_kMOdYdX-GvT-72OjZB-CKA9b5qV8BwNQ+6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 11:47:56AM -0800, Dan Williams wrote:
> On Tue, Dec 8, 2020 at 8:03 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Tue, Dec 08, 2020 at 06:22:50PM -0800, Ira Weiny wrote:
> > > Therefore, I tend to agree with Dan that if anything is to be done it should be
> > > a WARN_ON() which is only going to throw an error that something has probably
> > > been wrong all along and should be fixed but continue running as before.
> >
> > Silent data corruption is for ever.  Are you absolutely sure nobody has
> > done:
> >
> >         page = alloc_pages(GFP_HIGHUSER_MOVABLE, 3);
> >         memcpy_to_page(page, PAGE_SIZE * 2, p, PAGE_SIZE * 2);
> >
> > because that will work fine if the pages come from ZONE_NORMAL and fail
> > miserably if they came from ZONE_HIGHMEM.
> 
> ...and violently regress with the BUG_ON.

... which is what we want, no?

> The question to me is: which is more likely that any bad usages have
> been covered up by being limited to ZONE_NORMAL / 64-bit only, or that
> silent data corruption has been occurring with no ill effects?

I wouldn't be at all surprised to learn that there is silent data
corruption on 32-bit systems with HIGHMEM.  Would you?  How much testing
do you do on 32-bit HIGHMEM systems?

Actually, I wouldn't be at all surprised if we can hit this problem today.
Look at this:

size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
{
        char *to = addr;
        if (unlikely(iov_iter_is_pipe(i))) {
                WARN_ON(1);
                return 0;
        }
        if (iter_is_iovec(i))
                might_fault();
        iterate_and_advance(i, bytes, v,
                copyin((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
                memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
                                 v.bv_offset, v.bv_len),
                memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
        )

        return bytes;
}
EXPORT_SYMBOL(_copy_from_iter);

There's a lot of macrology in there, so for those following along who
aren't familiar with the iov_iter code, if the iter is operating on a
bvec, then iterate_and_advance() will call memcpy_from_page(), passing
it the bv_page, bv_offset and bv_len stored in the bvec.  Since 2019,
Linux has supported multipage bvecs (commit 07173c3ec276).  So bv_len
absolutely *can* be > PAGE_SIZE.

Does this ever happen in practice?  I have no idea; I don't know whether
any multipage BIOs are currently handed to copy_from_iter().  But I
have no confidence in your audit if you didn't catch this one.

> > > FWIW I think this is a 'bad BUG_ON' use because we are "checking something that
> > > we know we might be getting wrong".[1]  And because, "BUG() is only good for
> > > something that never happens and that we really have no other option for".[2]
> >
> > BUG() is our only option here.  Both limiting how much we copy or
> > copying the requested amount result in data corruption or leaking
> > information to a process that isn't supposed to see it.
> 
> At a minimum I think this should be debated in a follow on patch to
> add assertion checking where there was none before. There is no
> evidence of a page being overrun in the audit Ira performed.

If we put in into a separate patch, someone will suggest backing out the
patch which tells us that there's a problem.  You know, like this guy ...
https://lore.kernel.org/linux-mm/CAPcyv4jNVroYmirzKw_=CsEixOEACdL3M1Wc4xjd_TFv3h+o8Q@mail.gmail.com/
