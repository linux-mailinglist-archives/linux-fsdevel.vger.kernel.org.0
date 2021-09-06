Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1128E4014F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 04:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbhIFCMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 22:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbhIFCMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 22:12:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED77BC061575;
        Sun,  5 Sep 2021 19:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Ky4bG7KGTsnHipBAfRXL9mDIIk8mKlaMrLuz2v4zNa4=; b=NnXFdCqwHd0B10TYATV3ZAN7wi
        wLVvxz7VTsA+d4xe7pvfQePB607v7KDC6draw0v93GSVF/k1BD9KRBBk0DKIT4GsHQZlu/B0DV5zC
        6t33e/bR/5+TohsqxxPyFKdMOsi4ed4HXxPiWcFTlV92Z2wC8kQfIKob+PHuhQjWpxEDHd9kQPH/K
        pWkEtKqkqi//RuUfGzTT1kZOrI2Rzeqi1yHo+CTLdt1Gjy37v+FWRDajGihOKJrmGk6rYU/yxvab4
        w69zPOcEaKgkx2jYxHnj/qZ9mQHi8F9BBDKFZLp4kD0745L7HYQc14c1MH8vXImM4cuKHF70w7xyq
        PoJ3Txuw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mN46T-00H5Dj-5U; Mon, 06 Sep 2021 02:11:21 +0000
Subject: Re: [GIT PULL] xfs: new code for 5.15
To:     Thomas Gleixner <tglx@linutronix.de>,
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
References: <20210831211847.GC9959@magnolia>
 <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
 <20210902174311.GG9942@magnolia>
 <20210902223545.GA1826899@dread.disaster.area> <87a6kub2dp.ffs@tglx>
 <20210905002105.GC1826899@dread.disaster.area> <87mtoqa9hb.ffs@tglx>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7848ad2f-75fc-2416-8d9e-b0cc7c520107@infradead.org>
Date:   Sun, 5 Sep 2021 19:11:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87mtoqa9hb.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/5/21 4:28 PM, Thomas Gleixner wrote:
> Dave,
> 

[snip]

Hi,

Doc. comments below...


> I'm sorry that this change which turned CPU hotplug into a reliable,
> testable and instrumentable mechanism causes so much trouble for you. I
> hope it's just the lack of coherent documentation which made you
> unhappy.
> 
> If the updated documentation does not answer your questions, please let
> me know and please provide a coherent explanation of the problem you are
> trying to solve. Either I can give you an hint or I can identify further
> issues in the documentation.
> 
> If it turns out that there are functional shortcomings then I'm of
> course all ears as well.
> 
> If you need a conveniance API to install multiple states at once to
> regain the "simple API" feeling, please let me know - I surely have some
> ideas.
> 
> Thanks,
> 
>          tglx
> ---
> --- a/Documentation/core-api/cpu_hotplug.rst
> +++ b/Documentation/core-api/cpu_hotplug.rst
> @@ -156,95 +156,479 @@ hotplug states will be invoked, starting
>   * Once all services are migrated, kernel calls an arch specific routine
>     ``__cpu_disable()`` to perform arch specific cleanup.
>   

[snip]

> +
> +The CPU hotplug API
> +===================
> +
> +CPU hotplug state machine
> +-------------------------
> +
> +CPU hotplug uses a trivial state machine with a linear state space from
> +CPUHP_OFFLINE to CPUHP_ONLINE. Each state has a startup and a teardown
> +callback.
> +
> +When a CPU is onlined, the startup callbacks are invoked sequentially until
> +the state CPUHP_ONLINE is reached. They can also be invoked when the
> +callbacks of a state are set up or an instance is added to a multi-instance
> +state.
> +
> +When a CPU is offlined the teardown callbacks are invoked in the reverse
> +order sequenctially until the state CPUHP_OFFLINE is reached. They can also

          sequentially

> +be invoked when the callbacks of a state are removed or an instance is
> +removed from a multi-instance state.
> +
> +If a usage site requires only a callback in one direction of the hotplug
> +operations (CPU online or CPU offline) then the other not required callback

                                                          not-required

