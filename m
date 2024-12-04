Return-Path: <linux-fsdevel+bounces-36474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF439E3DD8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 16:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF19163CD8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EBB20B20E;
	Wed,  4 Dec 2024 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="FDUUTF6X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="flotd3Rz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16926199B8
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324968; cv=none; b=KPTLOG+C4iCkHwWn8r2LcVOiBmWOBmBc90oYX0hmyauynaaCQ7U4iKcx9t5VqNs6j4PzCpSeJLJuVXObSQvMBKUsp2EcNI8CbN3az2stMWTxwIJ9ovPvW4IYryCCgkpzvgtPNZ998y2RqX8+nujss+XSqp599mPJLyv9V4y6Skk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324968; c=relaxed/simple;
	bh=irrIn2djsbgjRy4V2nep6JU8h4ZMCfHS30lZVDzTNAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZrNV9rC2EgEmh9q4VEXZHzws+oLA18Dx9v8XTKklsYvGIbzo4mYbrmBqm46lopDgFKRd7rWbPSGwyzwMrbubGrmK8g2Q/zpRXXU2rTzI8NtfKQc7Be1mps5HpMohpLy3vJ5odFeFUXCg5lfPhUVOa6ZNs+Xtigy2pX+ZnKRfac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=FDUUTF6X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=flotd3Rz; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id ED3C41140135;
	Wed,  4 Dec 2024 10:09:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 04 Dec 2024 10:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733324963;
	 x=1733411363; bh=HO9hOzt6qYw608V0EKb9wqxjyEkagZpuQ7+/gaLh/xM=; b=
	FDUUTF6X/9asGOKECWtvW3SiZLvqyNjK5cBeLW0tnD24cr6cQboovq2rRrbg4e+9
	j7BupAD5i+Y0WDMRbpKTbSxGdduNGetmuHcH2lDvqqUQcCjYWkxNTf+UuJv1hv5P
	hRdrSFx6Bg4uMTj1S5HHVdvezWvso6ougyuzVjkj+3c17r9/nm5jUR/WYPVnEG+s
	kIhnfOKAf2eUvUoCljsB610FK5Akk6pbjf5SzjtllRWyys6RbTNv84mc3FmfcjgD
	Iwp9w2WyRsqx2Ttl2D/B+h2lJh75/I7LYkpdUIqKSxJwVPKFtnmu31p5zepmXi3t
	7c3op52JpA36OHCIpkOs4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733324963; x=
	1733411363; bh=HO9hOzt6qYw608V0EKb9wqxjyEkagZpuQ7+/gaLh/xM=; b=f
	lotd3RzsXm1vQPXOg04HdVLLjt6ao8KuF1Vhc81x/DHJFdIGoLzakWMV9qHGr+5s
	CrasSLuNW0N2A2lhKIWR6Wm6px5xf2UF3CaJD6dxNpFirUbBv03PWw5hJxK/F/xj
	5+tea52nIh7hV/aS4rcF+knx8ntpPhfVufn0ZkGJLY4ukYCocrYJnNYSFuAndjoC
	jf30nJKeUpVRmA1FjRkJ3mN41hhUM9uceo+pchaUmD+YLI8LzbpRIzpAVjnHpl65
	X9j0ktsb38JnNSwpQCKRCirqhZ3DUyWI41h6wkUs0AkjCUnBqnfijo3SNSRZSxkh
	yp3eladbJsh3Q7yQC+PJg==
X-ME-Sender: <xms:onBQZ3A_vwTRXhAQOlJXceOS3OxgW3NcilRq1ALVBUgF8T78UWmKdg>
    <xme:onBQZ9i-orthWn3eldKFWd17CLhuhSazAwWEUqYIJjCWkD3WjPzqf8-hzCwJJftJF
    cG-99SkoXMlBO1Z>
X-ME-Received: <xmr:onBQZymqQVKpMtzQidWhOex1W_nrFI3BGu-gKnr_nTTMUJDB6qjxTM1Yu3LSNwXXp-C-5yf_ovJhfd__vkis7gTBEr9yNWcmw5Mobo7fA_edOw1NmeCi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieehgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeen
    ucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrh
    htsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevgfeukedtfeeugfek
    ueeikeeileejheffjeehleduieefteeufefhteeuhefhfeenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsggprh
    gtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghgvghffhho
    nhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhfihhgrgestghhrhhomhhiuhhmrd
    horhhgpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshgvnhhoiihhrghtshhkhiestghhrhhomhhiuhhmrdhorhhgpdhrtghpth
    htohepsghstghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopehmihhklhhoshes
    shiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgu
    rgdrtghomhdprhgtphhtthhopehjvghffhhlvgiguheslhhinhhugidrrghlihgsrggsrg
    drtghomh
X-ME-Proxy: <xmx:onBQZ5y1hbWXEU8uhqkv3lZybyv1lF6iBhHFBUBEnBH9UksN_yrDpQ>
    <xmx:onBQZ8Q_LFtnJLB2hq3wkRKPwmqWrPV_tgn70YSDzfwKcnzgb0Lcrw>
    <xmx:onBQZ8bat9ShRk8Zhje0jasHWifUi4f5SigWQ75vjZmGi4Ms2ek45A>
    <xmx:onBQZ9Sb-5WlJIk5hrXgcPa6rpF0_5u2rR87uw0331CX731eUOnvdQ>
    <xmx:o3BQZwYrshKRB2aXm8VhSqUD-uOx5RX-dbzmGCW6lkflUwNTWBqBN6yV>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Dec 2024 10:09:21 -0500 (EST)
