Return-Path: <linux-fsdevel+bounces-27177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5253A95F2DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 15:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086501F2453E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3D118785F;
	Mon, 26 Aug 2024 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zp1vNc4D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MVBUGdIS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6CF53373;
	Mon, 26 Aug 2024 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678697; cv=none; b=XCCOISY7lvPyIk1KomhMq4rpTAzOktnYHzYLVQ44DEZ51U+0HwGtKuqeIY0/JdVsWxubYkJLbs57bM6pkddyANGfTY+F5jpbjw54HPB1bXEzpPWMsMnMUL1Nc3y4mNrPZV1xuTl9PIuFxxTJjmeK8bccLydlWSEjDV8hiDqkF8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678697; c=relaxed/simple;
	bh=Ubjr3hAkVUCRKgP1YwCituDtTL+Aqxbg8Af289I9Ieo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=crHbEJsOJEcsMmPN7P1mgpJZ7tIZjsgcpLwgd6bjQizwC3KhAdNg5vdmbmNuSRfJCwHSDjnL8yZf3SEXiEUo67xRe8eYK54mA7NI1bi/C4hnGym+XiijGYERe88HirZycxP0jSzdW5LXs5pLRMdhRrmY8vaOMMpZus7xlQjOvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zp1vNc4D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MVBUGdIS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724678693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JtERtJKi/CA36m/GEM8qvROm+v91KuIncw1OX4BkHbo=;
	b=zp1vNc4DuEN5YGFJn0TnAQLg0tqSuVcJT1LF7fJXWGjIq9boLoE67t0jweEecdUb7sF4GH
	GCQYB9HU/g83IdP8iePIB0ST+nfgjNktYKMIjUz3LlV/WiJcdqrTixPcGf8q5uk9fA4AJk
	w6fD2O1Yn3O5X0dRndrBmcvUrBU9IQbcMRg2frAPJ2wSc4l2YQ1FFd73rJq1/y6Vj/xxgH
	0esO02GAS3JjVqcgZix9NqNsLH/qRLm4AhSWJl3hwYmpMbN4YgqIT9Dr7UFLXgC7zxx7qp
	lBn8E0DLeyhkRVJ4UXNT+sBw3oZUwmdUgkhGWPGAQ6TSpslNcaibuIH3xKyBgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724678693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JtERtJKi/CA36m/GEM8qvROm+v91KuIncw1OX4BkHbo=;
	b=MVBUGdIS3uO0WmN8EGfXIZc+hb2K87xkQVti0VUBQTGVjM7a9DhmIGZGaQAw3NK+w8pyab
	59i8js1pWL3G7UAg==
To: Christophe Leroy <christophe.leroy@csgroup.eu>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Andy Lutomirski
 <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>, Arnd
 Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan
 <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 02/17] vdso: Clean header inclusion in getrandom
In-Reply-To: <51adbe91-3c3a-4baa-bb39-29df98a6eea5@csgroup.eu>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <2a081f1fff5e40f496153f8e0162fc7ec5adab2e.1724309198.git.christophe.leroy@csgroup.eu>
 <Zsw3xMoX2EI5UUs1@zx2c4.com>
 <7e519ba2-0293-4320-84bf-44f930fc286d@csgroup.eu>
 <ZsxDssNPbLkcPetJ@zx2c4.com>
 <51adbe91-3c3a-4baa-bb39-29df98a6eea5@csgroup.eu>
Date: Mon, 26 Aug 2024 15:24:52 +0200
Message-ID: <87plpvct7f.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26 2024 at 12:45, Christophe Leroy wrote:
> Le 26/08/2024 =C3=A0 10:58, Jason A. Donenfeld a =C3=A9crit=C2=A0:
>> On Mon, Aug 26, 2024 at 10:37:49AM +0200, Christophe Leroy wrote:
>>>
>>>
>>> Le 26/08/2024 =C3=A0 10:07, Jason A. Donenfeld a =C3=A9crit=C2=A0:
>>>> On Thu, Aug 22, 2024 at 09:13:10AM +0200, Christophe Leroy wrote:
>>>>>=20=20=20=20
>>>>> +#define _PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
>>>>> +#define _PAGE_MASK (~(_PAGE_SIZE - 1))
>>>>
>>>> If PAGE_SIZE isn't defined at this point, why not just call it PAGE_SI=
ZE
>>>> instead of _PAGE_SIZE? But if that's the case, why not put the vdso
>>>> definition of PAGE_SIZE into some vdso header included by this file?
>>>
>>> It was working ok on powerpc but on x86 I got:
>>=20
>> Seems like there might be some more fiddling to do, then? Or did you
>> conclude it's impossible?
>
> Maybe someone who knows x86 in details could helps but after a first=20
> look I gave up because it looks very x86 specific, indeed that's=20
> x86/asm/vdso/gettimeofday.h that pulls several x86/asm/ headers , and=20
> the same type of issue might arise for any new architecture coming in.

Of course :)

> For me it looked cleaner to just do as commit cffaefd15a8f ("vdso: Use=20
> CONFIG_PAGE_SHIFT in vdso/datapage.h") and not use PAGE_SIZE at all. But=
=20
> I didn't want to directly use (1UL << CONFIG_PAGE_SHIFT) and (~(1UL <<=20
> (CONFIG_PAGE_SHIFT - 1))) in the code directly hence the new macros with=
=20
> a leading underscore to avoid any conflict with existing macros.

#ifndef PAGE_SIZE
# define
#endif

Perhaps?

Thanks,

        tglx

