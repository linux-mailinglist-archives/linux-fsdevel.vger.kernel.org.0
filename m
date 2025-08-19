Return-Path: <linux-fsdevel+bounces-58250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9D9B2B83D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 06:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FA417B3BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 04:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDA825A65A;
	Tue, 19 Aug 2025 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="S2Ydt9u5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l54C6gbX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E03C33;
	Tue, 19 Aug 2025 04:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755576281; cv=none; b=PUIoENWnnsOOvKUEwsXXsRz4soeEkRxQGZgHAFTWFlqSv7EF1+M1wIF6LjLywph36cpZvcb8KkpZSz4vEQJjKEMyOQ4tDOkAq20Kr49KHlFzCwcszcPSQ+oDzylKrcIcnmQmcwMzhbuR34BzprE8bkPpZNfebdp+uBqpnl2oQLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755576281; c=relaxed/simple;
	bh=2iBcEDDJnDSku4YlF2mS1mhfVjVWc+y2JxmFkXUSkWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otg2Y8ipfcBzxAO0E1rTlte9kUxdZqbAms9V/6+qma3A8bOk23oaQ8rSHVYoSWooTHg7suTIClRo+8gu3g1NKMNt36IPVvMX4wXbMbVhUDUKfrS/X68Z4gziCPN/IhzDUXEci/j5nzgAqXph5JO6hrtHv78yJ1YM8t3gBD3FiAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=S2Ydt9u5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l54C6gbX; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 11ED61400751;
	Tue, 19 Aug 2025 00:04:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 19 Aug 2025 00:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755576276; x=1755662676; bh=uBb3k1TlFI
	xNXzTe9BSC026CGASpV1bEgyEuK5hRhZg=; b=S2Ydt9u5RChxtmJE621UpDqapK
	+uCKz5d4XorNZa9/ROJ0AQM6kZ5e+7yxnc3jTRfMVu/Aa9YM6zG31se9CSOd4chX
	gmjLh5BiUwalYdq1qA3J5ljS4dSnJl91aQ48xc+iIoDbradqkQog/mAfMYMZPl+N
	bHc7CExDRcNrp8WF+1OGCIKO6I0N1pyg/ZexoRYxoA8jOe60lZDTHgFKRORvwEcV
	znTmUH67YGYfmmw+CMcQmsY1uHBG9MhDl454HzRQ41eOTrXM5t/Jee2dl0swP6Th
	YP1OuX6RQM51AzTQK48BRRtB56ypc+I+Lc1Z6Q3GbyDuCnqH52SUVAqlKOkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755576276; x=1755662676; bh=uBb3k1TlFIxNXzTe9BSC026CGASpV1bEgyE
	uK5hRhZg=; b=l54C6gbX/rg6IsXM0nYanVj6nnjKELaA8di9B0jWKtTw5jHbj93
	tcUkWnHzSRnodnQojodJnQs7kuKQF/3X3SjTcLwzYWnXI2G1kP6p1+XUSzYVm2YM
	02r1MrrXZ+uIUO3r3rFAytAG4XliTSAeDed5ehoC6gRx6yiSIgEMh9zNkG6eSJLT
	wgzEKufMQl6tUze5ZsWZj4ArpO5eHzpaPD94qPCxlcv5wfQMTBJzRfSpOCITfQZ+
	bfPoVBokYXMyLDHFrD99l5WJ8Y+f7Tyg9EWKV4JioYxryHpbopa4WTwnjuhzzxWT
	VxIrK8bH0wmzzomLKWxKmNoDXxYY0k+W3VA==
X-ME-Sender: <xms:0_ejaCs74Jt248NrPZl-ZqGKHOVwoNb7FCmzfurS5nsdLQgm_Wb2rw>
    <xme:0_ejaM9p0O-gwqiUcvRs5Y7ZwrVtNBsgsOQ-iR3z53mJeWLkwfJX3TDj6JTPFfK26
    nj4bfGaaipDfPk-MKU>
X-ME-Received: <xmr:0_ejaM3Yn5LfNjpyVsgMomxfcc_Dplhs4sB0sVtlTf9oqUOgCBdHMZx9WNIgrxOja9IxXjmDMj0Fb-XEYTvHpbuhyoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeggeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeduvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthhtohepshhhrghkvggvlh
    drsghuthhtsehlihhnuhigrdguvghvpdhrtghpthhtohepfihquhesshhushgvrdgtohhm
    pdhrtghpthhtohepmhhhohgtkhhosehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0_ejaBiLbHc1kmaWR6VG6iDDnbFp89Xhn9VuOIMaB7PGJa7scODRog>
    <xmx:0_ejaMZHubobxkMM7UhNQkk7N9Jt7yjSQsNPUNd5KD_PfSWW_UCi1g>
    <xmx:0_ejaNWU11K446OLnkczrA1Cx8iaqxipJJV6P_KGubGkHykk6uKa2A>
    <xmx:0_ejaEFcS0VBPGrjhBIZBLj_9eQx8J22lLA2tDgwF8TscPv6w9fkVQ>
    <xmx:1PejaJrCoiAD0_6X7YpdrufBMImgf4ul8k-Q9IKluoIwsyR-y378izCc>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 00:04:34 -0400 (EDT)
Date: Mon, 18 Aug 2025 21:05:10 -0700
From: Boris Burkov <boris@bur.io>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com, shakeel.butt@linux.dev, wqu@suse.com,
	mhocko@kernel.org, muchun.song@linux.dev, roman.gushchin@linux.dev,
	hannes@cmpxchg.org
Subject: Re: [PATCH v3 2/4] mm: add vmstat for cgroup uncharged pages
Message-ID: <20250819040510.GB740459@zen.localdomain>
References: <cover.1755562487.git.boris@bur.io>
 <04b3a5c9944d79072d752c85dac1294ca9bee183.1755562487.git.boris@bur.io>
 <aKPmiWAwDPNdNBUA@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKPmiWAwDPNdNBUA@casper.infradead.org>

On Tue, Aug 19, 2025 at 03:50:49AM +0100, Matthew Wilcox wrote:
> On Mon, Aug 18, 2025 at 05:36:54PM -0700, Boris Burkov wrote:
> > Uncharged pages are tricky to track by their essential "uncharged"
> > nature. To maintain good accounting, introduce a vmstat counter tracking
> > all uncharged pages. Since this is only meaningful when cgroups are
> > configured, only expose the counter when CONFIG_MEMCG is set.
> 
> I don't understand why this is needed.  Maybe Shakeel had better
> reasoning that wasn't captured in the commit message.
> 
> If they're unaccounted, then you can get a good estimate of them
> just by subtracting the number of accounted pages from the number of
> file pages.  Sure there's a small race between the two numbers being
> updated, so you migth be off by a bit.

I don't think there is any over the top elaborate reasoning beyond being
precise and accurate with stats being a good thing.

In my experience, implicit calculations like the one you propose tend to
lead to metrics that drift into incorrectness. Today's correct
calculation is tomorrow's wrong one, when the invariants from which it
was derived shift again. We have seen this in practice before with
kernel memory usage at Meta.

I don't think this costs a lot, and it has an easy to understand
definition. Are you concerned that there is only a single user in btrfs,
so that doesn't merit defining a new stat?

Sorry to put words in your mouth, just trying to guess what might be
objectionable about it.

Thanks for the reviews, by the way.

