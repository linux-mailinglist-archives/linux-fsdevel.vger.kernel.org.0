Return-Path: <linux-fsdevel+bounces-41751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 921D7A366D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 21:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5121895918
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 20:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E0B1A2385;
	Fri, 14 Feb 2025 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="h+6hB+R/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XnZzlBNz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950719066D
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564840; cv=none; b=MtdnejVgmuX5yx0ssygBjWHT/Gxh+kOSYsccnxeSEYPqeRPyPf7P1n9U+nsCBsoLcNazkbjPX9V5snLpNT0liIIO9JZHje2pNmbIRKpv2ePGH7utNJzxhTFJ/V5NYNaCYsEU09GlR+zeo90VzjBh7neOrb/wrYm5agyhWXDdApo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564840; c=relaxed/simple;
	bh=l30gXDJkk3vQOwXZM9vj6HDYMdwbnRz7h16SCwvfv5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLDcRO21yoqiWX3sLjLTFlJlTXe01HOv0umrFMt796shPd9jsXi1AM0bcmqeawObAs+OvKobDMAFIQnsfza5rshojk9Ni4+9a4HRNBp+jYHNGy74h/ZqlBYVfRAQ9dIpcb9IvZp8+JMz5Kz6+2Rgqp3GmjNc3JRv7lhcRxuLTYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=h+6hB+R/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XnZzlBNz; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCB671140170;
	Fri, 14 Feb 2025 15:27:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 14 Feb 2025 15:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739564836;
	 x=1739651236; bh=v+TxsuK1oAYTXA9hntue4v265Plh2dSV3NRmTSbdPxQ=; b=
	h+6hB+R/zoyzHmdK/anS8OQdO0l/Vt0dobeGpUknc31LdOliMWJaqIO25d8Xs8RF
	scurmMBRBOA1ysoTtP9SYjGIoYuc4dktUP6U1GbKtLlDj6/IrLHPC6gFNSiRoZGf
	ESuo0rs59slOxKBBqOHg3mv9HYFk+q5qSjzi2RHf6W/Tk6P/qPZzM64oQ4YJ+i6g
	2jGh1YToZEt+oFts4k04HSglKDHHMTXKabQrUnPxMZD40NoiRfPis2CT6dwM1nJp
	TnMZ+mbAml0k2zPBym6G9d7UjF3DyqUxfGpC/3MPyXKWz5Jmvqbue/HK1LYgb89E
	96MSJDMHPag3q4kFbrvdXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739564836; x=
	1739651236; bh=v+TxsuK1oAYTXA9hntue4v265Plh2dSV3NRmTSbdPxQ=; b=X
	nZzlBNznqNy6uZ2ETaFT8DzKsDaERwnPK235+/3TeB/3HKgiBzGWbM4Ez1J3RD+6
	L0xI5oWlhjc+s2uPLOUmpaNqkLS0oXcOQ2h6afnpncpJuSE7i3oawgpb1lN8xKXu
	jzFbapLprdmzSoWVHLtm2C1ObXPwOQoFgcPjtT4zYcUDwbb1zqd9jAdt00wnhejF
	AqjrOsbE8ebI235N8pZKDEu4F41Vyi2J9VIhYJmAD73/CSb56V55ZwNS+grDIV7n
	R9nqYJZRKEBwa8yx72oo2GGs18Jszj+gR3Yv12n4e+tvwCNdG1otw2mfT5Fkl/7s
	ICbiEREcu7pT+LIGMxN+g==
X-ME-Sender: <xms:I6evZwdjnJJADSCmUAQq_jMJtLQnagiXWSS1HLModYtNTRZqTtcvVQ>
    <xme:I6evZyOQ-JHmWCXU87gup3ENlEKQ87YenVEA1VzruSn0zKjomWAguE1xEkb5uM_2z
    kVpfo9Wp_xpWCa8>
