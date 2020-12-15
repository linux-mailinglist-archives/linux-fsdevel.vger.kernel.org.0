Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1053D2DA5F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 03:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgLOCFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 21:05:06 -0500
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:52181 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbgLOCFG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 21:05:06 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id E4D9D10843D;
        Tue, 15 Dec 2020 13:04:21 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kozhM-0044AH-VK; Tue, 15 Dec 2020 13:04:20 +1100
Date:   Tue, 15 Dec 2020 13:04:20 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        hannes@cmpxchg.org, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 3/9] mm: vmscan: guarantee shrinker_slab_memcg() sees
 valid shrinker_maps for online memcg
Message-ID: <20201215020420.GJ3913616@dread.disaster.area>
References: <20201214223722.232537-1-shy828301@gmail.com>
 <20201214223722.232537-4-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214223722.232537-4-shy828301@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=7-415B0cAAAA:8
        a=wdWbNfnXb-wgsad9dhsA:9 a=CjuIK1q_8ugA:10 a=-RoEEKskQ1sA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 02:37:16PM -0800, Yang Shi wrote:
> The shrink_slab_memcg() races with mem_cgroup_css_online(). A visibility of CSS_ONLINE flag
> in shrink_slab_memcg()->mem_cgroup_online() does not guarantee that we will see
> memcg->nodeinfo[nid]->shrinker_maps != NULL.  This may occur because of processor reordering
> on !x86.
> 
> This seems like the below case:
> 
>            CPU A          CPU B
> store shrinker_map      load CSS_ONLINE
> store CSS_ONLINE        load shrinker_map
> 
> So the memory ordering could be guaranteed by smp_wmb()/smp_rmb() pair.
> 
> The memory barriers pair will guarantee the ordering between shrinker_deferred and CSS_ONLINE
> for the following patches as well.

This should not require memory barriers in the shrinker code.

The code that sets and checks the CSS_ONLINE flag should have the
memory barriers to ensure that anything that sees an online CSS will
see it completely set up.

That is, the functions online_css() that set the CSS_ONLINE needs
a memory barrier to ensure all previous writes are completed before
the CSS_ONLINE flag is set, and the function mem_cgroup_online()
needs a barrier to pair with that.

This is the same existence issue that the superblock shrinkers have
with the shrinkers being registered before the superblock is fully
set up. The SB_BORN flag on the sueprblock indicates the superblock
is now fully set up ("online" in CSS speak) and the registered
shrinker can run. Please see the smp_wmb() before we set SB_BORN in
vfs_get_tree(), and the big comment about the smp_rmb() -after- we
check SB_BORN in super_cache_count() to understand the details of
the data dependency between the flag and the structures being set up
that the barriers enforce.

IOWs, these memory barriers belong inside the cgroup code to
guarantee anything that sees an online cgroup will always see the
fully initialised cgroup structures. They do not belong in the
shrinker infrastructure...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
