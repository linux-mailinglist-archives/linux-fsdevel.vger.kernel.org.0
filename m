Return-Path: <linux-fsdevel+bounces-37924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD24D9F9119
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 12:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09DC516C3D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 11:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93D11C1F1F;
	Fri, 20 Dec 2024 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="oHVsPVRj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QAiA/sDE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555741BC066;
	Fri, 20 Dec 2024 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693928; cv=none; b=f24pqKBI88nL3jjw+9mpTYG6iUVpPi/y6QRRo2p9YD6QAgWYf+v4ZoOFbWztVXVBGdvjmkCisVNsC4KSM3/FT4QlCpEbR+CQ4QsAlszpnkEb0g2BxlZqSizfg1u5ANGQ/B9sTRj+ujKxEzpWWb1vgFAr65tGbdVKeLIBSQRR9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693928; c=relaxed/simple;
	bh=a+7IgKHdc5XVFG8sm+X4KTELPVl+8Sgfe+xOGT9eeNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGoIAnTOBdrMA2n35vliInk1d0dG1u6cYvb1l9yTwNW7IYtXSo+f/4aOW9WXohhy8MzS6C9Uiv9wyQiuV2XheN1ffRT4q8Gyh2NYprEGJqJSKr/+mCBuWVnu3Te/YZ4+luC6DrjE/izSJlDf+Uq4smquni7kKNxe5NwUPrPGX/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=oHVsPVRj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QAiA/sDE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A2D213801DE;
	Fri, 20 Dec 2024 06:25:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 20 Dec 2024 06:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734693925; x=
	1734780325; bh=auxqDTQvBNHnPTsv/fsGOI6AWiLPzFN3WSRZnI7RWKM=; b=o
	HVsPVRjmyaz1VfLbSzAsAJBe6sTqead64wO1TMqZa4NzJVOAozQ/aB/4d5eVh+T3
	h5bcnIwNSt7ZT0y5vrAUZC0JE2pU7CwjYrLq6a2mJfsHn/5Yg3zJ1F0ZpPXKz1W1
	M3FEG0N2CRfl7IzSbyiemVhQlooST8RHfR8EvJgjHFAm7SAolE62fQLqxDfh2MCe
	J6kpaOQzrQflNhlnHBQCzfeM+vCh4XjvAlyZybWYDKtx/9ATGnFWzYY1M83Lig6u
	Qb1wA3qD2xV5Ewbqfd46joNHyIbg9aVOoPrbbvghuxt/um1stXHTSrWOBDlQS6SF
	Dgdmh6YhdLjup8kDCjS2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734693925; x=1734780325; bh=auxqDTQvBNHnPTsv/fsGOI6AWiLPzFN3WSR
	ZnI7RWKM=; b=QAiA/sDEWRPoMdVLL9dVfwmC5V/+gY5tJ5ld5feN/K8XJtzCYpx
	9aX1V9G7cJ2IzoMz8LIv2yDQKozDwTj9LwXNcax9FV+7xcYxM+SRHA5Bm5Dqrwlu
	xEoNtAHH3jrG8gPCP102fs03rH0lzim+7soMrqKTb215PZoou42P8uZz6EnnYWf3
	tYhcXXcZlR68Rm6tKMS7EjWrXTGImfxLwLqEcIDaXYUs59WMWjL9nD9Vd6iV/QBx
	Nsalal5B+eDz1AfFk1Scpftkve7hPgz0UVPNUcvfh3awEuz6s067ajCgmwLxv8fr
	CbgRtU4isoOPjJHuUAPYmNX7JHRfhl2kaYQ==
X-ME-Sender: <xms:JFRlZ0519mdAToXsmpMJ7340kmWk_885-dblwe5VzbaunsM14ITPLw>
    <xme:JFRlZ14iMsE1mIbB3dZ6sb5okCNnWTejA-ANCuJeVACLBsl5VaSwXlYE8E3h6-L-P
    tJmsRdBPWF0cT53KvA>
X-ME-Received: <xmr:JFRlZzduQXdiHp84hON40UdrTyElC-4zEUgEU1WMkua4eT1q5Hz980i1JebS35gK2ggaeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeeltedugedtgfehuddu
    hfetleeiuedvtdehieejjedufeejfeegteetuddtgefgudenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhope
    ekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrgigsohgvsehkvghrnhgvlhdr
    ughkpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehhrghnnhgvshestghmphigtghhghdrohhrghdprhgtphhtthhopegtlhhmsehmvg
    htrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtohepsghfohhsthgvrhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:JFRlZ5LDeCGozRWHCFJpebzhPUhyFBsBt99FISUGTDTtazE5ZCgNRg>
    <xmx:JFRlZ4I1_OLUBJf43dLj3olct6XvUP8FzXxIUFeEa_sRanhvhcQEig>
    <xmx:JFRlZ6wwNM5CxjGAKdmVSVUbma-5Ot2W7_TN4N3f4Oyyl1eHdr5uAw>
    <xmx:JFRlZ8LSICniCIzBptgp_QuOwkZbFTPScOm8zzBRZnb6xbpCen7tSQ>
    <xmx:JVRlZ39SFJOhleaqmgvxBII16P-RPGo7Tt0PbVdQy0MFYkzYHjVLUp_j>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 06:25:21 -0500 (EST)
Date: Fri, 20 Dec 2024 13:25:18 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
	bfoster@redhat.com
Subject: Re: [PATCHSET v7 0/11] Uncached buffered IO
Message-ID: <tp5nhohkf73dubmepzo7u2hkwwstl2cphuznigdgnf7usd7tst@6ba2nmyu4ugy>
References: <20241213155557.105419-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213155557.105419-1-axboe@kernel.dk>

> Since v6
> - Rename the PG_uncached flag to PG_dropbehind
> - Shuffle patches around a bit, most notably so the foliop_uncached
>   patch goes with the ext4 support
> - Get rid of foliop_uncached hack for btrfs (Christoph)
> - Get rid of passing in struct address_space to filemap_create_folio()
> - Inline invalidate_complete_folio2() in folio_unmap_invalidate() rather
>   than keep it as a separate helper
> - Rebase on top of current master

Hm. v6 had a patch that cleared the PG_uncached flag if the page accessed
via non-uncached lookup[1]. What happened to it? I don't see it here.

https://lore.kernel.org/all/20241203153232.92224-14-axboe@kernel.dk

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

