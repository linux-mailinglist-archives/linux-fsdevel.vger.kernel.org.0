Return-Path: <linux-fsdevel+bounces-17081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D9D8A77D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 00:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE781F2306C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 22:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D72133291;
	Tue, 16 Apr 2024 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Te4SEjdi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1JReEmpz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C339FCF;
	Tue, 16 Apr 2024 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307005; cv=none; b=tm4sBpkVgDSYSRjEVakhNiod1gJxOOdMuBKgXHVJnnGeY+MiLSp+pWUFis/AnLm7shEys67oM4bgGnsUYRqjNtgNZcu9wiGGmq5fY3nDT12/52UuHfNPSIrKg5cI3dffcWYNpS8C5RHvG6ZkpNvCr1ctGTn1gXpgmNNE/yebkDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307005; c=relaxed/simple;
	bh=cSZY4ae4WAsue7NUAkAfbZWkSc+q0D62ObnXm+tgL3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgPbXCljHZ7oLoPKirQ0K7lA/0DlF2HrrUOYrwD/tddxxqibJtQwmlhmeJ1eRSbRoHPNdSZ3WfCHm+yl15NG5OYjxDA1uG7kZaVJYNU1qtBeIiYclaYdDD+53UImNp94NthJS9CckibZC6q2OdBbLMO64a9/YE5GN//J/3itbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Te4SEjdi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1JReEmpz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Apr 2024 00:36:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713307001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvuIWFJvCJMoa+9u4CC8L6s+esR9l0aMrumFrkL3xew=;
	b=Te4SEjdiIAtRl+sEaU2CE61/pWstSBJTyTvMhF0hRKt8Wb0II71K0I5eG60ljuA0kMImWq
	KKyacGeI2WuzzTMdaJJ8MZe8SHKLLYhuzudTyxKuF+BtfxH1/2Ro1FT/EGVLWPxSVJpPCN
	gQaCZC2X1aCeyUjRILimEQQmdYe93+dFDoADfCE8OCkq1a9uc0HeRrLvDYd/NVTT7Us+cX
	xcWl6fRlolFTM+jNzsJ21OrVltzZcx073fs5K8/brt9q27dRRLN7LkLMS0xKSY77/+owMi
	fGTD1V45mheTt9xeiXzrhDhQ9QLaLJDn1bIdJAnkUAL5eAnnRHSiuKQh1ZPKgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713307001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvuIWFJvCJMoa+9u4CC8L6s+esR9l0aMrumFrkL3xew=;
	b=1JReEmpzYenEyEPAqS7pF0uHMdoMdU/dE8wUr66hmDgCzsuooa4j1F8ymBqQjiWzrxxjf+
	eXAqVLKEyOsjtuDA==
From: Nam Cao <namcao@linutronix.de>
To: Mike Rapoport <rppt@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Christian Brauner <brauner@kernel.org>, Andreas Dilger
 <adilger@dilger.ca>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Theodore Ts'o <tytso@mit.edu>, Ext4
 Developers List <linux-ext4@vger.kernel.org>, Conor Dooley
 <conor@kernel.org>, Anders Roxell <anders.roxell@linaro.org>, Alexandre
 Ghiti <alex@ghiti.fr>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240417003639.13bfd801@namcao>
In-Reply-To: <Zh7Ey507KXIak8NW@kernel.org>
References: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
	<8734rlo9j7.fsf@all.your.base.are.belong.to.us>
	<Zh6KNglOu8mpTPHE@kernel.org>
	<20240416171713.7d76fe7d@namcao>
	<20240416173030.257f0807@namcao>
	<87v84h2tee.fsf@all.your.base.are.belong.to.us>
	<20240416181944.23af44ee@namcao>
	<Zh6n-nvnQbL-0xss@kernel.org>
	<Zh6urRin2-wVxNeq@casper.infradead.org>
	<Zh7Ey507KXIak8NW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-04-16 Mike Rapoport wrote:
> On Tue, Apr 16, 2024 at 06:00:29PM +0100, Matthew Wilcox wrote:
> > On Tue, Apr 16, 2024 at 07:31:54PM +0300, Mike Rapoport wrote:
> > > > -	if (!IS_ENABLED(CONFIG_64BIT)) {
> > > > -		max_mapped_addr = __pa(~(ulong)0);
> > > > -		if (max_mapped_addr == (phys_ram_end - 1))
> > > > -			memblock_set_current_limit(max_mapped_addr - 4096);
> > > > -	}
> > > > +	memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE);
> > > 
> > > Ack.
> > 
> > Can this go to generic code instead of letting architecture maintainers
> > fall over it?
> 
> Yes, it's just have to happen before setup_arch() where most architectures
> enable memblock allocations.

This also works, the reported problem disappears.

However, I am confused about one thing: doesn't this make one page of
physical memory inaccessible?

Is it better to solve this by setting max_low_pfn instead? Then at
least the page is still accessible as high memory.

Best regards,
Nam

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fa34cf55037b..6e3130cae675 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -197,7 +197,6 @@ early_param("mem", early_mem);
 static void __init setup_bootmem(void)
 {
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
-	phys_addr_t max_mapped_addr;
 	phys_addr_t phys_ram_end, vmlinux_start;
 
 	if (IS_ENABLED(CONFIG_XIP_KERNEL))
@@ -235,23 +234,9 @@ static void __init setup_bootmem(void)
 	if (IS_ENABLED(CONFIG_64BIT))
 		kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
 
-	/*
-	 * memblock allocator is not aware of the fact that last 4K bytes of
-	 * the addressable memory can not be mapped because of IS_ERR_VALUE
-	 * macro. Make sure that last 4k bytes are not usable by memblock
-	 * if end of dram is equal to maximum addressable memory.  For 64-bit
-	 * kernel, this problem can't happen here as the end of the virtual
-	 * address space is occupied by the kernel mapping then this check must
-	 * be done as soon as the kernel mapping base address is determined.
-	 */
-	if (!IS_ENABLED(CONFIG_64BIT)) {
-		max_mapped_addr = __pa(~(ulong)0);
-		if (max_mapped_addr == (phys_ram_end - 1))
-			memblock_set_current_limit(max_mapped_addr - 4096);
-	}
-
 	min_low_pfn = PFN_UP(phys_ram_base);
-	max_low_pfn = max_pfn = PFN_DOWN(phys_ram_end);
+	max_pfn = PFN_DOWN(phys_ram_end);
+	max_low_pfn = min(max_pfn, PFN_DOWN(__pa(-PAGE_SIZE)));
 	high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
 
 	dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));

