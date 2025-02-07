Return-Path: <linux-fsdevel+bounces-41246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F063FA2CB45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 19:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F0E1665D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 18:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D93C22F157;
	Fri,  7 Feb 2025 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="AB9YNfh1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xNEd1VJB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85989227568;
	Fri,  7 Feb 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738952506; cv=none; b=sn0xBDpCm+GgTHALA5QZOJVmFXl0BGNyhx0koJ01/UTjHos6wTo5k9ufOI6nmWow2k3BsDtpkgoGrVMD2U4Y+Y+L2fPpfuf4EOvcjryVUJ032RA3yeJadnjGrhHReCVwxwhLep17AoEOMwP8KJ4HKWs4PaYzrThAShoNWrJ0mGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738952506; c=relaxed/simple;
	bh=oR0fubKKlOsd+U2WicjhafkdDgnQ9KJD7ihnF2MaLAc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BCQ4hIHm8VAptCellHJp0YnKit0bHSSmIJWAngkN+WE+8rO0451B6M5bMJuYlSXCHOD6MSfallGfIEKHqYao7PNA7mFC8XTfsfPuuqBsRDgU1+QVLoEao0oH0kjt7WSA8xJej76LX2sBPkpkrXmOZeavfX47EknKT6xt5lxaD4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=AB9YNfh1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xNEd1VJB; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id DC941138006B;
	Fri,  7 Feb 2025 13:21:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 07 Feb 2025 13:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738952497;
	 x=1739038897; bh=CCGJeW5vu9jhNEnR12qD8kNSuNkT/Sn9sh0M3/XiisA=; b=
	AB9YNfh1k+drxnQd+pZiC2mD/Q4PsYGO46Ot5pGLShKyHShiOyNadwUa1SfwWSUB
	UIN3ITE5jqtmkWQjQJcktG7e3iuxUdWN5gak2Sj5JPEZ/LThl6bBX7hgDK7LITFi
	mC+ON6ytLK3GFd5nC4Nferde33uKbmXUG1EBzCnqvG8n9+c9NRKO2WLdTWh+H3Ps
	DJy7CNB6/s6lev4vJwHYe4G9sgeucS4wlvXpYz9YUQE6hP6mW6/AEdgr5HGwETU8
	CViCgeB+veSp/1RRoZcOFUsAkradyCyKRk5otDpIImT24c8njnkO1X0s9yuwAg1K
	RvjrZxHUbBt/uGPlcAizlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738952497; x=
	1739038897; bh=CCGJeW5vu9jhNEnR12qD8kNSuNkT/Sn9sh0M3/XiisA=; b=x
	NEd1VJBmnNofE3eYIBeh5e/0yDukSWTzSGlYseCh6HIhMieC8VQdM3w1CJAoMCYQ
	j4Tzm1L18zXGjVxNII/Ew+Qpa7hx1JpmJYivCkDA2QdL+L1Rv6sxVbbYZKZjFVfw
	oTZ64FsIqTylozL/UFbDSzYc3qHQiZvU8trgo9OWdAqa7xyah1gfb8VUfsht2PxJ
	dvosIqoCWRofpt/jSFGnFi+xVrKoQV/8vhil7mrGfQXM9UHtL/nQ1WFNCyzpl6S3
	2Rd44WXilapr3dHdcWErJjgNu6FyDUIB4/D5qMGer9oEon6RG6whXH6ddTftU55b
	51MXVkeOBunyFcIanDvsg==
X-ME-Sender: <xms:ME-mZ05FQlPMtqwl8EQTdF4HvQCuckWYcoxdgvQUHNzTUUS6NP047A>
    <xme:ME-mZ16yWc2hikqbhTHYdMRqMrAKeNvGqeB9eaExmlytN1x5jLGEmBKo_qibWKagk
    9XzLq4VALKBdNsb>