X-ME-Received: <xmr:I6evZxgp-ak_DqLoAjY3LcRvj65AHmfXNwbGhLBVhi-X1diZ6-YgPwLNJdse7eEyk9z6YeSJJXeVrD-ChvQsLShIwUVfgee82otEIPxY3iHZP-ruVFx5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduvedu
    veelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopegsshgthh
    husggvrhhtseguughnrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhsvghfsehtohigihgtph
    grnhgurgdrtghomhdprhgtphhtthhopehjvghffhhlvgiguheslhhinhhugidrrghlihgs
    rggsrgdrtghomh
X-ME-Proxy: <xmx:I6evZ197BTFSyrcZqOxdcrnrgEgal2O_xllnaF5v0lBDJCpcT5qIhQ>
    <xmx:I6evZ8ulBCaV7eIv01FG_MUab5KlTnUvEZjf24u0kosAN_x21edv-A>
    <xmx:I6evZ8GV-b5n3RiJECZMu9s3xK1V7wDQmIYvkKNqEOhNRlC-2K_WrQ>
    <xmx:I6evZ7O6WWuelPS6O8ev-xL510K9Uo3LbSJAHy2LImxr4hzrR9i7Mw>
    <xmx:JKevZwiYFJ1hArL7wDiTdfq8A2fxfvsOsfYxgtbbi-EyOMxucDbZUNfc>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 15:27:14 -0500 (EST)
Message-ID: <0d766a98-9da7-4448-825a-3f938b1c09d9@fastmail.fm>
Date: Fri, 14 Feb 2025 21:27:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Add open-gettr for fuse-file-open
To: Joanne Koong <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
 josef@toxicpanda.com, jefflexu@linux.alibaba.com
References: <20240820211735.2098951-1-bschubert@ddn.com>
 <CAJfpegvdXpkaxL9sdDCE=MePdDDoLVGfLsJrTafk=9L1iSQ0vg@mail.gmail.com>
 <38c1583f-aa19-4c8a-afb7-a0528d1035b0@fastmail.fm>
 <CAJfpegsFdWun1xZ-uHXnWBeRz3Bmyf0FSYWiX1pGYU8LEz12WA@mail.gmail.com>
 <CAJnrk1YaE3O91hTjicR6UMcLYiXHSntyqMkRWngxWW58Uu0-4g@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1YaE3O91hTjicR6UMcLYiXHSntyqMkRWngxWW58Uu0-4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Joanne,

On 2/14/25 21:01, Joanne Koong wrote:
> On Wed, Aug 21, 2024 at 8:04 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Wed, 21 Aug 2024 at 16:44, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>>> struct atomic_open
>>> {
>>>         uint64_t atomic_open_flags;
>>>         struct fuse_open_out open_out;
>>>         uint8_t future_padding1[16];
>>>         struct fuse_entry_out entry_out;
>>>         uint8_t future_padding2[16];
>>> }
>>>
>>>
>>> What do you think?
>>
>> I'm wondering if something like the "compound procedure" in NFSv4
>> would work for fuse as well?
> 
> Are compound requests still something that's planned to be added to
> fuse given that fuse now has support for sending requests over uring,
> which diminishes the overhead of kernel/userspace context switches for
> sending multiple requests vs 1 big compound request?
> 
> The reason I ask is because the mitigation for the stale attributes
> data corruption for servers backed by network filesystems we saw in
> [1]  is dependent on this patch / compound requests. If compound
> requests are no longer useful / planned, then what are your thoughts
> on [1] as an acceptable solution?

sorry, I have it in our ticket system, but I'm totally occupied with 
others issues for weeks *sigh*

Does io-uring really help if there is just on application doing IO to
the current core/ring-queue?

open - blocking fg request
getattr - blocking fg request

If we could dispatch both as bg request and wait for the response it
might work out, but in the current form not ideal.

I can only try to find the time over the weekend to work on the 
compound reuqest, although need to send out the other patch and 
especially to test it (the one about possible list corruption).


Thanks
Bernd






