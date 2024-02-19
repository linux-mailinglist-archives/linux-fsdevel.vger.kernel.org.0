Return-Path: <linux-fsdevel+bounces-12055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4003885AC89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 20:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22BE2826DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 19:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5791524A5;
	Mon, 19 Feb 2024 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="kQhzDOOU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LGZsYdSa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6F950A97
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372539; cv=none; b=pAhAq+dVamwXDGP+KNaLFBgoGuxtVDkLQduWfCQyhqG1d8yTBrNPc2yaO7jw3Tclg6QxY4gbpCK/5KVTZpNw/qWv7736u3OGaZvX+/pPT9MBgnCWrqFLb0Q5lU794E8yezm5RafoFp0yBu4Z6ix0gKEP4/+B4kPiw+kHeh9GN2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372539; c=relaxed/simple;
	bh=hv23sH8I7WrSzpzT73mZRsnAUGtxpeTJs0/RryABox4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvrO91cH8aBRvUbGAl5vh3ywLuqI3snSCMRwGjtsM1dC7Y4DbTR3TPvWfkV2/qa1c4zA87WeijPvNvNOM5EhHFrxcIDEe+NsJ9v/CoGODwn62kNMoNUBjFkY+egvGDcrtXc5iqHGB1pMbMQ+0plom4mfAI+fW97I4fETIrVSemE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=kQhzDOOU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LGZsYdSa; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 4ECCA3200A2A;
	Mon, 19 Feb 2024 14:55:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 19 Feb 2024 14:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1708372535;
	 x=1708458935; bh=nf/Xn5XMXRHtKQ5fya1LoKeLPbtugUFK8J3++VbOkbE=; b=
	kQhzDOOUxaEtSoFcU5O5YgK1K8qC4L6UPnYxfl6gqDZAl2BeAKKkpMBJSxUsmZIR
	q7I5XCFQty6eYiNW73aIME1a7utMeaScdCirIPRRzFkrKcsvJfLGrVFLpVkDSJO7
	9CWrY8cG5un28+3eS5IN8cASK9waG0nd6kK/jwyeAFaUf7ljcmwoEjRcGXcNKSlT
	RoS4ovgX026V6Si7KHd4rlCo5+YSi8IRejBW1iOuENHxUadp2A/yjPZZkD3nSFfS
	BIQ2kWd8bNFiXdY99Ga9fPIurGOd+8uJvZpRq7Alf/4Q5xww9RDacEeprdxie/1u
	qRyKk/H6AyOi0Sf9cFOfzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708372535; x=
	1708458935; bh=nf/Xn5XMXRHtKQ5fya1LoKeLPbtugUFK8J3++VbOkbE=; b=L
	GZsYdSa7+XoXYRnjB9peb5HKtvUqUVQfHKW10Fm7mdGZ+prEshxp/i7uMlKtOUSx
	xAqQAoyPSmF/GCxCzJMqJf8x6/8cc9OFzGmjm3sFt4TNVm8vPwXQoDv4GXvAkxFn
	zlyOfplvbfBCvjSBqrTueaGp2eaekEBMx6pQ2ihOgYcxQdz5xaXswXoViSiwB2b2
	N8jTEqDuQm42mcCuuCXWbWiGucG2gEFbNyUaDDzTlNsBjHeaNNesZkU6njNSqvh4
	7ILXuFq8/WgMhMsA6DW+HtijLkHS1HrQrKRLGo950zC1iQ2+xxX8/bkV9qXffFOZ
	upLP47owxj8ybtsz6Ta3w==
X-ME-Sender: <xms:N7LTZTvNPcQ1WY0tA0nM1_udKglEnLh06Rt2GX2RSRDbZ_JCdGdrYg>
    <xme:N7LTZUeADbkNu5wsONdA7VML55hT9zTVwLuMzw2k6PD8iO6tF7SlyW114x03l5d2-
    CCL3KFjPAagGNbH>
X-ME-Received: <xmr:N7LTZWzA07alWgXC6VuTRUzdQkEPq-8I3_9qExOQpOZcYk9g-RIwC80LN6hRaZDc2T09jPLgycTkjtS0umePxDNQSlnq7tRk9q4IZBNd8wRA1VaQYos3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:N7LTZSNifWeZrUYAZ3McUEXODbt0TtC1QXFUStoMLJbp9pzIHPIEUQ>
    <xmx:N7LTZT__FcWWY1uuTP7KiFtOmJRVTsOfMltUWOTVh9d9G8K9oJ2QUg>
    <xmx:N7LTZSXkqh6HkM2dHs0Yhb9jJUMcz4TRw48iSeq7VkM6hlNCTN8PcA>
    <xmx:N7LTZfYDgprpe0lZmxZ6g3Rv_bPZUtl7CzWRtlBn3sImG5FlNruVYQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 14:55:34 -0500 (EST)
Message-ID: <8fd58ae6-164c-4653-a979-b12ee577fe65@fastmail.fm>
Date: Mon, 19 Feb 2024 20:55:33 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
Content-Language: en-US, de-DE, fr
To: Miklos Szeredi <miklos@szeredi.hu>,
 Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Amir Goldstein <amir73il@gmail.com>,
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
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/24 20:38, Miklos Szeredi wrote:
> On Mon, 19 Feb 2024 at 20:05, Antonio SJ Musumeci <trapexit@spawn.link> wrote:
> 
>> This is what I see from the kernel:
>>
>> lookup(nodeid=3, name=.);
>> lookup(nodeid=3, name=..);
>> lookup(nodeid=1, name=dir2);
>> lookup(nodeid=1, name=..);
>> forget(nodeid=3);
>> forget(nodeid=1);
> 
> This is really weird.  It's a kernel bug, no arguments, because kernel
> should never send a forget against the root inode.   But that
> lookup(nodeid=1, name=..); already looks bogus.

Why exactly bogus?

reconnect_path()
		if (IS_ROOT(dentry))
			parent = reconnect_one(mnt, dentry, nbuf);

reconnect_one()
		if (mnt->mnt_sb->s_export_op->get_parent)
			parent = mnt->mnt_sb->s_export_op->get_parent(dentry);


fuse_get_parent()
	if (!fc->export_support)
		return ERR_PTR(-ESTALE);

	err = fuse_lookup_name(child_inode->i_sb, get_node_id(child_inode),
			       &dotdot_name, &outarg, &inode);



Thanks,
Bernd

