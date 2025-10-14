Return-Path: <linux-fsdevel+bounces-64128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88284BD97BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0EBAB352BC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8828731355F;
	Tue, 14 Oct 2025 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="fXEDl3t4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nb22c+Sx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513FA313530
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446711; cv=none; b=b3jx2xD5s26u+7yaE2+jlqalcKyoPmO9NnwjOowsMdyP/l1Pu7VUpdPWUAWUoyHT3M6VQeNalCgopbauh4PLjqW2JschjToVCMei8ux/IE4wDS+3ncGJsfMQJ+eiVb21eadb8HgzcwvloqL02rDdC/9glba1qV1/4OfmBkN5uso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446711; c=relaxed/simple;
	bh=uet+BtZTlAxor6IkrL9lXe4NV7w/DBbY2z4UVZWzpo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hztXP6KmNcR6b163APwQ2vvNJh7adAKM/uutMhv4ehPNhfLkqHuwgT96hkSNxIEDZNI6PSyFItCijUvPAiQaNgx7O3BtpRfm8OgWCODWnZUEuK5Ca3Pwi4QHUB3itxb7895ZuxVYHcMkCAR3F1it60SSSLdrIOmQ8eLYLXUN1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=fXEDl3t4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nb22c+Sx; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D75F14000EE;
	Tue, 14 Oct 2025 08:58:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 14 Oct 2025 08:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760446708; x=
	1760533108; bh=u6LKml2pyPSTZcevZ804GiM8rOEYpqXLcQSqWC6v/9E=; b=f
	XEDl3t4bZjYkKGTfqhLQZhK8NQDLKPVQHpJ2wy6BbqnfG/SCz99JC5BwzLOhd5At
	w7kHsQQgFDgos7dxM88z0/WQvUzDp7BdePP6QVKuiKbOQIFNZmG8bJCLZJn98eRF
	W3356NbDYS7HKSKQIzqMmyqKrHnKfwPmdpmnCe24YU/a/bRfrBZnTHiO5lkMeGZD
	uXndhDOI0iABQTafifiS6/nl7a2PemA1ILx/hnvzion3rglkGxaQI0DJP/+HCeV4
	fhScVKh2ildfRXK8NgoAWnwiWqiMVwT6Sjc0cCtakR0DnuE1MF0AcoKcVz+xPg9b
	b1v26fNFPF1n3H7HAXVYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760446708; x=1760533108; bh=u6LKml2pyPSTZcevZ804GiM8rOEYpqXLcQS
	qWC6v/9E=; b=Nb22c+SxdaKSYH9ixEJgpwaugop+xr5ctxUOY7zGhPaZYiyBwQR
	/JQ39TggLma1Mfwq+E8vC/k/rIjfxtD7aPn+i1sgAODL2PZHcHk42Se8FejN4TtZ
	2iJkozyuNnb2789M/7N8Ej9PF6WOLuDG7ONatzvzbgSpHs8hvaM4Z3vMeMYN0Lrh
	ij8jVSADPz8EeIYJxq5HDH5ikqJ+t9vebo1AROnTHl7EC3h9QfLEsRdcE6LYt2kl
	qVSDUmlWiGrmk5RO3aO8+isCxII+fJfArTc03j5cnrnzbQvYyU2fDKaiHNIo/Vv8
	5DLHeA7SJ8Qr3TfJj6B/rV24Wf3S23NJeRQ==
X-ME-Sender: <xms:80juaMBemFHcTGYWEWBRdrhfCX4KkzrI-YYoNV4nJL1RFeok4cviFQ>
    <xme:80juaBnZdaw1Fs-JrXtfkEOhn2Ixv40eRUPhbg8MhL0MiZD7DHcYcNnYPdeAmD94R
    Sr9u_xfex0rWRKj_dQQoeCe_KZPNEiBkPYzc4QplRDM2jIMNjKO3LU>
