Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA0E45E0EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 20:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242851AbhKYT0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 14:26:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49340 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbhKYTYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 14:24:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2AC7F212BD;
        Thu, 25 Nov 2021 19:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637868081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8azePtKmxMXIfEbKrI7iFZ6QX4F+81Lum/u6kAwGEE=;
        b=qBhNXr0FXgXEyWTrOen4WZ9Fua3qgP2gywveA8eBaJnz8dGtoJMm1jqCwDBuSa2ItuRauO
        Tf8o2XaQabb82yAQp0P4aMqE35COPWfAMzp1ELMULMdUVdPycaCnQGH+2n3P4DYx9GfkXA
        YM/jF5NORRfC14g+qWxidx0vhy2g9pU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D2741A3B81;
        Thu, 25 Nov 2021 19:21:20 +0000 (UTC)
Date:   Thu, 25 Nov 2021 20:21:20 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YZ/iMFXJzbfsy6WJ@dhcp22.suse.cz>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan>
 <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
 <YZ37IJq3+DrVhAcD@dhcp22.suse.cz>
 <YZ6iojllRBAAk8LW@pc638.lan>
 <YZ9N2I05NfureFuG@dhcp22.suse.cz>
 <CA+KHdyW6kS7dB95BOiNo5y5anfygB2OnJ0sOcw545s2_V1rfYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyW6kS7dB95BOiNo5y5anfygB2OnJ0sOcw545s2_V1rfYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 25-11-21 19:40:56, Uladzislau Rezki wrote:
> On Thu, Nov 25, 2021 at 9:48 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 24-11-21 21:37:54, Uladzislau Rezki wrote:
> > > On Wed, Nov 24, 2021 at 09:43:12AM +0100, Michal Hocko wrote:
> > > > On Tue 23-11-21 17:02:38, Andrew Morton wrote:
> > > > > On Tue, 23 Nov 2021 20:01:50 +0100 Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > >
> > > > > > On Mon, Nov 22, 2021 at 04:32:31PM +0100, Michal Hocko wrote:
> > > > > > > From: Michal Hocko <mhocko@suse.com>
> > > > > > >
> > > > > > > Dave Chinner has mentioned that some of the xfs code would benefit from
> > > > > > > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > > > > > > cannot fail and they do not fit into a single page.
> > > > >
> > > > > Perhaps we should tell xfs "no, do it internally".  Because this is a
> > > > > rather nasty-looking thing - do we want to encourage other callsites to
> > > > > start using it?
> > > >
> > > > This is what xfs is likely going to do if we do not provide the
> > > > functionality. I just do not see why that would be a better outcome
> > > > though. My longterm experience tells me that whenever we ignore
> > > > requirements by other subsystems then those requirements materialize in
> > > > some form in the end. In many cases done either suboptimaly or outright
> > > > wrong. This might be not the case for xfs as the quality of
> > > > implementation is high there but this is not the case in general.
> > > >
> > > > Even if people start using vmalloc(GFP_NOFAIL) out of lazyness or for
> > > > any other stupid reason then what? Is that something we should worry
> > > > about? Retrying within the allocator doesn't make the things worse. In
> > > > fact it is just easier to find such abusers by grep which would be more
> > > > elaborate with custom retry loops.
> > > >
> > > > [...]
> > > > > > > +             if (nofail) {
> > > > > > > +                     schedule_timeout_uninterruptible(1);
> > > > > > > +                     goto again;
> > > > > > > +             }
> > > > >
> > > > > The idea behind congestion_wait() is to prevent us from having to
> > > > > hard-wire delays like this.  congestion_wait(1) would sleep for up to
> > > > > one millisecond, but will return earlier if reclaim events happened
> > > > > which make it likely that the caller can now proceed with the
> > > > > allocation event, successfully.
> > > > >
> > > > > However it turns out that congestion_wait() was quietly broken at the
> > > > > block level some time ago.  We could perhaps resurrect the concept at
> > > > > another level - say by releasing congestion_wait() callers if an amount
> > > > > of memory newly becomes allocatable.  This obviously asks for inclusion
> > > > > of zone/node/etc info from the congestion_wait() caller.  But that's
> > > > > just an optimization - if the newly-available memory isn't useful to
> > > > > the congestion_wait() caller, they just fail the allocation attempts
> > > > > and wait again.
> > > >
> > > > vmalloc has two potential failure modes. Depleted memory and vmalloc
> > > > space. So there are two different events to wait for. I do agree that
> > > > schedule_timeout_uninterruptible is both ugly and very simple but do we
> > > > really need a much more sophisticated solution at this stage?
> > > >
> > > I would say there is at least one more. It is about when users set their
> > > own range(start:end) where to allocate. In that scenario we might never
> > > return to a user, because there might not be any free vmap space on
> > > specified range.
> > >
> > > To address this, we can allow __GFP_NOFAIL only for entire vmalloc
> > > address space, i.e. within VMALLOC_START:VMALLOC_END.
> >
> > How should we do that?
> >
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d2a00ad4e1dd..664935bee2a2 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3029,6 +3029,13 @@ void *__vmalloc_node_range(unsigned long size,
> unsigned long align,
>                 return NULL;
>         }
> 
> +       if (gfp_mask & __GFP_NOFAIL) {
> +               if (start != VMALLOC_START || end != VMALLOC_END) {
> +                       gfp_mask &= ~__GFP_NOFAIL;
> +                       WARN_ONCE(1, "__GFP_NOFAIL is allowed only for
> entire vmalloc space.");
> +               }
> +       }

So the called function effectivelly ignores the flag which could lead to
an actual failure and that is something the caller has told us not to
do. I do not consider such an API great, to say the least.

> +
>         if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP)) {
>                 unsigned long size_per_node;
> <snip>
> 
> Or just allow __GFP_NOFAIL flag usage only for a high level API, it is
> __vmalloc() one where
> gfp can be passed. Because it uses whole vmalloc address space, thus
> we do not need to
> check the range and other parameters like align, etc. This variant is
> preferable.
> 
> But the problem is that there are internal functions which are
> publicly available for kernel users like
> __vmalloc_node_range(). In that case we can add a big comment like:
> __GFP_NOFAIL flag can be
> used __only__ with high level API, i.e. __vmalloc() one.
> 
> Any thoughts?

I dunno. I find it rather ugly. We can surely document some APIs that
they shouldn't be used with __GFP_NOFAIL because they could result in an
endless loop but I find it rather subtle to change the contract under
the caller's feet and cause other problems.

I am rather curious about other opinions but at this moment this is
trying to handle a non existing problem IMHO. vmalloc and for that
matter other allocators are not trying to be defensive in API because we
assume in-kernel users to be good citizens.
-- 
Michal Hocko
SUSE Labs
