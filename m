Return-Path: <linux-fsdevel+bounces-65309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BCFC012FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 14:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255513A94EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 12:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E4330B527;
	Thu, 23 Oct 2025 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="F75UTxyQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tWM7k9du"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA5A2D7809;
	Thu, 23 Oct 2025 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761223320; cv=none; b=deR6sRfHya0CBCioe2oMeQeiF4IkHdMP3o+C8XQcQPbhZ1KaHT4VMsS5FDLwQCEiiQldmdTv0GgSisc/bx3Tuk3BnqUrz6F9HbTLqz5fIsF5T12s2eC8kBF/YgVibgzxBAWOwlvv2Tgbgijgx0ZeQqDdokrhNV8SeFQ6Y/xQ1eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761223320; c=relaxed/simple;
	bh=794ZiftVdzwhrSgvGwmkoupZXKGmT7JzUrT9Ch+zXbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALoTnfHBYDvqD+hRBfv3aDGK9eBTjx7cQyZjWyQGJ/WhlNxMTxePtZ/39WozzGTMDrpjAsyp78ZIK6RdPw2rEueshx4uzZQYHvX8gX0gG1LPOFWNL9rGYpRWjjVZj9GIp6FXM6Q+MR17+lYRHcmi4LZi1NVtpSIma6mnvTH/P8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=F75UTxyQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tWM7k9du; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2C5527A0090;
	Thu, 23 Oct 2025 08:41:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 23 Oct 2025 08:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761223317; x=
	1761309717; bh=K/3rmEGyyRqr/NQraJuCGAEXsJxihtT7HX1YfEvOM5I=; b=F
	75UTxyQjugFyfRZT2hGVKPmuB5pPR7BBVy8wlqG/BEEFoCLdIXdZMNglK3V52Fzc
	W/8E3rIrnfofl6F2O9HgkA2EWd2kmdSxXU3VfCrCKVy2xsxNGLrW32Svm0Na+W65
	G60ZAeZuA35QoyNA9AYonv11FZjuf6VBqbhlGor+2i//JrhfsXPMf3NW8Kxd8UYb
	paa7jML0qbG8cXO3ZZ0ZjvrjxnabEUZqI0jtjmEPOUQBiMPcjOMHc/qasg3lK8vo
	Kh1AltaXMOp0muk63ogjv3eyr3rKNJhc1rEUfEfSihVKLbcmv8bYr8s+RLequXZA
	JzQU4kNTScM4FbaPOl7eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761223317; x=1761309717; bh=K/3rmEGyyRqr/NQraJuCGAEXsJxihtT7HX1
	YfEvOM5I=; b=tWM7k9duNmDhsdin0A7s2vEwX0yVlBuKpsB6Ywg8Tz1JQsRlyUU
	abJZKR1JcyVYI3KAVz4gaTVV3gv3gEQhf/E9pnMvwOB1jx5QXk2klJ/ZTj6zMXqI
	Y+mV83CjndCCJIdOHJp62h6cKAvWnSi3RKaAahI3UJy8RadqYPvUIpuuKzMXS9Ey
	TVXQ7Ucjl0NbuiWq0KVUHpbSi3PlhyVC2lZLodkH/BBO3L9dtkpWzsnwGfcmCgol
	rJxr2HLTxLXEk8ZZTSsu95QA+vBErjOazZntRyKSWNXIXOPtNgB6Kd9xB6AlqYvP
	T8tPw7ucYDKmpMW1pA0UsEUOkmoclznr8EA==
X-ME-Sender: <xms:kyL6aFo9VJ3L8H15FHR3zvxubpEYSCA839ekhEUzk1O0WcE9q-ND5w>
    <xme:kyL6aI-sxuS8lOgohAnI1_ZwaUQ_wLpXWj-zkUCmqNAWwUuZEJqlBtERpL2L9CmVG
    o9zaJ-irDnRLWKjH-r88SRdDGuLGkU7WvsC5HT71NLCSe2gGDtmpIQ>
X-ME-Received: <xmr:kyL6aG33opj1embYhw12A-wRW1Q8a8-rVmk9yUWiWSEC6R64BQfkfMAbLmcSpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeigeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:kyL6aDnv5rDE6fqSI4ovDVI5fsUrPHmeyrw0au1dBlkwN7KmBrpoWQ>
    <xmx:kyL6aL2u8gn_8pipvVyNqlBtWd3xsNsexDdYnpoMnlzpUGQDyY8OlA>
    <xmx:kyL6aKj7-lw9T3ixPWJhOYQmB86SVcbjmqNQX8yx_Oa4UaoFF-xeew>
    <xmx:kyL6aBValJgxaySt0vPOsNs4Vcbo3MPFDKNi2UhsAPyYg87ioUBpeQ>
    <xmx:lSL6aCtNetd8m1RLcACeFDrEZgLoNJrcAME93tL-XIVEc_7NReQHkMKO>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 08:41:55 -0400 (EDT)
