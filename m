Return-Path: <linux-fsdevel+bounces-14374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B4187B50D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 00:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95216287532
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 23:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0F35D464;
	Wed, 13 Mar 2024 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="aE6FCaxf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bg+P+DBt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC82842078;
	Wed, 13 Mar 2024 23:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370982; cv=none; b=fycfXIVU5etgITPeoIt4lHMdlhZs0ZT58ixWkuCBblRiicy8jwPtiDn577weP3R0wrderOa15DW1yA7cpsMZ+ET7Da2AkwQ65NqlB4+DQFUpspMYKErPFMZwM/+0++jRokjcajdtjBjgEuarCGGvGWcyPWz8jzqCXSs8XOzuSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370982; c=relaxed/simple;
	bh=omms3SFurO0RSz7Vcb0yj6X1bkgms38UbPEuLlEOTOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xo4QwjPftNBrvPJ7c9clqfmK55WGxE32NCkunxctoPtUzbTFxlbowT0DCDQocLWkbnAA3Wt7OISy17PeCYnSfchLTGXpVBltSJhYpMgsBjU2E9SglKyKd1DI151fXRYzI88Z2V2IEBUgp+xipe+ozuzHv+vDiivNcDr7i6XDxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=aE6FCaxf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bg+P+DBt; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 388141800090;
	Wed, 13 Mar 2024 19:02:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 13 Mar 2024 19:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1710370977;
	 x=1710457377; bh=Bz4OSDL737dXWZswYNHf7v3iQ4bma+bPDF/AfKYK8vI=; b=
	aE6FCaxfm+Xa6KPA6rEvpcPdrVzbm9+PjDYhWEMyXBXgIaY6mzWcHT7oCTjGSI90
	Ur2imzdQKYPokhOpXSGpWwrPb6QY2QkjYCLDvAM7jGt/Af6U54PStQmIWcJbbZ1b
	KZ7Mmvd4dTskp1x/KLZ/NgJaNNL6sPKCQ3DsQsEpOWtQ5T8THYjyr+h0uFt3m70w
	Kn/epS80cNzapzq2aEUOFnmIdr5eMvnakl4DXwmRof9LfQjIxY3pNrMA4OIP8vKE
	b/RtD5fSKWywzkt0YOX35IEU8WwWnow4C8OZqWEtHN8NT+2k8SSWHnVrid8FnBVe
	g+3ifq733zXkNrB8M461gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710370977; x=
	1710457377; bh=Bz4OSDL737dXWZswYNHf7v3iQ4bma+bPDF/AfKYK8vI=; b=B
	g+P+DBtnuUCigeIBzC+2RyT/kLAJjW7Se2HVhtZi6vYnUDRryAwDXi8kM55AvdCF
	rapFWUbusKa5CJiaK/TqyZpeJ7G/dEjGOw3wnFZFe9bGw8cRo/Xv5Zve5v+IFffW
	+KDGasTsw5eMRjHqLCSoNSigKsbCNL0Qe8P5mxE/Nb4vhh+7Vw2CFHRucVJ4CXEg
	qLpcDKRHPy4WP73/BKepww4NZixnzySRSy86MOHKUuOs93MPbp9l9461wkL8BzQ+
	f0VH3Mw+h07ySWWKslZLBWgoG4Qdz6O8Kx1mj0t/JH2ZcUok8t75NPCvNVNbCqoA
	VsmtEBoUT0Yqwd/CJoiRA==
X-ME-Sender: <xms:oDDyZb3HmaZhlDp9JbkyPB1Vc3pz7Xc2JSo6XPMlheWr03PhzXWh8A>
    <xme:oDDyZaH1H2l-QpiWy3fn_wgb20GUNtg15ifBAYlkYBpvJdBjJt4YsozbK6EU53M4Y
    _zxuIpR0HWwQICV>
X-ME-Received: <xmr:oDDyZb6TFn9S-466_istBZsBYd-ARoI3MvFKEYgCB8-jMCmggL6dV9PfuGPN7HSxbiC8fX8Q3c8UXq7RhbX-4LiZIodmSaqAUsVBYVcDx4FuhlMVMjyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeigddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveej
    ieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:oDDyZQ0IZaGmu3XuaXb2Pv8eehKoMX-WokCMiIBSnxkq__Is3RjM4Q>
    <xmx:oDDyZeHff2tp5zoJgG_lo5mwLgu4YpKLc8k9fQrU_89kdVc6saxB7g>
    <xmx:oDDyZR8V6arTFUqAd8Kd-bQN5YT8duiJBWikcySQ_3dMQC6fovNq1Q>
    <xmx:oDDyZblpafvyWASHpjcYKL5r8PsY_wbA7v4a3szraAHtBl05N_gsaQ>
    <xmx:oTDyZVdKF5fa1Ul0H4gpQtt3m-A5TXuFtw-w2n48DYRMLvTjoWUOanfLJHQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Mar 2024 19:02:55 -0400 (EDT)
Message-ID: <d9d2ede5-7454-4c43-ab5d-29816e266453@fastmail.fm>
Date: Thu, 14 Mar 2024 00:02:52 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] fuse: limit the length of ITER_KVEC dio by
 max_pages
Content-Language: en-US, de-DE, fr
To: Hou Tao <houtao@huaweicloud.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Benjamin Coddington <bcodding@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, houtao1@huawei.com
References: <20240228144126.2864064-1-houtao@huaweicloud.com>
 <20240228144126.2864064-2-houtao@huaweicloud.com>
 <CAJfpegtMhkKG-Hk5vQ5gi6bSqwb=eMG9_TzcW7b08AtXBmnQXQ@mail.gmail.com>
 <8f21c92f-5456-7a2e-59af-1a02d8a10c24@huaweicloud.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <8f21c92f-5456-7a2e-59af-1a02d8a10c24@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/9/24 05:26, Hou Tao wrote:
> Hi,
> 
> On 3/1/2024 9:42 PM, Miklos Szeredi wrote:
>> On Wed, 28 Feb 2024 at 15:40, Hou Tao <houtao@huaweicloud.com> wrote:
>>
>>> So instead of limiting both the values of max_read and max_write in
>>> kernel, capping the maximal length of kvec iter IO by using max_pages in
>>> fuse_direct_io() just like it does for ubuf/iovec iter IO. Now the max
>>> value for max_pages is 256, so on host with 4KB page size, the maximal
>>> size passed to kmalloc() in copy_args_to_argbuf() is about 1MB+40B. The
>>> allocation of 2MB of physically contiguous memory will still incur
>>> significant stress on the memory subsystem, but the warning is fixed.
>>> Additionally, the requirement for huge physically contiguous memory will
>>> be removed in the following patch.
>> So the issue will be fixed properly by following patches?
>>
>> In that case this patch could be omitted, right?
> 
> Sorry for the late reply. Being busy with off-site workshop these days.
> 
> No, this patch is still necessary and it is used to limit the number of
> scatterlist used for fuse request and reply in virtio-fs. If the length
> of out_args[0].size is not limited, the number of scatterlist used to
> map the fuse request may be greater than the queue size of virtio-queue
> and the fuse request may hang forever.

I'm currently also totally busy and didn't carefully check, but isn't
there something missing that limits fc->max_write/fc->max_read?


Thanks,
Bernd

