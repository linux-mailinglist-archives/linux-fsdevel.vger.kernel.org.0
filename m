Return-Path: <linux-fsdevel+bounces-17208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50718A8EC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 00:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4351C20FCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71269142905;
	Wed, 17 Apr 2024 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="LyZlL72C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2547134CED
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713391843; cv=none; b=CQvBLX8hesBll6Dtf5tTwXvct93V2qRhL86wT+EnHQiLtnNfuRmaYGp3/OB5z8K9VcylKgEa01m5LHBkGgGHuFT2lhZI0ILVUMyN0X/lpZTWlaCgQZsPRlcskcDcSYvZ/7RT1Jtr3qUIKO/jl34a7/nJxwa9EqmDb0CZBwuAOPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713391843; c=relaxed/simple;
	bh=qvdEufpLC+fkHlvr1x7Zyw2PCjCYD8dZvdv6VijPd2o=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=iOPoWK468SjVRkfmMAA7U6uHn1SIeMBv90KBXyU0sEy/pM3dSrSVWbZ27uL6kA+3fqgXG2Lvo2u/U8UlzXNPPjqu7EJ5Xlx+jMKUljml80kgXON+w+iOg4lcTRG8+ddLUsgIc3bBemd9m9UeIiVLp0Y63lvnuCmGLJ6pudj6HXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=LyZlL72C; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so268923b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 15:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1713391841; x=1713996641; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wYhm/fOOjEK7jdgzj7y/SioxE02f8LD3ZE3uraqJyMQ=;
        b=LyZlL72CoKIvP0L5+zoP4RYx7GFEdxg+miLRl6jEJC3FQNTf8pL0iE3eO5KGkvtsZX
         bgF2fkykfd5ZiysGGHud4SGwL588avbTS2q42N8MOMd0hJCLYK97+8IvlYURIUMIpuaQ
         gtSgQBG4Xheok1wjtl+GinBZresOMUhvznbbLtDtBf+VKoL0SG5eMab2c6HRwu1EXxYx
         9OpvoJn9Ps16XyjWh88bZkN5ARoUmOMlx1dJ9L0/GRnFNV8zcmHRSzU//yRsKEAl9Z0k
         O+7S5jdyePOHrzLXkCDijEqHq5qjFYQd85N0R02icOfuaNe1GjsUdZyDA3a5gVHf4DR3
         FU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713391841; x=1713996641;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYhm/fOOjEK7jdgzj7y/SioxE02f8LD3ZE3uraqJyMQ=;
        b=VSdCqssbDo7NeBGKPcSBTjkELLXLwsB3UP8vBLjpdovHtHl+fquG/63WN84UZx3iJW
         8OzCQIfuPoTu9+NGpgWhJngX1Ua7+7nzl0DZoVVzX+IG8vxbJJnh1+hnKVozSFLfJ+S6
         odFxQ60XAzSg5hhoUicNWNvthoejCOvUl3EG1JbbAHujqoAq5WDDsFGjhT2U6EBWoQAi
         2RQwsTHKcjtoARvqNdQhMFjKV1F+CaW38pDYOpj6tHYVYbz+t1e3Q6WHhqnEoPWPaZpJ
         Hj0gtq8c6Kd5OQLHaCfPtgu0+z3GE3Mw8/MAoTEo+71cE1X3rFMMLfH/i1RX77dgEdAh
         gMEA==
X-Forwarded-Encrypted: i=1; AJvYcCV0OHoA45JrcxSTZo4ph18FJLN0DaibXrvQSccVt138Um2b9HEppw0TjMcP/JHxU+Ci6KTV/1hmkM/IGvPa0gdnTtMFhgtqYPvh5CoGkA==
X-Gm-Message-State: AOJu0YzYiIpenU2/PD/3QlJid+hd42+wW6WgAxcWSEIEVMb0hU1AuXG7
	htBGpTwVOjUY00WMYNbglNqF/Uvtq9zpB2yadSKnE2pR76rAEetPbHYuEUlQjuU=
X-Google-Smtp-Source: AGHT+IH3MYkMR8IPHkvuF/qL6uC7V9sKI5rYU7z0ZR3m/5HrAQlViqnnmV0nty+c2HEAzwnUFgRgbA==
X-Received: by 2002:a05:6a21:3483:b0:1aa:9561:1342 with SMTP id yo3-20020a056a21348300b001aa95611342mr457129pzb.35.1713391841276;
        Wed, 17 Apr 2024 15:10:41 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id h17-20020a62b411000000b006edd05e3751sm159808pfn.176.2024.04.17.15.10.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2024 15:10:40 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <1F07FFF3-663B-43D4-A9DA-C89856F2962A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B97920C0-75B2-43B7-A029-2F2368082F1C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Date: Wed, 17 Apr 2024 16:09:23 -0600
In-Reply-To: <20240417003639.13bfd801@namcao>
Cc: Mike Rapoport <rppt@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Jan Kara <jack@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org,
 Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Conor Dooley <conor@kernel.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Alexandre Ghiti <alex@ghiti.fr>
