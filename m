Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14B225A8FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 11:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgIBJ5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 05:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBJ5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:57:50 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9ADC061244;
        Wed,  2 Sep 2020 02:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QopoTG7wtXLeC7KjTt10YG/DVw3YVlXK9bp77v9rQoQ=; b=buaX8HQOWJP087/zDnJxqpsCQU
        Hy9Y5Ues/yc0B9I9sJ5Nqx915VdWxpW9T7rKAMN+p+73fxd9gwnm2Qux4aH4F5nQRKQKJIhuH94/e
        BIJF8DQDV2whFPuM3d79gB79e4amL/gVm9lJMyGy0L3tuLN4pPhTnkyyD4UmVycpVnqQTS7W7NAAQ
        9/47gNGn9uaPMV9iLcvHT71yTVmknhxxw6g4Kf3LYGBIIzOy73j27ju7I1ye9357iDniu0ieuEVXy
        uv1Z2vVZjpVVLSZF+bHT4LDR1A7VssCSUkwyybHMXjAdIGlTOwvBjoQEg34NgPa7nxRdMefc8wXLG
        Pu9KYWbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDPWJ-0003Hv-Jk; Wed, 02 Sep 2020 09:57:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D99E53012DF;
        Wed,  2 Sep 2020 11:57:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C00BC235DB8C1; Wed,  2 Sep 2020 11:57:30 +0200 (CEST)
Date:   Wed, 2 Sep 2020 11:57:30 +0200
From:   peterz@infradead.org
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     syzbot <syzbot+db9cdf3dd1f64252c6ef@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        christian@brauner.io, gladkov.alexey@gmail.com,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        walken@google.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, jannh@google.com
Subject: Re: possible deadlock in proc_pid_syscall (2)
Message-ID: <20200902095730.GB1362448@hirez.programming.kicks-ass.net>
References: <00000000000063640c05ade8e3de@google.com>
 <87mu2fj7xu.fsf@x220.int.ebiederm.org>
 <20200828123720.GZ1362448@hirez.programming.kicks-ass.net>
 <87v9h0gvro.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9h0gvro.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 30, 2020 at 07:31:39AM -0500, Eric W. Biederman wrote:
> peterz@infradead.org writes:

> > Could we check privs twice instead?
> >
> > Something like the completely untested below..
> 
> That might work.
> 
> I am thinking that for cases where we want to do significant work it
> might be better to ask the process to pause at someplace safe (probably
> get_signal) and then do all of the work when we know nothing is changing
> in the process.
> 
> I don't really like the idea of checking and then checking again.  We
> might have to do it but it feels like the model is wrong somewhere.

Another possible aproach might be to grab a copy of the cred pointer and
have the final install check that. It means we need to allow
perf_install_in_context() to fail though. That might be a little more
work.

> I had not realized before this how much setting up tracing in
> perf_even_open looks like attaching a debugger in ptrace_attach.

Same problem; once you've attached a perf event you can observe much of
what the task does.

