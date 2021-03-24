Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C5C347793
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 12:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhCXLmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 07:42:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:47320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhCXLmc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:42:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E505AD38;
        Wed, 24 Mar 2021 11:42:27 +0000 (UTC)
Date:   Wed, 24 Mar 2021 11:42:24 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] sched: Warn on long periods of pending need_resched
Message-ID: <20210324114224.GP15768@suse.de>
References: <20210323035706.572953-1-joshdon@google.com>
 <YFsIZjhCFbxKyos3@hirez.programming.kicks-ass.net>
 <YFsaYBO/UqMHSpGS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YFsaYBO/UqMHSpGS@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 11:54:24AM +0100, Peter Zijlstra wrote:
> On Wed, Mar 24, 2021 at 10:37:43AM +0100, Peter Zijlstra wrote:
> > Should we perhaps take out all SCHED_DEBUG sysctls and move them to
> > /debug/sched/ ? (along with the existing /debug/sched_{debug,features,preemp}
> > files)
> > 
> > Having all that in sysctl and documented gives them far too much sheen
> > of ABI.
> 
> ... a little something like this ...
> 

I did not read this particularly carefully or boot it to check but some
of the sysctls moved are expected to exist and should never should have
been under SCHED_DEBUG.

For example, I'm surprised that numa_balancing is under the SCHED_DEBUG
sysctl because there are legimiate reasons to disable that at runtime.
For example, HPC clusters running various workloads may disable NUMA
balancing globally for particular jobs without wanting to reboot and
reenable it when finished.

Moving something like sched_min_granularity_ns will break a number of
tuning guides as well as the "tuned" tool which ships by default with
some distros and I believe some of the default profiles used for tuned
tweak kernel.sched_min_granularity_ns

Whether there are legimiate reasons to modify those values or not,
removing them may generate fun bug reports.

-- 
Mel Gorman
SUSE Labs