> +can be set to NULL when the state is set up.
> +
> +The state space is divided into three sections:
> +
> +* The PREPARE section
> +
> +  The PREPARE section covers the state space from CPUHP_OFFLINE to CPUHP_BRINGUP_CPU

                                                                       CPUHP_BRINGUP_CPU.

> +
> +  The startup callbacks in this section are invoked before the CPU is
> +  started during a CPU online operation. The teardown callbacks are invoked
> +  after the CPU has become dysfunctional during a CPU offline operation.
> +
> +  The callbacks are invoked on a control CPU as they can't obviously run on
> +  the hotplugged CPU which is either not yet started or has become
> +  dysfunctional already.
> +
> +  The startup callbacks are used to setup resources which are required to
> +  bring a CPU successfully online. The teardown callbacks are used to free
> +  resources or to move pending work to an online CPU after the hotplugged
> +  CPU became dysfunctional.
> +
> +  The startup callbacks are allowed to fail. If a callback fails, the CPU
> +  online operation is aborted and the CPU is brought down to the previous
> +  state (usually CPUHP_OFFLINE) again.
> +
> +  The teardown callbacks in this section are not allowed to fail.
> +
> +* The STARTING section
> +
> +  The STARTING section covers the state space between CPUHP_BRINGUP_CPU + 1
> +  and CPUHP_AP_ONLINE

      and CPUHP_AP_ONLINE.

