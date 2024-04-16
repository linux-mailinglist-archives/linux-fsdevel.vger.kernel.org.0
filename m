Return-Path: <linux-fsdevel+bounces-17043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD62E8A6E36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 16:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0A71C20621
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 14:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B4D12F598;
	Tue, 16 Apr 2024 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6i63qqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90412EBF4;
	Tue, 16 Apr 2024 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277566; cv=none; b=Sou2Vt5mTw0T+xqYfXPdUuh+4h7pUvaN5+5EQv+3PiyH32kboSEjfCRt78DMEBgFNZgx4+c/ZI+MYMXZwNDzhwy8Uw60rMmgbAR1iqTWLtk3Ws9AknbcaP4QL7gK678k6n8alKnp7uhiCUjXvrnbQwPy2Preyh7HzswCS7xeDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277566; c=relaxed/simple;
	bh=+WyAEAGU6dHhLinGMVbyeKjBMJ0Y7Iab03XXzCxzVcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jk2k11QhWCJRWmzcT6sV1lFBCJfQvyQYy/AD4umkEz1Q5Zw52UTM2qkDNDYF66ii0Iq1aHaal0E/ze7/tRtO3i3Kpba+n6JZoylZxKwNffK4uIj+nGK3VFAtX6DKXsfcbclam+Zj+M+xnYDFv2NHM+5bOEraT0xYij+7SuJrK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6i63qqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21F3C113CE;
	Tue, 16 Apr 2024 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713277565;
	bh=+WyAEAGU6dHhLinGMVbyeKjBMJ0Y7Iab03XXzCxzVcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o6i63qqjHVahoY2VfNPDCyb0QK609jpzZ/ri34IbAojt+ypV2GQclA9EITdH1PB/Z
	 M6f8dRbuu+3UifYh6LaZZAU8NXsVs3918Oe/xEACVlJZnr1BEi0Bp18OB3yZTZD/1Q
	 CgPcVUq2chF13nYnivPvDrSQWN6QLKgMyFfPrVkPCPM0Uu5ZfUGUXdk6KC6yAdQH0O
	 pVt/OdihXNnSPfO9iZyELa9gsZxYDc+iDQm5q0Jf1cI/aud0daCHBfrqyM2zCmhLqP
	 T4q+nEaE/5R7XyW1/jr/PUBeRWiBAWD6LGFmA984CU5+4TqxGGnaTCtnvdzgtT9ude
	 +8314dIjlCCTw==
Date: Tue, 16 Apr 2024 17:24:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Nam Cao <namcao@linutronix.de>,
	Andreas Dilger <adilger@dilger.ca>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-riscv@lists.infradead.org, Theodore Ts'o <tytso@mit.edu>,
	Ext4 Developers List <linux-ext4@vger.kernel.org>,
	Conor Dooley <conor@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <Zh6KNglOu8mpTPHE@kernel.org>
References: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
 <8734rlo9j7.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734rlo9j7.fsf@all.your.base.are.belong.to.us>

Hi,

On Tue, Apr 16, 2024 at 01:02:20PM +0200, Björn Töpel wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > [Adding Mike who's knowledgeable in this area]
> 
> >> > Further, it seems like riscv32 indeed inserts a page like that to the
> >> > buddy allocator, when the memblock is free'd:
> >> > 
> >> >   | [<c024961c>] __free_one_page+0x2a4/0x3ea
> >> >   | [<c024a448>] __free_pages_ok+0x158/0x3cc
> >> >   | [<c024b1a4>] __free_pages_core+0xe8/0x12c
> >> >   | [<c0c1435a>] memblock_free_pages+0x1a/0x22
> >> >   | [<c0c17676>] memblock_free_all+0x1ee/0x278
> >> >   | [<c0c050b0>] mem_init+0x10/0xa4
> >> >   | [<c0c1447c>] mm_core_init+0x11a/0x2da
> >> >   | [<c0c00bb6>] start_kernel+0x3c4/0x6de
> >> > 
> >> > Here, a page with VA 0xfffff000 is a added to the freelist. We were just
> >> > lucky (unlucky?) that page was used for the page cache.
> >> 
> >> I just educated myself about memory mapping last night, so the below
> >> may be complete nonsense. Take it with a grain of salt.
> >> 
> >> In riscv's setup_bootmem(), we have this line:
> >> 	max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
> >> 
> >> I think this is the root cause: max_low_pfn indicates the last page
> >> to be mapped. Problem is: nothing prevents PFN_DOWN(phys_ram_end) from
> >> getting mapped to the last page (0xfffff000). If max_low_pfn is mapped
> >> to the last page, we get the reported problem.
> >> 
> >> There seems to be some code to make sure the last page is not used
> >> (the call to memblock_set_current_limit() right above this line). It is
> >> unclear to me why this still lets the problem slip through.
> >> 
> >> The fix is simple: never let max_low_pfn gets mapped to the last page.
> >> The below patch fixes the problem for me. But I am not entirely sure if
> >> this is the correct fix, further investigation needed.
> >> 
> >> Best regards,
> >> Nam
> >> 
> >> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> >> index fa34cf55037b..17cab0a52726 100644
> >> --- a/arch/riscv/mm/init.c
> >> +++ b/arch/riscv/mm/init.c
> >> @@ -251,7 +251,8 @@ static void __init setup_bootmem(void)
> >>  	}
> >>  
> >>  	min_low_pfn = PFN_UP(phys_ram_base);
> >> -	max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
> >> +	max_low_pfn = PFN_DOWN(memblock_get_current_limit());
> >> +	max_pfn = PFN_DOWN(phys_ram_end);
> >>  	high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
> >>  
> >>  	dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));
> 
> Yeah, AFAIU memblock_set_current_limit() only limits the allocation from
> memblock. The "forbidden" page (PA 0xc03ff000 VA 0xfffff000) will still
> be allowed in the zone.
> 
> I think your patch requires memblock_set_current_limit() is
> unconditionally called, which currently is not done.
> 
> The hack I tried was (which seems to work):
> 
> --
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fe8e159394d8..3a1f25d41794 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -245,8 +245,10 @@ static void __init setup_bootmem(void)
>          */
>         if (!IS_ENABLED(CONFIG_64BIT)) {
>                 max_mapped_addr = __pa(~(ulong)0);
> -               if (max_mapped_addr == (phys_ram_end - 1))
> +               if (max_mapped_addr == (phys_ram_end - 1)) {
>                         memblock_set_current_limit(max_mapped_addr - 4096);
> +                       phys_ram_end -= 4096;
> +               }
>         }

You can just memblock_reserve() the last page of the first gigabyte, e.g.

	if (!IS_ENABLED(CONFIG_64BIT)
		memblock_reserve(SZ_1G - PAGE_SIZE, PAGE_SIZE);

The page will still be mapped, but it will never make it to the page
allocator.

The nice thing about it is, that memblock lets you to reserve regions that are
not necessarily populated, so there's no need to check where the actual RAM
ends.

>  
>         min_low_pfn = PFN_UP(phys_ram_base);
> --
> 
> I'd really like to see an actual MM person (Mike or Alex?) have some
> input here, and not simply my pasta-on-wall approach. ;-)
> 
> 
> Björn

-- 
Sincerely yours,
Mike.

