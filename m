Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7D43479CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 14:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhCXNni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 09:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbhCXNnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:43:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1184BC061763;
        Wed, 24 Mar 2021 06:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z6YnZKE8JuXjPtE8/pNf6OtFYxSIiBBingu1TKjuVH4=; b=dZ9ouZTwMkaCDucdGFhCROIIM4
        W6vs7KV1/90Wjiyq9GY/vnLFVfy9+LP75PxuqPGkHYN0/Yy5kMx2drmdziZ1xxAvpnWKzAlY9Kuo1
        UdqGaoFOj2+Qy1jhq8WTIpawnOZAEcMSVkKiPD+g06BuQEfilIfPuRGdngu93WIi39VR3ZdU7oln+
        Saefe7rE5KX+Kz94R6VuDLIC5vL88xmefnbLzuFirS0IzdpqjamI+6uRGht6NuvR0r7qQB8cGfGSp
        57ULp91irzMOipsazEFkQgjExrRGcbnjfJdRGXfEbCtkzv/3iipa+rzTZF7SkFd17JlRXagwvrPrU
        y0E9vDjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP3n8-00HATU-Ix; Wed, 24 Mar 2021 13:43:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7FC843003E1;
        Wed, 24 Mar 2021 14:43:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E23520CCE90A; Wed, 24 Mar 2021 14:43:21 +0100 (CET)
Date:   Wed, 24 Mar 2021 14:43:21 +0100
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
Message-ID: <YFtB+Ta9pkMg4C2h@hirez.programming.kicks-ass.net>
References: <20210324112503.623833-1-elver@google.com>
 <20210324112503.623833-8-elver@google.com>
 <YFs2XHqepwtlLinx@hirez.programming.kicks-ass.net>
 <YFs4RDKfbjw89tf3@hirez.programming.kicks-ass.net>
 <YFs84dx8KcAtSt5/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFs84dx8KcAtSt5/@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 02:21:37PM +0100, Peter Zijlstra wrote:
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5652,13 +5652,17 @@ static long _perf_ioctl(struct perf_even
>  		return perf_event_query_prog_array(event, (void __user *)arg);
>  
>  	case PERF_EVENT_IOC_MODIFY_ATTRIBUTES: {
> +		struct perf_event_attr __user *uattr;
>  		struct perf_event_attr new_attr;
> -		int err = perf_copy_attr((struct perf_event_attr __user *)arg,
> -					 &new_attr);
> +		int err;
>  
> +		uattr = (struct perf_event_attr __user *)arg;
> +		err = perf_copy_attr(uattr, &new_attr);
>  		if (err)
>  			return err;
>  
> +		event->siginfo.si_perf = (unsigned long)uattr;

Oh bugger; that wants updating for all children too..

> +
>  		return perf_event_modify_attr(event,  &new_attr);
>  	}
>  	default:
> @@ -12011,6 +12010,11 @@ SYSCALL_DEFINE5(perf_event_open,
>  		goto err_task;
>  	}
>  
> +	clear_siginfo(&event->siginfo);
> +	event->siginfo.si_signo = SIGTRAP;
> +	event->siginfo.si_code = TRAP_PERF;
> +	event->siginfo.si_perf = (unsigned long)attr_uptr;

And inherit_event() / perf_event_alloc() want to copy/propagate that.

>  	if (is_sampling_event(event)) {
>  		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
>  			err = -EOPNOTSUPP;
