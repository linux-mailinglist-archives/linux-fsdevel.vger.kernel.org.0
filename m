Return-Path: <linux-fsdevel+bounces-17054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60F08A7176
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 18:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC1D1C219CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F6939FCF;
	Tue, 16 Apr 2024 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TpE9WHNu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48831103;
	Tue, 16 Apr 2024 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285115; cv=none; b=MjJuASgexire5okEBkWcLvjrF84/7+5vmjGsVBnYVVupa8ApC+8sS89h1QkOTB/k1PNrPo75HENjZRDfMEu0FNpMAgJHNpMi4k9sN+Fd2apQr61HhuqQQPcWnqRxaT30aEzSqeHpa64Fp1cEjVwZdbBBhlbsUENkkeDrLhbfJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285115; c=relaxed/simple;
	bh=H3p8m8mV2JkAiJUzY7gAd1xSzJUq5Su2mpe/YPvfz98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+yIVIBZ74ZXJNV23VkXcw7Nmjd7dxv4QVRsgNpuHHdc/xH3o0se2htj9lBRyPZHxXPxQ799kc/BcrTcR5Na/wxMjvQdb6vAKloA/zsqhP7k5hGiJPvAxgDMa/HSrD18z4xmL15VKtYdbDx34mANrsTXSjoGHU8bUDW9a/SD8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TpE9WHNu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zrxy/XX7+JuExrNVQ3X4tsqs9uLcDU9DwQc0CqefZDs=; b=TpE9WHNujzzZA/S3V2p4urVEPj
	R7bkoCWwWxSe7r+t8li4lsQD8ZzZItB+Zkbqc/dsdOTG8bYRwUatjQskVdkNgGcu4IhKO5oWVGOd1
	Urh4V8W4fbVs0l6AFTLU9BEeGCPP6pGVjM8TGPWH+tCzQGiGXPhh+U7FWm+980jhrd/JT2yAK5oHq
	pwFJaEmv8V6zxGBk/MLFWt56H8SOyBGsdAVFnXY7M4sbJyL732ZLrQtV6JKgaFlSPtxW70/EqOkGG
	TXaLlkKZzVWIbrQWTfQ+oXJRRmzbvNVk9PIUUbnFcYxo1v/8uqgD8NGr0x5ojmcoCfySBR9yZVdT5
	xXWOBcow==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwlip-00000000w58-1RyL;
	Tue, 16 Apr 2024 16:31:51 +0000
Date: Tue, 16 Apr 2024 17:31:51 +0100
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
Message-ID: <Zh6n952Y7qKRMnMj@casper.infradead.org>
References: <20240416-deppen-gasleitung-8098fcfd6bbd@brauner>
 <8734rlo9j7.fsf@all.your.base.are.belong.to.us>
 <Zh6KNglOu8mpTPHE@kernel.org>
 <20240416171713.7d76fe7d@namcao>
 <Zh6lD8d7cUZdkZJb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh6lD8d7cUZdkZJb@kernel.org>

On Tue, Apr 16, 2024 at 07:19:27PM +0300, Mike Rapoport wrote:
> > "last page of the first gigabyte" - why first gigabyte? Do you mean
> > last page of *last* gigabyte?
>  
> With 3G-1G split linear map can map only 1G from 0xc0000000 to 0xffffffff
> (or 0x00000000 with 32-bit overflow):
> 
> [    0.000000]       lowmem : 0xc0000000 - 0x00000000   (1024 MB)

... but you can't map that much.  You need to reserve space for (may not
be exhaustive):

 - PCI BARs (or other MMIO)
 - vmap
 - kmap
 - percpu
 - ioremap
 - modules
 - fixmap
 - Maybe EFI runtime services?

You'll be lucky to get 800MB of ZONE_NORMAL.

