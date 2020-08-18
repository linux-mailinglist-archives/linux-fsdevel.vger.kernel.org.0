Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559C0248578
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 14:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHRM4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 08:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgHRM4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:56:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289F3C061389;
        Tue, 18 Aug 2020 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mnr9o5vomenMnjGSwOgADsZNSiDQs16XxuJQkA6pw7A=; b=pUGj2IxnkHV9vZueIpbwqji2Jz
        4osZe4zjTl6vy8j4O1GqSzuht1xZTlDq/nyo7Zt88MLI0EF3+bRsp7khSHVkul6jXPUt6jbUcGgqX
        wB2TcbFBTZRD44Iz4OBsNLp9tT2pWHDXZxgDCYE1sqJxFC8/2qUdR7Gr5kHMA+fihdG3Xd3EPQgs3
        1Yi3ukQgtyCHWgNKqxRmqGQFa7YJ77FBhxgwcSBJ0sTftYxwm0Zr5Kz0hFwQ+NrV3N+Gfdg3tiPoG
        TFHH6wJpI5/01cnU9Z5jhHgml1eM1Aji19CV+ORA8lxPNw/zaz+KJse0bAZLt4mKIZPP3ziA3p9kW
        bOdS3v4g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k819j-0001m3-9N; Tue, 18 Aug 2020 12:55:59 +0000
Date:   Tue, 18 Aug 2020 13:55:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     peterz@infradead.org
Cc:     Chris Down <chris@chrisdown.name>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
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
Message-ID: <20200818125559.GP17456@casper.infradead.org>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092737.GA148695@chrisdown.name>
 <20200818100444.GN2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818100444.GN2674@hirez.programming.kicks-ass.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:04:44PM +0200, peterz@infradead.org wrote:
> On Tue, Aug 18, 2020 at 10:27:37AM +0100, Chris Down wrote:
> > peterz@infradead.org writes:
> > > On Mon, Aug 17, 2020 at 10:08:23AM -0400, Waiman Long wrote:
> > > > Memory controller can be used to control and limit the amount of
> > > > physical memory used by a task. When a limit is set in "memory.high" in
> > > > a v2 non-root memory cgroup, the memory controller will try to reclaim
> > > > memory if the limit has been exceeded. Normally, that will be enough
> > > > to keep the physical memory consumption of tasks in the memory cgroup
> > > > to be around or below the "memory.high" limit.
> > > > 
> > > > Sometimes, memory reclaim may not be able to recover memory in a rate
> > > > that can catch up to the physical memory allocation rate. In this case,
> > > > the physical memory consumption will keep on increasing.
> > > 
> > > Then slow down the allocator? That's what we do for dirty pages too, we
> > > slow down the dirtier when we run against the limits.
> > 
> > We already do that since v5.4. I'm wondering whether Waiman's customer is
> > just running with a too-old kernel without 0e4b01df865 ("mm, memcg: throttle
> > allocators when failing reclaim over memory.high") backported.
> 
> That commit is fundamentally broken, it doesn't guarantee anything.
> 
> Please go read how the dirty throttling works (unless people wrecked
> that since..).

Of course they did.

https://lore.kernel.org/linux-mm/ce7975cd-6353-3f29-b52c-7a81b1d07caa@kernel.dk/
