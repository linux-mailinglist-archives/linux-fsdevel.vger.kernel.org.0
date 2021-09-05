Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA90401216
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 01:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhIEX3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 19:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhIEX3I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 19:29:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDDCC061575;
        Sun,  5 Sep 2021 16:28:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630884481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mwEzgqvTABhy3dSK782j3nHbnc/d1QQ1Tt5FtA+Ybbk=;
        b=qidPdo26BGKz+jE4/7LJy1fou6QsP6Os6Jll/wAVABYWQthZ+rfpWIiPSX3LfEWSRwKvAH
        sEL6PCQHieiLOZCS2K8OF7M0NWk9ZMht0LLH1Hw9ubl6MTmBfpzbYDNHqhCFHRBc0uwAyx
        dk/o4UgCmNhYQhqCR2Ok/FqoaCNtWCGVFdIxLajdUXqqZ/hVFvw8tlpHzk3U/e5w/1wcjP
        0UPTeBSGly5T3C4oaLL+599WC7pkUKv6wLp/tg+1KOFhSFrz7CFNVVEep/w5a53bXvez4C
        N5UEwhHZz935ffZHONG46zecwttCcxZ2z7HTmXxPuX3SaJ19cWKUnv1GiNL4Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630884481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mwEzgqvTABhy3dSK782j3nHbnc/d1QQ1Tt5FtA+Ybbk=;
        b=i4spk046dXXJGZI5qVxbYNtt3Vu7A1M1cxYzTnXtG4NmyDbw6HYYcmMEGNWmG9hL82mOev
        z0sD5++v54t0uqAg==
To:     Dave Chinner <david@fromorbit.com>
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
In-Reply-To: <20210905002105.GC1826899@dread.disaster.area>
References: <20210831211847.GC9959@magnolia>
 <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
 <20210902174311.GG9942@magnolia>
 <20210902223545.GA1826899@dread.disaster.area> <87a6kub2dp.ffs@tglx>
 <20210905002105.GC1826899@dread.disaster.area>
Date:   Mon, 06 Sep 2021 01:28:00 +0200
Message-ID: <87mtoqa9hb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave,

On Sun, Sep 05 2021 at 10:21, Dave Chinner wrote:
> On Fri, Sep 03, 2021 at 08:26:58AM +0200, Thomas Gleixner wrote:
>> On Fri, Sep 03 2021 at 08:35, Dave Chinner wrote:
>> > On Thu, Sep 02, 2021 at 10:43:11AM -0700, Darrick J. Wong wrote:
>> > The part I dislike most about it is that we have to modify a header
>> > file that triggers full kernel rebuilds. Managing patch stacks and
>> > branches where one of them modifies such a header file means quick,
>> > XFS subsystem only kernel rebuilds are a rare thing...
>>=20
>> If you don't care about ordering, you can avoid touching the global
>> header completely. The dynamic state ranges in PREPARE and ONLINE
>> provide exactly what you want. It's documented.
>
> Ordering? When and why would I care about ordering?

Quite some hotplug related functionality cares about ordering of the
callbacks vs. other subsytems or core functionality:

 - workqueue startup/shutdown has to be at a well defined place

 - the PERF core online callback needs to be invoked before the
   various PERF drivers callbacks. On teardown the ordering is obviously
   reverse: Notify drivers before code.

 - low level startup/teardowm code has very strict ordering requirements

 - ....

If you don't have ordering requirements and you just want to be notified
then you don't have to think about that at all. Set up a dynamic state
and be done with it.

> il_last_pushed_lsn

I assume that I'm not supposed to figure out how that is related to the
topic we are discussing. :)

>> > That said, I'm all for a better interface to the CPU hotplug
>> > notifications. THe current interface is ... esoteric and to
>>=20
>> What's so esoteric about:
>>=20
>>        state =3D cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "xfs:prepare", =
func1, func2);
>>        state =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "xfs:online", fu=
nc3, func4);
>
> I don't want -online- notifications.  I only want _offline_
> notifications and according to the documentation,
> CPUHP_AP_ONLINE_DYN get called on both online and offline state
> changes.

So if you want only offline notification then you simply hand in NULL
for the bringup callback.

        state =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "xfs:offline", NUL=
L, func4);

> Don't you see the cognitive dissonance that contradictory "use
> online for offline" API naming like this causes.

It's so amazing hard to understand that offline is the reverse operation
of online, right?

> It easily scores negative points on the Rusty's API scale....

I'm surely impressed by the APIs which Rusty constructed.

The CPU hotplug notifier register/unregister API was surely trivial and
intuitive, but the rest was a horror show if you had to do something
more complex than 'let me know that the CPU is dead'.

Rusty admitted himself that the original CPU hotplug design was a
steaming pile of s... including the 'so simple' API. See below.

> Also, having to understand what the multiple callbacks
> just for different operations is a bit of a WTF. What's the actual
> difference between the "online" and "prepare down" callbacks?
> For online notifications, the prepare down op is documented as the
> online hotplug error handling function that undoes the online
> callback.
>
> But if we are registering an -offline notification-, their use isn't
> actually documented. Is it the same, or is it inverted? I have to go
> read the code...

The documentation sucks. I told you that I'm happy to update it. See
patch below.

> Indeed, that's the core difference between that old API and the
> current API - the current API requires registering a notifier per
> state transition, but that registers the notifier for both CPU up
> and down transitions.

That registers a callback for startup and teardown and either one can be
NULL if not required.

> The problem with the new API is that the requirement for symmetry in
> some subsystems has bled into the API, and so now all the subsystems
> that *don't need/want symmetry* have to juggle some undocumented
> esoteric combination of state definitions and callbacks to get the
> behaviour they require.

