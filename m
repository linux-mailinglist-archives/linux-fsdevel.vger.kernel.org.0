Return-Path: <linux-fsdevel+bounces-55460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCB6B0AA2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 20:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82795AA628A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD49A2E7BC4;
	Fri, 18 Jul 2025 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Nm2PrNz6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DzAUxK7O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5072A148850
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863735; cv=none; b=hd9TWsJiMX1NUu+5skFTTfd7lLZkovVOp3Hh76p0rW4VOCUQFHge05NjmzfsQZaxWcxaqNtXhfwSxsL+qq5CeCgDjeZMD9jJXOFBdi8/WHoBxE2+ezVFQz6WADW9mxT4UvX5f2SZ86qIxs7TwHYT3uET+W44YhIfuHYpofwiYzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863735; c=relaxed/simple;
	bh=WhzxVm/zCQihKWVoAfZtosX/xiojM15xoqGz+ObO7S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXrWUvyywHZYi8im3kD32ldwCjdpZ37xjYRhgzq73gm0a+yPEAhoJ0GxfupyP5rDAAikUQyAAhzcS6GYreOQ+l93aaOTRE6Moj3r/xoGHXE1RoFtstIeI4rjSvaINwY/Y54dBCPxuG9umPI81xLJd6fOqCtB47xxWy3w2zYGxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Nm2PrNz6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DzAUxK7O; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 562E3EC00C2;
	Fri, 18 Jul 2025 14:35:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 18 Jul 2025 14:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752863732;
	 x=1752950132; bh=J1qfaXvCoTZxmYgvUJKz/SLGPBXBs34U8oFIaU3ml5M=; b=
	Nm2PrNz6xAjXWRikjzCmJS+PmGPNaH5kmv996z6+le6ahOeWoatGiw6t+79FKkVa
	i2rD3YDGx/KlIuC6CKIPzIzS1JLid2fJCFybE2rD6jAXeV8OAYsW4tc7u+yEJgBV
	dAHd/Lie+G/HHs7l2FNslPY/tBBsHbM1uK7LhL4sH2j2Eg6xPUx4Y0biMegdXflI
	JVp+/ceieUkr/EciKuCipnp1MqMPxu0/EpPNDz4rMeuFmq7r7IcDQ1XVP+XlEJ/9
	q00oamgClNLR5SRPbVuZraWAQ7fbZNaf9eh32oZ9HTQkqRAbtICB2CNVPoKFu5vx
	h8fo2BLR5JV7Yh8E2FCX+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752863732; x=
	1752950132; bh=J1qfaXvCoTZxmYgvUJKz/SLGPBXBs34U8oFIaU3ml5M=; b=D
	zAUxK7OqKAJdN7gUSu00JxGNqFYgpN2ZQe5QbLZUs02Qd9PqvEDrnDs7ZFz9sims
	wbPYy5pWaNh55TuRjRtYtUKV/rNhMtIb3MDp+KpAafHcCoyulXFRKeuANkJyvr1R
	GsTTe6+OvstlZB6Xl+TSHmFlXc412exxWD0seaISMYQc37pFzMykSnoovEmgxkx3
	xcQNyzGiKpPUXiZaENVKlVIyHUe05yTSud2QQVOvvDSdgITLAYagJ0ymAclH/Q2O
	7p+l1CXMDOSbQTYfATY34UNvjcKqvBwozIxSY99Z/yWN0qJyLVEQSH3hlajwcoEf
	FaDe8JozWNEmutbaLb1rA==
X-ME-Sender: <xms:85N6aHQGiRJmQH7_BnNKR0Bs3V_kQly21egSPFA0yEL5jJ1W9f5Yyw>
    <xme:85N6aGXTV3Z0zaObRbwORj8rCuNkaGCjNO3hAAN6A4p25-DfTA8EPygzJhVaP3LLe
    heoMk6ufN16koNL>
X-ME-Received: <xmr:85N6aDQuHVFoRHDso9W_R61nbwLMRRpA28qKhZIhaOXwTAup1v_2MsZsutXH7WHKRAAmhbTVobr0LmkbhuWVhNxVyMVWzPgiNJRFXS1_nWG2jZg6xjqd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtohepjhhohhhnsehg
    rhhovhgvshdrnhgvthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilh
    drtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtoh
    epmhhikhhlohhssehsiigvrhgvughirdhhuh
X-ME-Proxy: <xmx:9JN6aIk4lLirDP267jwgdPE2yA21cFVLXqVGvC0_UV8KWpVKdaFpOg>
    <xmx:9JN6aB6IgAC-TlQ8GKpd7YSosaIvSV1F86RaQKmCFVnrFtF42rAMVQ>
    <xmx:9JN6aGhEh6RpHt4xpAoQ1A4d6qKjxRUT5ym2TMHKKRjDYVIYdHTwBQ>
    <xmx:9JN6aGGLVmMaNioL8uMX4RhjY4ziM5SehsAmf7CGFfJOBO2zCqWXAA>
    <xmx:9JN6aKVALgJ_G_qdEIteYAf7EBjgKm6NPyiaxLWNRDnDo-nRgUWifS1X>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 14:35:30 -0400 (EDT)
Message-ID: <a0971aee-6f10-4279-b90a-beeb5c3f3637@bsbernd.com>
Date: Fri, 18 Jul 2025 20:35:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libfuse: enable iomap cache management
To: "Darrick J. Wong" <djwong@kernel.org>, Bernd Schubert <bschubert@ddn.com>
Cc: "John@groves.net" <John@groves.net>,
 "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "neal@gompa.dev" <neal@gompa.dev>, "miklos@szeredi.hu" <miklos@szeredi.hu>
References: <175279460162.714730.17358082513177016895.stgit@frogsfrogsfrogs>
 <175279460180.714730.8674508220056498050.stgit@frogsfrogsfrogs>
 <573af180-296d-4d75-a43d-eb0825ed9af8@ddn.com>
 <20250718182213.GX2672029@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250718182213.GX2672029@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/18/25 20:22, Darrick J. Wong wrote:
> On Fri, Jul 18, 2025 at 04:16:28PM +0000, Bernd Schubert wrote:
>> On 7/18/25 01:38, Darrick J. Wong wrote:
>>> From: Darrick J. Wong <djwong@kernel.org>
>>>
>>> Add the library methods so that fuse servers can manage an in-kernel
>>> iomap cache.  This enables better performance on small IOs and is
>>> required if the filesystem needs synchronization between pagecache
>>> writes and writeback.
>>
>> Sorry, if this ready to be merged? I don't see in linux master? Or part
>> of your other patches (will take some to go through these).
> 
> No, everything you see in here is all RFC status and not for merging.
> We're past -rc6, it's far too late to be trying to get anything new
> merged in the kernel.
> 
> Though I say that as a former iomap maintainer who wouldn't take big
> core code changes after -rc4 or XFS changes after -rc6.  I think I was
> much more conservative about that than most maintainers. :)
> 
> (The cover letter yells very loudly about do not merge any of this,
> btw.)


This is  [PATCH 1/1] and when I wrote the mail it was not sorted in
threaded form - I didn't see a cover letter for this specific patch.
Might also be because some mails go to my ddn address and some to 
my own one. I use the DDN address for patches to give DDN credits 
for the work, but fastmail provides so much better filtering - I
prefer my private address for CCs.

So asked because I was confused about this [1/1] - it made it look
like it is ready.

Thanks,
Bernd

