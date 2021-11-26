Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E4245F05F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 16:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354200AbhKZPO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 10:14:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43698 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349785AbhKZPMy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:12:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DAB612191A;
        Fri, 26 Nov 2021 15:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637939380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cU0u1ErYfWJN1z5VHiy7kYCcJFmwRVG6KI1gkeUqUx0=;
        b=TUSWZNPKKrdfBXzvAGx2Kbhs53F5LWklUyEuRqQPxUekEie7Q6w4yPDHollgtu6eP+gCgL
        K5uEwT0vjdWFdbkK8Qft+2gUwGOg+9TNqkxKnIZSW7UX7Rbp8if6YunYiXYPNuviwBk2GC
        gDEv06tj/loWg8Mjz9BJZmUeDHJvkmo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BDE94A3B81;
        Fri, 26 Nov 2021 15:09:40 +0000 (UTC)
Date:   Fri, 26 Nov 2021 16:09:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YaD4tFV1P4vwBVEL@dhcp22.suse.cz>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan>
 <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
 <163772381628.1891.9102201563412921921@noble.neil.brown.name>
 <20211123194833.4711add38351d561f8a1ae3e@linux-foundation.org>
 <163773141164.1891.1440920123016055540@noble.neil.brown.name>
 <919f547e-beb7-34b7-7835-9e1625600323@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <919f547e-beb7-34b7-7835-9e1625600323@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 26-11-21 15:50:15, Vlastimil Babka wrote:
> On 11/24/21 06:23, NeilBrown wrote:
> >> 
> >> I forget why radix_tree_preload used a cpu-local store rather than a
> >> per-task one.
> >> 
> >> Plus "what order pages would you like" and "on which node" and "in
> >> which zone", etc...
> > 
> > "what order" - only order-0 I hope.  I'd hazard a guess that 90% of
> > current NOFAIL allocations only need one page (providing slub is used -
> > slab seems to insist on high-order pages sometimes).
> 
> Yeah AFAIK SLUB can prefer higher orders than SLAB, but also allows fallback
> to smallest order that's enough (thus 0 unless the objects are larger than a
> page).
> 
> > "which node" - whichever.  Unless __GFP_HARDWALL is set, alloc_page()
> > will fall-back to "whichever" anyway, and NOFAIL with HARDWALL is
> > probably a poor choice.
> > "which zone" - NORMAL.  I cannot find any NOFAIL allocations that want
> > DMA.  fs/ntfs asks for __GFP_HIGHMEM with NOFAIL, but that that doesn't
> > *requre* highmem.
> > 
> > Of course, before designing this interface too precisely we should check
> > if anyone can use it.  From a quick through the some of the 100-ish
> > users of __GFP_NOFAIL I'd guess that mempools would help - the
> > preallocation should happen at init-time, not request-time.  Maybe if we
> > made mempools even more light weight .... though that risks allocating a
> > lot of memory that will never get used.
> > 
> > This brings me back to the idea that
> >     alloc_page(wait and reclaim allowed)
> > should only fail on OOM_KILL.  That way kernel threads are safe, and
> > user-threads are free to return ENOMEM knowing it won't get to
> 
> Hm I thought that's already pretty much the case of the "too small to fail"
> of today. IIRC there's exactly that gotcha that OOM KILL can result in such
> allocation failure. But I believe that approach is rather fragile. If you
> encounter such an allocation not checking the resulting page != NULL, you
> can only guess which one is true:
> 
> - the author simply forgot to check at all
> - the author relied on "too small to fail" without realizing the gotcha
> - at the time of writing the code was verified that it can be only run in
> kernel thread context, not user and
>   - it is still true
>   - it stopped being true at some later point
>   - might be hard to even decide which is the case
> 
> IIRC at some point we tried to abolish the "too small to fail" rule because
> of this, but Linus denied that. But the opposite - make it hard guarantee in
> all cases - also didn't happen, so...

Yeah. IMHO we should treat each missing check for allocation failure
(except for GFP_NOFAIL) as a bug regardless the practical implementation
that say that small allocations do not fail. Because they can fail and
we should never subscribe to official support implicit non-fail
semantic.
-- 
Michal Hocko
SUSE Labs
