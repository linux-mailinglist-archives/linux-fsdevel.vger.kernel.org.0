Return-Path: <linux-fsdevel+bounces-64357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 08412BE2BAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 12:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79EAC35229A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 10:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0162032861A;
	Thu, 16 Oct 2025 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="V0H7RB8k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P2jcDerb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA49328601;
	Thu, 16 Oct 2025 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610129; cv=none; b=XCq4QE1n5TZ8zyL/mrcv+rTx9T8x1ull02YUcO1vDmRwXZjiZI5aVbpc14NzKitJhcipxwG6GR2scS9dWH1TzeYdsDlKzg8KEOcZJszGwEnALsvJlwp8BT6uGhlfW97umgFwgftVN6ZEBrfcuzyzKs1ikIrgGBuaKSX7v6GJpis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610129; c=relaxed/simple;
	bh=YFPu08gB2L2TzGPrnOyTzbHjOw+slzM9D6WRn0+0kUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpjZ2AeQuC0/kBvEopFCTVa87LR+gVPb9lOvlcQShfIrV5f3l+spIogqnc+OBh3gqOM0aH+3ghzLAxCXcmnbgBbnQpgJCPImnpxXUlYHz0ouRAtNFW/D5MNJ0d/dYLN2iYBo5vzcYYg9QcPkHu7+fiuZbKGftxM22f3AXrk3qU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=V0H7RB8k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P2jcDerb; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 608701400208;
	Thu, 16 Oct 2025 06:22:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Oct 2025 06:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1760610124; x=
	1760696524; bh=4cgizSnh8FyjftsIcMN/5doeb/L5sYJZzPBngz1cPTs=; b=V
	0H7RB8kX6dTe4pJfkGYa84CFGKQi7NQQwlIG5JtdXa17rPgjGU7VP1Im0x2JCx0C
	erNolu6GR6GrwirzS9l8PkU+m7UIbkA7XvpPXC7ZFyxsPYDEIbw1RrFzpxGqkE0I
	XSX2c5KYOu4R22qernV1tzWejdNPVpiF6l4acfHqHponV+OQwKMyBJBac6s3srED
	hFX3UEvTtKGF2/OHDDBf5m2oNLPo9+mcCfSWNi51R4gTtStNacgN9I+rh/zOeCdI
	bzeQI6SB+IMUgCVz7V3V15HPW5Ew/NXITdHFdAV6G//4gfIEajOAOqA9Yzk/TrTw
	tQ6ZnYipFhCaAm0qTeNoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760610124; x=1760696524; bh=4cgizSnh8FyjftsIcMN/5doeb/L5sYJZzPB
	ngz1cPTs=; b=P2jcDerbD5gusICBdwO0U719/hGR3gBgsrnEyk/uej3H9tIAQJG
	v7VgnltT3EvGvGG8+qrHW8D01JayYRv3okQbhAmUsijIbYrDIUKZ6S3S5/B9uLUr
	sSSx+QliS0zx1jH0Gxkvh7EyhpBHhERXy7acCWQLVRCPtOoRUXrp0MEcdkW7nZjF
	p/YgXjCydO23+cAAi/nmtPR0J1TjbTgQCUbErZT3E3/AZQlhYg8dzAaolvdkjNEN
	dC7i/NUPFe6YIqVV+eM8q9ZRv9QGFDBjT52AcCsxFfamN6djOIogNSb9V9SX4oeH
	phBvOoSe7RTOsP15zKrE1xGb5EaNosPQYkw==
X-ME-Sender: <xms:S8fwaP4ttjK6p3ef3wmSGFlFfKLtlDlXeqs087EFm0bPMRMUebjRmQ>
    <xme:S8fwaKboqjlnMreOaFW1YHCqKvbBO6P2TuqFlfh8IEkjbZQgdM9xKqtWmQfsXMwBa
    eyyGchYRW-Yp0dAfXK-Z_Zi10RRSNQLw7RbhXPhlaNigx4QAxQo1g>
