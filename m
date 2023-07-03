Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141B97460D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 18:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGCQj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 12:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCQjZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:39:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B95E41;
        Mon,  3 Jul 2023 09:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27A3E60FCD;
        Mon,  3 Jul 2023 16:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88545C433C8;
        Mon,  3 Jul 2023 16:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688402363;
        bh=mU//x9jBPILiKpU55W6pKfM7tWEnFXK8s6uKf0IHSCQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=M7QzdEtEbwotwMWafP/+IUqD+OL0lZqDIEYIxukmJRy4zFLksHmS0OvpXttqHtoql
         zmAPP+1ejIDFbQbr8IlUUScA4lqau9u+Buss6+c8qzKd9/wI364iDkNElNOBdEF98q
         Kh8eWQuwrF+h+/XzRxBXe/kwXG538TSND8V3ImrZFwLpsD4bMMtjgjw77IIimtdyiI
         vm3F44IJaZ2yU9uFJNPVYGV9kH3TkMVG5bUFa2ByYcCloMku7wRiF6DxKGei5SKe9K
         hwn9AMOYpgf4vnwkGj6bYY4CIZ3iKF2SBAvkgudHibT6SNUv99F0DvP2atQXG8oO+Q
         8onz/cm4rlnJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 22663CE0DD0; Mon,  3 Jul 2023 09:39:23 -0700 (PDT)
Date:   Mon, 3 Jul 2023 09:39:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        djwong@kernel.org, brauner@kernel.org, tytso@mit.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 24/29] mm: vmscan: make global slab shrink lockless
Message-ID: <cc894c77-717a-4e9f-b649-48bab40e7c60@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
 <20230622085335.77010-25-zhengqi.arch@bytedance.com>
 <cf0d9b12-6491-bf23-b464-9d01e5781203@suse.cz>
 <ZJU708VIyJ/3StAX@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJU708VIyJ/3StAX@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 23, 2023 at 04:29:39PM +1000, Dave Chinner wrote:
> On Thu, Jun 22, 2023 at 05:12:02PM +0200, Vlastimil Babka wrote:
> > On 6/22/23 10:53, Qi Zheng wrote:
> > > @@ -1067,33 +1068,27 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> > >  	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
> > >  		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
> > >  
> > > -	if (!down_read_trylock(&shrinker_rwsem))
> > > -		goto out;
> > > -
> > > -	list_for_each_entry(shrinker, &shrinker_list, list) {
> > > +	rcu_read_lock();
> > > +	list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
> > >  		struct shrink_control sc = {
> > >  			.gfp_mask = gfp_mask,
> > >  			.nid = nid,
> > >  			.memcg = memcg,
> > >  		};
> > >  
> > > +		if (!shrinker_try_get(shrinker))
> > > +			continue;
> > > +		rcu_read_unlock();
> > 
> > I don't think you can do this unlock?

Sorry to be slow to respond here, this one fell through the cracks.
And thank you to Qi for reminding me!

If you do this unlock, you had jolly well better nail down the current
element (the one referenced by shrinker), for example, by acquiring an
explicit reference count on the object.  And presumably this is exactly
what shrinker_try_get() is doing.  And a look at your 24/29 confirms this,
at least assuming that shrinker->refcount is set to zero before the call
to synchronize_rcu() in free_module() *and* that synchronize_rcu() doesn't
start until *after* shrinker_put() calls complete().  Plus, as always,
the object must be removed from the list before the synchronize_rcu()
starts.  (On these parts of the puzzle, I defer to those more familiar
with this code path.  And I strongly suggest carefully commenting this
type of action-at-a-distance design pattern.)

Why is this important?  Because otherwise that object might be freed
before you get to the call to rcu_read_lock() at the end of this loop.
And if that happens, list_for_each_entry_rcu() will be walking the
freelist, which is quite bad for the health and well-being of your kernel.

There are a few other ways to make this sort of thing work:

1.	Defer the shrinker_put() to the beginning of the loop.
	You would need a flag initially set to zero, and then set to
	one just before (or just after) the rcu_read_lock() above.
	You would also need another shrinker_old pointer to track the
	old pointer.  Then at the top of the loop, if the flag is set,
	invoke shrinker_put() on shrinker_old.	This ensures that the
	previous shrinker structure stays around long enough to allow
	the loop to find the next shrinker structure in the list.

	This approach is attractive when the removal code path
	can invoke shrinker_put() after the grace period ends.

2.	Make shrinker_put() invoke call_rcu() when ->refcount reaches
	zero, and have the callback function free the object.  This of
	course requires adding an rcu_head structure to the shrinker
	structure, which might or might not be a reasonable course of
	action.  If adding that rcu_head is reasonable, this simplifies
	the logic quite a bit.

3.	For the shrinker-structure-removal code path, remove the shrinker
	structure, then remove the initial count from ->refcount,
	and then keep doing grace periods until ->refcount is zero,
	then do one more.  Of course, if the result of removing the
	initial count was zero, then only a single additional grace
	period is required.

	This would need to be carefully commented, as it is a bit
	unconventional.

There are probably many other ways, but just to give an idea of a few
other ways to do this.

> > > +
> > >  		ret = do_shrink_slab(&sc, shrinker, priority);
> > >  		if (ret == SHRINK_EMPTY)
> > >  			ret = 0;
> > >  		freed += ret;
> > > -		/*
> > > -		 * Bail out if someone want to register a new shrinker to
> > > -		 * prevent the registration from being stalled for long periods
> > > -		 * by parallel ongoing shrinking.
> > > -		 */
> > > -		if (rwsem_is_contended(&shrinker_rwsem)) {
> > > -			freed = freed ? : 1;
> > > -			break;
> > > -		}
> > > -	}
> > >  
> > > -	up_read(&shrinker_rwsem);
> > > -out:
> > > +		rcu_read_lock();
> > 
> > That new rcu_read_lock() won't help AFAIK, the whole
> > list_for_each_entry_rcu() needs to be under the single rcu_read_lock() to be
> > safe.
> 
> Yeah, that's the pattern we've been taught and the one we can look
> at and immediately say "this is safe".
> 
> This is a different pattern, as has been explained bi Qi, and I
> think it *might* be safe.
> 
> *However.*
> 
> Right now I don't have time to go through a novel RCU list iteration
> pattern it one step at to determine the correctness of the
> algorithm. I'm mostly worried about list manipulations that can
> occur outside rcu_read_lock() section bleeding into the RCU
> critical section because rcu_read_lock() by itself is not a memory
> barrier.
> 
> Maybe Paul has seen this pattern often enough he could simply tell
> us what conditions it is safe in. But for me to work that out from
> first principles? I just don't have the time to do that right now.

If the code does just the right sequence of things on the removal path
(remove, decrement reference, wait for reference to go to zero, wait for
grace period, free), then it would work.  If this is what is happening,
I would argue for more comments.  ;-)

							Thanx, Paul

> > IIUC this is why Dave in [4] suggests unifying shrink_slab() with
> > shrink_slab_memcg(), as the latter doesn't iterate the list but uses IDR.
> 
> Yes, I suggested the IDR route because radix tree lookups under RCU
> with reference counted objects are a known safe pattern that we can
> easily confirm is correct or not.  Hence I suggested the unification
> + IDR route because it makes the life of reviewers so, so much
> easier...
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
