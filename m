Return-Path: <linux-fsdevel+bounces-26331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FA9957B51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 04:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EECC3B231C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 02:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D43926AC2;
	Tue, 20 Aug 2024 02:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myNqlT37"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A02C181;
	Tue, 20 Aug 2024 02:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724119678; cv=none; b=K5XQ6i+8rAN4RuiwQFe+F5SUPhRsK3c3BQhK0oWx0xVVdJDOJJHQHGTNdpewGruUUrfNzRJrDnszhWdBYzQN0IGjyITJ6ScAwC/Vc6W2/A4myUkSobxpRYQQ5JD1eTysCP6o1z/v0ob64STcOLCOH+7QJ9jHa81UvrP+Fh0GHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724119678; c=relaxed/simple;
	bh=ZddIw0tW5VAH05vy47Klfjadp2F4VUA1vxpIRu/A+Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAARtdAqE27E4fraw5oyqaASdQZ9XzTwg2dpvfmnLJ7Ra9BWEMFjVJXavLcrtHmq+7F9xsEcRX3FYZZLQ33cUe+dxXvLhvh3JrJmZ10fqUYFPz97KtKfGH7yplJYWWHFeKlEFxdGZOA2bvx0sCNazLHaUe+9DMsCPV7W+uReDdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myNqlT37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7436EC32782;
	Tue, 20 Aug 2024 02:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724119677;
	bh=ZddIw0tW5VAH05vy47Klfjadp2F4VUA1vxpIRu/A+Ls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=myNqlT37f5YJBFa59OcSKafME3odE0VUtB9AlIel9C9PgsOU1FIwhkkIpgLW9/H82
	 /Ad0i7FaYYInZyZSFTRTfqP4M3N8aVKI+1RAkyVl/mkQz95EG1zHicpg2b/iBFq/vF
	 bH1T3KTrUpE1KP5Qp/5kEDe1GduqhAPtG5wREEth4J55933AYVcHDTPe1dViVtpROX
	 qcz0eQgfmeJrzzhk+ZoSYxkBA8MZDICEHfeDqQ0Yf8LKAhrk/udLe3xjF9fOtN7QDY
	 QbGwVUN4QsIk8Sjti2igRtGMkDrifQd7Gogjs7mOl91fjOLncD0xTBwcVxF/qSRLIW
	 3NWBexXhwJCKw==
Date: Mon, 19 Aug 2024 19:07:55 -0700
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
Message-ID: <20240819190755.0ed0a959@kernel.org>
In-Reply-To: <15bec172-490f-4535-bd07-442c1be75ed9@uwaterloo.ca>
References: <20240812125717.413108-1-jdamato@fastly.com>
	<ZrpuWMoXHxzPvvhL@mini-arch>
	<2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
	<20240813171015.425f239e@kernel.org>
	<15bec172-490f-4535-bd07-442c1be75ed9@uwaterloo.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 21:14:40 -0400 Martin Karsten wrote:
> > What about NIC interrupt coalescing. defer_hard_irqs_count was supposed
> > to be used with NICs which either don't have IRQ coalescing or have a
> > broken implementation. The timeout of 200usec should be perfectly within
> > range of what NICs can support.
> > 
> > If the NIC IRQ coalescing works, instead of adding a new timeout value
> > we could add a new deferral control (replacing defer_hard_irqs_count)
> > which would always kick in after seeing prefer_busy_poll() but also
> > not kick in if the busy poll harvested 0 packets.  
> Maybe I am missing something, but I believe this would have the same 
> problem that we describe for gro-timeout + defer-irq. When busy poll 
> does not harvest packets and the application thread is idle and goes to 
> sleep, it would then take up to 200 us to get the next interrupt. This 
> considerably increases tail latencies under low load.
> 
> In order get low latencies under low load, the NIC timeout would have to 
> be something like 20 us, but under high load the application thread will 
> be busy for longer than 20 us and the interrupt (and softirq) will come 
> too early and cause interference.

An FSM-like diagram would go a long way in clarifying things :)

> It is tempting to think of the second timeout as 0 and in fact re-enable 
> interrupts right away. We have tried it, but it leads to a lot of 
> interrupts and corresponding inefficiencies, since a system below 
> capacity frequently switches between busy and idle. Using a small 
> timeout (20 us) for modest deferral and batching when idle is a lot more 
> efficient.

I see. I think we are on the same page. What I was suggesting is to use
the HW timer instead of the short timer. But I suspect the NIC you're
using isn't really good at clearing IRQs before unmasking. Meaning that
when you try to reactivate HW control there's already an IRQ pending
and it fires pointlessly. That matches my experience with mlx5. 
If the NIC driver was to clear the IRQ state before running the NAPI
loop, we would have no pending IRQ by the time we unmask and activate
HW IRQs.

Sorry for the delay.

