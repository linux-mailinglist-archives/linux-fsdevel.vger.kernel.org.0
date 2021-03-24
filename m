Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF58347A1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 15:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbhCXOCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 10:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbhCXOBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:01:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542CBC061763;
        Wed, 24 Mar 2021 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RLK0n+vWBgvQR+BSn/9+/c3c8WKIPg/Kphk7CJk6G50=; b=NfULNOrZGt0DNCFDHUPOpWK5KD
        lzNRcgADeOetLYv6Pi8i3X1XZ7R/yeGnssAFCsxHYtrY8nr9kyxbQumYJOY7o9jE+pv4X403B/26n
        Z7Qtx89tVQplRfXtE/wCCu8Pn5Yqug9DA7lbFRuCwg34//RpXgv2w0WwHLuq7uzHEpWb2ZbDcuBIP
        fb2MuF15kZjtuenFvHoQOMCRYEI0J5cT7EYgCfrrI9tlRJIvUuTXWkKE5E9209gVq2eGRExMViRC/
        yldMui0zWgOCePcMAOIRmJniyvdvsMGQ7G3LRIfvnLgxmVojKUyg7AMssZm6DP9+j4e7WNs7MxtK0
        eVEW+zWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP43Y-00BPZ2-4i; Wed, 24 Mar 2021 14:00:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5041300F7A;
        Wed, 24 Mar 2021 15:00:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B92A20CCE903; Wed, 24 Mar 2021 15:00:18 +0100 (CET)
Date:   Wed, 24 Mar 2021 15:00:18 +0100
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
Message-ID: <YFtF8tEPHrXnw7cX@hirez.programming.kicks-ass.net>
References: <20210324112503.623833-1-elver@google.com>
 <20210324112503.623833-8-elver@google.com>
 <YFs2XHqepwtlLinx@hirez.programming.kicks-ass.net>
 <YFs4RDKfbjw89tf3@hirez.programming.kicks-ass.net>
 <YFs84dx8KcAtSt5/@hirez.programming.kicks-ass.net>
 <YFtB+Ta9pkMg4C2h@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFtB+Ta9pkMg4C2h@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



One last try, I'll leave it alone now, I promise :-)

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -778,6 +778,9 @@ struct perf_event {
 	void *security;
 #endif
 	struct list_head		sb_list;
+
+	unsigned long			si_uattr;
+	unsigned long			si_data;
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
 
+		event->si_uattr = (unsigned long)uattr;
+
 		return perf_event_modify_attr(event,  &new_attr);
 	}
 	default:
@@ -6399,7 +6403,12 @@ static void perf_sigtrap(struct perf_eve
 	clear_siginfo(&info);
 	info.si_signo = SIGTRAP;
 	info.si_code = TRAP_PERF;
-	info.si_errno = event->attr.type;
+	info.si_addr = (void *)event->si_data;
+
+	info.si_perf = event->si_uattr;
+	if (event->parent)
+		info.si_perf = event->parent->si_uattr;
+
 	force_sig_info(&info);
 }
 
@@ -6414,8 +6423,8 @@ static void perf_pending_event_disable(s
 		WRITE_ONCE(event->pending_disable, -1);
 
 		if (event->attr.sigtrap) {
-			atomic_set(&event->event_limit, 1); /* rearm event */
 			perf_sigtrap(event);
+			atomic_set_release(&event->event_limit, 1); /* rearm event */
 			return;
 		}
 
@@ -9121,6 +9130,7 @@ static int __perf_event_overflow(struct
 	if (events && atomic_dec_and_test(&event->event_limit)) {
 		ret = 1;
 		event->pending_kill = POLL_HUP;
+		event->si_data = data->addr;
 
 		perf_event_disable_inatomic(event);
 	}
@@ -12011,6 +12021,8 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_task;
 	}
 
+	event->si_uattr = (unsigned long)attr_uptr;
+
 	if (is_sampling_event(event)) {
 		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
 			err = -EOPNOTSUPP;
