Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4893714D746
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 09:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgA3IHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 03:07:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55428 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgA3IHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mcACr4W9oLpnOmQRjpf37ACG6Vi7DI3ou3ovZqhIzPk=; b=eDpcAM6DvYInkBWBnBEa23Z1A
        Rq+cjhagKHCqoYwAOXQBn0YeWUQ8EJh7cRCn6jdmAhfCIFS58O7l+TZkxf4DY1dZT6O795djC03WQ
        L9nQUBGpDyqYPCJkRpjC39LQ4/ibMP8YTWfFJvpIQ8GgYIhaneI0Ejvh+T7xKVrme1huX+Hlf6toq
        0o/OSKdwOabnxSjRQXA3FG3FQRgHfbRdSqKLlq/QJ37zHAy/C631PZAbubznE1vIt4Mm9gslVUM0U
        Cxv2YzQmBQuluV0h0DBHNj3HeN6fy37aKXsVASt89Bj56hI4itCfijfFYw1YFnTg7498/CZvtBj1e
        x2D/psBuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ix4qm-00087j-2g; Thu, 30 Jan 2020 08:06:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DFB143011F3;
        Thu, 30 Jan 2020 09:05:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 141832B78BF24; Thu, 30 Jan 2020 09:06:53 +0100 (CET)
Date:   Thu, 30 Jan 2020 09:06:53 +0100
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
Message-ID: <20200130080653.GV14879@hirez.programming.kicks-ass.net>
References: <20200127143608.GX3466@techsingularity.net>
 <20200127223256.GA18610@dread.disaster.area>
 <20200128011936.GY3466@techsingularity.net>
 <20200128091012.GZ3466@techsingularity.net>
 <20200129173852.GP14914@hirez.programming.kicks-ass.net>
 <20200130004334.GF3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130004334.GF3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 30, 2020 at 12:43:34AM +0000, Mel Gorman wrote:
> On Wed, Jan 29, 2020 at 06:38:52PM +0100, Peter Zijlstra wrote:

> > I suppose the fact that it limits it to tasks that were running on the
> > same CPU limits the impact if we do get it wrong.
> > 
> 
> And it's limited to no other task currently running on the
> CPU. Now, potentially multiple sleepers are on that CPU waiting for
> a mutex/rwsem/completion but it's very unlikely and mostly likely due
> to the machine being saturated in which case searching for an idle CPU
> will probably fail. It would also be bound by a small window after the
> first wakeup before the task becomes runnable before the nr_running check
> mitigages the problem. Besides, if the sleeping task is waiting on the
> lock, it *is* related to the kworker which is probably finished.
> 
> In other words, even this patches worst-case behaviour does not seem
> that bad.

OK; let's just stick it in and see what, if anything, falls over :-)

I saw there is a v2 out (although I didn't see what changed in a hurry),
let me queue that one.