> +
> +  The startup callbacks in this section are invoked on the hotplugged CPU
> +  with interrupts disabled during a CPU online operation in the early CPU
> +  setup code. The teardown callbacks are invoked with interrupts disabled
> +  on the hotplugged CPU during a CPU offline operation shortly before the
> +  CPU is completely shut down.
> +
> +  The callbacks in this section are not allowed to fail.
> +
> +  The callbacks are used for low level hardware initialization/shutdown and
> +  for core subsystems.
> +
> +* The ONLINE section
> +
> +  The ONLINE section covers the state space between CPUHP_AP_ONLINE + 1 and
> +  CPUHP_ONLINE.
> +
> +  The startup callbacks in this section are invoked on the hotplugged CPU
> +  during a CPU online operation. The teardown callbacks are invoked on the
> +  hotplugged CPU during a CPU offline operation.
> +
> +  The callbacks are invoked in the context of the per CPU hotplug thread,
> +  which is pinned on the hotplugged CPU. The callbacks are invoked with
> +  interrupts and preemption enabled.
> +
> +  The callbacks are allowed to fail. When a callback fails the hotplug
> +  operation is aborted and the CPU is brought back to the previous state.
> +
> +CPU online/offline operations
> +-----------------------------
> +
> +A successful online operation looks like this: ::
> +
> +  [CPUHP_OFFLINE]
> +  [CPUHP_OFFLINE + 1]->startup()       -> success
> +  [CPUHP_OFFLINE + 2]->startup()       -> success
> +  [CPUHP_OFFLINE + 3]                  -> skipped because startup == NULL
> +  ...
> +  [CPUHP_BRINGUP_CPU]->startup()       -> success
> +  === End of PREPARE section
> +  [CPUHP_BRINGUP_CPU + 1]->startup()   -> success
> +  ...
> +  [CPUHP_AP_ONLINE]->startup()         -> success
> +  === End of STARTUP section
> +  [CPUHP_AP_ONLINE + 1]->startup()     -> success
> +  ...
> +  [CPUHP_ONLINE - 1]->startup()        -> success
> +  [CPUHP_ONLINE]
> +
> +A successful offline operation looks like this: ::
> +
> +  [CPUHP_ONLINE]
> +  [CPUHP_ONLINE - 1]->teardown()       -> success
> +  ...
> +  [CPUHP_AP_ONLINE + 1]->teardown()    -> success
> +  === Start of STARTUP section
> +  [CPUHP_AP_ONLINE]->teardown()        -> success
> +  ...
> +  [CPUHP_BRINGUP_ONLINE - 1]->teardown()
> +  ...
> +  === Start of PREPARE section
> +  [CPUHP_BRINGUP_CPU]->teardown()
> +  [CPUHP_OFFLINE + 3]->teardown()
> +  [CPUHP_OFFLINE + 2]                  -> skipped because teardown == NULL
> +  [CPUHP_OFFLINE + 1]->teardown()
> +  [CPUHP_OFFLINE]
> +
> +A failed online operation looks like this: ::
> +
> +  [CPUHP_OFFLINE]
> +  [CPUHP_OFFLINE + 1]->startup()       -> success
> +  [CPUHP_OFFLINE + 2]->startup()       -> success
> +  [CPUHP_OFFLINE + 3]                  -> skipped because startup == NULL
> +  ...
> +  [CPUHP_BRINGUP_CPU]->startup()       -> success
> +  === End of PREPARE section
> +  [CPUHP_BRINGUP_CPU + 1]->startup()   -> success
> +  ...
> +  [CPUHP_AP_ONLINE]->startup()         -> success
> +  === End of STARTUP section
> +  [CPUHP_AP_ONLINE + 1]->startup()     -> success
> +  ---
> +  [CPUHP_AP_ONLINE + N]->startup()     -> fail
> +  [CPUHP_AP_ONLINE + (N - 1)]->teardown()
> +  ...
> +  [CPUHP_AP_ONLINE + 1]->teardown()
> +  === Start of STARTUP section
> +  [CPUHP_AP_ONLINE]->teardown()
> +  ...
> +  [CPUHP_BRINGUP_ONLINE - 1]->teardown()
> +  ...
> +  === Start of PREPARE section
> +  [CPUHP_BRINGUP_CPU]->teardown()
> +  [CPUHP_OFFLINE + 3]->teardown()
> +  [CPUHP_OFFLINE + 2]                  -> skipped because teardown == NULL
> +  [CPUHP_OFFLINE + 1]->teardown()
> +  [CPUHP_OFFLINE]
> +
> +A failed offline operation looks like this: ::
> +
> +  [CPUHP_ONLINE]
> +  [CPUHP_ONLINE - 1]->teardown()       -> success
> +  ...
> +  [CPUHP_ONLINE - N]->teardown()       -> fail
> +  [CPUHP_ONLINE - (N - 1)]->startup()
> +  ...
> +  [CPUHP_ONLINE - 1]->startup()
> +  [CPUHP_ONLINE]
> +
> +Recursive failures cannot be handled sensibly. Look at the following
> +example of a recursive fail due to a failed offline operation: ::
> +
> +  [CPUHP_ONLINE]
> +  [CPUHP_ONLINE - 1]->teardown()       -> success
> +  ...
> +  [CPUHP_ONLINE - N]->teardown()       -> fail
> +  [CPUHP_ONLINE - (N - 1)]->startup()  -> success
> +  [CPUHP_ONLINE - (N - 2)]->startup()  -> fail
> +
> +The CPU hotplug state machine stops right here and does not try to go back
> +down again because that would likely result in an endless loop: ::
> +
> +  [CPUHP_ONLINE - (N - 1)]->teardown() -> success
> +  [CPUHP_ONLINE - N]->teardown()       -> fail
> +  [CPUHP_ONLINE - (N - 1)]->startup()  -> success
> +  [CPUHP_ONLINE - (N - 2)]->startup()  -> fail
> +  [CPUHP_ONLINE - (N - 1)]->teardown() -> success
> +  [CPUHP_ONLINE - N]->teardown()       -> fail
> +
> +Lather, rinse and repeat. In this case the CPU left in state: ::

                                               CPU is left

