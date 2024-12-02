Return-Path: <linux-fsdevel+bounces-36264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F41D9E061D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 16:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEFC169FCE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1811D208970;
	Mon,  2 Dec 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="X+7Uj3Ld";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iOQWtn2x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401C1207A2C
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150626; cv=none; b=izosZObBYRg/IagtptzHk8u5tSobSq6JtsnZsnKyvON4fP6bv6cmfQrvKA8zwdthqOqqfPgCNw127f6UX/OfSKxDtubzYswwnxMSmrgA2JKE6SfNkdnWJUHf1kFGZnDWuEBEVMpAXtF0TYr7bg7Qn4REU7RjCSmOuGyMWQu8WVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150626; c=relaxed/simple;
	bh=n+R5Qp/1yDHYuIjwS9rwMuxlcGbDy9rHYu9lc3MeKo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnwxOqh/LBng8bNplfoKhpa+XXLVd+0uWgTUCQU6CfBJx92wLMeeR0s3qP6kOzRpq8NJP04Te4rEYHyfLVWnR3BJNQYh20p6s491PSXmqgahh5UbaHxRD4HLE0kOeg73yWE7TSWlQhV8nLgFejIfDnDL0ud27gfs0Al32LlYZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=X+7Uj3Ld; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iOQWtn2x; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6960E1140147;
	Mon,  2 Dec 2024 09:43:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 02 Dec 2024 09:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733150623;
	 x=1733237023; bh=zAbaf1H2sBrjw4nYE1vl3xf1i7Z4YqngIOCJqk1MkJY=; b=
	X+7Uj3Ld7P710EKNM/av6YLqkcbUfc1RAjkULAd/Vpa4x8NFxmap1Xx29IN3dhld
	cGaHg6pd0uzPmq0dFyW5W0ER7ldmpcKqRirNZsg4QI1bKxYkoyDG8LErIQciP4mN
	/gXIygqnWLZANkXgKATELC8CbTtWJPEsRZG+2HWK3VuqLtxftwn5NHqJxvHvIBfs
	eU8wuZ1HeDgJ7ike1eIAGmnprprRjgG1lxHVVJYhCVwQ06kfIREIGJXeQmpaLvf1
	2GeMo4lyaRTt+ubiTck3BV2ocgXz5E7sClsYdV/Ou1WlmB7MKzuO1/Mrx8Hv+YeX
	B/BN/m6dAG5iGE4AOiEhpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733150623; x=
	1733237023; bh=zAbaf1H2sBrjw4nYE1vl3xf1i7Z4YqngIOCJqk1MkJY=; b=i
	OQWtn2xf5uNcFFlU3CnkFUd/7GN4mnypM1hLt1cuxhZZ1U8zDNSD/4OulONz1CS/
	dIdgR3FG0+8ughMHuzl/2Z+lKfa2GlaKUl3D6s3+tn8ixAYKZ+KZjOnlbLgbvClx
	SuNscFjWVL0wWJzSB/LqGEFj5zx7sGqVpS0lQxS/4UkIOfboHFTcn0xrvo0stQZG
	gD+gdzlzjMwwlojZg8MuecLeIbC9UG9ZMbuypLQD/5ZRd/C70q5KUtBmtPy4Jzu/
	0NXgpTcLg/dHSspBRxlE92yP9CJdwN77eL3Z/Ffx97Bvxt/2xdNHS2chyh7fbNnE
	QSF9v/xdJlZ0dHC3i5q/g==
X-ME-Sender: <xms:nsdNZ5dwN2Xvam2R5_kny3EzalAWGt0kOmcZX4sHWFvdaoTq3I8vZQ>
    <xme:nsdNZ3O27OwA_B2IpWvUhvQ_k9KlrcN4yj6dXhbeC6RjT5yPUMRReoEEow7n9tbqc
    dvu7HeKLgB-i-iG>
X-ME-Received: <xmr:nsdNZyhZGXDYc43NmHsXG8OTRyQMYMKZth6iohS6gse-XAkN-EbqD0d8Q9z-0z6xcwFaDXCTPIVNzSGR_yiEzBtQFBbX5UQA4ByvjBKAhnuVg0rtzGuE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeen
    ucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrh
    htsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeethedtudefkefgffei
    tdevueduuedvheekleetueejleejgfeiffekfeeikeelffenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsth
    hmrghilhdrfhhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepthhfihhgrgestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepshgvnh
    hoiihhrghtshhkhiestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepsghstghhuhgs
    vghrthesuggunhdrtghomhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrg
    hilhdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghp
    thhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehj
    vghffhhlvgiguheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehlrg
    horghrrdhshhgrohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:nsdNZy9SqKY3gtA68tEvz3rOOPeWoMuuoUSLEl6mty269El7HPmtpQ>
    <xmx:nsdNZ1v8GPGwEPGKSk-YYCU5xFxl1hCSTabzBusL6lZh2zNVx0RyOA>
    <xmx:nsdNZxHRJymEVSJHkXFJzE60Wf5Xse7_1y1WCTVtv5mM_Hcuj1ubug>
    <xmx:nsdNZ8PbEjgahdtO5RXZ5sJ6Ek81aatIFwb9Wy0lWrKwOMsIu-kBWw>
    <xmx:n8dNZ2lb83Jwuc-YzSyekADzr4JHoqjCX_BpWuzM7YWhH0WL1YPIuuh9>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 09:43:40 -0500 (EST)