X-ME-Received: <xmr:S8fwaOzJ7OkTL37tgtZuF7fDFCGl3u50u-MZSNoL7SAdZxEofOAvPqJ-qotFZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedu
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghp
    thhtohepmhgtghhrohhfsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprdhrrghghh
    grvhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopeiilhgrnhhgsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:S8fwaOPAgsDds0-ECl8Xyiqk0Z-xHO-Y5a8K0wNF6vpeVGcbwlcHDg>
    <xmx:S8fwaE7JMiDYacnKnQrAKBYRmKVV46Zunrxozt_3-856GxaGppyfZw>
    <xmx:S8fwaMfTCaQfJZvxTeKiGbOA4RU1D_fhU49T0yoOfv8RAIr7fuoCpQ>
    <xmx:S8fwaFJTy47n8Wuhx5FhwgBa-ro_YtmFJybzJQGxDhY7vB3dhQVNMw>
    <xmx:TMfwaHOsd3ep1ugD0EAPyXlN6Es_j3EWvKWJGeCH2CtZJr8affGgsJqb>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 06:22:02 -0400 (EDT)
Date: Thu, 16 Oct 2025 11:22:00 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "Darrick J. Wong" <djwong@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Pankaj Raghav <p.raghav@samsung.com>, Zorro Lang <zlang@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm <linux-mm@kvack.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, xfs <linux-xfs@vger.kernel.org>
Subject: Re: Regression in generic/749 with 8k fsblock size on 6.18-rc1
Message-ID: <bknltdsmeiapy37jknsdr2gat277a4ytm5dzj3xrcbjdf3quxm@ej2anj5kqspo>
References: <20251014175214.GW6188@frogsfrogsfrogs>
 <rymlydtl4fo4k4okciiifsl52vnd7pqs65me6grweotgsxagln@zebgjfr3tuep>
 <20251015175726.GC6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015175726.GC6188@frogsfrogsfrogs>

On Wed, Oct 15, 2025 at 10:57:26AM -0700, Darrick J. Wong wrote:
> On Wed, Oct 15, 2025 at 04:59:03PM +0100, Kiryl Shutsemau wrote:
> > On Tue, Oct 14, 2025 at 10:52:14AM -0700, Darrick J. Wong wrote:
> > > Hi there,
> > > 
> > > On 6.18-rc1, generic/749[1] running on XFS with an 8k fsblock size fails
> > > with the following:
> > > 
> > > --- /run/fstests/bin/tests/generic/749.out	2025-07-15 14:45:15.170416031 -0700
> > > +++ /var/tmp/fstests/generic/749.out.bad	2025-10-13 17:48:53.079872054 -0700
> > > @@ -1,2 +1,10 @@
> > >  QA output created by 749
> > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > +Expected SIGBUS when mmap() writing beyond page boundary
> > > +Expected SIGBUS when mmap() reading beyond page boundary
> > > +Expected SIGBUS when mmap() writing beyond page boundary
> > >  Silence is golden
> > > 
> > > This test creates small files of various sizes, maps the EOF block, and
> > > checks that you can read and write to the mmap'd page up to (but not
> > > beyond) the next page boundary.
> > > 
> > > For 8k fsblock filesystems on x86, the pagecache creates a single 8k
> > > folio to cache the entire fsblock containing EOF.  If EOF is in the
> > > first 4096 bytes of that 8k fsblock, then it should be possible to do a
> > > mmap read/write of the first 4k, but not the second 4k.  Memory accesses
> > > to the second 4096 bytes should produce a SIGBUS.
> > 
> > Does anybody actually relies on this behaviour (beyond xfstests)?
> 
> Beats me, but the mmap manpage says:
...
> POSIX 2024 says:
...
> From both I would surmise that it's a reasonable expectation that you
> can't map basepages beyond EOF and have page faults on those pages
> succeed.

<Added folks form the commit that introduced generic/749>

Modern kernel with large folios blurs the line of what is the page.

I don't want play spec lawyer. Let's look at real workloads.

If there's anything that actually relies on this SIGBUS corner case,
let's see how we can fix the kernel. But it will cost some CPU cycles.

If it only broke syntactic test case, I'm inclined to say WONTFIX.

Any opinions?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

