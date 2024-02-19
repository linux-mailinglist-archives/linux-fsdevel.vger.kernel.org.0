Return-Path: <linux-fsdevel+bounces-12058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 970F485AD93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 22:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FDC281E60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 21:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E3353E0A;
	Mon, 19 Feb 2024 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="XSGtQ4Ct";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LnwCiWFQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC20537E4
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708377260; cv=none; b=ovFr5oyXbWNJCjsjEuVs39HNBrqZpoRmG8Z2/E2nwa0aTCfM+HOfEU/wgVkVpKkopjFDcP2/0Vaa1+dX9FVnguqmJD559zl0ml7/dZiLNAEru9bK38tHKfu4kUYvG6hJhASMMYcHlFpeIDr4pul6FQAIo4aPZf5AImvY34GC3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708377260; c=relaxed/simple;
	bh=gzzDeID4hACLWKx2SWdJxOibIjI7ftuBOhZsB5tGav8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JU4SCUUDBicamt4VU8m6cN8AbaMgeuWOdHBLsDN3VVPF2bJJ1vZy9w+1kVNXwQ8gEYqzSNkITPb26g+0vrVEwpVsnBjpn0reQ2erf7o8a/g4W3sFBXDo65SlZXWUxHAYt6Rp2bwFY4HGxjQokkStJsVTYcnWYQ10tTD6MdjowMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=XSGtQ4Ct; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LnwCiWFQ; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1EB4B18000A1;
	Mon, 19 Feb 2024 16:14:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 19 Feb 2024 16:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1708377256;
	 x=1708463656; bh=QWDp+iLTqCYTOBLQPCdtdWiOZavU74+Nll//1LL21d4=; b=
	XSGtQ4CtKzviDtcRxiE06f5n5UdoJ8r4irtXvaX3SrXQaIhMhM9/E4VpKRYWOnjK
	6KNn29cFJvoFVDxE3g3KcAENXU4dFJqg+CfLCOGZh+T/MZ4dluIOyzDzVeWg8zN4
	7wmWKDW/IPET/PUiDdhxxxfPyjYm2tVlbFz68PbcItDW9pA2GDHYC+ZQUsaf/dpR
	Oy6NPQLe0TatrNdXHIn6nS7ohYCt8NBKqVz+ftoy8SMgws0mFVQm3ECW9CJ5wenH
	dwkBQabFAzgH2Fd/OoPtguK5cwHelTclmg+yo3EdAZIsh85afdN45ilzoVnJP75j
	b9ASL2qaJo6JAYNWVzCQPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708377256; x=
	1708463656; bh=QWDp+iLTqCYTOBLQPCdtdWiOZavU74+Nll//1LL21d4=; b=L
	nwCiWFQysPmpk2kY1weRcUVwSNkSe7Ax62+EO2803130NIdhYwUtxX6ag0/AldGc
	FvHJc9Yu6q9NVA+KGnCJ2pdiUsyckAe/A9Hze+lpnCepBkTaQzuYyj8gWHMhL5fY
	+GBhCozDNCjaLj5IKH8VlU1r2oVskX0MeUprVU2SL83oZEA2+55rzNDnPfcWed5n
	vXaaSEh/YNrakBxzV8yheHvJlRbAboQxti1Un/5SzpsHnIl+UxXqqdkwS4FVTPWH
	neyY1/72BxNT+GBA/gkP2kwjIXog4S/KYgZkf+SqbmRlKWIaQye2utqIpsZVnlrk
	1jAvRIaJH+h1TFCgjXiHQ==
X-ME-Sender: <xms:qMTTZZ_L6qnNh1_hRsKHMXSIolZ4l_LBrD0HkIGAep_1XGjxt6n4Mg>
    <xme:qMTTZduocywGOEzp06vmYDIX4e3dsmAT4L04iYB9ob3zvv8ploVb3kFFW8-o-k26X
    N1X1hA8HG0vHkod>
X-ME-Received: <xmr:qMTTZXD_N2Ji6MVFOcJt5txeKkpOJIbkQmbK_3RWR2sFYRGPchQqwHVNuveEv0ezXyoaH_IzBrUw8ju1-g-f-nx7vxtheHayjZOEFuq9okFOM6qWSDcT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:qMTTZdfOeQGjnZufaxwpV1yVE1xZD5iBcwY5H9bRTQPF14k_YS0vTg>
    <xmx:qMTTZeP_KW3jx1mqm7NPdyXocE0JMg24S9Tz45eogAPHaYWc-ZxIFg>
    <xmx:qMTTZfmB8nbYd5822phBKvr3KOmRTKvcgjPSWmPQuBmVt59Oz81htA>
    <xmx:qMTTZV24_oAtbVVkEDWCkdrnHpP5A8TgSeKilFKDwLeNvX9nS3qxrBsrB2U>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 16:14:15 -0500 (EST)
Message-ID: <0aec3014-ba3a-48d3-840a-4f61ff4d6f60@fastmail.fm>
Date: Mon, 19 Feb 2024 22:14:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
Content-Language: en-US, de-DE, fr
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>,
 Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 fuse-devel <fuse-devel@lists.sourceforge.net>
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link>
 <CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com>
 <b9cec6b7-0973-4d61-9bef-120e3c4654d7@spawn.link>
 <CAOQ4uxgZR4OtCkdrpcDGCK-MqZEHcrx+RY4G94saqaXVkL4cKA@mail.gmail.com>
 <23a6120a-e417-4ba8-9988-19304d4bd229@spawn.link>
 <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm>
 <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link>
 <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com>
 <8fd58ae6-164c-4653-a979-b12ee577fe65@fastmail.fm>
 <CAJfpegvgwZsoFpEUnqPkAXCST3bZYgWNy4NXKHOfnWQic_yvHw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegvgwZsoFpEUnqPkAXCST3bZYgWNy4NXKHOfnWQic_yvHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/24 20:58, Miklos Szeredi wrote:
> On Mon, 19 Feb 2024 at 20:55, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 2/19/24 20:38, Miklos Szeredi wrote:
>>> On Mon, 19 Feb 2024 at 20:05, Antonio SJ Musumeci <trapexit@spawn.link> wrote:
>>>
>>>> This is what I see from the kernel:
>>>>
>>>> lookup(nodeid=3, name=.);
>>>> lookup(nodeid=3, name=..);
>>>> lookup(nodeid=1, name=dir2);
>>>> lookup(nodeid=1, name=..);
>>>> forget(nodeid=3);
>>>> forget(nodeid=1);
>>>
>>> This is really weird.  It's a kernel bug, no arguments, because kernel
>>> should never send a forget against the root inode.   But that
>>> lookup(nodeid=1, name=..); already looks bogus.
>>
>> Why exactly bogus?
>>
>> reconnect_path()
>>                 if (IS_ROOT(dentry))
>>                         parent = reconnect_one(mnt, dentry, nbuf);
> 
> It's only getting this far if (dentry->d_flags & DCACHE_DISCONNECTED),
> but that doesn't make sense on the root dentry.  It does happen,
> though, I'm just not seeing yet how.

I see the BUG_ON(), but on the other the "if IS_ROOT(dentry)" condition
triggers.

