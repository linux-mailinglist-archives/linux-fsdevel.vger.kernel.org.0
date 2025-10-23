Return-Path: <linux-fsdevel+bounces-65297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C91C9C00A2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B5A14F3011
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 11:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2765A30C35A;
	Thu, 23 Oct 2025 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="KTtZ9kPr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvSBd6Pk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351328C00C;
	Thu, 23 Oct 2025 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217760; cv=none; b=F3rllKotjNB2ksrTJlYW2DdKl/pJpHv+eJr+aw3gqk8DnuMXhTMMKVCSQQTblWvn2GyF98VwoXS4S+4D+mrft9yyDyoRzZEtPBnMdwK/C4C51B5jdveK7mm2n6D8WMwFJyxHfYFPsxbnriivx2+CMCp0mOtXU2X5AeTSHHGPC2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217760; c=relaxed/simple;
	bh=TCq9qcVCutQlKO9j2oFwyEX6973EaileswZin2dPFvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=putk1LE7xSVdnlFvmOyC4aSJ5+bMnGPrx3c0LgilaLuonQ+33tsuBKUU3S5G7O8mSq+U9WBEF977/1a+2q7BzsEufBF0IBEb6Lyg52/9vF8HUFFosOxGqDX1+lp3+0f0sTltoAD2Z6+dU1MHPuEktL9OlnSYaNK13loJHXsXniA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=KTtZ9kPr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZvSBd6Pk; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 54A967A01AA;
	Thu, 23 Oct 2025 07:09:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 23 Oct 2025 07:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761217755; x=
	1761304155; bh=e9KawlaDhjJS+ZMKZhm8w/oQQAYs/+bmrKLwAa9o+Oo=; b=K
	TtZ9kPrsDfd+3EaDrvYvKpHAYzkTIVJrAmKe43FITa5lv0nU0iv1DvSxHM2brJHP
	gXTzRl0evfqb/S4E1iAxXB8h82GaBDpSCh81DC1kl1jdJvli7hF3tMxQW2BXQIfX
	C9TPWrTl258e/B7muQMshy7xxhDnc2hzV4ymHyBQr0pL1R0mz0HvVqOXyxjBT1gd
	FAK5k3Ab0NutyVxM7b/mHjEfS1zhsklO20wj3qj29BFELNA4MNl0klKX8SG3X7FK
	Tk+j8/6L/LHxHk9wo6ugVTSkkUDpb/IU5o0y7HmBoDrLB66MxRaG7NkTnx+6b3aj
	9+M5Dixxcx7gLWJceyAQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761217755; x=1761304155; bh=e9KawlaDhjJS+ZMKZhm8w/oQQAYs/+bmrKL
	wAa9o+Oo=; b=ZvSBd6PkTl7poelfrzGYRIkas/w2kqCzCVlPo33fflhWd8vbGGD
	QpOuZsa7EN85wVTexfkKIF24Ia5/TCUpbU8qL+h3KWOp8kJ/cYsCw/m0qryEg6ND
	D7BxD273UqTbDugWmRK8c2bZU2ObW/RUbITAwpMcIrw1eWmI5O82Zfb5UZ2q7/5W
	fApkBz1Nk+eD+UgFEdLSpvSDaj3toTfNrTN3eyYTeHLpuHXv/fbaZV3q/7DiWzve
	ZPiB/ockgXEUtYhDYcn/k0GNk9IF79AVhN+Q1S5GK1blhpv/J1laU8OqzQd+Hpk+
	pvnwF2igK+u6FU/zLCBq5ehZT/EAJpI3hAA==
X-ME-Sender: <xms:2gz6aLgPC_4h27QyswLx5Cwse3RkDSj_uz_4GZaG8mnNLHpnvEabCg>
    <xme:2gz6aJWyRsYlYESon6RK4edRatJupDlTRapA3AHpbp1OC7G-aAelaSHYHjSyTnKfX
    9YEjjSqwREQkeITFqtnRZ_BmWqrui-aoIUY0rsoMSJzjAWPlOIE8_M>
X-ME-Received: <xmr:2gz6aPvrFmO55TAZcbaCU-gBvZySktHrGHEVrq2_E4mX_Q8BWgYEbXORR3UfaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeifedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:2gz6aK-j5ahkGjat69k16dsaj_YxKtt6KtPiks_qU2wDXwki7BDPRg>
    <xmx:2gz6aPuITyhUJk6Nw5pKFFQR6WrAIQmg30Seq_-GRtZp0CNvCvcnTg>
    <xmx:2gz6aA6cv6s3eOCKW0IeSI7ZfBvceFJVxxXs8Xr538dmhrLrLBnkJg>
    <xmx:2gz6aINJcBwkBSnrruG4pP9k_2H-RjmOYbZ2I3uAnWQ8EefKooggHA>
    <xmx:2wz6aJnHpCeaO4Lu5OQQekx6DiIO6DwritTNhnpjWjS4xbjI3-7k-luM>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 07:09:14 -0400 (EDT)
Date: Thu, 23 Oct 2025 12:09:12 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <55p3kov54tjf5cr2sm3h3z7hv5cq6nlcqihlyxa427pz5mtkuv@nddjx4onw6mq>
References: <20251017141536.577466-1-kirill@shutemov.name>
 <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
 <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
 <06333766-fb79-4deb-9b53-5d1230b9d88d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06333766-fb79-4deb-9b53-5d1230b9d88d@redhat.com>

On Thu, Oct 23, 2025 at 12:54:59PM +0200, David Hildenbrand wrote:
> On 23.10.25 12:31, Kiryl Shutsemau wrote:
> > On Wed, Oct 22, 2025 at 07:28:27PM +0200, David Hildenbrand wrote:
> > > "garbage" as in pointing at something without a direct map, something that's
> > > protected differently (MTE? weird CoCo protection?) or even worse MMIO with
> > > undesired read-effects.
> > 
> > Pedro already points to the problem with missing direct mapping.
> > _nofault() copy should help with this.
> 
> Yeah, we do something similar when reading the kcore for that reason.
> 
> > 
> > Can direct mapping ever be converted to MMIO? It can be converted to DMA
> > buffer (which is fine), but MMIO? I have not seen it even in virtualized
> > environments.
> 
> I recall discussions in the context of PAT and the adjustment of caching
> attributes of the direct map for MMIO purposes: so I suspect there are ways
> that can happen, but I am not 100% sure.
> 
> 
> Thinking about it, in VMs we have the direct map set on balloon inflated
> pages that should not be touched, not even read, otherwise your hypervisor
> might get very angry. That case we could likely handle by checking whether
> the source page actually exists and doesn't have PageOffline() set, before
> accessing it. A bit nasty.
> 
> A more obscure cases would probably be reading a page that was poisoned by
> hardware and is not expected to be used anymore. Could also be checked by
> checking the page.

I don't think we can check the page. Since the page is not stabilized
with a reference, it is TOCTOU race. If there's some side effect that
we cannot suppress on read (like _nofault() does) we are screwed.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

