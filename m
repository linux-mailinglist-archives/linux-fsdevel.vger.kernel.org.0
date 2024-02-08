Return-Path: <linux-fsdevel+bounces-10770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD7884DF52
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 12:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55211F2B883
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 11:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED956A347;
	Thu,  8 Feb 2024 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Jss6Pw0X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ORmDgDWn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C96F52B
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390290; cv=none; b=IWhiyv0In7EG8XnzzVxrQ3wtypQhUemIS4ujh2PpdkEdF1yblH/6suvCgfxM/dNLBRbOg4No9Xmxf64xrR5xx2Y5xXRZNVqoCPHAX+1DvWG2qmgysBvPZAfBBRbbK5LveKhq4bUfAhbeRK5rTH+BCHtd7N8tOiMxinOqbi6fPnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390290; c=relaxed/simple;
	bh=CNE36xv3eFFqMG4ATqWhZcVtXS7UhO4JQrSb/bVCiik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2f4sNqd6xIe+BxnWD7hOptNbdO/oiRewnpsaSONmnMPy1qGuXsKTMtdE+SpMcoxO5oNqKddiG1sw4S3PrVmEL4/mN99qkx0BqRBgFOG/Y6aydU5I3vJLpGguE4GgpJgbRoP3T3YzGI6BglCVmaMBOlz21IgM3u1IKUIzDwzZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Jss6Pw0X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ORmDgDWn; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 969F25C0102;
	Thu,  8 Feb 2024 06:04:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 08 Feb 2024 06:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707390286;
	 x=1707476686; bh=KeKcuJo4KCxfPyorHTChaYUdSVjokAh2lCJ5Urc4gIE=; b=
	Jss6Pw0XiVIVdvA5atmz9rwgCpsN8sfMt/wfZsLuTXrj/UP/zcMAvbL7Ql55fg6u
	7o4StRlhbsQtolz49EaZq6w0FnDK9Kl9eCmmGRVPMAi/82BfR8jOgKGRV0mN0X1I
	HlR99K+znR8Apr7N/HUSjnPrQsCJobaFxSdzJC0HZfuYMAZtlU1A8O+zYRfa8XzT
	40zb8kPI3qBseX/zw05wFlkFqB3TwmGOKAxAAm8Oc/jKFKWeGdzmW5sE7qYJhtIv
	uTV99pHsBu2MT72acn+rZeap/rctFEvjzhrD+M1/b85iAaSDp7xOFkGMnUad3nVS
	T90tLxrw8cELTNCNZd4aOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707390286; x=
	1707476686; bh=KeKcuJo4KCxfPyorHTChaYUdSVjokAh2lCJ5Urc4gIE=; b=O
	RmDgDWn2CeoSqfz/7K/YjHTRBjo3kWAHJty+kGSJ11Q9JNthdj1fp5491ArQCt8A
	oluutX/G02tAiQPOj0L4fdqRXDnqTCKm2rlQEGtpc7XVKE70ynbOFfzwQYKQXQYL
	tQmaAz1dj2IBEtvekzyLe9k4dO2jSqt2w6/lwL8ObP8Z45doSMrNR3u0REWIG5/1
	4SrIUVl92xpmvwh/PVIrKGzaNf1kX8ty3CH91KACjC8PpBYeMDt0yeqFFrk3nDbA
	vlmVaeKNjmxL3Ey+WZelu5EWmq/Xyg+Cnx6nYqveMsxDKhn/qd7dX6EMEKAhhPMf
	nTHrPsq7T5YUw3xRY/dfw==
X-ME-Sender: <xms:TLXEZa7RsPTpAnhSj8eJnqJQ3PsbD8VHABjtohTmt7SKmP_84ctCxg>
    <xme:TLXEZT63CYQnn-sWc4cBpxOBQEwZRN-LSm1ZpOduf_-09Ikb3l1u77zWeHsDqL7w0
    tj766SdKGLXWUo_>
X-ME-Received: <xmr:TLXEZZcRTZsCgUGhWbW-DSMDH0oydapWaMGkU0KCCyUqaCf2UHOguGazYHMFFM15ikk3iOwJwertm2HNlFqB0zPrs8j-dKKLODHPUR9zitQB15OfiT-F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeggddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduveduveelgeelffffkedukeegveel
    gfekleeuvdehkeehheehkefhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:TbXEZXKTtct5waCETNJeNUDsQnMcQeIP1JY6Mkyc9z47NqskSXRjhg>
    <xmx:TbXEZeL3I-TKuKejGDw9M80HZbKrVOEe3sAucJN_BHzJ25yjyCeTEg>
    <xmx:TbXEZYwzRHVV2LQSwocgq-FrllD89yQ9zpYNO2o5IWXx5KL7epr-4A>
    <xmx:TrXEZTF9FRGYel4xsSvEdv7I7mbTagganGz6A892S56mDsgBgCYrzQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 06:04:44 -0500 (EST)
Message-ID: <39131575-f213-42bb-a8f8-cd2490429d7a@fastmail.fm>
Date: Thu, 8 Feb 2024 12:04:42 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [fuse-devel] Future of libfuse maintenance
To: "Pittman, Ashley M" <ashley.m.pittman@intel.com>,
 Nikolaus Rath <Nikolaus@rath.org>, Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Martin Kaspar via fuse-devel <fuse-devel@lists.sourceforge.net>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Miklos Szeredi <miklos@szeredi.hu>
References: <b1603752-5f5b-458f-a77b-2cc678c75dfb@app.fastmail.com>
 <9ed27532-41fd-4818-8420-7b7118ce5c62@fastmail.fm>
 <87mssf9dfc.fsf@vostro.rath.org>
 <CH3PR11MB844272EBE33A7CEF1F545611D3442@CH3PR11MB8442.namprd11.prod.outlook.com>
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CH3PR11MB844272EBE33A7CEF1F545611D3442@CH3PR11MB8442.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ashley,

On 2/8/24 10:14, Pittman, Ashley M wrote:
>  
> 
> We also use fuse extensively and I was considering putting my name
> forward here but I also need to ensure I’m following the correct
> processes with my employer and I’m not going to be able to do that
> before the end of the week.

I would be more than happy to form a team with Antonio and you.

> 
>  
> 
> Bernd and I have worked together in the past and I’d be more than happy
> if he was to take over as maintainer.

Thank you!

> 
>  
> 
> I’d also like to reiterate to point about the dependency between libfuse
> and the kernel driver, having the userspace and kernelspace fuse code
> better integrated from a mailing list/release/maintainer side would be
> of benefit overall I think.

For sure! I don't know if you noticed, I'm also working on the kernel
fuse side.

Probably would be also good, if we could create a new mailing list. The
sourceforge list is badly spammed, so it lands in special folder that I
don't check regularly. Using linux-fsdevel for all fuse discussions
(kernel and userspace might be abusive).

Cheers,
Bernd

