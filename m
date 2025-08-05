Return-Path: <linux-fsdevel+bounces-56796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5471B1BC78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 00:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E1362831D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 22:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FB825DB0A;
	Tue,  5 Aug 2025 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZEtR4TZs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173D0225402
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754432416; cv=none; b=tVP0mAkYef1EHbb8qiuJA5XOw5W7Wf0hi8xJ30CqVCUxUvk2Au0euzEdufoM/LydM9ZCZFEXPgBjrHl2NhGxLedtfoFp96co39Ug/6I8DN67sgzbI2PQnGSBkWhS7b03JxdewDwPScTDE5wDZyzYA/26LuR5wNC+83wrAct+zuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754432416; c=relaxed/simple;
	bh=k6eK//qtKyfu0r2cCARtjnz5aEWKrn3eO34pm9z7hg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyMT3vJ1Up+gMfj9V6/CIyJ7/v1HMD3GruLKm6pi4kUz+/Qr1NlHRLq9o7EVL/J+Pvvo9aJmBkcKSmoY53CXpufRMw9P75OgdwZ1hwC7GTJqUHuEx92q+T6GcnypWWhzEHaiw4Kr30cw76SKuPfvtYLqtqk6rHytzehtYPk/gjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZEtR4TZs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7961cf660so4868585f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 15:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754432412; x=1755037212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OiAjHzDCWx5/fnwcdQWM5XW7k9js3aPU7lPasy+MIaE=;
        b=ZEtR4TZsZbkPJT/nZnjy1uAbRrG7DuH3Mio+Iy8Qtzy85dyTDoC3A5CAKbZObmU0yh
         6Dyw1/UCeck4y0YA7roStvLOMkRy7RAHA3d/ZrqksZW+NIukUurQsvovvg6ItFgPGG8V
         rntY4rxGDaR5bvpo18qy6SMvTXM3Z9KLHopgG3oGp9O/ieYbWXEjD97k4CfMgfth+KeZ
         tNJvX62/ZELUtpgfS/8UyHjdZeBNcP5DNyGQJHe++FAkgdXIjih9dtC5AAmDujjGHMvW
         UvUdG+fEBNWmva5jbku2cz/1Ffnj8AY0JSJ3LwS5i14lw5q5X4rv+CzBXTw1M1EGjkTi
         Cr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754432412; x=1755037212;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiAjHzDCWx5/fnwcdQWM5XW7k9js3aPU7lPasy+MIaE=;
        b=M+NrbWWYhf3Y1YZ0GirRD4fN4+s35WwOlpAfEOcFLotuBf9MB2vz10JT26GBbdcO+B
         vs2+W8ZEGW36I3l/FhDW4NKcFvpIq1l2V/D23SpIqthaeZ+4criBvB1FOtXChrQKvImF
         O5HniSP8UFYwUBSd89KW/5+uLxSN9Ahl5Hyi/4aAMD2j0iuglky5C+XfLzOpHSs1SAjr
         +wqfIrZ1kHwHiXcrFqpyg7Ty4QfiZ2YYaRBeNkIO8WXADOALOnW8rnFrBhagzIxcnWyS
         YdGPdF/ZlZI1Ic7e2jhWErZmtzxSedJ7NbrF7sQErvtFHAclKZtiZFNhvI7Jkyo9Kf+m
         kOPA==
X-Forwarded-Encrypted: i=1; AJvYcCWxNlMCZus+rmghHhav223xNE+tNMYTtbfApsHNgO9Ry55Z26Lw/H5q0Dk7LSgI0LQuMiChD9IpoZJaJdCZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxaG692WQS12uI+PfcjQ5w4p8cvGU3UTUHR9AVzWsWI0QwVGz1L
	NeYTZogM12zeULeSD9tIYLVUL8Uyckv0zc/+R8Azl71cRSMhhj+moN+0UMd7GKMEHvM=
X-Gm-Gg: ASbGnctFvijtrGLHKx3AadY+b3nj56xsuJMwjDULo/Hr7Ge0fffI5F18qajB7QmSKHU
	M7wtsL5reriLEuRhGG+3SvQEHrO1R4WB0QzKuitVgfjEvoLzOhyPwOOf3VmQmOL9abA0048P41c
	ooRTkf5DGzY8ZPPwWRg07448sdZ66Ipa2zwLY+bKuV/uvIzikc8ZoksPbxYoWE14hHHnAI8/esd
	xDsJ6DhUzp6LdrZVWimx88wUJhl+7ZMwEVXmqTGhTfc1qx4LWa8JhFDsLSxpToQ8096Ub30sdZf
	ACyN0nYvxFzTzlne7fwMucZgGhVEVjSSKFhjo+hw1bq3PxHz6DjrITyyJDNmicgNcgekRa26RoG
	d536fUvdb94OwHu+y0WDpHuhduFQ+H/o2i8UAob4Ktb/90h3KLA==
