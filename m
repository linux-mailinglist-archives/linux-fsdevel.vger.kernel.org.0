Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C01C432EC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 08:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhJSHBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 03:01:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52374 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSHBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:01:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8524B2197E;
        Tue, 19 Oct 2021 06:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634626772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tWUYrvYFsmqj0rtE1yYDBB9n74JxtnDP+Db2R7/QIZk=;
        b=aOKILhuQ3bfvUS+uulyoyUwQPgpO7HbSEhf/Qg6dySM8FGEpcm+k1lR28mAXp0HBTon9vL
        8PkJYte5qeY7ri2k3Wvd1FWSq26EnbEBoc/DjuHwYSl5NRnjE3+RmqAybogg6PvMoZGXPb
        AGUfeDziG1cpHLYVPK7hNtwMMjRq3HA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 53C49A3B81;
        Tue, 19 Oct 2021 06:59:32 +0000 (UTC)
Date:   Tue, 19 Oct 2021 08:59:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC 1/3] mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc
Message-ID: <YW5s0qo64mFaQMQj@dhcp22.suse.cz>
References: <20211018114712.9802-1-mhocko@kernel.org>
 <20211018114712.9802-2-mhocko@kernel.org>
 <163460424165.17149.585825289709126969@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163460424165.17149.585825289709126969@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 19-10-21 11:44:01, Neil Brown wrote:
> On Mon, 18 Oct 2021, Michal Hocko wrote:
[...]
> > @@ -2930,8 +2932,24 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >  		goto fail;
> >  	}
> >  
> > -	if (vmap_pages_range(addr, addr + size, prot, area->pages,
> > -			page_shift) < 0) {
> > +	/*
> > +	 * page tables allocations ignore external gfp mask, enforce it
> > +	 * by the scope API
> > +	 */
> > +	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> > +		flags = memalloc_nofs_save();
> > +	else if (!(gfp_mask & (__GFP_FS | __GFP_IO)))
> 
> I would *much* rather this were written
> 
>         else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)

Sure, this looks better indeed.

> so that the comparison with the previous test is more obvious.  Ditto
> for similar code below.
> It could even be
> 
>    switch (gfp_mask & (__GFP_FS | __GFP_IO)) {
>    case __GFP__IO: flags = memalloc_nofs_save(); break;
>    case 0:         flags = memalloc_noio_save(); break;
>    }
> 
> But I'm not completely convinced that is an improvement.

I am not a great fan of this though.

> In terms of functionality this looks good.

Thanks for the review!

-- 
Michal Hocko
SUSE Labs
