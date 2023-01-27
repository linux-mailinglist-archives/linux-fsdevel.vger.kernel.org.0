Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA7867E883
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 15:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjA0OnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 09:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjA0OnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:43:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201E37C70E;
        Fri, 27 Jan 2023 06:43:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B8EB9220FF;
        Fri, 27 Jan 2023 14:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674830592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uD2PukWeCMHDxfU6cX50tev8CxQr4kL+7D4hPGIy2vA=;
        b=HGJlKyV3xz+rd4ETKRmwRMYY+TYuH8u+kQBcHneBXghAZ5GcOhqlUC8E15okptjA7a3phD
        zoOSnAaGP9H+YCrOEx2unK1PILTvXcnzTFU4h+KooFl2JI0UYcrJ6nXThOKx/FX1M4tY3t
        /KaG70suYts6hMyLAs+TPN0FCAdLfvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674830592;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uD2PukWeCMHDxfU6cX50tev8CxQr4kL+7D4hPGIy2vA=;
        b=ONfkIeP2vq6AyOt2TUSlAX+MsAbO4Udlny1q5w5QKGKDl7YkrSmxR+4EPpROFYa5gH4fsB
        YDPZ6Zg0fU1CQJCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F6931336F;
        Fri, 27 Jan 2023 14:43:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M+XeJgDj02NNTAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 27 Jan 2023 14:43:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 32FD6A06B4; Fri, 27 Jan 2023 15:43:12 +0100 (CET)
Date:   Fri, 27 Jan 2023 15:43:12 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <20230127144312.3m3hmcufcvxxp6f4@quack3>
References: <20230116080216.249195-1-ojaswin@linux.ibm.com>
 <20230116080216.249195-8-ojaswin@linux.ibm.com>
 <20230116122334.k2hlom22o2hlek3m@quack3>
 <Y8Z413XTPMr//bln@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230117110335.7dtlq4catefgjrm3@quack3>
 <Y8jizbGg6l2WxJPF@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8jizbGg6l2WxJPF@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ojaswin!

I'm sorry for a bit delayed reply...

