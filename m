Return-Path: <linux-fsdevel+bounces-28724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD59E96D82C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C9928B782
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7772819ADB0;
	Thu,  5 Sep 2024 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="K9RNtijG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D117A5BE;
	Thu,  5 Sep 2024 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538731; cv=none; b=Wrk0HzJxtlM1n5JYwU1quUFwaSkedfchBPVaybo439z8p0kwmJhn7oV21VbtxPuMZ9OyKf+/6fIR9g6j9a5ejHVuZGqxv30foXp/TGjSB8JduPx7K5OwGlVKPr565Qb2G73AzlftlzU7FQ2+6bmgC/JcjXtP6vZOM1zrQHeVNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538731; c=relaxed/simple;
	bh=xnxK5to/0ePcX0+Bd3U+Y0/lgElvGf1/1Pp5sQgodpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p8Z5Sio7ZOhPks12600tLrbI8T+PSLRJK6tdoZqsgt6zckRx3msHTTs4ATFZVoR5+YO5YfN9TEhLE1UYy5cJPMnj9A5lgfXm0uWPGHVpj874uGp9ed6TCDHPhiiNMSp3alSJWokxYmvNwOqvQYxkYpowzVsRBevT+R17Kzbzr58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=K9RNtijG; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725538726;
	bh=uHtMyZ0mGdGut63ipl9pSNEPhg4gQFAZt25TdNzawnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=K9RNtijGnQSSSovlUF+85A4m8nKayeSvx/Ob0UZe5MJZyqYtM2pQp+6L4nOcFBaL8
	 BMvvg2k7bpp41TQpyqsAUXWRf9BykbfFXJDdQCMgNnVRzMXGqdYM3Sm6ZG58e+Zzi8
	 xqDI/zBSXPr5VH16d77RzHiYS8QQhrpNG+LVTWOYc8PJiopRQ7aKFTBzvlaxwbnjCz
	 6ss+QYEqmuStkZsohKp2idavtqXQSJWsED2PrAQKG3qsuvIpbAmxC3YKMYwXrruEr9
	 LEfLpNhWcsB0I1NH6JCVZcsdgJSq7qa1g0AzaMpAXveSikpyikaPbous9gKJoszvTM
	 yYb9S47fFXRUg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wzz0y4N1Rz4w2Q;
	Thu,  5 Sep 2024 22:18:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Shuah
 Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, Adhemerval Zanella
 <adhemerval.zanella@linaro.org>, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH v5 0/5] Wire up getrandom() vDSO implementation on powerpc
In-Reply-To: <Zthr1nB_RJ56YD3O@zx2c4.com>
References: <cover.1725304404.git.christophe.leroy@csgroup.eu>
 <Zthr1nB_RJ56YD3O@zx2c4.com>
Date: Thu, 05 Sep 2024 22:18:40 +1000
Message-ID: <87frqe5m5b.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:
> Hi Christophe, Michael,
>
> On Mon, Sep 02, 2024 at 09:17:17PM +0200, Christophe Leroy wrote:
>> This series wires up getrandom() vDSO implementation on powerpc.
>> 
>> Tested on PPC32 on real hardware.
>> Tested on PPC64 (both BE and LE) on QEMU:
>> 
>> Performance on powerpc 885:
>> 	~# ./vdso_test_getrandom bench-single
>> 	   vdso: 25000000 times in 62.938002291 seconds
>> 	   libc: 25000000 times in 535.581916866 seconds
>> 	syscall: 25000000 times in 531.525042806 seconds
>> 
>> Performance on powerpc 8321:
>> 	~# ./vdso_test_getrandom bench-single
>> 	   vdso: 25000000 times in 16.899318858 seconds
>> 	   libc: 25000000 times in 131.050596522 seconds
>> 	syscall: 25000000 times in 129.794790389 seconds
>> 
>> Performance on QEMU pseries:
>> 	~ # ./vdso_test_getrandom bench-single
>> 	   vdso: 25000000 times in 4.977777162 seconds
>> 	   libc: 25000000 times in 75.516749981 seconds
>> 	syscall: 25000000 times in 86.842242014 seconds
>
> Looking good. I have no remaining nits on this patchset; it looks good
> to me.
>
> A review from Michael would be nice though (in addition to the necessary
> "Ack" I need to commit this to my tree), because there are a lot of PPC
> particulars that I don't know enough about to review properly. For
> example, you use -ffixed-r30 on PPC64. I'm sure there's a good reason
> for this, but I don't know enough to assess it. And cvdso_call I have no
> idea what's going on. Etc.
 
It all looks good to me, and has survived some testing. Let's get it
merged and get some wider test coverage.

There is an existing comment in the a/p/vdso/Makefile about the
fixed-r30 thing, tldr is it's a workaround to avoid breaking old
versions of Go.

For the series:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

If you can include Maddy's test results from Power9 in the change log
for patch 5 that'd be nice.

cheers

