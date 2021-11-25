Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA5445D673
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 09:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347563AbhKYIvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 03:51:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40620 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352490AbhKYItv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 03:49:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1B12821B36;
        Thu, 25 Nov 2021 08:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637830000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cswIxoSlRlT63La6eOMo8YzRcdw09aN70/ZppeCVAcc=;
        b=nbG0J+pLA5AfBgyD3YVer5rSFRseQoG/ODIGX9H6d34Q2d/QfevBhdszMSYRPztsqvFq8o
        4arZ3AgMy7iJrwNY93edMm1iAE3FjJG/GI9nlpjT8ywie2QZZsoTg5jcx0sT499stoIEWP
        ay9fUr14Aoue2DyQdUP7QZ3/KYgJZdU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E3892A3B81;
        Thu, 25 Nov 2021 08:46:39 +0000 (UTC)
Date:   Thu, 25 Nov 2021 09:46:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YZ9Nb2XA/OGWL1zz@dhcp22.suse.cz>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan>
 <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
 <YZ6cfoQah8Wo1eSZ@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ6cfoQah8Wo1eSZ@pc638.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 24-11-21 21:11:42, Uladzislau Rezki wrote:
> On Tue, Nov 23, 2021 at 05:02:38PM -0800, Andrew Morton wrote:
> > On Tue, 23 Nov 2021 20:01:50 +0100 Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > > On Mon, Nov 22, 2021 at 04:32:31PM +0100, Michal Hocko wrote:
> > > > From: Michal Hocko <mhocko@suse.com>
> > > > 
> > > > Dave Chinner has mentioned that some of the xfs code would benefit from
> > > > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > > > cannot fail and they do not fit into a single page.
> > 
> > Perhaps we should tell xfs "no, do it internally".  Because this is a
> > rather nasty-looking thing - do we want to encourage other callsites to
> > start using it?
> > 
> > > > The large part of the vmalloc implementation already complies with the
> > > > given gfp flags so there is no work for those to be done. The area
> > > > and page table allocations are an exception to that. Implement a retry
> > > > loop for those.
> > > > 
> > > > Add a short sleep before retrying. 1 jiffy is a completely random
> > > > timeout. Ideally the retry would wait for an explicit event - e.g.
> > > > a change to the vmalloc space change if the failure was caused by
> > > > the space fragmentation or depletion. But there are multiple different
> > > > reasons to retry and this could become much more complex. Keep the retry
> > > > simple for now and just sleep to prevent from hogging CPUs.
> > > > 
> > 
> > Yes, the horse has already bolted.  But we didn't want that horse anyway ;)
> > 
> > I added GFP_NOFAIL back in the mesozoic era because quite a lot of
> > sites were doing open-coded try-forever loops.  I thought "hey, they
> > shouldn't be doing that in the first place, but let's at least
> > centralize the concept to reduce code size, code duplication and so
> > it's something we can now grep for".  But longer term, all GFP_NOFAIL
> > sites should be reworked to no longer need to do the retry-forever
> > thing.  In retrospect, this bright idea of mine seems to have added
> > license for more sites to use retry-forever.  Sigh.
> > 
> > > > +		if (nofail) {
> > > > +			schedule_timeout_uninterruptible(1);
> > > > +			goto again;
> > > > +		}
> > 
> > The idea behind congestion_wait() is to prevent us from having to
> > hard-wire delays like this.  congestion_wait(1) would sleep for up to
> > one millisecond, but will return earlier if reclaim events happened
> > which make it likely that the caller can now proceed with the
> > allocation event, successfully.
> > 
> > However it turns out that congestion_wait() was quietly broken at the
> > block level some time ago.  We could perhaps resurrect the concept at
> > another level - say by releasing congestion_wait() callers if an amount
> > of memory newly becomes allocatable.  This obviously asks for inclusion
> > of zone/node/etc info from the congestion_wait() caller.  But that's
> > just an optimization - if the newly-available memory isn't useful to
> > the congestion_wait() caller, they just fail the allocation attempts
> > and wait again.
> > 
> > > well that is sad...
> > > I have raised two concerns in our previous discussion about this change,
> > 
> > Can you please reiterate those concerns here?
> >
> 1. I proposed to repeat(if fails) in one solid place, i.e. get rid of
> duplication and spreading the logic across several places. This is about
> simplification.

I am all for simplifications. But the presented simplification lead to 2) and ...

> 2. Second one is about to do an unwinding and release everything what we
> have just accumulated in terms of memory consumption. The failure might
> occur, if so a condition we are in is a low memory one or high memory
> pressure. In this case, since we are about to sleep some milliseconds
> in order to repeat later, IMHO it makes sense to release memory:
> 
> - to prevent killing apps or possible OOM;
> - we can end up looping quite a lot of time or even forever if users do
>   nasty things with vmalloc API and __GFP_NOFAIL flag.

... this is where we disagree and I have tried to explain why. The primary
memory to allocate are pages to back the vmalloc area. Failing to
allocate few page tables - which btw. do not fail as they are order-0 -
and result into the whole and much more expensive work to allocate the
former is really wasteful. You've had a concern about OOM killer
invocation while retrying the page table allocation but you should
realize that page table allocations might already invoke OOM killer so that
is absolutely nothing new.
-- 
Michal Hocko
SUSE Labs
