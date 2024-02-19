Return-Path: <linux-fsdevel+bounces-12048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41E485ABDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 20:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF441F22661
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 19:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E646B51C47;
	Mon, 19 Feb 2024 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="KnoRjAd3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cGX4nm86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D358450276
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708370236; cv=none; b=QiLThoUREZPFqlA8WIJwBgMDgSbOcR5CuhI1oypdnI8weMSsyg5P1O1tKK/ILh6Z72lsZEFDVU/kuHmJE86ZOP0FXQype5RcUysA/XeAPojYlU1YGWnml0U7j02QGvsZNyoZmB+mbWKZ0CW9Ti3E3Tli3V3NAL7lNR/kxS1WoWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708370236; c=relaxed/simple;
	bh=f2PxmoYXlPYN3TKfKZJZn/lfRsCYgIodggbLER10LM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opmSKcwpa8QTl6YTSS/tKmeTTGBEgojX6smxM8A7bzGk1MpNYlHfpGaLLmpZp+x8ffbNLAvEuIWMIOlDOEcgWZhGlEHqH+kujF5qqfBm1CIPA893appFPf1AXnw491Tt091OEbm0BW7paHgbLL1xnrAP1Vdt2e+n81cIHKTBUpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=KnoRjAd3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cGX4nm86; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id B65E318000A0;
	Mon, 19 Feb 2024 14:17:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 19 Feb 2024 14:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1708370233;
	 x=1708456633; bh=zm81YW+5lRk/RxNNks/Xr4Fn9o4eGXBF0Wv8R4QjHCw=; b=
	KnoRjAd3KumAueZ61Wbq16EWLQe0WvbY0FCwBPMKhADpl71GSE4ExEFhopFzEcym
	L7ZKSYvszLgm8nL6RhPuo6oqpP9kKe5kgdcgx2uMQk5ZK5Xc5Gn3mF1+LZYJ2YGY
	dHc7goKk4swFkM5mj5mITW28uJhl5msGJf6thRHz2CsjTGiMaYBtE9a1OI1IE+Cm
	Fdy04K8BlRme8CHrNJxwBVZtSPcfatIGjfWzrfJvEAn3hQmHIFsWSQAEKuvTfcwL
	+JUPuj8wPvnWX4ezuXiC2bA9LjMYEFmKXFjcKkm4CMzg3cPjRfObjn8qNjkcfm/u
	YN1A556fHJXv0TggZLR5pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708370233; x=
	1708456633; bh=zm81YW+5lRk/RxNNks/Xr4Fn9o4eGXBF0Wv8R4QjHCw=; b=c
	GX4nm86RFKU8UxMSZ8aLlzryvrnvs+klv0T3lI39ef99gDzedY8veQFFdZ/xuBY6
	OCnXsLTm0hEV9ilxl03yg07u4qz6Qw9+c/aIW6EQigc9mpnNLz5L5+XYGKT1tDUN
	GGYCYzO7+V9a2kQm6tBF0kVrL6EIXtfpaNCaAb2Q83tITD4veqjE79vUIyjR0aOT
	4Xk24dH04dCzqKWbocXVdlWUxR4kn7LR1QsAN/vlahgdC5Mq1dpp8mHW3VuXoQSq
	wpZoWvsrNsClyraN7J41n4n4Ci2K5qqhzVsc4RZWYZrOf9rt5g+i2mH3CC7S+eYu
	uOio18kObjJcAjGeUPVpg==
X-ME-Sender: <xms:OanTZa2BP0mHdz18eMm7VuuD9Qn9n9fhtjVp4kVgT91xbvX37qlaAQ>
    <xme:OanTZdHA_RdR6TFodTKemrN_sIOiTmi0ZPAr2Bteln-NFHGlhhY6sWTeghMK7vcoH
    xxqbdvoCHJGJktR>
X-ME-Received: <xmr:OanTZS43UygxtU91KAZlJvMQ0RKkLedDfTvh-Zm_se4t76-8ofA9urDVLpQVQKKqPIz2RqRLO6Su5OEAkn9UiQin2HR_M37VOFNWSs4SuUEChNmP_reu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ekredttddvjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpedule
    efvdduveduveelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstg
    hhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:OanTZb0-Tfabb6pZjKFJdhWNpejSBCaxqZiMAaehRj7FPdbWlvdSow>
    <xmx:OanTZdFIwT1MAqtNxviXQ4ew2KERrGyood0wZzsIm67891B-aLWBXA>
    <xmx:OanTZU9jStJwqa_J84TQHHmQ-75qN5kgVsUEKj5foA0VgLZg29BtWw>
    <xmx:OanTZRhf1U4v8-0tDaCooP_Ml1OFiVzVUSwrDpbh6G8o_ayiC1ye3zqtxjY>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 14:17:12 -0500 (EST)