Message-ID: <ab0c3519-2664-4a23-adfa-d179164e038d@fastmail.fm>
Date: Mon, 2 Dec 2024 15:43:39 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Bernd Schubert <bschubert@ddn.com>, Joanne Koong
 <joannelkoong@gmail.com>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
 "laoar.shao@gmail.com" <laoar.shao@gmail.com>,
 "kernel-team@meta.com" <kernel-team@meta.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com>
 <20241128104437.GB10431@google.com>
 <25e0e716-a4e8-4f72-ad52-29c5d15e1d61@fastmail.fm>
 <20241128110942.GD10431@google.com>
 <8c5d292f-b343-435f-862e-a98910b6a150@ddn.com>
 <20241128115455.GG10431@google.com>
 <CAAFQd5BW+nqZ2-_U_dj+=jLeOK9_FYN7sf_4U9PTTcbw8WJYWQ@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAAFQd5BW+nqZ2-_U_dj+=jLeOK9_FYN7sf_4U9PTTcbw8WJYWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/2/24 10:45, Tomasz Figa wrote:
> Hi everyone,
> 
> On Thu, Nov 28, 2024 at 8:55 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
>>
>> Cc-ing Tomasz
>>
>> On (24/11/28 11:23), Bernd Schubert wrote:
>>>> Thanks for the pointers again, Bernd.
>>>>
>>>>> Miklos had asked for to abort the connection in v4
>>>>> https://lore.kernel.org/all/CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S2JACFdgJJ_b8FdHw@mail.gmail.com/raw
>>>>
>>>> OK, sounds reasonable. I'll try to give the series some testing in the
>>>> coming days.
>>>>
>>>> // I still would probably prefer "seconds" timeout granularity.
>>>> // Unless this also has been discussed already and Bernd has a link ;)
>>>
>>>
>>> The issue is that is currently iterating through 256 hash lists +
>>> pending + bg.
>>>
>>> https://lore.kernel.org/all/CAJnrk1b7bfAWWq_pFP=4XH3ddc_9GtAM2mE7EgWnx2Od+UUUjQ@mail.gmail.com/raw
>>
>> Oh, I see.
>>
>>> Personally I would prefer a second list to avoid the check spike and latency
>>> https://lore.kernel.org/linux-fsdevel/9ba4eaf4-b9f0-483f-90e5-9512aded419e@fastmail.fm/raw
>>
>> That's good to know.  I like the idea of less CPU usage in general,
>> our devices a battery powered so everything counts, to some extent.
>>
>>> What is your opinion about that? I guess android and chromium have an
>>> interest low latencies and avoiding cpu spikes?
>>
>> Good question.
>>
>> Can't speak for android, in chromeos we probably will keep it at 1 minute,
>> but this is because our DEFAULT_HUNG_TASK_TIMEOUT is larger than that (we
>> use default value of 120 sec). There are setups that might use lower
>> values, or even re-define default value, e.g.:
>>
>> arch/arc/configs/axs101_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
>> arch/arc/configs/axs103_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
>> arch/arc/configs/axs103_smp_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
>> arch/arc/configs/hsdk_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
>> arch/arc/configs/vdk_hs38_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
>> arch/arc/configs/vdk_hs38_smp_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
>> arch/powerpc/configs/mvme5100_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=20
>>
>> In those cases 1 minute fuse timeout will overshot HUNG_TASK_TIMEOUT
>> and then the question is whether HUNG_TASK_PANIC is set.
>>
>> On the other hand, setups that set much lower timeout than
>> DEFAULT_HUNG_TASK_TIMEOUT=120 will have extra CPU activities regardless,
>> just because watchdogs will run more often.
>>
>> Tomasz, any opinions?
> 
> First of all, thanks everyone for looking into this.
> 
> How about keeping a list of requests in the FIFO order (in other
> words: first entry is the first to timeout) and whenever the first
> entry is being removed from the list (aka the request actually
> completes), re-arming the timer to the timeout of the next request in
> the list? This way we don't really have any timer firing unless there
> is really a request that timed out.

Requests are in FIFO order on the list and only head is checked. 
There are 256 hash lists per fuse device for requests currently
in user space, though.

> 
> (In fact, we could optimize it even further by opportunistically
> scheduling a timer slightly later and opportunistically handling timed
> out requests when other requests are being completed, but this would
> be optimizing for the slow path, so probably an overkill.)
> 
> As for the length of the request timeout vs the hung task watchdog
> timeout, my opinion is that we should make sure that the hung task
> watchdog doesn't hit in any case, simply because a misbehaving
> userspace process must not be able to panic the kernel. In the
> blk-core, the blk_io_schedule() function [1] uses
> sysctl_hung_task_timeout_secs to determine the maximum length of a
> single uninterruptible sleep. I suppose we could use the same
> calculation to obtain our timeout number. What does everyone think?
> 
> [1] https://elixir.bootlin.com/linux/v6.12.1/source/block/blk-core.c#L1232

I think that is a good idea.


Thanks,
Bernd

