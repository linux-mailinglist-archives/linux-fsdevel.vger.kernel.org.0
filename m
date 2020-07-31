Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9BD233F15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 08:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbgGaG2S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 02:28:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37411 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731368AbgGaG2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 02:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596176894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pao/Sd97gVfvKhK6/6ymDqnN+qhbbP53Wl+E49WNZXc=;
        b=Bd4W6Dp0QOOysfWHjZTJ1wysTkPyZWH0e6NQkRKIuvzPTvDRl1Vl+QWvqfbZ/jWMIXUDkQ
        B+LwuQr5vrLH46V0o9+DDv5/lDaOlsTNdSETKWrUSfWMA86DOp/aPFtPI4w6cBmFmhyF9F
        kp2s80ldW9O6vTA0mftjVZDVarIvUrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-O3PKWmNBNGyrfEeyzkNZvg-1; Fri, 31 Jul 2020 02:28:10 -0400
X-MC-Unique: O3PKWmNBNGyrfEeyzkNZvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6B67107ACCA;
        Fri, 31 Jul 2020 06:28:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3C1DF712D9;
        Fri, 31 Jul 2020 06:28:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 31 Jul 2020 08:28:08 +0200 (CEST)
Date:   Fri, 31 Jul 2020 08:28:05 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RFC][PATCH] exec: Conceal the other threads from wakeups during
 exec
Message-ID: <20200731062804.GA26171@redhat.com>
References: <87h7tsllgw.fsf@x220.int.ebiederm.org>
 <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
 <87d04fhkyz.fsf@x220.int.ebiederm.org>
 <87h7trg4ie.fsf@x220.int.ebiederm.org>
 <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
 <878sf16t34.fsf@x220.int.ebiederm.org>
 <87pn8c1uj6.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn8c1uj6.fsf_-_@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric, I won't comment the intent, but I too do not understand this idea.

On 07/30, Eric W. Biederman wrote:
>
> [This change requires more work to handle TASK_STOPPED and TASK_TRACED]

Yes. And it is not clear to me how can you solve this.

> [This adds a new lock ordering dependency siglock -> pi_lock -> rq_lock ]

Not really, ttwu() can be safely called with siglock held and it takes
pi_lock + rq_lock. Say, signal_wake_up().

> +int make_task_wakekill(struct task_struct *p)
> +{
> +	unsigned long flags;
> +	int cpu, success = 0;
> +	struct rq_flags rf;
> +	struct rq *rq;
> +	long state;
> +
> +	/* Assumes p != current */
> +	preempt_disable();
> +	/*
> +	 * If we are going to change a thread waiting for CONDITION we
> +	 * need to ensure that CONDITION=1 done by the caller can not be
> +	 * reordered with p->state check below. This pairs with mb() in
> +	 * set_current_state() the waiting thread does.
> +	 */
> +	raw_spin_lock_irqsave(&p->pi_lock, flags);
> +	smp_mb__after_spinlock();
> +	state = p->state;
> +
> +	/* FIXME handle TASK_STOPPED and TASK_TRACED */
> +	if ((state == TASK_KILLABLE) ||
> +	    (state == TASK_INTERRUPTIBLE)) {
> +		success = 1;
> +		cpu = task_cpu(p);
> +		rq = cpu_rq(cpu);
> +		rq_lock(rq, &rf);
> +		p->state = TASK_WAKEKILL;

You can only do this if the task was already deactivated. Just suppose it
is preempted or does something like

	set_current_sate(TASK_INTERRUPTIBLE);

	if (CONDITION) {
		// make_task_wakekill() sets state = TASK_WAKEKILL
		__set_current_state(TASK_RUNNING);
		return;
	}

	schedule();

Oleg.

