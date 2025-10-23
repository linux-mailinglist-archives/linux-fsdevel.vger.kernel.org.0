Return-Path: <linux-fsdevel+bounces-65303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B42C00D08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9154501739
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 11:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D82430DEDC;
	Thu, 23 Oct 2025 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="BcFXvPLW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kfZPHhYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA0A30DEB4;
	Thu, 23 Oct 2025 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219627; cv=none; b=oaFhLq8m+uywtJgdqB3KqqVXMYC92mnuMui2dBfypZDnreS/q/i3/GRvq9vcGxPfdAu4E9l/Jmyc7F8J2cpuTcSAS3/t00GF7g1LTO0y+Mw+mQWxa+cKeB6TtssDlx5BaGWSnHwZl1CUMlh13dK9Zb70PDyslmYIzyqnv3vaZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219627; c=relaxed/simple;
	bh=WXr39l81EP2XwEMafDoJbya4KDyagrEJDHLzKbXijNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3iI89m5tifwQzbVaN4hbJSAGJ1pZjA4uhwyZlf4tf2kXD87hNeIwuR3aJtbNyqOCN7XiXB+QiewvY+BZdiazXYqK6ICf4ug+QJU4Y8CAXca9qqqGeO+YGO6A8uUHRY0nKa0QVS1dLDbbbEFlSHRB4+fNWlcTgFKTRHP26fS1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=BcFXvPLW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kfZPHhYU; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7E4C01D0013A;
	Thu, 23 Oct 2025 07:40:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 23 Oct 2025 07:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761219623; x=
	1761306023; bh=TGTdiZBZdQIPrGsQYMV9BtYIorIZz8VR0jKouLljBYA=; b=B
	cFXvPLWV+lXE7xxKYW4EHHbcGRD4y/L0zZR/aNG62i7HKKJruXobU/wwia0uCF+J
	RXnNJClxG/a/VXr0X00ZGhChdjCkBy9q80fvYORmVeKeN1/w+C0i5nLbHCF/KHsO
	3YCRfjMm2JlOq1flybcqNr8Y4MH4Sk+bFkDCeNMZ6/0yFgZYsQGkczEJGISv2/Dw
	tdFaKitJxKgfZHCOKni5tjTobQk1hJFJbL4pxXODR0JiNeXjdgYGjaUbUcUNbe40
	CQCFXG4Jv3QBmmdbcbheV/kQxTaOk13f37IZ/mAazckCgTSRy4qqTuzAT+Z7AFo9
	sIGm9QK2t80rbxgbURSbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761219623; x=1761306023; bh=TGTdiZBZdQIPrGsQYMV9BtYIorIZz8VR0jK
	ouLljBYA=; b=kfZPHhYUsLxPWhPk7mHkz7K5MpgnZuvygmW0lVAcIOuEK/6puxl
	Yk9vj6GutIb+ZRp/mdOpH+RoUNlP8g60hFkj5C1IcIcgGaTh3aXgfXz64HC/OjmH
	k2i6lOH1pPIRK/v5kCloGuBPcpT8hPinej5eGL9rA93pCtR29qAw/MuxKap+8nlT
	nIBN7K7msKtltqfJuAeUJE0OUmwsewZcrFrs+IBRUJClBH2I2pqZv8S8GOs3F9Ow
	nabZCuWL4urlHuaHFapN4tl2M+gX9/vVWE02X6DkpnewEPjPynVUDf7+dyhMKc2x
	i8lofAfzRqz3n31+J3hsUZbv0ZECU9bzbUA==
X-ME-Sender: <xms:JhT6aFysnQnFWGq2-JeJCVVkphyFFkojUUpjBT8sZ-ggIYykzN-t_A>
    <xme:JhT6aGm8ngsnaWo_y3sefXMHJygkZLr_nY6BGxsJEIobfApvSaFi_RUZcirzN5JUU
    zypiTtDWnDtocDnKH2gO_KBskMDJSHKwephWKMoFF8tQqWp43YVXGk>
