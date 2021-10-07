Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23944250B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 12:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbhJGKJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 06:09:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34754 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240540AbhJGKJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:09:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A9C7722526;
        Thu,  7 Oct 2021 10:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633601263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H4Ul2HxwLohvq2LxFkQLFFYYgikdgrah0DTLC7cFiY0=;
        b=quSKVcFrsqj8pOlL7N/kApBS4N4Hnnreq8O3OeVVlo2YqiBeMCubqiCrN23pnvEkGkRujC
        EbSln1J9I0kGz4w/KXsTVaUpaYrZ9GM4yb5q+leWfbR7h/2lWIE/KwUJw6YVdC1YBVkZ/q
        lkL9wAvpj+T7f2AX9jcpxm/i65rYKhY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5B313A3B81;
        Thu,  7 Oct 2021 10:07:43 +0000 (UTC)
Date:   Thu, 7 Oct 2021 12:07:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] MM: improve documentation for __GFP_NOFAIL
Message-ID: <YV7G7gyfZkmw7/Ae@dhcp22.suse.cz>
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>
 <163184741778.29351.16920832234899124642.stgit@noble.brown>
 <b680fb87-439b-0ba4-cf9f-33d729f27941@suse.cz>
 <YVwyhDnE/HEnoLAi@dhcp22.suse.cz>
 <eba04a07-99da-771a-ab6b-36de41f9f120@suse.cz>
 <20211006231452.GF54211@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006231452.GF54211@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 07-10-21 10:14:52, Dave Chinner wrote:
> On Tue, Oct 05, 2021 at 02:27:45PM +0200, Vlastimil Babka wrote:
> > On 10/5/21 13:09, Michal Hocko wrote:
> > > On Tue 05-10-21 11:20:51, Vlastimil Babka wrote:
> > > [...]
> > >> > --- a/include/linux/gfp.h
> > >> > +++ b/include/linux/gfp.h
> > >> > @@ -209,7 +209,11 @@ struct vm_area_struct;
> > >> >   * used only when there is no reasonable failure policy) but it is
> > >> >   * definitely preferable to use the flag rather than opencode endless
> > >> >   * loop around allocator.
> > >> > - * Using this flag for costly allocations is _highly_ discouraged.
> > >> > + * Use of this flag may lead to deadlocks if locks are held which would
> > >> > + * be needed for memory reclaim, write-back, or the timely exit of a
> > >> > + * process killed by the OOM-killer.  Dropping any locks not absolutely
> > >> > + * needed is advisable before requesting a %__GFP_NOFAIL allocate.
> > >> > + * Using this flag for costly allocations (order>1) is _highly_ discouraged.
> > >> 
> > >> We define costly as 3, not 1. But sure it's best to avoid even order>0 for
> > >> __GFP_NOFAIL. Advising order>1 seems arbitrary though?
> > > 
> > > This is not completely arbitrary. We have a warning for any higher order
> > > allocation.
> > > rmqueue:
> > > 	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> > 
> > Oh, I missed that.
> > 
> > > I do agree that "Using this flag for higher order allocations is
> > > _highly_ discouraged.
> > 
> > Well, with the warning in place this is effectively forbidden, not just
> > discouraged.
> 
> Yup, especially as it doesn't obey __GFP_NOWARN.
> 
> See commit de2860f46362 ("mm: Add kvrealloc()") as a direct result
> of unwittingly tripping over this warning when adding __GFP_NOFAIL
> annotations to replace open coded high-order kmalloc loops that have
> been in place for a couple of decades without issues.
> 
> Personally I think that the way __GFP_NOFAIL is first of all
> recommended over open coded loops and then only later found to be
> effectively forbidden and needing to be replaced with open coded
> loops to be a complete mess.

Well, there are two things. Opencoding something that _can_ be replaced
by __GFP_NOFAIL and those that cannot because the respective allocator
doesn't really support that semantic. kvmalloc is explicit about that
IIRC. If you have a better way to consolidate the documentation then I
am all for it.

> Not to mention on the impossibility of using __GFP_NOFAIL with
> kvmalloc() calls. Just what do we expect kmalloc_node(__GFP_NORETRY
> | __GFP_NOFAIL) to do, exactly?

This combination doesn't make any sense. Like others. Do you want us to
list all combinations that make sense?

> So, effectively, we have to open-code around kvmalloc() in
> situations where failure is not an option. Even if we pass
> __GFP_NOFAIL to __vmalloc(), it isn't guaranteed to succeed because
> of the "we won't honor gfp flags passed to __vmalloc" semantics it
> has.

yes vmalloc doesn't support nofail semantic and it is not really trivial
to craft it there.

> Even the API constaints of kvmalloc() w.r.t. only doing the vmalloc
> fallback if the gfp context is GFP_KERNEL - we already do GFP_NOFS
> kvmalloc via memalloc_nofs_save/restore(), so this behavioural
> restriction w.r.t. gfp flags just makes no sense at all.

GFP_NOFS (without using the scope API) has the same problem as NOFAIL in
the vmalloc. Hence it is not supported. If you use the scope API then
you can GFP_KERNEL for kvmalloc. This is clumsy but I am not sure how to
define these conditions in a more sensible way. Special case NOFS if the
scope api is in use? Why do you want an explicit NOFS then?

> That leads to us having to go back to writing extremely custom open
> coded loops to avoid awful high-order kmalloc direct reclaim
> behaviour and still fall back to vmalloc and to still handle NOFAIL
> semantics we need:
> 
> https://lore.kernel.org/linux-xfs/20210902095927.911100-8-david@fromorbit.com/

It would be more productive to get to MM people rather than rant on a
xfs specific patchse. Anyway, I can see a kvmalloc mode where the
kmalloc allocation would be really a very optimistic one - like your
effectively GFP_NOWAIT. Nobody has requested such a mode until now and I
am not sure how we would sensibly describe that by a gfp mask.

Btw. your GFP_NOWAIT | __GFP_NORETRY combination doesn't make any sense
in the allocator context as the later is a reclaim mofifier which
doesn't get applied when the reclaim is disabled (in your case by flags
&= ~__GFP_DIRECT_RECLAIM).

GFP flags are not that easy to build a coherent and usable apis.
Something we carry as a baggage for a long time.

> So, really, the problems are much deeper here than just badly
> documented, catch-22 rules for __GFP_NOFAIL - we can't even use
> __GFP_NOFAIL consistently across the allocation APIs because it
> changes allocation behaviours in unusable, self-defeating ways....

GFP_NOFAIL sucks. Not all allocator can follow it for practical
reasons. You are welcome to help document those awkward corner cases or
fix them up if you have a good idea how.

Thanks!
-- 
Michal Hocko
SUSE Labs
