Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B0614CFC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 18:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgA2Ri7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 12:38:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA2Ri6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gc3ks24OG6X76f+yAGA45eM4fknNEyoh+zvpOec4XLI=; b=DrEnxIvCOx0T33JROVafFekwY
        od8NQOjAsF4gsSr7L8yMUUamw6VwZ1Wyft5tj9oxTzG4tggqa6ey8DL49jQvhTQdsFvPDBmIU/KVG
        PB0J9pjy9pJ3BfdksVsr8Zld0Yko146sw5ph/We4CMg3DxBh6Tak08DBYSCF9azbKb+GNy5nbpR7V
        HwRqrp2IREayDQEteLRQ5hopWzdUMdrI1uQZ5bOZVdHvtlmqXcERa+8H20vpXLPZLXdcC8iEjvK7R
        WS/hdcvcFX7FO0SUm/yYqkFvg/RMAyGc43DOlfjjB4jqWqVYT3OboKwHOkv9ywOFKlONZAFB2auMs
        EmC7jW0gg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwrIk-0003Xh-JK; Wed, 29 Jan 2020 17:38:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52E533035D4;
        Wed, 29 Jan 2020 18:37:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BFEA2B7334C0; Wed, 29 Jan 2020 18:38:52 +0100 (CET)
Date:   Wed, 29 Jan 2020 18:38:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>, Phil Auld <pauld@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched, fair: Allow a per-cpu kthread waking a task to
 stack on the same CPU
Message-ID: <20200129173852.GP14914@hirez.programming.kicks-ass.net>
References: <20200127143608.GX3466@techsingularity.net>
 <20200127223256.GA18610@dread.disaster.area>
 <20200128011936.GY3466@techsingularity.net>
 <20200128091012.GZ3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128091012.GZ3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 28, 2020 at 09:10:12AM +0000, Mel Gorman wrote:
> Peter, Ingo and Vincent -- I know the timing is bad due to the merge
> window but do you have any thoughts on allowing select_idle_sibling to
> stack a wakee task on the same CPU as a waker in this specific case?

I sort of see, but *groan*...

so if the kworker unlocks a contended mutex/rwsem/completion...

I suppose the fact that it limits it to tasks that were running on the
same CPU limits the impact if we do get it wrong.

Elsewhere you write:

> I would prefer the wakeup code did not have to signal that it's a
> synchronous wakeup. Sync wakeups so exist but callers got it wrong many
> times where stacking was allowed and then the waker did not go to sleep.
> While the chain of events are related, they are not related in a very
> obvious way. I think it's much safer to keep this as a scheduler
> heuristic instead of depending on callers to have sufficient knowledge
> of the scheduler implementation.

That is true; the existing WF_SYNC has caused many issues for maybe
being too strong.

But what if we create a new hint that combines both these ideas? Say
WF_COMPLETE and subject that to these same criteria. This way we can
eliminate wakeups from locks and such (they won't have this set).

Or am I just making things complicated again?
