Return-Path: <linux-fsdevel+bounces-13079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA64486B017
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD0A28A633
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE06B14A4F9;
	Wed, 28 Feb 2024 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="cqoLYCL8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UHGf6AF1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0763BBEE
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126193; cv=none; b=QA3iYPeUMC6crR+E9L8/F+4o3uOxGI5IIyLasoSETOck0DrI0w0j0P0Vz3hq1OwxqI+/kL7N4ZGrI5ebe5DSt1Huh8AnYSGdWuvyKKRMb2N527nvta8j2wCcI6RPJZ/e2G5l0u7JDWuBuifEzdt6fefYtF2oCdzG3MLu1cBlj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126193; c=relaxed/simple;
	bh=JmOLzFG9r85mP/aD4o7HhWI1yQhCP+Ef/p+Qc1lF8pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKkwnVHN7L4xnQFEbV/88cbezfcei3e5YyqkMsTFPec3WAzp/wPa0uLnq9MWhOp0NaDO0EiejKJjVlzIcbKus2y3/qdFox/JGLO8LSgHOUrfiqjmBnorn8Ec4y3o78mImrYNhSg/lO8BlQIrfDS1XS3xo+PxZ4OwsfqD/9B+BIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=cqoLYCL8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UHGf6AF1; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 2300332003F4;
	Wed, 28 Feb 2024 08:16:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 28 Feb 2024 08:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709126189;
	 x=1709212589; bh=qxbnInwpCSauvomUbBIXNcNrEzVvpFSXQaZhd0X83Uo=; b=
	cqoLYCL8frAb1kOjK7mfkfTHKP4o3nqTICiIVmIJD01ACMotc0MVt2VqKm9FB6kk
	U4xlHRsofLxYczNjxfr2aL6SD1IcYgT3fMuSRyP5aCvi15Oc/f7mgO2tfcuCvIsV
	iuOyUTGWSxb/QqfOwLF3rcMbkfZoDyHL4lSnIXUDU+nMbH5qKJyflVrBh+4BJ6gd
	setUpWQla3JiqWYcsH+CqLEl9+YhmMoSV80pwjSUj0qAuEy8TIyKkbvh4hTZrgGK
	3tZ7D0Ev/9xBr0WuunUSwvLOsTeppPDqzOajLKaEf87zbcS2Yrzz9L5Z5aqENz+b
	4L55wQ8QwiP3UnC7Jiv/vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709126189; x=
	1709212589; bh=qxbnInwpCSauvomUbBIXNcNrEzVvpFSXQaZhd0X83Uo=; b=U
	HGf6AF1vNhpTrcODy/YNE6IsVczZJXsMzNKYKUI5vk23gVg2lb9OH+1amDoEM/q1
	YGkxcRSBHesmvXNTLnZCe9533t7+qyTH16ydyIfTMKZ1KKkGfStv8jDYSR0J78zx
	pp6av7VdrYtZOm7446NmmOJR1qL3cKjn/TR4mx5an1hMe3O0DIp2HQM1SDowTXOl
	apNfnR6+egvvJ5sI05NJc0A/3q0Tr5cULZ88zGiYEFqUDVNL8mTKjI+cwmrbCzyT
	cR3UxTk3MtSahhJGF2ZFrPwug3jC8reglryVHDQtPVvCrFPMTkL/STLQPLujK+3K
	Ph/qjYD04Xkk+dLJ1ZYmg==
X-ME-Sender: <xms:LTLfZRrbBZloomcJYExBhXqEeMtalkhGcs9fRA9ab8Daf9GTK5cl6Q>
    <xme:LTLfZTrCRTrRxnzAv408srphIoPls_asbBpeO7lBxNrlcvMIp_lLzwo8Jz6shZ0DX
    mHlsHowb-OYcNyA>
