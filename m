Return-Path: <linux-fsdevel+bounces-17046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623828A6F82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 17:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8574B1C216C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 15:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46006130A7F;
	Tue, 16 Apr 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1rjHsmK8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xCB8nmTp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0749B130491;
	Tue, 16 Apr 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280642; cv=none; b=X+MxaiXJFkJBqhQHvDGjWwKdX50gnquO2vD5kFj9MH8qB3xmbxyjccFpXYXZroiEu870hMupAgg7XQj7LGXycOOX5rdwQg58vXCuG53QY6leT/TbhKVOTnW+vUld28rgvOcnjCgGkHEEj7EAtrKT7bf76JYGuNQusm6Sp+39sG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280642; c=relaxed/simple;
	bh=8N7kn/veswkPTZ2V4/nm3UuOUEsty6IwODyIV+m3odE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAwJfXAT06y71hhq05vpvO0b5MiiUe74DvC3ghPCoBFFEAxoAiD3MMmyQUqa+erV3xlbTLu1hm2V+mSQCY5OMppVChB+yZt153S4TTAec3CY0uhsp8iX+clQ5xanFxsp6TJySfdCeXRjurz1NMsknuVdY/1FmP8vQ04oXQvTRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1rjHsmK8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xCB8nmTp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Apr 2024 17:17:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713280636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SS0ZeV6erFMkAKB6pTGu7Q4XhRszm7ibCxDeTjsPTw0=;
	b=1rjHsmK8SlMFbSBgC6CMkwF5pQ3o1WAoeOBxdKI2KXUeZCv77Tkk1pg+nNIBGBaESPYOd3
	goSyvQIsvuouHfTftW95qJJ6ISPHnbNRPpDZFjcvyFEvfOJscQI36Ehdznj/fVqukxB/qb
	ZP+xBgdZSPWPfthYwCl1CDuhDY+Gj0ySpmNWubWGvYsmlq+zrukDyyF4r6gyu0NYNu27xy
	oNLNGVFaOddzjBk66FmUqtRE/VgdfS1SXYkJNiNM0h84xtjYXTqKFX/rw2VqFLyRuERLLL
	TEJ+JEnHS07rj6xJ4UfHit8VsoqbvIXIxDCOB2weRrdCr/KBv9bTSb5OFefHVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713280636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SS0ZeV6erFMkAKB6pTGu7Q4XhRszm7ibCxDeTjsPTw0=;
	b=xCB8nmTpm7UCjnVOxsp+XAtGA73a7DsdqFIdCsNrCpoMIP5/uXiwG/ZCDCE+Trg6PUQTlp
	FzpA2pmR2XnIwGDQ==
From: Nam Cao <namcao@linutronix.de>
To: Mike Rapoport <rppt@kernel.org>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Andreas Dilger <adilger@dilger.ca>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jan Kara <jack@suse.cz>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, Theodore
 Ts'o <tytso@mit.edu>, Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Conor Dooley <conor@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Anders Roxell <anders.roxell@linaro.org>, Alexandre
 Ghiti <alex@ghiti.fr>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240416171713.7d76fe7d@namcao>
In-Reply-To: <Zh6KNglOu8mpTPHE@kernel.org>
References: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
	<8734rlo9j7.fsf@all.your.base.are.belong.to.us>
	<Zh6KNglOu8mpTPHE@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2024-04-16 Mike Rapoport wrote:
