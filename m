Return-Path: <linux-fsdevel+bounces-44696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F26A6B7D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 10:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D341F482F6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 09:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A7D1F1301;
	Fri, 21 Mar 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="hBvZjC+H";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="OgDqqYwU";
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="EvFlgfDH";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="PPO0HiJJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86F61EFFA4
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550123; cv=none; b=OCT84jc35XrPL62S99Vx7+aXcRXZ/1aE0Y/0s8xjKZr0gW2IIGFkRs1o7+6VYz6VaYLzoATaGtBAVq0KTcp4zUeZyaDYaF24v4XE0oVysr4iRpw64rW03Dr92bBRV71aDwVYBLPx+qB4q/PcbvhbIdk2mwPcWOHwLDT8uxmOaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550123; c=relaxed/simple;
	bh=IJ+K5OSTJBkQCs1C6yqJdB3J0gF/16mRNM2HCkD9Nso=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nN+ySdkiNg4AG8DpxdyPPb3sS3nnM9ZvxJyqL8DmMjIwu+bSwg6wglpPyre4WJZ1aiefxDU9L/Mr/KFarSwpbQI1X39xrNO6oyH81ks8I50Hl4JZh0+EVSAAJdOxtmJ5WNFjA3FPymJjMgYPF4mT3XIqWJJB4tUES9E/iRWzwTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=hBvZjC+H; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=OgDqqYwU; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=EvFlgfDH; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=PPO0HiJJ; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:5d4e:344b:7eb2:7ccc])
	by mail.tnxip.de (Postfix) with ESMTPS id 972C7208AD;
	Fri, 21 Mar 2025 10:41:45 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1742550105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qx26ebe7MdjOE9pme50/NbVnGkpmGGZxsnPspoOiOH8=;
	b=hBvZjC+HjfPWBmPYXR+T/QV1F9MW51z4oitkZ9ijnUaZ2GfLTCE0ns4u5Ty/g3oL+t2YxG
	Yj3VHwFow42ZVDCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1742550105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qx26ebe7MdjOE9pme50/NbVnGkpmGGZxsnPspoOiOH8=;
	b=OgDqqYwUjvJxaN5pur8S9zUsbSRfYU7EtbIJBzvoPCSrrFveUNtGtt3AwOT7H51Vba2Sfv
	q2SYLa93bSW+vxDuQZ4i3DV9/lYI5XnMQdqgr3uB/UUsksB2jJQALy01z5CAL6dGxa9Q1v
	4GLcAYkx4CfYjouOEthm6hFzFS7bq/c=
Received: from [IPV6:2a04:4540:8c08:700:b62a:cab:307d:8dc9] (unknown [IPv6:2a04:4540:8c08:700:b62a:cab:307d:8dc9])
	by gw.tnxip.de (Postfix) with ESMTPSA id 5A66C5800000000000E32;
	Fri, 21 Mar 2025 10:41:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1742550105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qx26ebe7MdjOE9pme50/NbVnGkpmGGZxsnPspoOiOH8=;
	b=EvFlgfDHPhRh3savza2YBKX20Iujr+nqrmE7Jw7RghZqmalL8Z742NjNJMUA+64NFi44Yb
	9vrP8HNoQHIbpljs53QHqAYjkbZnWPrQ+FsbRO/pel4x7ciTKCAQOWsS6/PzmpUMOXvDXP
	32pEXDEDktlYDUebQIpRoqnq+EyFSdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1742550105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qx26ebe7MdjOE9pme50/NbVnGkpmGGZxsnPspoOiOH8=;
	b=PPO0HiJJctbR8UsWAuzRTQG5K/kj8rJEwN1PEzkCE2Hdd/etcx/JsT1OzOeO+WnTAWaUSx
	c19nD6/vk6QZa0CQ==
Message-ID: <5d1428e6-3a8b-448d-817e-f46eb343cd67@tnxip.de>
Date: Fri, 21 Mar 2025 10:41:45 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: Random desktop freezes since 6.14-rc. Seems VFS related
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <39cc7426-3967-45de-b1a1-526c803b9a84@tnxip.de>
 <Z7DKs3dSPdDLRRmF@casper.infradead.org>
 <87e7e4e9-b87b-4333-9a2a-fcf590271744@tnxip.de>
 <Z7Hj3pzwylskq4Fd@casper.infradead.org>
 <0e5236de-93b9-466a-aba0-2cc8351eb2b5@tnxip.de>
 <d61dd288-cd7c-4adc-a025-21715311704b@tnxip.de>
Content-Language: en-US, de-DE
In-Reply-To: <d61dd288-cd7c-4adc-a025-21715311704b@tnxip.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 06/03/2025 17:37, Malte Schröder wrote:
> On 16/02/2025 17:12, Malte Schröder wrote:
>> On 16/02/2025 14:10, Matthew Wilcox wrote:
>>> On Sun, Feb 16, 2025 at 12:26:06AM +0100, Malte Schröder wrote:
>>>> On 15/02/2025 18:11, Matthew Wilcox wrote:
>>>>> On Sat, Feb 15, 2025 at 01:34:33PM +0100, Malte Schröder wrote:
>>>>>> Hi,
>>>>>> I am getting stuff freezing randomly since 6.14-rc. I do not have a clear way to 
>>>>> When you say "since 6.14-rc", what exactly do you mean?  6.13 is fine
>>>>> and 6.14-rc2 is broken?  Or some other version?
>>>> 6.13 and 6.13 + bcachefs-master was fine. Issue started with 6.14-rc1.
>>> That's interesting.
>>>
>>>>> This seems very similar to all of these syzbot reports:
>>>>> https://lore.kernel.org/linux-bcachefs/Z6-o5A4Y-rf7Hq8j@casper.infradead.org/
>>>>>
>>>>> Fortunately, syzbot thinks it's bisected one of them:
>>>>> https://lore.kernel.org/linux-bcachefs/67b0bf29.050a0220.6f0b7.0010.GAE@google.com/
>>>>>
>>>>> Can you confirm?
>>>> >From my limited understanding of how bcachefs works I do not think this
>>>> commit is the root cause of this issue. That commit just changes the
>>>> autofix flags, so it might just uncover some other issue in fsck code.
>>>> Also I've been running that code before the 6.14 merge without issues.
>>> If you have time to investigate this, seeing if you can reproduce this on
>>> commit 141526548052 and then (if it does reproduce) bisecting between that
>>> and v6.13-rc3 might lead us to the real commit that's causing the problem.
>>>
>> I will try. But I will need to find a way to reliably reproduce my issue
>> first.
> I did not find a reliable way to reproduce this issue. It happens like
> every few weeks, so bisecting is not an option for me. Sorry.
>
>
> It is also is hard to distinguish, which kind of freeze I just
> encountered. I also found issues with apparmor vs. resume (just
> reported) and I have a feeling something is going on in amdgpu-land but
> can't quite pinpoint it, yet.
>
>
> /Malte
>
I get the feeling this issue lies deeper. I get this about once a week,
but also when there is nothing really going on IO wise. May there be a
deeper issue with rcu? Who to involve?

/Malte


