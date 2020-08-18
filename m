Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B068248266
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 11:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHRJ7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRJ72 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:59:28 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED336C061389;
        Tue, 18 Aug 2020 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AMCRlHQqFClUdfDgWF0Pc4T0d8x7BsArDzhjVVkMBFc=; b=xgXKcBxjIZlrJ2bfw/hT1bnAoS
        kBjjfcb6QgfBLTcDMcHpy8F4bRDIAIYsX+KlAFGVgPJObGB0scLri+4ZnTtHvYjeaQF7lshfo8YNf
        NFmwu+hYtQ1fCP1mgDGFnFFJkkKQHjZU4cWQWZDVowbL6lgdSb17nzCmGp+WBJ8GQIT+Y2soQbKo9
        Zdjf17B1voahyFMG7Hhq4akH3EGdqexyEj9wWM+kB6N8masvpaQTPJ5wzSo62sMaUVtMNCUck34Y9
        wNNgjNvKf/jG+0QOKa2zufhfKfliZLU8qGC4oj+TBUtiDaZ89RlznYJOt0N4MT4x2OoGYFzEugjqv
        oU5eG/DA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7yOf-0000ZR-Ew; Tue, 18 Aug 2020 09:59:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B322300DB4;
        Tue, 18 Aug 2020 11:59:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64F6822E9BD55; Tue, 18 Aug 2020 11:59:10 +0200 (CEST)
Date:   Tue, 18 Aug 2020 11:59:10 +0200
From:   peterz@infradead.org
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <20200818095910.GM2674@hirez.programming.kicks-ass.net>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092617.GN28270@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818092617.GN28270@dhcp22.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:26:17AM +0200, Michal Hocko wrote:
> On Tue 18-08-20 11:14:53, Peter Zijlstra wrote:
> > On Mon, Aug 17, 2020 at 10:08:23AM -0400, Waiman Long wrote:
> > > Memory controller can be used to control and limit the amount of
> > > physical memory used by a task. When a limit is set in "memory.high" in
> > > a v2 non-root memory cgroup, the memory controller will try to reclaim
> > > memory if the limit has been exceeded. Normally, that will be enough
> > > to keep the physical memory consumption of tasks in the memory cgroup
> > > to be around or below the "memory.high" limit.
> > > 
> > > Sometimes, memory reclaim may not be able to recover memory in a rate
> > > that can catch up to the physical memory allocation rate. In this case,
> > > the physical memory consumption will keep on increasing. 
> > 
> > Then slow down the allocator? That's what we do for dirty pages too, we
> > slow down the dirtier when we run against the limits.
> 
> This is what we actually do. Have a look at mem_cgroup_handle_over_high.

But then how can it run-away like Waiman suggested?

/me goes look... and finds MEMCG_MAX_HIGH_DELAY_JIFFIES.

That's a fail... :-(