X-Google-Smtp-Source: AGHT+IF1yMEsHMExuBAJx/ZFT3wrkOpXFDU7fJaND5zk3EE8jSJwV2lypM5/PjsUQf4gqnK+ukIjmA==
X-Received: by 2002:a05:6000:2893:b0:3b7:8b1b:a9d5 with SMTP id ffacd0b85a97d-3b8f493d8b1mr146614f8f.51.1754432412122;
        Tue, 05 Aug 2025 15:20:12 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422be2b3a5sm11829110a12.46.2025.08.05.15.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 15:20:11 -0700 (PDT)
Message-ID: <6a85c9c0-36ac-4a69-a0d5-4bc5846cd5c7@suse.com>
Date: Wed, 6 Aug 2025 07:50:06 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should seed device be allowed to be mounted multiple times?
To: Christian Brauner <brauner@kernel.org>, Anand Jain <anand.jain@oracle.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Qu Wenruo <wqu@suse.de>, linux-btrfs <linux-btrfs@vger.kernel.org>,
 David Sterba <dsterba@suse.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <aef03da8-853a-4c9f-b77b-30cf050ec1a5@suse.de>
 <4cdf6f5c-41e8-4943-9c8b-794e04aa47c5@suse.de>
 <8daff5f7-c8e8-4e74-a56c-3d161d3bda1f@oracle.com>
 <bddc796f-a0e0-4ab5-ab90-8cd10e20db23@suse.de>
 <184c750a-ce86-4e08-9722-7aa35163c940@oracle.com>
 <bc8ecf02-b1a1-4bc0-80e3-162e334db94a@gmx.com>
 <a3db2131-37a8-469f-a20d-dc83b2b14475@oracle.com>
 <510675a5-7cb2-4838-87e0-9fb0e9f114f0@suse.com>
 <20250805-tragweite-keule-31547b419bc3@brauner>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250805-tragweite-keule-31547b419bc3@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/5 22:13, Christian Brauner 写道:
> On Tue, Aug 05, 2025 at 10:22:49AM +0930, Qu Wenruo wrote:
>>
>>
>> 在 2025/8/5 10:06, Anand Jain 写道:
>>>
>>>
>>>>> Thanks for the comments.
>>>>> Our seed block device use-case doesn’t fall under the kind of risk that
>>>>> BLK_OPEN_RESTRICT_WRITES is meant to guard against—it’s not a typical
>>>>> multi-FS RW setup. Seed devices are readonly, so it might be reasonable
>>>>> to handle this at the block layer—or maybe it’s not feasible.
>>>
>>>
>>>> Read-only doesn't prevent the device from being removed suddenly.
>>>
>>> I don't see how this is related to the BLK_OPEN_RESTRICT_WRITES flag.
>>> Can you clarify?
>>
>> It's not related to that flag, I'm talking about the fs_bdev_mark_dead(),
>> and the remaining 3 callbacks.
>>
>> Those call backs are all depending on the bdev holder to grab a super block.
>>
>> Thus a block device should and can not have multiple super blocks.
> 
> I'm pretty sure you can't just break the seed device sharing use-case
> without causing a lot of regressions...

It's not that widely affecting, we can still share the same seed device 
for all different sprout fses, just only one of them can be mounted at 
the same time.

And even with that limitation, it won't affect most (or any) real world 
use cases.

Even the most complex case like using seed devices as rootfs, and we 
want to sprout the rootfs again, just remove the seed device from the 
current rootfs, then one can mount the seed device again.

> 
> If you know what the seed devices are than you can change the code to
> simply use the btrfs filesystem type as the holder without any holder
> operations but just for seed devices. Then seed devices can be opened
> by/shared with any btrfs filesystem.

But we will lose all the bdev related events.

We still want to sync/freeze/thaw the real sprouted fs in the end.

> 
> The only restriction is that you cannot use a device as a seed device
> that another btrfs filesystem uses as a non-seed device because then it
> will be fully owned by the other btrfs filesystem. But Josef tells me
> you can only use it as a seed device anyway.
> 
> IOW, if you have a concept of shareable devices between different btrfs
> filesystems then it's fine to reflect that in the code. If really needed
> you can later add custom block holder ops for seed devices so you can
> e.g., iterate through all filesystems that share the device.

Sure it's possible, with a lot of extra code looking up where the seed 
device belongs, and all the extra bdev event proxy.


But I'd say, the seed device specification is not well specified in the 
very beginning, thus it results a lot of "creative" but not practical 
use cases.

Yes, this will result some regression, but I'd prefer a more sounding 
and simpler logic for the whole seed device, with minimal impact to the 
most common existing use cases.

Thanks,
Qu