> Hi,
>=20
> On Tue, Apr 16, 2024 at 01:02:20PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> > Christian Brauner <brauner@kernel.org> writes:
> >=20
> > > [Adding Mike who's knowledgeable in this area]
> >=20
> > >> > Further, it seems like riscv32 indeed inserts a page like that to =
the
> > >> > buddy allocator, when the memblock is free'd:
> > >> >=20
> > >> >   | [<c024961c>] __free_one_page+0x2a4/0x3ea
> > >> >   | [<c024a448>] __free_pages_ok+0x158/0x3cc
> > >> >   | [<c024b1a4>] __free_pages_core+0xe8/0x12c
> > >> >   | [<c0c1435a>] memblock_free_pages+0x1a/0x22
> > >> >   | [<c0c17676>] memblock_free_all+0x1ee/0x278
> > >> >   | [<c0c050b0>] mem_init+0x10/0xa4
> > >> >   | [<c0c1447c>] mm_core_init+0x11a/0x2da
> > >> >   | [<c0c00bb6>] start_kernel+0x3c4/0x6de
> > >> >=20
> > >> > Here, a page with VA 0xfffff000 is a added to the freelist. We wer=
e just
> > >> > lucky (unlucky?) that page was used for the page cache.
> > >>=20
> > >> I just educated myself about memory mapping last night, so the below
> > >> may be complete nonsense. Take it with a grain of salt.
> > >>=20
> > >> In riscv's setup_bootmem(), we have this line:
> > >> 	max_low_pfn =3D max_pfn =3D PFN_DOWN(phys_ram_end);
> > >>=20
> > >> I think this is the root cause: max_low_pfn indicates the last page
> > >> to be mapped. Problem is: nothing prevents PFN_DOWN(phys_ram_end) fr=
om
> > >> getting mapped to the last page (0xfffff000). If max_low_pfn is mapp=
ed
> > >> to the last page, we get the reported problem.
> > >>=20
> > >> There seems to be some code to make sure the last page is not used
> > >> (the call to memblock_set_current_limit() right above this line). It=
 is
> > >> unclear to me why this still lets the problem slip through.
> > >>=20
> > >> The fix is simple: never let max_low_pfn gets mapped to the last pag=
e.
> > >> The below patch fixes the problem for me. But I am not entirely sure=
 if
> > >> this is the correct fix, further investigation needed.
> > >>=20
> > >> Best regards,
> > >> Nam
> > >>=20
> > >> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > >> index fa34cf55037b..17cab0a52726 100644
> > >> --- a/arch/riscv/mm/init.c
> > >> +++ b/arch/riscv/mm/init.c
> > >> @@ -251,7 +251,8 @@ static void __init setup_bootmem(void)
> > >>  	}
> > >> =20
> > >>  	min_low_pfn =3D PFN_UP(phys_ram_base);
> > >> -	max_low_pfn =3D max_pfn =3D PFN_DOWN(phys_ram_end);
> > >> +	max_low_pfn =3D PFN_DOWN(memblock_get_current_limit());
> > >> +	max_pfn =3D PFN_DOWN(phys_ram_end);
> > >>  	high_memory =3D (void *)(__va(PFN_PHYS(max_low_pfn)));
> > >> =20
> > >>  	dma32_phys_limit =3D min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_=
low_pfn));
> >=20
> > Yeah, AFAIU memblock_set_current_limit() only limits the allocation from
> > memblock. The "forbidden" page (PA 0xc03ff000 VA 0xfffff000) will still
> > be allowed in the zone.
> >=20
> > I think your patch requires memblock_set_current_limit() is
> > unconditionally called, which currently is not done.
> >=20
> > The hack I tried was (which seems to work):
> >=20
> > --
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index fe8e159394d8..3a1f25d41794 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -245,8 +245,10 @@ static void __init setup_bootmem(void)
> >          */
> >         if (!IS_ENABLED(CONFIG_64BIT)) {
> >                 max_mapped_addr =3D __pa(~(ulong)0);
> > -               if (max_mapped_addr =3D=3D (phys_ram_end - 1))
> > +               if (max_mapped_addr =3D=3D (phys_ram_end - 1)) {
> >                         memblock_set_current_limit(max_mapped_addr - 40=
96);
> > +                       phys_ram_end -=3D 4096;
> > +               }
> >         }
>=20
> You can just memblock_reserve() the last page of the first gigabyte, e.g.

"last page of the first gigabyte" - why first gigabyte? Do you mean
last page of *last* gigabyte?

> 	if (!IS_ENABLED(CONFIG_64BIT)
> 		memblock_reserve(SZ_1G - PAGE_SIZE, PAGE_SIZE);
>=20
> The page will still be mapped, but it will never make it to the page
> allocator.
>=20
> The nice thing about it is, that memblock lets you to reserve regions tha=
t are
> not necessarily populated, so there's no need to check where the actual R=
AM
> ends.

I tried the suggested code, it didn't work. I think there are 2
mistakes:
 - last gigabyte, not first
 - memblock_reserve() takes physical addresses as arguments, not
   virtual addresses

The below patch fixes the problem. Is this what you really meant?

Best regards,
Nam

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fa34cf55037b..ac7efdd77be8 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -245,6 +245,7 @@ static void __init setup_bootmem(void)
 	 * be done as soon as the kernel mapping base address is determined.
 	 */
 	if (!IS_ENABLED(CONFIG_64BIT)) {
+		memblock_reserve(__pa(-PAGE_SIZE), __pa(PAGE_SIZE));
 		max_mapped_addr =3D __pa(~(ulong)0);
 		if (max_mapped_addr =3D=3D (phys_ram_end - 1))
 			memblock_set_current_limit(max_mapped_addr - 4096);


