Return-Path: <linux-fsdevel+bounces-67286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AABC3A805
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 12:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72523BAA59
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F02930DD19;
	Thu,  6 Nov 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CdLmX5m+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E29630C622;
	Thu,  6 Nov 2025 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427691; cv=none; b=WThw8y0khD63WI7wujYRfuW6Ru9HBQQKAJlhqUxWo3luEjCtDTiBkmEhcGrgC260ZvbLRLrHZXADJBaBCGItG1gE5KCmiecK4/vVA4iN2kiByDuingheMZTSZNwZsTUBf+vUxJ3v58zK377cf6gEuM08JfnbBuzzpCn799Oda/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427691; c=relaxed/simple;
	bh=bYywurBjYiPTQ/uMEOza3zXaJRw6XGwDWtd1DH1Ws7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3aooc4B+o8chwvTohWhWX/z5362bpvfjBomflli42t6qKQMRMtoUdhI1WGXUNWux9VMq1XSxo48hi+nwg7uY57DLa/oOjtEAJcUXNQWISHH/IFYKzinSeTOOre7tOEfBKwceX3d0BOT/XXknmrqgfbZy/r8ZsB1VC04vvKu9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CdLmX5m+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 36AD540E00DE;
	Thu,  6 Nov 2025 11:14:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8kpSLCUmPsvb; Thu,  6 Nov 2025 11:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762427681; bh=qDCZJajK14UB/WrJEvM7bIOYetebJavQOoVjcO4lFvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdLmX5m+lI5DEXIMPbgDRIEOlvByEsidFDAzueKYVMe+vrOevOjlgGwKCbM2h2Vrd
	 xtP7hVBx2QY9Du1JUZs6T4DxljrzIF+UFVCI7FR8boUFB4KNbX+Gte4oNIxWut16zk
	 fFhIgBT7XBwYijsSQathtXlYvN+wUCGNCFYIsDN9u15RX0chB0/XtaJM5atGH6y90Y
	 6lMH1BhpNyw4G2ySjVJh4qNTNBetITjheb2Pt2UbEuPP6k8d4BdgPwHsBoU5N5xeN0
	 VBnXjqwQS9GLZhTJdODiOX2pCPHp2bfNKa8lEX9wpllVVcX6qhnru135XeQU7Yacb3
	 xr9VQwbtlWX+1t5eOFvZQGu1bVV2xsx0LXUI5RXP0r2PG0X7HaXGi7d+GNkTRyVveS
	 K7hIO9nHTaGuh92nmrYWxzuYe/pak8Z1GJ8pgr6lwIagB7Vq3FV1SnAnKxZryCQsep
	 WoK5rxzOUxvJ9jXoUbyRyQOTPEx6EM3v9p0O3fWvEVEoNma/MTm87of3TKqgSrHUNm
	 FT657P+rsANwg71m0+M5XmpG6Ft7y/V1YTcr2HSGQWY5dX8C4fIe8P9fjLXi32Sv55
	 TVZjER15StF7HLNLBCo3dvqLkptGrpSorvQPzVn2etJDjr81j/tq0O0pKsUR+HRHFs
	 FYRdhX0FuZIYsyBokuv6S1CI=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4770A40E019F;
	Thu,  6 Nov 2025 11:14:31 +0000 (UTC)
Date: Thu, 6 Nov 2025 12:14:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	the arch/x86 maintainers <x86@kernel.org>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
Message-ID: <20251106111429.GCaQyDFWjbN8PjqxUW@fat_crate.local>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com>
 <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local>
 <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
 <CAGudoHGXeg+eBsJRwZwr6snSzOBkWM0G+tVb23zCAhhuWR5UXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHGXeg+eBsJRwZwr6snSzOBkWM0G+tVb23zCAhhuWR5UXQ@mail.gmail.com>

On Wed, Nov 05, 2025 at 09:50:51PM +0100, Mateusz Guzik wrote:
> For unrelated reasons I disassembled kmem_cache_free and the following
> goodies popped up:
> sub    0x18e033f(%rip),%rax        # ffffffff82f944d0 <page_offset_base>
> [..]
> add    0x18e031d(%rip),%rax        # ffffffff82f944c0 <vmemmap_base>
> [..]
> mov    0x2189e19(%rip),%rax        # ffffffff8383e010 <__pi_phys_base>
> 
> These are definitely worthwhile to get rid of.

Says which semi-respectable benchmark?

If none, why bother?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

