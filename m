Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275262482CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 12:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHRKS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 06:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgHRKS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:18:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D89C061389;
        Tue, 18 Aug 2020 03:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HP1xqIyJ0Z2PoaT6LGQfex8u1OM0JhiMqZ+Gafs9dGw=; b=d/+duAZaAzefByp0XFpldd9XZZ
        jb+OHF+tlem68S9hFSgzLn8Lv930zbK8UGuObZMxRQkG8PQodkdob/LCun4ESFOfTCVmTlpEYtAyN
        L7xKkWBAaw6dkyz3SH1NbPjVWjqOnR0JALmHyBepqV2JsNZMGGqSqOqrq3ANaQ8FHNtRmWAGdhGY8
        CxYR1esL35L+rLFC+fmRgkdP202MA8VJOooRf6uPDxbrwSO66qa1GSQXfkCpydHmHkzF1rAvHCGVR
        OJ8BXBD6e9EFiG9Qr/FobVl2ssBynzUAwK6/mIbz+B5rNph2oywm4zIIHKlcVLe7ezr5ugiaNHrVn
        PgFwbcKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7yhd-0000yn-0m; Tue, 18 Aug 2020 10:18:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9BCA0300DB4;
        Tue, 18 Aug 2020 12:18:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 578F722E9BD69; Tue, 18 Aug 2020 12:18:44 +0200 (CEST)
Date:   Tue, 18 Aug 2020 12:18:44 +0200
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
Message-ID: <20200818101844.GO2674@hirez.programming.kicks-ass.net>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092617.GN28270@dhcp22.suse.cz>
 <20200818095910.GM2674@hirez.programming.kicks-ass.net>
 <20200818100516.GO28270@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818100516.GO28270@dhcp22.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:05:16PM +0200, Michal Hocko wrote:
> > But then how can it run-away like Waiman suggested?
> 
> As Chris mentioned in other reply. This functionality is quite new.
>  
> > /me goes look... and finds MEMCG_MAX_HIGH_DELAY_JIFFIES.
> 
> We can certainly tune a different backoff delays but I suspect this is
> not the problem here.

Tuning? That thing needs throwing out, it's fundamentally buggered. Why
didn't anybody look at how the I/O drtying thing works first?

What you need is a feeback loop against the rate of freeing pages, and
when you near the saturation point, the allocation rate should exactly
match the freeing rate.

But this thing has nothing what so ever like that.
