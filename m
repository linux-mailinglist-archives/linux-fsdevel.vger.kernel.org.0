Return-Path: <linux-fsdevel+bounces-17204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384618A8C2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 21:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689531C21B2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C627E2E41C;
	Wed, 17 Apr 2024 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb+8+TXV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D51BF53;
	Wed, 17 Apr 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713382541; cv=none; b=ABepTx2xIv7redKzvNoonhYQ539mcK519YGuWClOoKiUZ5WygTSfd+mMp/MS4jGehQ+YCrA0rZL8Ae+JnKbnpwS63tlzAvJpY+PPpMGlFPPYsv4O+qg3XD8RldRpfeFZ07/j1mqBGjhi6OzgtX8vFfgTMoXsK+0wTiQworGpjsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713382541; c=relaxed/simple;
	bh=D7V7cK/8mNacv3vFISbQfmWRwzEyZTIcIMLY5u7r1pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7ZrOJ6UczIPILyWIG0sO5NWh/KYtOuzKCYvI9cW3yHOasj1DGHu+SB+Ro9pTmUPs9xESoJgVh7U4mL0ArtVHoRvopV7Bjy3c6uOare/B76J7GTCV/ACtCSSuP6uD3Oj0YfFScDYjSUzNSCkT0dYDaGAdaw88lYnAVhdz5PoAkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb+8+TXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3909CC072AA;
	Wed, 17 Apr 2024 19:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713382540;
	bh=D7V7cK/8mNacv3vFISbQfmWRwzEyZTIcIMLY5u7r1pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hb+8+TXVdmYjhheg9GEtOlw+rpmMP0ryAmTR3HCIbTH3jWoQmDTy6dI0KIzG5O6z4
	 RoXopQ9dEv7BCk9+6snZO118PbwU8tPqVRWRXdE2+J4iCXcvysOcBu1jdgJBONZ0HZ
	 grOlXjP6FnouSABVzLIq83/U/jFXay0lcKNNKLd9CxHvA4GNvNfFVBsMDeIa8QK9yq
	 SdJX1AIklVERA6yFqxMhRf91wZJoxR0/V+Ybmkc3M1Q96cansBf9aQ+vWqpb4w0WCe
	 uftHf9VatHr1/2PjLjo7eYVe9nYjSsgzYZd7crt0+dFDxVUm2gntDjtBwBCfof006e
	 a/7poxFCaJYnA==
Date: Wed, 17 Apr 2024 22:34:28 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Matthew Wilcox <willy@infradead.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Andreas Dilger <adilger@dilger.ca>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-riscv@lists.infradead.org, Theodore Ts'o <tytso@mit.edu>,
	Ext4 Developers List <linux-ext4@vger.kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <ZiAkRMUfiPDUGPdL@kernel.org>
References: <8734rlo9j7.fsf@all.your.base.are.belong.to.us>
 <Zh6KNglOu8mpTPHE@kernel.org>
 <20240416171713.7d76fe7d@namcao>
 <20240416173030.257f0807@namcao>
 <87v84h2tee.fsf@all.your.base.are.belong.to.us>
 <20240416181944.23af44ee@namcao>
 <Zh6n-nvnQbL-0xss@kernel.org>
 <Zh6urRin2-wVxNeq@casper.infradead.org>
 <Zh7Ey507KXIak8NW@kernel.org>
 <20240417003639.13bfd801@namcao>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417003639.13bfd801@namcao>

On Wed, Apr 17, 2024 at 12:36:39AM +0200, Nam Cao wrote:
> On 2024-04-16 Mike Rapoport wrote:
> > On Tue, Apr 16, 2024 at 06:00:29PM +0100, Matthew Wilcox wrote:
> > > On Tue, Apr 16, 2024 at 07:31:54PM +0300, Mike Rapoport wrote:
> > > > > -	if (!IS_ENABLED(CONFIG_64BIT)) {
> > > > > -		max_mapped_addr = __pa(~(ulong)0);
> > > > > -		if (max_mapped_addr == (phys_ram_end - 1))
> > > > > -			memblock_set_current_limit(max_mapped_addr - 4096);
> > > > > -	}
> > > > > +	memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE);
> > > > 
> > > > Ack.
> > > 
> > > Can this go to generic code instead of letting architecture maintainers
> > > fall over it?
> > 
> > Yes, it's just have to happen before setup_arch() where most architectures
> > enable memblock allocations.
> 
> This also works, the reported problem disappears.
> 
> However, I am confused about one thing: doesn't this make one page of
> physical memory inaccessible?
> 
> Is it better to solve this by setting max_low_pfn instead? Then at
> least the page is still accessible as high memory.

It could be if riscv had support for HIGHMEM.
 
> Best regards,
> Nam
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fa34cf55037b..6e3130cae675 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -197,7 +197,6 @@ early_param("mem", early_mem);
>  static void __init setup_bootmem(void)
>  {
>  	phys_addr_t vmlinux_end = __pa_symbol(&_end);
> -	phys_addr_t max_mapped_addr;
>  	phys_addr_t phys_ram_end, vmlinux_start;
>  
>  	if (IS_ENABLED(CONFIG_XIP_KERNEL))
> @@ -235,23 +234,9 @@ static void __init setup_bootmem(void)
>  	if (IS_ENABLED(CONFIG_64BIT))
>  		kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
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

To be precisely strict about the conflict between mapping a page at
0xfffff000 and IS_ERR_VALUE, memblock should not allocate the that page, so
memblock_set_current_limit() should remain. It does not need all the
surrounding if, though just setting the limit for -PAGE_SIZE should do.

Although I suspect that this call to memblock_set_current_limit() is what
caused the splat in ext4. Without that limit enforcement, the last page
would be the first one memblock allocates and it most likely would have
ended in the kernel page tables and would never be checked for IS_ERR. With
the limit set that page made it to the buddy and got allocated by the code
that actually does IS_ERR checks.

> -	}
> -
>  	min_low_pfn = PFN_UP(phys_ram_base);
> -	max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
> +	max_pfn = PFN_DOWN(phys_ram_end);
> +	max_low_pfn = min(max_pfn, PFN_DOWN(__pa(-PAGE_SIZE)));
>  	high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
>  
>  	dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));

-- 
Sincerely yours,
Mike.

