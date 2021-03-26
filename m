Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0306834A38C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 09:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCZI7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 04:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCZI67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:58:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD27DC0613AA;
        Fri, 26 Mar 2021 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0ejXkL4xcTbYFcCB6r85AcgH1FBIJ/gjNm5LeorRuS0=; b=lg2sbBWOJy5DtXdaAk8EVOb9+Y
        kPHx/GNDPRWvq0uNB3flYMRwToyIq5EwBrexP0pbNZhB0JIjI51OYmXYXG7FMMB/I5e7MXW5KAvm4
        yGRgsFX1L5pl7Mv/xYcPdFuDXylWQSr6/7O5+wKWIlPEsd8tgIexiAV9pPjrnPTSv4IHz943H4bo8
        fPAWsE5zBrSYBqfDvxDxfvD4bTBOdtHptmi90LyLOdvPF8IFBooSB2cviqy1ruCe/2s2v2i5mLgpC
        CcBdY5cgVgWIpvW7IbvZogqOudGCrLAkjLabN38ANcZwExKufU9CbaiPstJRfkXGotSFAZzU+p/Mg
        Fm4UL3uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPiIn-00341M-Ri; Fri, 26 Mar 2021 08:58:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48FC8300F7A;
        Fri, 26 Mar 2021 09:58:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AAF7203ECD86; Fri, 26 Mar 2021 09:58:44 +0100 (CET)
Date:   Fri, 26 Mar 2021 09:58:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
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
        Oleg Rombakh <olegrom@google.com>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] sched: Warn on long periods of pending need_resched
Message-ID: <YF2iROWyH7sqvvZb@hirez.programming.kicks-ass.net>
References: <20210323035706.572953-1-joshdon@google.com>
 <YFsIZjhCFbxKyos3@hirez.programming.kicks-ass.net>
 <YFsaYBO/UqMHSpGS@hirez.programming.kicks-ass.net>
 <20210324114224.GP15768@suse.de>
 <YFssoD5NDl6dFfg/@hirez.programming.kicks-ass.net>
 <20210324133916.GQ15768@suse.de>
 <YFtOXpl1vWp47Qud@hirez.programming.kicks-ass.net>
 <20210324155224.GR15768@suse.de>
 <CABk29Nu7rR=_enuU8ecogtwCU3E4ygP0m+nmBH-KqKTRzDCe=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nu7rR=_enuU8ecogtwCU3E4ygP0m+nmBH-KqKTRzDCe=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 02:58:52PM -0700, Josh Don wrote:
> > On Wed, Mar 24, 2021 at 01:39:16PM +0000, Mel Gorman wrote:
> > I'm not going to NAK because I do not have hard data that shows they must
> > exist. However, I won't ACK either because I bet a lot of tasty beverages
> > the next time we meet that the following parameters will generate reports
> > if removed.
> >
> > kernel.sched_latency_ns
> > kernel.sched_migration_cost_ns
> > kernel.sched_min_granularity_ns
> > kernel.sched_wakeup_granularity_ns
> >
> > I know they are altered by tuned for different profiles and some people do
> > go the effort to create custom profiles for specific applications. They
> > also show up in "Official Benchmarking" such as SPEC CPU 2017 and
> > some vendors put a *lot* of effort into SPEC CPU results for bragging
> > rights. They show up in technical books and best practice guids for
> > applications.  Finally they show up in Google when searching for "tuning
> > sched_foo". I'm not saying that any of these are even accurate or a good
> > idea, just that they show up near the top of the results and they are
> > sufficiently popular that they might as well be an ABI.
> 
> +1, these seem like sufficiently well-known scheduler tunables, and
> not really SCHED_DEBUG.

So we've never made any guarantees on their behaviour, nor am I willing
to make any.

In fact, I propose we merge the below along with the debugfs move. Just
to make absolutely sure any 'tuning' is broken.



---
Subject: sched,fair: Alternative sched_slice()
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Mar 25 13:44:46 CET 2021

The current sched_slice() seems to have issues; there's two possible
things that could be improved:

 - the 'nr_running' used for __sched_period() is daft when cgroups are
   considered. Using the RQ wide h_nr_running seems like a much more
   consistent number.

 - (esp) cgroups can slice it real fine (pun intendend), which makes for
   easy over-scheduling, ensure min_gran is what the name says.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |   15 ++++++++++++++-
 kernel/sched/features.h |    3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -680,7 +680,16 @@ static u64 __sched_period(unsigned long
  */
 static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	u64 slice = __sched_period(cfs_rq->nr_running + !se->on_rq);
+	unsigned int nr_running = cfs_rq->nr_running;
+	u64 slice;
+
+	if (sched_feat(ALT_PERIOD))
+		nr_running = rq_of(cfs_rq)->cfs.h_nr_running;
+
+	slice = __sched_period(nr_running + !se->on_rq);
+
+	if (sched_feat(BASE_SLICE))
+		slice -= sysctl_sched_min_granularity;
 
 	for_each_sched_entity(se) {
 		struct load_weight *load;
@@ -697,6 +706,10 @@ static u64 sched_slice(struct cfs_rq *cf
 		}
 		slice = __calc_delta(slice, se->load.weight, load);
 	}
+
+	if (sched_feat(BASE_SLICE))
+		slice += sysctl_sched_min_granularity;
+
 	return slice;
 }
 
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -90,3 +90,6 @@ SCHED_FEAT(WA_BIAS, true)
  */
 SCHED_FEAT(UTIL_EST, true)
 SCHED_FEAT(UTIL_EST_FASTUP, true)
+
+SCHED_FEAT(ALT_PERIOD, true)
+SCHED_FEAT(BASE_SLICE, true)
