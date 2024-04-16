Return-Path: <linux-fsdevel+bounces-17068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B62F68A72C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 20:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71063284448
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 18:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DAA134437;
	Tue, 16 Apr 2024 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgo4Q4p1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4AD134405;
	Tue, 16 Apr 2024 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713290742; cv=none; b=DAzxnTW1OaZ5IwJ3CeOHUg9vuiSisnJUMNLdYxare0GWFBnqGD2PpRgxOc4gMzVERz45HQTpE8/KLulug8eFG8Q3w6UL34T1xPVNTK04h1sGVjxMNhJFQbFxxes9fXHSHUSUOc3naU9ea0d81+BkrBcLKOsJQuHfzLUTbfLLNjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713290742; c=relaxed/simple;
	bh=ofwzRbETYmRwC0pS8n9dd+EPWVyzyXzVpzRfaZ5N3ro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TBDIWM73injrFYZ2wu+ERtNZnz+C3e9CBNCJ0dprvBsfsFmV/S7ZzPuy0VEyv5tONGehuXKBoo6PQp720a6bpz6l3AqFsERz8TK8EW3kM2phYRrk9+BO3BANum4eJqtR6jEVoZEB02DmKVkL4/R5zv3XJu2/Q+oK1Ya1V4NDVK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgo4Q4p1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5310C2BD11;
	Tue, 16 Apr 2024 18:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713290742;
	bh=ofwzRbETYmRwC0pS8n9dd+EPWVyzyXzVpzRfaZ5N3ro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tgo4Q4p1d1p9T0puSKluE1QgYZa7w62lj9a8aH0yC4TeNdxnVmji8JSX+Bf4sgn3F
	 eYMgcoM9yOR5Io4NBynQVzUaTT5/syfShwg0UNBIeW9Id0U/kQIk1qqH9NmV+Cj27a
	 47gIOUAsyoLBzsU9COXbsbFn1GO3RC2GZ+QMPJCkj+GRIZcHD5QiP1sZHlr5rcYZyu
	 3sbr6n5gIMkjenovcrb8ogVhK+KO+0eOpTBDQupNx+h9Np8tLGSUoTo1SVGUKPB/2H
	 6I5hzm3QznH1igAiCrfCZF0kdZB+r6veXZb0qnoa5YV/lMOwj0v4wWRJrbHVsd0O2i
	 Xawofm9TvBNGQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Mike Rapoport <rppt@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Andreas Dilger <adilger@dilger.ca>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Theodore Ts'o <tytso@mit.edu>, Ext4
 Developers List <linux-ext4@vger.kernel.org>, Conor Dooley
 <conor@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Anders
 Roxell <anders.roxell@linaro.org>, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
In-Reply-To: <20240416181944.23af44ee@namcao>
References: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
 <8734rlo9j7.fsf@all.your.base.are.belong.to.us>
 <Zh6KNglOu8mpTPHE@kernel.org> <20240416171713.7d76fe7d@namcao>
 <20240416173030.257f0807@namcao>
 <87v84h2tee.fsf@all.your.base.are.belong.to.us>
 <20240416181944.23af44ee@namcao>
Date: Tue, 16 Apr 2024 20:05:38 +0200
Message-ID: <875xwhuqrx.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nam Cao <namcao@linutronix.de> writes:

> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fa34cf55037b..f600cfee0aef 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -197,7 +197,6 @@ early_param("mem", early_mem);
>  static void __init setup_bootmem(void)
>  {
>  	phys_addr_t vmlinux_end =3D __pa_symbol(&_end);
> -	phys_addr_t max_mapped_addr;
>  	phys_addr_t phys_ram_end, vmlinux_start;
>=20=20
>  	if (IS_ENABLED(CONFIG_XIP_KERNEL))
> @@ -238,17 +237,9 @@ static void __init setup_bootmem(void)
>  	/*
>  	 * memblock allocator is not aware of the fact that last 4K bytes of
>  	 * the addressable memory can not be mapped because of IS_ERR_VALUE
> -	 * macro. Make sure that last 4k bytes are not usable by memblock
> -	 * if end of dram is equal to maximum addressable memory.  For 64-bit
> -	 * kernel, this problem can't happen here as the end of the virtual
> -	 * address space is occupied by the kernel mapping then this check must
> -	 * be done as soon as the kernel mapping base address is determined.
> +	 * macro. Make sure that last 4k bytes are not usable by memblock.
>  	 */
> -	if (!IS_ENABLED(CONFIG_64BIT)) {
> -		max_mapped_addr =3D __pa(~(ulong)0);
> -		if (max_mapped_addr =3D=3D (phys_ram_end - 1))
> -			memblock_set_current_limit(max_mapped_addr - 4096);
> -	}
> +	memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE);
>=20=20
>  	min_low_pfn =3D PFN_UP(phys_ram_base);
>  	max_low_pfn =3D max_pfn =3D PFN_DOWN(phys_ram_end);

Nice! Would you mind submitting this as a proper fix (unless there's a
way to do it non-arch specific like Matthew pointed out).


Bj=C3=B6rn

