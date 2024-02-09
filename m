Return-Path: <linux-fsdevel+bounces-10946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E15A84F51B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 13:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24F81F22B73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB1231A82;
	Fri,  9 Feb 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="AXyqw3V8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aLuoYfpI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108FC31A83
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707481172; cv=none; b=Mm7CG+d1KVAHPlUR/QwDGP+YOsE9uv3fdPvfjFqzrpLwfSGtxMXhtGa+tfju9fUj3WHrFDG+O2YFoTew4JJynOmxOEg+yk+AiRlqHU5zl7ilD6WO9p80bqJBXU1f4+7hiymRyQewT3oh5AUJZW0UV9pDsEUof4llukvk9MtgM3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707481172; c=relaxed/simple;
	bh=LOw9ASgNZKi4J+9Ilc8AH0tngUPJiswflaO1bTbIn/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgZ1LjlIS1v9XsW/3Qxp6wqAHpcoQzE0hutirZj7RcrmF3o5tcEehLthgApNPBTXPCBJnvaZOJ1YsQrqqa13TNG1ZPC1MwplE7JkZ2XqTa8D1L495FeApBrDubrOu6DzSSYLtv07v7tikJbJbpfuOtJLbig3f0+YB1BBxU87NOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=AXyqw3V8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aLuoYfpI; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id F09115C0182;
	Fri,  9 Feb 2024 07:19:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 09 Feb 2024 07:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707481164;
	 x=1707567564; bh=/YMy2aj2YpQwd+IrlIhAalDAlbXONEFK3N4XfXPrB/k=; b=
	AXyqw3V8e9J7ZbkL2QK8sc9sd5X/QCnSCZagjWlWCxnUC/0n/0oMk2+TjqpKSWLG
	YZPopGsoubeMLeTElPbebwqb8oaNYJ6TQpzuoep2TlSPw+FZWSVg+h+ZsLk8znLw
	+TmvgkWnN/JNmmkPzVoyBdHKIqkC8Pd1WBOqfX0aL2j3yp9VXMkGzeMw1EV3qXdB
	WNFDMplp4Pn4xoq7BY9r4ViEitPmteoJAL95ThBYgT1Bb6oTH3WK8AZEyIjTPdAv
	XB7Ov1Ahstuy0lVrq8Hw7TDt2GBpn35+7kl0ubSg/c1gE+QuHs6YxFkCXH2UkUCP
	16R16bUhY8QtX61egwpG6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707481164; x=
	1707567564; bh=/YMy2aj2YpQwd+IrlIhAalDAlbXONEFK3N4XfXPrB/k=; b=a
	LuoYfpIcY1PSPDwVRth6Rr/rJnu/Lq4sbLwOCMG/oT2lCKP8MoU5bZds7qbaF8IA
	B68Gv9/LWf/XL/bh2QHk11gapVCV1H/0XnkCnhWnIIBS5u8uDk8pRnVtTbygyJa2
	kUjBzvfWVVwOL3Gx6EKMz1XT4W9uNjRFSkHyvSxogbAvyS42l999UDblgUPrdK23
	uhmVjXnuvyR+Jr88q7eIaVqA0pNju8DuTwfGzRuviR7VespXYbwhRuH/mgbSMxvQ
	dAlSkRrWtAzOkDA2M9XPJNauh5+HAZoXV1QgqyeZE/7SF2q0+1bqtZ4LivFUd2Gh
	tTXqcxhgZgQyoRSg0e+jg==
X-ME-Sender: <xms:TBjGZQEwXH9yPpwJtGUdjoToVNMXeSb4HGZCBijENADWQXQ3Gli8Bg>
    <xme:TBjGZZVyQ3RNwfaj4n49xZPVS7tdrmvM86IDorRulsxioDZ-QkoSYORJ8LAtj1iRP
    9w0GAb76EFzbGIT>
X-ME-Received: <xmr:TBjGZaL_Zejs8IzHq8QWW7oOWurSxnPZaFqqFmXPf9o2yJHBqn5OKXHIrmwvnSflGdJi25qCtd6PigQBPsNgEDemds5QDU-cM7xQS9Wx3K5VUHzBworU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduveduveelgeelffffkedukeegveel
    gfekleeuvdehkeehheehkefhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:TBjGZSHQVAE9gzJmwEfjtrWAnvIr1D08YdupIUasvg2TBAYXaDBqDQ>
    <xmx:TBjGZWUIynwjaj-8I-uvUtHT0kIxdbC91jsA7DkazdVpO8GyKg2JgA>
    <xmx:TBjGZVPtknmrGjE4G_6_-JrDVCULH4Rgp6PDEOw_6ckhUz1WUfoY5g>
    <xmx:TBjGZTjdpT8e4HxmBhY5Sj_YXUIxOtPlhdbWKSvh_kaTpanY8qKuog>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 07:19:24 -0500 (EST)
Message-ID: <c2a59abb-caf4-4c7a-a5ba-04ec5efe7f71@fastmail.fm>
Date: Fri, 9 Feb 2024 13:19:23 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] fuse: allow parallel dio writes with
 FUSE_DIRECT_IO_ALLOW_MMAP
