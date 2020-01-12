Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278161388C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 00:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbgALXb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jan 2020 18:31:28 -0500
Received: from foss.arm.com ([217.140.110.172]:33012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbgALXb1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jan 2020 18:31:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F10530E;
        Sun, 12 Jan 2020 15:31:27 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20B963F534;
        Sun, 12 Jan 2020 15:31:25 -0800 (PST)
Date:   Sun, 12 Jan 2020 23:31:22 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20200112233122.b26kidww6xphuyqq@e107158-lin.cambridge.arm.com>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200108134448.GG2844@hirez.programming.kicks-ass.net>
 <20200109130052.feebuwuuvwvm324w@e107158-lin.cambridge.arm.com>
 <20200110134236.GM2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110134236.GM2844@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/10/20 14:42, Peter Zijlstra wrote:
> On Thu, Jan 09, 2020 at 01:00:58PM +0000, Qais Yousef wrote:
> > On 01/08/20 14:44, Peter Zijlstra wrote:
> 
> > > Did cpu_uclamp_write() forget to check for input<0 ?
> > 
> > Hmm just tried that and it seems so
> > 
> > # echo -1 > cpu.uclamp.min
> > # cat cpu.uclamp.min
> > 42949671.96
> > 
> > capacity_from_percent(); we check for
> > 
> > 7301                 if (req.percent > UCLAMP_PERCENT_SCALE) {
> > 7302                         req.ret = -ERANGE;
> > 7303                         return req;
> > 7304                 }
> > 
> > But req.percent is s64, maybe it should be u64?
> 
> 		if ((u64)req.percent > UCLAMP_PERCENT_SCALE)
> 
> should do, I think.

Okay I'll send a separate fix for that.

Cheers

--
Qais Yousef
