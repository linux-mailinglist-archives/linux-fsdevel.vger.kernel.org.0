Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA7421887D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 15:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgGHNIi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 09:08:38 -0400
Received: from foss.arm.com ([217.140.110.172]:39262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbgGHNIi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:08:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B4AE1FB;
        Wed,  8 Jul 2020 06:08:38 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B71213F718;
        Wed,  8 Jul 2020 06:08:35 -0700 (PDT)
Date:   Wed, 8 Jul 2020 14:08:33 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Anderson <dianders@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] sched/uclamp: Add a new sysctl to control RT
 default boost value
Message-ID: <20200708130831.4oaukv65hbano3j7@e107158-lin>
References: <20200706142839.26629-1-qais.yousef@arm.com>
 <20200706142839.26629-2-qais.yousef@arm.com>
 <jhj8sfw8wzk.mognet@arm.com>
 <20200707093447.4t6eqjy4fkt747fo@e107158-lin.cambridge.arm.com>
 <jhj36638suv.mognet@arm.com>
 <20200707123640.lahojmq2s4byhkhl@e107158-lin.cambridge.arm.com>
 <jhjwo3e6zd1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jhjwo3e6zd1.mognet@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/08/20 12:05, Valentin Schneider wrote:
> > AFAIU rcu_read_lock() is light weight. So having the protection applied is more
> > robust against future changes.
> 
> So I think the one thing you win by having this dance with mb's and the
> suggested handling of the task list is that you do not need any
> rcu_synchronize() anymore. Both approaches have merit, it's just that the
> way I understood the suggestion to add sched_post_fork() was to simplify
> the ordering of the update with the aforementioned scheme.

The synchronize_rcu() is not for sched_post_fork(). It is to deal with the
preemption problem.

> 
> >
> >>
> >> sched_post_fork() being preempted out is a bit more annoying, but what
> >> prevents us from making that bit preempt-disabled?
> >
> > preempt_disable() is not friendly to RT and heavy handed approach IMO.
> >
> 
> True, but this is both an infrequent and slow sysctl path, so I don't think
> RT would care much.

There's an easy answer for that. But first I'm not sure what problem are we
discussing here.

What is the problem with rcu? And how is preempt_disable() fixes it or improves
on it?

Thanks

--
Qais Yousef
