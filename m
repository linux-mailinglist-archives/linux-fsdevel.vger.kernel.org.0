Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4FE8D95B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 17:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405058AbfJPPfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 11:35:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:43702 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405055AbfJPPfS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:35:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D3FCAC84;
        Wed, 16 Oct 2019 15:35:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F24491E482D; Wed, 16 Oct 2019 17:35:15 +0200 (CEST)
Date:   Wed, 16 Oct 2019 17:35:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     Eric Sandeen <sandeen@sandeen.net>, Jan Kara <jack@suse.cz>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH V2] fs: avoid softlockups in s_inodes iterators
Message-ID: <20191016153515.GA11388@quack2.suse.cz>
References: <a26fae1d-a741-6eb1-b460-968a3b97e238@redhat.com>
 <20191015073740.GA21550@quack2.suse.cz>
 <c3c6a9df-c4f5-7692-d8c0-3f6605a74ef4@sandeen.net>
 <20191016094237.GE30337@quack2.suse.cz>
 <3a175c93-d7b2-5afb-fc2c-69951eb17838@sandeen.net>
 <20191016134945.GD7198@quack2.suse.cz>
 <6ea5f881-7637-5b90-a0d4-499f6ffbfa90@sandeen.net>
 <9a1fc48d-807d-ecd2-5f84-35887c3d74f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a1fc48d-807d-ecd2-5f84-35887c3d74f7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 16-10-19 10:26:16, Eric Sandeen wrote:
> On 10/16/19 9:39 AM, Eric Sandeen wrote:
> > On 10/16/19 8:49 AM, Jan Kara wrote:
> >> On Wed 16-10-19 08:23:51, Eric Sandeen wrote:
> >>> On 10/16/19 4:42 AM, Jan Kara wrote:
> >>>> On Tue 15-10-19 21:36:08, Eric Sandeen wrote:
> >>>>> On 10/15/19 2:37 AM, Jan Kara wrote:
> >>>>>> On Mon 14-10-19 16:30:24, Eric Sandeen wrote:
> >>>>>>> Anything that walks all inodes on sb->s_inodes list without rescheduling
> >>>>>>> risks softlockups.
> >>>>>>>
> >>>>>>> Previous efforts were made in 2 functions, see:
> >>>>>>>
> >>>>>>> c27d82f fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
> >>>>>>> ac05fbb inode: don't softlockup when evicting inodes
> >>>>>>>
> >>>>>>> but there hasn't been an audit of all walkers, so do that now.  This
> >>>>>>> also consistently moves the cond_resched() calls to the bottom of each
> >>>>>>> loop in cases where it already exists.
> >>>>>>>
> >>>>>>> One loop remains: remove_dquot_ref(), because I'm not quite sure how
> >>>>>>> to deal with that one w/o taking the i_lock.
> >>>>>>>
> >>>>>>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> >>>>>>
> >>>>>> Thanks Eric. The patch looks good to me. You can add:
> >>>>>>
> >>>>>> Reviewed-by: Jan Kara <jack@suse.cz>
> >>>>>
> >>>>> thanks
> >>>>>
> >>>>>> BTW, I suppose you need to add Al to pickup the patch?
> >>>>>
> >>>>> Yeah (cc'd now)
> >>>>>
> >>>>> But it was just pointed out to me that if/when the majority of inodes
> >>>>> at umount time have i_count == 0, we'll never hit the resched in 
> >>>>> fsnotify_unmount_inodes() and may still have an issue ...
> >>>>
> >>>> Yeah, that's a good point. So that loop will need some further tweaking
> >>>> (like doing iget-iput dance in need_resched() case like in some other
> >>>> places).
> >>>
> >>> Well, it's already got an iget/iput for anything with i_count > 0.  But
> >>> as the comment says (and I think it's right...) doing an iget/iput
> >>> on i_count == 0 inodes at this point would be without SB_ACTIVE and the final
> >>> iput here would actually start evicting inodes in /this/ loop, right?
> >>
> >> Yes, it would but since this is just before calling evict_inodes(), I have
> >> currently hard time remembering why evicting inodes like that would be an
> >> issue.
> > 
> > Probably just weird to effectively evict all inodes prior to evict_inodes() ;)
> > 
> >>> I think we could (ab)use the lru list to construct a "dispose" list for
> >>> fsnotify processing as was done in evict_inodes...
> > 
> > [narrator: Eric's idea here is dumb and it won't work]
> > 
> >>> or maybe the two should be merged, and fsnotify watches could be handled
> >>> directly in evict_inodes.  But that doesn't feel quite right.
> >>
> >> Merging the two would be possible (and faster!) as well but I agree it
> >> feels a bit dirty :)
> > 
> > It's starting to look like maybe the only option...
> > 
> > I'll see if Al is willing to merge this patch as is for the simple "schedule
> > the big loops" and see about a 2nd patch on top to do more surgery for this
> > case.
> 
> Sorry for thinking out loud in public but I'm not too familiar with fsnotify, so
> I'm being timid.  However, since fsnotify_sb_delete() and evict_inodes() are working
> on orthogonal sets of inodes (fsnotify_sb_delete only cares about nonzero refcount,
> and evict_inodes only cares about zero refcount), I think we can just swap the order
> of the calls.  The fsnotify call will then have a much smaller list to walk
> (any refcounted inodes) as well.
> 
> I'll try to give this a test.

Yes, this should make the softlockup impossible to trigger in practice. So
agreed.

								Honza

> 
> diff --git a/fs/super.c b/fs/super.c
> index cfadab2cbf35..cd352530eca9 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -448,10 +448,12 @@ void generic_shutdown_super(struct super_block *sb)
>  		sync_filesystem(sb);
>  		sb->s_flags &= ~SB_ACTIVE;
>  
> -		fsnotify_sb_delete(sb);
>  		cgroup_writeback_umount();
>  
> +		/* evict all inodes with zero refcount */
>  		evict_inodes(sb);
> +		/* only nonzero refcount inodes can have marks */
> +		fsnotify_sb_delete(sb);
>  
>  		if (sb->s_dio_done_wq) {
>  			destroy_workqueue(sb->s_dio_done_wq);
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