X-ME-Received: <xmr:JhT6aD-T1-k7aVIcsJBgGVYvHO7PRpLYDPeO5zfvE-VLwnqeDJ2bGlaDo0woJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeifeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrd
    gtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    epthhorhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphht
    thhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsg
    hrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdr
    tgiipdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JhT6aKPz40luYy1Eie_fBiExg_G1OUu6eJvaBajwqyU3OKqYD3aLxQ>
    <xmx:JhT6aN_LXH3KHlfYxLK-t0yMrWZgibDv2Nqtgm8ID9PG_vRdYJzqiQ>
    <xmx:JhT6aCLvrS50ijCK2tLskpLEoZ62YbEDfkav7YtwiH4-nYOTlXynqg>
    <xmx:JhT6aAeh_ejRGjXaABoaNZTziegD8jdGGzkp_zGIICRuIDIX0wOEaA>
    <xmx:JxT6aB15Kpve9K8JX7w0wCcDK2CpxRUgm6z4qGAytCUixwo9jUl7PjjH>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 07:40:22 -0400 (EDT)
Date: Thu, 23 Oct 2025 12:40:20 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <7fmiqrcyiccff5okrs7sdz3i63mp376f2r76e4r5c2miluwk76@567sm46qop5h>
References: <20251017141536.577466-1-kirill@shutemov.name>
 <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
 <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
 <06333766-fb79-4deb-9b53-5d1230b9d88d@redhat.com>
 <56d9f1d9-fc20-4be8-b64a-07beac3c64d0@redhat.com>
 <5b33b587-ffd1-4a25-95e5-5f803a935a57@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b33b587-ffd1-4a25-95e5-5f803a935a57@redhat.com>

On Thu, Oct 23, 2025 at 01:11:43PM +0200, David Hildenbrand wrote:
> On 23.10.25 13:10, David Hildenbrand wrote:
> > On 23.10.25 12:54, David Hildenbrand wrote:
> > > On 23.10.25 12:31, Kiryl Shutsemau wrote:
> > > > On Wed, Oct 22, 2025 at 07:28:27PM +0200, David Hildenbrand wrote:
> > > > > "garbage" as in pointing at something without a direct map, something that's
> > > > > protected differently (MTE? weird CoCo protection?) or even worse MMIO with
> > > > > undesired read-effects.
> > > > 
> > > > Pedro already points to the problem with missing direct mapping.
> > > > _nofault() copy should help with this.
> > > 
> > > Yeah, we do something similar when reading the kcore for that reason.
> > > 
> > > > 
> > > > Can direct mapping ever be converted to MMIO? It can be converted to DMA
> > > > buffer (which is fine), but MMIO? I have not seen it even in virtualized
> > > > environments.
> > > 
> > > I recall discussions in the context of PAT and the adjustment of caching
> > > attributes of the direct map for MMIO purposes: so I suspect there are
> > > ways that can happen, but I am not 100% sure.
> > > 
> > > 
> > > Thinking about it, in VMs we have the direct map set on balloon inflated
> > > pages that should not be touched, not even read, otherwise your
> > > hypervisor might get very angry. That case we could likely handle by
> > > checking whether the source page actually exists and doesn't have
> > > PageOffline() set, before accessing it. A bit nasty.
> > > 
> > > A more obscure cases would probably be reading a page that was poisoned
> > > by hardware and is not expected to be used anymore. Could also be
> > > checked by checking the page.
> > > 
> > > Essentially all cases where we try to avoid reading ordinary memory
> > > already when creating memory dumps that might have a direct map.
> > > 
> > > 
> > > Regarding MTE and load_unaligned_zeropad(): I don't know unfortunately.
> > 
> > Looking into this, I'd assume the exception handler will take care of it.
> > 
> > load_unaligned_zeropad() is interesting if there is a direct map but the
> > memory should not be touched (especially regarding PageOffline and
> > memory errors).
> > 
> > I read drivers/firmware/efi/unaccepted_memory.c where we there is a
> > lengthy discussion about guard pages and how that works for unaccepted
> > memory.
> > 
> > While it works for unaccepted memory, it wouldn't work for other random
> 
> Sorry I meant here "while that works for load_unaligned_zeropad()".

Do we have other random reads?

For unaccepted memory, we care about touching memory that was never
allocated because accepting memory is one way road.

I only know about load_unaligned_zeropad() that does reads like this. Do
you know others?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

