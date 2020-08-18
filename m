Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31548248281
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 12:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgHRKE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 06:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRKE6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:04:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF99C061389;
        Tue, 18 Aug 2020 03:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pE8vmQW7SZy0+JnQJV6um55H7ktisT4GBi3Ij24COKw=; b=Ec+Zcl4xLw+ZX6xKNyn+LxSmLG
        EZ0TRWdmzTaNznp3475KXmL3ObxYB8nifTSAaMXiLeZUks0Nj5dKNXO1Xn7KLLyXdVmocwwsjI4lS
        vle42FQMDNCGwBA718/gxyq2awU9AUycF2AWtY7YvO2anUpmOw2nxD9NNLylDwT1Y8AgDnFt0tIMK
        aXjKb+XCYELLhPQAQvh3b4tpgmLWW2qDfIU9Sookz16wBzOHVP9oWOoFLBkp/Z9O3ds+gd5jHL6Rv
        yKky0b51qKBgFHHFuKF0rKJf3lONp/eBNtXBzBQs52mYwF+8Rn0gH3SW7XRRift4xDJ6wOYiRrsi7
        klLCmhAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7yU0-00009c-R9; Tue, 18 Aug 2020 10:04:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48FD9301179;
        Tue, 18 Aug 2020 12:04:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F8A722E9BD47; Tue, 18 Aug 2020 12:04:44 +0200 (CEST)
Date:   Tue, 18 Aug 2020 12:04:44 +0200
From:   peterz@infradead.org
To:     Chris Down <chris@chrisdown.name>
Cc:     Waiman Long <longman@redhat.com>,
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
Message-ID: <20200818100444.GN2674@hirez.programming.kicks-ass.net>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092737.GA148695@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818092737.GA148695@chrisdown.name>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:27:37AM +0100, Chris Down wrote:
> peterz@infradead.org writes:
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
> We already do that since v5.4. I'm wondering whether Waiman's customer is
> just running with a too-old kernel without 0e4b01df865 ("mm, memcg: throttle
> allocators when failing reclaim over memory.high") backported.

That commit is fundamentally broken, it doesn't guarantee anything.

Please go read how the dirty throttling works (unless people wrecked
that since..).
