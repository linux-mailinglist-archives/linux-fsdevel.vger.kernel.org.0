Return-Path: <linux-fsdevel+bounces-28766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A02696E0B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B89D1C23B92
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 17:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAF61A0B13;
	Thu,  5 Sep 2024 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="eQnfTq5B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E881214EC71;
	Thu,  5 Sep 2024 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555695; cv=none; b=dPxRdX5t0xecEc4ut/XOlkVyXPTmJ5H4q8gTRJz1xypsbDvTBSWgD2GpxCmNdiZE+8VRyBtRoN0BW1hHDWPivvb1ulKYDKQHifbqEIRixrFnrEyMJnHg3IhLQOH0dk94gfCjjnKmgr5dq2GGKGbPxV11sEtVXqzR+XZQfL7pS60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555695; c=relaxed/simple;
	bh=XfRHOOTB0JMhf+MK3R/lYIZ6+UJ/VHBgt5zKgheqat0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pZMoDAhQc8bRjpPzbmwP07Ehyco7lryEDPLSyBHLLS0jiEOKLzsOfqly+1+r9m0lEWWnXb9sAbqgW8pvI55gc2T9s124jTzkorRJuM8ErSX2qtCCxwgzPYpDfmfh7OaBr5l6c/3xE2ACUzUtugJCB52rOt1HDYGXW6wKwbHpeZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=eQnfTq5B; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1725555689;
	bh=m7o5UxMVj4tZHSmvKnKAAWvKE9fBkiFe1G6UTAXy5Zo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eQnfTq5BofF4mjxLeycsVbeLthlkeKdeBFy6kb6apgzF2KPRhoEmrbxm4Pt15YLpl
	 J6AB/gQdRsAEdR8B/fS5bK1Z52/xaWinCKV1s5TaL2dGA47Vu0O9PMHDxdnygC2BBV
	 GpYLCmIMD28MIbLsPfcXaLYXxb10KQbzRkrANP5U=
Received: from [IPv6:240e:358:11a3:ba00:dc73:854d:832e:2] (unknown [IPv6:240e:358:11a3:ba00:dc73:854d:832e:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 9F4141A3F87;
	Thu,  5 Sep 2024 13:01:18 -0400 (EDT)
Message-ID: <edd9356165393818b4f1c9d4a4f3af4e561127e5.camel@xry111.site>
Subject: Re: [PATCH v5 4/5] powerpc/vdso: Wire up getrandom() vDSO
 implementation on VDSO32
From: Xi Ruoyao <xry111@xry111.site>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, "Jason A. Donenfeld"
	 <Jason@zx2c4.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-trace-kernel@vger.kernel.org, Adhemerval Zanella
 <adhemerval.zanella@linaro.org>
Date: Fri, 06 Sep 2024 01:01:13 +0800
In-Reply-To: <85c02620-e8b2-4c97-9905-685a9a4e556d@csgroup.eu>
References: <cover.1725304404.git.christophe.leroy@csgroup.eu>
	 <1f49c2ce009f8b007ab0676fb41187b2d54f28b2.1725304404.git.christophe.leroy@csgroup.eu>
	 <ZtnYqZI-nrsNslwy@zx2c4.com>
	 <85c02620-e8b2-4c97-9905-685a9a4e556d@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-05 at 18:55 +0200, Christophe Leroy wrote:
> > Normal single thread
> > =C2=A0=C2=A0=C2=A0=C2=A0 vdso: 25000000 times in 12.494133131 seconds
> > =C2=A0=C2=A0=C2=A0=C2=A0 libc: 25000000 times in 69.594625188 seconds
> > syscall: 25000000 times in 67.349243972 seconds
> > Time namespace single thread
> > =C2=A0=C2=A0=C2=A0=C2=A0 vdso: 25000000 times in 71.673057436 seconds
> > =C2=A0=C2=A0=C2=A0=C2=A0 libc: 25000000 times in 71.712774121 seconds
> > syscall: 25000000 times in 66.902318080 seconds
> >=20
> > I'm seeing this on ppc, ppc64, and ppc64le.
>=20
> What is the command to use to test with time namespace ?

Assuming user namespace and time namespace are available:

$ unshare -r -T --boottime $((365*24*3600))

It'll start a new shell where you are pretended to be the root (i.e. the
root in the separated user namespace).  Then:

# uptime
 00:57:17 up 365 days, 57 min,  2 users,  load average: 0.19, 0.30, 0.32

So in the separated time namespace the system is pretended to have been
booted for 1 year.  Now:

# /path/to/linux.git/tools/testing/selftests/vDSO/vdso_test_getrandom bench=
_single
   vdso: 25000000 times in 0.419125373 seconds
   libc: 25000000 times in 5.985498234 seconds
syscall: 25000000 times in 5.993506773 seconds

This is on x86_64, indicating vDSO getrandom is fine for x86_64 in a
separated time namespace.

If user namespace isn't available (disabled building the kernel or
disabled by the security policy of some distros) use

$ sudo unshare -T --boottime $((365*24*3600))

to create the time namespace instead.  But note that with this approach
you'll be operating as the real root user and be careful not to break
things.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

