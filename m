Return-Path: <linux-fsdevel+bounces-21017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9448FC568
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 10:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD99228202D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 08:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5066F18F2F1;
	Wed,  5 Jun 2024 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kBP7dyDj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mybaqr2z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134741922FC;
	Wed,  5 Jun 2024 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574956; cv=none; b=SLb7Cs22SauIMRwZhySyvUZtqXcupKTUis4kii/uCMrJMcguzqsa8Iytubys/eBKAKujKybAObF0JXyO5P9yqcyLYjyAJjh6h3/1F3cM2qQUIlAGgGAHjPLH+W1nBEb8yW6+LqC3PBWNq2xsWzfcCGunAZBJKwm6Yf4/L1ocpp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574956; c=relaxed/simple;
	bh=FT4Y4OJ4id8HqamjL00KdzNK9nXAWzR+KO67PsOMQTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ECtB3edDssQ9USsa/5MNFSrHZfFfLgmjeI0XJhMpcwWc/19AsQ355HKZwBl5muSkfMqhhbAf6mQtgL4ALdPSX70nFz4170utWX53izznXi1hS6cUJA/EvPJFcIMvaN9uRgYaOo3Vy9HIewBAm8xfSmAjKb+Xgnm2q9wa6x/yEbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kBP7dyDj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mybaqr2z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717574953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=avePAaCaM858ft+0llwxfEjs24knvY5E6LjmaAAd0dA=;
	b=kBP7dyDjbHyI3PlBC95D/ONIO947LhKAog4APwoYaoFvDcKJyCOJTZaV2zJbK8Doyvfh1I
	9C8MswjNB6XJCb76ujpBq+RPuZcpRZmrkVth/jLkqe229PL4Jf1j8WrXxDARhhMO+R17v9
	NPUUfJYmqKY5zodrrSoQt5ANutGUnXvtQ960RqSPXpSkhq4NMHxEBkJiVuLjHCd9h/zyfE
	QpIhUr2W2AdjgkYqQfeZ6fOLA7XIZZ3hS5pspeFqTG9gI+LoTZACqgMk3+bBJNxarJS0QF
	3WqKRjoor9Xr0FfuC0UOom6LpURA88jFYkXiLdR2kJ8Kj+8iMhPAvWtzUntN2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717574953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=avePAaCaM858ft+0llwxfEjs24knvY5E6LjmaAAd0dA=;
	b=mybaqr2zeW9qQLCdzbaTCQ9ce8xRm0i+inlSYiD3deJn0tYIFOWHtaS+9xQ1qPeNphG6Nh
	0WZtXeK5h6jY4rCw==
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Sreenath Vijayan
 <sreenath.vijayan@sony.com>, Shimoyashiki Taichi
 <taichi.shimoyashiki@sony.com>, Tomas Mudrunka <tomas.mudrunka@gmail.com>,
 linux-doc@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, "Borislav Petkov (AMD)"
 <bp@alien8.de>, Xiongwei Song <xiongwei.song@windriver.com>
Subject: Re: [PATCH printk v2 00/18] add threaded printing + the rest
In-Reply-To: <aqkcpca4vgadxc3yzcu74xwq3grslj5m43f3eb5fcs23yo2gy4@gcsnqcts5tos>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <aqkcpca4vgadxc3yzcu74xwq3grslj5m43f3eb5fcs23yo2gy4@gcsnqcts5tos>
Date: Wed, 05 Jun 2024 10:15:12 +0206
Message-ID: <875xunx13r.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Juri,

