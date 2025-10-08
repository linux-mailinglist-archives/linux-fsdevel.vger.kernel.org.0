Return-Path: <linux-fsdevel+bounces-63603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41D9BC57CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 16:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829573A811F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4092EC560;
	Wed,  8 Oct 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Q+HbRt8n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ps8/ZbSd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D3324DCF9
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759935252; cv=none; b=CZQTifoy5cZg7bTqrtGIhiiQ8ngSHjp8Z+X1zGLj+hufRH1/UFChnXDuP5gSjIDZ5bI0EdKNV/Z14tA3JDgEsGdS3m7N4n0wJYCbdyjOexjPfzOx4wKTdwaXE84Najg9P+VkGZKljROoLv4zRZdAhy8a9ZOrEuBow+GarHrjtkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759935252; c=relaxed/simple;
	bh=7FHWcQrS8236m+Hy0xeNahUEkkTf8hBjMXHe1XoZ8B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+uHKNM5qLJr7RMUfW4mNNjJ2GoqUPD13xgyAqCkbe4VVkdbwnb3Hkk0IVt6kpkRd1rhxiKsZlR8/2lNn/ScW1pZMyawkddVR++xsLS824gYqac0RLzvhs+i5eT4Jp7UIZuG59IKqOh1p9c9TnDAly8X7Z3j5pfGVRhv4LnJHLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Q+HbRt8n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ps8/ZbSd; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C5551D00055;
	Wed,  8 Oct 2025 10:54:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 08 Oct 2025 10:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1759935248; x=
	1760021648; bh=cxjXQzbYHa9gdrvaIHZq0mlCekuWfVqLUGcO7cpYi3U=; b=Q
	+HbRt8n4WWT5Fk6U7SJJvBGgyVjay+Ch3Pnr4JwSiHGIrpFTUvwKJ4DKvpmQYJ3u
	9StJV4XcgJaPYQRVRNbAr6Y9xpTB1ahmPInLXGI37gRLnaZ9YwugmDMPZ42mCoOG
	joeHDepYVSf7q5KYfRPSyi3C8f3I6yjKN0AtMH7H1WKGr7k8lvip1IyYXYkGAtIT
	cGZuNfVpArA2nqowdr1DaXvg8xwvLaKVuRPJNEj1x0yxAmbe/lisRenEv7cyjwTf
	vnQIVRbf7JUFOdeFef2hXiZ4W1vdAPDfn9N1CHo2c2Oi+rODi0tQZI5sa4i6OGnM
	2wVjfX0w4XYzIgwyJ6jaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759935248; x=1760021648; bh=cxjXQzbYHa9gdrvaIHZq0mlCekuWfVqLUGc
	O7cpYi3U=; b=ps8/ZbSdxARwBXdeCKHuJgVwjInbM2/ItY0ahzgp+3NsbHND4am
	1q8oxD9RJS3sssbZjMZRuB2+Jf1KbXcD0Z2PCoL4JMG4KI2Vlef4+TbCChe9GmEB
	EQGM0iEtvrjuslO622idvbLETF6lnItWyZJapYAg7JhBpqyh2pkPFtzuVvWzCEmh
	Lo+4z3qf6mRGYoYxgVT/OhHfetdWC/uTQlkmVkJhnoR6PuBgMu55gJbu1KPXjINN
	3Hxq1UuYIy0srz4zv4LlBv06BxPk4iTA122Xlz5bxJ9iWn6XGrgub3PBnCHNhK4W
	AAhlLlG6e5MWxHaE9Y9nu6MtWuBmif4mKIA==
X-ME-Sender: <xms:D3vmaPkXz-0p-LqJ53si7ifLxQnlRLRatVBcBI_11ctHYmKPFqpMaw>
    <xme:D3vmaF7st4hBKtzOihNXaUY5agPEZRUdQdzN-LLYy3hXonlHUHN5dcpO7SRyERVV1
    xWRTe7nBKvhG_xMmPszPbfYvdeoEHX6K6f7acV7PHNZCNW0kfBszOY>
