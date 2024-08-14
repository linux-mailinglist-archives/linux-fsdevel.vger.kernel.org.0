Return-Path: <linux-fsdevel+bounces-25845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D536B9510E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582061F22F58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 00:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C7BEA4;
	Wed, 14 Aug 2024 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nvni09KB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C0D195;
	Wed, 14 Aug 2024 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723594218; cv=none; b=n/9fTj/uxK+kTqCdUIatVFwK37r3eR3vpBsJk6+VwBpYaGgCzs6VBF9swpe8geOHj7woSpsGG9bq0q4NarK2GXXdncviDvgrKJvCPWHwqfxPE6jDi+jWTdb0l1DFlIzkxaCvY4bEmX7Qzs9DPjTiZstu9VUlvBw5P1vdwUi+4qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723594218; c=relaxed/simple;
	bh=CgGiCU1U9xTQYDZRxZm7Un7VEpNMJSVzVM6bJDlOdxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsqehI4AjUTinGZqR4LddOZJOQ+UzwnHFwVGiYLIvrtdtC2QPoMrmbaLuXov8bb9IX88KbBh13BZA0QWKU4pKtMZtBFlP5NuWFYppgL6uMlSzMJIgM4mG5aWUIl0vNAWsGIAZMVqJvuAz9VFjrOX5quvEHAZQYpjbDJRw7NTEto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nvni09KB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95D2C32782;
	Wed, 14 Aug 2024 00:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723594217;
	bh=CgGiCU1U9xTQYDZRxZm7Un7VEpNMJSVzVM6bJDlOdxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nvni09KBGRfPgKM0VLV7+RkFXHKxWveneB40K/7YISiqq8MNws8kWwgwQs1zw5YKX
	 3TOKan99uX7wRudaxZN6twe2lAaS7QHxgQmu1F9qHXV1PF2uoAceqBpIHQSJuSCvEa
	 FoFqg7NUsDTM4krBHmtN/pcq+jI7Z9TlSN4IbSY/ZzM7p0p3GAIe4q42GgmcY1Vwsb
	 DeeWR0BNVGG+a965Kmwx4ZIoOBF+/k1+Wmud6I9png+Rkb7g9qRVa2myEGM2Vw7vbv
	 LSwh+xVmyXwczJTlnlfpvSUoQF/NfsMtTF8g90NtD8/rXVMko3HnPcZeswM9zLC+SP
	 4rDf7QhhKwn6w==
Date: Tue, 13 Aug 2024 17:10:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, Joe Damato
 <jdamato@fastly.com>, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jan Kara
 <jack@suse.cz>, Jiri Pirko <jiri@resnulli.us>, Johannes Berg
 <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "open list:FILESYSTEMS
 (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
Message-ID: <20240813171015.425f239e@kernel.org>
In-Reply-To: <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
References: <20240812125717.413108-1-jdamato@fastly.com>
	<ZrpuWMoXHxzPvvhL@mini-arch>
	<2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 17:46:42 -0400 Martin Karsten wrote:
> >> Here's how it is intended to work:
> >>    - An administrator sets the existing sysfs parameters for
> >>      defer_hard_irqs and gro_flush_timeout to enable IRQ deferral.
> >>
> >>    - An administrator sets the new sysfs parameter irq_suspend_timeout
> >>      to a larger value than gro-timeout to enable IRQ suspension.  
> > 
> > Can you expand more on what's the problem with the existing gro_flush_timeout?
> > Is it defer_hard_irqs_count? Or you want a separate timeout only for the
> > perfer_busy_poll case(why?)? Because looking at the first two patches,
> > you essentially replace all usages of gro_flush_timeout with a new variable
> > and I don't see how it helps.  
> 
> gro-flush-timeout (in combination with defer-hard-irqs) is the default 
> irq deferral mechanism and as such, always active when configured. Its 
> static periodic softirq processing leads to a situation where:
> 
> - A long gro-flush-timeout causes high latencies when load is 
> sufficiently below capacity, or
> 
> - a short gro-flush-timeout causes overhead when softirq execution 
> asynchronously competes with application processing at high load.
> 
> The shortcomings of this are documented (to some extent) by our 
> experiments. See defer20 working well at low load, but having problems 
> at high load, while defer200 having higher latency at low load.
> 
> irq-suspend-timeout is only active when an application uses 
> prefer-busy-polling and in that case, produces a nice alternating 
> pattern of application processing and networking processing (similar to 
> what we describe in the paper). This then works well with both low and 
> high load.

What about NIC interrupt coalescing. defer_hard_irqs_count was supposed
to be used with NICs which either don't have IRQ coalescing or have a
broken implementation. The timeout of 200usec should be perfectly within
range of what NICs can support.

If the NIC IRQ coalescing works, instead of adding a new timeout value
we could add a new deferral control (replacing defer_hard_irqs_count)
which would always kick in after seeing prefer_busy_poll() but also
not kick in if the busy poll harvested 0 packets.

> > Maybe expand more on what code paths are we trying to improve? Existing
> > busy polling code is not super readable, so would be nice to simplify
> > it a bit in the process (if possible) instead of adding one more tunable.  
> 
> There are essentially three possible loops for network processing:
> 
> 1) hardirq -> softirq -> napi poll; this is the baseline functionality
> 
> 2) timer -> softirq -> napi poll; this is deferred irq processing scheme 
> with the shortcomings described above
> 
> 3) epoll -> busy-poll -> napi poll
> 
> If a system is configured for 1), not much can be done, as it is 
> difficult to interject anything into this loop without adding state and 
> side effects. This is what we tried for the paper, but it ended up being 
> a hack.
> 
> If however the system is configured for irq deferral, Loops 2) and 3) 
> "wrestle" with each other for control. Injecting the larger 
> irq-suspend-timeout for 'timer' in Loop 2) essentially tilts this in 
> favour of Loop 3) and creates the nice pattern describe above.


