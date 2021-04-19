Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA18363910
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 03:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhDSBYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Apr 2021 21:24:31 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:56366 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233104AbhDSBYb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Apr 2021 21:24:31 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id CF2691AF1B0;
        Mon, 19 Apr 2021 11:23:58 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lYIdo-00EcnL-KJ; Mon, 19 Apr 2021 11:23:56 +1000
Date:   Mon, 19 Apr 2021 11:23:56 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Bharata B Rao <bharata@linux.ibm.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <20210419012356.GZ1990290@dread.disaster.area>
References: <20210405054848.GA1077931@in.ibm.com>
 <20210406222807.GD1990290@dread.disaster.area>
 <20210416044439.GB1749436@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416044439.GB1749436@in.ibm.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=ScFYv971vT0PkSOGSnAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:14:39AM +0530, Bharata B Rao wrote:
> On Wed, Apr 07, 2021 at 08:28:07AM +1000, Dave Chinner wrote:
> > On Mon, Apr 05, 2021 at 11:18:48AM +0530, Bharata B Rao wrote:
> > 
> > > As an alternative approach, I have this below hack that does lazy
> > > list_lru creation. The memcg-specific list is created and initialized
> > > only when there is a request to add an element to that particular
> > > list. Though I am not sure about the full impact of this change
> > > on the owners of the lists and also the performance impact of this,
> > > the overall savings look good.
> > 
> > Avoiding memory allocation in list_lru_add() was one of the main
> > reasons for up-front static allocation of memcg lists. We cannot do
> > memory allocation while callers are holding multiple spinlocks in
> > core system algorithms (e.g. dentry_kill -> retain_dentry ->
> > d_lru_add -> list_lru_add), let alone while holding an internal
> > spinlock.
> > 
> > Putting a GFP_ATOMIC allocation inside 3-4 nested spinlocks in a
> > path we know might have memory demand in the *hundreds of GB* range
> > gets an NACK from me. It's a great idea, but it's just not a
> 
> I do understand that GFP_ATOMIC allocations are really not preferrable
> but want to point out that the allocations in the range of hundreds of
> GBs get reduced to tens of MBs when we do lazy list_lru head allocations
> under GFP_ATOMIC.

That does not make GFP_ATOMIC allocations safe or desirable. In
general, using GFP_ATOMIC outside of interrupt context indicates
something is being done incorrectly. Especially if it can be
triggered from userspace, which is likely in this particular case...



> As shown earlier, this is what I see in my experimental setup with
> 10k containers:
> 
> Number of kmalloc-32 allocations
> 		Before		During		After
> W/o patch	178176		3442409472	388933632
> W/  patch	190464		468992		468992

SO now we have an additional half million GFP_ATOMIC allocations
when we currently have none. That's not an improvement, that rings
loud alarm bells.

> This does really depend and vary on the type of the container and
> the number of mounts it does, but I suspect we are looking
> at GFP_ATOMIC allocations in the MB range. Also the number of
> GFP_ATOMIC slab allocation requests matter I suppose.

They are slab allocations, which mean every single one of them
could require a new slab backing page (pages!) to be allocated.
Hence the likely memory demand might be a lot higher than the
optimal case you are considering here...

> There are other users of list_lru, but I was just looking at
> dentry and inode list_lru usecase. It appears to me that for both
> dentry and inode, we can tolerate the failure from list_lru_add
> due to GFP_ATOMIC allocation failure. The failure to add dentry
> or inode to the lru list means that they won't be retained in
> the lru list, but would be freed immediately. Is this understanding
> correct?

No. Both retain_dentry() and iput_final() would currently leak
objects that fail insertion into the LRU. They don't check for
insertion success at all.

But, really, this is irrelevant - GFP_ATOMIC usage is the problem,
and allowing it to fail doesn't avoid the problems that unbound
GFP_ATOMIC allocation can have on the stability of the rest of the
system when low on memory. Being able to handle a GFP_ATOMIC memory
allocation failure doesn't change the fact that you should not be
doing GFP_ATOMIC allocation in the first place...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
