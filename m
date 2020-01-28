Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5AE14B189
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 10:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgA1JKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 04:10:19 -0500
Received: from outbound-smtp18.blacknight.com ([46.22.139.245]:57296 "EHLO
        outbound-smtp18.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgA1JKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 04:10:17 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id 26B941C3374
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 09:10:14 +0000 (GMT)
Received: (qmail 20507 invoked from network); 28 Jan 2020 09:10:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Jan 2020 09:10:14 -0000
Date:   Tue, 28 Jan 2020 09:10:12 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched, fair: Allow a per-cpu kthread waking a task to
 stack on the same CPU
Message-ID: <20200128091012.GZ3466@techsingularity.net>
References: <20200127143608.GX3466@techsingularity.net>
 <20200127223256.GA18610@dread.disaster.area>
 <20200128011936.GY3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200128011936.GY3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 28, 2020 at 01:19:36AM +0000, Mel Gorman wrote:
> > <SNIP>
> > After all this, I have two questions that would help me understand
> > if this is what you are seeing:
> > 
> > 1. to confirm: does removing just the WQ_UNBOUND from the CIL push
> > workqueue (as added in 8ab39f11d974) make the regression go away?
> > 
> 
> I'll have to check in the morning. Around the v5.4 development timeframe,
> I'm definite that reverting the patch helped but that was not an option
> given that it's fixing a correctness issue.
> 

This is a comparison of the baseline kernel (tip at the time I started),
the proposed fix and a revert. The revert was not clean but I do not
believe it matters

dbench4 Loadfile Execution Time
                           5.5.0-rc7              5.5.0-rc7              5.5.0-rc7
                   tipsched-20200124      kworkerstack-v1r2     revert-XFS-wq-v1r2
Amean     1         58.69 (   0.00%)       30.21 *  48.53%*       47.48 *  19.10%*
Amean     2         60.90 (   0.00%)       35.29 *  42.05%*       51.13 *  16.04%*
Amean     4         66.77 (   0.00%)       46.55 *  30.28%*       59.54 *  10.82%*
Amean     8         81.41 (   0.00%)       68.46 *  15.91%*       77.25 *   5.11%*
Amean     16       113.29 (   0.00%)      107.79 *   4.85%*      112.33 *   0.85%*
Amean     32       199.10 (   0.00%)      198.22 *   0.44%*      200.31 *  -0.61%*
Amean     64       478.99 (   0.00%)      477.06 *   0.40%*      482.17 *  -0.66%*
Amean     128     1345.26 (   0.00%)     1372.64 *  -2.04%*     1368.94 *  -1.76%*
Stddev    1          2.64 (   0.00%)        4.17 ( -58.08%)        5.01 ( -89.89%)
Stddev    2          4.35 (   0.00%)        5.38 ( -23.73%)        4.48 (  -2.90%)
Stddev    4          6.77 (   0.00%)        6.56 (   3.00%)        7.40 (  -9.40%)
Stddev    8         11.61 (   0.00%)       10.91 (   6.04%)       11.62 (  -0.05%)
Stddev    16        18.63 (   0.00%)       19.19 (  -3.01%)       19.12 (  -2.66%)
Stddev    32        38.71 (   0.00%)       38.30 (   1.06%)       38.82 (  -0.28%)
Stddev    64       100.28 (   0.00%)       91.24 (   9.02%)       95.68 (   4.59%)
Stddev    128      186.87 (   0.00%)      160.34 (  14.20%)      170.85 (   8.57%)

According to this, commit 8ab39f11d974 ("xfs: prevent CIL push holdoff
in log recovery") did introduce some unintended behaviour. The fix
actually performs better than a revert with the obvious benefit that it
does not reintroduce the functional breakage (log starvation) that the
commit originally fixed.

I still think that XFS is not the problem here, it's just the
messenger. The functional fix, delegating work to kworkers running on the
same CPU and blk-mq delivering IO completions to the same CPU as the IO
issuer are all sane decisions IMO. I do not think that adjusting any of
them to wakeup the task on a new CPU is sensible due to the loss of data
cache locality and potential snags with power management when waking a
CPU from idle state.

Peter, Ingo and Vincent -- I know the timing is bad due to the merge
window but do you have any thoughts on allowing select_idle_sibling to
stack a wakee task on the same CPU as a waker in this specific case?

-- 
Mel Gorman
SUSE Labs
