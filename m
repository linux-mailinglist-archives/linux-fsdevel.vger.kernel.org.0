Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6D16BF704
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 01:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCRAlf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 20:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjCRAle (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 20:41:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C64D3D09D;
        Fri, 17 Mar 2023 17:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA60CB82749;
        Sat, 18 Mar 2023 00:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A835FC433EF;
        Sat, 18 Mar 2023 00:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679100090;
        bh=thnG4UAyNln1QXaTgB/6+jHAEK0Y5sQuA5qja+wqgz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D1VeViBZhpnEgalhGa/F1x5LTPiiL7OO+0utJdMl1d6na/b04TI3ADjBzDQJRYRiB
         PH7508B7ybejcIEfphCkdGQgX+NQdmqEHm6iC9lV+szG1IKYC+PdSXdSdD7mIka+TE
         2bGKSGd/zOWM+cgFz0k2oKb52R34wRSf6AY6qQkBUNWvBLS8WRdEam1qWdetJEIw7j
         YL5+r3FaF439zd+zRIlKfdk37p8AEgxr+5utfZUaLu5ik6kc09/LxDJbCfxDx88rfI
         acmk5qPMxCzK5bht7fVIx6x7tG87OaaHEnlPfY94+LMeWbE74K6wJDvfwmofnF0n4r
         kX1sHzMiedo/A==
Date:   Fri, 17 Mar 2023 17:41:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yebin10@huawei.com
Subject: Re: [PATCH 0/4] pcpctr: fix percpu_counter_sum vs cpu offline race
Message-ID: <20230318004130.GU11376@frogsfrogsfrogs>
References: <20230315084938.2544737-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315084938.2544737-1-david@fromorbit.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 15, 2023 at 07:49:34PM +1100, Dave Chinner wrote:
> Ye Bin reported an XFS assert failure when testing CPU hotplug
> recently. During unmount, XFs was asserting that a percpu counter
> value should be zero because at that point in time a non-zero value
> indicates a space accounting leak which is a bug. The details of
> that failure can be found here:
> 
> https://lore.kernel.org/linux-kernel/20230314090649.326642-1-yebin@huaweicloud.com/
> 
> Ye Bin then proposed changing the XFS code to use
> percpu_counter_sum_all(), which surprised me because I didn't know
> that function existed at all. Indeed, it was only merged in the
> recent 6.3-rc1 merge window because someone else had noticed a
> pcpctr sum race with hotplug.
> 
> commit f689054aace2 ("percpu_counter: add percpu_counter_sum_all
> interface") was introduced via the mm tree. Nobody outside that
> scope knew about this, because who bothers to even try to read LKML
> these days? There was little list discussion, and I don't see
> anything other than a cursory review done on the patch.
> 
> At minimum, linux-fsdevel should have been cc'd because multiple
> filesystems use percpu counters for both threshold and ENOSPC
> accounting in filesystems.  Hence if there is a problem with
> percpu_counter_sum() leaking, filesystem developers kinda need to
> know about it because leaks like this (as per the XFS bug report)
> can actually result in on-disk corruption occurring.
> 
> So, now I know that there is an accuracy problem with
> percpu_counter_sum(), I will assert that we need to fix it properly
> rathern than hack around it by adding a new variant. Leaving people
> who know nothing about cpu hotplug to try to work out if they have a
> hotplug related issue with their use of percpu_counter_sum() is just
> bad code; percpu_counter_sum() should just Do The Right Thing.
> 
> Use of the cpu_dying_mask should effectively close this race
> condition.  That is, when we take a CPU offline we effectively do:
> 
> 	mark cpu dying
> 	clear cpu from cpu_online_mask
> 	run cpu dead callbacks
> 	  ....
> 	  <lock counter>
> 	  fold pcp count into fbc->count
> 	  clear pcp count
> 	  <unlock counter>
> 	  ...
> 	mark CPU dead
> 	clear cpu dying
> 
> The race condition occurs because we can run a _sum operation
> between the "clear cpu online" mask update and the "pcpctr cpu dead"
> notification runs and fold the pcp counter values back into the
> global count.  The sum sees that the CPU is not online, so it skips
> that CPU even though the count is not zero and hasn't been folded by
> the CPU dead notifier. Hence it skips something that it shouldn't.
> 
> However, that race condition doesn't exist if we take cpu_dying_mask
> into account during the sum.  i.e. percpu_counter_sum() should
> iterate every CPU set in either the cpu_online_mask and the
> cpu_dying_mask to capture CPUs that are being taken offline.
> 
> If the cpu is not set in the dying mask, then the online or offline
> state of the CPU is correct an there is no notifier pending over
> running and we will skip/sum it correctly.
> 
> If the CPU is set in the dying mask, then we need to sum it
> regardless of the online mask state or even whether the cpu dead
> notifier has run.  If the sum wins the race to the pcp counter on
> the dying CPU, it is included in the local sum from the pcp
> variable. If the notifier wins the race, it gets folded back into
> the global count and zeroed before the sum runs. Then the sum
> includes the count in the local sum from the global counter sum
> rather than the percpu counter.
> 
> Either way, we get the same correct sum value from
> percpu_counter_sum() regardless of how it races with a CPU being
> removed from the system. And there is no need for
> percpu_count_sum_all() anymore.
> 
> This series introduces bitmap operations for finding bits set in
> either of two bitmasks and adds the for_each_cpu_or() wrapper to
> iterate CPUs set in either of the two supplied cpu masks. It then
> converts __percpu_counter_sum_mask() to use this, and have
> __percpu_counter_sum() pass the cpu_dying_mask as the second mask.
> This fixes the race condition with CPUs dying.
> 
> It then converts the only user of percpu_counter_sum_all() to use
> percpu_counter_sum() as percpu_counter_sum_all() is now redundant,
> then it removes percpu_counter_sum_all() and recombines
> __percpu_counter_sum_mask() and __percpu_counter_sum().
> 
> This effectively undoes all the changes in commit f689054aace2
> except for the small change to use for_each_cpu_or() to fold in the
> cpu_dying_mask made in this patch set to avoid the problematic race
> condition. Hence the cpu unplug race condition is now correctly
> handled by percpu_counter_sum(), and people can go back to being
> blissfully ignorant of how pcpctrs interact with CPU hotplug (which
> is how it should be!).
> 
> This has spent the last siz hours running generic/650 on XFS on a
> couple of VMs (on 4p, the other 16p) which stresses the filesystem
> by running a multi-process fsstress invocation whilst randomly
> onlining and offlining CPUs. Hence it's exercising all the percpu
> counter cpu dead paths whilst the filesystem is randomly modifying,
> reading and summing summing the critical counters that XFS needs for
> accurate accounting of resource consumption within the filesystem.
> 
> Thoughts, comments and testing welcome!

I've been testing this since I saw it, and AFAICT it looks good to me.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

That said -- do any of the people who know percpu counters better than
me have any thoughts?  The justification and the code changes make sense
to me, but keeping up with xfs metadata is enough for me.

--D


> 
> -Dave.
> 