On 2024-06-04, Juri Lelli <juri.lelli@redhat.com> wrote:
> Our QE reported something like the following while testing the latest
> rt-devel branch (I then could reproduce with this set applied on top of
> linux-next).
>
> ---
> ... kernel: INFO: task khugepaged:351 blocked for more than 1 seconds.
> ... kernel:       Not tainted 6.9.0-thrdprintk+ #3
> ... kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> ... kernel: task:khugepaged      state:D stack:0     pid:351   tgid:351   ppid:2      flags:0x00004000
> ... kernel: Call Trace:
> ... kernel:  <TASK>
> ... kernel:  __schedule+0x2bd/0x7f0
> ... kernel:  ? __lock_release.isra.0+0x5e/0x170
> ... kernel:  schedule+0x3d/0x100
> ... kernel:  schedule_timeout+0x1ca/0x1f0
> ... kernel:  ? mark_held_locks+0x49/0x80
> ... kernel:  ? _raw_spin_unlock_irq+0x24/0x50
> ... kernel:  ? lockdep_hardirqs_on+0x77/0x100
> ... kernel:  __wait_for_common+0xb7/0x220
> ... kernel:  ? __pfx_schedule_timeout+0x10/0x10
> ... kernel:  __flush_work+0x70/0x90
> ... kernel:  ? __pfx_wq_barrier_func+0x10/0x10
> ... kernel:  __lru_add_drain_all+0x179/0x210
> ... kernel:  khugepaged+0x73/0x200
> ... kernel:  ? lockdep_hardirqs_on+0x77/0x100
> ... kernel:  ? _raw_spin_unlock_irqrestore+0x38/0x60
> ... kernel:  ? __pfx_khugepaged+0x10/0x10
> ... kernel:  kthread+0xec/0x120
> ... kernel:  ? __pfx_kthread+0x10/0x10
> ... kernel:  ret_from_fork+0x2d/0x50
> ... kernel:  ? __pfx_kthread+0x10/0x10
> ... kernel:  ret_from_fork_asm+0x1a/0x30
> ... kernel:  </TASK>
> ... kernel:
> ...         Showing all locks held in the system:
> ... kernel: 1 lock held by khungtaskd/345:
> ... kernel:  #0: ffffffff8cbff1c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x32/0x1d0
> ... kernel: BUG: using smp_processor_id() in preemptible [00000000] code: khungtaskd/345
> ... kernel: caller is nbcon_get_cpu_emergency_nesting+0x25/0x40
> ... kernel: CPU: 30 PID: 345 Comm: khungtaskd Kdump: loaded Not tainted 6.9.0-thrdprintk+ #3
> ... kernel: Hardware name: Dell Inc. PowerEdge R740/04FC42, BIOS 2.10.2 02/24/2021
> ... kernel: Call Trace:
> ... kernel:  <TASK>
> ... kernel:  dump_stack_lvl+0x7f/0xa0
> ... kernel:  check_preemption_disabled+0xbf/0xe0
> ... kernel:  nbcon_get_cpu_emergency_nesting+0x25/0x40
> ... kernel:  nbcon_cpu_emergency_flush+0xa/0x60
> ... kernel:  debug_show_all_locks+0x9d/0x1d0
> ... kernel:  check_hung_uninterruptible_tasks+0x4f0/0x540
> ... kernel:  ? check_hung_uninterruptible_tasks+0x185/0x540
> ... kernel:  ? __pfx_watchdog+0x10/0x10
> ... kernel:  watchdog+0x99/0xa0
> ... kernel:  kthread+0xec/0x120
> ... kernel:  ? __pfx_kthread+0x10/0x10
> ... kernel:  ret_from_fork+0x2d/0x50
> ... kernel:  ? __pfx_kthread+0x10/0x10
> ... kernel:  ret_from_fork_asm+0x1a/0x30
> ... kernel:  </TASK>
> ---
>
> It requires DEBUG_PREEMPT and LOCKDEP enabled, sched_rt_runtime_us = -1
> and a while(1) loop running at FIFO for some time (I also set sysctl
> kernel.hung_task_timeout_secs=1 to speed up reproduction).
>
> Looks like check_hung_uninterruptible_tasks() requires some care as you
> did already in linux-next for panic, rcu and lockdep ("Make emergency
> sections ...")?

Yes, that probably is a good candidate for emergency mode.

However, your report is also identifying a real issue:
nbcon_cpu_emergency_flush() was implemented to be callable from
non-emergency contexts (in which case it should do nothing). However, in
order to check if it is an emergency context, migration needs to be
disabled.

Perhaps the below change can be made for v2 of this series?

John

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 4b9645e7ed70..eeaf8465f492 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1581,8 +1581,19 @@ void nbcon_cpu_emergency_exit(void)
  */
 void nbcon_cpu_emergency_flush(void)
 {
+	bool is_emergency;
+
+	/*
+	 * If the current context is not an emergency context, preemption
+	 * might be enabled. To be sure, disable preemption when checking
+	 * if this is an emergency context.
+	 */
+	preempt_disable();
+	is_emergency = (*nbcon_get_cpu_emergency_nesting() != 0);
+	preempt_enable();
+
 	/* The explicit flush is needed only in the emergency context. */
-	if (*(nbcon_get_cpu_emergency_nesting()) == 0)
+	if (!is_emergency)
 		return;
 
 	nbcon_atomic_flush_pending();

