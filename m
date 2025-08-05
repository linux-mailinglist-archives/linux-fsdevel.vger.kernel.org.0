Return-Path: <linux-fsdevel+bounces-56704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D326B1ABD4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 02:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962EC17D37F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 00:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE14189905;
	Tue,  5 Aug 2025 00:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Zt4LTHs0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778EA3FE7
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754355179; cv=none; b=ijUBoyfS295pUmK/S3wRKj75hW7RW5jxWUN354NRvSgBf6DV00cwps2iXpZ9jPFwYvuqzgwoQNxXKfVo+WNBAdXXFN6P9D3d+ZtaH4uur8hu5D0xm2ZLv4Kc0FH8ZiSUYLeXacOVgGe5zkH+TjiLH51H++wgDEu7b6eIg7kX3Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754355179; c=relaxed/simple;
	bh=TBUNnhxD1842HFOzp6kn5hSqXP5MRgPWgOWV2/OvRo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X2mgSvzwxOJHIWPds9759ZAUgCDsf9jcm0WeQQFZGczdqGOXwSBbQiodr+N19AdVh6srzUAc2osKTc7sG6uQjpCvEy6r44Wopbh/6G5JnvXr0fweS8Z1oo9sxM40MlupCZFKoue9Knseqxil/yY7J/RLStDkOnRDFyvfNQy0MVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Zt4LTHs0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b78a034f17so3346595f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 17:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754355176; x=1754959976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T3mkcPdexRN4at20C1geVLLNsNcKXRcUEz7db2wwIaU=;
        b=Zt4LTHs0gWkxhWM/ENdODLvrpkV/8oJA+BU2EmM1rbEQXIE0NHFLFNOOT+T864wqtR
         SeUvfP/0rEOUMzW5ERYCYU9oSNAtNn7lVJkylbJKp+yDNbi+XqgF7Y4JQXNCMQI+tP/a
         ErrQTrQ8h8WuQHFXwpx/0wY7NgzNaAz0SE3lOO+pJrst8NmRjSDLog7u106GyGrnqdRY
         YZsjQE7NZ/NnXHlFqKtxP80qRjhvdybLKjNo+UkzdaVapwyodsRqPrRmETQ9Tm3efgD8
         rYFAjJw0x5HGHFQaqFm8/MU2Ji2l8LfixcU0Sfk4xjUhrTqcTCiTiZg3SWWEDA+wHgza
         fWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754355176; x=1754959976;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3mkcPdexRN4at20C1geVLLNsNcKXRcUEz7db2wwIaU=;
        b=q4ZSgrY9ylRSvvOzSVWJ6i7hslygZJtr1+r3AR91JjNp55gU3K6u4Ez66gfrrypUrC
         5hUkVLydRofqJshTtoDMvRrGWkflCo49xKQvQn/Z+aytf/uWWp3LC1DiT/SYCRVIrgyp
         baMaojq2XxV9obF0hdAyxZZQmhTR/EyhCRd/OmjoCKgh3Un7Phd/zEkDiVbf3aU2CLo7
         N7/nQd0fnTZgeiW6B6jGfJvqncMfMwgTLhlNXlt06GadDoiGzEQyVOdLAE4WWtHNnYuy
         TwDWEM4QANCL0aFUZPSdU/g1o9JQGCOQvlJf4czaO8dGOY2C+yzKtTl6XM9HL27n3qCi
         MDqg==
X-Forwarded-Encrypted: i=1; AJvYcCUxpLY+aphMJtTaxLNNXhtdy0GVjUODJSqWaGOFp7ux0su+MpdafAgelyEUwom84ZPArXoGe0Wm6tyfYbvX@vger.kernel.org
X-Gm-Message-State: AOJu0YwaaeJynwpE6JxwX7q3JSqpPt6cWtbAMy5JDHNxTUrsfYXM1qjm
	NWWHMISoysx6YhsZihpD5d3zvrs4bBHw6n5Itb2pE5RkIY0dbues4OP7Hf1xiLaZ25g=
X-Gm-Gg: ASbGncv8dV0JXeIK1mpeIYz/GubbJna5q9rqJeLWHd3enLX1B/P2vZn9jm9YKG53wO3
	lEkIcz+5YQcsPGl3wXWXHKX0YY4o32h5UE0Y6DLkR/OAvuLwYatxPywuVP1QARO0cFjmbCAiPwC
	JcBYeDvtgdtClWhD8Nglr0NbuM8s93s49qnwiNhqPaUnRKakp2RNgjheUE3zpXO9JOZMDS2AUNa
	aw8+7TH5widEbrbYxh6ujIMCVXoyPRW/uSkFgJ6Lpr6wJCoS7IKlfv16ZO3jQsmnuAnIB9bpXk+
	zsfekgz7elgqfN3ssbBk2UK158kiviYCceX87q+YV/XgqKnhS8sae/39Qk5G2ZFr0hehuFKynVb
	i0oJ6sZt1yAki5jOkJDpRg7T2ee8h830oad+lptkCX1CrHKAvq4qLS37tnUSU
