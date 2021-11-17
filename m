Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052B0454E51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 21:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhKQUOc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 15:14:32 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50250 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231429AbhKQUOb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 15:14:31 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5FAAC1F953;
        Wed, 17 Nov 2021 20:11:32 +0000 (UTC)
Date:   Wed, 17 Nov 2021 20:11:32 +0000
From:   Eric Wong <e@80x24.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Roman Penyaev <rpenyaev@suse.de>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC] How to fix eventpoll rwlock based priority inversion on
 PREEMPT_RT?
Message-ID: <20211117201132.M259904@dcvr>
References: <20211116140252.GA348770@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211116140252.GA348770@lothringen>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> wrote:
> Hi,
> 
> I'm iterating again on this topic, this time with the author of
> the patch Cc'ed.
> 
> The following commit:
> 
>     a218cc491420 (epoll: use rwlock in order to reduce ep_poll
>                   callback() contention)
> 
> has changed the ep->lock into an rwlock. This can cause priority inversion
> on PREEMPT_RT. Here is an example:
> 
> 
> 1) High priority task A waits for events on epoll_wait(), nothing shows up so
>    it goes to sleep for new events in the ep_poll() loop.
> 
> 2) Lower prio task B brings new events in ep_poll_callback(), waking up A
>    while still holding read_lock(ep->lock)
> 
> 3) Task A wakes up immediately, tries to grab write_lock(ep->lock) but it has
>    to wait for task B to release read_lock(ep->lock). Unfortunately there is
>    no priority inheritance when write_lock() is called on an rwlock that is
>    already read_lock'ed. So back to task B that may even be preempted by
>    yet another task before releasing read_lock(ep->lock).
> 
> 
> Now how to solve this? Several possibilities:
> 
> == Delay the wake up after releasing the read_lock()? ==
> 
> That solves part of the problem only. If another event comes up
> concurrently we are back to the original issue.
> 
> == Make rwlock more fair ? ==
> 
> Currently read_lock() only acquires the rtmutex if the lock is already
> write-held (or write_lock() is waiting to acquire). So if read_lock() happens
> after write_lock(), fairness is observed but if write_lock() happens after
> read_lock(), priority inheritance doesn't happen.
> 
> I think there has been attempts to solve this by the past but some issues
> arised (don't know the exact details, comments on rwbase_rt.c bring some clues).
> 
> == Convert the rwlock to RCU ? ==
> 
> Traditionally, we try to convert rwlocks bringing issues to RCU. I'm not sure the
> situation fits here because the rwlock is used the other way around:
> the epoll consumer does the write_lock() and the producers do read_lock(). Then
> concurrent producers use ad-hoc concurrent list add (see list_add_tail_lockless)
> to handle racy modifications.
> 
> There are also list modifications on both side. There are added from the
> producers and read and deleted (even re-added sometimes) on the consumer side.
> 
> Perhaps RCU could be used with keeping locking on the consumer side...

+CC linux-fsdevel and Mathieu Desnoyers

I proposed using wfcqueue many years ago, but ran out of
time/hardware/funding to work on it:

  https://yhbt.net/lore/lkml/20130401183118.GA9968@dcvr.yhbt.net/

wfcqueue is used internally by Userspace-RCU, but wfcqueue
itself doesn't rely on RCU.  I'm not sure if wfcqueue helps
PREEMPT_RT, but Mathieu + Paul might.

> == Convert to llist ? ==
> 
> It's a possibility but some operations like single element deletion may be
> costly because only llist_add() and llist_del_all() are atomic on llist.
> !CONFIG_PREEMPT_RT might not be happy about it.
> 
> == Consider epoll not PREEMPT_RT friendly? ==
> 
> A last resort is to simply consider epoll is not RT-friendly and suggest
> using more simple alternatives like poll()....
> 
> Any thoughts?
