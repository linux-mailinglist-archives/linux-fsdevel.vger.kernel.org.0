Return-Path: <linux-fsdevel+bounces-27130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C210395ED95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 11:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A48282F42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648D8146585;
	Mon, 26 Aug 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bmPESgmv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZbN8bFkN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF81D143C70;
	Mon, 26 Aug 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724665423; cv=none; b=ksD1OZn9FiFiAOYXKr5MyyhXraMQZpWxK6lH/tVZp8V9RBE9kaoTI2iZ9NJI33DXG+gaFM4kPc+blo3sImGq2Uy3XrZXxgHVufAijXIuFuWMoj3HPCvsX9StUdnTnFarLM3lZ87AIhUcvbdF1KexjHF/NAbYsmw6nm33vYyDAmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724665423; c=relaxed/simple;
	bh=S0E2hl8Sw8JnJBQLHmT3c7HPhPVn6TItCR8uBaquQBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fIKo0aMa1uWBy0rsXPtwoVomktJTAAExvD5VXHtg3ECh7XFJzW0vCnrFJ7gx2Li0g7qM1zhq8odyiZjaHuW0cAfD3v2rs8YxrZ/mkLD65z2ElNXqefp1/Ei3XRnysC7LaA5MO/kefvft2lFCQd5cNMdWwWHKOTXBB5j7mtgwv1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bmPESgmv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZbN8bFkN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724665419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWCfkFVrFX69lQNtUh8BUdPXl70d8BgaQObUYTFPILY=;
	b=bmPESgmvVam6uU5EAujJz26OEz8vzU03VRka4i/NIHfcO0tvLgMQav7QZ5wjTdfWFsNZH9
	m/gcxCTXSaKrbFiJAtNTWkcCn1a4ZunRuUUoasin6t7EouB8Eg23E4cfndiKovgeCSQBYz
	azCmo6HpVRPPD0uWfpN6UMp4NrWbg+2sai7ZfHfA28PTcveLz6HognVZljULJOMHYICWRp
	VlNJmgDeTme9YI6usDRrT/0HoBj4xWY9nfw/nLeYCWL6cVZ/si5qxe+gtgS5GjTf0oU+vX
	STEm/BzYUg4sR/eJdC/VhwDD25Hbdt9UUcQHMGTfQYacZgFTJvpW65ZPJ3hWzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724665419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWCfkFVrFX69lQNtUh8BUdPXl70d8BgaQObUYTFPILY=;
	b=ZbN8bFkNzXf9ozXai8sskpGXdUYpkAo5Nk+tQIsKhxqftJyTPMZ0uuNnAKau3plmtS1IaZ
	Iofyp0/mQc8sPZBw==
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
Subject: Re: [PATCH v2 06/17] vdso: Change getrandom's generation to
 unsigned long
In-Reply-To: <7d58be73-a8e5-4ec7-bbdc-238b0c25c77b@csgroup.eu>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <525b48eb79978ddba2d1b8ee23b27bd6c5b0b4ee.1724309198.git.christophe.leroy@csgroup.eu>
 <Zswzu1l3xO99KN3I@zx2c4.com>
 <7d58be73-a8e5-4ec7-bbdc-238b0c25c77b@csgroup.eu>
Date: Mon, 26 Aug 2024 11:43:39 +0200
Message-ID: <87v7znd3g4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26 2024 at 10:01, Christophe Leroy wrote:
> Le 26/08/2024 =C3=A0 09:50, Jason A. Donenfeld a =C3=A9crit=C2=A0:
>> But tglx pointed out in that thread that this actually isn't necessary:
>>=20
>> | All of this is pointless because if a 32-bit application runs on a
>> | 64-bit kernel it has to use the 64-bit 'generation'. So why on earth do
>> | we need magic here for a 32-bit kernel?
>> |
>> | Just use u64 for both and spare all this voodoo. We're seriously not
>> | "optimizing" for 32-bit kernels.
>> |
>> | All what happens on a 32-bit kernel is that the RNG will store the
>> | unsigned long (32bit) generation into a 64bit variable:
>> |
>> | 	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
>> |
>> | As the upper 32bit are always zero, there is no issue vs. load store
>> | tearing at all. So there is zero benefit for this aside of slightly
>> | "better" user space code when running on a 32-bit kernel. Who cares?
>>=20
>> So I just got rid of it and used a u64 as he suggested.
>>=20
>> However, there's also an additional reason why it's not worth churning
>> further over this - because VM_DROPPABLE is 64-bit only (due to flags in
>> vma bits), likely so is vDSO getrandom() for the time being. So I think
>> it makes more sense to retool this series to be ppc64, and then if you
>> really really want 32-bit and can convince folks it matters, then all of
>> these parts (for example, here, the fact that the smp helper doesn't
>> want to tear) can be fixed up in a separate series.
>
> So yes I really really want it on ppc32 because this is the only type of=
=20
> boards I have and this is really were we need getrandom() to be=20
> optimised,

For nostalgic reasons?

> indeed ppc64 was sherry-on-the-cake in my series, I just added it
> because it was easy to do after doing ppc32.

The rng problem for ppc32 seems to be:

   smp_store_release(&_vdso_rng_data.generation, next_gen + 1);

right?=20

Your proposed type change creates inconsistency for 32-bit userspace
running on 64-bit kernels because the data struct layout changes.

As explained before, there is no problem with store or load tearing on
32bit systems because the generation counter is only 32bit wide. So the
obvious solution is to only update 32 bits on a 32bit kernel:

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -282,7 +282,7 @@ static void crng_reseed(struct work_stru
 	 * is ordered with the write above to base_crng.generation. Pairs with
 	 * the smp_rmb() before the syscall in the vDSO code.
 	 */
-	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
+	smp_store_release((unsigned long *)&_vdso_rng_data.generation, next_gen +=
 1);
 #endif
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init =3D CRNG_READY;

Which is perfectly fine on 32-bit independent of endianess because the
user space side does READ_ONCE(data->generation) and the read value is
solely used for comparison so it does not matter at all whether the
generation information is in the upper or the lower 32bit of the u64.

No?

But that's a trivial fix compared to making VM_DROPPABLE work on 32-bit
correclty. :)

Thanks,

        tglx