Message-ID: <7443694c-4a14-4f48-9628-23f7b415fe55@fastmail.fm>
Date: Mon, 19 Feb 2024 20:17:10 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
To: Antonio SJ Musumeci <trapexit@spawn.link>
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
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/19/24 20:05, Antonio SJ Musumeci wrote:
> On Monday, February 19th, 2024 at 5:36 AM, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> 
>>
>>
>>
>>
>> On 2/18/24 01:48, Antonio SJ Musumeci wrote:
>>
>>> On 2/7/24 01:04, Amir Goldstein wrote:
>>>
>>>> On Wed, Feb 7, 2024 at 5:05 AM Antonio SJ Musumeci trapexit@spawn.link wrote:
>>>>
>>>>> On 2/6/24 00:53, Amir Goldstein wrote:
>>>>> only for a specific inode object to which you have an open fd for.
>>>>> Certainly not at the sb/mount level.
>>>>
>>>> Thanks,
>>>> Amir.
>>>
>>> Thanks again Amir.
>>>
>>> I've narrowed down the situation but I'm still struggling to pinpoint
>>> the specifics. And I'm unfortunately currently unable to replicate using
>>> any of the passthrough examples. Perhaps some feature I'm enabling (or
>>> not). My next steps are looking at exactly what differences there are in
>>> the INIT reply.
>>>
>>> I'm seeing a FUSE_LOOKUP request coming in for ".." of nodeid 1.
>>>
>>> I have my FUSE fs setup about as simply as I can. Single threaded. attr
>>> and entry/neg-entry caching off. direct-io on. EXPORT_SUPPORT is
>>> enabled. The mountpoint is exported via NFS. On the same host I mount
>>> NFS. I mount it on another host as well.
>>>
>>> On the local machine I loop reading a large file using dd
>>> (if=/mnt/nfs/file, of=/dev/null). After it finished I echo 3 >
>>> drop_caches. That alone will go forever. If on the second machine I
>>> start issuing `ls -lh /mnt/nfs` repeatedly after a moment it will
>>> trigger the issue.
>>>
>>> `ls` will successfully statx /mnt/nfs and the following openat and
>>> getdents also return successfully. As it iterates over the output of
>>> getdents statx's for directories fail with EIO and files succeed as
>>> normal. In my FUSE server for each EIO failure I'm seeing a lookup for
>>> ".." on nodeid 1. Afterwards all lookups fail on /mnt/nfs. The only
>>> request that seems to work is statfs.
>>>
>>> This was happening some time ago without me being able to reproduce it
>>> so I put a check to see if that was happening and return -ENOENT.
>>> However, looking over libfuse HLAPI it looks like fuse_lib_lookup
>>> doesn't handle this situation. Perhaps a segv waiting to happen?
>>>
>>> If I remove EXPORT_SUPPORT I'm no longer triggering the issue (which I
>>> guess makes sense.)
>>>
>>> Any ideas on how/why ".." for root node is coming in? Is that valid? It
>>> only happens when using NFS? I know there is talk of adding the ability
>>> of refusing export but what is the consequence of disabling
>>> EXPORT_SUPPORT? Is there a performance or capability difference? If it
>>> is a valid request what should I be returning?
>>
>>
>> If you don't set EXPORT_SUPPORT, it just returns -ESTALE in the kernel
>> side functions - which is then probably handled by the NFS client. I
>> don't think it can handle that in all situations, though. With
>> EXPORT_SUPPORT an uncached inode is attempted to be opened with the name
>> "." and the node-id set in the lookup call. Similar for parent, but
>> ".." is used.
>>
>> A simple case were this would already fail without NFS, but with the
>> same API
>>
>> name_to_handle_at()
>> umount fuse
>> mount fuse
>> open_by_handle_at
>>
>>
>> I will see if I can come up with a simple patch that just passes these
>> through to fuse-server
>>
>>
>> static const struct export_operations fuse_export_operations = {
>> .fh_to_dentry = fuse_fh_to_dentry,
>> .fh_to_parent = fuse_fh_to_parent,
>> .encode_fh = fuse_encode_fh,
>> .get_parent = fuse_get_parent,
>> };
>>
>>
>>
>>
>> Cheers,
>> Bernd
> 
> Thank you but I'm not sure I'm able to piece together the answers to my questions from that.
> 
> Perhaps my ignorance of the kernel side is showing but how can the root node have a parent? If it can have a parent then does that mean that the HLAPI has a possible bug in lookup?
> 
> I handle "." and ".." just fine for non-root nodes. But this is `lookup(nodeid=1,name="..");`.
> 
> Given the relative directory structure:
> 
> * /dir1/
> * /dir2/
> * /dir3/
> * /file1
> * /file2
> 
> This is what I see from the kernel:
> 
> lookup(nodeid=3, name=.);
> lookup(nodeid=3, name=..);
> lookup(nodeid=1, name=dir2);
> lookup(nodeid=1, name=..);
> forget(nodeid=3);
> forget(nodeid=1);
> 
> lookup(nodeid=4, name=.);
> lookup(nodeid=4, name=..);
> lookup(nodeid=1, name=dir3);
> lookup(nodeid=1, name=..);
> forget(nodeid=4);
> 
> lookup(nodeid=5, name=.);
> lookup(nodeid=5, name=..);
> lookup(nodeid=1, name=dir1);
> lookup(nodeid=1, name=..);
> forget(nodeid=5);
> forget(nodeid=1);
> 
> 
> It isn't clear to me what the proper response is for lookup(nodeid=1, name=..). Make something up? From userspace if you stat "/.." you get details for "/". If I respond to that lookup request with the details of root node it errors out.

I might be wrong, but from my understanding of the code, "." here means
"I don't have the name, please look up the entry by ID. Entry can be any
valid directory entry. And  ".." means "I don't have the name, please
look up parent by ID". Parent has to be a directory. So for ".." and
ID=FUSE_ROOT_ID it should return your file system root dir.




