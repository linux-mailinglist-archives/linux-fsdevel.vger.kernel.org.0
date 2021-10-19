Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605AA433465
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbhJSLJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 07:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbhJSLJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:09:05 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B54FC06161C;
        Tue, 19 Oct 2021 04:06:53 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id e19so5353954ljk.12;
        Tue, 19 Oct 2021 04:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tAD7zB8LM4f7YToBrIIqjU4Z5P1aP+J+3akIYooYFgI=;
        b=iMsktpTc9SPawOT2NakNmiXvq50ESMo7mzuI1jCaBysrlgBv00bjDX4DC74IDX0p/B
         IglEQEjsnbiXtKEm6Zf0FwxEH5OJmij/GKTFPdejO32sUW61IEVFjegxmb4BWA3tYzb4
         ALLA/mo0JWxOme4cySkma44ncYG5SPScsVbS9me4eSvF008gRa5nUBwnYI61GZwzVUGA
         CGdver6Za5JVZPGYjC6cEK/bL3kiGBW3ZMUZffBskeKLZBWthXF6ggAg+ZC5ruGpinpT
         WA0A2yf/luRwP6PJOKyXLU73pYzH4BF7j/sn2sruVrcnEPGE56t8pxlGTLdWHUAp9ckI
         sTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tAD7zB8LM4f7YToBrIIqjU4Z5P1aP+J+3akIYooYFgI=;
        b=x6wU+KGlCfrGj4ON2IgjbdfGBU0pG3YPu3rbl8QvJsU7yj9Nb90bWzGEVH2d6jVmk7
         swHRsOCoBpZsgTmYLyx+D8OS4YThufzQypD/4i7wQuUgdo+6po735K6Uczf+kbnuCs25
         StozQqgHnOaACFnWfK/o6hcA/1+DS3pHYVOutnNK7WoiHS1JN+d3LnRuJM0/jYEexFVh
         CIVi+ru15yH5NJOqnW6ACjpddHffUZ/vx+xoCDTJhs2KbxuN8kLbuQ2zGq4D6saAqmGn
         4uPWwk2blJLBL0bX1VDARfSGTilseVrQsSMs86ZWrtFfWjungv9uZsEgToyduDNnPgOq
         /heQ==
X-Gm-Message-State: AOAM530svpEps8APdjzG6LpyecqY+zctq2+u0GzKg1lBG+UmP7/keTor
        ZzXPlcamrCDwAn6cdZyk/48=
X-Google-Smtp-Source: ABdhPJyDg8JhJM+ACrmcGUWrMbttXSWDvW0F5ZT/zkT5/NpawPSvYfQ/Cb9JGS7Jdj2l9jPhGN8lhg==
X-Received: by 2002:a05:651c:1589:: with SMTP id h9mr6215602ljq.151.1634641611570;
        Tue, 19 Oct 2021 04:06:51 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id h25sm1911356ljg.24.2021.10.19.04.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 04:06:51 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 19 Oct 2021 13:06:49 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <20211019110649.GA1933@pc638.lan>
References: <20211018114712.9802-1-mhocko@kernel.org>
 <20211018114712.9802-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018114712.9802-3-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Michal Hocko <mhocko@suse.com>
> 
> Dave Chinner has mentioned that some of the xfs code would benefit from
> kvmalloc support for __GFP_NOFAIL because they have allocations that
> cannot fail and they do not fit into a single page.
> 
> The larg part of the vmalloc implementation already complies with the
> given gfp flags so there is no work for those to be done. The area
> and page table allocations are an exception to that. Implement a retry
> loop for those.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmalloc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 7455c89598d3..3a5a178295d1 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2941,8 +2941,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	else if (!(gfp_mask & (__GFP_FS | __GFP_IO)))
>  		flags = memalloc_noio_save();
>  
> -	ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> +	do {
> +		ret = vmap_pages_range(addr, addr + size, prot, area->pages,
>  			page_shift);
> +	} while ((gfp_mask & __GFP_NOFAIL) && (ret < 0));
>  
>  	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
>  		memalloc_nofs_restore(flags);
> @@ -3032,6 +3034,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, vm_struct allocation failed",
>  			real_size);
> +		if (gfp_mask && __GFP_NOFAIL)
> +			goto again;
>  		goto fail;
>  	}
>  
> -- 
> 2.30.2
> 
I have checked the vmap code how it aligns with the __GFP_NOFAIL flag.
To me it looks correct from functional point of view.

There is one place though it is kasan_populate_vmalloc_pte(). It does
not use gfp_mask, instead it directly deals with GFP_KERNEL for its
internal purpose. If it fails the code will end up in loping in the
__vmalloc_node_range().

I am not sure how it is important to pass __GFP_NOFAIL into KASAN code.

Any thoughts about it?

--
Vlad Rezki
