Return-Path: <linux-fsdevel+bounces-27438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07A896188E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 279FDB22BB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7991A18661B;
	Tue, 27 Aug 2024 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP7+ifKU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B32E62B;
	Tue, 27 Aug 2024 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724790872; cv=none; b=P6uE5LUf9QKV9ZdEXMq+gBCYtUm9z0GxRyIgfN0ZhWp7vfO4izJ6XuH33A9j9GLcjDE/2e210bRx6ZkAM/vz7wTUAabVQBa9HD/nm2OO1xJwAOMiGoZV0pd0QrAQDvJ5+XbsZimh/JaD9RgA3UFpf8hQbF/hgfoZmsAb82cen9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724790872; c=relaxed/simple;
	bh=nL656klfj72UXKbQ1kigvDKpTewYtq848tbr531Sjmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyeHWt5aZGOgIu2pMJJQEpksMwtL0Vehy5bTrpckj+U25qejgPZfjKFK4UuugQ28UlmD50agmDKgE4phky/uhUlrZ4gxmzsg8jjpll+qVGNeYlp2pFVGvW/INGHrnfkgQ1Lmh2d8rg+9FkW1eflv+cuV9zQjG1sxgopJZC1Gt5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP7+ifKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B179C32786;
	Tue, 27 Aug 2024 20:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724790872;
	bh=nL656klfj72UXKbQ1kigvDKpTewYtq848tbr531Sjmk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KP7+ifKUCF8iQyJ8eaBhwQECY0WZ0nZRPn9JkFS1XxNylDj1iIYO9UK5fESDvGhyh
	 NXkDwKXamGLHw1SdjNPUyc/zl3wwbM9Z/rt07zbBqZlMuCBEfOoB/CDJ2FHG25ED5y
	 3bsj5VYRVLBCvvStc/dzDnIYy2z1CBYNIEfX7S9bk8+hCBv8cS4kXOY8sCSxO2aNIa
	 qq7maIPVx/EGmVyuO/sBC/HiJ54ifx1KFsYlHVw639iEuYvHB54W5vLq4wqWsCc0lq
	 sbdCZfKYXOfqyS7vpfaVHWklAH/GspDI8gXF3OiPqIlWE8eaERW7wWM7biCQ8YZNJe
	 INYqtZSekkS7g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0E6DFCE11D3; Tue, 27 Aug 2024 13:34:32 -0700 (PDT)
Date: Tue, 27 Aug 2024 13:34:32 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jon Kohler <jon@nutanix.com>
Cc: "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>,
	"jack@suse.cz" <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Z qiang <qiang.zhang1211@gmail.com>
Subject: Re: SRCU hung task on 5.10.y on synchronize_srcu(&fsnotify_mark_srcu)
Message-ID: <95fbe7cc-8752-4e38-8c2e-5df5e544a3cc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1E829024-48BF-4647-A1DD-AC7E8BFA0FA2@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1E829024-48BF-4647-A1DD-AC7E8BFA0FA2@nutanix.com>

On Tue, Aug 27, 2024 at 08:01:27PM +0000, Jon Kohler wrote:
> Hey Paul, Lai, Josh, and the RCU list and Jan/FS list -
> Reaching out about a tricky hung task issue that I'm running into. I've
> got a virtualized Linux guest on top of a KVM based platform, running
> a 5.10.y based kernel. The issue we're running into is a hung task that
> *only* happens on shutdown/reboot of this particular VM once every 
> 20-50 times.
> 
> The signature of the hung task is always similar to the output below,
> where we appear to hang on the call to 
>     synchronize_srcu(&fsnotify_mark_srcu)

One thing to try would be to add trace_printk() or similar to the SRCU
readers, just in case someone was using srcu_read_lock_notrace() on
fsnotify_mark_srcu, which I see no trace of in current mainline.

Alternatively, if there is a version where this does not happen, try
bisecting.  Each bisection step would require something like 400-500
shutdown/reboots to prove the commit good.  (Obviously, the first failure
proves the commit bad, which for one-out-of-50 failures will take on
average about 35 shutdown/reboots.)

There could also be a bad SRCU backport from mainline, so please check
what SRCU backports you have in your 5.10.y stable release.  (Though
maybe Jack has already done this?)

							Thanx, Paul

