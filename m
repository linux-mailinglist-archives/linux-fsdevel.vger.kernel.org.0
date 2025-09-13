Return-Path: <linux-fsdevel+bounces-61211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A40B56276
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 20:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413D21721EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 18:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CBC1F9F51;
	Sat, 13 Sep 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WrDPKO9t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ifqClj1M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F7E1D5146;
	Sat, 13 Sep 2025 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757786524; cv=none; b=pxR/bGojmRLygZ72MqmQ8b8TdzocRTwEwlWF2iDJREJfYO9Nu1k+uVop1ANQrvQ4ZkWRX8GzkEXbsBr6HU+NlOKtzHVJUMXebNfiW8QBQzaGcUqxsNnkWKPTVTmIyiquJHr+vmAmFw30MqIlOnDc4lNxSo4dsmrEiYwu7ZOnxiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757786524; c=relaxed/simple;
	bh=Ps+Pl01P0IfQwj66HPqHEiOcIWsQihuXbQnfO5Jovdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JbhT4CK9r4rZpVQ9V+fr9KmQIKxiA2/9eUPNntKwaNiS1q6MhMexqEytEPi7BvLDU175GukY1iwbMUDaxrSJLLq/MPKqgACopml/71ENrcp/TF4JESwAVPOAaBJVksWB5Jghx93XRkn3ouVw9Cgw+NPze5nR8a7HrUHzEqps4VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WrDPKO9t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ifqClj1M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757786519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJrkNR8Djaw117twu3g48vyGNepCTuoaHbeLvsIJPc0=;
	b=WrDPKO9tFY34kzid5bGf5l3cqv0nOiKxrfNBWunhn/8+gqCydNFVF+qvh7o+b5ejoAKORb
	3tUcCtmuhpJdGn6fuZoqFFkQDcfAkmbA1wsK6lzTc+JqQ7ejVA9D15rfVZcwAlumCJTrUs
	BtpaKyKOeHMc7oeQsE+hN4ha1D3sRo/uhFlZXct824XxkjxtVJTN6zCrqMKJDXvSMnLMTX
	/5nzYGjNrK3ZWKgntU0Kf2Q52BBaNXjlS783MSNm2+jm/puqc7OfiaXlhUMpUAOTZwdK/R
	Pcpdm4Suj82xE1ThrsiORtxo0FEPkfufBXnuz+k2r6npBhb0vhoLVUyUPyUInQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757786519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJrkNR8Djaw117twu3g48vyGNepCTuoaHbeLvsIJPc0=;
	b=ifqClj1M/rTywWSB3Qli/BeWNUV1cyMMpn4zf0vjoNjjZOhjJPYrKgECwUjF3wB1nYB6r8
	Uz3s/cQFYOGD0BDA==
To: Christophe Leroy <christophe.leroy@csgroup.eu>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, x86@kernel.org,
 Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 1/4] uaccess: Provide common helpers for masked user access
In-Reply-To: <0424c6bc-aa12-4ee2-a062-68ce16603c26@csgroup.eu>
References: <20250813150610.521355442@linutronix.de>
 <20250813151939.601040635@linutronix.de>
 <0424c6bc-aa12-4ee2-a062-68ce16603c26@csgroup.eu>
Date: Sat, 13 Sep 2025 20:01:57 +0200
Message-ID: <874it65izu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26 2025 at 09:04, Christophe Leroy wrote:

