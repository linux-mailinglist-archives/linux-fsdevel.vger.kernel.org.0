Return-Path: <linux-fsdevel+bounces-18430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF048B8B67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 15:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EC528154F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 13:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C1112EBF3;
	Wed,  1 May 2024 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="SoVtLLGJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TkCvjX5p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0304B433D4;
	Wed,  1 May 2024 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570926; cv=none; b=ATZQvp5n1A34ROy8aLXpTBs/63SiSSLpMjnwl9+2kKrNzYF4iw1cP4G/s8r/ZDtXI+2GWhjwpHJN1Yz4tc8kmDyLliaIoimrlsOvtFPUEuAzbLvoJTcY3PoEIBWUzVoq1BmRe2MsvfQlpnDiE8IZdpJdcjApKb9fxOuufGwMNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570926; c=relaxed/simple;
	bh=PRe9JziAYd7Oekv6Bxx8TMGGJC66QjPnsc2sC/Dk61s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqLaS2WQLk8aZ+9TwHGqf4Xo/bhIl4fS4Qyi/eOPQL8/Iz2O2P8nE2ogKU81ZbKWAsFmw5NeqBOraFyWUIOVqN+8bl/U0guKaqruQhWrQ8GgODR54byY5h4ftmQVXRIxHooePSboknPQBzrjQkWIZf/dKoM8yovRexn+C9xv+qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=SoVtLLGJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TkCvjX5p; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1ADBC11400A8;
	Wed,  1 May 2024 09:42:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 May 2024 09:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1714570923;
	 x=1714657323; bh=tygaZVq4PloivL6PKL6UBSuUKd5G8T84EjzJZGAmu30=; b=
	SoVtLLGJwb9+QlNlugu+ktJASrPT7j4zKY8Tu8FhpycUrDt9f00tF4gfDmKduwz6
	7xDpXQdMKKMGaF2HcBRZLWERSrzjU+33BFsxo16UtzrpXl0W/D9vMDqymgZWNdjv
	BRKRJE3RpIw0FpckZQtDn8qRbYGkCO84znr2ARtWCZKZ7tyvu2ydj2E3xPRRvBdE
	MF7XIaN3u8+2RoM6s07Q53KQJsIiC24+t+isOKi3YH316S3kMrXGe+0RG49zk7+S
	24MoFeNWYQImwWA6EuGzrRJNo85oL4PA+SL9uAg0esDpwQfq1GGcoE/3Tndd4bCj
	jxG8BX24kaY+jFH87t0vvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714570923; x=
	1714657323; bh=tygaZVq4PloivL6PKL6UBSuUKd5G8T84EjzJZGAmu30=; b=T
	kCvjX5pjq3yDfFlOndr6eDu4Li5gQdtU5I+ZGkLzU70AZPyKwVvEVwFpwTWdyBH5
	dzVg07zDyAGYyImH78Qtie1c9R/hYGvGmtbxz0+vuVHnO/TKsTkB9MlxxbZBEBAc
	a6IlR5MK+SNy0axAg4AJyYOcwzHP1zjSsTJqF1AwhC2XuKIcC7AdbLZ9e3aK/V+s
	GkaLlo/tsukN4p60zkzkKcemYrAxqcxb8bkPXpq7fcYhjkhlzk5ZzhirHqgbwYfl
	AWJgLmpf8CZyjp+9FSbgIhXYH8vFQllqdTYzZV0c9uWme+kXgXxiWavuzF1TZgQl
	blsT0xLT2fOEpg6xQGiKQ==
X-ME-Sender: <xms:qkYyZnKVPoQoVHlJRWfzWK83aT6JGikjgM1FaL-DoFjDcRhrjcnR3Q>
    <xme:qkYyZrIp-HFuByp5WI4742-1D3uRTncJeR52musV09EZLEZhUVi_H1lqr7Ta2OHD8
    twT4ehYU9LU>
X-ME-Received: <xmr:qkYyZvsEmD-EPNmFYLkRQuix8izrhMH6H_FzAqx5NL0Ea71YgwNnkIRlmGDKX5K4WspwVeuLNGf9zAMUTosbb32II6-99SnYgPScDaY2lbCESgBPmGXTf2EC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduhedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgr
    nhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrh
    hnpeefkefhgeeigeetleffgeelteejkeduvdfhheejhfehueeitdehuefhkeeukeffheen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvg
    hnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:qkYyZgYNey5oxNfSEzZTd8plULSaM2nDWxUS8zh7ZF81euIosI7Fkg>
    <xmx:qkYyZuaz48nYFOyn7m0yee1nxsaeNo93L65aDL41FlPjVetKmAbhrw>
    <xmx:qkYyZkDZglbXqfjWpcIIixgB2zfyOVTL16PXypuEIlUYF8i5ybizBw>
    <xmx:qkYyZsaRg57a7t7QMSlXsHBksfGSGhwZghVoBQwzP781DT_UUrPG8A>
    <xmx:q0YyZkl7JQfKvy959ZcIHZPkpdHsr7cbQ5xRgIke86IgCT7Rq5SWXGFD>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 May 2024 09:41:58 -0400 (EDT)
Message-ID: <52eab48d-9098-4609-895b-6bed5953cc6c@themaw.net>
Date: Wed, 1 May 2024 21:41:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/1] fs/namespace: defer RCU sync for MNT_DETACH umount
To: Lucas Karpinski <lkarpins@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexl@redhat.com, echanude@redhat.com,
 ikent@redhat.com, ahalaney@redhat.com
References: <20240426195429.28547-1-lkarpins@redhat.com>
 <20240426195429.28547-2-lkarpins@redhat.com> <20240426200941.GP2118490@ZenIV>
 <6rp73lih7g2b7i5rhsztwc66quq6fi3mesel52uavvt7uhfzlf@6rytjc7gb2tj>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <6rp73lih7g2b7i5rhsztwc66quq6fi3mesel52uavvt7uhfzlf@6rytjc7gb2tj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/4/24 21:25, Lucas Karpinski wrote:
> On Fri, Apr 26, 2024 at 09:09:41PM +0100, Al Viro wrote:
>>> +		call_rcu(&drelease->rcu, delayed_mount_release);
>> ... which is a bad idea, since call_rcu() callbacks are run
>> from interrupt context.  Which makes blocking in them a problem.
>>
> Thanks for the quick review.
>
> Documentation/RCU/checklist.rst suggests switching to queue_rcu_work()
> function in scenarios where the callback function can block. This seems
> like it would fix the issue you found, while still providing similar
> performance improvements.

You know I've been looking at this and you can see that mntput() will 
just call

mntput_no_expire() which queues work to do the bulk of the work and returns.


So I'm wondering what would happen to the timing if you simply didn't 
call the

rcu wait for the lazy umount case and left everything else as it is.


Ian


