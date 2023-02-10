Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6411D6920EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 15:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjBJOh6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 09:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjBJOh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:37:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9A46D63A;
        Fri, 10 Feb 2023 06:37:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CFE2D33E95;
        Fri, 10 Feb 2023 14:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676039873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J9IxGzrWR5KtzShNEpT9W3weNyZVsLsdhzbqLC1nYNA=;
        b=Te/RVHf9aZoqXOtfEgUhIKdBWYB2YL309JAcOxqOziGs/gpRD8kF/MKifj3shCjTqtxR3h
        slsQJJfMqg7+QqDuVRMPz/NFd88AVHOidBE+K1KeTXVeNfQ8MV6MjKvIQaSVPUGGp9UJCw
        NOz6oNSubeE4/S/NrBWIYufQhlARC0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676039873;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J9IxGzrWR5KtzShNEpT9W3weNyZVsLsdhzbqLC1nYNA=;
        b=8z/bGzA+rwn9D/ov23LTqsYx6MHq+jtY21Oia40m57zN+D0+83mjVaNoUlTNnW+pp3KfYr
        BDTRxtNiCty6XUDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB0EE13206;
        Fri, 10 Feb 2023 14:37:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rHs4LcFW5mPYTQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 10 Feb 2023 14:37:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3D94FA06D8; Fri, 10 Feb 2023 15:37:53 +0100 (CET)
Date:   Fri, 10 Feb 2023 15:37:53 +0100
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
Message-ID: <20230210143753.ofh6wouk7vi7ygcl@quack3>
References: <20230116080216.249195-8-ojaswin@linux.ibm.com>
 <20230116122334.k2hlom22o2hlek3m@quack3>
 <Y8Z413XTPMr//bln@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230117110335.7dtlq4catefgjrm3@quack3>
 <Y8jizbGg6l2WxJPF@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230127144312.3m3hmcufcvxxp6f4@quack3>
 <Y9zHkMx7w4Io0TTv@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <Y+OGkVvzPN0RMv0O@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230209105418.ucowiqnnptbpwone@quack3>
 <Y+UzQJRIJEiAr4Z4@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+UzQJRIJEiAr4Z4@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 09-02-23 23:24:31, Ojaswin Mujoo wrote:
> On Thu, Feb 09, 2023 at 11:54:18AM +0100, Jan Kara wrote:
> > On Wed 08-02-23 16:55:05, Ojaswin Mujoo wrote:
> > > On Fri, Feb 03, 2023 at 02:06:56PM +0530, Ojaswin Mujoo wrote:
> > > > On Fri, Jan 27, 2023 at 03:43:12PM +0100, Jan Kara wrote:
> > > > > 
> > > > > Well, I think cond_resched() + goto retry would be OK here. We could also
> > > > > cycle the corresponding group lock which would wait for
> > > > > ext4_mb_discard_group_preallocations() to finish but that is going to burn
> > > > > the CPU even more than the cond_resched() + retry as we'll be just spinning
> > > > > on the spinlock. Sleeping is IMHO not warranted as the whole
> > > > > ext4_mb_discard_group_preallocations() is running under a spinlock anyway
> > > > > so it should better be a very short sleep.
> > > > > 
> > > > > Or actually I have one more possible solution: What the adjusting function
> > > > > is doing that it looks up PA before and after ac->ac_o_ex.fe_logical and
> > > > > trims start & end to not overlap these PAs. So we could just lookup these
> > > > > two PAs (ignoring the deleted state) and then just iterate from these with
> > > > > rb_prev() & rb_next() until we find not-deleted ones. What do you think? 
> > > > 
> > > > Hey Jan, 
> > > > 
> > > > Just thought I'd update you, I'm trying this solution out, and it looks
> > > > good but I'm hitting a few bugs in the implementation. Will update here
> > > > once I have it working correctly.
> > > 
> > > Alright, so after spending some time on these bugs I'm hitting I'm
> > > seeing some strange behavior. Basically, it seems like in scenarios
> > > where we are not able to allocate as many block as the normalized goal
> > > request, we can sometimes end up adding a PA that overlaps with existing
> > > PAs in the inode PA list/tree. This behavior exists even before this
> > > particular patchset. Due to presence of such overlapping PAs, the above
> > > logic was failing in some cases.
> > > 
> > > From my understanding of the code, this seems to be a BUG. We should not
> > > be adding overlapping PA ranges as that causes us to preallocate
> > > multiple blocks for the same logical offset in a file, however I would
> > > also like to know if my understanding is incorrect and if this is an
> > > intended behavior.
> > > 
> > > ----- Analysis of the issue ------
> > > 
> > > Here's my analysis of the behavior, which I did by adding some BUG_ONs
> > > and running generic/269 (4k bs). It happens pretty often, like once
> > > every 5-10 runs. Testing was done without applying this patch series on
> > > the Ted's dev branch.
> > > 
> > > 1. So taking an example of a real scenario I hit. After we find the best
> > > len possible, we enter the ext4_mb_new_inode_pa() function with the
> > > following values for start and end of the extents:
> > > 
> > > ## format: <start>/<end>(<len>)
> > > orig_ex:503/510(7) goal_ex:0/512(512) best_ex:0/394(394)
> > > 
> > > 2. Since (best_ex len < goal_ex len) we enter the PA window adjustment
> > > if condition here:
> > > 
> > > 	if (ac->ac_b_ex.fe_len < ac->ac_g_ex.fe_len)
> > > 		...
> > > 	}
> > > 
> > > 3. Here, we calc wins, winl and off and adjust logical start and end of
> > > the best found extent. The idea is to make sure that the best extent
> > > atleast covers the original request. In this example, the values are:
> > > 
> > > winl:503 wins:387 off:109
> > > 
> > > and win = min(winl, wins, off) = 109
> > > 
> > > 4. We then adjust the logical start of the best ex as:
> > > 
> > > 		ac->ac_b_ex.fe_logical = ac->ac_o_ex.fe_logical - EXT4_NUM_B2C(sbi, win);
> > > 
> > > which makes the new best extent as:
> > > 
> > > best_ex: 394/788(394)
> > > 
> > > As we can see, the best extent overflows outside the goal range, and
> > > hence we don't have any guarentee anymore that it will not overlap with
> > > another PA since we only check overlaps with the goal start and end.
> > > We then initialze the new PA with the logical start and end of the best
> > > extent and finaly add it to the inode PA list.
> > > 
> > > In my testing I was able to actually see overlapping PAs being added to
> > > the inode list.
> > > 
> > > ----------- END ---------------
> > > 
> > > Again, I would like to know if this is a BUG or intended. If its a BUG,
> > > is it okay for us to make sure the adjusted best extent length doesn't 
> > > extend the goal length? 
> > 
> > Good spotting. So I guess your understanding of mballoc is better than mine
> > by now :) but at least in my mental model I would also expect the resulting
> > preallocation to stay withing the goal extent. What is causing here the
> > issue is this code in ext4_mb_new_inode_pa():
> > 
> >                 offs = ac->ac_o_ex.fe_logical %
> >                         EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
> >                 if (offs && offs < win)
> >                         win = offs;
> > 
> > so we apparently try to align the logical offset of the allocation to a
> > multiple of the allocated size but that just does not make much sense when
> 
> Yep, it is indeed the offset calculation that is cauing issues in this
> particular example. Any idea why this was originally added?

