Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4872A24E0BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 21:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHUThd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 15:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgHUThb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:37:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BDEC061573;
        Fri, 21 Aug 2020 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N3ZGTcGJdfl/OTaIgJwrIkHSk+AkqKBFZGMv7k7JAjc=; b=ggzc/B/8OBjbLuwpgTkXf/pU42
        +EOW+Btl5c58I6tA9Tz1DotvxKyQlEce8eaHFx5uPaj+FAJO5eNeSstr8eK32iVfkZX9BRWclAhwZ
        OToYv7Axe6/UemxFJFZtndQZLIFCKFhxZ+MicIpQ8D2ApWwHovB9Qo8srTIBnFpw3chOTGT/K2CGp
        QDl7EaMCU/DeA8Ba3GZGENthYYt7qc6MSlkzrz8gl43DMD/4tUAsV3LVKmPDXUozBTfBOHQo3pvCS
        Lx7OuGNZE83kZvcZUsnl0RTEslw9K9K9Qom8MsixP0YIQpoLJF5WMetdTe20APCXCS1WvfV1v90Sq
        /JStoxmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9Cqj-0005Lt-JW; Fri, 21 Aug 2020 19:37:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCBA8980DF7; Fri, 21 Aug 2020 21:37:16 +0200 (CEST)
Date:   Fri, 21 Aug 2020 21:37:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/8] memcg: Enable fine-grained per process memory
 control
Message-ID: <20200821193716.GU3982@worktop.programming.kicks-ass.net>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092617.GN28270@dhcp22.suse.cz>
 <20200818095910.GM2674@hirez.programming.kicks-ass.net>
 <20200818100516.GO28270@dhcp22.suse.cz>
 <20200818101844.GO2674@hirez.programming.kicks-ass.net>
 <20200818134900.GA829964@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818134900.GA829964@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 09:49:00AM -0400, Johannes Weiner wrote:
> On Tue, Aug 18, 2020 at 12:18:44PM +0200, peterz@infradead.org wrote:
> > What you need is a feeback loop against the rate of freeing pages, and
> > when you near the saturation point, the allocation rate should exactly
> > match the freeing rate.
> 
> IO throttling solves a slightly different problem.
> 
> IO occurs in parallel to the workload's execution stream, and you're
> trying to take the workload from dirtying at CPU speed to rate match
> to the independent IO stream.
> 
> With memory allocations, though, freeing happens from inside the
> execution stream of the workload. If you throttle allocations, you're

For a single task, but even then you're making the argument that we need
to allocate memory to free memory, and we all know where that gets us.

But we're actually talking about a cgroup here, which is a collection of
tasks all doing things in parallel.

> most likely throttling the freeing rate as well. And you'll slow down
> reclaim scanning by the same amount as the page references, so it's
> not making reclaim more successful either. The alloc/use/free
> (im)balance is an inherent property of the workload, regardless of the
> speed you're executing it at.

Arguably seeing the rate drop to near 0 is a very good point to consider
running cgroup-OOM.
