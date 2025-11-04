Return-Path: <linux-fsdevel+bounces-66891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8423C2FC10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 09:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4681B4E71CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CFA30506E;
	Tue,  4 Nov 2025 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jgwl2Vop";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t8JDRw+f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9B82C181;
	Tue,  4 Nov 2025 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243327; cv=none; b=KGFnH2l9do9oWlHUThIPfdZGOyZVO2WvRGI+Myr/0hQbYShgGyirQqKcQsrt0CYrugCbwl8FXJc6a9Owa6AV61FDehYFPH6TtcQfJusFtNBvzcSqVlZ4yV5PkM+gdFTS44hD3/bolxaA1jCe39jNDbAbG5ufxt4eqMfRk6oYduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243327; c=relaxed/simple;
	bh=vaSI9y3TVSYBJFCalfQ4W0TlJkXSf69LRSPhgBhvC3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HOhhN6Z3TVKxvhkHfZoo6YXHC1pYbU3POb5pGKli9CRkh2PW3BdTvQyO/Uzzj8CtO0glJ0rNBHtl19S9VNRfkC3teolaMhxLuDsrzp4AP1OqWRrlJtBBuiw39vRT++8Mrt+6SGDOAodgA4216NEl730RHm9D0zbOO8eZZWCzFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jgwl2Vop; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t8JDRw+f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762243320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxHg295CBRsqPu2lBIqw5Sn0fGrCLg/ElUlxqApeBLM=;
	b=Jgwl2VopvLhsHH+YYqRsae6+FKzyHIS0wgTmsM6zvXdnRYVO1Mp+3CjSgP12sRf79JdkIC
	hx50TnrXAEfEN5ICnRweGj/sSAz5nUPqUFikzhoLJZNQyXaN5ymoCj4E2L3wBjx4OeG4vN
	lcnERol2ohNQ5nXcU3OkM3UJOm2NJRST4BTxh1MoYrChOMqgAT9DLUj9eFzBzflyLWH87K
	qqDczZQWcFWGe/iPVZhDUA34+WNIo7S9c1kgflcSpKmM0UaRdPJMv7RLP9TTDCTxs4B7XJ
	XLq2JS1KXSF/YOo8ZUxjIZTH8AN+3Axixi4ToMHu6WXnTGvIMsd2QaBZquI9Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762243320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxHg295CBRsqPu2lBIqw5Sn0fGrCLg/ElUlxqApeBLM=;
	b=t8JDRw+fUTFLMI+7oIYVrsnas628xW2/vuKmoPeHnnr/Dd9LlRlJTGnA4BulGKiXBQPkro
	pOJgImdDLmiQK4AQ==
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>, Andrew
 Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen
 <dave.hansen@linux.intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 03/10] uaccess: Add
 masked_user_{read/write}_access_begin
In-Reply-To: <01d89f24-8fca-4fc3-9f48-79e28b9663db@csgroup.eu>
References: <cover.1760529207.git.christophe.leroy@csgroup.eu>
 <a4ef0a8e1659805c60fafc8d3b073ecd08117241.1760529207.git.christophe.leroy@csgroup.eu>
 <87bjlyyiii.ffs@tglx> <01d89f24-8fca-4fc3-9f48-79e28b9663db@csgroup.eu>
Date: Tue, 04 Nov 2025 09:01:58 +0100
Message-ID: <875xbqw7ih.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04 2025 at 07:39, Christophe Leroy wrote:
> Le 22/10/2025 =C3=A0 19:05, Thomas Gleixner a =C3=A9crit=C2=A0:
>> On Fri, Oct 17 2025 at 12:20, Christophe Leroy wrote:
>>> Allthough masked_user_access_begin() is to only be used when reading
>>> data from user at the moment, introduce masked_user_read_access_begin()
>>> and masked_user_write_access_begin() in order to match
>>> user_read_access_begin() and user_write_access_begin().
>>>
>>> That means masked_user_read_access_begin() is used when user memory is
>>> exclusively read during the window, masked_user_write_access_begin()
>>> is used when user memory is exclusively writen during the window,
>>> masked_user_access_begin() remains and is used when both reads and
>>> writes are performed during the open window. Each of them is expected
>>> to be terminated by the matching user_read_access_end(),
>>> user_write_access_end() and user_access_end().
>>>
>>> Have them default to masked_user_access_begin() when they are
>>> not defined.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>=20
>> Can we please coordinate on that vs. the scoped_access() work as this
>> nicely collides all over the place?
>
> Sure, I will rebase on top of your series.
>
> Once it is rebased, could you take the non powerpc patches in your tree ?

Sure. The current lot is at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git scoped-uaccess

Thanks,

        tglx

