Return-Path: <linux-fsdevel+bounces-9891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F387845C6E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAD41C2C837
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B96779EE;
	Thu,  1 Feb 2024 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="nwOmhomw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AXMht+1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A735F49A
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803268; cv=none; b=GeS21YVUFd/z4HCcOwMX84bLaZ09XbKBDYFSwDeCaJNJuXxToD2m+jC5v8kgS/C1eVNYrZBSArlHfADYAbMC2t0TcBOobnRsJU/7nY77SOStSsqpgmkSDGIh2gWQOrNIVbYnfR5o1sQwvGB2BFCMFXcQFJBLJwsbdd+wqlNSkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803268; c=relaxed/simple;
	bh=3PMxcE5abbu8YApU6OX4GuN2mjDaq8eMslw1mHysXOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSQb8n8Wmq1uEXdbug8tepg8UKA1EzKluUQNtxMj8mrbVRFLL7OgxTBCdbBIho2OWq/F/Os6LKcybMrGslR+bIAQjbUgwmhHJ28ze/W+I1oYNxgY1sRukzXA7CcuG0DRDJr9WchjIcVtuSgjk3QLBrA1sUtlfzq8kwtIXGjmVqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=nwOmhomw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AXMht+1p; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 7D4E13200AE2;
	Thu,  1 Feb 2024 11:01:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 01 Feb 2024 11:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1706803264;
	 x=1706889664; bh=qeZnpmAfNS+41uLSKe+vM3eJw9+uJ0S2W8Ss75wgyBY=; b=
	nwOmhomwMxV3cAuc5da85KNvIddrERa4oKFbUC+YumbAVh7T+xCspto/AK70nlIR
	sXrX0J8eULu/sODO+lAc+JJOozRQILBvgON11caTdCKm+0+6JpRmbi5zB4/Tu/E1
	zIEFhxZQU2JMLV4lRlxS6GcFz1g3OiZvoTISY8/wJyuopSukrQdMQ36H3/g5bjYI
	unmFtxpZLAdoTIAH+/7+JZIw/OWTEjTLlWtpTH3ew8EUZaT6GXl02tb66KGyNnaf
	tkWLP3/oqYrC+iWoFZLMlvjyWmYf8Jy0UJ+z4KsxiJZGu7eZGy+iA1UYlICYUBF5
	4ZLB7x615+ihqUDPDUbZmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706803264; x=
	1706889664; bh=qeZnpmAfNS+41uLSKe+vM3eJw9+uJ0S2W8Ss75wgyBY=; b=A
	XMht+1psSR4ojTI5e6xO9uMVPBhLvFZpil4FhGr8oFnoxVx2jBDfv5PZm4sxWPtx
	UdjDwbI/bfbicFdDuEsCvubGUW0c1XLkN57ayM1NvT270Lp+RW65c3cv9Fs2tz/k
	hk1rW02JzibhlwCUkYmBqcqc8YZunyw9sZgp8c7sSlvr4HgGNx00+/VTOhP1uiwg
	2kUyTpl/ZdU+KcdaTgTJSQVlZ+/IuidAdGUQeCPhb3q657s6SB3WKIm4KMGZ4xuR
	mdEV7Ar77kiVFxqc0rrSCjuqOzpCMCErRhnNgYgR0BdKtzJlVPNwVW7J37osw4sN
	yBMEl3ZHSQG4KabVcRAug==
X-ME-Sender: <xms:QMC7ZXSEj_sUST6JKqxhdOTbhkRp6r1c2CWAmY0D91KZBn8ShhFx0Q>
    <xme:QMC7ZYy5AQjeDy9C489qJkA5a9auRDh8_4-tH80e6ktc_huenWr85EWLZ4BYBIEns
    ol-D5boBKwdcqbK>
X-ME-Received: <xmr:QMC7Zc0g4GFO5V-UFq07oPaMIlpFi7L5Y_xK61Nj53PWGccWc0yM55WBSNhgwZRO_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ekredttddvjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeeutd
    ekieelgeehudekgffhtdduvddugfehleejjeegleeuffeukeehfeehffevleenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:QMC7ZXCRxVGlIgPfUk1c00qETFuDYhv5h_1PRotJ8HMYwoYLCki72g>
    <xmx:QMC7ZQhRTcHF0jxRXCkq8T2-55vB1hsSDDHkyuwVtJ2rg00tSli_XQ>
    <xmx:QMC7ZbpM_-gOtoNJoeIOvEAlQZi0bNV7uASsvQLXY_vha3V0UgjoMQ>
    <xmx:QMC7ZZvPGhxlmOSOQjVOuGHeqKEDE5kwfl1d0L3tQSVg9CRPDxdzZg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 11:01:03 -0500 (EST)
Message-ID: <de4aee5a-c410-4149-b333-76a01e0f8dfe@fastmail.fm>
Date: Thu, 1 Feb 2024 17:01:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] fuse: inode IO modes and mmap
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, dsingh@ddn.com
References: <20240131230827.207552-1-bschubert@ddn.com>
 <CAOQ4uxi_SqKq_sdaL1nFgjqonh2_b910XOgMbzeY4aP1tj-qGw@mail.gmail.com>
 <7d194156-4763-42ea-b89c-e01be7d3e22d@fastmail.fm>
 <CAOQ4uxh5+v3NQK4=TJ7XfVtNCmNYMmAEKyASON6eJFP5OipJWw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxh5+v3NQK4=TJ7XfVtNCmNYMmAEKyASON6eJFP5OipJWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/1/24 16:56, Amir Goldstein wrote:
> On Thu, Feb 1, 2024 at 4:30 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> Hi Amir,
>>
>> sorry for a bit late reply (*).
>>
>> On 2/1/24 11:30, Amir Goldstein wrote:
>>> On Thu, Feb 1, 2024 at 1:08 AM Bernd Schubert <bschubert@ddn.com> wrote:
>>>>
>>>> This series is mostly about mmap, direct-IO and inode IO modes.
>>>> (new in this series is FOPEN_CACHE_IO).
>>>> It brings back the shared lock for FOPEN_DIRECT_IO when
>>>> FUSE_DIRECT_IO_ALLOW_MMAP is set and is also preparation
>>>> work for Amirs work on fuse-passthrough and also for
>>>
>>> For the interested:
>>> https://github.com/amir73il/linux/commits/fuse-backing-fd-010224/
>>>
>>> Bernd,
>>>
>>> Can you push this series to your v2 branch so that I can rebase
>>> my branch on top of it?
>>
>> Do you mind if I push this to a different branch to keep the branch clean?
>>
> 
> I don't mind, I just thought that it would be nice if the branch fuse_io_mode-v2
> actually contained the patches that were posted as V2 to the mailing list...

Ah sorry, I misread. I thought you wanted me to pull 
fuse-backing-fd-010224 onto the  fuse_io_mode-v2 branch. I just pushed 
posted v2 to my branch.

Thanks,
Bernd

