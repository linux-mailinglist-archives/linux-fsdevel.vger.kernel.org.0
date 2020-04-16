Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD801ABDDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 12:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504912AbgDPK1x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 06:27:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:54924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504896AbgDPK12 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:27:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D8B32ABEF;
        Thu, 16 Apr 2020 10:27:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 833421E1250; Thu, 16 Apr 2020 12:27:24 +0200 (CEST)
Date:   Thu, 16 Apr 2020 12:27:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, sandeen@sandeen.net
Subject: Re: [RFC 1/1] ext4: Fix race in
 ext4_mb_discard_group_preallocations()
Message-ID: <20200416102724.GD23739@quack2.suse.cz>
References: <20200410155211.GC1443@quack2.suse.cz>
 <cover.1586954511.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1586954511.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-04-20 22:50:19, Ritesh Harjani wrote:
> Sorry if this mail is not properly formatted. Somehow my mail server lost few
> of the emails and I didn't receive your email. I have to start exploring some
> other reliable method for at least receiving all the emails.
> But anyways, I copied this from patchwork so that we could continue our
> discussion.

Sure, no problem.

> >On Fri 10-04-20 00:15:44, Ritesh Harjani wrote:
> >> On 4/9/20 7:07 PM, Jan Kara wrote:
> >> > Hello Ritesh!
> >> > 
> >> > On Wed 08-04-20 22:24:10, Ritesh Harjani wrote:
> >> > > @@ -3908,16 +3919,13 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
> >> > >   	mb_debug(1, "discard preallocation for group %u\n", group);
> >> > > -	if (list_empty(&grp->bb_prealloc_list))
> >> > > -		return 0;
> >> > > -
> >> > 
> >> > OK, so ext4_mb_discard_preallocations() is now going to lock every group
> >> > when we try to discard preallocations. That's likely going to increase lock
> >> > contention on the group locks if we are running out of free blocks when
> >> > there are multiple processes trying to allocate blocks. I guess we don't
> >> > care about the performace of this case too deeply but I'm not sure if the
> >> > cost won't be too big - probably we should check how much the CPU usage
> >> > with multiple allocating process trying to find free blocks grows...
> >> 
> >> Sure let me check the cpu usage in my test case with this patch.
> >> But either ways unless we take the lock we are not able to confirm
> >> that what are no. of free blocks available in the filesystem, right?
> >> 
> >> This mostly will happen only when there are lot of threads and due to
> >> all of their preallocations filesystem is running into low space and
> >> hence
> >> trying to discard all the preallocations. => so when FS is going low on
> >> space, isn't this cpu usage justifiable? (in an attempt to make sure we
> >> don't fail with ENOSPC)?
> >> Maybe not since this is only due to spinlock case, is it?
> >
> >As I wrote, I'm not too much concerned about *some* increase in CPU usage.
> >But I'd like to get that quantified because if we can say softlockup the
> >machine in the extreme case (or burn 100% of several CPUs spinning on the
> >lock), then we need a better mechanism to handle the preallocation
> >discarding and waiting...
> 
> So I did give this a thought and re-looked at our code again. So to me one other
> reason why we could be deleting the PAs from grp->bb_prealloc_list and adding
> it to our local list is because:-
> We should be able to make the grp->bb_prealloc_list empty as quickly as
> possible, so that if the other process tries to discard the same group's PA
> list, it should find the list empty and it could proceed discarding some
> other group's PA. This way instead of spending cpu cycles on spin lock waiting
> for discard to complete, we could as well try and discard some other group's
> PA list.
> Not sure if there is some other reason as well for doing it like this.

Hum, interesting idea but I somewhat doubt that was the reason... I rather
suspect that the reason was some lock ordering problem which got removed
later (e.g. maybe there originally was not pa->deleted entry to mark
preallocation as on its way to be deleted and then lock ordering would
basically dictate a local list of to-discard items).

