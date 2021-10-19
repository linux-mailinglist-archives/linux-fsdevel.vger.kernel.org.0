Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027DB43351A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 13:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbhJSLyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 07:54:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56924 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbhJSLyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:54:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A1E09219CA;
        Tue, 19 Oct 2021 11:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634644331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FVWDN88HfsUiEL7zxmKlDT6HLD9ZkADBiB3wYPzcH7E=;
        b=t+VtV7fiTS2AvdIyjZhEsc2AqFaI2gWH3wuHhskPNrJQdV6Jpe4AmxQV+JzrOjL5NemUve
        cbwMVATf/OboDPlyZwk4+96RMyqUKP89qkbA4E5M1QjDoTyC5pxR1X22cyKdCFFqFkzUZ9
        rXniS/u6//WEZRkRf6x+ZgxzPsq8hZM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 74929A3B8F;
        Tue, 19 Oct 2021 11:52:11 +0000 (UTC)
Date:   Tue, 19 Oct 2021 13:52:07 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YW6xZ7vi/7NVzRH5@dhcp22.suse.cz>
References: <20211018114712.9802-1-mhocko@kernel.org>
 <20211018114712.9802-3-mhocko@kernel.org>
 <20211019110649.GA1933@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019110649.GA1933@pc638.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 19-10-21 13:06:49, Uladzislau Rezki wrote:
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
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/vmalloc.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 7455c89598d3..3a5a178295d1 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2941,8 +2941,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >  	else if (!(gfp_mask & (__GFP_FS | __GFP_IO)))
> >  		flags = memalloc_noio_save();
> >  
> > -	ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> > +	do {
> > +		ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> >  			page_shift);
> > +	} while ((gfp_mask & __GFP_NOFAIL) && (ret < 0));
> >  
> >  	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> >  		memalloc_nofs_restore(flags);
> > @@ -3032,6 +3034,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
> >  		warn_alloc(gfp_mask, NULL,
> >  			"vmalloc error: size %lu, vm_struct allocation failed",
> >  			real_size);
> > +		if (gfp_mask && __GFP_NOFAIL)
> > +			goto again;
> >  		goto fail;
> >  	}
> >  
> > -- 
> > 2.30.2
> > 
> I have checked the vmap code how it aligns with the __GFP_NOFAIL flag.
> To me it looks correct from functional point of view.
> 
> There is one place though it is kasan_populate_vmalloc_pte(). It does
> not use gfp_mask, instead it directly deals with GFP_KERNEL for its
> internal purpose. If it fails the code will end up in loping in the
> __vmalloc_node_range().
> 
> I am not sure how it is important to pass __GFP_NOFAIL into KASAN code.
> 
> Any thoughts about it?

The flag itself is not really necessary down there as long as we
guarantee that the high level logic doesn't fail. In this case we keep
retrying at __vmalloc_node_range level which should be possible to cover
all callers that can control gfp mask. I was thinking to put it into
__get_vm_area_node but that was slightly more hairy and we would be
losing the warning which might turn out being helpful in cases where the
failure is due to lack of vmalloc space or similar constrain. Btw. do we
want some throttling on a retry?

It would be better if the kasan part dealt with gfp mask properly though
and something that we can do on top.

-- 
Michal Hocko
SUSE Labs