What kind of esoteric things do you need? Can you explain the
requirements and why do you think it's hard to solve?

Your handwaving here is more than counterproductive.

> And that, AFAICT, means that those callbacks can't handle failures in
> hotplug processing properly.

Why so?

Here is an example for online:

        [state 1]->startup()    -> success
        [state 2]->startup()    -> success
        [state 3]               -> skipped because startup is NULL=20
        [state 4]->startup()    -> fail
        [state 3]->teardown()
        [state 2]               -> skipped because teardown is NULL
        [state 1]->teardown()

If state 2 does not provide a teardown callback then there is nothing to
teardown obviously. Same for state 3 on startup.

What does not work correctly in the error case?

It does not matter at all whether the transition from state 3 to state 0
happens due to a CPU offline operation or because the online operation
got aborted at state 4. It's exactly the same thing. It's that simple,
really.

If you think that you need a 'bringup failed' notification for the
subsystem which set up state 4 or a 'bringup failed' notification for
the subsystem which registered state 2 then you are really doing
something fundamentally wrong.

I know that the 'oh so simple and well designed' original notifier sent
these 'failed' notifications, but they were sent for the completely
wrong reasons and were part of the overall problem.

I'm obviously failing to understand how a 'simple' single callback
interface which forces the user to handle a gazillion of obscure events
is so much superiour than a straight forward linear state machine,

> So rather than having a nice, simple "one callback per event" API,
> we've got this convoluted thing that behaves according to a
> combination of state definition and callback defintions. Then the
> API is duplicated into "_nocall()" variants (not documented!)
> because many subsystems do not want hotplug callbacks run on
> setup/teardown of hotplug events.

About 70% of the state setups are utilizing the callback invocations
which means we don't have to have hundreds duplicated and probably
differently buggy code to do that manually all over the place.

That's a clear maintenance and code correctness win and that definitely
justifies an extra inline variant for those usage sites which don't
need/want those invocations for hopefully well thought out reasons.

> The old hotplug notification *implementation* had problems, but the
> *API* was not the cause of those bugs.

The state transitions, i.e. the @reason (event) argument to the
callbacks were definitely part of the API and that was where the main
problem came from.

At the end we had _seventeen_ different reasons (events) because people
added new ones over and over to duct tape the issues of the existing
pile. What the hell is simple about that?

Most of these reasons and their possible transition schemes were
undocumented and not understandable at all. That and the assbackwards
failure handling turned that thing into an unmaintainable and unfixable
nightmare.

The fact that 25% of all notifier callbacks were buggy speaks for
itself. Not to talk about the locking issues which got papered over by
the fact that the hotplug locking was hidden from lockdep, the absurd
assumptions about invocation context and the workarounds to handle
callback invocations correctly when registering or unregistering a
notifier.

The charm of this "simple" API ended right there at the register /
unregister function invocation level. Nice for the occasional user with
simple requirements and a nightmare for those people who had to debug
the fallout of this simplicity.

Keep it simple is surely a good engineering principle, but if the
simplicity is restricted to the least important part of the problem then
it turns into a nightmare.

> In contrast, the current API appears to make it impossible to
> implement notifiers for certain use cases correctly, and that's
> directly where my statement that "you need to be a cpuhp expert to use
> this" comes from....

Just for the record:

 - When we converted all notifiers over there was not a single instance
   which could not be handled straight forward and in the vast majority
   of the cases the code got simpler, smaller and easier to understand.

 - After the initial conversion more than hundred state setups were
   added without a single complaint about the so complex API and no one
   showed up as hotplug expert since then.

 - The number of obscure and hard to debug CPU hotplug bugs has gone
   close to zero since then. The obvious programming bugs in the core,
   the callbacks and API usage are just the usual programming errors
   which are not specific to CPU hotplug at all.

I'm sorry that this change which turned CPU hotplug into a reliable,
testable and instrumentable mechanism causes so much trouble for you. I
hope it's just the lack of coherent documentation which made you
unhappy.

If the updated documentation does not answer your questions, please let
me know and please provide a coherent explanation of the problem you are
trying to solve. Either I can give you an hint or I can identify further
issues in the documentation.

If it turns out that there are functional shortcomings then I'm of
course all ears as well.

If you need a conveniance API to install multiple states at once to
regain the "simple API" feeling, please let me know - I surely have some
ideas.

Thanks,

        tglx
---
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -156,95 +156,479 @@ hotplug states will be invoked, starting
 * Once all services are migrated, kernel calls an arch specific routine
   ``__cpu_disable()`` to perform arch specific cleanup.
