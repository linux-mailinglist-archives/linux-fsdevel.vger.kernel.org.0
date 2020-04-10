Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFAA1A47FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 17:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDJPwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 11:52:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgDJPwP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:52:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EDF15AE99;
        Fri, 10 Apr 2020 15:52:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CA8A61E1246; Fri, 10 Apr 2020 17:52:11 +0200 (CEST)
Date:   Fri, 10 Apr 2020 17:52:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        sandeen@sandeen.net
Subject: Re: [RFC 1/1] ext4: Fix race in
 ext4_mb_discard_group_preallocations()
Message-ID: <20200410155211.GC1443@quack2.suse.cz>
References: <cover.1586358980.git.riteshh@linux.ibm.com>
 <2e231c371cc83357a6c9d55e4f7284f6c1fb1741.1586358980.git.riteshh@linux.ibm.com>
 <20200409133719.GA18960@quack2.suse.cz>
 <20200409184545.7E0CBA4040@d06av23.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409184545.7E0CBA4040@d06av23.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hello Ritesh!

On Fri 10-04-20 00:15:44, Ritesh Harjani wrote:
> On 4/9/20 7:07 PM, Jan Kara wrote:
> > Hello Ritesh!
> > 
> > On Wed 08-04-20 22:24:10, Ritesh Harjani wrote:
> > > @@ -3908,16 +3919,13 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
> > >   	mb_debug(1, "discard preallocation for group %u\n", group);
> > > -	if (list_empty(&grp->bb_prealloc_list))
> > > -		return 0;
> > > -
> > 
> > OK, so ext4_mb_discard_preallocations() is now going to lock every group
> > when we try to discard preallocations. That's likely going to increase lock
> > contention on the group locks if we are running out of free blocks when
> > there are multiple processes trying to allocate blocks. I guess we don't
> > care about the performace of this case too deeply but I'm not sure if the
> > cost won't be too big - probably we should check how much the CPU usage
> > with multiple allocating process trying to find free blocks grows...
> 
> Sure let me check the cpu usage in my test case with this patch.
> But either ways unless we take the lock we are not able to confirm
> that what are no. of free blocks available in the filesystem, right?
> 
> This mostly will happen only when there are lot of threads and due to
> all of their preallocations filesystem is running into low space and
> hence
> trying to discard all the preallocations. => so when FS is going low on
> space, isn't this cpu usage justifiable? (in an attempt to make sure we
> don't fail with ENOSPC)?
> Maybe not since this is only due to spinlock case, is it?

As I wrote, I'm not too much concerned about *some* increase in CPU usage.
But I'd like to get that quantified because if we can say softlockup the
machine in the extreme case (or burn 100% of several CPUs spinning on the
lock), then we need a better mechanism to handle the preallocation
discarding and waiting...

> Or are you suggesting we should use some other method for discarding
> all the group's PA. So that other threads could sleep while discard is
> happening. Something like a discard work item which should free up
> all of the group's PA. But we need a way to determine if the needed
> no of blocks were freed so that we wake up and retry the allocation.
> 
> (Darrick did mentioned something on this line related to work/workqueue,
> but couldn't discuss much that time).
> 
> 
> > 
> > >   	bitmap_bh = ext4_read_block_bitmap(sb, group);
> > >   	if (IS_ERR(bitmap_bh)) {
> > >   		err = PTR_ERR(bitmap_bh);
> > >   		ext4_set_errno(sb, -err);
> > >   		ext4_error(sb, "Error %d reading block bitmap for %u",
> > >   			   err, group);
> > > -		return 0;
> > > +		goto out_dbg;
> > >   	}
> > >   	err = ext4_mb_load_buddy(sb, group, &e4b);
> > > @@ -3925,7 +3933,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
> > >   		ext4_warning(sb, "Error %d loading buddy information for %u",
> > >   			     err, group);
> > >   		put_bh(bitmap_bh);
> > > -		return 0;
> > > +		goto out_dbg;
> > >   	}
> > >   	if (needed == 0)
> > > @@ -3967,9 +3975,15 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
> > >   		goto repeat;
> > >   	}
> > > -	/* found anything to free? */
> > > +	/*
> > > +	 * If this list is empty, then return the grp->bb_free. As someone
> > > +	 * else may have freed the PAs and updated grp->bb_free.
> > > +	 */
> > >   	if (list_empty(&list)) {
> > >   		BUG_ON(free != 0);
> > > +		mb_debug(1, "Someone may have freed PA for this group %u, grp->bb_free %d\n",
> > > +			 group, grp->bb_free);
> > > +		free = grp->bb_free;
> > >   		goto out;
> > >   	}
> > 
> > OK, but this still doesn't reliably fix the problem, does it? Because >
> > bb_free can be still zero and another process just has some extents
> to free
> > in its local 'list' (e.g. because it has decided it doesn't have enough
> > extents, some were busy and it decided to cond_resched()), so bb_free will
> > increase from 0 only once these extents are freed.
> 
> This patch should reliably fix it, I think.
> So even if say Process P1 didn't free all extents, since some of the
> PAs were busy it decided to cond_resched(), that still means that the
> list(bb_prealloc_list) is not empty and whoever will get the
> ext4_lock_group() next will either
> get the busy PAs or it will be blocked on this lock_group() until all of
> the PAs were freed by processes.
> So if you see we may never actually return 0, unless, there are no PAs and
> grp->bb_free is truely 0.

Right, I missed that. Thanks for correction.

> But your case does shows that grp->bb_free may not be the upper bound
> of free blocks for this group. It could be just 1 PA's free blocks, while
> other PAs are still in some other process's local list (due to
> cond_reched())

Yes, but note that the return value of ext4_mb_discard_preallocations() is
effectively treated as bool in the end - i.e., did I free some blocks? If
yes, retry, if not -> ENOSPC.

Looking more into the code, I'm also somewhat concerned, whether your
changes cannot lead to excessive looping in ext4_mb_new_blocks(). Because
allocation request can be restricting, which blocks are elligible for
allocation. And thus even if there are some free blocks in the group, it
may not be possible to satisfy the request. Currently, the looping is
limited by the fact that you have to discard some preallocation to loop
again. With your bb_free check, this protection is removed and you could
loop in principle indefinitely AFAICS.

> > Honestly, I don't understand why ext4_mb_discard_group_preallocations()
> > bothers with the local 'list'. Why doesn't it simply free the preallocation
> 
> Let's see if someone else know about this. I am not really sure
> why it was done this way.
> 
> 
> > right away? And that would also basically fix your problem (well, it would
> > still theoretically exist because there's still freeing of one extent
> > potentially pending but I'm not sure if that will still be a practical
> > issue).
> 
> I guess this still can be a problem. So let's say if the process P1
> just checks that the list was not empty and then in parallel process P2
> just deletes the last entry - then when process P1 iterates over the list,
> it will find it empty and return 0, which may return -ENOSPC failure.
> unless we again take the group lock to check if the list is really free
> and return grp->bb_free if it is.

I see. You're correct this could be an issue. Good spotting! So we really
need to check if some preallocation was discarded (either by us or someone
else) since we last tried allocation. If yes, loop again, if no, return
ENOSPC. Do you agree? This could be implemented quite efficiently by
"preallocation discard" sequence counter. We'd sample it before trying
preallocation, then again after returning from
ext4_mb_discard_preallocations() and if it differs, we'll loop. What do you
think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