X-ME-Received: <xmr:LTLfZeMmDM0QDNbi9M_h2FBHp0Q7qOirf85_6-QHEf3bNZ0BhXMOA6nrYn0_5jR_ptAIGONHy_FxRzdGfPjNx4TA_bpz_gigng26wEgonK2wjq7-71KV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeejgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveej
    ieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:LTLfZc7sQzHMzXArwBv69PCJO491Uu0XZmo7j5K9kAT6_BqmBz5mYg>
    <xmx:LTLfZQ6s2C4OARalE10pTj9biD0CQcA21EbKaLzh2E6lqWHRIRoA9g>
    <xmx:LTLfZUhypN6vT-ksPEllAOaTJPeCCqY8puJ5YUafzWVuh4iz6bzy3w>
    <xmx:LTLfZb1QliCouorEOXpueiOIHI9PIZLfx8hhSTk2gHv1OLK6YGU1-g>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Feb 2024 08:16:28 -0500 (EST)
Message-ID: <f246e9ce-32bd-40df-a407-7a01c7d8939b@fastmail.fm>
Date: Wed, 28 Feb 2024 14:16:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
To: Miklos Szeredi <miklos@szeredi.hu>,
 Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 fuse-devel <fuse-devel@lists.sourceforge.net>
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link>
 <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm>
 <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link>
 <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com>
 <5b7139d5-52fd-4fd0-8fa0-df0a38d96a33@spawn.link>
 <CAJfpeguvX1W2M9kY-4Tx9oJhSYE2+nHQuGXDNPw+1_9jtMO7zA@mail.gmail.com>
 <CAJfpegssrySj4Yssu4roFHZn1jSPZ-FLfb=HX4VDsTP2jY5BLA@mail.gmail.com>
 <6fb38202-4017-4acd-8fb8-673eee7182b9@spawn.link>
 <CAJfpegscxYn9drVRkbVhRztL-+V0+oge8ZqPhgt4BAnvzaPzwQ@mail.gmail.com>
 <f70732f8-4d67-474a-a4b8-320f78c3394d@spawn.link>
 <9b9aab6f-ee29-441b-960d-a95d99ba90d8@spawn.link>
 <CAJfpegsz_R9ELzXnWaFrdNqy5oU8phwAtg0shJhKuJCBhvku9Q@mail.gmail.com>
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegsz_R9ELzXnWaFrdNqy5oU8phwAtg0shJhKuJCBhvku9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/24 14:06, Miklos Szeredi wrote:
> On Sun, 25 Feb 2024 at 21:58, Antonio SJ Musumeci <trapexit@spawn.link> wrote:
> 
>> I've resolved the issue and I believe I know why I couldn't reproduce
>> with current libfuse examples. The fact root node has a generation of 0
>> is implicit in the examples and as a result when the request came in the
>> lookup on ".." of a child node to root it would return 0. However, in my
>> server I start the generation value of everything at different non-zero
>> value per instance of the server as at one point I read that ensuring
>> different nodeid + gen pairs for different filesystems was better/needed
>> for NFS support. I'm guessing the increase in reports I've had was
>> happenstance of people upgrading to kernels past 5.14.
>>
>> In retrospect it makes sense that the nodeid and gen are assumed to be 1
>> and 0 respectively, and don't change, but due to the symptoms I had it
>> wasn't clicking till I saw the stale check.
>>
>> Not sure if there is any changes to the kernel code that would make
>> sense. A log entry indicating root was tagged as bad and why would have
>> helped but not sure it needs more than a note in some docs. Which I'll
>> likely add to libfuse.
>>
>> Thanks for everyone's help. Sorry for the goose chase.
> 
> Looking deeper this turned out to be a regression, introduced in v5.14
> by commit 15db16837a35 ("fuse: fix illegal access to inode with reused
> nodeid").  Prior to this commit the generation number would be ignored
> and things would work fine.
> 
> The attached patch reverts this behavior for the root inode (which
> wasn't intended, since the generation number is not supplied by the
> server), but with an added warn_on_once() so this doesn't remain
> hidden in the future.

Could you still apply your previous patch? I think that definitely makes
sense as well.

I think what we also need is notification message from kernel to server
that it does something wrong - instead of going to kernel logs, such
messages should go to server side logs.


Thanks,
Bernd

