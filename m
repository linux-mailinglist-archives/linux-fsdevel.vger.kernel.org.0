Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6240D14D801
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 09:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgA3IzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 03:55:18 -0500
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:37341 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726940AbgA3IzS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:55:18 -0500
Received: from mail.blacknight.com (unknown [81.17.254.16])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id A696AD07BA
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2020 08:55:15 +0000 (GMT)
Received: (qmail 3857 invoked from network); 30 Jan 2020 08:55:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Jan 2020 08:55:15 -0000
Date:   Thu, 30 Jan 2020 08:55:13 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>, Phil Auld <pauld@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched, fair: Allow a per-cpu kthread waking a task to
 stack on the same CPU
Message-ID: <20200130085513.GH3466@techsingularity.net>
References: <20200127143608.GX3466@techsingularity.net>
 <20200127223256.GA18610@dread.disaster.area>
 <20200128011936.GY3466@techsingularity.net>
 <20200128091012.GZ3466@techsingularity.net>
 <20200129173852.GP14914@hirez.programming.kicks-ass.net>
 <20200130004334.GF3466@techsingularity.net>
 <20200130080653.GV14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200130080653.GV14879@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 30, 2020 at 09:06:53AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 30, 2020 at 12:43:34AM +0000, Mel Gorman wrote:
> > On Wed, Jan 29, 2020 at 06:38:52PM +0100, Peter Zijlstra wrote:
> 
> > > I suppose the fact that it limits it to tasks that were running on the
> > > same CPU limits the impact if we do get it wrong.
> > > 
> > 
> > And it's limited to no other task currently running on the
> > CPU. Now, potentially multiple sleepers are on that CPU waiting for
> > a mutex/rwsem/completion but it's very unlikely and mostly likely due
> > to the machine being saturated in which case searching for an idle CPU
> > will probably fail. It would also be bound by a small window after the
> > first wakeup before the task becomes runnable before the nr_running check
> > mitigages the problem. Besides, if the sleeping task is waiting on the
> > lock, it *is* related to the kworker which is probably finished.
> > 
> > In other words, even this patches worst-case behaviour does not seem
> > that bad.
> 
> OK; let's just stick it in and see what, if anything, falls over :-)
> 
> I saw there is a v2 out (although I didn't see what changed in a hurry),
> let me queue that one.

Only the changelog and comments changed in light of the discussion
with Dave.

-- 
Mel Gorman
SUSE Labs
