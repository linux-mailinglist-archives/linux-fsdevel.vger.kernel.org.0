Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF1740C4ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 14:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbhIOMIL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 08:08:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47040 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbhIOMIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:08:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 828A72222D;
        Wed, 15 Sep 2021 12:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631707610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fDnJwjOe8KY66rlsqENGN+zFJLxyrN2ZFgm6GsdfZzA=;
        b=Dwkv4upqvT7mHsbyi5uLFUTgJbi154ACEvZLwjLSRW02FkkhAkT7U7o6i7Bv4eXyp43r3C
        aYuKnEevTaETf9LLr8C1roCbWfwg1Uq4MWQVGzHbeNMCYTyXTsfqC5FRS375fUjuQmDhQv
        Js/pS3+2I+z38LX5uIv0HsR+F5KBGzc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4F79BA3B8F;
        Wed, 15 Sep 2021 12:06:50 +0000 (UTC)
Date:   Wed, 15 Sep 2021 14:06:49 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] EXT4: Remove ENOMEM/congestion_wait() loops.
Message-ID: <YUHh2ddnJEDGI8YG@dhcp22.suse.cz>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838437.13293.14244628630141187199.stgit@noble.brown>
 <20210914163432.GR3828@suse.com>
 <163165609100.3992.1570739756456048657@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163165609100.3992.1570739756456048657@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-09-21 07:48:11, Neil Brown wrote:
> On Wed, 15 Sep 2021, Mel Gorman wrote:
> > On Tue, Sep 14, 2021 at 10:13:04AM +1000, NeilBrown wrote:
> > > Indefinite loops waiting for memory allocation are discouraged by
> > > documentation in gfp.h which says the use of __GFP_NOFAIL that it
> > > 
> > >  is definitely preferable to use the flag rather than opencode endless
> > >  loop around allocator.
> > > 
> > > Such loops that use congestion_wait() are particularly unwise as
> > > congestion_wait() is indistinguishable from
> > > schedule_timeout_uninterruptible() in practice - and should be
> > > deprecated.
> > > 
> > > So this patch changes the two loops in ext4_ext_truncate() to use
> > > __GFP_NOFAIL instead of looping.
> > > 
> > > As the allocation is multiple layers deeper in the call stack, this
> > > requires passing the EXT4_EX_NOFAIL flag down and handling it in various
> > > places.
> > > 
> > > Of particular interest is the ext4_journal_start family of calls which
> > > can now have EXT4_EX_NOFAIL 'or'ed in to the 'type'.  This could be seen
> > > as a blurring of types.  However 'type' is 8 bits, and EXT4_EX_NOFAIL is
> > > a high bit, so it is safe in practice.
> > > 
> > > jbd2__journal_start() is enhanced so that the gfp_t flags passed are
> > > used for *all* allocations.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > 
> > I'm not a fan. GFP_NOFAIL allows access to emergency reserves increasing
> > the risk of a livelock if memory is completely depleted where as some
> > callers can afford to wait.
> 
> Maybe we should wind back and focus on the documentation patches.
> As quoted above, mm.h says:
> 
> > >  is definitely preferable to use the flag rather than opencode endless
> > >  loop around allocator.
> 
> but you seem to be saying that is wrong.  I'd certainly like to get the
> documentation right before changing any code.
> 
> Why does __GFP_NOFAIL access the reserves? Why not require that the
> relevant "Try harder" flag (__GFP_ATOMIC or __GFP_MEMALLOC) be included
> with __GFP_NOFAIL if that is justified?

Does 5020e285856c ("mm, oom: give __GFP_NOFAIL allocations access to
memory reserves") help?

I would be worried to make the semantic even more complex than already
is. Access to memory reserves is an implementation detail that the page
allocator does currently. Callers shouldn't really be worried about
that. I do not ever remember any actual NOFAIL triggered memory
exhaustion. I have seen that to happen for unrestricted access to memory
reserves by OOM victim though. Hence cd04ae1e2dc8 ("mm, oom: do not rely
on TIF_MEMDIE for memory reserves access"). We can consider something
similar if NOFAIL allocation really tend to show a similar problem. We
do not want callers to care about OOM sitauations for this kind of
requests.

__GFP_NOFAIL | __GFP_HIGH is certainly something that is a valid usage
but I wouldn't base OOM behavior based on that.

> There are over 100 __GFP_NOFAIL allocation sites.  I don't feel like
> reviewing them all and seeing if any really need a try-harder flag.
> Can we rename __GFP_NOFAIL to __GFP_NEVERFAIL and then
> #define __GFP_NOFAIL (__GFP_NEVERFAIL | __GFP_ATOMIC)
> and encourage the use of __GFP_NEVERFAIL in future?

Doesn't this add even more complexity?

> When __GFP_NOFAIL loops, it calls congestion_wait() internally.  That
> certainly needs to be fixed and the ideas you present below are
> certainly worth considering when trying to understand how to address
> that.  I'd rather fix it once there in page_alloc.c rather then export a
> waiting API like congestion_wait().  That would provide more
> flexibility.  e.g.  a newly freed page could be handed directly back to
> the waiter.

Completely agreed here. We really do not want people to open code NOFAIL
unless they can do something really subsystem specific that would help
to make a forward progress.

-- 
Michal Hocko
SUSE Labs