Message-ID: <217fe49e-d6b2-4bff-86ae-463eb9724995@fastmail.fm>
Date: Wed, 4 Dec 2024 16:09:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Brian Geffon <bgeffon@google.com>, Tomasz Figa <tfiga@chromium.org>
Cc: Joanne Koong <joannelkoong@gmail.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Bernd Schubert <bschubert@ddn.com>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
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
 <ab0c3519-2664-4a23-adfa-d179164e038d@fastmail.fm>
 <CAJnrk1b3n7z3wfbZzUB_zVi3PTfjbZFbiUTfFMfAu61-t-W7Ug@mail.gmail.com>
 <CAAFQd5B+CkvZDSa+tZ0_ZpF0fQRC9ryXsGqm2R-ofvVqNnAJ1Q@mail.gmail.com>
 <CADyq12xSgHVFf4-bxk_9uN5-KJWnCohz1VAZKH4QEKJLJpcUEA@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CADyq12xSgHVFf4-bxk_9uN5-KJWnCohz1VAZKH4QEKJLJpcUEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/4/24 15:51, Brian Geffon wrote:
> On Wed, Dec 4, 2024 at 9:40 AM Tomasz Figa <tfiga@chromium.org> wrote:
>>
>> On Tue, Dec 3, 2024 at 4:29 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>>>
>>> On Mon, Dec 2, 2024 at 6:43 AM Bernd Schubert
>>> <bernd.schubert@fastmail.fm> wrote:
>>>>
>>>> On 12/2/24 10:45, Tomasz Figa wrote:
>>>>> Hi everyone,
>>>>>
>>>>> On Thu, Nov 28, 2024 at 8:55 PM Sergey Senozhatsky
>>>>> <senozhatsky@chromium.org> wrote:
>>>>>>
>>>>>> Cc-ing Tomasz
>>>>>>
>>>>>> On (24/11/28 11:23), Bernd Schubert wrote:
>>>>>>>> Thanks for the pointers again, Bernd.
>>>>>>>>
>>>>>>>>> Miklos had asked for to abort the connection in v4
>>>>>>>>> https://lore.kernel.org/all/CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S2JACFdgJJ_b8FdHw@mail.gmail.com/raw
>>>>>>>>
>>>>>>>> OK, sounds reasonable. I'll try to give the series some testing in the
>>>>>>>> coming days.
>>>>>>>>
>>>>>>>> // I still would probably prefer "seconds" timeout granularity.
>>>>>>>> // Unless this also has been discussed already and Bernd has a link ;)
>>>>>>>
>>>>>>>
>>>>>>> The issue is that is currently iterating through 256 hash lists +
>>>>>>> pending + bg.
>>>>>>>
>>>>>>> https://lore.kernel.org/all/CAJnrk1b7bfAWWq_pFP=4XH3ddc_9GtAM2mE7EgWnx2Od+UUUjQ@mail.gmail.com/raw
>>>>>>
>>>>>> Oh, I see.
>>>>>>
>>>>>>> Personally I would prefer a second list to avoid the check spike and latency
>>>>>>> https://lore.kernel.org/linux-fsdevel/9ba4eaf4-b9f0-483f-90e5-9512aded419e@fastmail.fm/raw
>>>>>>
>>>>>> That's good to know.  I like the idea of less CPU usage in general,
>>>>>> our devices a battery powered so everything counts, to some extent.
>>>>>>
>>>>>>> What is your opinion about that? I guess android and chromium have an
>>>>>>> interest low latencies and avoiding cpu spikes?
>>>>>>
>>>>>> Good question.
>>>>>>
>>>>>> Can't speak for android, in chromeos we probably will keep it at 1 minute,
>>>>>> but this is because our DEFAULT_HUNG_TASK_TIMEOUT is larger than that (we
>>>>>> use default value of 120 sec). There are setups that might use lower
>>>>>> values, or even re-define default value, e.g.:
>>>>>>
>>>>>> arch/arc/configs/axs101_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
>>>>>> arch/arc/configs/axs103_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
>>>>>> arch/arc/configs/axs103_smp_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
>>>>>> arch/arc/configs/hsdk_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
>>>>>> arch/arc/configs/vdk_hs38_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
>>>>>> arch/arc/configs/vdk_hs38_smp_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
>>>>>> arch/powerpc/configs/mvme5100_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=20
>>>>>>
>>>>>> In those cases 1 minute fuse timeout will overshot HUNG_TASK_TIMEOUT
>>>>>> and then the question is whether HUNG_TASK_PANIC is set.
> 
> In my opinion this is a good argument for having the hung task timeout
> and a fuse timeout independent. The hung task timeout is for hung
> kernel threads, in this situation we're potentially taking too long in
> userspace but that doesn't necessarily mean the system is hung. I
> think a loop which does an interruptible wait with a timeout of 1/2
> the hung task timeout would make sense to ensure the hung task timeout
> doesn't hit. There might be situations where we want a fuse timeout
> which is larger than the hung task timeout, perhaps a file system
> being read over a satellite internet connection?


For a network file system the remote server also might just hang and
one might want to wait much longer than  1/2 hung task timeout for 
recovery.


Thanks,
Bernd

