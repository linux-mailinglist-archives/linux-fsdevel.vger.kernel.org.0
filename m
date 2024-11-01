Return-Path: <linux-fsdevel+bounces-33507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC52D9B9B39
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 00:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C9A1F22151
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 23:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E071E32CC;
	Fri,  1 Nov 2024 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JWEj9QjS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a34UxBWJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C75137745;
	Fri,  1 Nov 2024 23:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730504241; cv=none; b=ZDLqvOVBEEySuLrCP8D4PoqUwnBWViS/I9sq18VYewfjVan2cOAX/1e9tGHfbnRkd5q8Y16TB8SLeBjU9bNDOwOp/g1SkNLlOr0r6FjrW/HfxIPLpo4hUaO0P/KI3/Po+Tlej8LLKol5BDek3HB8gYfbPBVknfmeIL8hEAJi9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730504241; c=relaxed/simple;
	bh=3kj6OyEELQBFa/kDWXd9HVrlsW3N9aS0gU28/KPADWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FBEs2Wwqcz1EUvh6EVcKJoD2IfYHjsbUoH0K6sid+LCmW0l2Kg8GrgseqXXQcdXNYFilSq/1ofped9L6KdJLRHuQYUyR6WaU1BVyodjLA90cquw5oWK9Yp28k869PzSqjiBdWF6FMJP52wQ6YuE/3nyJ11FGcva0L5hOEhWBrns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JWEj9QjS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a34UxBWJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730504237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hEbhXrDUtyuWKJd3ehaILokOGyu2h6Q6B5wfuMSyD0=;
	b=JWEj9QjSBEyCLLc2sdGDVDHcdRYMuPETvwuhGBviRL/LQKvn0eWocb5w+DiZzTkMOC7uWr
	fPD9AbGNop10pVIuH2G+X+xTlNcnjpn660Vh8xo343ffA86Q0uSwb/8dj3Ueq4kIt/ADcQ
	010zK74KumgO4nFr89HL5E2dEoLNEy27jC4ROhnqzx+5Z9wDK0MKHKLCNIcMKqD/Zr99ne
	JqEajIb88CUZjq/bfKi3QEFvH57wRgSxlAteKaAlmfFj67bIMdq4VY1zkcnab4V2ZKLHw7
	ofr7M1f2WJ2XvhOmww5tSuy3ohxhYNOXMtOf25dGqdwuD0cYokRIE9DrQHL9Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730504237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hEbhXrDUtyuWKJd3ehaILokOGyu2h6Q6B5wfuMSyD0=;
	b=a34UxBWJt0wl4wyuMAv1RCtfRBgMJ6wl9RM2K6j1I9qDmQClIdys5MO7cAup4fpZLr9ZT6
	aU3o2yNbv17xKKBg==
To: mapicccy <guanjun@linux.alibaba.com>
Cc: corbet@lwn.net, axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, vgoyal@redhat.com,
 stefanha@redhat.com, miklos@szeredi.hu, peterz@infradead.org,
 akpm@linux-foundation.org, paulmck@kernel.org, thuth@redhat.com,
 rostedt@goodmis.org, bp@alien8.de, xiongwei.song@windriver.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v1 1/2] genirq/affinity: add support for limiting
 managed interrupts
In-Reply-To: <9847EC49-8F55-486A-985D-C3EDD168762D@linux.alibaba.com>
References: <20241031074618.3585491-1-guanjun@linux.alibaba.com>
 <20241031074618.3585491-2-guanjun@linux.alibaba.com> <87v7x8woeq.ffs@tglx>
 <9847EC49-8F55-486A-985D-C3EDD168762D@linux.alibaba.com>
Date: Sat, 02 Nov 2024 00:37:16 +0100
Message-ID: <87h68qttjn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01 2024 at 11:03, mapicccy wrote:
>> 2024=E5=B9=B410=E6=9C=8831=E6=97=A5 18:35=EF=BC=8CThomas Gleixner <tglx@=
linutronix.de> =E5=86=99=E9=81=93=EF=BC=9A
>>> +	get_nodes_in_cpumask(node_to_cpumask, premask, &nodemsk);
>>> +
>>> +	for_each_node_mask(n, nodemsk) {
>>> +		cpumask_and(&managed_irqs_cpumsk[n], &managed_irqs_cpumsk[n], premas=
k);
>>> +		cpumask_and(&managed_irqs_cpumsk[n], &managed_irqs_cpumsk[n], node_t=
o_cpumask[n]);
>>=20
>> How is this managed_irqs_cpumsk array protected against concurrency?
>
> My intention was to allocate up to `managed_irq_per_node` cpu bits from `=
managed_irqs_cpumask[n]`,
> even if another task modifies some of the bits in the `managed_irqs_cpuma=
sk[n]` at the same time.

That may have been your intention, but how is this even remotely
correct?

Aside of that. If it's intentional and you think it's correct then you
should have documented that in the code and also annotated it to not
trigger santiziers.

>> Given the limitations of the x86 vector space, which is not going away
>> anytime soon, there are only two options IMO to handle such a scenario.
>>=20
>>   1) Tell the nvme/block layer to disable queue affinity management
>>=20
>>   2) Restrict the devices and queues to the nodes they sit on
>
> I have tried fixing this issue through nvme driver, but later
> discovered that the same issue exists with virtio net.  Therefore, I
> want to address this with a more general solution.

I understand, but a general solution for this problem won't exist
ever.

It's very reasonable to restrict this for one particular device type or
subsystem while maintaining the strict managed property for others, no?

General solutions are definitely preferred, but not for the price that
they break existing completely correct and working setups. Which is what
your 2/2 patch does for sure.

Thanks,

        tglx