> +
> +  [CPUHP_ONLINE - (N - 1)]
> +
> +which at least lets the system make progress and gives the user a chance to
> +debug or even resolve the situation.
> +
> +Allocating a state
> +------------------
> +
> +There are two ways to allocate a CPU hotplug state:
> +
> +* Static allocation
> +
> +  Static allocation has to be used when the subsystem or driver has
> +  ordering requirements versus other CPU hotplug states. E.g. the PERF core
> +  startup callback has to be invoked before the PERF driver startup
> +  callbacks during a CPU online operation. During a CPU offline operation
> +  the driver teardown callbacks have to be invoked before the core teardown
> +  callback. The statically allocated states are described by constants in
> +  the cpuhp_state enum which can be found in include/linux/cpuhotplug.h.
> +
> +  Insert the state into the enum at the proper place so the ordering
> +  requirements are fulfilled. The state constant has to be used for state
> +  setup and removal.
> +
> +  Static allocation is also required when the state callbacks are not set
> +  up at runtime and are part of the initializer of the CPU hotplug state
> +  array in kernel/cpu.c.
> +
> +* Dynamic allocation
> +
> +  When there are no ordering requirements for the state callbacks then
> +  dynamic allocation is the preferred method. The state number is allocated
> +  by the setup function and returned to the caller on success.
> +
> +  Only the PREPARE and ONLINE sections provide a dynamic allocation
> +  range. The STARTING section does not as most of the callbacks in that
> +  section have explicit ordering requirements.
> +
> +Setup of a CPU hotplug state
> +----------------------------
> +
> +The core code provides the following functions to setup a state:
> +
> +* cpuhp_setup_state(state, name, startup, teardown)
> +* cpuhp_setup_state_nocalls(state, name, startup, teardown)
> +* cpuhp_setup_state_cpuslocked(state, name, startup, teardown)
> +* cpuhp_setup_state_nocalls_cpuslocked(state, name, startup, teardown)
> +
> +For cases where a driver or a subsystem has multiple instances and the same
> +CPU hotplug state callbacks need to be invoked for each instance, the CPU
> +hotplug core provides multi-instance support. The advantage over driver
> +specific instance lists is that the instance related functions are fully
> +serialized against CPU hotplug operations and provide the automatic
> +invocations of the state callbacks on add and removal. To set up such a
> +multi-instance state the following function is available:
> +
> +* cpuhp_setup_state_multi(state, name, startup, teardown)
> +
> +The @state argument is either a statically allocated state or one of the
> +constants for dynamically allocated states - CPUHP_PREPARE_DYN,
> +CPUHP_ONLINE_DYN - depending on the state section (PREPARE, ONLINE) for
> +which a dynamic state should be allocated.
> +
> +The @name argument is used for sysfs output and for instrumentation. The
> +naming convention is "subsys:mode" or "subsys/driver:mode",
> +e.g. "perf:mode" or "perf/x86:mode". The common mode names:

                                                         names are:

> +
> +======== =======================================================
> +prepare  For states in the PREPAREsection

                               PREPARE section

> +
> +dead     For states in the PREPARE section which do not provide
> +         a startup callback
> +
> +starting For states in the STARTING section
> +
> +dying    For states in the STARTING section which do not provide
> +         a startup callback
> +
> +online   For states in the ONLINE section
> +
> +offline  For states in the ONLINE section which do not provide
> +         a startup callback
> +======== =======================================================
> +
> +As the @name argument is only used for sysfs and instrumentation other mode
> +descriptors can be used as well if they describe the nature of the state
> +better than the common ones.
> +
> +Examples for @name arguments: "perf/online", "perf/x86:prepare",
> +"RCU/tree:dying", "sched/waitempty"
> +
> +The @startup argument is a function pointer to the callback which should be
> +invoked during a CPU online operation. If the usage site does not require a
> +startup callback set the pointer to NULL.
> +
> +The @teardown argument is a function pointer to the callback which should
> +be invoked during a CPU offline operation. If the usage site does not
> +require a teardown callback set the pointer to NULL.
> +
> +The functions differ in the way how the installed callbacks are treated:
> +
> +  * cpuhp_setup_state_nocalls(), cpuhp_setup_state_nocalls_cpuslocked()
> +    and cpuhp_setup_state_multi() only install the callbacks
> +
> +  * cpuhp_setup_state() and cpuhp_setup_state_cpuslocked() install the
> +    callbacks and invoke the @startup callback (if not NULL) for all online
> +    CPUs which have currently a state greater than the newly installed
> +    state. Depending on the state section the callback is either invoked on
> +    the current CPU (PREPARE section) or on each online CPU (ONLINE
> +    section) in the context of the CPU's hotplug thread.
> +
> +    If a callback fails for CPU N then the teardown callback for CPU
> +    0 .. N-1 is invoked to rollback the operation. The state setup fails,

