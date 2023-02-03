Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A0E689464
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 10:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjBCJv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 04:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjBCJvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:51:25 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE667EDF;
        Fri,  3 Feb 2023 01:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VqJqS6npLKIiNe5AEXZhFQk5R3HIEFJ+u6UVRW2cKIs=; b=isWRl/avDUjmYiGVKnXYTOaLkf
        /JpiAZU9+DXbhtnv1CKViaTZFQ98RaOUVkhe2586gakIJXalJuXP4rB5rpx7iODOgL8FGtrZmbUUE
        dJfN9Ah4lC3VEovAHHz8yELe+w9Pep3sZqxxUHZF36xumRdb5nTWIbG3Y0I5Juofgl4caro6baPUD
        dtQ5kR6F1Dh4NGxy0g02lvgB51iQcEiHuKqIZp0fTEWiauRsaQEUQ6V+BQ7B+FOV9WeMwnlMBS7l4
        HikiggaZBau2SLkvVfu6Dm4xjqFRuf/KKPbUzl5u/CHLgTdl7N3oFlYCQExj5I9mhTtPBj35G0cP3
        GAn8w6zg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pNsiJ-005Tl6-2S;
        Fri, 03 Feb 2023 09:50:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2418300446;
        Fri,  3 Feb 2023 10:51:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF3202136B38A; Fri,  3 Feb 2023 10:51:09 +0100 (CET)
Date:   Fri, 3 Feb 2023 10:51:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xi Wang <xii@google.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched: Consider capacity for certain load balancing
 decisions
Message-ID: <Y9zZDcIua63WOdG7@hirez.programming.kicks-ass.net>
References: <20230201012032.2874481-1-xii@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201012032.2874481-1-xii@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 05:20:32PM -0800, Xi Wang wrote:
> After load balancing was split into different scenarios, CPU capacity
> is ignored for the "migrate_task" case, which means a thread can stay
> on a softirq heavy cpu for an extended amount of time.
> 
> By comparing nr_running/capacity instead of just nr_running we can add
> CPU capacity back into "migrate_task" decisions. This benefits
> workloads running on machines with heavy network traffic. The change
> is unlikely to cause serious problems for other workloads but maybe
> some corner cases still need to be considered.
> 
> Signed-off-by: Xi Wang <xii@google.com>
> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0f8736991427..aad14bc04544 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10368,8 +10368,9 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  			break;
>  
>  		case migrate_task:
> -			if (busiest_nr < nr_running) {
> +			if (busiest_nr * capacity < nr_running * busiest_capacity) {
>  				busiest_nr = nr_running;
> +				busiest_capacity = capacity;
>  				busiest = rq;
>  			}
>  			break;

I don't think this is correct. The migrate_task case is work-conserving,
and your change can severely break that I think.