On Thu 19-01-23 11:57:25, Ojaswin Mujoo wrote:
> On Tue, Jan 17, 2023 at 12:03:35PM +0100, Jan Kara wrote:
> > On Tue 17-01-23 16:00:47, Ojaswin Mujoo wrote:
> > > On Mon, Jan 16, 2023 at 01:23:34PM +0100, Jan Kara wrote:
> > > > > Since this covers the special case we discussed above, we will always
> > > > > un-delete the PA when we encounter the special case and we can then
> > > > > adjust for overlap and traverse the PA rbtree without any issues.
> > > > > 
> > > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > 
> > > Hi Jan,
> > > Thanks for the review, sharing some of my thoughts below.
> > > 
> > > > 
> > > > So I find this putting back of already deleted inode PA very fragile. For
> > > > example in current code I suspect you've missed a case in ext4_mb_put_pa()
> > > > which can mark inode PA (so it can then be spotted by
> > > > ext4_mb_pa_adjust_overlap() and marked as in use again) but
> > > > ext4_mb_put_pa() still goes on and destroys the PA.
> > > 
> > > The 2 code paths that clash here are:
> > > 
> > > ext4_mb_new_blocks() -> ext4_mb_release_context() -> ext4_mb_put_pa()
> > > ext4_mb_new_blocks() -> ext4_mb_normalize_request() -> ext4_mb_pa_adjust_overlap()
> > > 
> > > Since these are the only code paths from which these 2 functions are
> > > called, for a given inode, access will always be serialized by the upper
> > > level ei->i_data_sem, which is always taken when writing data blocks
> > > using ext4_mb_new_block(). 
> > 
> > Indeed, inode->i_data_sem prevents the race I was afraid of.
> >  
> > > From my understanding of the code, I feel only
> > > ext4_mb_discard_group_preallocations() can race against other functions
> > > that are modifying the PA rbtree since it does not take any inode locks.
> > > 
> > > That being said, I do understand your concerns regarding the solution,
> > > however I'm willing to work with the community to ensure our
> > > implementation of this undelete feature is as robust as possible. Along
> > > with fixing the bug reported here [1], I believe that it is also a good
> > > optimization to have especially when the disk is near full and we are
> > > seeing a lot of group discards going on. 
> > > 
> > > Also, in case the deleted PA completely lies inside our new range, it is
> > > much better to just undelete and use it rather than deleting the
> > > existing PA and reallocating the range again. I think the advantage
> > > would be even bigger in ext4_mb_use_preallocated() function where we can
> > > just undelete and use the PA and skip the entire allocation, incase original
> > > range lies in a deleted PA.
> > 
> > Thanks for explantion. However I think you're optimizing the wrong thing.
> > We are running out of space (to run ext4_mb_discard_group_preallocations()
> > at all) and we allocate from an area covered by PA that we've just decided
> > to discard - if anything relies on performance of the filesystem in ENOSPC
> > conditions it has serious problems no matter what. Sure, we should deliver
> > the result (either ENOSPC or some block allocation) in a reasonable time
> > but the performance does not really matter much because all the scanning
> > and flushing is going to slow down everything a lot anyway. One additional
> > scan of the rbtree is really negligible in this case. So what we should
> > rather optimize for in this case is the code simplicity and maintainability
> > of this rare corner-case that will also likely get only a small amount of
> > testing. And in terms of code simplicity the delete & restart solution
> > seems to be much better (at least as far as I'm imagining it - maybe the
> > code will prove me wrong ;)).
> Hi Jan,
> 
> So I did try out the 'rb_erase from ext4_mb_adjust_overlap() and retry' method,
> with ane extra pa_removed flag, but the locking is getting pretty messy. I'm
> not sure if such a design is possible is the lock we currently have. 
> 
> Basically, the issue I'm facing is that we are having to drop the
> locks read locks and accquire the write locks in
> ext4_mb_adjust_overlap(), which looks something like this:
> 
> 				spin_unlock(&tmp_pa->pa_lock);
> 				read_unlock(&ei->i_prealloc_lock);
> 
> 				write_lock(&ei->i_prealloc_lock);
> 				spin_lock(&tmp_pa->pa_lock);
> 
> We have to preserve the order and drop both tree and PA locks to avoid
> deadlocks.  With this approach, the issue is that in between dropping and
> accquiring this lock, the group discard path can actually go ahead and free the
> PA memory after calling rb erase on it, which can result in use after free in
> the adjust overlap path.  This is because the PA is freed without any locks in
> discard path, as it assumes no other thread will have a reference to it. This
> assumption was true earlier since our allocation path never gave up the rbtree
> lock however it is not possible with this approach now.  Essentially, the
> concept of having two different areas where a PA can be deleted is bringing in
> additional challenges and complexity, which might make things worse from a
> maintainers/reviewers point of view.

Right, I didn't realize that. That is nasty.

> After brainstorming a bit, I think there might be a few alternatives here:
> 
> 1. Instead of deleting PA in the adjust overlap thread, make it sleep till group
> discard path goes ahead and deletes/frees it. At this point we can wake it up and retry
> allocation. 
> 
> * Pros: We can be sure that PA would have been removed at the time of retry so
> we don't waste extra retries. C
> * Cons: Extra complexity in code. 
> 
> 2. Just go for a retry in adjust overlap without doing anything. In ideal case,
> by the time we start retrying the PA might be already removed. Worse case: We
> keep looping again and again since discard path has not deleted it yet.
> 
> * Pros: Simplest approach, code remains straightforward.
> * Cons: We can end up uselessly retrying if the discard path doesn't delete the PA fast enough.

Well, I think cond_resched() + goto retry would be OK here. We could also
cycle the corresponding group lock which would wait for
ext4_mb_discard_group_preallocations() to finish but that is going to burn
the CPU even more than the cond_resched() + retry as we'll be just spinning
on the spinlock. Sleeping is IMHO not warranted as the whole
ext4_mb_discard_group_preallocations() is running under a spinlock anyway
so it should better be a very short sleep.

Or actually I have one more possible solution: What the adjusting function
is doing that it looks up PA before and after ac->ac_o_ex.fe_logical and
trims start & end to not overlap these PAs. So we could just lookup these
two PAs (ignoring the deleted state) and then just iterate from these with
rb_prev() & rb_next() until we find not-deleted ones. What do you think? 
 
> 3. The approach of undeleting the PA (proposed in this patchset) that
> we've already discussed.
> 
> Now, to be honest, I still prefer the undelete PA approach as it makes more
> sense to me and I think the code is simple enough as there are not many paths
> that might race. Mostly just adjust_overlap and group discard or
> use_preallocated and group discard.

Yeah, I'm still not too keen on this but I'm willing to reconsider if 
above approach proves to be too expensive under ENOSPC conditions...

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
