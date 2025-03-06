Return-Path: <linux-fsdevel+bounces-43372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8D1A55199
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 17:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DC33B06CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 16:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECB6221F28;
	Thu,  6 Mar 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="3I3REgZz";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="Y855LaK6";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="D7/s3vFY";
	dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="kPWL8Ju1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFEC221F34
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279068; cv=none; b=pkW94AJTveu+yvp93lpCCFgMg+Pd0OBtX7k8v5Aj4DZq+SzLmxswQNjWhKSKWGiaZ7EXaxs6c/bxMeem5vVss6ERkndn2/JCkKqYaozwQ14uee5tsAEjbe9UZW5MB+/rGavzkZ9UnQFzquZZdx+PYVhpEJA9luR3cd1Laiiayuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279068; c=relaxed/simple;
	bh=BGB05qvKbaiCq8J+3PGwzjEAYEKDFadO+ywijlcM4c0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RhCT4FJHY36gawJhNL6g5G+xB8ZrRdPe1DjLly9l3fFqabiQFt27On8RVZpeQeIgBflYmHc1s9F68mDFyi73Iue8CmnXBd048dn2S9eV9RAYNlh+ie7o8yasVlJJmCy4JEpG6z1CB+IO/LoVmNPdBxXeORkTsGRk/vUhK8KER2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=3I3REgZz; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=Y855LaK6; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=D7/s3vFY; dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=kPWL8Ju1; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:810f:171e:3cc4:af3c])
	by mail.tnxip.de (Postfix) with ESMTPS id 11A56208AD;
	Thu,  6 Mar 2025 17:37:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1741279058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgBfP6Y/pEeb+6JdklamR6B2Lm2YkFY9Qo56fx3D3E0=;
	b=3I3REgZzRd4yasV8nI3tgVsXUwmREfaj3v7ZxLzrhHWoQo/WT7cP7GXTuH0zdE+/q8Mn8q
	s8qLc3QjrHEMaxj/Y97tguxef87+TMlpbEk/IegTIqfUOx6Ku3+LW7UJrHeWpZJ7GWVqqL
	Z34+Ttff4xUCWTCPxrFpT3KIK4KCacc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1741279059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgBfP6Y/pEeb+6JdklamR6B2Lm2YkFY9Qo56fx3D3E0=;
	b=Y855LaK6BN6FLtGKzv3yRtZ91wGpiMyk1HBfQTea9LcEgWSZxQfWiaNuGmuRQDBkrRa/kk
	mEJ+hX4yz2fpX2AQ==
Received: from [IPV6:2a04:4540:8c08:100:138b:b7d5:e167:9bf0] (unknown [IPv6:2a04:4540:8c08:100:138b:b7d5:e167:9bf0])
	by gw.tnxip.de (Postfix) with ESMTPSA id C9DB340000000003C6855;
	Thu, 06 Mar 2025 17:37:37 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1741279057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgBfP6Y/pEeb+6JdklamR6B2Lm2YkFY9Qo56fx3D3E0=;
	b=D7/s3vFYqAi2xAMKzI3Q+UdxQBMC7hXipUx/GmUwnEh63LqVy8taYr/CoRFxtTaIi+IHU5
	hk3m2Lqkxe0hURAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1741279057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgBfP6Y/pEeb+6JdklamR6B2Lm2YkFY9Qo56fx3D3E0=;
	b=kPWL8Ju1u5SpVoQzdO7mgxWCSoHj5tuRWsHgNVCTswd38OetEY6cOBng/GIvAZZ2NG8zID
	rWAltOkC4ieLlhOsToOuOVFenpEqlXVgjcHH2lT1PwqInLHt6KZagPgpUtRc8NuyIr3aa/
	UhbDTwHn3DjZGzc+q6XDGqriLCLwys0=
Message-ID: <d61dd288-cd7c-4adc-a025-21715311704b@tnxip.de>
Date: Thu, 6 Mar 2025 17:37:37 +0100
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
Content-Language: en-US, de-DE
In-Reply-To: <0e5236de-93b9-466a-aba0-2cc8351eb2b5@tnxip.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/02/2025 17:12, Malte Schröder wrote:
> On 16/02/2025 14:10, Matthew Wilcox wrote:
>> On Sun, Feb 16, 2025 at 12:26:06AM +0100, Malte Schröder wrote:
>>> On 15/02/2025 18:11, Matthew Wilcox wrote:
>>>> On Sat, Feb 15, 2025 at 01:34:33PM +0100, Malte Schröder wrote:
>>>>> Hi,
>>>>> I am getting stuff freezing randomly since 6.14-rc. I do not have a clear way to 
>>>> When you say "since 6.14-rc", what exactly do you mean?  6.13 is fine
>>>> and 6.14-rc2 is broken?  Or some other version?
>>> 6.13 and 6.13 + bcachefs-master was fine. Issue started with 6.14-rc1.
>> That's interesting.
>>
>>>> This seems very similar to all of these syzbot reports:
>>>> https://lore.kernel.org/linux-bcachefs/Z6-o5A4Y-rf7Hq8j@casper.infradead.org/
>>>>
>>>> Fortunately, syzbot thinks it's bisected one of them:
>>>> https://lore.kernel.org/linux-bcachefs/67b0bf29.050a0220.6f0b7.0010.GAE@google.com/
>>>>
>>>> Can you confirm?
>>> >From my limited understanding of how bcachefs works I do not think this
>>> commit is the root cause of this issue. That commit just changes the
>>> autofix flags, so it might just uncover some other issue in fsck code.
>>> Also I've been running that code before the 6.14 merge without issues.
>> If you have time to investigate this, seeing if you can reproduce this on
>> commit 141526548052 and then (if it does reproduce) bisecting between that
>> and v6.13-rc3 might lead us to the real commit that's causing the problem.
>>
> I will try. But I will need to find a way to reliably reproduce my issue
> first.

I did not find a reliable way to reproduce this issue. It happens like
every few weeks, so bisecting is not an option for me. Sorry.


It is also is hard to distinguish, which kind of freeze I just
encountered. I also found issues with apparmor vs. resume (just
reported) and I have a feeling something is going on in amdgpu-land but
can't quite pinpoint it, yet.


/Malte


