Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FE726FAE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 12:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgIRKsi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 06:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbgIRKsg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600426114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R1chLQYyqvdYMEdkQJ5aLl7aSBAy8CC1WIB+Xh754Tw=;
        b=hRCZSfYBwKtO8WOnpbG7aq8jxgaSsfXLUWos+DzjzwXRUH/W0cNaHte1ijAuw+OJTo8rEK
        1fdee+yNZTfHupUuNISKmo3pib0BMBjogocrrD9jiiBDwCGueavyC0lUZBjmoHsn0NYkVD
        iieYlTI58AWUDBjyuaj+wlCoQRePhpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-SrCELimjN-W__2WG3SIN9A-1; Fri, 18 Sep 2020 06:48:31 -0400
X-MC-Unique: SrCELimjN-W__2WG3SIN9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15A38640A0;
        Fri, 18 Sep 2020 10:48:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.72])
        by smtp.corp.redhat.com (Postfix) with SMTP id F32135DEBF;
        Fri, 18 Sep 2020 10:48:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 18 Sep 2020 12:48:28 +0200 (CEST)
Date:   Fri, 18 Sep 2020 12:48:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     peterz@infradead.org
Cc:     Jan Kara <jack@suse.cz>, Boaz Harrosh <boaz@plexistor.com>,
        Hou Tao <houtao1@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200918104824.GA23469@redhat.com>
References: <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
 <20200917120132.GA5602@redhat.com>
 <20200918090702.GB18920@quack2.suse.cz>
 <20200918100112.GN1362448@hirez.programming.kicks-ass.net>
 <20200918101216.GL35926@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918101216.GL35926@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/18, Peter Zijlstra wrote:
>
> On Fri, Sep 18, 2020 at 12:01:12PM +0200, peterz@infradead.org wrote:
> > +	u64 sum = per_cpu_sum(*(u64 *)sem->read_count);
>
> Moo, that doesn't work, we have to do two separate sums.

Or we can re-introduce "atomic_t slow_read_ctr".

	percpu_up_read_irqsafe(sem)
	{
		preempt_disable();
		atomic_dec_release(&sem->slow_read_ctr);
		if (!rcu_sync_is_idle(&sem->rss))
			rcuwait_wake_up(&sem->writer);
		preempt_enable();
	}

	readers_active_check(sem)
	{
		unsigned int sum = per_cpu_sum(*sem->read_count) +
			(unsigned int)atomic_read(&sem->slow_read_ctr);
		if (sum)
			return false;
		...
	}

Of course, this assumes that atomic_t->counter underflows "correctly", just
like "unsigned int".

But again, do we really want this?

Oleg.

