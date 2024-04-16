Return-Path: <linux-fsdevel+bounces-17057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C4C8A71CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 19:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218ED283CE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8191327ED;
	Tue, 16 Apr 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nt9mrA1v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6112AAE3;
	Tue, 16 Apr 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286834; cv=none; b=AwYV2HB1lRHn0SvCCuHpZXnl3nCZTKIkxmKHDIi6rEy3ZkTe4Ov5+N4mx2oO6ypjUcctm3t8SCmctXS3J0PSfNtIwWcE6PiU/RisEqE3MYdVjQx7TytL3Mmrn6n51HDQiyOcbCxsmAqGeplGL6aJSYzub6TtyKhnSdmXq54hhMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286834; c=relaxed/simple;
	bh=+eKfqkqGNqkcZA+3CL0j3nQn92dxN0Kh6lLW/1pOGwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b73xnWD2C8HNFDyQPm8n6TECcBbUTUi416YzV5zvtBmMFGTLex6IFEHi+sJqiPffF9GBi60O6R3M1JVSs1c1cZLtV54svYtnVkF3qeMTdABcb5EXZqRt4c8a9Vgu6FwIa1iGenrBDUtN0wje2Y8+fJPiLp6URnMxLEDHkjpzuak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nt9mrA1v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KRNBS/nNdDiPqgsHkyKzXY05QuyaoZshBLw+Rc9FXMA=; b=nt9mrA1vsAaOvdbNnhltvUwu9v
	eWZR64hdT0sHaVKkAKmAe02tetl0haDxBjBnAHLphqFzp/yy5osgH3yZyN6EMx70yH1d9DLHOvVrz
	dlRSWUeki4/Q/6FdINSaH5XHgpn18Dmc7bkQlSk/Sg9c13cunns8wBOiCeumO9xQ5x0BAtn5G/uU/
	xnQs8dh9gnYgu2MH0woQlj+GOoe6kRJfmSNBff0Hup94JBNpjrNs0La/eiMr7DSYEkpv1GiMYVo3T
	yqk61h9eHqECcuvHQGIgfFsTqPQCz0ZDqgjczHx4LBks0gwP9I1Os4OQf9wpGT5Ee1lDF7iiYEL7s
	zChMYYyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwmAX-00000000yWu-3TaB;
	Tue, 16 Apr 2024 17:00:29 +0000
Date: Tue, 16 Apr 2024 18:00:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
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
Message-ID: <Zh6urRin2-wVxNeq@casper.infradead.org>
References: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
 <8734rlo9j7.fsf@all.your.base.are.belong.to.us>
 <Zh6KNglOu8mpTPHE@kernel.org>
 <20240416171713.7d76fe7d@namcao>
 <20240416173030.257f0807@namcao>
 <87v84h2tee.fsf@all.your.base.are.belong.to.us>
 <20240416181944.23af44ee@namcao>
 <Zh6n-nvnQbL-0xss@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh6n-nvnQbL-0xss@kernel.org>

On Tue, Apr 16, 2024 at 07:31:54PM +0300, Mike Rapoport wrote:
> > @@ -238,17 +237,9 @@ static void __init setup_bootmem(void)
> >  	/*
> >  	 * memblock allocator is not aware of the fact that last 4K bytes of
> >  	 * the addressable memory can not be mapped because of IS_ERR_VALUE
> > -	 * macro. Make sure that last 4k bytes are not usable by memblock
> > -	 * if end of dram is equal to maximum addressable memory.  For 64-bit
> > -	 * kernel, this problem can't happen here as the end of the virtual
> > -	 * address space is occupied by the kernel mapping then this check must
> > -	 * be done as soon as the kernel mapping base address is determined.
> > +	 * macro. Make sure that last 4k bytes are not usable by memblock.
> >  	 */
> 
> It's not only memblock, but buddy as well, so maybe
> 
> 	/*
> 	 * The last 4K bytes of the addressable memory can not be used
> 	 * because of IS_ERR_VALUE macro. Make sure that last 4K bytes are
> 	 * not usable by kernel memory allocators.
> 	 */
> 
> > -	if (!IS_ENABLED(CONFIG_64BIT)) {
> > -		max_mapped_addr = __pa(~(ulong)0);
> > -		if (max_mapped_addr == (phys_ram_end - 1))
> > -			memblock_set_current_limit(max_mapped_addr - 4096);
> > -	}
> > +	memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE);
> 
> Ack.

Can this go to generic code instead of letting architecture maintainers
fall over it?

