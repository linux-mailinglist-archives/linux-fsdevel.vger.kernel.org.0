Return-Path: <linux-fsdevel+bounces-62529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31440B97B32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 00:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACEF4C2462
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 22:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC5F30CB20;
	Tue, 23 Sep 2025 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="FBHKuC7Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VlKRxgAJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EDAC2E0;
	Tue, 23 Sep 2025 22:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666078; cv=none; b=JWZuf45QE2QHswzHVkGNWIWuwIfTHf3ZPTDa2abK2vqKL34ivRRE1x8pHVBIVfsG9Q59A9bTM/d/At5J1uLcU5qvqcnzsuzeVIDnbU1hj+UaGx1K17exoV6iJ+LinuahimRYHY8f1oEpv9gGVRvFXxZIfieP3aTysHd5lx7rodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666078; c=relaxed/simple;
	bh=Ik7YM5Q/FmmiZ1L/zyrrXdT0vMvQm7wIQuGJxxDp3VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGW9/85dE5J1OmxzwC1tIcRMQoanwJTZ80DSSdarDT4mUQ1Yz1KU7b0gA2NBh+1KkOcyNsF8ya+Utl4Un3KRi+rHQK1zXgr+LarQdMIFnq05knY+cUhT521Phu2WxJngqphRJvAlXqxW+5HXC2GmbEoFIP6gKfDUZX2q9Dp9cgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=FBHKuC7Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VlKRxgAJ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D55EEC0122;
	Tue, 23 Sep 2025 18:21:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 23 Sep 2025 18:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758666076;
	 x=1758752476; bh=3nkMXYsQNPOfJyMM2epA6ZJ4KP4ztuWbczd1cO9jXWc=; b=
	FBHKuC7YvPP1A0aKHGXlQx6H7dRJfuklX0Va64ptRJZjgjUGHt5au5lhM29t/ZbL
	alNIDOk2Laz6iX4OLQ9KMYp8JRm3sTPJ4YlDlx/Jma6v6f4wjtQABjAKhzUuB2z8
	MOiuUDZcvWAiT/mbQ0lkOSn7rJfFCMyrglbCLTZNlBPArv8MLlWLaiarUG8Ok/GQ
	AUaO2UZkgS4frzjUjf9rUOaM4dGYt2a+F0u6abf4wFOhTPNl/lm1Ri1fPoXfhvG9
	tXQ3kJ6pRHuGqend0/pkENQC8y6/TQMX9brIARSIISU27WsIWgDx3rVOvCjx4EdB
	igBZkvrXJcbuTK94JtT6GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758666076; x=
	1758752476; bh=3nkMXYsQNPOfJyMM2epA6ZJ4KP4ztuWbczd1cO9jXWc=; b=V
	lKRxgAJ7dYtQej9YMB5hqAIZAFn0EjdkDsLEMWQB8mwaMcI2r/g+MiSOR6h4a6L1
	rhexDqV0UvuydO7WlmZkZqJyLUFXmOvm3RZ1KBcKNZjRAvfN+n+HHPaY02VBuAgS
	DJr1+QP0Im4feovRIzdh/XpdszQWrLXAKFkFzBke6EhmNT2JGUEnhLDwGzB1jWjj
	QxT74SdL2fdd18AMNIh+JhNFk/bNTfK4cfbu8FLo7bBm+w+JFkmi7HluFxCeRqNM
	XmYtnzxzhOlafSRw/Eb7l2AemCXCAYEhPgAyMhNURaCtlzbZYbvYMBBJvpdIqtTS
	UBm08E2mTeib/VkeEUSlQ==
X-ME-Sender: <xms:Wx3TaF1zy_diO-dBaFSd_HN9kFj2vtLyg5iX6aNLwaykmXPHnStaRA>
    <xme:Wx3TaCEkBCS3xXKmkmJ5GVwMS92jwMS8N-a1BW1lJYMbSUOY8qkJW7dBiRanqbNtm
    cI1-44R1vxmCrRtJcblkBnRU7eIadJSmwCMcU1s3ZT5MaLVc3y84D0>
X-ME-Received: <xmr:Wx3TaAtxZY411aTC7INIzKfDKyznzkWqms_8mZEJ_T1d826u4YR4Wn5irwaXyu2nmT54RBW_sDAawh3OwE9Nj8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepgfhrihgtucfu
    rghnuggvvghnuceoshgrnhguvggvnhesshgrnhguvggvnhdrnhgvtheqnecuggftrfgrth
    htvghrnhepveeikeeuteefueejtdehfeefvdegffeivdejjeelfffhgeegjeeutdejueel
    hfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grnhguvggvnhesshgrnhguvggvnhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrshhmrgguvghushestghouggvfihrvggtkh
    drohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehsrghnuggvvghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehvlehfsheslh
    hishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghrihgtvhhhsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehluhgthhhosehiohhnkhhovhdrnhgvthdprhgtph
    htthhopehlihhnuhigpghoshhssegtrhhuuggvsgihthgvrdgtohhm
X-ME-Proxy: <xmx:Wx3TaFoUV0d9T1VUoU3TrOW1_gPVHI335AcNk_qHubZHcmYRuuaQnA>
    <xmx:Wx3TaHVIz_TQVJK5OhzdSQc-UrIYSBb4AkO2QdOY36p08zrZEnsOyA>
    <xmx:Wx3TaN19rxvtPeE62WJNqvQ6PiwBbwGuete9CCckqq_O3h938przkQ>
    <xmx:Wx3TaMto1xlI216iWHc2L-tm6mjiM8138FWzkSB0pkl9QjzPxdGUrw>
    <xmx:XB3TaDINo6u7AVJ9MjgO-EOkFvSD77mEhy8FTk_Z1QZOF_MBMmSpKlGD>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 18:21:14 -0400 (EDT)
Message-ID: <fe6ecd47-2c6d-45b4-a210-230a162b39b2@sandeen.net>
Date: Tue, 23 Sep 2025 17:21:14 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] 9p: convert to the new mount API
To: Dominique Martinet <asmadeus@codewreck.org>,
 Christian Brauner <brauner@kernel.org>
Cc: Eric Sandeen <sandeen@redhat.com>, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
 dhowells@redhat.com
References: <20250730192511.2161333-1-sandeen@redhat.com>
 <aIqa3cdv3whfNhfP@codewreck.org>
 <6e965060-7b1b-4bbf-b99b-fc0f79b860f8@sandeen.net>
 <aJ6SPLaYUEtkTFWc@codewreck.org>
 <20250815-gebohrt-stollen-b1747c01ce40@brauner>
 <aJ-eNBtjEuYidHiu@codewreck.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <aJ-eNBtjEuYidHiu@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 3:53 PM, Dominique Martinet wrote:
> Christian Brauner wrote on Fri, Aug 15, 2025 at 03:55:13PM +0200:
>> Fyi, Eric (Sandeen) is talking about me, Christian Brauner, whereas you
>> seem to be thinking of Christian Schoenebeck...
> 
> Ah, yes.. (He's also in cc, although is name doesn't show up in his
> linux_oss@crudebyte mail)
> 
> Well, that makes more sense; I've picked up the patches now so I think
> it's fine as it is but happy to drop the set if you have any reason to
> want them, just let me know.

Hi Dominique - not to be pushy, but any chance for this in the current
merge window, if it's had enough soak time? If not it's not really urgent,
I just don't want it to get lost.

Thanks,
-Eric

