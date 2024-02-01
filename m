Return-Path: <linux-fsdevel+bounces-9875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75427845A52
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 15:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E08C8B22CC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 14:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448BD5D48D;
	Thu,  1 Feb 2024 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Js5orRPn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f+zxzwlA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C3A5F46A
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797830; cv=none; b=UPmhylqvBpF/GhTbIyx5hQUh+AEiRqo7zkQOsJUbmDZkpjUTvQw1xmbqRItU3z56EXiy4PXi0Rto8r+QaAHWWMOe4M8GJk/fn1lmNJxxUPxn3D5AfqbG5nP4xUI6vzI7geYQpLkq+JBWcWw7QrH3H7OjEFRmQeM9Re4i3wssA+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797830; c=relaxed/simple;
	bh=YpjmqQX77kSnZ5OCHXts0cVJxFcsN8tHA187ysO3fqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXcuim3OATKxk+2/DxZ8+hP/apQF6DFVzHzwqaC5aeOrigEKu2NyMQ5cDXORqgkJN4CmiBziPAewzhYz0TNErHwv1cCreK+j8VV7+EEYIxebS6AL1otEyqUmD76Smrj2rHX92OsmzPoSo8+tl1Wphh6PUlvoftNRykzL6YUJGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Js5orRPn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f+zxzwlA; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id B44F63200A85;
	Thu,  1 Feb 2024 09:30:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 01 Feb 2024 09:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1706797825;
	 x=1706884225; bh=+REvpcS2Y/+jQ71vX4cy/xMrIr1/Uqqz/drVgjg9chY=; b=
	Js5orRPnJwySfk3zvCGz6ppaY+7mYh30/oOX8byLDzR8lWn6T0u303gLSrvJ3HdN
	20pIvPX8JKNe0oDC+N+27fVQubqUY6zAXJW6y8NKrremtix8A6YIhG6qzG5g9hRl
	H8qkh3TyVk4qdi7XjiI66U6FesWWfLBkSW04w1Ux6Q/LKfnq5oHhz9Ka1RP9sAeY
	DadcFmFrgJvg7MfRmX0ccUODoc7jjLBPAhZQDpZWqKeebPn7ytDLKiNetuH3+m7K
	mHuFstY7aMozQDi+PzgC36tuQOBusSMASXwIQlJBwD6QIJdM5NDY58AMvDfnEUIT
	Lw2x92K/MPPRi21VpoaZfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706797825; x=
	1706884225; bh=+REvpcS2Y/+jQ71vX4cy/xMrIr1/Uqqz/drVgjg9chY=; b=f
	+zxzwlAXG8QQ91BRhcx1BYOyHkA32sTOzmGyWbMzkn1NtKs6/y4edp6rQ3sqeXBo
	G/OVGOYuscrfq7MNDMSg2SLdL7F09quaEif49HZM8f6wthaXLaFI0+jKEpAnANrF
	VQZVKxil7eYsLM1tRa5dwbg9isVXijDhLdrMeBK+A8wyZFvMDF3chLXnm/IHoMLI
	t0MbRg7lO3F6NOI/xBKXNbtFuzYVr2fYk/nnFin/caL0TqpP2amfl6+TOrF6mVmd
	jupiQF1htRWBU73rNRDGslTB/zcsP5/huYgOqiItai5gG59f40LY1IF04VXbwl1Z
	dygw3nyTd7MwHW4ma/KYw==
X-ME-Sender: <xms:AKu7ZWaz1fMykmwbYXVw7AJtOFRge3j-mtBBVyi7Bo3_AMIjezpLWg>
    <xme:AKu7ZZYiKe933OtNmD97gxNS9g2qG2htFy-gKESR_prpREtMiCH_geTGQnxHdqChT
    PsdY5_l1_Slev2b>
X-ME-Received: <xmr:AKu7ZQ_WPreeaEPs3FAFUtY93PJ1um7UFCaQTY2G_1L34SUnLE9BYA9qT1Kh8matpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ekredttddvjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpedvhf
    duveeivddvieetfffghfeiffekteefheffleekhfegteejhfekffdtuddtfeenucffohhm
    rghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:AKu7ZYoKyhabeHJgFl_KYaafHFny4zG33ppC6na2B3pQGWL0YhjAOg>
    <xmx:AKu7ZRo9-titOYNAZ20IRiRiEfr8M3rjl3G2xM3jBbzXLbZw2eD0Og>
    <xmx:AKu7ZWT8T5ZiLd8wxJCp7Rl49mswyzMN2NFhYDFOT1cI0fXh9n4iPw>
    <xmx:Aau7ZYUKLooegKoivfH-NFHJV7CZK7RCMBY5g1cMk3MDXadtx7bb2A>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 09:30:23 -0500 (EST)