> Le 13/08/2025 =C3=A0 17:57, Thomas Gleixner a =C3=A9crit=C2=A0:
>> commit 2865baf54077 ("x86: support user address masking instead of
>> non-speculative conditional") provided an optimization for
>> unsafe_get/put_user(), which optimizes the Spectre-V1 mitigation in an
>> architecture specific way. Currently only x86_64 supports that.
>>=20
>> The required code pattern is:
>>=20
>> 	if (can_do_masked_user_access())
>> 		dst =3D masked_user_access_begin(dst);
>> 	else if (!user_write_access_begin(dst, sizeof(*dst)))
>> 		return -EFAULT;
>> 	unsafe_put_user(val, dst, Efault);
>> 	user_read_access_end();
>
> You previously called user_write_access_begin(), so must be a=20
> user_write_access_end() here not a user_read_access_end().
>
>> 	return 0;
>> Efault:
>> 	user_read_access_end();
>
> Same.
>
>> 	return -EFAULT;
>>=20
>> The futex code already grew an instance of that and there are other area=
s,
>> which can be optimized, when the calling code actually verified before,
>> that the user pointer is both aligned and actually in user space.
>>=20
>> Use the futex example and provide generic helper inlines for that to avo=
id
>> having tons of copies all over the tree.
>>=20
>> This provides get/put_user_masked_uNN() where $NN is the variable size in
>> bits, i.e. 8, 16, 32, 64.
>
> Couldn't the $NN be automatically determined through the type of the=20
> provided user pointer (i.e. the 'from' and 'to' in patch 2) ?
>
>>=20
>> The second set of helpers is to encapsulate the prologue for larger acce=
ss
>> patterns, e.g. multiple consecutive unsafe_put/get_user() scenarioes:
>>=20
>> 	if (can_do_masked_user_access())
>> 		dst =3D masked_user_access_begin(dst);
>> 	else if (!user_write_access_begin(dst, sizeof(*dst)))
>> 		return -EFAULT;
>> 	unsafe_put_user(a, &dst->a, Efault);
>> 	unsafe_put_user(b, &dst->b, Efault);
>> 	user_write_access_end();
>> 	return 0;
>> Efault:
>> 	user_write_access_end();
>> 	return -EFAULT;
>>=20
>> which allows to shorten this to:
>>=20
>> 	if (!user_write_masked_begin(dst))
>> 		return -EFAULT;
>> 	unsafe_put_user(a, &dst->a, Efault);
>> 	...
>
> That's nice but ... it hides even deeper the fact that=20
> masked_user_access_begin() opens a read/write access to userspace. On=20
> x86 it doesn't matter because all userspace accesses are read/write. But=
=20
> on architectures like powerpc it becomes a problem if you do a=20
> read/write open then only call user_read_access_end() as write access=20
> might remain open.
>
> I have a patch (See [1]) that splits masked_user_access_begin() into=20
> three versions, one for read-only, one for write-only and one for=20
> read-write., so that they match user_read_access_end()=20
> user_write_access_end() and user_access_end() respectively.
>
> [1]=20
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/7b570e237f7099d56=
4d7b1a270169428ac1f3099.1755854833.git.christophe.leroy@csgroup.eu/
>
>
>>=20
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>   include/linux/uaccess.h |   78 +++++++++++++++++++++++++++++++++++++++=
+++++++++
>>   1 file changed, 78 insertions(+)
>>=20
>> --- a/include/linux/uaccess.h
>> +++ b/include/linux/uaccess.h
>> @@ -569,6 +569,84 @@ static inline void user_access_restore(u
>>   #define user_read_access_end user_access_end
>>   #endif
>>=20=20=20
>> +/*
>> + * Conveniance macros to avoid spreading this pattern all over the place
>> + */
>> +#define user_read_masked_begin(src) ({					\
>> +	bool __ret =3D true;						\
>> +									\
>> +	if (can_do_masked_user_access())				\
>> +		src =3D masked_user_access_begin(src);			\
>
> Should call a masked_user_read_access_begin() to perform a read-only=20
> masked access begin, matching the read-only access begin below
>
>> +	else if (!user_read_access_begin(src, sizeof(*src)))		\
>> +		__ret =3D false;						\
>> +	__ret;								\
>> +})
>> +
>> +#define user_write_masked_begin(dst) ({					\
>> +	bool __ret =3D true;						\
>> +									\
>> +	if (can_do_masked_user_access())				\
>> +		dst =3D masked_user_access_begin(dst);			\
>
> Should call masked_user_write_access_begin() to perform a write-only=20
> masked access begin, matching the write-only access begin below
>
>> +	else if (!user_write_access_begin(dst, sizeof(*dst)))		\
>> +		__ret =3D false;						\
>> +	__ret;								\
>> +})
>
> You are missing a user_masked_begin() for read-write operations.

Duh. Let me go and rewrite this correctly. I clearly wasn't thinking straig=
ht.

>> +GEN_GET_USER_MASKED(u8)
>> +GEN_GET_USER_MASKED(u16)
>> +GEN_GET_USER_MASKED(u32)
>> +GEN_GET_USER_MASKED(u64)
>> +#undef GEN_GET_USER_MASKED
>
> Do we need four functions ? Can't we just have a get_user_masked() macro=
=20
> that relies on the type of src , just like unsafe_get_user() ?

Tried and the resulting macro maze is completely unreadable
garbage. Having a readable implementation and the four functions for the
types supported was definitely more palatable. It's not too much asked
from a developer to pick the correct one.

Thanks,

        tglx

