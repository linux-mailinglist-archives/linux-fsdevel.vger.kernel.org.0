Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A97F40D374
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 08:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhIPGxr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 02:53:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48426 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhIPGxr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:53:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BD63922324;
        Thu, 16 Sep 2021 06:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631775144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rgPYC/jO9gO7VeQL2HNt6VwK+j/K8XgK6Ia/iOSZmOA=;
        b=hyumKxv6Z1+GNRpK2emC5w8B+VLGOQafgHC+qT62hFQsVpViXyiB+mwGicPS7LoAcfjwD/
        OnsM+osaP8zGhyId8SbUcUt7jIxfG37qnmBQLJNvqD8YBhtYB1FqAqMxHRsalzcEFswLt2
        KT6QGXECdYCpeVo67h3EGaQ5VfNThQk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 59A0AA3B87;
        Thu, 16 Sep 2021 06:52:24 +0000 (UTC)
Date:   Thu, 16 Sep 2021 08:52:23 +0200
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
Message-ID: <YULpp4gVgZSuH65/@dhcp22.suse.cz>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
 <163157838437.13293.14244628630141187199.stgit@noble.brown>
 <20210914163432.GR3828@suse.com>
 <163165609100.3992.1570739756456048657@noble.neil.brown.name>
 <YUHh2ddnJEDGI8YG@dhcp22.suse.cz>
 <163174534006.3992.15394603624652359629@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163174534006.3992.15394603624652359629@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-09-21 08:35:40, Neil Brown wrote:
> On Wed, 15 Sep 2021, Michal Hocko wrote:
> > On Wed 15-09-21 07:48:11, Neil Brown wrote:
> > > 
> > > Why does __GFP_NOFAIL access the reserves? Why not require that the
> > > relevant "Try harder" flag (__GFP_ATOMIC or __GFP_MEMALLOC) be included
> > > with __GFP_NOFAIL if that is justified?
> > 
> > Does 5020e285856c ("mm, oom: give __GFP_NOFAIL allocations access to
> > memory reserves") help?
> 
> Yes, that helps.  A bit.
> 
> I'm not fond of the clause "the allocation request might have come with some
> locks held".  What if it doesn't?  Does it still have to pay the price.
> 
> Should we not require that the caller indicate if any locks are held?

I do not think this would help much TBH. What if the lock in question
doesn't impose any dependency through allocation problem?

> That way callers which don't hold locks can use __GFP_NOFAIL without
> worrying about imposing on other code.
> 
> Or is it so rare that __GFP_NOFAIL would be used without holding a lock
> that it doesn't matter?
> 
> The other commit of interest is
> 
> Commit: 6c18ba7a1899 ("mm: help __GFP_NOFAIL allocations which do not trigger OOM killer")
> 
> I don't find the reasoning convincing.  It is a bit like "Robbing Peter
> to pay Paul".  It takes from the reserves to allow a __GFP_NOFAIL to
> proceed, with out any reason to think this particular allocation has any
> more 'right' to the reserves than anything else.

I do agree that this is not really optimal. I do not remember exact
details but these changes were mostly based or inspired by extreme
memory pressure testing by Tetsuo who has managed to trigger quite some
corner cases. Especially those where NOFS was involved were problematic.

> While I don't like the reasoning in either of these, they do make it
> clear (to me) that the use of reserves is entirely an internal policy
> decision.  They should *not* be seen as part of the API and callers
> should not have to be concerned about it when deciding whether to use
> __GFP_NOFAIL or not.

Yes. NOFAIL should have high enough bar to use - essentially there is no
other way than use it - that memory reserves shouldn't be a road block.
If we learn that existing users can seriously deplete memory reserves
then we might need to reconsider the existing logic. So far there are no
indications that NOFAIL would really cause any problems in that area.

> The use of these reserves is, at most, a hypothetical problem.  If it
> ever looks like becoming a real practical problem, it needs to be fixed
> internally to the page allocator.  Maybe an extra water-mark which isn't
> quite as permissive as ALLOC_HIGH...
> 
> I'm inclined to drop all references to reserves from the documentation
> for __GFP_NOFAIL.

I have found your additions to the documentation useful.

> I think there are enough users already that adding a
> couple more isn't going to make problems substantially more likely.  And
> more will be added anyway that the mm/ team won't have the opportunity
> or bandwidth to review.
> 
> Meanwhile I'll see if I can understand the intricacies of alloc_page so
> that I can contibute to making it more predictable.
> 
> Question: In those cases where an open-coded loop is appropriate, such
> as when you want to handle signals or can drop locks, how bad would it
> be to have a tight loop without any sleep?
>
> should_reclaim_retry() will sleep 100ms (sometimes...).  Is that enough?
> __GFP_NOFAIL doesn't add any sleep when looping.

Yeah, NOFAIL doesn't add any explicit sleep points. In general there is
no guarantee that a sleepable allocation will sleep. We do cond_resched
in general but sleeping is enforced only for worker contexts because WQ
concurrency depends on an explicit sleeping. So to answer your question,
if you really need to sleep between retries then you should do it
manually but cond_resched can be implied.
-- 
Michal Hocko
SUSE Labs