To: Nam Cao <namcao@linutronix.de>
References: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
 <8734rlo9j7.fsf@all.your.base.are.belong.to.us> <Zh6KNglOu8mpTPHE@kernel.org>
 <20240416171713.7d76fe7d@namcao> <20240416173030.257f0807@namcao>
 <87v84h2tee.fsf@all.your.base.are.belong.to.us>
 <20240416181944.23af44ee@namcao> <Zh6n-nvnQbL-0xss@kernel.org>
 <Zh6urRin2-wVxNeq@casper.infradead.org> <Zh7Ey507KXIak8NW@kernel.org>
 <20240417003639.13bfd801@namcao>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_B97920C0-75B2-43B7-A029-2F2368082F1C
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Apr 16, 2024, at 4:36 PM, Nam Cao <namcao@linutronix.de> wrote:
> 
> On 2024-04-16 Mike Rapoport wrote:
>> On Tue, Apr 16, 2024 at 06:00:29PM +0100, Matthew Wilcox wrote:
>>> On Tue, Apr 16, 2024 at 07:31:54PM +0300, Mike Rapoport wrote:
>>>>> -	if (!IS_ENABLED(CONFIG_64BIT)) {
>>>>> -		max_mapped_addr = __pa(~(ulong)0);
>>>>> -		if (max_mapped_addr == (phys_ram_end - 1))
>>>>> -			memblock_set_current_limit(max_mapped_addr - 4096);
>>>>> -	}
>>>>> +	memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE);
>>>> 
>>>> Ack.
>>> 
>>> Can this go to generic code instead of letting architecture maintainers
>>> fall over it?
>> 
>> Yes, it's just have to happen before setup_arch() where most architectures
>> enable memblock allocations.
> 
> This also works, the reported problem disappears.
> 
> However, I am confused about one thing: doesn't this make one page of
> physical memory inaccessible?
> 
> Is it better to solve this by setting max_low_pfn instead? Then at
> least the page is still accessible as high memory.

Is that one page of memory really worthwhile to preserve?  Better to
have a simple solution that works, maybe even mapping that page
read-only so that any code which tries to dereference an ERR_PTR
address immediately gets a fault?

Cheers, Andreas

> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fa34cf55037b..6e3130cae675 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -197,7 +197,6 @@ early_param("mem", early_mem);
> static void __init setup_bootmem(void)
> {
> 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
> -	phys_addr_t max_mapped_addr;
> 	phys_addr_t phys_ram_end, vmlinux_start;
> 
> 	if (IS_ENABLED(CONFIG_XIP_KERNEL))
> @@ -235,23 +234,9 @@ static void __init setup_bootmem(void)
> 	if (IS_ENABLED(CONFIG_64BIT))
> 		kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
> 
> -	/*
> -	 * memblock allocator is not aware of the fact that last 4K bytes of
> -	 * the addressable memory can not be mapped because of IS_ERR_VALUE
> -	 * macro. Make sure that last 4k bytes are not usable by memblock
> -	 * if end of dram is equal to maximum addressable memory.  For 64-bit
> -	 * kernel, this problem can't happen here as the end of the virtual
> -	 * address space is occupied by the kernel mapping then this check must
> -	 * be done as soon as the kernel mapping base address is determined.
> -	 */
> -	if (!IS_ENABLED(CONFIG_64BIT)) {
> -		max_mapped_addr = __pa(~(ulong)0);
> -		if (max_mapped_addr == (phys_ram_end - 1))
> -			memblock_set_current_limit(max_mapped_addr - 4096);
> -	}
> -
> 	min_low_pfn = PFN_UP(phys_ram_base);
> -	max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
> +	max_pfn = PFN_DOWN(phys_ram_end);
> +	max_low_pfn = min(max_pfn, PFN_DOWN(__pa(-PAGE_SIZE)));
> 	high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
> 
> 	dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));


Cheers, Andreas






--Apple-Mail=_B97920C0-75B2-43B7-A029-2F2368082F1C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYgSN0ACgkQcqXauRfM
H+DTLw/9EwRBw0cRdgYXbwAYsBH4sVkfgtbtkgDwHRrlhS6n2fVLjymfTmEtn++p
28ksq83sFuQ/G5E6hPw5WOrOygWfww4hjLLM3kGvHf0iiMc7hR4ElbGEMbY8Iyu7
dA8A0aStRJHcJpYi0aMfUF2SCnCIAp1Q11JFgfw3g2sqNSWMUTw22R57BD6W8GJB
3zD+y/EhOWzT28zBq8sB55ynr6TVQXf/G/M7Kdr6QQ98oXEDVYLtdT0B0p4JaHXM
TxQkijrAIJHHZ4oWd2B749JUwoq4zqtCUp9jaJkwfvuL2889TOdxNV4Ae0LHv51t
k+N5NsQ8WILPQ+sIJezIHxswFkHLiczoVw6W9J/JQOq3PmiF3JeADAsLOgPOA7VH
8bicPF2GT+yi7amnzN5pdl7oB0rk/qQMlotJjzfCZpx/7hKOjeAA3m4PGLJDNnWV
XaW47LVUJxk+LKjhTRIWXReNWVfpEMi/YnVyLSVg5CNl7FQPYq6ybhnVbwlOmcUr
WZCqFJGuomrHtqOUSC/+oW2rREHDhw6s+noEC/g0X8sn5cfMMZognwxvqzgLd7AF
taLTLPGuzc9PcbBlNRfapmCFUczLvbWY1+SjVh3Im8Yq2yaS95J/1kzSkSodexqh
9qHDAikxwiGJxK9HeqITFGaXg+Y9mn+frUuzKfFm1w2koGweqaI=
=VbKS
-----END PGP SIGNATURE-----

--Apple-Mail=_B97920C0-75B2-43B7-A029-2F2368082F1C--

