Return-Path: <linux-fsdevel+bounces-26521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8FC95A4AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 20:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692341F231AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A3D1B3B0D;
	Wed, 21 Aug 2024 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="PXK06LpD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ncF2h2Qi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6691B3B09
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264800; cv=none; b=Xupjzns9wnorWA+1R/v3+alGR0v3qDQCMfyVbpjZNZy8XOvJi4RuGsBEmsdlZ+Xkztl4Txh9+SY8rGP6eW0q3hoVZH37GmAhBNNgaBAXYS0tHkyS8RvG5+8cxk94Los+yITZzynEBxGb9f/xf0ziQ4QdIFVfNA/zHDGQ5NivtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264800; c=relaxed/simple;
	bh=13bVUbYpRu1vo+VZZwqBOA4hiT7vqkyQwN8y+S/K3fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3hEHnRvzOlqgoShsZfV7BlChtw13JEh/MzypKh7FUpxsufMt16dBekhBueXyQMURPCx2OnMBiaEj2rEl7TmNFQFpSKq3T4hWRzBZLe9YcfKgx6+BIztucmmssxMXJ0MYsU7lb2eL+3fRe74f+PeqLqah+qB7OIegWuPNEDN+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=PXK06LpD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ncF2h2Qi; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D90B3114AB91;
	Wed, 21 Aug 2024 14:26:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 21 Aug 2024 14:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724264797;
	 x=1724351197; bh=3182Pa1lzkVBby0P9seki1K7KcTQO5UheoQwIReFpp4=; b=
	PXK06LpDlV5v7fc2sRqYz6w25fczd78j6sxxiAajBQ0dTbQCR4sgmhcMVG3GShDj
	cwF57Wa5zEpeFci3py6LzFW2mKcVxBvj/A3FisbbgFaQDaDjk4Y0UYnNFBDM/GgN
	2l5aI5De4OMgp1F0rEkIQzARYzyp9vCF7idpy36VWvt1wPjuWBvnERa2DnckEHIZ
	BPlT8nIGaaWQ9Ed+HDoz9SNFvY1uskh28qyEg1G7/DGD9wlxB8NrBdjgxE3MDM9u
	2P3M/tLUB+KzRV0IbZc+IfvtWhQCRk9o1iLYQuc3ybHuBSyKHKatqRdt47o91y2F
	B6PF8MBWDVFd8VdYs4mOaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724264797; x=
	1724351197; bh=3182Pa1lzkVBby0P9seki1K7KcTQO5UheoQwIReFpp4=; b=n
	cF2h2QiVTNHQymaKlx1W5NJ9LZ1qFTiWazmsPyKsmXkXJPea8ZfYq7zZQED9neyR
	MCKAqVKTwd0SwCG5LA2OX9TjVqyrfw22t5WmBTnScdz+RSSCSAoDBNhSIdR5bGWe
	itGjgTUDINtAcU7g+XpqvAHzhI7LYHO+ZpvHzTokTjEORT9eTT8RcHIU6+C8CFJU
	Y6OrLT3IsxFo6dDPy06qdAdGRi07lYXRwImHCkuuW78etlbXp1P4J0DxWcRzYGFR
	7fwBQzJIhOJxGU3EgI2WaGhrUhn2RP99svRb7+oNIoSHBIF6wm8xmJeYiScgaITY
	XhkuNu5rgUYx5faE9M50Q==
X-ME-Sender: <xms:XTHGZsdkpoz38gtNMc9Jp-g9uRO0XRAyhHZ9-72P3rMheFTT2AeAzQ>
    <xme:XTHGZuPOzSITw3MjwP3SnXpjdNTkeXkLu1xBrXdxpEXz89Jn8PhIDdMBRoRC9_mbf
    RCUxJbcop4OQMwb>
X-ME-Received: <xmr:XTHGZthgJUSq87ePeHoyUty0LE9h7W8B_33yxtkIXn11Xa88B7GeFepawIScmh2Y6UIAboJtMbAurDIQRpQF3-xXpvL_fZHD_E2QMLJAiAgW8WSHJUxYnds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthho
    pehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    shgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdhtvg
    grmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:XTHGZh-473SYtWExAGtrnbnC9a3m-Ep6KNLREa7dVgmGS5xqJLZXsw>
    <xmx:XTHGZosDVQROTxI-UlEUWtN0nTQEwigyOl_2vgYP7TcALsE4u67k0A>
    <xmx:XTHGZoEAbIicgyXPNo9AR185v0k2PjdxYkAK11dFIw2tphI_okbH2A>
    <xmx:XTHGZnOu-eXaRBnxlwq_PQaVppvnVVkwwrg1tQ4zOr3nqSf3dvhbNA>
    <xmx:XTHGZiXf2i-4VzN7SkrSwhc5K-k0kfXsRmNiC9bOc2Krzdex59L15aUg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 14:26:36 -0400 (EDT)
Message-ID: <6d1c802e-1635-414a-b0d7-ad5306bfaf8f@fastmail.fm>
Date: Wed, 21 Aug 2024 20:26:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fuse: update stats for pages in dropped aux writeback
 list
To: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@meta.com
References: <20240819182417.504672-1-joannelkoong@gmail.com>
 <20240819182417.504672-2-joannelkoong@gmail.com>
 <CAJfpegswvvE5oid-hPXsSXQpFezq3NLVdJWTr_eb4shFLJ2j4A@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegswvvE5oid-hPXsSXQpFezq3NLVdJWTr_eb4shFLJ2j4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/24 17:56, Miklos Szeredi wrote:
> On Mon, 19 Aug 2024 at 20:25, Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> In the case where the aux writeback list is dropped (eg the pages
>> have been truncated or the connection is broken), the stats for
>> its pages and backing device info need to be updated as well.
> 
> Patch looks good.  Thanks.
> 
> Do you have a reproducer or was this found by code review only?

That's indeed a nice catch from Joanne!.

I would have expected that writing to a file and in parallel truncating
it would leak WritebackTmp in /proc/meminfo. But I see it going up and
always to 0 again.


Thanks,
Bernd

