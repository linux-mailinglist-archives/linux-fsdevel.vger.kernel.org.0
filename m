Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2E51B1AF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 02:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgDUAwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 20:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgDUAwP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 20:52:15 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AD93208E4;
        Tue, 21 Apr 2020 00:52:12 +0000 (UTC)
Date:   Mon, 20 Apr 2020 20:52:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT
 default boost value
Message-ID: <20200420205210.7217651c@oasis.local.home>
In-Reply-To: <20200420151941.47ualxul5seqwdgh@e107158-lin.cambridge.arm.com>
References: <20200403123020.13897-1-qais.yousef@arm.com>
        <20200414182152.GB20442@darkstar>
        <54ac2709-54e5-7a33-a6af-0a07e272365c@arm.com>
        <20200420151941.47ualxul5seqwdgh@e107158-lin.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 20 Apr 2020 16:19:42 +0100
Qais Yousef <qais.yousef@arm.com> wrote:

> > root@h960:~# find / -name "*util_clamp*"
> > /proc/sys/kernel/sched_rt_default_util_clamp_min
> > /proc/sys/kernel/sched_util_clamp_max
> > /proc/sys/kernel/sched_util_clamp_min
> > 
> > IMHO, keeping the common 'sched_util_clamp_' would be helpful here, e.g.
> > 
> > /proc/sys/kernel/sched_util_clamp_rt_default_min  
> 
> All RT related knobs are prefixed with 'sched_rt'. I kept the 'util_clamp_min'
> coherent with the current sysctl (sched_util_clamp_min). Quentin suggested
> adding 'default' to be more obvious, so I ended up with
> 
> 	'sched_rt' + '_default' + '_util_clamp_min'.
> 
> I think this is the logical and most consistent form. Given that Patrick seems
> to be okay with the 'default' now, does this look good to you too?

There's only two files with "sched_rt" and they are tightly coupled
(they define how much an RT task may use the CPU).

My question is, is this "sched_rt_default_util_clamp_min" related in
any way to those other two files that start with "sched_rt", or is it
more related to the files that start with "sched_util_clamp"?

If the latter, then I would suggest using
"sched_util_clamp_min_rt_default", as it looks to be more related to
the "sched_util_clamp_min" than to anything else.

-- Steve
