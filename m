Return-Path: <linux-fsdevel+bounces-50836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE8CAD00E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 12:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814C9188E5B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 10:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738202882B9;
	Fri,  6 Jun 2025 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EOamfUq9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6BD28640E;
	Fri,  6 Jun 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749207518; cv=none; b=mUXPZV43Tpc9T6gbyf5Z6dqrqkM5FWNpl5nG7xl976fBkpO8Hm9fPYVbgf00c4zrOZ/aiJpIxcv64hX/L+4sZ8WQPV7O5Xc970J+Dp65ueLDt5/Jo9moX8bYPaoO+RaXPU6BqnOsyu0kgO5+4j9Njxii8Hxuz7XtkTkTRUJbugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749207518; c=relaxed/simple;
	bh=LYpVHHosFbX5ljXejQMh7Q1YT6ct86HAqT1qXS08S78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MefTjg1SJ8MW5PPTlSpBF2T2WCe0kIoVqkJPlrbsagXiL0r2z8k50aKAqQ3nu3qerEPMoYeYdTmpeHvngzX0YqBq0G5QPaxZ4xrRcp9E67ZkQtgdsrCLWENMQKtSLTeOvif32Kb6+w14mO4SjI8pMSUmZZ9c54XDDHDm/kvqA2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EOamfUq9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YD1+ylMFInat6Pc9lNPvkwSZIdRwUAoj193DVNJsNXA=; b=EOamfUq93/o1xotEiiOyrAW2p5
	f5lmd9I1XUSjS79mosCme2DghBN/0yfRzLltug8SaofXP0vr3tOBS5N1ozQDuoLEwABZtUSCab/02
	vL++vfiB4kMlcZzmRSc0ofhiVHzpP0xT06C0HtMkArCzvirb3oCxsIRmyXvENL5GAe8VdFjLRR4Gn
	AAzaatqE6ayWF9jAVz3h5IbKTUWQhrksEYvO7hdswRiSUMh9WqrmMWDy6eDYn6ctoewETo0vweR5E
	bE4SvLcUe8yvFK7NbeiAn55t0KRco4LFTsP2qk1eQ3lf6ISxUBckZMtSMssUUWG4nvR4g8Z8eHDAt
	oejtMraQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNUmN-00000005F39-1T5y;
	Fri, 06 Jun 2025 10:58:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 951CE3005AF; Fri,  6 Jun 2025 12:58:30 +0200 (CEST)
Date: Fri, 6 Jun 2025 12:58:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Konstantin Khorenko <khorenko@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>,
	Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel@openvz.org
Subject: Re: [PATCH] locking: detect spin_lock_irq() call with disabled
 interrupts
Message-ID: <20250606105830.GZ39944@noisy.programming.kicks-ass.net>
References: <20250606095741.46775-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606095741.46775-1-ptikhomirov@virtuozzo.com>

On Fri, Jun 06, 2025 at 05:57:23PM +0800, Pavel Tikhomirov wrote:
> This is intended to easily detect irq spinlock self-deadlocks like:
> 
>   spin_lock_irq(A);
>   spin_lock_irq(B);
>   spin_unlock_irq(B);
>     IRQ {
>       spin_lock(A); <- deadlocks
>       spin_unlock(A);
>     }
>   spin_unlock_irq(A);
> 
> Recently we saw this kind of deadlock on our partner's node:
> 
> PID: 408      TASK: ffff8eee0870ca00  CPU: 36   COMMAND: "kworker/36:1H"
>  #0 [fffffe3861831e60] crash_nmi_callback at ffffffff97269e31
>  #1 [fffffe3861831e68] nmi_handle at ffffffff972300bb
>  #2 [fffffe3861831eb0] default_do_nmi at ffffffff97e9e000
>  #3 [fffffe3861831ed0] exc_nmi at ffffffff97e9e211
>  #4 [fffffe3861831ef0] end_repeat_nmi at ffffffff98001639
>     [exception RIP: native_queued_spin_lock_slowpath+638]
>     RIP: ffffffff97eb31ae  RSP: ffffb1c8cd2a4d40  RFLAGS: 00000046
>     RAX: 0000000000000000  RBX: ffff8f2dffb34780  RCX: 0000000000940000
>     RDX: 000000000000002a  RSI: 0000000000ac0000  RDI: ffff8eaed4eb81c0
>     RBP: ffff8eaed4eb81c0   R8: 0000000000000000   R9: ffff8f2dffaf3438
>     R10: 0000000000000000  R11: 0000000000000000  R12: 0000000000000000
>     R13: 0000000000000024  R14: 0000000000000000  R15: ffffd1c8bfb24b80
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> --- <NMI exception stack> ---
>  #5 [ffffb1c8cd2a4d40] native_queued_spin_lock_slowpath at ffffffff97eb31ae
>  #6 [ffffb1c8cd2a4d60] _raw_spin_lock_irqsave at ffffffff97eb2730
>  #7 [ffffb1c8cd2a4d70] __wake_up at ffffffff9737c02d
>  #8 [ffffb1c8cd2a4da0] sbitmap_queue_wake_up at ffffffff9786c74d
>  #9 [ffffb1c8cd2a4dc8] sbitmap_queue_clear at ffffffff9786cc97
> --- <IRQ stack> ---
>     [exception RIP: _raw_spin_unlock_irq+20]
>     RIP: ffffffff97eb2e84  RSP: ffffb1c8cd90fd18  RFLAGS: 00000283
>     RAX: 0000000000000001  RBX: ffff8eafb68efb40  RCX: 0000000000000001
>     RDX: 0000000000000008  RSI: 0000000000000061  RDI: ffff8eafb06c3c70
>     RBP: ffff8eee7af43000   R8: ffff8eaed4eb81c8   R9: ffff8eaed4eb81c8
>     R10: 0000000000000008  R11: 0000000000000008  R12: 0000000000000000
>     R13: ffff8eafb06c3bd0  R14: ffff8eafb06c3bc0  R15: ffff8eaed4eb81c0
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> 
> Luckily it was already fixed in mainstream by:
> commit b313a8c83551 ("block: Fix lockdep warning in blk_mq_mark_tag_wait")
> 
> Currently if we are unlucky we may miss such a deadlock on our testing
> system as it is racy and it depends on the specific interrupt handler
> appearing at the right place and at the right time. So this patch tries
> to detect the problem despite the absence of the interrupt.
> 
> If we see spin_lock_irq under interrupts already disabled we can assume
> that it has paired spin_unlock_irq which would reenable interrupts where
> they should not be reenabled. So we report a warning for it.
> 
> Same thing on spin_unlock_irq even if we were lucky and there was no
> deadlock let's report if interrupts were enabled.
> 
> Let's make this functionality catch one problem and then be disabled, to
> prevent from spamming kernel log with warnings. Also let's add sysctl
> kernel.debug_spin_lock_irq_with_disabled_interrupts to reenable it if
> needed. Also let's add a by default enabled configuration option
> DEBUG_SPINLOCK_IRQ_WITH_DISABLED_INTERRUPTS_BY_DEFAULT, in case we will
> need this on boot.
> 
> Yes Lockdep can detect that, if it sees both the interrupt stack and the
> regular stack where we can get into interrupt with spinlock held. But
> with this approach we can detect the problem even without ever getting
> into interrupt stack. And also this functionality seems to be more
> lightweight then Lockdep as it does not need to maintain lock dependency
> graph.

So why do we need DEBUG_SPINLOCK code, that's injected into every single
callsite, if lockdep can already detect this?