X-Google-Smtp-Source: AGHT+IGgIoj/ytGmmiZCm/WyOOoK/JoWd3pIPcnuGCXIvetP+ROr/UwG61SyL9Unu72AH58O/qAHvg==
X-Received: by 2002:a05:6000:228a:b0:3b7:825e:2d28 with SMTP id ffacd0b85a97d-3b8d946c027mr7987123f8f.9.1754355175648;
        Mon, 04 Aug 2025 17:52:55 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8ac9021sm118590975ad.195.2025.08.04.17.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 17:52:55 -0700 (PDT)
Message-ID: <510675a5-7cb2-4838-87e0-9fb0e9f114f0@suse.com>
Date: Tue, 5 Aug 2025 10:22:49 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should seed device be allowed to be mounted multiple times?
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
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
In-Reply-To: <a3db2131-37a8-469f-a20d-dc83b2b14475@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/5 10:06, Anand Jain 写道:
> 
> 
>>> Thanks for the comments.
>>> Our seed block device use-case doesn’t fall under the kind of risk that
>>> BLK_OPEN_RESTRICT_WRITES is meant to guard against—it’s not a typical
>>> multi-FS RW setup. Seed devices are readonly, so it might be reasonable
>>> to handle this at the block layer—or maybe it’s not feasible.
> 
> 
>> Read-only doesn't prevent the device from being removed suddenly.
> 
> I don't see how this is related to the BLK_OPEN_RESTRICT_WRITES flag. 
> Can you clarify?

It's not related to that flag, I'm talking about the 
fs_bdev_mark_dead(), and the remaining 3 callbacks.

Those call backs are all depending on the bdev holder to grab a super block.

Thus a block device should and can not have multiple super blocks.

> 
> ------
> /* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
> #define BLK_OPEN_RESTRICT_WRITES        ((__force blk_mode_t)(1 << 5))
> ------
> 
>> You still didn't know that the whole fs_holder_ops is based on the 
>> assumption that one block device should only belong to one mounted fs.
> 
> You're missing the point: after a sprout, Btrfs internally becomes a new
> filesystem with a new FSID. Some may call it insane—but it's different,
> useful, and it works.

I totally know that, it's you don't understand how bdev holder works, 
nor willing to spend any time reading the details about bdev_open().

Just search the @holder inside that function, even without 
RESTRICT_WRITES flag, it will still fail at bd_may_reclaim() due to the 
holder (super block) mismatch.


> 
> During that transition, fs_holder (or equivalent) needs to be updated to
> reflect the change. If that's not currently possible, we may need to add
> support for it.
> 
> The problem is that fs_holder_ops still sees it as a seed device, which
> is risky—we don’t know what else could break if the FSID change isn’t
> properly handled.

Nope, it's super simple, you just can not mount have a block device with 
two different holders.

> 
>> And I see that assumption completely valid.
>>
>> I didn't see any reason why any sane people want to mount the sported 
>> fs and the seed device at the same time.
> 
> Neither of us has data on how it’s being used.

Just read all the other filesystems' code.

Either it's pushing super block as bdev holder, so that we can easily 
grab the fs from bdev through bdev_super_lock(), or it's bcachefs doing 
the similar thing, but without using the existing helpers.

> And as I’ve hinted, it
> does violate kABI from a technical standpoint.
>> If the use case is to sprout a fs based on the seed device multiple 
>> times, it's still possible, just unmount the sprout fs before mounting 
>> the seed device again.
> 
> In a datacenter environment, unmounting isn’t always a viable option.

If you're mounting the fs already, why you can not umount suddenly?

If you're talking about rootfs, it's no deal breaker, just remove the 
seed device from the sprout fs, then mount the seed device again.

> 
> Now that there’s a regression and a feature has been broken, let’s not
> shift the discussion to whether that feature was useful. I prefer to
> keep things technical—not personal—and I expect respectful communication
> to be mutual, not taken for granted.

I have explained the technical details enough. If you are not willing to 
understand, sure call it whatever you want.

> 
> Btrfs has some unique behaviors, and it’s possible we’ll need changes in
> the block layer or fs_holder_ops. That still needs to be figured out.

Unique doesn't mean correct nor sane.

And seed device is nothing special. If you don't want to accept that one 
mounted block device should only belong to one mounted fs, sure go ahead 
and see what everyone else thinks.

> 
> Thanks, Anand
> 


