Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9221BA151
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 12:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgD0Kc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 06:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726604AbgD0Kc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:32:26 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DC7C0610D5;
        Mon, 27 Apr 2020 03:32:26 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jT13m-0000By-43; Mon, 27 Apr 2020 12:32:22 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 20933100606; Mon, 27 Apr 2020 12:32:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3 2/6] posix-cpu-timers: Use PIDTYPE_TGID to simplify the logic in lookup_task
In-Reply-To: <87blnemj5t.fsf_-_@x220.int.ebiederm.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com> <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org> <20200424173927.GB26802@redhat.com> <87mu6ymkea.fsf_-_@x220.int.ebiederm.org> <87blnemj5t.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 27 Apr 2020 12:32:21 +0200
Message-ID: <87zhaxqkwa.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:
> Using pid_task(find_vpid(N), PIDTYPE_TGID) guarantees that if a task
> is found it is at that moment the thread group leader.  Which removes
> the need for the follow on test has_group_leader_pid.
>
> I have reorganized the rest of the code in lookup_task for clarity,
> and created a common return for most of the code.

Sorry, it's way harder to read than the very explicit exits which were
there before.

> The special case for clock_gettime with "pid == gettid" is not my
> favorite.  I strongly suspect it isn't used as gettid is such a pain,
> and passing 0 is much easier.  Still it is easier to keep this special
> case than to do the reasarch that will show it isn't used.

It might be not your favorite, but when I refactored the code I learned
the hard way that one of the test suites has assumptions that
clock_gettime(PROCESS) works from any task of a group and not just for
the group leader. Sure we could fix the test suite, but test code tends
to be copied ...

>  /*
>   * Functions for validating access to tasks.
>   */
> -static struct task_struct *lookup_task(const pid_t pid, bool thread,
> +static struct task_struct *lookup_task(const pid_t which_pid, bool thread,
>  				       bool gettime)
>  {
>  	struct task_struct *p;
> +	struct pid *pid;
>  
>  	/*
>  	 * If the encoded PID is 0, then the timer is targeted at current
>  	 * or the process to which current belongs.
>  	 */
> -	if (!pid)
> +	if (!which_pid)
>  		return thread ? current : current->group_leader;
>  
> -	p = find_task_by_vpid(pid);
> -	if (!p)
> -		return p;
> -
> -	if (thread)
> -		return same_thread_group(p, current) ? p : NULL;
> -
> -	if (gettime) {
> +	pid = find_vpid(which_pid);
> +	if (thread) {
> +		p = pid_task(pid, PIDTYPE_PID);
> +		if (p && !same_thread_group(p, current))
> +			p = NULL;
> +	} else {
>  		/*
>  		 * For clock_gettime(PROCESS) the task does not need to be
>  		 * the actual group leader. tsk->sighand gives
> @@ -76,13 +75,13 @@ static struct task_struct *lookup_task(const pid_t pid, bool thread,
>  		 * reference on it and store the task pointer until the
>  		 * timer is destroyed.

Btw, this comment is wrong since

     55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not a task")

Thanks,

        tglx
