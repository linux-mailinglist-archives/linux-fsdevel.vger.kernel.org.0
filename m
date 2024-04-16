Return-Path: <linux-fsdevel+bounces-17073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AC58A7351
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 20:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B30282A28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 18:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54074136E12;
	Tue, 16 Apr 2024 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0XOvrLO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F562D60A;
	Tue, 16 Apr 2024 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292561; cv=none; b=Lu6NlSY+3fEROkGqsyGPt40mpHBkgoCqr0PrM4OwTsfsaNMhGsh2UE7edhC3maQljhQ588Le6CrH3r4ZEtHK9y26vi3TKuRTseW0iMp5rGt5NllS0kmmxINf5UhMx6I8v0BREIuT3Ri8I4hH+OyMb2eAcTTgbFWPtxRi+viIoik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292561; c=relaxed/simple;
	bh=RUydQSI9IalFqEGbK9QMhcm64ilwdfZmZE3G8mYwjzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7ntnfBFNwCTT10vYndeQqSnwYJ+n4VbQp4hqvKKolS9TvvOphVlm1hKkCCk1MxuMAAdUm1qhKXR05Y9/r0p7IEDpLvmRd5EI8rt6fQp3RXfC/Oy3UW5P+T7UwHb+jS5p2d/5qfbh5rnwTRtYEYIbAOvBW5BinLYlkAFw0o/njk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0XOvrLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165C3C113CE;
	Tue, 16 Apr 2024 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713292561;
	bh=RUydQSI9IalFqEGbK9QMhcm64ilwdfZmZE3G8mYwjzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0XOvrLOmIGvtvZ81QXFXzN4kYMmV6ckD/uMbpDkJL8LOZfAKxnJZFm4KYJoTWIoO
	 M8TyNsvhgGRMql9wlIWgnTAj1yJcmch0lIXb0su80K1hgIpyMoUga4NhSei6/A4QCk
	 lc7bJGNPIsemhUlHKhSgp7YZTyvWyEl+9p/aR5FZCziUNaaxjKV5J6CY9Vg7g0tRuw
	 6BE159Fcux3KiPOeKvDdx07Lvy8+3/UBMYMRoW7yUZu5yxKDaYJFE6O04Tjv6grN+z
	 fR1mt4uB/FYFf4+9WdGti/KqrBBHoPa3Dvg2s5jspWiwhLLJ4TP0WNg46JR094OSOl
	 K+Kx+6gKRxQUQ==
Date: Tue, 16 Apr 2024 21:34:51 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Nam Cao <namcao@linutronix.de>,
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
Message-ID: <Zh7Ey507KXIak8NW@kernel.org>
References: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
 <8734rlo9j7.fsf@all.your.base.are.belong.to.us>
 <Zh6KNglOu8mpTPHE@kernel.org>
 <20240416171713.7d76fe7d@namcao>
 <20240416173030.257f0807@namcao>
 <87v84h2tee.fsf@all.your.base.are.belong.to.us>
 <20240416181944.23af44ee@namcao>
 <Zh6n-nvnQbL-0xss@kernel.org>
 <Zh6urRin2-wVxNeq@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh6urRin2-wVxNeq@casper.infradead.org>

On Tue, Apr 16, 2024 at 06:00:29PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 16, 2024 at 07:31:54PM +0300, Mike Rapoport wrote:
> > > @@ -238,17 +237,9 @@ static void __init setup_bootmem(void)
> > >  	/*
> > >  	 * memblock allocator is not aware of the fact that last 4K bytes of
> > >  	 * the addressable memory can not be mapped because of IS_ERR_VALUE
> > > -	 * macro. Make sure that last 4k bytes are not usable by memblock
> > > -	 * if end of dram is equal to maximum addressable memory.  For 64-bit
> > > -	 * kernel, this problem can't happen here as the end of the virtual
> > > -	 * address space is occupied by the kernel mapping then this check must
> > > -	 * be done as soon as the kernel mapping base address is determined.
> > > +	 * macro. Make sure that last 4k bytes are not usable by memblock.
> > >  	 */
> > 
> > It's not only memblock, but buddy as well, so maybe
> > 
> > 	/*
> > 	 * The last 4K bytes of the addressable memory can not be used
> > 	 * because of IS_ERR_VALUE macro. Make sure that last 4K bytes are
> > 	 * not usable by kernel memory allocators.
> > 	 */
> > 
> > > -	if (!IS_ENABLED(CONFIG_64BIT)) {
> > > -		max_mapped_addr = __pa(~(ulong)0);
> > > -		if (max_mapped_addr == (phys_ram_end - 1))
> > > -			memblock_set_current_limit(max_mapped_addr - 4096);
> > > -	}
> > > +	memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE);
> > 
> > Ack.
> 
> Can this go to generic code instead of letting architecture maintainers
> fall over it?

Yes, it's just have to happen before setup_arch() where most architectures
enable memblock allocations.

-- 
Sincerely yours,
Mike.

