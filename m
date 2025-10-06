Return-Path: <linux-fsdevel+bounces-63514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721D6BBEE1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 20:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CCF3B240D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 18:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3223246766;
	Mon,  6 Oct 2025 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="YEIRcNUY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Auk/0g+h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C4621C179
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773874; cv=none; b=D5t+O2MBd29FqlQMCSQiLacnNX+0kcxPPGdpnC4VHg7mETdTYNvMVavLcvfgbpTq1hpR2SA17qAhxZNQo6r+lnMtIEiGovrHOWu98WOUQ/1RHkYuRJBq50l4ydmKx6wtY2qUKhYhaV0sW1dqc4AJ2vdImOXGLGVLIqBUuVkUppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773874; c=relaxed/simple;
	bh=LrFVzIkHIWTHuI4rXTBWGV+v/+f1YiSTPEZ9/vbskyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRk38D6ZMZKNrbKzyMv96dNPLESiV1qUVNo3NiyQiWt4KpGWeqreTQV10vKIPcYgxQV8On7Uxx3fIdo/yBjwbl1XEpyofeOPUFyVqrvaoZQM/oFAS+nOG5VqaXWAx52855HI/XJmt88XRsR50/7zSTi2ZllUjUUqK0m3mJ40Agk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=YEIRcNUY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Auk/0g+h; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF4167A0127;
	Mon,  6 Oct 2025 14:04:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 06 Oct 2025 14:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1759773869; x=
	1759860269; bh=mvRmitREcUsAIl3c+ISPdevfWOPSl1oIN+oRFP6Q4Mc=; b=Y
	EIRcNUYhfrPGY19vO2hpSwLknu6Q4o6tCDjyHmm8v+9rU12jnkWTkXJi00vm0Kf/
	5JoEk2CifeTzzxv9CJKgQX1gX1GBgmyW1gHFhHKcC23Eix7raf0mEDhwcXtKa4eg
	HMMrILVv8x7qTinIxgRVnbMl8538/zxxY+K0ozoh7yZVxq3qoSxKL2C64QkuPZIQ
	nSyy07if6Pp8OFcuprt8KElOhYlciQ92qnqbgpnGY7lZkATVvOCT0ckS56upNcDD
	s8x4Bxx65xcLtJIOKoFAerSBJ61/tLmdY68p1FNZwELg/i3s04IoZBPlntKVXZDG
	Xz5QW2qj6OdRJlcxfwlhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759773869; x=1759860269; bh=mvRmitREcUsAIl3c+ISPdevfWOPSl1oIN+o
	RFP6Q4Mc=; b=Auk/0g+hdxoQ3NNFMr1/+2KxC1flPJFtsHTJHXIrFFDmJzuJ4On
	0yAG0FoK04ncv5SVUN6Lz3D1dODTYdKIpbf6Q5VTFAefiQvIb0YdaSm21ogqmEXo
	jZ+OkCO7wE2AIyGZPkYckyYSmS7h/1rqTkp7er3hqQPw5AYclOVdCdzZ3Tut0Wff
	G/oBE+j6qqPuBvuZpzdcKSLjRhBci48Hp1zeGrMFmeh5CPfFpS+i9VnhDBvSVnQ+
	1o8Ngzeyb7Glrup2L6vHTIS5/yfXhAg3S3BpKhMFjTmP3nrzhZyE1uA5dGS96cxk
	ZADkyCJgGjRSX6kcqBra2E0x0MD6Dz+ABqA==
X-ME-Sender: <xms:rQTkaNw84cZ5zCKLnFQ_I-ArYHhp9lCooWVyw2Was1QbpvH7_xAxNQ>
    <xme:rQTkaAWT2R0eNX6ZfL_2MTvT7-5IQ7ZKOrTFqa3Z7L6slwgzQfIi3nN4bT7P5QuTb
    7HmFWtsSYhJ0SP8HkdtJn3Lug9PkLI8B-2NNx8o9NezaUrOxqFY_l0>
X-ME-Received: <xmr:rQTkaB_vc2qTV3Bb69BpuzJOmNUVzz6sPKQbZc4xXjDFdj-4QYCNQeh-cpzc1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepuddt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugi
    dqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepfihilhhlhiesihhnfhhrrggu
    vggrugdrohhrghdprhgtphhtthhopehmtghgrhhofheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rQTkaLshyacJTOxqkAYV_Mq3psXLsryU-csILR2ICVVXNMthP85QwA>
    <xmx:rQTkaJ3HFfs5bn3Sz3X9Up-7-8CMZxnST_jVVVDt5CT1IP7fISuyfw>
    <xmx:rQTkaIQcy2Z0EL9aAdbAsUlNMqEWIprPGhmJ0l1P9k9szOgHTiYI4w>
    <xmx:rQTkaFd-RIs73pUY1abGNwXqu7TqMFPJAGAxtP9ZaBIiF_i0ZWnnPA>
    <xmx:rQTkaOVgd5OZygrHjAovjkvWOnGwKWmsAixlN7Cm4w3ouWWnmCAP96nJ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 14:04:28 -0400 (EDT)