Message-ID: <7d194156-4763-42ea-b89c-e01be7d3e22d@fastmail.fm>
Date: Thu, 1 Feb 2024 15:30:22 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] fuse: inode IO modes and mmap
To: Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, dsingh@ddn.com
References: <20240131230827.207552-1-bschubert@ddn.com>
 <CAOQ4uxi_SqKq_sdaL1nFgjqonh2_b910XOgMbzeY4aP1tj-qGw@mail.gmail.com>
Content-Language: en-US
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxi_SqKq_sdaL1nFgjqonh2_b910XOgMbzeY4aP1tj-qGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Amir,

sorry for a bit late reply (*).

On 2/1/24 11:30, Amir Goldstein wrote:
> On Thu, Feb 1, 2024 at 1:08 AM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> This series is mostly about mmap, direct-IO and inode IO modes.
>> (new in this series is FOPEN_CACHE_IO).
>> It brings back the shared lock for FOPEN_DIRECT_IO when
>> FUSE_DIRECT_IO_ALLOW_MMAP is set and is also preparation
>> work for Amirs work on fuse-passthrough and also for
> 
> For the interested:
> https://github.com/amir73il/linux/commits/fuse-backing-fd-010224/
> 
> Bernd,
> 
> Can you push this series to your v2 branch so that I can rebase
> my branch on top of it?

Do you mind if I push this to a different branch to keep the branch clean?

> 
>> shared lock O_DIRECT and direct-IO code consolidation I have
>> patches for.
>>
>> Patch 1/5 was already posted before
>> https://patchwork.kernel.org/project/linux-fsdevel/patch/20231213150703.6262-1-bschubert@ddn.com/
>> but is included here again, as especially patch 5/5 has a
>> dependency on it. Amir has also spotted a typo in the commit message
>> of the initial patch, which is corrected here.
>>
>> Patches 2/5 and 3/5 add helper functions, which are needed by the
>> main patch (5/5) in this series and are be also needed by another
>> fuse direct-IO series. That series needs the helper functions in
>> fuse_cache_write_iter, thus, these new helpers are above that
>> function.
>>
>> Patch 4/5 allows to fail fuse_finish_open and is a preparation
>> to handle conflicting IO modes from the server side and will also be
>> needed for fuse passthrough.
>>
>> Patch 5/5 is the main patch in the series, which adds inode
>> IO modes, which is needed to re-enable shared DIO writes locks
>> when FUSE_DIRECT_IO_ALLOW_MMAP is set. Furthermore, these IO modes
>> are also needed by Amirs WIP fuse passthrough work.
>>
>> The conflict of FUSE_DIRECT_IO_ALLOW_MMAP and
>> FOPEN_PARALLEL_DIRECT_WRITES was detected by xfstest generic/095.
>> This patch series was tested by running a loop of that test
>> and also by multiple runs of the complete xfstest suite.
>> For testing with libfuse a version is needed that includes this
>> pull request
>> https://github.com/libfuse/libfuse/pull/870
> 
> Heh, this is already merged :)

Yeah, just not in any libfuse release yet. Btw, for some reasons I need 
to comment out "_require_aio" in tests/generic/095 to get the test to do 
something, I need to investigate why.

> 
> For the record, I understand that you ran this test with passthrough_hp.
> In which configurations --direct-io? --nocache? only default?

I always test with both, which is why testing takes a bit time with all 
tests. Also both modes for generic/095, but that one with an additional 
loop (10 iterations), as in loop mode it found some issues in the 
initial patches. For the --direct-io I actually need a slight patch to 
get that passed through from local.config to passthrough_hp via 
/sbin/mount.fuse.passthrough. Will submit that to libfuse later on.

> 
> Thanks for pushing this through!

Well, thanks a lot for all of your work on it!



Cheers,
Bernd



PS (*): _Another_ broken bicycle in the middle of way to the office.... 
Half of the spokes of my rear wheel broke, out of the nowhere.