Content-Language: en-US, de-DE, fr
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 Bernd Schubert <bschubert@ddn.com>
References: <20240208170603.2078871-1-amir73il@gmail.com>
 <20240208170603.2078871-10-amir73il@gmail.com>
 <CAJfpegtcqPgb6zwHtg7q7vfC4wgo7YPP48O213jzfF+UDqZraw@mail.gmail.com>
 <1be6f498-2d56-4c19-9f93-0678ad76e775@fastmail.fm>
 <f44c0101-0016-4f82-a02d-0dcfefbf4e96@fastmail.fm>
 <CAOQ4uxi9X=a6mvmXXdrSYX-r5EUdVfRiGW0nwFj2ZZTzHQJ5jw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAOQ4uxi9X=a6mvmXXdrSYX-r5EUdVfRiGW0nwFj2ZZTzHQJ5jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/9/24 13:12, Amir Goldstein wrote:
> On Fri, Feb 9, 2024 at 1:48 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 2/9/24 12:21, Bernd Schubert wrote:
>>>
>>>
>>> On 2/9/24 11:50, Miklos Szeredi wrote:
>>>> On Thu, 8 Feb 2024 at 18:09, Amir Goldstein <amir73il@gmail.com> wrote:
>>>>
>>>>>  static int fuse_inode_get_io_cache(struct fuse_inode *fi)
>>>>>  {
>>>>> +       int err = 0;
>>>>> +
>>>>>         assert_spin_locked(&fi->lock);
>>>>> -       if (fi->iocachectr < 0)
>>>>> -               return -ETXTBSY;
>>>>> -       if (fi->iocachectr++ == 0)
>>>>> -               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>>>>> -       return 0;
>>>>> +       /*
>>>>> +        * Setting the bit advises new direct-io writes to use an exclusive
>>>>> +        * lock - without it the wait below might be forever.
>>>>> +        */
>>>>> +       set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>>>>> +       while (!err && fuse_is_io_cache_wait(fi)) {
>>>>> +               spin_unlock(&fi->lock);
>>>>> +               err = wait_event_killable(fi->direct_io_waitq,
>>>>> +                                         !fuse_is_io_cache_wait(fi));
>>>>> +               spin_lock(&fi->lock);
>>>>> +       }
>>>>> +       /*
>>>>> +        * Enter caching mode or clear the FUSE_I_CACHE_IO_MODE bit if we
>>>>> +        * failed to enter caching mode and no other caching open exists.
>>>>> +        */
>>>>> +       if (!err)
>>>>> +               fi->iocachectr++;
>>>>> +       else if (fi->iocachectr <= 0)
>>>>> +               clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>>>>
>>>> This seems wrong:  if the current task is killed, and there's anther
>>>> task trying to get cached open mode, then clearing
>>>> FUSE_I_CACHE_IO_MODE will allow new parallel writes, breaking this
>>>> logic.
>>>
>>> This is called holding a spin lock, another task cannot enter here?
>>> Neither can direct-IO, because it is also locked out. The bit helps DIO
>>> code to avoid trying to do parallel DIO without the need to take a spin
>>> lock. When DIO decides it wants to do parallel IO, it first has to get
>>> past fi->iocachectr < 0 - if there is another task trying to do cache
>>> IO, either DIO gets < 0 first and the other cache task has to wait, or
>>> cache tasks gets > 0 and dio will continue with the exclusive lock. Or
>>> do I miss something?
>>
>> Now I see what you mean, there is an unlock and another task might have also already set the bit
>>
>> I think this should do
>>
>> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
>> index acd0833ae873..7c22edd674cb 100644
>> --- a/fs/fuse/iomode.c
>> +++ b/fs/fuse/iomode.c
>> @@ -41,6 +41,8 @@ static int fuse_inode_get_io_cache(struct fuse_inode *fi)
>>                 err = wait_event_killable(fi->direct_io_waitq,
>>                                           !fuse_is_io_cache_wait(fi));
>>                 spin_lock(&fi->lock);
>> +               if (!err)
>> +                       /* Another interrupted task might have unset it */
>> +                       set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>>         }
>>         /*
>>          * Enter caching mode or clear the FUSE_I_CACHE_IO_MODE bit if we
> 
> I think this race can happen even if we remove killable_
> not sure - anyway, with fuse passthrough there is another error
> condition:
> 
>         /*
>          * Check if inode entered passthrough io mode while waiting for parallel
>          * dio write completion.
>          */
>         if (fuse_inode_backing(fi))
>                 err = -ETXTBSY;
> 
> But in this condition, all waiting tasks should abort the wait,
> so it does not seem a problem to clean the flag.
> 
> Anyway, IMO it is better to set the flag before every wait and on
> success. Like below.
> 
> Thanks,
> Amir.
> 
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -35,8 +35,8 @@ static int fuse_inode_get_io_cache(struct fuse_inode *fi)
>          * Setting the bit advises new direct-io writes to use an exclusive
>          * lock - without it the wait below might be forever.
>          */
> -       set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>         while (!err && fuse_is_io_cache_wait(fi)) {
> +               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>                 spin_unlock(&fi->lock);
>                 err = wait_event_killable(fi->direct_io_waitq,
>                                           !fuse_is_io_cache_wait(fi));
> @@ -53,8 +53,8 @@ static int fuse_inode_get_io_cache(struct fuse_inode *fi)
>          * Enter caching mode or clear the FUSE_I_CACHE_IO_MODE bit if we
>          * failed to enter caching mode and no other caching open exists.
>          */
> -       if (!err)
> -               fi->iocachectr++;
> +       if (!err && fi->iocachectr++ == 0)
> +               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>         else if (fi->iocachectr <= 0)
>                 clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>         return err;


Yeah, that is fine with me. Basically every wait signals "please let me
in", instead of doing it a single time only.


Thanks,
Bernd

