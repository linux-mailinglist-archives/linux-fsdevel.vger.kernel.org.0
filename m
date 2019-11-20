Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C83104415
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 20:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKTTQn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 14:16:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfKTTQn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+uiX8Y1FAOVx63BgGhdqk6UFOCjK1eb99TNr3TVgrIU=; b=BqmvakRCAIVKzYcDLg/Qch27X
        35mFslRqqVAYqgbmgTvsmMp3M12VvLOROf5bcDJwZF/FJYUNy8Yk9NmXULSy5g8/pblUsDD2TDfpK
        BniKwfa3nTylt+8dPT8sl3zfVEBzm0Sl8fe1gz+cvuGMeUX8ufazZqcpvN1pVjjUuPqUHyxXv+7J6
        sRiuyR6E3hhc1T98sqjCzwFtFe5OXhKGngAlV1NO+c17X7ylg7mqaw2s6RKcSLWq/Xzz+4BUaIOc3
        +Z7vjEmi3ttpbQKmB6yvBrmSPLbqfCfpJezR9+Ap2Uv2irNXBGTv2NOa/+d+zjFFsGU+S4d10iCDI
        fTH6oSPeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXVSw-0005wN-CY; Wed, 20 Nov 2019 19:16:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B0D130068E;
        Wed, 20 Nov 2019 20:15:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 200F42B25DAAD; Wed, 20 Nov 2019 20:16:36 +0100 (CET)
Date:   Wed, 20 Nov 2019 20:16:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191120191636.GI4097@hirez.programming.kicks-ass.net>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118204054.GV4614@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 19, 2019 at 07:40:54AM +1100, Dave Chinner wrote:
> On Mon, Nov 18, 2019 at 10:21:21AM +0100, Peter Zijlstra wrote:

> > We typically only fall back to the active balancer when there is
> > (persistent) imbalance and we fail to migrate anything else (of
> > substance).
> > 
> > The tuning mentioned has the effect of less frequent scheduling, IOW,
> > leaving (short) tasks on the runqueue longer. This obviously means the
> > load-balancer will have a bigger chance of seeing them.
> > 
> > Now; it's been a while since I looked at the workqueue code but one
> > possible explanation would be if the kworker that picks up the work item
> > is pinned. That would make it runnable but not migratable, the exact
> > situation in which we'll end up shooting the current task with active
> > balance.
> 
> Yes, that's precisely the problem - work is queued, by default, on a
> specific CPU and it will wait for a kworker that is pinned to that

I'm thinking the problem is that it doesn't wait. If it went and waited
for it, active balance wouldn't be needed, that only works on active
tasks.

> specific CPU to dispatch it. We've already tested that queuing on a
> different CPU (via queue_work_on()) makes the problem largely go
> away as the work is not longer queued behind the long running fio
> task.
> 
> This, however, is not at viable solution to the problem. The pattern
> of a long running process queuing small pieces of individual work
> for processing in a separate context is pretty common...

Right, but you're putting the scheduler in a bind. By overloading the
CPU and only allowing the one task to migrate, it pretty much has no
choice left.

Anyway, I'm still going to have try and reproduce -- I got side-tracked
into a crashing bug, I'll hopefully get back to this tomorrow. Lastly,
one other thing to try is -next. Vincent reworked the load-balancer
quite a bit.