> >> Or are you suggesting we should use some other method for discarding
> >> all the group's PA. So that other threads could sleep while discard is
> >> happening. Something like a discard work item which should free up
> >> all of the group's PA. But we need a way to determine if the needed
> >> no of blocks were freed so that we wake up and retry the allocation.
> >> 
> >> (Darrick did mentioned something on this line related to work/workqueue,
> >> but couldn't discuss much that time).
> >> 
> >> 
> >> > 
> >> > >   	bitmap_bh = ext4_read_block_bitmap(sb, group);
> >> > >   	if (IS_ERR(bitmap_bh)) {
> >> > >   		err = PTR_ERR(bitmap_bh);
> >> > >   		ext4_set_errno(sb, -err);
> >> > >   		ext4_error(sb, "Error %d reading block bitmap for %u",
> >> > >   			   err, group);
> >> > > -		return 0;
> >> > > +		goto out_dbg;
> >> > >   	}
> >> > >   	err = ext4_mb_load_buddy(sb, group, &e4b);
> >> > > @@ -3925,7 +3933,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
> >> > >   		ext4_warning(sb, "Error %d loading buddy information for %u",
> >> > >   			     err, group);
> >> > >   		put_bh(bitmap_bh);
> >> > > -		return 0;
> >> > > +		goto out_dbg;
> >> > >   	}
> >> > >   	if (needed == 0)
> >> > > @@ -3967,9 +3975,15 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
> >> > >   		goto repeat;
> >> > >   	}
> >> > > -	/* found anything to free? */
> >> > > +	/*
> >> > > +	 * If this list is empty, then return the grp->bb_free. As someone
> >> > > +	 * else may have freed the PAs and updated grp->bb_free.
> >> > > +	 */
> >> > >   	if (list_empty(&list)) {
> >> > >   		BUG_ON(free != 0);
> >> > > +		mb_debug(1, "Someone may have freed PA for this group %u, grp->bb_free %d\n",
> >> > > +			 group, grp->bb_free);
> >> > > +		free = grp->bb_free;
> >> > >   		goto out;
> >> > >   	}
> >> > 
> >> > OK, but this still doesn't reliably fix the problem, does it? Because >
> >> > bb_free can be still zero and another process just has some extents
> >> to free
> >> > in its local 'list' (e.g. because it has decided it doesn't have enough
> >> > extents, some were busy and it decided to cond_resched()), so bb_free will
> >> > increase from 0 only once these extents are freed.
> >> 
> >> This patch should reliably fix it, I think.
> >> So even if say Process P1 didn't free all extents, since some of the
> >> PAs were busy it decided to cond_resched(), that still means that the
> >> list(bb_prealloc_list) is not empty and whoever will get the
> >> ext4_lock_group() next will either
> >> get the busy PAs or it will be blocked on this lock_group() until all of
> >> the PAs were freed by processes.
> >> So if you see we may never actually return 0, unless, there are no PAs and
> >> grp->bb_free is truely 0.
> >
> >Right, I missed that. Thanks for correction.
> >
> >> But your case does shows that grp->bb_free may not be the upper bound
> >> of free blocks for this group. It could be just 1 PA's free blocks, while
> >> other PAs are still in some other process's local list (due to
> >> cond_reched())
> >
> >Yes, but note that the return value of ext4_mb_discard_preallocations() is
> >effectively treated as bool in the end - i.e., did I free some blocks? If
> >yes, retry, if not -> ENOSPC.
> 
> Yes, that's true.
> 
> >Looking more into the code, I'm also somewhat concerned, whether your
> >changes cannot lead to excessive looping in ext4_mb_new_blocks(). Because
> >allocation request can be restricting, which blocks are elligible for
> >allocation. And thus even if there are some free blocks in the group, it
> >may not be possible to satisfy the request. Currently, the looping is
> 
> I am not very sure if above is true. I do see that we have a ac_criteria,
> which if it's 3, then even if any group is found with free space less that the
> original allocation request length, even then it could proceed with allocation.
> I see that we iterate till the criteria value is <= 3 in 
> ext4_mb_regular_allocator(). Also note in function ext4_mb_measure_extent().
> In that we note any free block extent into ac->ac_b_ex, unless on doing
> more scanning, we are able to find a better one.
> 
> But considering there are a lot of logic conditions put in here, maybe
> I have missed your case here. Could you please help explain this case
> where if there are some free blocks in the group i.e. grp->bb_free is non-zero,
> even then it may fail to allocate anything?

What I had in mind was e.g. an allocation with EXT4_MB_HINT_GOAL_ONLY
flag. Then AFAICT we will only try to allocate starting at given block and
if that happens to be unfreeable, we have to bail out with ENOSPC even if
the group has other free blocks. But as you said, the mballoc logic is
rather convoluted so I may be missing something as well :).

