Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8160A39432C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 15:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhE1NHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 09:07:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:60786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234224AbhE1NHT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 09:07:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622207143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qP6qh/m621ZycGy72wfyobP44v85NyyRRCeimgviInw=;
        b=pEo1UPtzuo+xqh+4/GraukeK5luXAt5NJpAxW4+TnRsKs72SBewhYgcixhEkGZaBNqFfNB
        NqshIvYeSVfq2s2NnS/VO04PjPRxX1AfhKG/6+KiMGA4cJ6diF2+b5QUOJORK+hZkt/yFq
        lvlEZLtPQDajD+1YBUSV6WBgSNgKI/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622207143;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qP6qh/m621ZycGy72wfyobP44v85NyyRRCeimgviInw=;
        b=OHtutEfVEsUUJ06h8/TcKQkBsUOJiYeRs4pLknxFYYOEkTWs419PxE+nFXXL1c0nKIbnwI
        lvBaNmZ7Dw6YohAA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97338AD80;
        Fri, 28 May 2021 13:05:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 59BD81E0D30; Fri, 28 May 2021 15:05:43 +0200 (CEST)
Date:   Fri, 28 May 2021 15:05:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v5 2/2] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <20210528130543.GB28653@quack2.suse.cz>
References: <20210526222557.3118114-1-guro@fb.com>
 <20210526222557.3118114-3-guro@fb.com>
 <20210527112403.GC24486@quack2.suse.cz>
 <YK/bi1OU7bNgPBab@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK/bi1OU7bNgPBab@carbon.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 27-05-21 10:48:59, Roman Gushchin wrote:
