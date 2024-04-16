Return-Path: <linux-fsdevel+bounces-17069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF16D8A72D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 20:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A381F21A83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 18:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AD3134437;
	Tue, 16 Apr 2024 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GMhnFAjb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ixQmOQ/Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F052A132C1F;
	Tue, 16 Apr 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713290958; cv=none; b=SqNCjE1JgzJQNA3vD4pAmyt9XcPtjkhjnMjoHeNkdDjFc38rzwMJRxKoKnNGn4ts4FhpZc6bvORWl/ABwTIdUgtJcNxuECZDxglBP3n2Vkije+rHjGuOkADAIwQ0O97TEI1WjSzOZ18C16ugGfY+oSQ+h3J/kTEVwiJhud4ey3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713290958; c=relaxed/simple;
	bh=H8MrxffkceMumKJooGQ32Ry3ywid0CvWTua4pVRYLN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtMhSQ+EUtSTAjMSeTO+QN21B1lK+YV01ciDx5e2DtGEIrDkOzX7fwjUjLfue4dHTpbgjGeVPyZ6hSZKvadiLsUYaSvxdnw9nJ8WV3R2v6ogIyxfSx1uYgvEYiO6PmsZ+srMIa4SZ6iKOjI+t0iMRPA8b9tR7OwwS8H3kZ3qncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GMhnFAjb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ixQmOQ/Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Apr 2024 20:09:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713290953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKLrAI5OCUe/r2J49t7qM8eP1fCwVfsTtu23X+cbhBw=;
	b=GMhnFAjb5aq0fLq1hjaVwDC+5vKgO0aCNwGaU5Cg54Dwdl9OeS42slUU0vCDSUpV6s95+f
	So/JFdqMFwQ0NhjaqOe7zQ6d/VA+QxIwi1ucEUpCvWu3Z99MtkGTlNIi+1NEvgulAc7YK4
	mGvSc0PTS7Km/W9dDgIwMo0psk4jzZkt8Hjk2JQlw+oovvt5+rRdK1El/jdfj0lNyKmJM8
	K3c5LmVS0QcaJ04UQk8GV7B8uhyW95BRdfrKnE8JKF2ILPHxVKa8r24H2DSgA65SfvSj8e
	eEa7YmcRxOk5ZCcqgm4uc/7pdnlChnyC0eyqwezB7TpQ98nV0HvVanFPYH5acA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713290953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKLrAI5OCUe/r2J49t7qM8eP1fCwVfsTtu23X+cbhBw=;
	b=ixQmOQ/Z45c/M1fP70O0/XH6yLZ1zVX1OS5AAh3Zp3iBkAq1q4nMCxItjJ18ha6HRKoS0G
	uM/NfWOUolPOHiBA==
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
Message-ID: <20240416200910.294ea07b@namcao>
In-Reply-To: <875xwhuqrx.fsf@all.your.base.are.belong.to.us>
References: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
	<8734rlo9j7.fsf@all.your.base.are.belong.to.us>
	<Zh6KNglOu8mpTPHE@kernel.org>
	<20240416171713.7d76fe7d@namcao>
	<20240416173030.257f0807@namcao>
	<87v84h2tee.fsf@all.your.base.are.belong.to.us>
	<20240416181944.23af44ee@namcao>
	<875xwhuqrx.fsf@all.your.base.are.belong.to.us>
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
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index fa34cf55037b..f600cfee0aef 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -197,7 +197,6 @@ early_param("mem", early_mem);
> >  static void __init setup_bootmem(void)
> >  {
> >  	phys_addr_t vmlinux_end =3D __pa_symbol(&_end);
> > -	phys_addr_t max_mapped_addr;
> >  	phys_addr_t phys_ram_end, vmlinux_start;
> > =20
> >  	if (IS_ENABLED(CONFIG_XIP_KERNEL))
> > @@ -238,17 +237,9 @@ static void __init setup_bootmem(void)
> >  	/*
> >  	 * memblock allocator is not aware of the fact that last 4K bytes of
> >  	 * the addressable memory can not be mapped because of IS_ERR_VALUE
> > -	 * macro. Make sure that last 4k bytes are not usable by memblock
> > -	 * if end of dram is equal to maximum addressable memory.  For 64-bit
> > -	 * kernel, this problem can't happen here as the end of the virtual
> > -	 * address space is occupied by the kernel mapping then this check mu=
st
> > -	 * be done as soon as the kernel mapping base address is determined.
> > +	 * macro. Make sure that last 4k bytes are not usable by memblock.
> >  	 */
> > -	if (!IS_ENABLED(CONFIG_64BIT)) {
> > -		max_mapped_addr =3D __pa(~(ulong)0);
> > -		if (max_mapped_addr =3D=3D (phys_ram_end - 1))
> > -			memblock_set_current_limit(max_mapped_addr - 4096);
> > -	}
> > +	memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE);
> > =20
> >  	min_low_pfn =3D PFN_UP(phys_ram_base);
> >  	max_low_pfn =3D max_pfn =3D PFN_DOWN(phys_ram_end); =20
>=20
> Nice! Would you mind submitting this as a proper fix (unless there's a
> way to do it non-arch specific like Matthew pointed out).

I don't mind, but I am waiting for the discussion on the non-arch solution.

Best regards,
Nam

