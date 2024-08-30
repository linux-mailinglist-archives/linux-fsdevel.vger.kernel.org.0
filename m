Return-Path: <linux-fsdevel+bounces-28004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD50B965DD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 12:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5C8281010
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 10:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104E317C22B;
	Fri, 30 Aug 2024 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="NNcmrTyt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4D17B4E1;
	Fri, 30 Aug 2024 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012129; cv=none; b=c8MuiDqGg6GxWubMNBmR0p3sBOXVY54V2YVCGEFWO9VHBfKykWmj6aFXs0uEgMldEUCiIeXYCwaGCs8towqltrLx6o7u+Wwl6sHbLvlokAxckX57MB5A1mZu3uZgQ0TjvauPe51ltdzn8G1eCxTiCX49neQm/PgwU3SZrD9oIyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012129; c=relaxed/simple;
	bh=trhe5zk8M/PcJeerPxnKm741ZNbwuM7VZERvyU7MXrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TnDYAFS32d1tbk0OmGjxWhALLWOuqb7kDKwTUgPmno1p5XY6hLRyedJmojaSsu9x1wjXNQs+1QNjd85x4j5uGxxdRSprnvRI65r+Mvur+zXoPhYWcardoBwIQkPI5VY9qGm/O6B/fzIvY9qjHsbv2uhCNz4jYWvuv79fXO235Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=NNcmrTyt; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725012123;
	bh=lPcPtY81gFF3u7n0A2RVPpHqZKSc08Lj9bnrJizsMEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NNcmrTytNe5K01YNEaaZ19cRsK3cVkZsPx09KELB11fMi0p0LaIX5DEwSFpG6peNy
	 ISAellXAO+xLaSRbUK+pojAHnpn4mXhQ6Xi7aXgPNSvfk1Fhhy97z3qo3PUX1Q1jRr
	 2dNrvbGjMGW1FqKKrMfKdMnOYumxQuAOYNTy0i1fviy9HjXmvUY4p8bDjh83ht9EjH
	 yYNATupCNzqj23A6fjAnQZotlcbf/AcIWq7SPsN2wMldKWCJpNeeAVJfDGraO9mfkL
	 nu1POz8pU9cnmrPtuY8NQqHP6jmqW67hqV/EN6svLc1HdzcViESWbiCV6jJzitD/1o
	 cUcK4jBAfhGPw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WwDG04LmLz4wnw;
	Fri, 30 Aug 2024 20:01:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Cc: Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Jason
 A . Donenfeld" <Jason@zx2c4.com>, Eric Biggers <ebiggers@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>, Andrew Morton
 <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 05/17] vdso: Avoid call to memset() by getrandom
In-Reply-To: <20240829180241.GJ29862@gate.crashing.org>
References: <20240827180819.GB2049@sol.localdomain>
 <20240827225330.GC29862@gate.crashing.org> <Zs8HirKLk-SrwTIu@zx2c4.com>
 <fc19bf63-d519-46e2-be70-80202c85ff92@app.fastmail.com>
 <20240828124519.GE29862@gate.crashing.org>
 <CAMj1kXGmDmxy75eP=rf_fzKmg0g_FeKV43jk2G_gibnKZBtVww@mail.gmail.com>
 <20240828162025.GG29862@gate.crashing.org>
 <CAMj1kXHZPfr2Sz78UrgsdX-2uBp0D1sCnznQnz5ZyMdiJq6rAA@mail.gmail.com>
 <20240828172538.GI29862@gate.crashing.org>
 <e5a36d98-c880-4d33-954a-2a05240ef02f@csgroup.eu>
 <20240829180241.GJ29862@gate.crashing.org>
Date: Fri, 30 Aug 2024 20:01:58 +1000
Message-ID: <87jzfye3c9.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Thu, Aug 29, 2024 at 07:36:38PM +0200, Christophe Leroy wrote:
>>=20
>>=20
>> Le 28/08/2024 =C3=A0 19:25, Segher Boessenkool a =C3=A9crit=C2=A0:
>> >
>> >>Not sure about static binaries, though: do those even use the VDSO?
>> >
>> >With "static binary" people usually mean "a binary not using any DSOs",
>> >I think the VDSO is a DSO, also in this respect?  As always, -static
>> >builds are *way* less problematic (and faster and smaller :-) )
>> >
>>=20
>> AFAIK on powerpc even static binaries use the vDSO, otherwise signals=20
>> don't work.
>
> How can that work?  Non-dynamic binaries do not use ld.so (that is the
> definition of a dynamic binary, even).  So they cannot link (at runtime)
> to any DSO (unless that is done manually?!)

At least for signals I don't think the application needs to know
anything about the VDSO. The kernel sets up the return to the signal
trampoline (in the VDSO), and as long as userspace returns from its
signal handler with blr it will land back on the trampoline.

cheers

