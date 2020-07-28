Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98792307CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 12:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgG1KjV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 06:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgG1KjV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:39:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3EC061794;
        Tue, 28 Jul 2020 03:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ypNJAwGRLRbYYnJEfcTCKIzmFirwGZ/k/RvbvuVZ8q4=; b=ZxsoqojnivhdOtNFQ7ijw8tFIS
        DW2+ZZdVqI+YTlXRfXfozGEbH0saMYPSlKwQFgNptwke3nKub9qOKLzuTljpCmSmuIi4DoV5ZmT+a
        ORDvwrsMfcuqK3Ko+zIHqF3P99gL9wRxJQHCLF8Fgx7lh7EslkDSBjnJ55dmRuZNkWhL0idV+rLVt
        MLT4DVYgUuZ2T/1BHmgk0so5e2riO7lt2CnymYnKd1s0zn87qz7kg+AcOzOe38dctjCghsWQdxtcB
        co4YxEvoJTQ21Q67Z6VyRIfwG33K2mPvRHnXc9YJRwSelSn+vgiQvyxBxhi5mdEa8Msv9zrnyTlHD
        rCwmh9nw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0N0n-0006gK-NF; Tue, 28 Jul 2020 10:39:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 561D2304BAE;
        Tue, 28 Jul 2020 12:39:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20888238A58A4; Tue, 28 Jul 2020 12:39:07 +0200 (CEST)
Date:   Tue, 28 Jul 2020 12:39:07 +0200
From:   peterz@infradead.org
To:     Xi Wang <xii@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com
Subject: Re: [PATCH] sched: Make select_idle_sibling search domain
 configurable
Message-ID: <20200728103907.GT119549@hirez.programming.kicks-ass.net>
References: <20200728070131.1629670-1-xii@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728070131.1629670-1-xii@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:01:31AM -0700, Xi Wang wrote:
> The scope of select_idle_sibling idle cpu search is LLC. This
> becomes a problem for the AMD CCX architecture, as the sd_llc is only
> 4 cores. On a many core machine, the range of search is too small to
> reach a satisfactory level of statistical multiplexing / efficient
> utilization of short idle time slices.
> 
> With this patch idle sibling search is detached from LLC and it
> becomes run time configurable. To reduce search and migration
> overheads, a presearch domain is added. The presearch domain will be
> searched first before the "main search" domain, e.g.:
> 
> sysctl_sched_wake_idle_domain == 2 ("MC" domain)
> sysctl_sched_wake_idle_presearch_domain == 1 ("DIE" domain)
> 
> Presearch will go through 4 cores of a CCX. If no idle cpu is found
> during presearch, full search will go through the remaining cores of
> a cpu socket.

*groan*, this is horrific :-(

It is also in direct conflict with people wanting to make it smaller.

On top of that, a domain number is a terrible terrible interface. They
aren't even available without SCHED_DEBUG on.

What is the inter-L3 latency? Going by this that had better be awesome.
And if this Infinity Fabric stuff if highly effective in effectively
merging L3s -- analogous to what Intel does with it's cache slices, then
should we not change the AMD topology setup instead of this 'thing'?

Also, this commit:

  051f3ca02e46 ("sched/topology: Introduce NUMA identity node sched domain")

seems to suggest L3 is actually bigger. Suravee, can you please comment?