> in fsnotify_connector_destroy_workfn / fsnotify_mark_destroy_workfn,
> where two kernel threads are both calling synchronize_srcu, then
> scheduling out in wait_for_completion, and completely going out to
> lunch for over 4 minutes. This then triggers the hung task timeout and
> things blow up.
> 
> We are running audit=1 for this system and are using an el8 based
> userspace.
> 
> I've flipped through the fs/notify code base for both 5.10 as well as
> upstream mainline to see if something jumped off the page, and I
> haven't yet spotted any particular suspect code from the caller side.
> 
> This hang appears to come up at the very end of the shutdown/reboot
> process, seemingly after the system starts to unwind through initrd.
> 
> What I'm working on now is adding some instrumentation to the dracut
> shutdown initrd scripts to see if I can how far we get down that path
> before the system fails to make forward progress, which may give some
> hints. TBD on that. I've also enabled lockdep with CONFIG_PROVE_RCU and
> a plethora of DEBUG options [2], and didn't get anything interesting.
> To be clear, we haven't seen lockdep spit out any complaints as of yet.
> 
> Reaching out to see if this sounds familar to anyone on the list, or if
> there are any particular areas of the RCU code base that might be
> suspect for this kind of issue. I'm happy to provide more information,
> as frankly, I'm quite stumped at the moment.
> 
> Thanks all,
> Jon
> 
> [1] panic trace
>     Normal shutdown process, then hangs on the following:
>     ...
>     dracut Warning: Killing all remaining processes
>     ...
>     INFO: task kworker/u20:7:1200701 blocked for more than 241 seconds.
>           Tainted: G           O      5.10.205-2.el8.x86_64 #1
>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>     task:kworker/u20:7   state:D stack:    0 pid:1200701 ppid:     2 flags:0x00004080
>     Workqueue: events_unbound fsnotify_connector_destroy_workfn
>     Call Trace:
>      __schedule+0x267/0x790
>      schedule+0x3c/0xb0
>      schedule_timeout+0x219/0x2b0
>      wait_for_completion+0x9e/0x100
>      __synchronize_srcu.part.24+0x83/0xb0
>      ? __bpf_trace_rcu_utilization+0x10/0x10
>      ? synchronize_srcu+0x5d/0xf0
>      fsnotify_connector_destroy_workfn+0x46/0x80
>      process_one_work+0x1fc/0x390
>      worker_thread+0x2d/0x3e0
>      ? process_one_work+0x390/0x390
>      kthread+0x114/0x130
>      ? kthread_park+0x80/0x80
>      ret_from_fork+0x1f/0x30
>     INFO: task kworker/u20:8:1287360 blocked for more than 241 seconds.
>           Tainted: G           O      5.10.205-2.el8.x86_64 #1
>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>     task:kworker/u20:8   state:D stack:    0 pid:1287360 ppid:     2 flags:0x00004080
>     Workqueue: events_unbound fsnotify_mark_destroy_workfn
>     Call Trace:
>      __schedule+0x267/0x790
>      schedule+0x3c/0xb0
>      schedule_timeout+0x219/0x2b0
>      ? add_timer+0x14a/0x200
>      wait_for_completion+0x9e/0x100
>      __synchronize_srcu.part.24+0x83/0xb0
>      ? __bpf_trace_rcu_utilization+0x10/0x10
>      fsnotify_mark_destroy_workfn+0x77/0xe0
>      process_one_work+0x1fc/0x390
>      ? process_one_work+0x390/0x390
>      worker_thread+0x2d/0x3e0
>      ? process_one_work+0x390/0x390
>      kthread+0x114/0x130
>      ? kthread_park+0x80/0x80
>      ret_from_fork+0x1f/0x30
>     Kernel panic - not syncing: hung_task: blocked tasks
>     CPU: 1 PID: 64 Comm: khungtaskd Kdump: loaded Tainted: G           O      5.10.205-2.el8.x86_64 #1
>     Hardware name: Red Hat KVM, BIOS 20230302.1.2662.el8 04/01/2014
>     Call Trace:
>      dump_stack+0x6d/0x8c
>      panic+0x114/0x2ea
>      watchdog.cold.8+0xb5/0xb5
>      ? hungtask_pm_notify+0x50/0x50
>      kthread+0x114/0x130
>      ? kthread_park+0x80/0x80
>      ret_from_fork+0x1f/0x30
> 
> [2] additional debugging config knobs turned up.
>     CONFIG_PROVE_LOCKING=y
>     CONFIG_LOCK_STAT=y
>     CONFIG_DEBUG_RT_MUTEXES=y
>     CONFIG_DEBUG_SPINLOCK=y
>     CONFIG_DEBUG_MUTEXES=y
>     CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
>     CONFIG_DEBUG_RWSEMS=y
>     CONFIG_DEBUG_LOCK_ALLOC=y
>     CONFIG_LOCKDEP=y
>     CONFIG_LOCKDEP_BITS=15
>     CONFIG_LOCKDEP_CHAINS_BITS=16
>     CONFIG_LOCKDEP_STACK_TRACE_BITS=19
>     CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
>     CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
>     CONFIG_DEBUG_SHIRQ=y
>     CONFIG_WQ_WATCHDOG=y
>     CONFIG_DEBUG_ATOMIC_SLEEP=y
>     CONFIG_DEBUG_LIST=y
>     CONFIG_DEBUG_PLIST=y
>     CONFIG_DEBUG_SG=y
>     CONFIG_DEBUG_NOTIFIERS=y
>     CONFIG_BUG_ON_DATA_CORRUPTION=y