X-ME-Received: <xmr:80juaKO9Y3zHinhRZ-bgVEG74xdNTlXRBBzlEHQ1yXev4YOfXM1aB9sfKIJVqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtheelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:80juaO-nHpgJkVNsquld8r3lxO1G96Efhi65ggThZHK4JvNjl765gA>
    <xmx:80juaMGjAva8TAsdeuDNsS6mpwHmATExQ098GQkJwerdOeh5_6TtTg>
    <xmx:80juaNgvnTSbk64WWN3N4I2QNTu99f__3agVO7FQKYTGvFRryZmXOQ>
    <xmx:80juaBsxhJQzcXenGXzp5na5rL0cG0F0jhA0BT_Cgr5TvKmg6H8wLQ>
    <xmx:9EjuaEkBtEB7lnMzcQjuAsmUsXX0qQCy8VBBEcWUPXjklRP9h6dmEtVt>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 08:58:27 -0400 (EDT)
Date: Tue, 14 Oct 2025 13:58:25 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Optimizing small reads
Message-ID: <wfneq47jscotsqb2hhwpjfp2hqz4d7yyw643yagqnqvh74opvx@5fnmgowterq5>
References: <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp>
 <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
 <CAHk-=wi42ad9s1fUg7cC3XkVwjWFakPp53z9P0_xj87pr+AbqA@mail.gmail.com>
 <nhrb37zzltn5hi3h5phwprtmkj2z2wb4gchvp725bwcnsgvjyf@eohezc2gouwr>
 <CAHk-=wi1rrcijcD0i7V7JD6bLL-yKHUX-hcxtLx=BUd34phdug@mail.gmail.com>
 <qasdw5uxymstppbxvqrfs5nquf2rqczmzu5yhbvn6brqm5w6sw@ax6o4q2xkh3t>
 <CAHk-=wg0r_xsB0RQ+35WPHwPb9b9drJEfGL-hByBZRmPbSy0rQ@mail.gmail.com>
 <jzpbwmoygmjsltnqfdgnq4p75tg74bdamq3hne7t32mof4m5xo@lcw3afbr4daf>
 <dz7pcqi5ytmb35r6kojuetdipjp7xdjlnyzcu5qb6d4cdo6vq5@3b62gfzcxszo>
 <CAHk-=wgrZL7pLPW9GjUagoGOoOeDAVnyGJCn+6J5x-9+Dtbx-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgrZL7pLPW9GjUagoGOoOeDAVnyGJCn+6J5x-9+Dtbx-A@mail.gmail.com>

On Mon, Oct 13, 2025 at 09:19:47AM -0700, Linus Torvalds wrote:
>  - both filemap_read_slow and filemap_read_fast would be 'noinline' so
> that they don't share a stack frame

clang-19 actually does pretty good job re-using stack space without
additional function call.

noinline:

../mm/filemap.c:2883:filemap_read	32	static
../mm/filemap.c:2714:filemap_read_fast	392	static
../mm/filemap.c:2763:filemap_read_slow	408	static

no modifiers:

../mm/filemap.c:2883:filemap_read	456	static

And if we increase buffer size to 1k Clang uninlines it:

../mm/filemap.c:2870:9:filemap_read	32	static
../mm/filemap.c:2714:13:filemap_read_fast	1168	static
../mm/filemap.c:2750:16:filemap_read_slow	384	static

gcc-14, on other hand, doesn't want to inline these functions, even with
'inline' specified. And '__always_inline' doesn't look good.

no modifiers / inline:

../mm/filemap.c:2883:9:filemap_read	32	static
../mm/filemap.c:2714:13:filemap_read_fast	400	static
../mm/filemap.c:2763:16:filemap_read_slow	384	static

__always_inline:

../mm/filemap.c:2883:9:filemap_read	696	static

There's room for improvement for GCC.

I am inclined leave it without modifiers. It gives reasonable result for
both compilers.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

