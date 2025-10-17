Return-Path: <linux-fsdevel+bounces-64473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98647BE847E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F371819A4690
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF5A343D64;
	Fri, 17 Oct 2025 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0w22HeRq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yb2o+SyR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B1339B5D;
	Fri, 17 Oct 2025 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700079; cv=none; b=bxcH9pZNsHb09X976ERCHJBmFmpSraQM60i4oushNjK5J8KQYPB8f8Nv9Oum7TQdruwVDqt9QAHJm+sHJttiU0vcBoddnpliB57H+jIpl8PoDQFYhrjRxhEuprFdoUUz5HVkgYD3eW7WgBu6l77dnvQLxCwxWMjomKE3qouWDg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700079; c=relaxed/simple;
	bh=0FvyCoHZIpX45PkbM8k1XpEvA39Z8N3BYjHT0VhQTKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G2zd3/7Uothb6XAV8lMJ4f72QbtB9Wi68GWzbbJohCBLD9xhpjp0LqWSp9Qepst6NnBsI64hCveyzqJW6bPyaoLafS21ci6t8K6KPwx92Ux7lvOG3iIvLbz1+iBVLaBxjqFKy+xAPdq4DS2VXnpgss1ipAo+/gJLKQa0bRY7wUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0w22HeRq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yb2o+SyR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760700075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZ5/2E9/kdHV6wKk13IMjV26fuC0EY7cU/moeac/r0k=;
	b=0w22HeRqwsEaDWfFRcdym9ZdxujQL/SMlrRPuJJ8G0lW0VU+roLNqAQqn+5ddD4XHPvhCI
	G8RfcOVLaDb522FTklVP+T9AWU7a2YUuU3/zS9de1315WWxBoHvU0Nj9QJ0h9Ke1JMi7Um
	5yCRggrIaasOfxTCXZDvGcnXQN5DpN5DBZjhPihilyQSh9zfnpDA51OSo91RRi6YZ2ajDU
	zq9nd/fL2MnY3jElVShCHCxnhdw8CHKx+HzZyOCYRxfE/8sQpHPMZx5+Owgr0vwuACBi4W
	Im9zYuGn3kphxZ4bkop+xrUFJb6ZrY64lUNREC8dmKGqVpm3CuTHhMBvBTfxjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760700075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZ5/2E9/kdHV6wKk13IMjV26fuC0EY7cU/moeac/r0k=;
	b=yb2o+SyRVbqNJx1T2MjsSgrIjIm9/+bN/XuOD9YUNJmae1nSpVUZAsBLSIxLGfTfjAFqpz
	FrlXldlLVbWUzqBA==
To: Andrew Cooper <andrew.cooper@citrix.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, Julia Lawall
 <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Peter
 Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access
 regions
In-Reply-To: <adba2f37-85fc-45fa-b93b-9b86ab3493f3@citrix.com>
References: <20251017085938.150569636@linutronix.de>
 <20251017093030.253004391@linutronix.de>
 <adba2f37-85fc-45fa-b93b-9b86ab3493f3@citrix.com>
Date: Fri, 17 Oct 2025 13:21:14 +0200
Message-ID: <871pn122qd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17 2025 at 12:08, Andrew Cooper wrote:

> On 17/10/2025 11:09 am, Thomas Gleixner wrote:
>> --- a/include/linux/uaccess.h
>> +++ b/include/linux/uaccess.h
>> +#define __scoped_masked_user_access(_mode, _uptr, _size, _elbl)					\
>> +for (bool ____stop =3D false; !____stop; ____stop =3D true)						\
>> +	for (typeof((_uptr)) _tmpptr =3D __scoped_user_access_begin(_mode, _up=
tr, _size, _elbl);	\
>> +	     !____stop; ____stop =3D true)							\
>> +		for (CLASS(masked_user_##_mode##_access, scope) (_tmpptr); !____stop;=
		\
>> +		     ____stop =3D true)					\
>> +			/* Force modified pointer usage within the scope */			\
>> +			for (const typeof((_uptr)) _uptr =3D _tmpptr; !____stop; ____stop =
=3D true)	\
>> +				if (1)
>> +
>
> Truly a thing of beauty.=C2=A0 At least the end user experience is nice.
>
> One thing to be aware of is that:
>
> =C2=A0=C2=A0=C2=A0 scoped_masked_user_rw_access(ptr, efault) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe_get_user(rval, &ptr->rv=
al, efault);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe_put_user(wval, &ptr->wv=
al, efault);
> =C2=A0=C2=A0=C2=A0 } else {
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 // unreachable
> =C2=A0=C2=A0=C2=A0 }
>
> will compile.=C2=A0 Instead, I think you want the final line of the macro=
 to
> be "if (0) {} else" to prevent this.

Duh. yes. But I can just remove the 'if (1)' completely. That's a
leftover from some earlier iteration of this.

> While we're on the subject, can we find some C standards people to lobby.
>
> C2Y has a proposal to introduce "if (int foo =3D" syntax to generalise the
> for() loop special case.=C2=A0 Can we please see about fixing the restric=
tion
> of only allowing a single type per loop?=C2=A0=C2=A0 This example could b=
e a
> single loop if it weren't for that restriction.

That'd be nice. But we can't have nice things, can we?

Thanks,

        tglx

