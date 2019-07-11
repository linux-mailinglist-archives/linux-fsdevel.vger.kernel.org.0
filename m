Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C372B658FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 16:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfGKO1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 10:27:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55754 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbfGKO1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kgSCqCMgkzHP3NI7bApdCQ2mgMy1VndTbhMfuP51VMY=; b=vYqpYvpe4pu04ng6B0A06A2Ebt
        IEotIWqUDGlLiIeJXs3STCRzutaBfRE8kMERKV9c7ZRD5PB+jVgbutrHwHhFQdoFSNubb17mq05ay
        pILpcnf6sG5BKWFktgHStubOK9UqnnoPCyptfIMcsrCDcCoV/zaZdI6rh/UVSFFCapTpb0LStSgYV
        XEAUQnYOyieF5R42wT7u2kL17EUSlkCjtyvlmXvQQsct3CXPyDLrc3Cixv/gAoOluBL6Y/OSSpg9A
        iqvrC7IKzdy209HkI4yhcxi7UtnvQ5PpTa86x0CyyEahVMeohTVHZCpUSg97S19SCOjj4iR+cjY8o
        1+fQ8g6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hla2n-0003zh-2O; Thu, 11 Jul 2019 14:27:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D714220213042; Thu, 11 Jul 2019 16:27:28 +0200 (CEST)
Date:   Thu, 11 Jul 2019 16:27:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, riel@surriel.com
Subject: Re: [PATCH 4/4] numa: introduce numa cling feature
Message-ID: <20190711142728.GF3402@hirez.programming.kicks-ass.net>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <9a440936-1e5d-d3bb-c795-ef6f9839a021@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a440936-1e5d-d3bb-c795-ef6f9839a021@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 03, 2019 at 11:34:16AM +0800, 王贇 wrote:
> Although we paid so many effort to settle down task on a particular
> node, there are still chances for a task to leave it's preferred
> node, that is by wakeup, numa swap migrations or load balance.
> 
> When we are using cpu cgroup in share way, since all the workloads
> see all the cpus, it could be really bad especially when there
> are too many fast wakeup, although now we can numa group the tasks,
> they won't really stay on the same node, for example we have numa
> group ng_A, ng_B, ng_C, ng_D, it's very likely result as:
> 
> 	CPU Usage:
> 		Node 0		Node 1
> 		ng_A(600%)	ng_A(400%)
> 		ng_B(400%)	ng_B(600%)
> 		ng_C(400%)	ng_C(600%)
> 		ng_D(600%)	ng_D(400%)
> 
> 	Memory Ratio:
> 		Node 0		Node 1
> 		ng_A(60%)	ng_A(40%)
> 		ng_B(40%)	ng_B(60%)
> 		ng_C(40%)	ng_C(60%)
> 		ng_D(60%)	ng_D(40%)
> 
> Locality won't be too bad but far from the best situation, we want
> a numa group to settle down thoroughly on a particular node, with
> every thing balanced.
> 
> Thus we introduce the numa cling, which try to prevent tasks leaving
> the preferred node on wakeup fast path.


> @@ -6195,6 +6447,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	if ((unsigned)i < nr_cpumask_bits)
>  		return i;
> 
> +	/*
> +	 * Failed to find an idle cpu, wake affine may want to pull but
> +	 * try stay on prev-cpu when the task cling to it.
> +	 */
> +	if (task_numa_cling(p, cpu_to_node(prev), cpu_to_node(target)))
> +		return prev;
> +
>  	return target;
>  }

Select idle sibling should never cross node boundaries and is thus the
entirely wrong place to fix anything.
