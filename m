Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189233478F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 13:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhCXM43 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 08:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhCXM4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:56:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDC3C061763;
        Wed, 24 Mar 2021 05:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tHp+k1OitbRlspde73UjQtr/BpbC8h6lYxWD13OBqjk=; b=tf1rnOdWTwyzbMBVWRfPe5nYqp
        zIMdh2lwopsG94dkMaorDBV8dt0SzG2QSjD5XtAFtIqKUjLvzBf4uAbcCGOtjr7jXFL27hLLF0CGu
        dtdsxAtG1dZd87NgIAGBq0hwifQnAHV0ZFGokUXAMouaXYXAbLh9MPWiNjGUX0h4GUkNWaauMkJaQ
        tkB4piLWaBw0dGDwmbWUxblTMYOT797DbhWCnOxSAGJtARFaJ7dWQz53CCAiwv+7z5CKBsZdWNsQ3
        WTDQ3rzj7x0ehPTucy5FQnlywr0M3JX//RiJySTUE64QVaLVb061tCtFoBbMEKoZ2qs54paYWZMHB
        MBgjKCkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP31B-00BM08-Uc; Wed, 24 Mar 2021 12:53:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92E65300F7A;
        Wed, 24 Mar 2021 13:53:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7823A20693983; Wed, 24 Mar 2021 13:53:48 +0100 (CET)
Date:   Wed, 24 Mar 2021 13:53:48 +0100
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
Message-ID: <YFs2XHqepwtlLinx@hirez.programming.kicks-ass.net>
References: <20210324112503.623833-1-elver@google.com>
 <20210324112503.623833-8-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324112503.623833-8-elver@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 12:24:59PM +0100, Marco Elver wrote:
> Encode information from breakpoint attributes into siginfo_t, which
> helps disambiguate which breakpoint fired.
> 
> Note, providing the event fd may be unreliable, since the event may have
> been modified (via PERF_EVENT_IOC_MODIFY_ATTRIBUTES) between the event
> triggering and the signal being delivered to user space.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Add comment about si_perf==0.
> ---
>  kernel/events/core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1e4c949bf75f..0316d39e8c8f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6399,6 +6399,22 @@ static void perf_sigtrap(struct perf_event *event)
>  	info.si_signo = SIGTRAP;
>  	info.si_code = TRAP_PERF;
>  	info.si_errno = event->attr.type;
> +
> +	switch (event->attr.type) {
> +	case PERF_TYPE_BREAKPOINT:
> +		info.si_addr = (void *)(unsigned long)event->attr.bp_addr;
> +		info.si_perf = (event->attr.bp_len << 16) | (u64)event->attr.bp_type;

Ahh, here's the si_perf user. I wasn't really clear to me what was
supposed to be in that field at patch #5 where it was introduced.

Would it perhaps make sense to put the user address of struct
perf_event_attr in there instead? (Obviously we'd have to carry it from
the syscall to here, but it might be more useful than a random encoding
of some bits therefrom).

Then we can also clearly document that's in that field, and it might be
more useful for possible other uses.