CPU 0? Does one of these fail since it's not an AP?

> +    the callbacks for the state are not installed and in case of dynamic
> +    allocation the allocated state is freed.
> +
> +The state setup and the callback invocations are serialized against CPU
> +hotplug operations. If the setup function has to be called from a CPU
> +hotplug read locked region, then the _cpuslocked() variants have to be
> +used. These functions cannot be used from within CPU hotplug callbacks.
> +
> +The function return values:
> +  ======== ===================================================================
> +  0        Statically allocated state was successfully set up
> +
> +  >0       Dynamically allocated state was successfully set up.
> +
> +           The returned number is the state number which was allocated. If
> +           the state callbacks have to be removed later, e.g. module
> +           removal, then this number has to be saved by the caller and used
> +           as @state argument for the state remove function. For
> +           multi-instance states the dynamically allocated state number is
> +           also required as @state argument for the instance add/remove
> +           operations.
> +
> +  <0	   Operation failed
> +  ======== ===================================================================
> +
> +Removal of a CPU hotplug state
> +------------------------------
> +
> +To remove a previously set up state, the following functions are provided:
> +
> +* cpuhp_remove_state(state)
> +* cpuhp_remove_state_nocalls(state)
> +* cpuhp_remove_state_nocalls_cpuslocked(state)
> +* cpuhp_remove_multi_state(state)
> +
> +The @state argument is either a statically allocated state or the state
> +number which was allocated in the dynamic range by cpuhp_setup_state*(). If
> +the state is in the dynamic range, then the state number is freed and
> +available for dynamic allocation again.
> +
> +The functions differ in the way how the installed callbacks are treated:
> +
> +  * cpuhp_remove_state_nocalls(), cpuhp_remove_state_nocalls_cpuslocked()
> +    and cpuhp_remove_multi_state() only remove the callbacks.
> +
> +  * cpuhp_remove_state() removes the callbacks and invokes the teardown
> +    callback (if not NULL) for all online CPUs which have currently a state
> +    greater than the removed state. Depending on the state section the
> +    callback is either invoked on the current CPU (PREPARE section) or on
> +    each online CPU (ONLINE section) in the context of the CPU's hotplug
> +    thread.
> +
> +    In order to complete the removal, the teardown callback should not fail.
> +
> +The state removal and the callback invocations are serialized against CPU
> +hotplug operations. If the remove function has to be called from a CPU
> +hotplug read locked region, then the _cpuslocked() variants have to be
> +used. These functions cannot be used from within CPU hotplug callbacks.
> +
> +If a multi-instance state is removed then the caller has to remove all
> +instances first.
> +
> +Multi-Instance state instance management
> +----------------------------------------
> +
> +Once the multi-instance state is set up, instances can be added to the
> +state:
> +
> +  * cpuhp_state_add_instance(state, node)
> +  * cpuhp_state_add_instance_nocalls(state, node)
> +
> +The @state argument is either a statically allocated state or the state
> +number which was allocated in the dynamic range by cpuhp_setup_state_multi().
> +
> +The @node argument is a pointer to a hlist_node which is embedded in the

               I would say:         to an hlist_node