=20
-Using the hotplug API
----------------------
-It is possible to receive notifications once a CPU is offline or onlined. =
This
-might be important to certain drivers which need to perform some kind of s=
etup
-or clean up functions based on the number of available CPUs: ::
-
-  #include <linux/cpuhotplug.h>
-
-  ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "X/Y:online",
-                          Y_online, Y_prepare_down);
-
-*X* is the subsystem and *Y* the particular driver. The *Y_online* callback
-will be invoked during registration on all online CPUs. If an error
-occurs during the online callback the *Y_prepare_down* callback will be
-invoked on all CPUs on which the online callback was previously invoked.
-After registration completed, the *Y_online* callback will be invoked
-once a CPU is brought online and *Y_prepare_down* will be invoked when a
-CPU is shutdown. All resources which were previously allocated in
-*Y_online* should be released in *Y_prepare_down*.
-The return value *ret* is negative if an error occurred during the
-registration process. Otherwise a positive value is returned which
-contains the allocated hotplug for dynamically allocated states
-(*CPUHP_AP_ONLINE_DYN*). It will return zero for predefined states.
-
-The callback can be remove by invoking ``cpuhp_remove_state()``. In case o=
f a
-dynamically allocated state (*CPUHP_AP_ONLINE_DYN*) use the returned state.
-During the removal of a hotplug state the teardown callback will be invoke=
d.
-
-Multiple instances
-~~~~~~~~~~~~~~~~~~
-If a driver has multiple instances and each instance needs to perform the
-callback independently then it is likely that a ''multi-state'' should be =
used.
-First a multi-state state needs to be registered: ::
-
-  ret =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "X/Y:online,
-                                Y_online, Y_prepare_down);
-  Y_hp_online =3D ret;
-
-The ``cpuhp_setup_state_multi()`` behaves similar to ``cpuhp_setup_state()=
``
-except it prepares the callbacks for a multi state and does not invoke
-the callbacks. This is a one time setup.
-Once a new instance is allocated, you need to register this new instance: =
::
-
-  ret =3D cpuhp_state_add_instance(Y_hp_online, &d->node);
-
-This function will add this instance to your previously allocated
-*Y_hp_online* state and invoke the previously registered callback
-(*Y_online*) on all online CPUs. The *node* element is a ``struct
-hlist_node`` member of your per-instance data structure.
-
-On removal of the instance: ::
-  cpuhp_state_remove_instance(Y_hp_online, &d->node)
-
-should be invoked which will invoke the teardown callback on all online
-CPUs.
-
-Manual setup
-~~~~~~~~~~~~
-Usually it is handy to invoke setup and teardown callbacks on registration=
 or
-removal of a state because usually the operation needs to performed once a=
 CPU