So I belive mballoc tries to align everything (offsets & lengths) to powers
of two to reduce fragmentation and simplify the work for the buddy allocator.
If ac->ac_b_ex.fe_len is a power-of-two, the alignment makes sense. But
once we had to resort to higher allocator passes and just got some
random-length extent, the alignment stops making sense.

> > we found some random leftover extent with shorter-than-goal size. So what
> > I'd do in the shorter-than-goal preallocation case is:
> > 
> > 1) If we can place the allocation at the end of goal window and still cover
> > the original allocation request, do that.
> > 
> > 2) Otherwise if we can place the allocation at the start of the goal
> > window and still cover the original allocation request, do that.
> > 
> > 3) Otherwise place the allocation at the start of the original allocation
> > request.
> > 
> > This would seem to reasonably reduce fragmentation of preallocated space
> > and still keep things simple.
> This looks like a good approach to me and it will take care of the issue
> caused due to offset calculation.
> 
> However, after commenting out the offset calculation bit in PA window
> adjustment logic, I noticed that there is one more way that such an
> overflow can happen, which would need to be addressed before we can
> implement the above approach. Basically, this happens when we end up
> with a goal len greater than the original len.

You probably mean goal end block smaller than original end block here... At
least that's what you speak about below.

> See my comments at the end for more info.
> 
> > 
> > > Also, another thing I noticed is that after ext4_mb_normalize_request(),
> > > sometimes the original range can also exceed the normalized goal range,
> > > which is again was a bit surprising to me since my understanding was
> > > that normalized range would always encompass the orignal range.
> > 
> > Well, isn't that because (part of) the requested original range is already
> > preallocated? Or what causes the goal range to be shortened?
> > 
> Yes I think that pre existing PAs could be one of the cases.
> 
> Other than that, I'm also seeing some cases of sparse writes which can cause
> ext4_mb_normalize_request() to result in having an original range that
> overflows out of the goal range. For example, I observed these values just
> after the if else if else conditions in the function, before we check if range
> overlaps pre existing PAs:
> 
> orig_ex:2045/2055(len:10) normalized_range:0/2048, orig_isize:8417280
> 
> Basically, since isize is large and we are doing a sparse write, we end
> up in the following if condition:
> 
> 	} else if (NRL_CHECK_SIZE(ac->ac_o_ex.fe_len,
> 								(8<<20)>>bsbits, max, 8 * 1024)) {
> 		start_off = ((loff_t)ac->ac_o_ex.fe_logical >> (23 - bsbits)) << 23;
> 		size = 8 * 1024 * 1024;
>  }
> 
> Resulting in normalized range less than original range.

I see.

> Now, in any case, once we get such an overflow, if we try to enter the PA
> adjustment window in ext4_mb_new_inode_pa() function, we will again end
> up with a best extent overflowing out of goal extent since we would try
> to cover the original extent. 
> 
> So yeah, seems like there are 2 cases where we could result in
> overlapping PAs:
> 
> 1. Due to off calculation in PA adjustment window, as we discussed.  2.
> Due to original extent overflowing out of goal extent.
> 
> I think the 3 step solution you proposed works well to counter 1 but not
> 2, so we probably need some more logic on top of your solution to take
> care of that.  I'll think some more on how to fix this but I think this
> will be as a separate patch.

Well, my algorithm will still result in preallocation being within the goal
range AFAICS. In the example above we had:

Orig 2045/2055 Goal 0/2048

Suppose we found 200 blocks. So we try placing preallocation like:

1848/2048, it covers the original starting block 2045 so we are fine and
create preallocation 1848/2048. Nothing has overflown the goal window...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
