Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBFC43B72E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhJZQbW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 12:31:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45304 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhJZQbV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:31:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E34AA1FD40;
        Tue, 26 Oct 2021 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635265736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ep7pk0RtKoliHV+b3g2iUpg/poji2IQmV1gzXO0qnWE=;
        b=kMmZWqueBhX5qkInokZ0o0l7RV2i28bXS0DpgOS83UQYcXZHCreURWmgclPYO371JUJLW3
        maBub2+sDCUdnWOZC2rTlQF/1iwp/WKVPW/sEurcKN5vImo2WagqHHR2yAzr/Xhz4JXlxS
        O8tdi4PAUG5EqN6QIA0YaivsXY4YJBA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B326FA3B81;
        Tue, 26 Oct 2021 16:28:56 +0000 (UTC)
Date:   Tue, 26 Oct 2021 18:28:52 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YXgsxF/NRlHjH+Ng@dhcp22.suse.cz>
References: <20211025150223.13621-1-mhocko@kernel.org>
 <20211025150223.13621-3-mhocko@kernel.org>
 <CA+KHdyVqOuKny7bT+CtrCk8BrnARYz744Ze6cKMuy2BXo5e7jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyVqOuKny7bT+CtrCk8BrnARYz744Ze6cKMuy2BXo5e7jw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-10-21 17:48:32, Uladzislau Rezki wrote:
> > From: Michal Hocko <mhocko@suse.com>
> >
> > Dave Chinner has mentioned that some of the xfs code would benefit from
> > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > cannot fail and they do not fit into a single page.
> >
> > The larg part of the vmalloc implementation already complies with the
> > given gfp flags so there is no work for those to be done. The area
> > and page table allocations are an exception to that. Implement a retry
> > loop for those.
> >
> > Add a short sleep before retrying. 1 jiffy is a completely random
> > timeout. Ideally the retry would wait for an explicit event - e.g.
> > a change to the vmalloc space change if the failure was caused by
> > the space fragmentation or depletion. But there are multiple different
> > reasons to retry and this could become much more complex. Keep the retry
> > simple for now and just sleep to prevent from hogging CPUs.
> >
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/vmalloc.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index c6cc77d2f366..602649919a9d 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2941,8 +2941,12 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >         else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
> >                 flags = memalloc_noio_save();
> >
> > -       ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> > +       do {
> > +               ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> >                         page_shift);
> > +               if (ret < 0)
> > +                       schedule_timeout_uninterruptible(1);
> > +       } while ((gfp_mask & __GFP_NOFAIL) && (ret < 0));
> >
> 
> 1.
> After that change a below code:
> 
> <snip>
> if (ret < 0) {
>     warn_alloc(orig_gfp_mask, NULL,
>         "vmalloc error: size %lu, failed to map pages",
>         area->nr_pages * PAGE_SIZE);
>     goto fail;
> }
> <snip>
> 
> does not make any sense anymore.

Why? Allocations without __GFP_NOFAIL can still fail, no?

> 2.
> Can we combine two places where we handle __GFP_NOFAIL into one place?
> That would look like as more sorted out.

I have to admit I am not really fluent at vmalloc code so I wanted to
make the code as simple as possible. How would I unwind all the allocated
memory (already allocated as GFP_NOFAIL) before retrying at
__vmalloc_node_range (if that is what you suggest). And isn't that a
bit wasteful?

Or did you have anything else in mind?
-- 
Michal Hocko
SUSE Labs