> On Thu, May 27, 2021 at 01:24:03PM +0200, Jan Kara wrote:
> > On Wed 26-05-21 15:25:57, Roman Gushchin wrote:
> > > Asynchronously try to release dying cgwbs by switching clean attached
> > > inodes to the bdi's wb. It helps to get rid of per-cgroup writeback
> > > structures themselves and of pinned memory and block cgroups, which
> > > are way larger structures (mostly due to large per-cpu statistics
> > > data). It helps to prevent memory waste and different scalability
> > > problems caused by large piles of dying cgroups.
> > > 
> > > A cgwb cleanup operation can fail due to different reasons (e.g. the
> > > cgwb has in-glight/pending io, an attached inode is locked or isn't
> > > clean, etc). In this case the next scheduled cleanup will make a new
> > > attempt. An attempt is made each time a new cgwb is offlined (in other
> > > words a memcg and/or a blkcg is deleted by a user). In the future an
> > > additional attempt scheduled by a timer can be implemented.
> > > 
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > ---
> > >  fs/fs-writeback.c                | 35 ++++++++++++++++++
> > >  include/linux/backing-dev-defs.h |  1 +
> > >  include/linux/writeback.h        |  1 +
> > >  mm/backing-dev.c                 | 61 ++++++++++++++++++++++++++++++--
> > >  4 files changed, 96 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > > index 631ef6366293..8fbcd50844f0 100644
> > > --- a/fs/fs-writeback.c
> > > +++ b/fs/fs-writeback.c
> > > @@ -577,6 +577,41 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> > >  	kfree(isw);
> > >  }
> > >  
> > > +/**
> > > + * cleanup_offline_wb - detach associated clean inodes
> > > + * @wb: target wb
> > > + *
> > > + * Switch the inode->i_wb pointer of the attached inodes to the bdi's wb and
> > > + * drop the corresponding per-cgroup wb's reference. Skip inodes which are
> > > + * dirty, freeing, in the active writeback process or are in any way busy.
> > 
> > I think the comment doesn't match the function anymore.
> > 
> > > + */
> > > +void cleanup_offline_wb(struct bdi_writeback *wb)
> > > +{
> > > +	struct inode *inode, *tmp;
> > > +
> > > +	spin_lock(&wb->list_lock);
> > > +restart:
> > > +	list_for_each_entry_safe(inode, tmp, &wb->b_attached, i_io_list) {
> > > +		if (!spin_trylock(&inode->i_lock))
> > > +			continue;
> > > +		xa_lock_irq(&inode->i_mapping->i_pages);
> > > +		if ((inode->i_state & I_REFERENCED) != I_REFERENCED) {
> > 
> > Why the I_REFERENCED check here? That's just inode aging bit and I have
> > hard time seeing how it would relate to whether inode should switch wbs...
> 
> What I tried to say (and failed :) ) was that I_REFERENCED is the only accepted
> flag here. So there must be
> 	if ((inode->i_state | I_REFERENCED) != I_REFERENCED)
> 
> Does this look good or I am wrong and there are other flags acceptable here?

Ah, I see. That makes more sense. I guess you could also exclude I_DONTCACHE
and I_OVL_INUSE but that's not that important.

> > > +			struct bdi_writeback *bdi_wb = &inode_to_bdi(inode)->wb;
> > > +
> > > +			WARN_ON_ONCE(inode->i_wb != wb);
> > > +
> > > +			inode->i_wb = bdi_wb;
> > > +			list_del_init(&inode->i_io_list);
> > > +			wb_put(wb);
> > 
> > I was kind of hoping you'll use some variant of inode_switch_wbs() here.
> 
> My reasoning was that by definition inode_switch_wbs() handles dirty inodes,
> while in the cleanup case we can deal only with clean inodes and clean wb's.
> Hopefully this can make the whole procedure simpler/cheaper. Also, the number
> of simultaneous switches is limited and I don't think cleanups should share
> this limit.
> However I agree that it would be nice to share at least some code.

I agree limits on parallel switches should not apply. Otherwise I agree
some bits of inode_switch_wbs_work_fn() should not be strictly necessary
but they should be pretty cheap anyway.

> > That way we have single function handling all the subtleties of switching
> > inode->i_wb of an active inode. Maybe it isn't strictly needed here because
> > you detach only from b_attached list and move to bdi_wb so things are
> > indeed simpler here. But you definitely miss transferring WB_WRITEBACK stat
> > and I'd also like to have a comment here explaining why this cannot race
> > with other writeback handling or wb switching in a harmful way.
> 
> If we'll check under wb->list_lock that wb has no inodes on any writeback
> lists (excluding b_attached), doesn't it mean that WB_WRITEBACK must be
> 0?

No, pages under writeback are not reflected in inode->i_state in any way.
You would need to check mapping_tagged(inode->i_mapping,
PAGECACHE_TAG_WRITEBACK) to find that out. But if you'd use
inode_switch_wbs_work_fn() you wouldn't even have to be that careful when
switching inodes as it can handle alive inodes just fine...

> Re racing: my logic here was that we're taking all possible locks before doing
> anything and then we check that the inode is entirely clean, so this must be
> safe:
> 	spin_lock(&wb->list_lock);
> 	spin_trylock(&inode->i_lock);
> 	xa_lock_irq(&inode->i_mapping->i_pages);
> 	...
> 
> But now I see that the unlocked inode's wb access mechanism
> (unlocked_inode_to_wb_begin()/end()) probably requires additional care.

Yeah, exactly corner case like this were not quite clear to me whether you
have them correct or not.

> Repeating the mechanism with scheduling the switching of each inode separately
> after an rcu grace period looks too slow. Maybe we can mark all inodes at once
> and then switch them all at once, all in two steps. I need to think more.
> Do you have any ideas/suggestions here?

Nothing really bright. As you say I'd do this in batches - i.e., tag all
inodes for switching with I_WB_SWITCH, then synchronize_rcu(), then call
inode_switch_wbs_work_fn() for each inode (or probably some helper function
that has guts of inode_switch_wbs_work_fn() as we probably don't want to
acquire wb->list_lock's and wb_switch_rwsem repeatedly unnecessarily).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