> >limited by the fact that you have to discard some preallocation to loop
> >again. With your bb_free check, this protection is removed and you could
> >loop in principle indefinitely AFAICS.
> 
> So even with a positive grp->bb_free value, if ext4_mb_regular_allocator()
> cannot make forward progress of any kind, then yes this indefinitely looping
> is possible. But I am unable to find a case where this is true.
> 
> >
> >> > Honestly, I don't understand why ext4_mb_discard_group_preallocations()
> >> > bothers with the local 'list'. Why doesn't it simply free the preallocation
> >> 
> >> Let's see if someone else know about this. I am not really sure
> >> why it was done this way.
> 
> One reason could be trying to free other group's PA list in parallel
> (as explained above). Not sure if there was any other reason apart from this
> though.
> 
> >> 
> >> > right away? And that would also basically fix your problem (well, it would
> >> > still theoretically exist because there's still freeing of one extent
> >> > potentially pending but I'm not sure if that will still be a practical
> >> > issue).
> >> 
> >> I guess this still can be a problem. So let's say if the process P1
> >> just checks that the list was not empty and then in parallel process P2
> >> just deletes the last entry - then when process P1 iterates over the list,
> >> it will find it empty and return 0, which may return -ENOSPC failure.
> >> unless we again take the group lock to check if the list is really free
> >> and return grp->bb_free if it is.
> >
> >I see. You're correct this could be an issue. Good spotting! So we really
> >need to check if some preallocation was discarded (either by us or someone
> >else) since we last tried allocation. If yes, loop again, if no, return
> >ENOSPC. Do you agree? This could be implemented quite efficiently by
> >"preallocation discard" sequence counter. We'd sample it before trying
> >preallocation, then again after returning from
> >ext4_mb_discard_preallocations() and if it differs, we'll loop. What do you
> >think?
> 
> IIUC, write_seqcounter needs a locking since write paths cannot be nested.
> So the caller needs to implement it's own locking for seqcounter. So what could
> actually happen is even if update write_seqcount_begin/end() inside
> ext4_lock/unlock_group(). It may still happen that some other thread with a
> different group can proceed with it's own different group lock and call
> write_seqcount_begin() which will make it nested (since we are keeping
> seqcount at EXT4 super_block level), unless we decide to keep seqcount also
> at group level. But that would also mean that we need to sample the
> read_seqcount for all groups in beginning?
> 
> Hence the slight trouble understanding a way around this issue.
> Does this make sense or am I lost here?

Right, it's not as simple as I thought :). So how I'd do it is to have
atomic_t counter in the superblock, increment it for each discard of a
preallocated extent (likely in ext4_mb_release_group_pa() and
ext4_mb_release_inode_pa()). Sample it in ext4_mb_new_blocks() before the
first allocation and then again after ext4_mb_discard_preallocations() to
check whether anything was discarded.

Now it could happen that this atomic_t will actually become a bottleneck
due to cacheline bouncing if there's heavy discarding of preallocations
happening from multiple CPUs. In case we find a workload where that would
happen we'd need to make it a per-cpu counter and then play some tricks
with the sampling - like do the first sampling in ext4_mb_new_blocks() with
percpu_counter_read() (to avoid the overhead of summing the counter for
common allocations) and if there's no space, use percpu_counter_sum() to
get accurate value. This could result in falsely retrying once if there's
no space but that's not that bad...

> Now while we are at this, I implemented another approach of taking a fastpath
> and slowpath in ext4_mb_discard_group_preallocations(). 
> But this still relies upon the grp->bb_free counter. This also means that
> we need to get answer to our above concern, where we assume that if grp->bb_free
> is non-zero then the forward progress is possible.
> 
> While reading more code, I see that updating grp->bb_free and
> grp->bb_prealloc_list is not atomic. This happens in two different functions
> and in between the lock is released. So relying completely on grp->bb_free
> if the PA list is just an approximation in our algorithm.
> Since it may happen that some processes in parallel may come and allocate
> all grp->bb_free blocks but the PA list for those are not yet created.
> If that happens and we return grp->bb_free which is 0, this could again
> be a corner(/approx.) case of ENOSPC failure.
> Bcoz there was still some space left which was about to be updated into the
> group's PA list.
> But this would also mean that we are anyway reaching our limit
> of ENOSPC and so it should be ok if we get a ENOSPC failure then, right?
> 
> Meanwhile since I anyway have that patch with me, I will reply to this
> email with that new patch. That patch should help fix your concern of
> spinning unnecessarily on the group lock. And also it has other problem as
> explained, that it could have made all discard proceed only sequentially.
> But with new approach of fastpath/slowpath, it is still possible to at least
> discard in parallel (if by the time we check list_emty(), some other process
> made this group's bb_prealloc_list empty and added all the PAs in it's local
> list).

OK, I'll have a look.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
