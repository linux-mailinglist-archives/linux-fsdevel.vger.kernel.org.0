Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BB2427DE7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Oct 2021 00:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhJIWkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Oct 2021 18:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhJIWkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Oct 2021 18:40:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5239BC061570;
        Sat,  9 Oct 2021 15:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hPKAcZK5izPuDfWh8AAW5OoknbBIjrsDsl4cSr/xTWk=; b=qmgd5RoIVCBNZUjd7+fltt0qg3
        vAD6cLLr91kNcKSvgMFgaGmncnqOXqJWzSthinZwzI6PVrGfBvHMCYaf6mq2RBJ9rRqyJQq1ZU3+p
        tkn9+Vk7uw8s+hneNDkMNqSgnJPfsz19O2ad46wSeRuzqF1dsnCB26873MpSrLz9UENnyWMeremWS
        FC52qqbE2BgTUia5i1q1XmLKAKRzbt9VpbLmVw2lXvqNLK7iQ+PwnG0Z05UUlb6jKJUolPj4KdEZW
        7nnRANZxbiJykY2+Lj46fB1yEZmpH4siJpkmtJESYo+JO3Ux0r0StFPhTIc93Ob56diWrKRjc/7RE
        3hEDqCzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZKyL-008urs-G5; Sat, 09 Oct 2021 22:37:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 013FA9811D4; Sun, 10 Oct 2021 00:37:39 +0200 (CEST)
Date:   Sun, 10 Oct 2021 00:37:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Pratik R. Sampat" <psampat@linux.ibm.com>
Cc:     bristot@redhat.com, christian@brauner.io, ebiederm@xmission.com,
        lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, containers@lists.linux.dev,
        containers@lists.linux-foundation.org, pratik.r.sampat@gmail.com
Subject: Re: [RFC 1/5] ns: Introduce CPU Namespace
Message-ID: <20211009223739.GY174703@worktop.programming.kicks-ass.net>
References: <20211009151243.8825-1-psampat@linux.ibm.com>
 <20211009151243.8825-2-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009151243.8825-2-psampat@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 09, 2021 at 08:42:39PM +0530, Pratik R. Sampat wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d9ff40f4661..0413175e6d73 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -27,6 +27,8 @@
>  #include "pelt.h"
>  #include "smp.h"
>  
> +#include <linux/cpu_namespace.h>
> +
>  /*
>   * Export tracepoints that act as a bare tracehook (ie: have no trace event
>   * associated with them) to allow external modules to probe them.
> @@ -7559,6 +7561,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>  {
>  	cpumask_var_t cpus_allowed, new_mask;
>  	struct task_struct *p;
> +	cpumask_t temp;
>  	int retval;
>  
>  	rcu_read_lock();

You're not supposed to put a cpumask_t on stack. Those things can be
huge.

> @@ -7682,8 +7686,9 @@ SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
>  long sched_getaffinity(pid_t pid, struct cpumask *mask)
>  {
>  	struct task_struct *p;
> +	cpumask_var_t temp;
>  	unsigned long flags;
> -	int retval;
> +	int retval, cpu;
>  
>  	rcu_read_lock();
>  
> @@ -7698,6 +7703,13 @@ long sched_getaffinity(pid_t pid, struct cpumask *mask)
>  
>  	raw_spin_lock_irqsave(&p->pi_lock, flags);
>  	cpumask_and(mask, &p->cpus_mask, cpu_active_mask);
> +	cpumask_clear(temp);

There's a distinct lack of allocating temp before use. Are you sure you
actually tested this?

