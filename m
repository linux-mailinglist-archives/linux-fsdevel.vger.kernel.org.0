Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0ADB65803
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 15:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfGKNoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 09:44:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55320 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfGKNoN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TBOYZ0TJRtXkPl4BWDGsbuy8MB5If3yCD5dZFWq2zO0=; b=0h1y0UG2apY07KX9lcujJGVlJP
        7BsFf1QI7kw9dZ9QFkRN3jZ6jGNVYCzTa9mcxtQ9ECqThLZHq8pvoqpJAwHtZwCw4GlnXAnvFxTde
        /s6Rv+1nVR1RHDbRwHgdRqXnLXLSJyjrWtkvM72Z5wjn8t10N+jIVsGNJqJfjpLOh+cMY0UPaFnpS
        Y0jg5QWZJcIPZ3DBM9zgnuKPMu9KtfYaQXk/pYEjsMfjdI/MPf2Zuev6ivKE1FS8IG27KMVgxpuh/
        69sHVDz+IxevRGT0k3TCldwKV3SdXxMD/60u4cPGqHLssnGQVDeCvbdNdd8Np/pb0LbrA7hcCPDk+
        znssWpkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlZMZ-0003nD-9M; Thu, 11 Jul 2019 13:43:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4BBC20B54EA6; Thu, 11 Jul 2019 15:43:53 +0200 (CEST)
Date:   Thu, 11 Jul 2019 15:43:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, riel@surriel.com
Subject: Re: [PATCH 1/4] numa: introduce per-cgroup numa balancing locality,
 statistic
Message-ID: <20190711134353.GB3402@hirez.programming.kicks-ass.net>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <3ac9b43a-cc80-01be-0079-df008a71ce4b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ac9b43a-cc80-01be-0079-df008a71ce4b@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 03, 2019 at 11:28:10AM +0800, 王贇 wrote:
> +#ifdef CONFIG_NUMA_BALANCING
> +
> +enum memcg_numa_locality_interval {
> +	PERCENT_0_29,
> +	PERCENT_30_39,
> +	PERCENT_40_49,
> +	PERCENT_50_59,
> +	PERCENT_60_69,
> +	PERCENT_70_79,
> +	PERCENT_80_89,
> +	PERCENT_90_100,
> +	NR_NL_INTERVAL,
> +};

That's just daft; why not make 8 equal sized buckets.

> +struct memcg_stat_numa {
> +	u64 locality[NR_NL_INTERVAL];
> +};

> +	if (remote || local) {
> +		idx = ((local * 10) / (remote + local)) - 2;

		idx = (NR_NL_INTERVAL * local) / (remote + local);

> +	}
> +
> +	rcu_read_lock();
> +	memcg = mem_cgroup_from_task(p);
> +	if (idx != -1)
> +		this_cpu_inc(memcg->stat_numa->locality[idx]);
> +	rcu_read_unlock();
> +}
> +#endif
