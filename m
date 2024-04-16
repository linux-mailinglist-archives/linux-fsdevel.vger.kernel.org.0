Return-Path: <linux-fsdevel+bounces-17051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8058A7131
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 18:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8621F22E1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 16:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7142131E21;
	Tue, 16 Apr 2024 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kJN1kvZz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4XT0Vx5x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8712D741;
	Tue, 16 Apr 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284392; cv=none; b=rxNzIMBL83f7RV8oDKpIgDV+j6H7zsqd3NGz4bIsN8pRP8u9c04TYg9afLAfwwVgSenwwVZZMKoTsgV+AYEayopLJlQd+Lvm3rAv/e2NTJSpwLmDqjoOMO27qAbllJFO2D4VmrpTPIsENfN/RAaF1Gfh8+3DQYNrjw32WupkKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284392; c=relaxed/simple;
	bh=u8QCJiuXj8GqdD/HN6uB24dbcQOucYXQvVmuYLSt1EE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRm+HQYCrqOGAT6Ay2UrNVcv1wBSB8LtF89zATB7F6cK0M+on9gK+NLrBAnGLedwiemsPhsyR5NgqcsuSr7DMD/DiNujjsmRtyyC0Omb2jBnhllc/cSvJjHAw/zzPHp4SopgdI1MyZqMi66FvJye8wDhdwSOb7d8p8xyAl9k9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kJN1kvZz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4XT0Vx5x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Apr 2024 18:19:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713284387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A23kAXEf9C2KhbYlAYQaiPt99jI8MlAVS/+Sw78HXwk=;
	b=kJN1kvZz5VI9X1N44mbAnqG+ChDEeeB8pSyDOQ6ehcAFkalZx0dHpMGO5OuOv4Vvth9DDO
	YIkd6myOE8E0VxNvTutlXGo5yVZnBn28av6knai5Q+ZnF2v9MsZfsuA/rD3M4vXJerWTMn
	buMdeVp9l2uCQJqtF7+Dc9cVFTOHT5/p70lcg/xocSDSggwmX1S8stgD+E0MS0UoWlYVTa
	5sq9E/LJ3rJMdxGXiG1eM9zOh0fpzg2XksNuZpcAFEX395HLswMEPpw5zgh1Bn+sy1dbVI
	NkPlvnarvQEiu0kNzsLznOIC91t1qIAQFcyVZnByx78jzgBPTBMt4g5fE8C5Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713284387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A23kAXEf9C2KhbYlAYQaiPt99jI8MlAVS/+Sw78HXwk=;
	b=4XT0Vx5xO8W/erNB63yAHRYfUcl16Pw8c0TDGAchcUnv7GWfAGkXmMBdMT37fDCP2dMi8A
	vE2JarnSJaBlAQDg==
From: Nam Cao <namcao@linutronix.de>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Andreas Dilger <adilger@dilger.ca>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Theodore Ts'o <tytso@mit.edu>, Ext4
 Developers List <linux-ext4@vger.kernel.org>, Conor Dooley
 <conor@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Anders
 Roxell <anders.roxell@linaro.org>, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240416181944.23af44ee@namcao>
In-Reply-To: <87v84h2tee.fsf@all.your.base.are.belong.to.us>
References: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
	<8734rlo9j7.fsf@all.your.base.are.belong.to.us>
	<Zh6KNglOu8mpTPHE@kernel.org>
	<20240416171713.7d76fe7d@namcao>
	<20240416173030.257f0807@namcao>
	<87v84h2tee.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2024-04-16 Bj=C3=B6rn T=C3=B6pel wrote:
> Nam Cao <namcao@linutronix.de> writes:
>=20
> > Fixed version:
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index fa34cf55037b..af4192bc51d0 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -245,6 +245,7 @@ static void __init setup_bootmem(void)
> >  	 * be done as soon as the kernel mapping base address is determined.
> >  	 */
> >  	if (!IS_ENABLED(CONFIG_64BIT)) {
> > +		memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE);
> >  		max_mapped_addr =3D __pa(~(ulong)0);
> >  		if (max_mapped_addr =3D=3D (phys_ram_end - 1))
> >  			memblock_set_current_limit(max_mapped_addr - 4096); =20
>=20
> Nice!
>=20
> Can't we get rid of the if-statement, and max_mapped_address as well?

I don't see why not :D

Best regards,
Nam

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fa34cf55037b..f600cfee0aef 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -197,7 +197,6 @@ early_param("mem", early_mem);
 static void __init setup_bootmem(void)
 {
 	phys_addr_t vmlinux_end =3D __pa_symbol(&_end);
-	phys_addr_t max_mapped_addr;
 	phys_addr_t phys_ram_end, vmlinux_start;
=20
 	if (IS_ENABLED(CONFIG_XIP_KERNEL))
@@ -238,17 +237,9 @@ static void __init setup_bootmem(void)
 	/*
 	 * memblock allocator is not aware of the fact that last 4K bytes of
 	 * the addressable memory can not be mapped because of IS_ERR_VALUE
-	 * macro. Make sure that last 4k bytes are not usable by memblock
-	 * if end of dram is equal to maximum addressable memory.  For 64-bit
-	 * kernel, this problem can't happen here as the end of the virtual
-	 * address space is occupied by the kernel mapping then this check must
-	 * be done as soon as the kernel mapping base address is determined.
+	 * macro. Make sure that last 4k bytes are not usable by memblock.
 	 */
-	if (!IS_ENABLED(CONFIG_64BIT)) {
-		max_mapped_addr =3D __pa(~(ulong)0);
-		if (max_mapped_addr =3D=3D (phys_ram_end - 1))
-			memblock_set_current_limit(max_mapped_addr - 4096);
-	}
+	memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE);
=20
 	min_low_pfn =3D PFN_UP(phys_ram_base);
 	max_low_pfn =3D max_pfn =3D PFN_DOWN(phys_ram_end);