-goes online (offline) and during initial setup (shutdown) of the driver. H=
owever
-each registration and removal function is also available with a ``_nocalls=
``
-suffix which does not invoke the provided callbacks if the invocation of t=
he
-callbacks is not desired. During the manual setup (or teardown) the functi=
ons
-``cpus_read_lock()`` and ``cpus_read_unlock()`` should be used to inhibit =
CPU
-hotplug operations.
-
-
-The ordering of the events
---------------------------
-The hotplug states are defined in ``include/linux/cpuhotplug.h``:
-
-* The states *CPUHP_OFFLINE* =E2=80=A6 *CPUHP_AP_OFFLINE* are invoked befo=
re the
-  CPU is up.
-* The states *CPUHP_AP_OFFLINE* =E2=80=A6 *CPUHP_AP_ONLINE* are invoked
-  just the after the CPU has been brought up. The interrupts are off and
-  the scheduler is not yet active on this CPU. Starting with *CPUHP_AP_OFF=
LINE*
-  the callbacks are invoked on the target CPU.
-* The states between *CPUHP_AP_ONLINE_DYN* and *CPUHP_AP_ONLINE_DYN_END* a=
re
-  reserved for the dynamic allocation.
-* The states are invoked in the reverse order on CPU shutdown starting with
-  *CPUHP_ONLINE* and stopping at *CPUHP_OFFLINE*. Here the callbacks are
-  invoked on the CPU that will be shutdown until *CPUHP_AP_OFFLINE*.
-
-A dynamically allocated state via *CPUHP_AP_ONLINE_DYN* is often enough.
-However if an earlier invocation during the bring up or shutdown is requir=
ed
-then an explicit state should be acquired. An explicit state might also be
-required if the hotplug event requires specific ordering in respect to
-another hotplug event.
+
+The CPU hotplug API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+CPU hotplug state machine
+-------------------------
+
+CPU hotplug uses a trivial state machine with a linear state space from
+CPUHP_OFFLINE to CPUHP_ONLINE. Each state has a startup and a teardown
+callback.
+
+When a CPU is onlined, the startup callbacks are invoked sequentially until
+the state CPUHP_ONLINE is reached. They can also be invoked when the
+callbacks of a state are set up or an instance is added to a multi-instance
+state.
+
+When a CPU is offlined the teardown callbacks are invoked in the reverse
+order sequenctially until the state CPUHP_OFFLINE is reached. They can also
+be invoked when the callbacks of a state are removed or an instance is
+removed from a multi-instance state.
+
+If a usage site requires only a callback in one direction of the hotplug
+operations (CPU online or CPU offline) then the other not required callback
+can be set to NULL when the state is set up.
+
+The state space is divided into three sections:
+
+* The PREPARE section
+
+  The PREPARE section covers the state space from CPUHP_OFFLINE to CPUHP_B=
RINGUP_CPU
+
+  The startup callbacks in this section are invoked before the CPU is
+  started during a CPU online operation. The teardown callbacks are invoked
+  after the CPU has become dysfunctional during a CPU offline operation.
+
+  The callbacks are invoked on a control CPU as they can't obviously run on
+  the hotplugged CPU which is either not yet started or has become
+  dysfunctional already.
+
+  The startup callbacks are used to setup resources which are required to
+  bring a CPU successfully online. The teardown callbacks are used to free
+  resources or to move pending work to an online CPU after the hotplugged
+  CPU became dysfunctional.
+
+  The startup callbacks are allowed to fail. If a callback fails, the CPU
+  online operation is aborted and the CPU is brought down to the previous
+  state (usually CPUHP_OFFLINE) again.
+
+  The teardown callbacks in this section are not allowed to fail.
+
+* The STARTING section
+
+  The STARTING section covers the state space between CPUHP_BRINGUP_CPU + 1
+  and CPUHP_AP_ONLINE
+
+  The startup callbacks in this section are invoked on the hotplugged CPU
+  with interrupts disabled during a CPU online operation in the early CPU
+  setup code. The teardown callbacks are invoked with interrupts disabled
+  on the hotplugged CPU during a CPU offline operation shortly before the
+  CPU is completely shut down.
+
+  The callbacks in this section are not allowed to fail.
+
+  The callbacks are used for low level hardware initialization/shutdown and
+  for core subsystems.
+
+* The ONLINE section
+
+  The ONLINE section covers the state space between CPUHP_AP_ONLINE + 1 and
+  CPUHP_ONLINE.
+
+  The startup callbacks in this section are invoked on the hotplugged CPU
+  during a CPU online operation. The teardown callbacks are invoked on the
+  hotplugged CPU during a CPU offline operation.
+
+  The callbacks are invoked in the context of the per CPU hotplug thread,
+  which is pinned on the hotplugged CPU. The callbacks are invoked with
+  interrupts and preemption enabled.
+
+  The callbacks are allowed to fail. When a callback fails the hotplug
+  operation is aborted and the CPU is brought back to the previous state.
+
+CPU online/offline operations
+-----------------------------
+
+A successful online operation looks like this: ::
+
+  [CPUHP_OFFLINE]
+  [CPUHP_OFFLINE + 1]->startup()       -> success
+  [CPUHP_OFFLINE + 2]->startup()       -> success
+  [CPUHP_OFFLINE + 3]                  -> skipped because startup =3D=3D N=
ULL
+  ...
+  [CPUHP_BRINGUP_CPU]->startup()       -> success
+  =3D=3D=3D End of PREPARE section
+  [CPUHP_BRINGUP_CPU + 1]->startup()   -> success
+  ...
+  [CPUHP_AP_ONLINE]->startup()         -> success
+  =3D=3D=3D End of STARTUP section
+  [CPUHP_AP_ONLINE + 1]->startup()     -> success
+  ...
+  [CPUHP_ONLINE - 1]->startup()        -> success
+  [CPUHP_ONLINE]
+
+A successful offline operation looks like this: ::
+
+  [CPUHP_ONLINE]
+  [CPUHP_ONLINE - 1]->teardown()       -> success
+  ...
+  [CPUHP_AP_ONLINE + 1]->teardown()    -> success
+  =3D=3D=3D Start of STARTUP section
+  [CPUHP_AP_ONLINE]->teardown()        -> success
+  ...
+  [CPUHP_BRINGUP_ONLINE - 1]->teardown()
+  ...
+  =3D=3D=3D Start of PREPARE section
+  [CPUHP_BRINGUP_CPU]->teardown()
+  [CPUHP_OFFLINE + 3]->teardown()
+  [CPUHP_OFFLINE + 2]                  -> skipped because teardown =3D=3D =
NULL
+  [CPUHP_OFFLINE + 1]->teardown()
+  [CPUHP_OFFLINE]
+
+A failed online operation looks like this: ::
+
+  [CPUHP_OFFLINE]
+  [CPUHP_OFFLINE + 1]->startup()       -> success
+  [CPUHP_OFFLINE + 2]->startup()       -> success
+  [CPUHP_OFFLINE + 3]                  -> skipped because startup =3D=3D N=
ULL
+  ...
+  [CPUHP_BRINGUP_CPU]->startup()       -> success
+  =3D=3D=3D End of PREPARE section
+  [CPUHP_BRINGUP_CPU + 1]->startup()   -> success
+  ...
+  [CPUHP_AP_ONLINE]->startup()         -> success
+  =3D=3D=3D End of STARTUP section
+  [CPUHP_AP_ONLINE + 1]->startup()     -> success
+  ---
+  [CPUHP_AP_ONLINE + N]->startup()     -> fail
+  [CPUHP_AP_ONLINE + (N - 1)]->teardown()
+  ...
+  [CPUHP_AP_ONLINE + 1]->teardown()
+  =3D=3D=3D Start of STARTUP section
+  [CPUHP_AP_ONLINE]->teardown()
+  ...
+  [CPUHP_BRINGUP_ONLINE - 1]->teardown()
+  ...
+  =3D=3D=3D Start of PREPARE section
+  [CPUHP_BRINGUP_CPU]->teardown()
+  [CPUHP_OFFLINE + 3]->teardown()
+  [CPUHP_OFFLINE + 2]                  -> skipped because teardown =3D=3D =
NULL
+  [CPUHP_OFFLINE + 1]->teardown()
+  [CPUHP_OFFLINE]
+
+A failed offline operation looks like this: ::
+
+  [CPUHP_ONLINE]
+  [CPUHP_ONLINE - 1]->teardown()       -> success
+  ...
+  [CPUHP_ONLINE - N]->teardown()       -> fail
+  [CPUHP_ONLINE - (N - 1)]->startup()
+  ...
+  [CPUHP_ONLINE - 1]->startup()
+  [CPUHP_ONLINE]
+
+Recursive failures cannot be handled sensibly. Look at the following
+example of a recursive fail due to a failed offline operation: ::
+
+  [CPUHP_ONLINE]
+  [CPUHP_ONLINE - 1]->teardown()       -> success
+  ...
+  [CPUHP_ONLINE - N]->teardown()       -> fail
+  [CPUHP_ONLINE - (N - 1)]->startup()  -> success
+  [CPUHP_ONLINE - (N - 2)]->startup()  -> fail
+
+The CPU hotplug state machine stops right here and does not try to go back
+down again because that would likely result in an endless loop: ::
+
+  [CPUHP_ONLINE - (N - 1)]->teardown() -> success
+  [CPUHP_ONLINE - N]->teardown()       -> fail
+  [CPUHP_ONLINE - (N - 1)]->startup()  -> success
+  [CPUHP_ONLINE - (N - 2)]->startup()  -> fail
+  [CPUHP_ONLINE - (N - 1)]->teardown() -> success
+  [CPUHP_ONLINE - N]->teardown()       -> fail
+
+Lather, rinse and repeat. In this case the CPU left in state: ::
+
+  [CPUHP_ONLINE - (N - 1)]
+
+which at least lets the system make progress and gives the user a chance to
+debug or even resolve the situation.
+
+Allocating a state
+------------------
+
+There are two ways to allocate a CPU hotplug state:
+
+* Static allocation
+
+  Static allocation has to be used when the subsystem or driver has
+  ordering requirements versus other CPU hotplug states. E.g. the PERF core
+  startup callback has to be invoked before the PERF driver startup
+  callbacks during a CPU online operation. During a CPU offline operation
+  the driver teardown callbacks have to be invoked before the core teardown
+  callback. The statically allocated states are described by constants in
+  the cpuhp_state enum which can be found in include/linux/cpuhotplug.h.
+
+  Insert the state into the enum at the proper place so the ordering
+  requirements are fulfilled. The state constant has to be used for state
+  setup and removal.
+
+  Static allocation is also required when the state callbacks are not set
+  up at runtime and are part of the initializer of the CPU hotplug state
+  array in kernel/cpu.c.
+
+* Dynamic allocation
+
+  When there are no ordering requirements for the state callbacks then
+  dynamic allocation is the preferred method. The state number is allocated
+  by the setup function and returned to the caller on success.
+
+  Only the PREPARE and ONLINE sections provide a dynamic allocation
+  range. The STARTING section does not as most of the callbacks in that
+  section have explicit ordering requirements.
+
+Setup of a CPU hotplug state
+----------------------------
+
+The core code provides the following functions to setup a state:
+
+* cpuhp_setup_state(state, name, startup, teardown)
+* cpuhp_setup_state_nocalls(state, name, startup, teardown)
+* cpuhp_setup_state_cpuslocked(state, name, startup, teardown)
+* cpuhp_setup_state_nocalls_cpuslocked(state, name, startup, teardown)
+
+For cases where a driver or a subsystem has multiple instances and the same
+CPU hotplug state callbacks need to be invoked for each instance, the CPU
+hotplug core provides multi-instance support. The advantage over driver
+specific instance lists is that the instance related functions are fully
+serialized against CPU hotplug operations and provide the automatic
+invocations of the state callbacks on add and removal. To set up such a
+multi-instance state the following function is available:
+
+* cpuhp_setup_state_multi(state, name, startup, teardown)
+
+The @state argument is either a statically allocated state or one of the
+constants for dynamically allocated states - CPUHP_PREPARE_DYN,
+CPUHP_ONLINE_DYN - depending on the state section (PREPARE, ONLINE) for
+which a dynamic state should be allocated.
+
+The @name argument is used for sysfs output and for instrumentation. The
+naming convention is "subsys:mode" or "subsys/driver:mode",
+e.g. "perf:mode" or "perf/x86:mode". The common mode names:
+
+=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+prepare  For states in the PREPAREsection
+
+dead     For states in the PREPARE section which do not provide
+         a startup callback
+
+starting For states in the STARTING section
+
+dying    For states in the STARTING section which do not provide
+         a startup callback
+
+online   For states in the ONLINE section
+
+offline  For states in the ONLINE section which do not provide
+         a startup callback
+=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+As the @name argument is only used for sysfs and instrumentation other mode
+descriptors can be used as well if they describe the nature of the state
+better than the common ones.
+
+Examples for @name arguments: "perf/online", "perf/x86:prepare",
+"RCU/tree:dying", "sched/waitempty"
+
+The @startup argument is a function pointer to the callback which should be
+invoked during a CPU online operation. If the usage site does not require a
+startup callback set the pointer to NULL.
+
+The @teardown argument is a function pointer to the callback which should
+be invoked during a CPU offline operation. If the usage site does not
+require a teardown callback set the pointer to NULL.
+
+The functions differ in the way how the installed callbacks are treated:
+
+  * cpuhp_setup_state_nocalls(), cpuhp_setup_state_nocalls_cpuslocked()
+    and cpuhp_setup_state_multi() only install the callbacks
+
+  * cpuhp_setup_state() and cpuhp_setup_state_cpuslocked() install the
+    callbacks and invoke the @startup callback (if not NULL) for all online
+    CPUs which have currently a state greater than the newly installed
+    state. Depending on the state section the callback is either invoked on
+    the current CPU (PREPARE section) or on each online CPU (ONLINE
+    section) in the context of the CPU's hotplug thread.
+
+    If a callback fails for CPU N then the teardown callback for CPU
+    0 .. N-1 is invoked to rollback the operation. The state setup fails,
+    the callbacks for the state are not installed and in case of dynamic
+    allocation the allocated state is freed.
+
+The state setup and the callback invocations are serialized against CPU
+hotplug operations. If the setup function has to be called from a CPU
+hotplug read locked region, then the _cpuslocked() variants have to be
+used. These functions cannot be used from within CPU hotplug callbacks.
+
+The function return values:
+  =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+  0        Statically allocated state was successfully set up
+
+  >0       Dynamically allocated state was successfully set up.
+
+           The returned number is the state number which was allocated. If
+           the state callbacks have to be removed later, e.g. module
+           removal, then this number has to be saved by the caller and used
+           as @state argument for the state remove function. For
+           multi-instance states the dynamically allocated state number is
+           also required as @state argument for the instance add/remove
+           operations.
+
+  <0	   Operation failed
+  =3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
+Removal of a CPU hotplug state
+------------------------------
+
+To remove a previously set up state, the following functions are provided:
+
+* cpuhp_remove_state(state)
+* cpuhp_remove_state_nocalls(state)
+* cpuhp_remove_state_nocalls_cpuslocked(state)
+* cpuhp_remove_multi_state(state)
+
+The @state argument is either a statically allocated state or the state
+number which was allocated in the dynamic range by cpuhp_setup_state*(). If
+the state is in the dynamic range, then the state number is freed and
+available for dynamic allocation again.
+
+The functions differ in the way how the installed callbacks are treated:
+
+  * cpuhp_remove_state_nocalls(), cpuhp_remove_state_nocalls_cpuslocked()
+    and cpuhp_remove_multi_state() only remove the callbacks.
+
+  * cpuhp_remove_state() removes the callbacks and invokes the teardown
+    callback (if not NULL) for all online CPUs which have currently a state
+    greater than the removed state. Depending on the state section the
+    callback is either invoked on the current CPU (PREPARE section) or on
+    each online CPU (ONLINE section) in the context of the CPU's hotplug
+    thread.
+
+    In order to complete the removal, the teardown callback should not fai=
l.
+
+The state removal and the callback invocations are serialized against CPU
+hotplug operations. If the remove function has to be called from a CPU
+hotplug read locked region, then the _cpuslocked() variants have to be
+used. These functions cannot be used from within CPU hotplug callbacks.
+
+If a multi-instance state is removed then the caller has to remove all
+instances first.
+
+Multi-Instance state instance management
+----------------------------------------
+
+Once the multi-instance state is set up, instances can be added to the
+state:
+
+  * cpuhp_state_add_instance(state, node)
+  * cpuhp_state_add_instance_nocalls(state, node)
+
+The @state argument is either a statically allocated state or the state
+number which was allocated in the dynamic range by cpuhp_setup_state_multi=
().
+
+The @node argument is a pointer to a hlist_node which is embedded in the
+instance's data structure. The pointer is handed to the multi-instance
+state callbacks and can be used by the callback to retrieve the instance
+via container_of().
+
+The functions differ in the way how the installed callbacks are treated:
+
+  * cpuhp_state_add_instance_nocalls() and only adds the instance to the
+    multi-instance state's node list.
+
+  * cpuhp_state_add_instance() adds the instance and invokes the startup
+    callback (if not NULL) associated with @state for all online CPUs which
+    have currently a state greater than @state. The callback is only
+    invoked for the to be added instance. Depending on the state section
+    the callback is either invoked on the current CPU (PREPARE section) or
+    on each online CPU (ONLINE section) in the context of the CPU's hotplug
+    thread.
+
+    If a callback fails for CPU N then the teardown callback for CPU
+    0 .. N-1 is invoked to rollback the operation, the function fails and
+    the instance is not added to the node list of the multi-instance state.
+
+To remove an instance from the state's node list these functions are
+available:
+
+  * cpuhp_state_remove_instance(state, node)
+  * cpuhp_state_remove_instance_nocalls(state, node)
+
+The arguments are the same as for the the cpuhp_state_add_instance*()
+variants above.
+
+The functions differ in the way how the installed callbacks are treated:
+
+  * cpuhp_state_remove_instance_nocalls() only removes the instance from t=
he
+    state's node list.
+
+  * cpuhp_state_remove_instance() removes the instance and invokes the
+    teardown callback (if not NULL) associated with @state for all online
+    CPUs which have currently a state greater than @state.  The callback is
+    only invoked for the to be removed instance.  Depending on the state
+    section the callback is either invoked on the current CPU (PREPARE
+    section) or on each online CPU (ONLINE section) in the context of the
+    CPU's hotplug thread.
+
+    In order to complete the removal, the teardown callback should not fai=
l.
+
+The node list add/remove operations and the callback invocations are
+serialized against CPU hotplug operations. These functions cannot be used
+from within CPU hotplug callbacks and CPU hotplug read locked regions.
+
+Examples
+--------
+
+Setup and teardown a statically allocated state in the STARTING section for
+notifications on online and offline operations: ::
+
+   ret =3D cpuhp_setup_state(CPUHP_SUBSYS_STARTING, "subsys:starting", sub=
sys_cpu_starting, subsys_cpu_dying);
+   if (ret < 0)
+        return ret;
+   ....
+   cpuhp_remove_state(CPUHP_SUBSYS_STARTING);
+
+Setup and teardown a dynamically allocated state in the ONLINE section
+for notifications on offline operations: ::
+
+   state =3D cpuhp_setup_state(CPUHP_ONLINE_DYN, "subsys:offline", NULL, s=
ubsys_cpu_offline);
+   if (state < 0)
+       return state;
+   ....
+   cpuhp_remove_state(state);
+
+Setup and teardown a dynamically allocated state in the ONLINE section
+for notifications on online operations without invoking the callbacks: ::
+
+   state =3D cpuhp_setup_state_nocalls(CPUHP_ONLINE_DYN, "subsys:online", =
subsys_cpi_online, NULL);
+   if (state < 0)
+       return state;
+   ....
+   cpuhp_remove_state_nocalls(state);
+
+Setup, use and teardown a dynamically allocated multi-instance state in the
+ONLINE section for notifications on online and offline operation: ::
+
+   state =3D cpuhp_setup_state_multi(CPUHP_ONLINE_DYN, "subsys:online", su=
bsys_cpu_online, subsys_cpu_offline);
+   if (state < 0)
+       return state;
+   ....
+   ret =3D cpuhp_state_add_instance(state, &inst1->node);
+   if (ret)
+        return ret;
+   ....
+   ret =3D cpuhp_state_add_instance(state, &inst2->node);
+   if (ret)
+        return ret;
+   ....
+   cpuhp_remove_instance(state, &inst1->node);
+   ....
+   cpuhp_remove_instance(state, &inst2->node);
+   ....
+   remove_multi_state(state);
+
=20
 Testing of hotplug states
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -22,8 +22,42 @@
  *              AP_ACTIVE			AP_ACTIVE
  */
