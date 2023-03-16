Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D6D6BDA03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 21:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCPUU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 16:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCPUU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:20:57 -0400
X-Greylist: delayed 149162 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 13:20:55 PDT
Received: from out-34.mta0.migadu.com (out-34.mta0.migadu.com [IPv6:2001:41d0:1004:224b::22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87566F4B1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 13:20:55 -0700 (PDT)
Date:   Thu, 16 Mar 2023 13:20:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678998054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tp+E+qKzkiPQ9TteUgVP64dlXuOyGgf7R5+zJuVjYSM=;
        b=d6nBC/+ODd1bTK9Q0IPFjyCGN1iQ02clc+m2RmLBYjreQBYklevSuN12MY7zhDZjQX/XWM
        VH0dJshY6vsOTIgSNvH2twCYoS966PkaQTYkn8xGjN7yqVdR8+ou9+ZfNhW5XLkVjv14Yd
        nEqedL4bgTd8PmyOyZoYuY5h+zdPyFY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        bpf@vger.kernel.org, linux-xfs@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] SLOB+SLAB allocators removal and future SLUB
 improvements
Message-ID: <ZBN6Eus03wRSbqwf@P9FQF9L96D.corp.robot.car>
References: <4b9fc9c6-b48c-198f-5f80-811a44737e5f@suse.cz>
 <ZBEzUN35gOK5igmT@P9FQF9L96D>
 <c87d4f6c-e947-70b2-f74f-2e5145572123@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c87d4f6c-e947-70b2-f74f-2e5145572123@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Thu, Mar 16, 2023 at 09:18:11AM +0100, Vlastimil Babka wrote:
> On 3/15/23 03:54, Roman Gushchin wrote:
> > On Tue, Mar 14, 2023 at 09:05:13AM +0100, Vlastimil Babka wrote:
> >> As you're probably aware, my plan is to get rid of SLOB and SLAB, leaving
> >> only SLUB going forward. The removal of SLOB seems to be going well, there
> >> were no objections to the deprecation and I've posted v1 of the removal
> >> itself [1] so it could be in -next soon.
> >> 
> >> The immediate benefit of that is that we can allow kfree() (and kfree_rcu())
> >> to free objects from kmem_cache_alloc() - something that IIRC at least xfs
> >> people wanted in the past, and SLOB was incompatible with that.
> >> 
> >> For SLAB removal I haven't yet heard any objections (but also didn't
> >> deprecate it yet) but if there are any users due to particular workloads
> >> doing better with SLAB than SLUB, we can discuss why those would regress and
> >> what can be done about that in SLUB.
> >> 
> >> Once we have just one slab allocator in the kernel, we can take a closer
> >> look at what the users are missing from it that forces them to create own
> >> allocators (e.g. BPF), and could be considered to be added as a generic
> >> implementation to SLUB.
> > 
> > I guess eventually we want to merge the percpu allocator too.
> 
> What exactly do you mean here, probably not mm/percpu.c

Actually, I mean mm/percpu.c

> which is too different from slab

It is currently, but mostly for historical reasons, I guess.

In fact, all is needed (I drastically simplify here) is to replicate
an allocation for each cpu, which can be done by having special slab_caches
with a set of pages per cpu. I believe that in the long run the percpu allocator
can greatly benefit from it. The need for the performance and fragmentation avoidance
improvements grows with the increased number of percpu applications.

But it's not a small project by any means and to my knowledge nobody is actively
working on it, so my comment can be ignored now.

Thanks!
