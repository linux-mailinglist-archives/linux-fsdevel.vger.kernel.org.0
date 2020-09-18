Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C9426F8EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 11:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIRJHF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 05:07:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:38864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgIRJHF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:07:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA1ECAE09;
        Fri, 18 Sep 2020 09:07:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7145D1E12E1; Fri, 18 Sep 2020 11:07:02 +0200 (CEST)
Date:   Fri, 18 Sep 2020 11:07:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Boaz Harrosh <boaz@plexistor.com>, Hou Tao <houtao1@huawei.com>,
        peterz@infradead.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200918090702.GB18920@quack2.suse.cz>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
 <20200917120132.GA5602@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917120132.GA5602@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-09-20 14:01:33, Oleg Nesterov wrote:
> On 09/17, Boaz Harrosh wrote:
> >
> > On 16/09/2020 15:32, Hou Tao wrote:
> > <>
> > >However the performance degradation is huge under aarch64 (4 sockets, 24 core per sockets): nearly 60% lost.
> > >
> > >v4.19.111
> > >no writer, reader cn                               | 24        | 48        | 72        | 96
> > >the rate of down_read/up_read per second           | 166129572 | 166064100 | 165963448 | 165203565
> > >the rate of down_read/up_read per second (patched) |  63863506 |  63842132 |  63757267 |  63514920
> > >
> >
> > I believe perhaps Peter Z's suggestion of an additional
> > percpu_down_read_irqsafe() API and let only those in IRQ users pay the
> > penalty.
> >
> > Peter Z wrote:
> > >My leading alternative was adding: percpu_down_read_irqsafe() /
> > >percpu_up_read_irqsafe(), which use local_irq_save() instead of
> > >preempt_disable().
> 
> This means that __sb_start/end_write() and probably more users in fs/super.c
> will have to use this API, not good.
> 
> IIUC, file_end_write() was never IRQ safe (at least if !CONFIG_SMP), even
> before 8129ed2964 ("change sb_writers to use percpu_rw_semaphore"), but this
> doesn't matter...
> 
> Perhaps we can change aio.c, io_uring.c and fs/overlayfs/file.c to avoid
> file_end_write() in IRQ context, but I am not sure it's worth the trouble.

Well, that would be IMO rather difficult. We need to do file_end_write()
after the IO has completed so if we don't want to do it in IRQ context,
we'd have to queue a work to a workqueue or something like that. And that's
going to be expensive compared to pure per-cpu inc/dec...

If people really wanted to avoid irq-safe inc/dec for archs where it is
more expensive, one idea I had was that we could add 'read_count_in_irq' to
percpu_rw_semaphore. So callers in normal context would use read_count and
callers in irq context would use read_count_in_irq. And the writer side
would sum over both but we don't care about performance of that one much.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
