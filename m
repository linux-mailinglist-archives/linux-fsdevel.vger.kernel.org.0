Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8632C5CDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 21:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390908AbgKZUHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 15:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389989AbgKZUHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 15:07:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803C0C0613D4;
        Thu, 26 Nov 2020 12:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Oynq0P9qwAVLUJIozexhIrD4X8bgYbBxQMqU661Oro=; b=OaYSyI+vbas3gKInvB8tgJHU8U
        l3DfxHSKXTg2R3LKiX/4ZCz6NO6M4ChYqZT0FYtOucI3gQrQwNa+4Zww5X3C68bEAsgKR5DqOGRK4
        39NtnKv8nH05FPs1KJMB9wLgSPD3GTLyy89krwdar7NcUpJLoWYe+N88Mily9LvWE2bYVWpsajx5P
        vZsYT+um7imRp+bdpL6l93jEXbrhhmtl9Mvb45DTbxUHZc6CkB8R68o8NrXnr3rXCM34vifKg0Qan
        jf2Brgc1lKnwuxlJL9nkafnTa53Vs+hSRBKKAplJuDnsDqQjd9sR7m5eB1IuWdKrin3lowD9WIPmA
        eNgr5X3g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiNXj-0005L2-5Z; Thu, 26 Nov 2020 20:07:03 +0000
Date:   Thu, 26 Nov 2020 20:07:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, dchinner@redhat.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
Message-ID: <20201126200703.GW4327@casper.infradead.org>
References: <alpine.LSU.2.11.2011160128001.1206@eggly.anvils>
 <20201117153947.GL29991@casper.infradead.org>
 <alpine.LSU.2.11.2011170820030.1014@eggly.anvils>
 <20201117191513.GV29991@casper.infradead.org>
 <20201117234302.GC29991@casper.infradead.org>
 <20201125023234.GH4327@casper.infradead.org>
 <20201125150859.25adad8ff64db312681184bd@linux-foundation.org>
 <CANsGZ6a95WK7+2H4Zyg5FwDxhdJQqR8nKND1Cn6r6e3QxWeW4Q@mail.gmail.com>
 <20201126121546.GN4327@casper.infradead.org>
 <alpine.LSU.2.11.2011261101230.2851@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2011261101230.2851@eggly.anvils>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 26, 2020 at 11:24:59AM -0800, Hugh Dickins wrote:
> On Thu, 26 Nov 2020, Matthew Wilcox wrote:
> > On Wed, Nov 25, 2020 at 04:11:57PM -0800, Hugh Dickins wrote:
> > > > +                               index = truncate_inode_partial_page(mapping,
> > > > +                                               page, lstart, lend);
> > > > +                               if (index > end)
> > > > +                                       end = indices[i] - 1;
> > > >                         }
> > > > -                       unlock_page(page);
> > > 
> > > The fix needed is here: instead of deleting that unlock_page(page)
> > > line, it needs to be } else { unlock_page(page); }
> > 
> > It also needs a put_page(page);
> 
> Oh yes indeed, sorry for getting that wrong.  I'd misread the
> pagevec_reinit() at the end as the old pagevec_release().  Do you
> really need to do pagevec_remove_exceptionals() there if you're not
> using pagevec_release()?

Oh, good point!

> > That's now taken care of by truncate_inode_partial_page(), so if we're
> > not calling that, we need to put the page as well.  ie this:
> 
> Right, but I do find it confusing that truncate_inode_partial_page()
> does the unlock_page(),put_page() whereas truncate_inode_page() does
> not: I think you would do better to leave them out of _partial_page(),
> even if including them there saves a couple of lines somewhere else.

I agree; I don't love it.  The only reason I moved them in there was
because after calling split_huge_page(), we have to call unlock_page();
put_page(); on the former-tail-page-that-is-now-partial, not on the
head page.

Hm, what I could do is return the struct page which is now the partial
page.  Why do I never think of these things before posting?  I'll see
how that works out.

> But right now it's the right fix that's important: ack to yours below.
> 
> I've not yet worked out the other issues I saw: will report when I have.
> Rebooted this laptop, pretty sure it missed freeing a shmem swap entry,
> not yet reproduced, will study the change there later, but the non-swap 
> hang in generic/476 (later seen also in generic/112) more important.

The good news is that I've sorted out the SCRATCH_DEV issue with
running xfstests.  The bad news is that (even on an unmodified kernel),
generic/027 takes 19 hours to run.  On xfs, it's 4 minutes.  Any idea
why it's so slow on tmpfs?
