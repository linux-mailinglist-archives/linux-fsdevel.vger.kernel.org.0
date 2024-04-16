Return-Path: <linux-fsdevel+bounces-17050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F3E8A70BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 18:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D911F264B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC70131BD6;
	Tue, 16 Apr 2024 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzG0c6gX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A863131756;
	Tue, 16 Apr 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282989; cv=none; b=KvnL8NE5t+DM9E57D4gK8SVATy9fP0uNjs4qwv2QKPBPRjBWtR6Dap3yYy8SLxGyq7iYw/YfMLpDEc6s+DZOWWTysUSnoYnY5CT/jwoNzJaFai7auEBRX2PrLPjvH/It3ppwnfwHJg3XyfqZkqI18Xor/CjB4XW3Cm63YXQmV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282989; c=relaxed/simple;
	bh=xj5oIWlYq20UZfWwDIb9TzDyZ90WyaHjoi8dkpzi3hY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KNGXRcXEN5N6sk6sit5dCslNqB6WpfMvTZ5z4gigUfq1ciygg0lQX58UoJQSBfTMxij1ou8aMmsls0WzA4wJCJAIAjnJpR5Y4ABqNxb5WLLsyWb+MFl1/DKekdfdF5fXyVJPi8Heqzgzc/UyIVWB3+qHJ4s+1V1b+TvMbTShIew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzG0c6gX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792D7C113CE;
	Tue, 16 Apr 2024 15:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713282989;
	bh=xj5oIWlYq20UZfWwDIb9TzDyZ90WyaHjoi8dkpzi3hY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PzG0c6gXNNiSNW/OjmEVa1jcml2jIk4toUumXHj1PFWRlW2puT5qUARDvSSBmZTld
	 GCIGfOAW1VrnjTIUNavavaDJSr1Gd6sgvwCnf1q1E4zJyQ0c/2xGB5qkqPuFUmSIP1
	 WV83tvTswwBRItV5wgDOF4QtZpNeolSypSzp89MKMt8qQE86rh4Q29J08tgh8oa8vy
	 8gNUYmIGxZIwan4Vu3AM5C0yy0H+O3SMqtkvl1DpLDRJDWwL9UuARjO2nZ4x38Sxtx
	 RyRhgZY0gKSJaLestj4GkhWJgONsgLu4ePJn4xXcsB8Mbs8Dgr/UxuVimLexjZD4DM
	 NWD56iIML/gfQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Nam Cao <namcao@linutronix.de>, Mike Rapoport <rppt@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Andreas Dilger
 <adilger@dilger.ca>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Theodore
 Ts'o <tytso@mit.edu>, Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Conor Dooley <conor@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Anders Roxell <anders.roxell@linaro.org>, Alexandre
 Ghiti <alex@ghiti.fr>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
In-Reply-To: <20240416173030.257f0807@namcao>
References: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
 <8734rlo9j7.fsf@all.your.base.are.belong.to.us>
 <Zh6KNglOu8mpTPHE@kernel.org> <20240416171713.7d76fe7d@namcao>
 <20240416173030.257f0807@namcao>
Date: Tue, 16 Apr 2024 17:56:25 +0200
Message-ID: <87v84h2tee.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nam Cao <namcao@linutronix.de> writes:

> Fixed version:
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fa34cf55037b..af4192bc51d0 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -245,6 +245,7 @@ static void __init setup_bootmem(void)
>  	 * be done as soon as the kernel mapping base address is determined.
>  	 */
>  	if (!IS_ENABLED(CONFIG_64BIT)) {
> +		memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE);
>  		max_mapped_addr =3D __pa(~(ulong)0);
>  		if (max_mapped_addr =3D=3D (phys_ram_end - 1))
>  			memblock_set_current_limit(max_mapped_addr - 4096);

Nice!

Can't we get rid of the if-statement, and max_mapped_address as well?


Bj=C3=B6rn

