Return-Path: <linux-fsdevel+bounces-69915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFED7C8B914
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 20:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFEA3B4EBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 19:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE99033F397;
	Wed, 26 Nov 2025 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="m5IyTggr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8DD2264BB;
	Wed, 26 Nov 2025 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185207; cv=none; b=PbQpKuHeSFctQFiDz/3zewqDXQvKl28SIOKbYpvjPkpp1mS/AM/BaeIhmkeenCHC6fz45GT8/ElaZu7w8JT5rbCWhjRL8dv+bDFAg3KNfnILJZsd45CrcbOYGiQvFcz02JaA49vETKruj0+Dzqh5zPwe7WB28jISDc+b8DNOEsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185207; c=relaxed/simple;
	bh=3AX+Ze2uGmBJvcdvNaslrGGPuc6ft6bx+pZHqFnsmv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClbOSisc3jJOlsRy++eh7Itq9plAndE/6b9XWvl8OICj6q39WnvOCi/Wcd2dL4n+KGdmmui8VwzJTbCtaQeUAtxAip8CRD8YCf399EAbr5MoZ08fv6pgXnBZk2rQEAteCbl6KCHi0Kv/d8d6b+Voe8TZwf/psTKIu8BNbWnQ/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=m5IyTggr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nU80GOb9NiCLGKUDlF0jPjWnpLtyN6G9RlF17vc6RcQ=; b=m5IyTggrRAAY5MhBN6EpasSDVL
	YnL4rtLPSW0hBjjOgYMp5fLiiyp/wwm7von1AJhAekg73plC0swbRI6WCfUWNQ+P6t7lyjB2IwWHK
	dHG3UMGxNUmXcARXsH20a+MKTVvBYdnODh/AQrhfKkPdN/yqqcu2nz9UzxOTCwSxCeDov1UGjAWpd
	LRU9WIJuinhZqwhWTWmliPFSxagjI+DUY21bqlM1h0ikrfoablwBCOy2u85OE1+TvvgXc8peS4IO3
	q6s2ELwC4XDldzOHD/QHYDaCIUs7has7C2uaIiYN19w0u1KZqxMxK8bdXYbLyPvUw9OW2F289fVxg
	elLHBApA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vOLA0-00000000kzD-2DFB;
	Wed, 26 Nov 2025 19:26:40 +0000
Date: Wed, 26 Nov 2025 19:26:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, brauner@kernel.org, jack@suse.cz,
	will@kernel.org, nico@fluxnic.net, akpm@linux-foundation.org,
	hch@lst.de, jack@suse.com, wozizhi@huaweicloud.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	lilinjie8@huawei.com, liaohua4@huawei.com,
	wangkefeng.wang@huawei.com, pangliyuan1@huawei.com
Subject: Re: [RFC PATCH] vfs: Fix might sleep in load_unaligned_zeropad()
 with rcu read lock held
Message-ID: <20251126192640.GD3538@ZenIV>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <20251126101952.174467-1-xieyuanbin1@huawei.com>
 <20251126181031.GA3538@ZenIV>
 <20251126184820.GB3538@ZenIV>
 <aSdPYYqPD5V7Yeh6@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSdPYYqPD5V7Yeh6@shell.armlinux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 26, 2025 at 07:05:05PM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 26, 2025 at 06:48:20PM +0000, Al Viro wrote:
> > It's been years since I looked at 32bit arm exception handling, so I'd need
> > quite a bit of (re)RTF{S,M} before I'm comfortable with poking in
> > arch/arm/mm/fault.c; better let ARM folks deal with that.  But arch/* is
> > where it should be dealt with; as for papering over that in fs/*:
> 
> Don't expect that to happen. I've not looked at it for over a decade,
> I do very little 32-bit ARM stuff anymore. Others have modified the
> fault handling, the VM has changed, I basically no longer have the
> knowledge. Effectively, 32-bit ARM is unmaintained now, although it
> still has many users.

Joy...  For quick and dirty variant (on current tree), how about
adding
	if (unlikely(addr > TASK_SIZE) && !user_mode(regs))
		goto no_context;

right after

	if (!ttbr0_usermode_access_allowed(regs))
		goto no_context;

in do_page_fault() there?

NOTE: that might or might not break vdso; I don't think it would, but...

