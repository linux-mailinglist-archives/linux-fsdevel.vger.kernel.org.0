Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7C3466802
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 09:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfGLHxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 03:53:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfGLHx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yBJq9CDSWPk31o8rRIJukShqhxBMe0EUUUqQoPxta+0=; b=Qj1RfR/O8WufKxSqWgw5cNtHdP
        EiGCtkdhnfwmBHRpq16DvuUT5c9pJocq2KVloiR2wNQRjNvSizqzigMTOuvCIrABB4VRLg6nt0atI
        +9JPW+rbGxfKWv0Dwzg/13BWWqMwyt912a0wnbJ/4Q+pt5oU9IqVCIdxofj9cz2RmTvKze+nm2k9S
        IzDbo38zYGjtuGmMto/J0ZEiGXsNyHPTCL3lyS5bh+k6uG3uZl8ODKmLzV2S1U/NKL3x+bBuuHwtH
        e/TOKwj9nw7Mi5MRQPOuizEX9cEzb6LV9O7izC5X3w9vMRSmw8OpUkwxZjXoaIsqnY2/nJ3Av7SRr
        wE54IWHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlqMq-0004VU-NY; Fri, 12 Jul 2019 07:53:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C950520B2B4C6; Fri, 12 Jul 2019 09:53:18 +0200 (CEST)
Date:   Fri, 12 Jul 2019 09:53:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, riel@surriel.com
Subject: Re: [PATCH 4/4] numa: introduce numa cling feature
Message-ID: <20190712075318.GM3402@hirez.programming.kicks-ass.net>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <9a440936-1e5d-d3bb-c795-ef6f9839a021@linux.alibaba.com>
 <20190711142728.GF3402@hirez.programming.kicks-ass.net>
 <82f42063-ce51-dd34-ba95-5b32ee733de7@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82f42063-ce51-dd34-ba95-5b32ee733de7@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 11:10:08AM +0800, 王贇 wrote:
> On 2019/7/11 下午10:27, Peter Zijlstra wrote:

> >> Thus we introduce the numa cling, which try to prevent tasks leaving
> >> the preferred node on wakeup fast path.
> > 
> > 
> >> @@ -6195,6 +6447,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >>  	if ((unsigned)i < nr_cpumask_bits)
> >>  		return i;
> >>
> >> +	/*
> >> +	 * Failed to find an idle cpu, wake affine may want to pull but
> >> +	 * try stay on prev-cpu when the task cling to it.
> >> +	 */
> >> +	if (task_numa_cling(p, cpu_to_node(prev), cpu_to_node(target)))
> >> +		return prev;
> >> +
> >>  	return target;
> >>  }
> > 
> > Select idle sibling should never cross node boundaries and is thus the
> > entirely wrong place to fix anything.
> 
> Hmm.. in our early testing the printk show both select_task_rq_fair() and
> task_numa_find_cpu() will call select_idle_sibling with prev and target on
> different node, thus we pick this point to save few lines.

But it will never return @prev if it is not in the same cache domain as
@target. See how everything is gated by:

  && cpus_share_cache(x, target)

> But if the semantics of select_idle_sibling() is to return cpu on the same
> node of target, what about move the logical after select_idle_sibling() for
> the two callers?

No, that's insane. You don't do select_idle_sibling() to then ignore the
result. You have to change @target before calling select_idle_sibling().