X-ME-Received: <xmr:D3vmaATwcTvRsJoJH8TVLA-Umga8yui94ZIwajmtSY4tza_p4-L8m8QrU9Be6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedu
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughssehlihhnuh
    igqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeifihhllhihsehinhhfrhgr
    uggvrggurdhorhhgpdhrtghpthhtohepmhgtghhrohhfsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:D3vmaDxB2UES1dtMqkK3RIlF6QYxUODmoefxum_9xjhXquPr0yKIig>
    <xmx:D3vmaIoXLflSPLcHVl_6yOnUQls4R3zAMuoOULjyttPrvkEgv4UZYA>
    <xmx:D3vmaG0SA70G5S13n9--vCA8EsxzmixMUwNQ5eoJOMLfNoexKp2W7Q>
    <xmx:D3vmaIyI00jkSyFKEYGX-ud23kYOkogdbyC1HHusVy4-LvdnxnL_xQ>
    <xmx:EHvmaK6oUWl1iRaqYzM3yV4euRPrYpM1kBQsE3eHFFNe4Tdu4EliPIMP>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 10:54:07 -0400 (EDT)
Date: Wed, 8 Oct 2025 15:54:05 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Optimizing small reads
Message-ID: <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp>
References: <CAHk-=whThZaXqDdum21SEWXjKQXmBcFN8E5zStX8W-EMEhAFdQ@mail.gmail.com>
 <a3nryktlvr6raisphhw56mdkvff6zr5athu2bsyiotrtkjchf3@z6rdwygtybft>
 <CAHk-=wg-eq7s8UMogFCS8OJQt9hwajwKP6kzW88avbx+4JXhcA@mail.gmail.com>
 <4bjh23pk56gtnhutt4i46magq74zx3nlkuo4ym2tkn54rv4gjl@rhxb6t6ncewp>
 <CAHk-=wi4Cma0HL2DVLWRrvte5NDpcb2A6VZNwUc0riBr2=7TXw@mail.gmail.com>
 <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka>
 <CAHk-=wjDvkQ9H9kEv-wWKTzdBsnCWpwgnvkaknv4rjSdLErG0g@mail.gmail.com>
 <CAHk-=wiTqdaadro3ACg6vJWtazNn6sKyLuHHMn=1va2+DVPafw@mail.gmail.com>
 <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
 <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com>

On Tue, Oct 07, 2025 at 04:30:20PM -0700, Linus Torvalds wrote:
> On Tue, 7 Oct 2025 at 15:54, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So here's the slightly fixed patch that actually does boot - and that
> > I'm running right now. But I wouldn't call it exactly "tested".
> >
> > Caveat patchor.
> 
> From a quick look at profiles, the major issue is that clac/stac is
> very expensive on the machine I'm testing this on, and that makes the
> looping over smaller copies unnecessarily costly.
> 
> And the iov_iter overhead is quite costly too.
> 
> Both would be fixed by instead of just checking the iov_iter_count(),
> we should likely check just the first iov_iter entry, and make sure
> it's a user space iterator.
> 
> Then we'd be able to use the usual - and *much* cheaper -
> user_access_begin/end() and unsafe_copy_to_user() functions, and do
> the iter update at the end outside the loop.
> 
> Anyway, this all feels fairly easily fixable and not some difficult
> fundamental issue, but it just requires being careful and getting the
> small details right. Not difficult, just "care needed".
> 
> But even without that, and in this simplistic form, this should
> *scale* beautifully, because all the overheads are purely CPU-local.
> So it does avoid the whole atomic page reference stuff etc
> synchronization.

I tried to look at numbers too.

The best case scenario looks great. 16 threads hammering the same 4k
with 256 bytes read:

Baseline:	2892MiB/s
Kiryl:		7751MiB/s
Linus:		7787MiB/s

But when I tried something outside of the best case, it doesn't look
good. 16 threads read from 512k file with 4k:

Baseline:	99.4GiB/s
Kiryl:		40.0GiB/s
Linus:		44.0GiB/s

I have not profiled it yet.

Disabling SMAP (clearcpuid=smap) makes it 45.7GiB/s for mine patch and
50.9GiB/s for yours. So it cannot be fully attributed to SMAP.

Other candidates are iov overhead and multiple xarray lookups.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

