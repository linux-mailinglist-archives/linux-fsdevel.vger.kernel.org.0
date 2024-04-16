Return-Path: <linux-fsdevel+bounces-17055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DFD8A717A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 18:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5ED1C218BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F6237719;
	Tue, 16 Apr 2024 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtqvXTIW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3FF4E7;
	Tue, 16 Apr 2024 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285185; cv=none; b=s8pwpq6n6NsXFN0BGpXliKNQhp8JXF07TG+obAhtHNJL5esQUXuFP83KH4PRelg3iriavFqXViT0y9TAYtifxCDIJm3Q2Ia0nx5Qbsds8Zw+x1z2OUQM0HXF5a/dif8hTv7ussB//4311UdvBEMVC/TlcbZ+NZZTbf4mg4KPyxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285185; c=relaxed/simple;
	bh=gTJHR1KdErAk/qzXo5EJZZiXgCceiHY4vGZi+g7gbDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX/Ehk+X8ROePKpNbLh0hrBuTff2WuB7F7Qalic4AavQToWJFPW5K4Aa66TVz8GnclLbUWt3Cs4LMr+5emwoUYxuDLIyDQ5ak/EH2CiK/CVceOIdbHhtBXo27DPd3WCJQbKAguzDDNKzEZY0Ygx0swICzUWc3lITUhCmDJhhLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtqvXTIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D926C113CE;
	Tue, 16 Apr 2024 16:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713285184;
	bh=gTJHR1KdErAk/qzXo5EJZZiXgCceiHY4vGZi+g7gbDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YtqvXTIWp4JmR1FEXjRm/DaLcxcqVbM2sHNsTceCNUlja61mLU46RASB4axT8jg7S
	 ccSAtBcXO0XJgcAOAkoSXCk08wv1/gy8wYOwNQKVpNrnIWb1U96Y0fr1kbgyU4fuSM
	 LDei7oagYypXMxOvgDkPZQ34bTr9dFttMUMB/hKcpj5EezRXogMzMk+ZFPnCCpGH0+
	 /JF9F1R7RPCGjHwJCNQHo0pzQdq0BwDUuRvACQZ0id1Qh2GX6bTVvG1fVIVdX1v12L
	 t7hmZH/NYURJMwWh2rUMqairNtEvXdZJNhrJA4dZinneJD+IcysEK6n3rjvUQaYSpk
	 neOgd64QhpAxw==
Date: Tue, 16 Apr 2024 19:31:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
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
Message-ID: <Zh6n-nvnQbL-0xss@kernel.org>
References: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
 <8734rlo9j7.fsf@all.your.base.are.belong.to.us>
 <Zh6KNglOu8mpTPHE@kernel.org>
 <20240416171713.7d76fe7d@namcao>
 <20240416173030.257f0807@namcao>
 <87v84h2tee.fsf@all.your.base.are.belong.to.us>
 <20240416181944.23af44ee@namcao>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416181944.23af44ee@namcao>

On Tue, Apr 16, 2024 at 06:19:44PM +0200, Nam Cao wrote:
> On 2024-04-16 Björn Töpel wrote:
> > Nam Cao <namcao@linutronix.de> writes:
> > 
> > > Fixed version:
> > >
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index fa34cf55037b..af4192bc51d0 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -245,6 +245,7 @@ static void __init setup_bootmem(void)
> > >  	 * be done as soon as the kernel mapping base address is determined.
> > >  	 */
> > >  	if (!IS_ENABLED(CONFIG_64BIT)) {
> > > +		memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE);
> > >  		max_mapped_addr = __pa(~(ulong)0);
> > >  		if (max_mapped_addr == (phys_ram_end - 1))
> > >  			memblock_set_current_limit(max_mapped_addr - 4096);  
> > 
> > Nice!
> > 
> > Can't we get rid of the if-statement, and max_mapped_address as well?
> 
> I don't see why not :D
> 
> Best regards,
> Nam
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fa34cf55037b..f600cfee0aef 100644
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

It's not only memblock, but buddy as well, so maybe

	/*
	 * The last 4K bytes of the addressable memory can not be used
	 * because of IS_ERR_VALUE macro. Make sure that last 4K bytes are
	 * not usable by kernel memory allocators.
	 */

> -	if (!IS_ENABLED(CONFIG_64BIT)) {
> -		max_mapped_addr = __pa(~(ulong)0);
> -		if (max_mapped_addr == (phys_ram_end - 1))
> -			memblock_set_current_limit(max_mapped_addr - 4096);
> -	}
> +	memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE);

Ack.

>  	min_low_pfn = PFN_UP(phys_ram_base);
>  	max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
> 

-- 
Sincerely yours,
Mike.