> +instance's data structure. The pointer is handed to the multi-instance
> +state callbacks and can be used by the callback to retrieve the instance
> +via container_of().
> +
> +The functions differ in the way how the installed callbacks are treated:
> +
> +  * cpuhp_state_add_instance_nocalls() and only adds the instance to the
> +    multi-instance state's node list.
> +
> +  * cpuhp_state_add_instance() adds the instance and invokes the startup
> +    callback (if not NULL) associated with @state for all online CPUs which
> +    have currently a state greater than @state. The callback is only
> +    invoked for the to be added instance. Depending on the state section
> +    the callback is either invoked on the current CPU (PREPARE section) or
> +    on each online CPU (ONLINE section) in the context of the CPU's hotplug
> +    thread.
> +
> +    If a callback fails for CPU N then the teardown callback for CPU
> +    0 .. N-1 is invoked to rollback the operation, the function fails and

all except the Boot CPU?

> +    the instance is not added to the node list of the multi-instance state.
> +
> +To remove an instance from the state's node list these functions are
> +available:
> +
> +  * cpuhp_state_remove_instance(state, node)
> +  * cpuhp_state_remove_instance_nocalls(state, node)
> +
> +The arguments are the same as for the the cpuhp_state_add_instance*()
> +variants above.
> +
> +The functions differ in the way how the installed callbacks are treated:
> +
> +  * cpuhp_state_remove_instance_nocalls() only removes the instance from the
> +    state's node list.
> +
> +  * cpuhp_state_remove_instance() removes the instance and invokes the
> +    teardown callback (if not NULL) associated with @state for all online
> +    CPUs which have currently a state greater than @state.  The callback is
> +    only invoked for the to be removed instance.  Depending on the state
> +    section the callback is either invoked on the current CPU (PREPARE
> +    section) or on each online CPU (ONLINE section) in the context of the
> +    CPU's hotplug thread.
> +
> +    In order to complete the removal, the teardown callback should not fail.
> +
> +The node list add/remove operations and the callback invocations are
> +serialized against CPU hotplug operations. These functions cannot be used
> +from within CPU hotplug callbacks and CPU hotplug read locked regions.
> +
> +Examples
> +--------
> +
> +Setup and teardown a statically allocated state in the STARTING section for
> +notifications on online and offline operations: ::
> +
> +   ret = cpuhp_setup_state(CPUHP_SUBSYS_STARTING, "subsys:starting", subsys_cpu_starting, subsys_cpu_dying);
> +   if (ret < 0)
> +        return ret;
> +   ....
> +   cpuhp_remove_state(CPUHP_SUBSYS_STARTING);
> +
> +Setup and teardown a dynamically allocated state in the ONLINE section
> +for notifications on offline operations: ::
> +
> +   state = cpuhp_setup_state(CPUHP_ONLINE_DYN, "subsys:offline", NULL, subsys_cpu_offline);
> +   if (state < 0)
> +       return state;
> +   ....
> +   cpuhp_remove_state(state);
> +
> +Setup and teardown a dynamically allocated state in the ONLINE section
> +for notifications on online operations without invoking the callbacks: ::
> +
> +   state = cpuhp_setup_state_nocalls(CPUHP_ONLINE_DYN, "subsys:online", subsys_cpi_online, NULL);

                                                                                  _cpu_

> +   if (state < 0)
> +       return state;
> +   ....
> +   cpuhp_remove_state_nocalls(state);
> +
> +Setup, use and teardown a dynamically allocated multi-instance state in the
> +ONLINE section for notifications on online and offline operation: ::
> +
> +   state = cpuhp_setup_state_multi(CPUHP_ONLINE_DYN, "subsys:online", subsys_cpu_online, subsys_cpu_offline);
> +   if (state < 0)
> +       return state;
> +   ....
> +   ret = cpuhp_state_add_instance(state, &inst1->node);
> +   if (ret)
> +        return ret;
> +   ....
> +   ret = cpuhp_state_add_instance(state, &inst2->node);
> +   if (ret)
> +        return ret;
> +   ....
> +   cpuhp_remove_instance(state, &inst1->node);
> +   ....
> +   cpuhp_remove_instance(state, &inst2->node);
> +   ....
> +   remove_multi_state(state);
> +
>   
>   Testing of hotplug states
>   =========================


-- 
~Randy

