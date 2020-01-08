Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5BB13442C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 14:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgAHNpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 08:45:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAHNpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wk7s5uy/Dgrq7F8jPCUqmm6ORQULcEXjI71y1YxQTGA=; b=Rzo0ZjCs0fX38OXa1TaOnUpRs
        Wotv2f5MlC0vVaJaDFXtwg0rojTCeEDsqK61OP2S8dn/iSQDfvmZywW79em3iK6rF3e35yg+Aly29
        iKEoIYC6MsV1jhEXnOFv5gmU+pVNDANpyvxi4vHZSHN9FCYH7bb9380cmfXFsuxJe8T2Hk/P2q8k2
        vO9K7RQPxkQI+be8bALGDPhjCirrEDWMLDyBN6mNB46GF9lD+SX7oF1psRDxb3KTdrR+eI43TF/mA
        7jEXnwBqcwmxAnyyNtCQuAT4ShB3NXrWNRQpsnB32Y25682Uz8k3iwdBQeF8ddAGrIp5N13HX/LIs
        sxs2uuV1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipBdj-00078N-Vr; Wed, 08 Jan 2020 13:44:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 015D730025A;
        Wed,  8 Jan 2020 14:43:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE10A201CE313; Wed,  8 Jan 2020 14:44:48 +0100 (CET)
Date:   Wed, 8 Jan 2020 14:44:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        valentin.schneider@arm.com, qperret@google.com,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
Message-ID: <20200108134448.GG2844@hirez.programming.kicks-ass.net>
References: <20191220164838.31619-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220164838.31619-1-qais.yousef@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 20, 2019 at 04:48:38PM +0000, Qais Yousef wrote:
> RT tasks by default try to run at the highest capacity/performance
> level. When uclamp is selected this default behavior is retained by
> enforcing the uclamp_util_min of the RT tasks to be
> uclamp_none(UCLAMP_MAX), which is SCHED_CAPACITY_SCALE; the maximum
> value.
> 
> See commit 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks").
> 
> On battery powered devices, this default behavior could consume more
> power, and it is desired to be able to tune it down. While uclamp allows
> tuning this by changing the uclamp_util_min of the individual tasks, but
> this is cumbersome and error prone.
> 
> To control the default behavior globally by system admins and device
> integrators, introduce the new sysctl_sched_rt_uclamp_util_min to
> change the default uclamp_util_min value of the RT tasks.
> 
> Whenever the new default changes, it'd be applied on the next wakeup of
> the RT task, assuming that it still uses the system default value and
> not a user applied one.

This is because these RT tasks are not in a cgroup or not affected by
cgroup settings? I feel the justification is a little thin here.

> If the uclamp_util_min of an RT task is 0, then the RT utilization of
> the rq is used to drive the frequency selection in schedutil for RT
> tasks.

Did cpu_uclamp_write() forget to check for input<0 ?