Date: Mon, 6 Oct 2025 19:04:26 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Optimizing small reads
Message-ID: <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka>
References: <CAHk-=wj00-nGmXEkxY=-=Z_qP6kiGUziSFvxHJ9N-cLWry5zpA@mail.gmail.com>
 <flg637pjmcnxqpgmsgo5yvikwznak2rl4il2srddcui2564br5@zmpwmxibahw2>
 <CAHk-=wgy=oOSu+A3cMfVhBK66zdFsstDV3cgVO-=RF4cJ2bZ+A@mail.gmail.com>
 <CAHk-=whThZaXqDdum21SEWXjKQXmBcFN8E5zStX8W-EMEhAFdQ@mail.gmail.com>
 <a3nryktlvr6raisphhw56mdkvff6zr5athu2bsyiotrtkjchf3@z6rdwygtybft>
 <CAHk-=wg-eq7s8UMogFCS8OJQt9hwajwKP6kzW88avbx+4JXhcA@mail.gmail.com>
 <4bjh23pk56gtnhutt4i46magq74zx3nlkuo4ym2tkn54rv4gjl@rhxb6t6ncewp>
 <CAHk-=wi4Cma0HL2DVLWRrvte5NDpcb2A6VZNwUc0riBr2=7TXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi4Cma0HL2DVLWRrvte5NDpcb2A6VZNwUc0riBr2=7TXw@mail.gmail.com>

On Mon, Oct 06, 2025 at 08:50:55AM -0700, Linus Torvalds wrote:
> On Mon, 6 Oct 2025 at 04:45, Kiryl Shutsemau <kirill@shutemov.name> wrote:
> >
> > Below is my take on this. Lightly tested.
> 
> Thanks.
> 
> That looked even simpler than what I thought it would be, although I
> worry a bit about the effect on page_cache_delete() now being much
> more expensive with that spinlock.
>
> And the spinlock actually looks unnecessary, since page_cache_delete()
> already relies on being serialized by holding the i_pages lock.
> 
> So I think you can just change the seqcount_spinlock_t to a plain
> seqcount_t with no locking at all, and document that external locking.

That is not a spinlock. It is lockdep annotation that we expect this
spinlock to be held there for seqcount write to be valid.

It is NOP with lockdep disabled.

pidfs does the same: pidmap_lock_seq tied to pidmap_lock. And for
example for code flow: free_pid() takes pidmap_lock and calls
pidfs_remove_pid() that takes pidmap_lock_seq.

It also takes care about preemption disabling if needed.

Unless I totally misunderstood how it works... :P

> >  - Do we want a bounded retry on read_seqcount_retry()?
> >    Maybe upto 3 iterations?
> 
> No., I don't think it ever triggers, and I really like how this looks.
> 
> And I'd go even further, and change that first
> 
>         seq = read_seqcount_begin(&mapping->i_pages_delete_seqcnt);
> 
> into a
> 
>         if (!raw_seqcount_try_begin(&mapping->i_pages_delete_seqcnt);
>                 return 0;
> 
> so that you don't even wait for any existing case.

Ack.

> That you could even do *outside* the RCU section, but I'm not sure
> that buys us anything.
> 
> *If* somebody ever hits it we can revisit, but I really think the
> whole point of this fast-path is to just deal with the common case
> quickly.
> 
> There are going to be other things that are much more common and much
> more realistic, like "this is the first read, so I need to set the
> accessed bit".
> 
> >  - HIGHMEM support is trivial with memcpy_from_file_folio();
> 
> Good call. I didn't even want to think about it, and obviously never did.
> 
> >  - I opted for late partial read check. It would be nice allow to read
> >    across PAGE_SIZE boundary as long as it is in the same folio
> 
> Sure,
> 
> When I wrote that patch, I actually worried more about the negative
> overhead of it not hitting at all, so I tried very hard to minimize
> the cases where we look up a folio speculatively only to then decide
> we can't use it.

Consider it warming up CPU cache for slow path :P

> But as long as that
> 
>         if (iov_iter_count(iter) <= sizeof(area)) {
> 
> is there to protect the really basic rule, I guess it's not a huge deal.
> 
> >  - Move i_size check after uptodate check. It seems to be required
> >    according to the comment in filemap_read(). But I cannot say I
> >    understand i_size implications here.
> 
> I forget too, and it might be voodoo programming.
> 
> >  - Size of area is 256 bytes. I wounder if we want to get the fast read
> >    to work on full page chunks. Can we dedicate a page per CPU for this?
> >    I expect it to cover substantially more cases.
> 
> I guess a percpu page would be good, but I really liked using the
> buffer we already ended up having for that page array.
> 
> Maybe worth playing around with.

With page size buffer we might consider serving larger reads in the same
manner with loop around filemap_fast_read().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

