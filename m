Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F1D401908
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 11:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbhIFJnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 05:43:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36072 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbhIFJnc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:43:32 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630921345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eI34dkboo2GUlocVviv6+R9K4VmeCPMQM21Fjmx5538=;
        b=gWF2KY4IUmqrJgB+ljRMKEnaVgooIihoAIsg/Yj/n0E9Xi1Me5k1XjWItN6TlrQS3ri/H9
        DdqH0h6uQ2Nw3LrKQZVQzRj/ftjH0eMRRShflIyeICJnkTtAN0NV6jAiB5gPVaCSqwmEoi
        qEE0nyhikwcc/9+HjldLIz7sbu2sK6g81cddXWwFOzmjicCGV1mkSE0JaJKCsq2qqdrO6J
        mufmG3ZID20m7KzHmx+DGlYawQ7fqXXZUYa6t2l7MdTQLBZPR09CLy6zYJGCi8pL0qDKYm
        3CeW0odZMVrVJxdV55ope4dp7BESjKtAXhHKaQVY00vSo3eEKZqiKEQJA1f3Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630921345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eI34dkboo2GUlocVviv6+R9K4VmeCPMQM21Fjmx5538=;
        b=m0USZb5bbdfTuv8I1COl11RPVUol3bQue36MXll2Hf790/MNqWGsZkigcQtwLCUuUl/74W
        YZn7LYEjHRsCR/CA==
To:     Randy Dunlap <rdunlap@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] xfs: new code for 5.15
In-Reply-To: <7848ad2f-75fc-2416-8d9e-b0cc7c520107@infradead.org>
References: <20210831211847.GC9959@magnolia>
 <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
 <20210902174311.GG9942@magnolia>
 <20210902223545.GA1826899@dread.disaster.area> <87a6kub2dp.ffs@tglx>
 <20210905002105.GC1826899@dread.disaster.area> <87mtoqa9hb.ffs@tglx>
 <7848ad2f-75fc-2416-8d9e-b0cc7c520107@infradead.org>
Date:   Mon, 06 Sep 2021 11:42:25 +0200
Message-ID: <87eea29h1a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Randy,

On Sun, Sep 05 2021 at 19:11, Randy Dunlap wrote:
> On 9/5/21 4:28 PM, Thomas Gleixner wrote:
>> +  * cpuhp_setup_state() and cpuhp_setup_state_cpuslocked() install the
>> +    callbacks and invoke the @startup callback (if not NULL) for all online
>> +    CPUs which have currently a state greater than the newly installed
>> +    state. Depending on the state section the callback is either invoked on
>> +    the current CPU (PREPARE section) or on each online CPU (ONLINE
>> +    section) in the context of the CPU's hotplug thread.
>> +
>> +    If a callback fails for CPU N then the teardown callback for CPU
>> +    0 .. N-1 is invoked to rollback the operation. The state setup fails,
>
> CPU 0? Does one of these fail since it's not an AP?

Yes. CPU 0 is not special in any way.

The point is that the hotplug state callbacks are set up late in the
boot process or during runtime when a module is loaded or some
functionality initialized on first use.

At that time the boot CPU (0) and usually the secondary CPUs are online
already. So the driver/subsystem has two ways to bring the per CPU
functionality into operation:

 1) Initialize all per CPU state manually which often involves queuing
    work on each online CPU or invoking SMP function calls on the online
    CPUs and if all succeeds install the callbacks. If something goes
    wrong on one of the CPUs then the state has to be cleaned up on the
    CPUs which had their state set up correctly already.

    This of course has to be done with cpus_read_lock() held to
    serialize against a concurrent CPU hotplug operation.-

 2) Let the hotplug core do that work. Setup a state with the
    corresponding callbacks. The core invokes the startup callback on
    all online CPUs (including 0) in the correct context:

    for_each_online_cpu(cpu) {
    	ret = invoke_callback_on/for_cpu(cpu, startup);
        if (ret)
        	goto err;
        ...

    Any of these callback invocations can fail even the one on the boot
    CPU. In case of failure on CPU0 there is nothing to clean up, but if
    the Nth CPU callback fails then the state has been established for
    CPU 0 to CPU N-1 already, e.g. memory allocation, hardware setup ...

    So instead of returning with a half set up functionality, the core
    does the rollback on CPU 0 to CPU N-1 by invoking the teardown
    callback before returning the error code.

    err:
    	for_each_online_cpu(cpu) {
            if (startup_done[cpu])
                invoke_callback_on/for_cpu(cpu, teardown);
        }

    That means the call site does not have to mop up the half
    initialized state manually.

    All of that is properly serialized against CPU hotplug operations.

>> +
>> +    If a callback fails for CPU N then the teardown callback for CPU
>> +    0 .. N-1 is invoked to rollback the operation, the function fails and
>
> all except the Boot CPU?

See above.

Thanks,

        tglx
