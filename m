Return-Path: <linux-fsdevel+bounces-9877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC5D845A66
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 15:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F2229140E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2103B5D497;
	Thu,  1 Feb 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="j/EoiIyM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XQwF1KgB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2435A5D49C;
	Thu,  1 Feb 2024 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798175; cv=none; b=C2ttOKp99abu6f+DS1R2JcPoxvvVRxYmACLmIoO0T9qu8DNMu3fNeYaiMMqBXxpydL7ZQrEEE/rQSsi2GaAeMPxHdswxjSprKWpPzhL3EzGYfJalKTUNAbAb2OqV5kp4bv1hVoYND2hEiQ9365SOp4XMYCVYx+1FOwgIvWoK62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798175; c=relaxed/simple;
	bh=FeRaLjIRZZOoVQRE3VbB+k+NxwiDyFTyOTKoaXeaHyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpT9fviKuVZeL5ZpFGQcqlWSXQUtSoM7XfyAx7snaMNy8f0TaQmzMKgj2Nxz+VldM4LpTwPCKjrO5t1wWGgOcqvkLJ6a9BmFiSiG3Hz53zHmcWnhS66LkRYX19s+GQn7FHwAHs3/Kq7eS3yvNgG+APm2oqw5Nr7c7pBIRz/M648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=j/EoiIyM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XQwF1KgB; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 4242C3200B17;
	Thu,  1 Feb 2024 09:36:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Feb 2024 09:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1706798170;
	 x=1706884570; bh=fbNJ0Fw0DlPFvpJQ5pJ2PmJ8FIFdaBpICHpQUyevCoo=; b=
	j/EoiIyMwaGcKAc2+GketOt8fAugSdAyb4Cpo5NCYPphNATFRs9Lb0RtxTsB4hCE
	eXivRr8C/FsVXpwBz+ojRhl0uimR3UI2FGySqRfkx7YXwac28i52zHRjdYe76jvn
	Zvf2eaiXOODLcdoo4zBGhzBD4oPknJ9oyaiK497j4U2hMCITnlXswndmzoLLEPHN
	hIEN0ZTjmBOLYmBBt8xrLKqmiuPedIuNfn7/fidHoST+hoBFYOcvmhSOkR7RGxVz
	xql1BSSdujD1Mb9VkusOL7bMu/Z2qi3z7EeP5yN4HmfFcRSgGc0zwBdpyMCHfe59
	5loisoj/c8P4Yo8u7SIh5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706798170; x=
	1706884570; bh=fbNJ0Fw0DlPFvpJQ5pJ2PmJ8FIFdaBpICHpQUyevCoo=; b=X
	QwF1KgB3kTNVV20lcIyyl4dDzOtoSbiJlFYur4ZjqgID05OTS7vBcMPg+YYmLepX
	MzBuJ0ilUlSChTqKX53OKG/Q6cSBI7ecat2Am9IRV8o2DB7kQxd0FvuJZyzVws/a
	z96+TQrv3h6DZ4JBZSwhRufC+Q9KDoXrULEWH7UYmGJFZuNOheLQEJKgbkhbTuHB
	2ktB/bjdf4sBFu643Wi0+KVpasJ+S0lIPKJOh4MUemsqwP3wBdepel6j9pB3+GWO
	0xPHgExSktHnOcXeKKOrdXUv9Ejidz2vNGxXMHvWQIfcjyZjw92lgFuure96j/RG
	6k5IkNC4AZTIGWu1OB1GQ==
X-ME-Sender: <xms:Wqy7ZYCiTKaoEIVvmDwueDg8tr1qfLpw7ZcALHerVSeS0KbbUbZ8VQ>
    <xme:Wqy7ZahMlr7GL-yd_d5pehkBl_fUfIMp2jARnxkk6D0Ku93EiqnpD9JIXUx3H3Xc5
    ZeFuiruRhG6bgcG>
X-ME-Received: <xmr:Wqy7ZbnrHYHdBczs_E8PwIt2pesP8AaYcaW3k3OMwrGm8mweyam3I2ejen5mY4HkHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:Wqy7Zez_9NxK_KoMWuE0MTpCZuGXs8Kx97KrtsgHltc5m_x9xChCbA>
    <xmx:Wqy7ZdTDEgQxx4yjgirKQlN501MW2ZFhLot3vcyVs4KTfeU8Ly1UhA>
    <xmx:Wqy7ZZZ1RHjyqNYvsZ4rKyLipRhzK9IZLnK1bMLSxhPX2dFnIXSibQ>
    <xmx:Wqy7ZWItDPBxucB9A-PFy52Y7Ly0L9xLuZeuua_mOUDv06TlpxUPWw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 09:36:09 -0500 (EST)
Message-ID: <0d74c391-895c-4481-8f95-8411c706be83@fastmail.fm>
Date: Thu, 1 Feb 2024 15:36:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, dsingh@ddn.com,
 Hao Xu <howeyxu@tencent.com>, stable@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>
References: <20240131230827.207552-1-bschubert@ddn.com>
 <20240131230827.207552-2-bschubert@ddn.com>
 <CAJfpegsU25pNx9KA0+9HiVLzd2NeSLvzfbXjcFNxT9gpfogjjg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegsU25pNx9KA0+9HiVLzd2NeSLvzfbXjcFNxT9gpfogjjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/1/24 09:45, Miklos Szeredi wrote:
> On Thu, 1 Feb 2024 at 00:09, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> There were multiple issues with direct_io_allow_mmap:
>> - fuse_link_write_file() was missing, resulting in warnings in
>>    fuse_write_file_get() and EIO from msync()
>> - "vma->vm_ops = &fuse_file_vm_ops" was not set, but especially
>>    fuse_page_mkwrite is needed.
>>
>> The semantics of invalidate_inode_pages2() is so far not clearly defined
>> in fuse_file_mmap. It dates back to
>> commit 3121bfe76311 ("fuse: fix "direct_io" private mmap")
>> Though, as direct_io_allow_mmap is a new feature, that was for MAP_PRIVATE
>> only. As invalidate_inode_pages2() is calling into fuse_launder_folio()
>> and writes out dirty pages, it should be safe to call
>> invalidate_inode_pages2 for MAP_PRIVATE and MAP_SHARED as well.
> 
> Did you test with fsx (various versions can be found in LTP/xfstests)?
>   It's very good at finding  mapped vs. non-mapped bugs.

I tested with xfstest, but not with fsx yet. I can look into that. Do 
you have by any chance an exact command I should run?


Thanks,
Bernd