X-ME-Received: <xmr:ME-mZze-ee-GzK25W1NjAuKLMtk1h0Xzgq3vj8IbxQoMbOuYlineDCINeKvMIUwDwIsJdY6qKNrkMQ8igEtOcOjBWfTB76uAexPNYl43AQHMiMFesBVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuhffvvehfjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugessghssggvrh
    hnugdrtghomheqnecuggftrfgrthhtvghrnhepgfdtudehtedujeelueeiheffudegjeev
    hfekvefggfekieetgfffieffieejueejnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghr
    nhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhrtghpthhtohep
    mhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopeifihhllhihsehinhhfrh
    gruggvrggurdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnheshhgvuhhsvghlrdgv
    uhdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtth
    hopehmshiivghrvgguihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhgvghhrvghs
    shhiohhnsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ME-mZ5LTUqmYQacr5-QCjbvzmcc_eSWKslRhqQOUKz40qll6cmNAYA>
    <xmx:ME-mZ4IFNWUTSdGtxuP80iPVpIonXEkY-9AURQres4-_up_eY1NlNQ>
    <xmx:ME-mZ6zARAuveKc3azce1wRol4i7S3n29OAqyEJBdr4T7vvhg_DJvw>
    <xmx:ME-mZ8IijsotW7yGYii9pojQSeodUMdp0YftSL0OkjaY9HnyJ_w7_Q>
    <xmx:MU-mZ6BX8LAdYs1Np7OGnk8hYzpolUQce27zn3980CH8diVwq-yJ4bKb>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 13:21:35 -0500 (EST)
Message-ID: <ca0dfc92-7b23-4c37-98b4-02f3396691fb@bsbernd.com>
Date: Fri, 7 Feb 2025 19:21:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
From: Bernd Schubert <bernd@bsbernd.com>
To: Vlastimil Babka <vbabka@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Matthew Wilcox <willy@infradead.org>,
 Christian Heusel <christian@heusel.eu>, Josef Bacik <josef@toxicpanda.com>,
 Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, linux-mm <linux-mm@kvack.org>,
 =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <Z6XWVU6ZTCIl3jnc@casper.infradead.org>
 <03eb13ad-03a2-4982-9545-0a5506e043d0@suse.cz>
 <CAJfpegtvy0N8dNK-jY1W-LX=TyGQxQTxHkgNJjFbWADUmzb6xA@mail.gmail.com>
 <f8b08ef9-5bba-490c-9d99-9ab955e68732@suse.cz>
 <94df7323-4ded-416a-b850-41e7ba034fdc@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <94df7323-4ded-416a-b850-41e7ba034fdc@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/25 12:16, Bernd Schubert wrote:
> 
> 
> On 2/7/25 11:55, Vlastimil Babka wrote:
>> On 2/7/25 11:43, Miklos Szeredi wrote:
>>> On Fri, 7 Feb 2025 at 11:25, Vlastimil Babka <vbabka@suse.cz> wrote:
>>>
>>>> Could be a use-after free of the page, which sets PG_lru again. The list
>>>> corruptions in __rmqueue_pcplist also suggest some page manipulation after
>>>> free. The -1 refcount suggests somebody was using the page while it was
>>>> freed due to refcount dropping to 0 and then did a put_page()?
>>>
>>> Can you suggest any debug options that could help pinpoint the offender?
>>
>> CONFIG_DEBUG_VM enables a check in put_page_testzero() that would catch the
>> underflow (modulo a tiny race window where it wouldn't). Worth trying.
> 
> I typically run all of my tests with these options enabled
> 
> https://github.com/bsbernd/tiny-qemu-virtio-kernel-config
> 
> 
> If Christian or Mantas could tell me what I need to install and run, I
> could probably quickly give it a try.

Got firefox through flatpak working with 6.13 + patches, 
but the flatpak fuse mount is basically empty and I didn't observe
any issue. Would be great if you could post, what exactly triggers
it.

Thanks,
Bernd

