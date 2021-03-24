Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A30834797D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 14:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhCXNVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 09:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbhCXNVt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:21:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A139C061763;
        Wed, 24 Mar 2021 06:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4WpXJrjstIuowWonzq4eFShaVDE/4VxJi8AtBgBCg04=; b=jjJOyq5elx6rtNmL15TaGiFG2H
        ROIEFcSd320xiwFqKeAP51uoLF3jxgTM6DqhMN4M8WFBlPHdMAhmFUIKdMwpnbcVQhGPx0TPcmwAB
        GTZcFH/aOOXsyLJeChFqeuuNVdJ+So8n4kGtwpbO+DCRteqmRBEUe+r+M9k3SnY7Gmfo1KGl3IOTO
        z66L3EtCtpBwpAlxBsGWYjdT7ILq36txGq3jhGbWKJJ56lZBIameLC3v/VM3vZLy9gsoZid3tn4wq
        LdLmKaLUYLEKP5jNesv2UiSlNADXPt+yIjOgB4SGmoizmr5Ox8hVPci7FnX05l+TW/wR2EIrJvok+
        yyGFXhMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP3S6-00H977-Bb; Wed, 24 Mar 2021 13:21:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A15F3010C8;
        Wed, 24 Mar 2021 14:21:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 129BE20693989; Wed, 24 Mar 2021 14:21:37 +0100 (CET)
Date:   Wed, 24 Mar 2021 14:21:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, glider@google.com,
        viro@zeniv.linux.org.uk, arnd@arndb.de, christian@brauner.io,
        dvyukov@google.com, jannh@google.com, axboe@kernel.dk,
        mascasa@google.com, pcc@google.com, irogers@google.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 07/11] perf: Add breakpoint information to siginfo on
 SIGTRAP
Message-ID: <YFs84dx8KcAtSt5/@hirez.programming.kicks-ass.net>
References: <20210324112503.623833-1-elver@google.com>
 <20210324112503.623833-8-elver@google.com>
 <YFs2XHqepwtlLinx@hirez.programming.kicks-ass.net>
 <YFs4RDKfbjw89tf3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFs4RDKfbjw89tf3@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 02:01:56PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 24, 2021 at 01:53:48PM +0100, Peter Zijlstra wrote:
> > On Wed, Mar 24, 2021 at 12:24:59PM +0100, Marco Elver wrote:
> > > Encode information from breakpoint attributes into siginfo_t, which
> > > helps disambiguate which breakpoint fired.
> > > 
> > > Note, providing the event fd may be unreliable, since the event may have
> > > been modified (via PERF_EVENT_IOC_MODIFY_ATTRIBUTES) between the event
> > > triggering and the signal being delivered to user space.
> > > 
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > > v2:
> > > * Add comment about si_perf==0.
> > > ---
> > >  kernel/events/core.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 1e4c949bf75f..0316d39e8c8f 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -6399,6 +6399,22 @@ static void perf_sigtrap(struct perf_event *event)
> > >  	info.si_signo = SIGTRAP;
> > >  	info.si_code = TRAP_PERF;
> > >  	info.si_errno = event->attr.type;
> > > +
> > > +	switch (event->attr.type) {
> > > +	case PERF_TYPE_BREAKPOINT:
> > > +		info.si_addr = (void *)(unsigned long)event->attr.bp_addr;
> > > +		info.si_perf = (event->attr.bp_len << 16) | (u64)event->attr.bp_type;
> > 
> > Ahh, here's the si_perf user. I wasn't really clear to me what was
> > supposed to be in that field at patch #5 where it was introduced.
> > 
> > Would it perhaps make sense to put the user address of struct
> > perf_event_attr in there instead? (Obviously we'd have to carry it from
> > the syscall to here, but it might be more useful than a random encoding
> > of some bits therefrom).
> > 
> > Then we can also clearly document that's in that field, and it might be
> > more useful for possible other uses.
> 
> Something like so...

Ok possibly something like so, which also gets the data address right
for more cases.

---
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -778,6 +778,8 @@ struct perf_event {
 	void *security;
 #endif
 	struct list_head		sb_list;
+
+	struct kernel_siginfo 		siginfo;
 #endif /* CONFIG_PERF_EVENTS */
 };
 
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5652,13 +5652,17 @@ static long _perf_ioctl(struct perf_even
 		return perf_event_query_prog_array(event, (void __user *)arg);
 
 	case PERF_EVENT_IOC_MODIFY_ATTRIBUTES: {
+		struct perf_event_attr __user *uattr;
 		struct perf_event_attr new_attr;
-		int err = perf_copy_attr((struct perf_event_attr __user *)arg,
-					 &new_attr);
+		int err;
 
+		uattr = (struct perf_event_attr __user *)arg;
+		err = perf_copy_attr(uattr, &new_attr);
 		if (err)
 			return err;
 
+		event->siginfo.si_perf = (unsigned long)uattr;
+
 		return perf_event_modify_attr(event,  &new_attr);
 	}
 	default:
@@ -6394,13 +6398,7 @@ void perf_event_wakeup(struct perf_event
 
 static void perf_sigtrap(struct perf_event *event)
 {
-	struct kernel_siginfo info;
-
-	clear_siginfo(&info);
-	info.si_signo = SIGTRAP;
-	info.si_code = TRAP_PERF;
-	info.si_errno = event->attr.type;
-	force_sig_info(&info);
+	force_sig_info(&event->siginfo);
 }
 
 static void perf_pending_event_disable(struct perf_event *event)
@@ -6414,8 +6412,8 @@ static void perf_pending_event_disable(s
 		WRITE_ONCE(event->pending_disable, -1);
 
 		if (event->attr.sigtrap) {
-			atomic_set(&event->event_limit, 1); /* rearm event */
 			perf_sigtrap(event);
+			atomic_set_release(&event->event_limit, 1); /* rearm event */
 			return;
 		}
 
@@ -9121,6 +9119,7 @@ static int __perf_event_overflow(struct
 	if (events && atomic_dec_and_test(&event->event_limit)) {
 		ret = 1;
 		event->pending_kill = POLL_HUP;
+		event->siginfo.si_addr = (void *)data->addr;
 
 		perf_event_disable_inatomic(event);
 	}
@@ -12011,6 +12010,11 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_task;
 	}
 
+	clear_siginfo(&event->siginfo);
+	event->siginfo.si_signo = SIGTRAP;
+	event->siginfo.si_code = TRAP_PERF;
+	event->siginfo.si_perf = (unsigned long)attr_uptr;
+
 	if (is_sampling_event(event)) {
 		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
 			err = -EOPNOTSUPP;