Date: Thu, 23 Oct 2025 13:41:52 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <fqexozfjp3l6vj643lecky4nndmwblvee7u5f5ejcqkpsij3wp@3yb4y4lyd3dn>
References: <20251017141536.577466-1-kirill@shutemov.name>
 <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
 <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
 <06333766-fb79-4deb-9b53-5d1230b9d88d@redhat.com>
 <56d9f1d9-fc20-4be8-b64a-07beac3c64d0@redhat.com>
 <5b33b587-ffd1-4a25-95e5-5f803a935a57@redhat.com>
 <7fmiqrcyiccff5okrs7sdz3i63mp376f2r76e4r5c2miluwk76@567sm46qop5h>
 <f57d73e3-fb6c-4c01-9897-c9686889fec2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f57d73e3-fb6c-4c01-9897-c9686889fec2@redhat.com>

On Thu, Oct 23, 2025 at 01:49:22PM +0200, David Hildenbrand wrote:
> On 23.10.25 13:40, Kiryl Shutsemau wrote:
> > On Thu, Oct 23, 2025 at 01:11:43PM +0200, David Hildenbrand wrote:
> > > On 23.10.25 13:10, David Hildenbrand wrote:
> > > > On 23.10.25 12:54, David Hildenbrand wrote:
> > > > > On 23.10.25 12:31, Kiryl Shutsemau wrote:
> > > > > > On Wed, Oct 22, 2025 at 07:28:27PM +0200, David Hildenbrand wrote:
> > > > > > > "garbage" as in pointing at something without a direct map, something that's
> > > > > > > protected differently (MTE? weird CoCo protection?) or even worse MMIO with
> > > > > > > undesired read-effects.
> > > > > > 
> > > > > > Pedro already points to the problem with missing direct mapping.
> > > > > > _nofault() copy should help with this.
> > > > > 
> > > > > Yeah, we do something similar when reading the kcore for that reason.
> > > > > 
> > > > > > 
> > > > > > Can direct mapping ever be converted to MMIO? It can be converted to DMA
> > > > > > buffer (which is fine), but MMIO? I have not seen it even in virtualized
> > > > > > environments.
> > > > > 
> > > > > I recall discussions in the context of PAT and the adjustment of caching
> > > > > attributes of the direct map for MMIO purposes: so I suspect there are
> > > > > ways that can happen, but I am not 100% sure.
> > > > > 
> > > > > 
> > > > > Thinking about it, in VMs we have the direct map set on balloon inflated
> > > > > pages that should not be touched, not even read, otherwise your
> > > > > hypervisor might get very angry. That case we could likely handle by
> > > > > checking whether the source page actually exists and doesn't have
> > > > > PageOffline() set, before accessing it. A bit nasty.
> > > > > 
> > > > > A more obscure cases would probably be reading a page that was poisoned
> > > > > by hardware and is not expected to be used anymore. Could also be
> > > > > checked by checking the page.
> > > > > 
> > > > > Essentially all cases where we try to avoid reading ordinary memory
> > > > > already when creating memory dumps that might have a direct map.
> > > > > 
> > > > > 
> > > > > Regarding MTE and load_unaligned_zeropad(): I don't know unfortunately.
> > > > 
> > > > Looking into this, I'd assume the exception handler will take care of it.
> > > > 
> > > > load_unaligned_zeropad() is interesting if there is a direct map but the
> > > > memory should not be touched (especially regarding PageOffline and
> > > > memory errors).
> > > > 
> > > > I read drivers/firmware/efi/unaccepted_memory.c where we there is a
> > > > lengthy discussion about guard pages and how that works for unaccepted
> > > > memory.
> > > > 
> > > > While it works for unaccepted memory, it wouldn't work for other random
> > > 
> > > Sorry I meant here "while that works for load_unaligned_zeropad()".
> > 
> > Do we have other random reads?
> > 
> > For unaccepted memory, we care about touching memory that was never
> > allocated because accepting memory is one way road.
> 
> Right, but I suspect if you get a random read (as the unaccepted memory doc
> states) you'd be in trouble as well.

Yes. Random read of unaccepted memory is unrecoverable exit to host for
TDX guest.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

