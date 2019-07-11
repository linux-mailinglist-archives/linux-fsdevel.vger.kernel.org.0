Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF7706580D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 15:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfGKNpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 09:45:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55348 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfGKNpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=motTGlaLa78AkkT94ppPVZ2/Cr7h+cvS3zIYf8Ec2sw=; b=YrXbIX5qnEOqZJQGogVWSKOxdl
        nGFNn6+c0qufC1VtyAe6+rL5HrRV67MuO+rpGnEO0OyUNgeIEPyNiSiZrfk6aZZrK5WNwcSr/8dyK
        A26SZPB2XsuHf+D4zUZlaMuqB+7kEyEb+ngAnNP6xe5ohRPxdletoBrzIZXJ31TWB1dFGaguDRjL6
        GRsekT6kNLxlJ7kZwHIlito+ouKUCAR/I/CsOhElJJb1HCWsIfFsFnE2fFyvtCjGYfq8lmKOXoZik
        mAS0/IpGxoFZ8o1KHUmMwLXx5fGM8kctE7QQMdPbSolTQ9Qd+HRIStso/avMYCaTNCZnK6yy3EO1W
        VNCWBhCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlZO4-0003nk-NU; Thu, 11 Jul 2019 13:45:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E86920B54EA8; Thu, 11 Jul 2019 15:45:27 +0200 (CEST)
Date:   Thu, 11 Jul 2019 15:45:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, riel@surriel.com
Subject: Re: [PATCH 2/4] numa: append per-node execution info in
 memory.numa_stat
Message-ID: <20190711134527.GC3402@hirez.programming.kicks-ass.net>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <825ebaf0-9f71-bbe1-f054-7fa585d61af1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <825ebaf0-9f71-bbe1-f054-7fa585d61af1@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 03, 2019 at 11:29:15AM +0800, 王贇 wrote:

> +++ b/include/linux/memcontrol.h
> @@ -190,6 +190,7 @@ enum memcg_numa_locality_interval {
> 
>  struct memcg_stat_numa {
>  	u64 locality[NR_NL_INTERVAL];
> +	u64 exectime;

Maybe call the field jiffies, because that's what it counts.

>  };
> 
>  #endif
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2edf3f5ac4b9..d5f48365770f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3575,6 +3575,18 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
>  		seq_printf(m, " %u", jiffies_to_msecs(sum));
>  	}
>  	seq_putc(m, '\n');
> +
> +	seq_puts(m, "exectime");
> +	for_each_online_node(nr) {
> +		int cpu;
> +		u64 sum = 0;
> +
> +		for_each_cpu(cpu, cpumask_of_node(nr))
> +			sum += per_cpu(memcg->stat_numa->exectime, cpu);
> +
> +		seq_printf(m, " %llu", jiffies_to_msecs(sum));
> +	}
> +	seq_putc(m, '\n');
>  #endif
> 
>  	return 0;
