Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1CD433F72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 21:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbhJSTtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 15:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhJSTtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 15:49:16 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE817C06161C;
        Tue, 19 Oct 2021 12:47:02 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 204so8205591ljf.9;
        Tue, 19 Oct 2021 12:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dU9JPjCF/QTHYanK0ubxc1uDAVdt4MQo9gsrLFf8T0o=;
        b=CEnquVm6zuPjD6ToNyyTaUnJlEN5UdVTyHGgrKm9v3Ktx9ySAbGgNfBCkdj4kczwgU
         LQNfKvxWvfy2E7wchjG4g7r7gIwhyf2JzesOB44LHHFt3+1JiaC/CyNo69M4tjZ+Sf8Q
         UnoZsHYnCkHbe8CvEJwJR+pVwDG5iBcz/kvQzo/MI87j7tujktg+6qMK1cISrE+hXpeP
         q9MTPImuSAoK7OVSZa4g8Ao33xzUVQfnbmrwub2SHMkZH0h0Gw/CZjoDG+RL/KxUWjMN
         omKxddKgnIuHoAMBzQTpSI1usJd2ccvqcciMTcM+saI0ctVoJ0GUcI6gM+3H+gcUc2Ra
         fjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dU9JPjCF/QTHYanK0ubxc1uDAVdt4MQo9gsrLFf8T0o=;
        b=MhCyez7Dgl5Sg4B+9v+tPWFOv55/WDYNVoVT7kE0qenIhxRM0SeTz4QIGNP18lcbpX
         TgUDXQILYfDT+NgcMH7BeOQl7V/XTB8Hfq9XnprWN+BCnHz5AI0kBCQteD7tYlUHvo4o
         /7OCzQIJJu8nB3H/yHPA+WT72XqYLCP2vFqlFugbxh335hPNYEmcAz3OFOtRP1h0VVQI
         G4BDNo5Lx4qpI4F+XEBBcb3r5adseSL0kkGtHYwEY9XfWIC7w0xrNDYiiiTVQpJR7/ov
         1d+XtR0eEsH4s3wfzizinBCPEm8B2f5Bl5E9S6o7sQMQpuHN4rnEmzylYP018bvYy97b
         70ig==
X-Gm-Message-State: AOAM533t+2+Tza1DahSdJI4wQVCeFzvpk4ccS35EENdxOlToPw0m9UNX
        RI6siHtLRSlkvTViH2aa3QY=
X-Google-Smtp-Source: ABdhPJzveWHVkx2ylYoebfuMsa1JZePdpzsdY9LAzL7gLa4QSNKCJ1lYZ0HzeN378yYNoKs3GIgtrg==
X-Received: by 2002:a2e:2d12:: with SMTP id t18mr8541409ljt.254.1634672821174;
        Tue, 19 Oct 2021 12:47:01 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id x34sm6454lfa.170.2021.10.19.12.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 12:47:00 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 19 Oct 2021 21:46:58 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <20211019194658.GA1787@pc638.lan>
References: <20211018114712.9802-1-mhocko@kernel.org>
 <20211018114712.9802-3-mhocko@kernel.org>
 <20211019110649.GA1933@pc638.lan>
 <YW6xZ7vi/7NVzRH5@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW6xZ7vi/7NVzRH5@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 01:52:07PM +0200, Michal Hocko wrote:
> On Tue 19-10-21 13:06:49, Uladzislau Rezki wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > Dave Chinner has mentioned that some of the xfs code would benefit from
> > > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > > cannot fail and they do not fit into a single page.
> > > 
> > > The larg part of the vmalloc implementation already complies with the
> > > given gfp flags so there is no work for those to be done. The area
> > > and page table allocations are an exception to that. Implement a retry
> > > loop for those.
> > > 
> > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > ---
> > >  mm/vmalloc.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 7455c89598d3..3a5a178295d1 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2941,8 +2941,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > >  	else if (!(gfp_mask & (__GFP_FS | __GFP_IO)))
> > >  		flags = memalloc_noio_save();
> > >  
> > > -	ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> > > +	do {
> > > +		ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> > >  			page_shift);
> > > +	} while ((gfp_mask & __GFP_NOFAIL) && (ret < 0));
> > >  
> > >  	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> > >  		memalloc_nofs_restore(flags);
> > > @@ -3032,6 +3034,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
> > >  		warn_alloc(gfp_mask, NULL,
> > >  			"vmalloc error: size %lu, vm_struct allocation failed",
> > >  			real_size);
> > > +		if (gfp_mask && __GFP_NOFAIL)
> > > +			goto again;
> > >  		goto fail;
> > >  	}
> > >  
> > > -- 
> > > 2.30.2
> > > 
> > I have checked the vmap code how it aligns with the __GFP_NOFAIL flag.
> > To me it looks correct from functional point of view.
> > 
> > There is one place though it is kasan_populate_vmalloc_pte(). It does
> > not use gfp_mask, instead it directly deals with GFP_KERNEL for its
> > internal purpose. If it fails the code will end up in loping in the
> > __vmalloc_node_range().
> > 
> > I am not sure how it is important to pass __GFP_NOFAIL into KASAN code.
> > 
> > Any thoughts about it?
> 
> The flag itself is not really necessary down there as long as we
> guarantee that the high level logic doesn't fail. In this case we keep
> retrying at __vmalloc_node_range level which should be possible to cover
> all callers that can control gfp mask. I was thinking to put it into
> __get_vm_area_node but that was slightly more hairy and we would be
> losing the warning which might turn out being helpful in cases where the
> failure is due to lack of vmalloc space or similar constrain. Btw. do we
> want some throttling on a retry?
> 
I think adding kind of schedule() will not make things worse and in corner
cases could prevent a power drain by CPU. It is important for mobile devices. 

As for vmap space, it can be that a user specifies a short range that does
not contain any free area. In that case we might never return back to a caller.

Maybe add a good comment something like: think what you do when deal with the
__vmalloc_node_range() and __GFP_NOFAIL?

--
Vlad Rezki
