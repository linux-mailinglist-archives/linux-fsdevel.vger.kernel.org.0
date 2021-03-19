Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05DD3417E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 10:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhCSJC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 05:02:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:52422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhCSJC5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:02:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1383AC1F;
        Fri, 19 Mar 2021 09:02:55 +0000 (UTC)
Date:   Fri, 19 Mar 2021 09:02:52 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, Paul Turner <pjt@google.com>
Subject: Re: [PATCH] sched: Warn on long periods of pending need_resched
Message-ID: <20210319090252.GF15768@suse.de>
References: <20210317045949.1584952-1-joshdon@google.com>
 <20210317082550.GA3881262@gmail.com>
 <CABk29NvGx6KQa_+RU-6xmL6mUeBrqZjH1twOw93SCVD-NZkbMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CABk29NvGx6KQa_+RU-6xmL6mUeBrqZjH1twOw93SCVD-NZkbMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 05:06:31PM -0700, Josh Don wrote:
> On Wed, Mar 17, 2021 at 1:25 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Josh Don <joshdon@google.com> wrote:
> >
> > > If resched_latency_warn_ms is set to the default value, only one warning
> > > will be produced per boot.
> >
> > Looks like a value hack, should probably be a separate flag,
> > defaulting to warn-once.
> 
> Agreed, done.
> 
> > > This warning only exists under CONFIG_SCHED_DEBUG. If it goes off, it is
> > > likely that there is a missing cond_resched() somewhere.
> >
> > CONFIG_SCHED_DEBUG is default-y, so most distros have it enabled.
> 
> To avoid log spam for people who don't care, I was considering having
> the feature default disabled. Perhaps a better alternative is to only
> show a single line warning and not print the full backtrace by
> default. Does the latter sound good to you?
> 

Default disabling and hidden behind a static branch would be useful
because the majority of users are not going to know what to do about
a need_resched warning and the sysctl is not documented. As Ingo said,
SCHED_DEBUG is enabled by default a lot. While I'm not sure what motivates
most distributions, I have found it useful to display topology information
on boot and in rare cases, for the enabling/disabling of sched features.
Hence, sched debug features should avoid adding too much overhead where
possible.

The static branch would mean splitting the very large inline functions
adding by the patch. The inline section should do a static check only and
do the main work in a function in kernel/sched/debug.c so it has minimal
overhead if unused.

-- 
Mel Gorman
SUSE Labs
