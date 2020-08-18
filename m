Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E827C2482E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 12:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHRK0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 06:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRK03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:26:29 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F43C061389;
        Tue, 18 Aug 2020 03:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VCX6Iv8QocyVcCbIivzpSCWISFs79AnDnWaSLIjrF8U=; b=j7wyfdQzzEZMB+e5Nys0bXVBDM
        vXxWFcYB/mrjbGXoK6s/YyXkyE6PEiHxe/nBfggrXwCHEBYZoA+0zTm5Vb1AstfB31VWdqkUhz+Lu
        GhuVveE3fX33vy9iOUGmUOGQTpcnGX8Le2X92V55OQNMd6LaHzwBqsrrTz20Loi9qbnaDar3Egck5
        ZPIiaa51a22YyQbTto8qWi2dofwWO9ePhTZU9EQfrLwzHhf1SZ7eMIaQETjafCmtTZEowmxaz8kI+
        BRM4AOz+8lAiFZuTvd6ErYylKdURKpdwxPyyZ4ER3Pkd/KKNdee92nG2DliqRsgvFcnLS+HFsElKf
        m1hCpYeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7yos-0004EG-CM; Tue, 18 Aug 2020 10:26:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 09548300DB4;
        Tue, 18 Aug 2020 12:26:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E60632B76E7C6; Tue, 18 Aug 2020 12:26:16 +0200 (CEST)
Date:   Tue, 18 Aug 2020 12:26:16 +0200
From:   peterz@infradead.org
To:     Chris Down <chris@chrisdown.name>
Cc:     Michal Hocko <mhocko@suse.com>, Waiman Long <longman@redhat.com>,
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
Message-ID: <20200818102616.GP2674@hirez.programming.kicks-ass.net>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092617.GN28270@dhcp22.suse.cz>
 <20200818095910.GM2674@hirez.programming.kicks-ass.net>
 <20200818101756.GA155582@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818101756.GA155582@chrisdown.name>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:17:56AM +0100, Chris Down wrote:

> I'd ask that you understand a bit more about the tradeoffs and intentions of
> the patch before rushing in to declare its failure, considering it works
> just fine :-)
> 
> Clamping the maximal time allows the application to take some action to
> remediate the situation, while still being slowed down significantly. 2
> seconds per allocation batch is still absolutely plenty for any use case
> I've come across. If you have evidence it isn't, then present that instead
> of vague notions of "wrongness".

There is no feedback from the freeing rate, therefore it cannot be
correct in maintaining a maximum amount of pages.

0.5 pages / sec is still non-zero, and if the free rate is 0, you'll
crawl across whatever limit was set without any bounds. This is math
101.

It's true that I haven't been paying attention to mm in a while, but I
was one of the original authors of the I/O dirty balancing, I do think I
understand how these things work.