=20
+/*
+ * CPU hotplug states. The state machine invokes the installed state
+ * startup callbacks sequentially from CPUHP_OFFLINE + 1 to CPUHP_ONLINE
+ * during a CPU online operation. During a CPU offline operation the
+ * installed teardown callbacks are invoked in the reverse order from
+ * CPU_ONLINE - 1 down to CPUHP_OFFLINE.
+ *
+ * The state space has three sections: PREPARE, STARTING and ONLINE.
+ *
+ * PREPARE: The callbacks are invoked on a control CPU before the
+ * hotplugged CPU is started up or after the hotplugged CPU has died.
+ *
+ * STARTING: The callbacks are invoked on the hotplugged CPU from the low =
level
+ * hotplug startup/teardown code with interrupts disabled.
+ *
+ * ONLINE: The callbacks are invoked on the hotplugged CPU from the per CPU
+ * hotplug thread with interrupts and preemption enabled.
+ *
+ * Adding explicit states to this enum is only necessary when:
+ *
+ * 1) The state is within the STARTING section
+ *
+ * 2) The state has ordering constraints vs. other states in the
+ *    same section.
+ *
+ * If neither #1 nor #2 apply, please use the dynamic state space when
+ * setting up a state by using CPUHP_PREPARE_DYN or CPUHP_PREPARE_ONLINE
+ * for the @state argument of the setup function.
+ *
+ * See Documentation/core-api/cpu_hotplug.rst for further information and
+ * examples.
+ */
 enum cpuhp_state {
 	CPUHP_INVALID =3D -1,
+
+	/* PREPARE section invoked on a control CPU */
 	CPUHP_OFFLINE =3D 0,
 	CPUHP_CREATE_THREADS,
 	CPUHP_PERF_PREPARE,
@@ -93,6 +127,11 @@ enum cpuhp_state {
 	CPUHP_BP_PREPARE_DYN,
 	CPUHP_BP_PREPARE_DYN_END		=3D CPUHP_BP_PREPARE_DYN + 20,
 	CPUHP_BRINGUP_CPU,
+
+	/*
+	 * STARTING section invoked on the hotplugged CPU in low level
+	 * bringup and teardown code.
+	 */
 	CPUHP_AP_IDLE_DEAD,
 	CPUHP_AP_OFFLINE,
 	CPUHP_AP_SCHED_STARTING,
@@ -153,6 +192,8 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
 	CPUHP_TEARDOWN_CPU,
+
+	/* Online section invoked on the hotplugged CPU from the hotplug thread */
 	CPUHP_AP_ONLINE_IDLE,
 	CPUHP_AP_SCHED_WAIT_EMPTY,
 	CPUHP_AP_SMPBOOT_THREADS,
@@ -214,14 +255,15 @@ int __cpuhp_setup_state_cpuslocked(enum
 				   int (*teardown)(unsigned int cpu),
 				   bool multi_instance);
 /**
- * cpuhp_setup_state - Setup hotplug state callbacks with calling the call=
backs
+ * cpuhp_setup_state - Setup hotplug state callbacks with calling the star=
tup
+ *                     callback
  * @state:	The state for which the calls are installed
  * @name:	Name of the callback (will be used in debug output)
- * @startup:	startup callback function
- * @teardown:	teardown callback function
+ * @startup:	startup callback function or NULL if not required
+ * @teardown:	teardown callback function or NULL if not required
  *
  * Installs the callback functions and invokes the startup callback on
- * the present cpus which have already reached the @state.
+ * the online cpus which have already reached the @state.
  */
 static inline int cpuhp_setup_state(enum cpuhp_state state,
 				    const char *name,
@@ -231,6 +273,18 @@ static inline int cpuhp_setup_state(enum
 	return __cpuhp_setup_state(state, name, true, startup, teardown, false);
 }
=20
+/**
+ * cpuhp_setup_state_cpuslocked - Setup hotplug state callbacks with calli=
ng
+ *				  startup callback from a cpus_read_lock()
+ *				  held region
+ * @state:	The state for which the calls are installed
+ * @name:	Name of the callback (will be used in debug output)
+ * @startup:	startup callback function or NULL if not required
+ * @teardown:	teardown callback function or NULL if not required
+ *
+ * Same as cpuhp_setup_state() except that it must be invoked from within a
+ * cpus_read_lock() held region.
+ */
 static inline int cpuhp_setup_state_cpuslocked(enum cpuhp_state state,
 					       const char *name,
 					       int (*startup)(unsigned int cpu),
@@ -242,14 +296,14 @@ static inline int cpuhp_setup_state_cpus
=20
 /**
  * cpuhp_setup_state_nocalls - Setup hotplug state callbacks without calli=
ng the
- *			       callbacks
+ *			       startup callback
  * @state:	The state for which the calls are installed
  * @name:	Name of the callback.
- * @startup:	startup callback function
- * @teardown:	teardown callback function
+ * @startup:	startup callback function or NULL if not required
+ * @teardown:	teardown callback function or NULL if not required
  *
- * Same as @cpuhp_setup_state except that no calls are executed are invoked
- * during installation of this callback. NOP if SMP=3Dn or HOTPLUG_CPU=3Dn.
+ * Same as cpuhp_setup_state() except that the startup callback is not
+ * invoked during installation. NOP if SMP=3Dn or HOTPLUG_CPU=3Dn.
  */
 static inline int cpuhp_setup_state_nocalls(enum cpuhp_state state,
 					    const char *name,
@@ -260,6 +314,19 @@ static inline int cpuhp_setup_state_noca
 				   false);
 }
=20
+/**
+ * cpuhp_setup_state_nocalls_cpuslocked - Setup hotplug state callbacks wi=
thout
+ *					  invoking the @bringup callback from
+ *					  a cpus_read_lock() held region
+ *			       callbacks
+ * @state:	The state for which the calls are installed
+ * @name:	Name of the callback.
+ * @startup:	startup callback function or NULL if not required
+ * @teardown:	teardown callback function or NULL if not required
+ *
+ * Same as cpuhp_setup_state_nocalls() except that it must be invoked from
+ * within a cpus_read_lock() held region.
+ */
 static inline int cpuhp_setup_state_nocalls_cpuslocked(enum cpuhp_state st=
ate,
 						     const char *name,
 						     int (*startup)(unsigned int cpu),
@@ -273,13 +340,13 @@ static inline int cpuhp_setup_state_noca
  * cpuhp_setup_state_multi - Add callbacks for multi state
  * @state:	The state for which the calls are installed
  * @name:	Name of the callback.
- * @startup:	startup callback function
- * @teardown:	teardown callback function
+ * @startup:	startup callback function or NULL if not required
+ * @teardown:	teardown callback function or NULL if not required
  *
  * Sets the internal multi_instance flag and prepares a state to work as a=
 multi
  * instance callback. No callbacks are invoked at this point. The callback=
s are
  * invoked once an instance for this state are registered via
- * @cpuhp_state_add_instance or @cpuhp_state_add_instance_nocalls.
+ * cpuhp_state_add_instance() or cpuhp_state_add_instance_nocalls()
  */
 static inline int cpuhp_setup_state_multi(enum cpuhp_state state,
 					  const char *name,
@@ -305,8 +372,8 @@ int __cpuhp_state_add_instance_cpuslocke
  * @node:	The node for this individual state.
  *
  * Installs the instance for the @state and invokes the startup callback on
- * the present cpus which have already reached the @state. The @state must=
 have
- * been earlier marked as multi-instance by @cpuhp_setup_state_multi.
+ * the online cpus which have already reached the @state. The @state must =
have
+ * been earlier marked as multi-instance by cpuhp_setup_state_multi().
  */
 static inline int cpuhp_state_add_instance(enum cpuhp_state state,
 					   struct hlist_node *node)
@@ -321,7 +388,8 @@ static inline int cpuhp_state_add_instan
  * @node:	The node for this individual state.
  *
  * Installs the instance for the @state The @state must have been earlier
- * marked as multi-instance by @cpuhp_setup_state_multi.
+ * marked as multi-instance by cpuhp_setup_state_multi. NOP if SMP=3Dn or
+ * HOTPLUG_CPU=3Dn.
  */
 static inline int cpuhp_state_add_instance_nocalls(enum cpuhp_state state,
 						   struct hlist_node *node)
@@ -329,6 +397,17 @@ static inline int cpuhp_state_add_instan
 	return __cpuhp_state_add_instance(state, node, false);
 }
=20
+/**
+ * cpuhp_state_add_instance_nocalls_cpuslocked - Add an instance for a sta=
te
+ *						 without invoking the startup
+ *						 callback from a cpus_read_lock()
+ *						 held region.
+ * @state:	The state for which the instance is installed
+ * @node:	The node for this individual state.
+ *
+ * Same as cpuhp_state_add_instance_nocalls() except that it must be
+ * invoked from within a cpus_read_lock() held region.
+ */
 static inline int
 cpuhp_state_add_instance_nocalls_cpuslocked(enum cpuhp_state state,
 					    struct hlist_node *node)
@@ -353,7 +432,7 @@ static inline void cpuhp_remove_state(en
=20
 /**
  * cpuhp_remove_state_nocalls - Remove hotplug state callbacks without inv=
oking
- *				teardown
+ *				the teardown callback
  * @state:	The state for which the calls are removed
  */
 static inline void cpuhp_remove_state_nocalls(enum cpuhp_state state)
@@ -361,6 +440,14 @@ static inline void cpuhp_remove_state_no
 	__cpuhp_remove_state(state, false);
 }
=20
+/**
+ * cpuhp_remove_state_nocalls_cpuslocked - Remove hotplug state callbacks =
without invoking
+ *					   teardown from a cpus_read_lock() held region.
+ * @state:	The state for which the calls are removed
+ *
+ * Same as cpuhp_remove_state nocalls() except that it must be invoked
+ * from within a cpus_read_lock() held region.
+ */
 static inline void cpuhp_remove_state_nocalls_cpuslocked(enum cpuhp_state =
state)
 {
 	__cpuhp_remove_state_cpuslocked(state, false);
@@ -389,7 +476,7 @@ int __cpuhp_state_remove_instance(enum c
  * @node:	The node for this individual state.
  *
  * Removes the instance and invokes the teardown callback on the present c=
pus
- * which have already reached the @state.
+ * which have already reached @state.
  */
 static inline int cpuhp_state_remove_instance(enum cpuhp_state state,
 					      struct hlist_node *node)
