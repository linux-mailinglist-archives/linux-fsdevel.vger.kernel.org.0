Return-Path: <linux-fsdevel+bounces-52908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90304AE84CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 15:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D433189B3B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 13:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D711A83E4;
	Wed, 25 Jun 2025 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dXGe4/nZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SccpscEX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE78188715;
	Wed, 25 Jun 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858215; cv=none; b=ZkUAa+ar1UUz6m9kBt0AXn5IFMj3iu1nSyQHZBq3Zi1wUTWOJA850RdR2mJiQsY3Ow5VBnzU6dUzi2ENQjGF668b0vpeXgj8I1JnNcfY0qP00/jC9hvhQlNh/MbY1YZLbEpcaFYammJE8SlaZwJhpfPPvpKN5osPbkptjbGpd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858215; c=relaxed/simple;
	bh=vuHqH1PEJjDubr/N9Vp6Y8axigxhUhtGqTy2JWe5oNk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YrSK/P/G/2Rz63eCU8RuRnSYBi1eAzuGDohxeiHA3Hz+3q3mODG0OQWpveFcl4vE4KxZsao7qLKZvjVeOXXAFm/qOIntT9ZulF+47HQx6XgkJUchTHnOvKnXix37CYHU4obuwtVVpZDY6g/Xorpb/wzfIxF6u8LT+/u31Dq6DYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dXGe4/nZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SccpscEX; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 71296EC0254;
	Wed, 25 Jun 2025 09:30:12 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 25 Jun 2025 09:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750858212;
	 x=1750944612; bh=XF9TgJ4TM+rMZuwH8jLpih446v5Y7WgDzSnif4Skai4=; b=
	dXGe4/nZGlrqMcAkEn6WpxSoA7U0ZSTDmqEIxwgm6w/SWaAUP7J7Ki4yQaaEj2lL
	++48R0LFGoXAj/KRtqLNmiUDmSi6pmNAkXmv8byre6Iot2oc9WoFXeOMLgXY7OG4
	ytc78svQ0YDeMGdoHF2NBTUAaj1/y/W4fLXFWmSyhNHOZKsceCnUJgdBl22Fs5lX
	jArCH07Mr3c/4GX4l3znLORUVh46SLfAk/bslDzWb0DQxr6nJkUJjWyMF0RMI82K
	Brj7M+bXSG1RUqM+xIG6wQuCaZXgS5NZQwBGYWqSQxjWSWaN4uy42zaGcD0z6933
	T9BOBcAL5g9nbDmxbVKvHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750858212; x=
	1750944612; bh=XF9TgJ4TM+rMZuwH8jLpih446v5Y7WgDzSnif4Skai4=; b=S
	ccpscEXfCYF5acR+hKZjipG83cA1rUynfX/2wf++nANktF0+1FaR2vetu9yAvMuL
	5X+57/15mlhHW1AQAE//afhx36xGRrFmKlOWYjK9MSDjiq3DG6ENW8YZ39oiA1bc
	Bm6Quza6lUWfkztxuXHxX+xJ4cmFx4vJDF01nnIt8D1Vd6IxtRv2p1sLktpr4NTy
	ryUE1WNMPbuu8vfNGaMCuaSk8LsWvkKiulAoJxbzgVdx2GydszDGkPXYh9sbxxb2
	MTImfziveXvyVOtSo976ga2D/zxekCa7Jl7FXh0im9oFbAIg0o+NOSxxTsgIlpZX
	MgYf6pKQ9lacCWL3WoiVw==
X-ME-Sender: <xms:4_lbaEx1jXUWSYXBR1joL8AQVSOvcZHNnwh18ovi1Rm2QcBLwMRu3g>
    <xme:4_lbaIRVo3b76TYuCmqQRz4U5ZBKwotU7zklHi7qQgCvZZIlJMNGjEWwENex2MKJ7
    o9wFCp19-cLgLEZD0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhutggrrdgsohgttggrshhsihesghhmrghilhdrtghomhdprhgtph
    htthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrrhhnugeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhho
    mhgrnhhksehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtoheprghlvg
    igrghnuggvrhesmhhihhgrlhhitgihnhdrtghomhdprhgtphhtthhopehmrdhsiiihphhr
    ohifshhkihesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrd
    gtii
X-ME-Proxy: <xmx:4_lbaGVZcIeD3Bqb4N5JHA9n3DBFN_GP7M5MaQhMx2ZhJ0FC8L830A>
    <xmx:4_lbaCg6Jt-QmmvfhUlhwfx4nbdJ7Cl_X3h_0_8QS7sZ1p8K9t-xvw>
    <xmx:4_lbaGB3quRHyfglsSxgPk27JsxyQI-EJY448kPfLs4EN6YLHtfX2Q>
    <xmx:4_lbaDKwO1G0rtFfE-uc1zR7IpCawWIsOF15NEL0fchIkAtNGtAJuw>
    <xmx:5PlbaBHsDXBNJ1MIz8A4lTQHAn-P6-7ZAzOYf1M1n-dpEbDK5UWGRSaT>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 85D04700065; Wed, 25 Jun 2025 09:30:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T0a33ac4b6ea30a8c
Date: Wed, 25 Jun 2025 15:29:50 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
 "Alexander Mikhalitsyn" <alexander@mihalicyn.com>,
 "Jann Horn" <jannh@google.com>, "Luca Boccassi" <luca.boccassi@gmail.com>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Roman Kisel" <romank@linux.microsoft.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <cb0c926f-15be-4400-a9b9-0122a6238fea@app.fastmail.com>
In-Reply-To: <8f080dc3-ef13-4d9a-8964-0c2b3395072e@samsung.com>
References: <20250620112105.3396149-1-arnd@kernel.org>
 <404dfe9a-1f4f-4776-863a-d8bbe08335e2@samsung.com>
 <CGME20250625115426eucas1p17398cfcd215befcd3eafe0cac44b33a7@eucas1p1.samsung.com>
 <8f080dc3-ef13-4d9a-8964-0c2b3395072e@samsung.com>
Subject: Re: [PATCH] coredump: reduce stack usage in vfs_coredump()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jun 25, 2025, at 13:54, Marek Szyprowski wrote:
> On 25.06.2025 13:41, Marek Szyprowski wrote:
>>
>> This change appears in today's linux-next (next-20250625) as commit 
>> fb82645d3f72 ("coredump: reduce stack usage in vfs_coredump()"). In my 
>> tests I found that it causes a kernel oops on some of my ARM 32bit 
>> Exynos based boards. This is really strange, because I don't see any 
>> obvious problem in this patch. Reverting $subject on top of linux-next 
>> hides/fixes the oops. I suspect some kind of use-after-free issue, but 
>> I cannot point anything related. Here is the kernel log from one of 
>> the affected boards (I've intentionally kept the register and stack 
>> dumps):
>
> I've just checked once again and found the source of the issue. 
> vfs_coredump() calls coredump_cleanup(), which calls coredump_finish(), 
> which performs the following dereference:
>
> next = current->signal->core_state->dumper.next
>
> of the core_state assigned in zap_threads() called from coredump_wait(). 
> It looks that core_state cannot be moved into coredump_wait() without 
> refactoring/cleaning this first.

Thanks for the analysis, I agree that this can't work and my patch
just needs to be dropped. The 'noinline_for_stack' change on
its own is probably sufficient to avoid the warning, and I can
respin a new version after more build testing.

     Arnd

