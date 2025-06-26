Return-Path: <linux-fsdevel+bounces-53067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8F5AE98C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 10:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E834A6A1188
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 08:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443C02949F0;
	Thu, 26 Jun 2025 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TdnmqeC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7B29290A
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927453; cv=none; b=tI7+voLHOuvcOLopsAYFo64GdC/F8fgpbVYikvy2xzgzCN8laPAtzO4W67nXkQMuXYch9tU1uRWGZu7un0CYi690BfALtne0GTUVdIVDTk5Oeqbw95MlH3NdG9TC2KKSuK1fz2op/jXvcnN8wSex9Oxp5mgTIjq+WZUmXLtQg2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927453; c=relaxed/simple;
	bh=8L5ExMvo6qk/tsjlQvMmvrihPQ//4a20pMuZToIOlwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uifCHmVOHXCNU3Eb/6NexlTdUE8mcZ6qwm99soq/96kR+dKYPwM56+WLYbiZ1iPhHGQEd1XuCqC6aUARkqglaqJ4K1vroXN5A43R8O159jAv4FQJayMutHXCD4fDjEpi1I8T/qWS6JQAXBIPCgqsHj0+OXpbZO4MZKYc3wBEAlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TdnmqeC/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a510432236so539206f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 01:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750927449; x=1751532249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jo5462XH/J0CHUJB31BqUZLvosDDfk454xCnbCM4JXw=;
        b=TdnmqeC/cwvnbrvp4wo/NBWCQqXdSgZIhztYw/lhu7hAoHTkcOEXNzrAeXKMDGMK8K
         v6XpxMZMamSqM0v5EqpSKW94CKp4Mn4/RcqtqhAoUHgaFY02Ze0MvwKK/fRSXWm74cV4
         k6znBPV2oaPjnuBt9H3uwWt6+XM64x3gb8jJO75g1y+yP/W+hG6zdomHTmRGAw2feQJV
         lL4IlgeJRcDkIxCWHV4kO/5ZvX8dYMjQwm7lI+haBCKEnL8lz46sE3sddP7Pu9/qKtNJ
         yLi5gvDDaMaQHUR8Ngwk2sOEI4BHOs8JT6qnANN5mN0o4hIwwkZJBusKuatquvJwX6XP
         T9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927449; x=1751532249;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jo5462XH/J0CHUJB31BqUZLvosDDfk454xCnbCM4JXw=;
        b=O4LCO3Yp6ESjTuE/i7faF3Se8T/Ne9E+/QaqqWCOVzsLeSrtwCSL2ChZ2eVqpl7SsU
         dwqHlmM5o7N/T/ZOwJRDihgjKVrHOIhr/T4/g/YKRjs4zzdIpO7dmrMnY1M1xvg9CprJ
         AIqh1Lyf6yaT/LIPvrrDldcUjQXMl3DBnVHaRy0wORqetqJAr63pLgLtvE0N4AEbrtk7
         X1+C0WWvhc5N+QPH/c86r2Rl98m39Aemn/IaL1xLnLGCKZdNv/qjM9cB608vZSGuwQnL
         eQKXB16gh+7LnjMt+h+CX9e92BF7N+DGHVa8pqtWwUHRU0FvYlIvShvKENKr9Pxsaabk
         I8CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgef5tFZTwNhhYOqIkRyXZzhmbkb3Xv+HmlORHPNylAudeUDRIRD1U/yu9sLEpRqJsZWzJNnEbfMCjNcKH@vger.kernel.org
X-Gm-Message-State: AOJu0YwzOBZhUNiGszWV88HpxVbUtEn3lxOz+GsWldhdWIFXcwgh4pRd
	sdFv8ibrRqsV8LSn6B1auJR/lcNeOnGccvrN/Mrfia5LtNegVBR/pZ9GkZBl02Jm6P8=
X-Gm-Gg: ASbGncvi6/W/AkfUjGW2qr7DDr4GCs6+XkuggyrMklqnWOlKMvT+3QgXudevnIco7J9
	Q4201kOh2JLDuMThiY9rn6WivjRUV8E4d6O6llcDQRzLc+HpnCLplLlxO2cQ2ZZqvOEWUTFIosq
	TBfKV5oCaqIZDIIiBG2bKl+v972c/C6t+0LxSlHBgF4tCIaizQ/WCiyuHAoSNNjku66CoVyCWIL
	G8VgOuTmTs7e7UG81/mZ8fmmElZjjjLnTW4yhYpgr1VUREJGX22CGeYIDZmmPsYicMPCqWVba+V
	z/73RSOPNqg69H0L+z/M2s16nQpwKXO+xjsqHfJBvfmZjN7LnOTueccZytOVZbrwxWrSeEsFFP7
	uwQ6alSuPsHatZw==
X-Google-Smtp-Source: AGHT+IEI2rVsRnZF2+YQ3sLqXU0Ra/H0nMwmAvU5nnF4ULUMVCZ2weL1T3HAxnDrGePI1CEgfuWmvg==
X-Received: by 2002:a05:6000:2410:b0:3a5:2ddf:c934 with SMTP id ffacd0b85a97d-3a6ed644198mr4469901f8f.30.1750927448280;
        Thu, 26 Jun 2025 01:44:08 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83f14adsm158539755ad.82.2025.06.26.01.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 01:44:07 -0700 (PDT)
Message-ID: <e8709e52-5a64-470e-922f-c026190fcd91@suse.com>
Date: Thu, 26 Jun 2025 18:14:03 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] fs: add a new remove_bdev() super operations callback
To: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz
References: <cover.1750895337.git.wqu@suse.com>
 <c8853ae1710df330e600a02efe629a3b196dde88.1750895337.git.wqu@suse.com>
 <20250626-schildern-flutlicht-36fa57d43570@brauner>
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
In-Reply-To: <20250626-schildern-flutlicht-36fa57d43570@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/26 18:08, Christian Brauner 写道:
> On Thu, Jun 26, 2025 at 09:23:42AM +0930, Qu Wenruo wrote:
>> The new remove_bdev() call back is mostly for multi-device filesystems
>> to handle device removal.
>>
>> Some multi-devices filesystems like btrfs can have the ability to handle
>> device lose according to the setup (e.g. all chunks have extra mirrors),
>> thus losing a block device will not interrupt the normal operations.
>>
>> Btrfs will soon implement this call back by:
>>
>> - Automatically degrade the fs if read-write operations can be
>>    maintained
>>
>> - Shutdown the fs if read-write operations can not be maintained
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/super.c         |  4 +++-
>>   include/linux/fs.h | 18 ++++++++++++++++++
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/super.c b/fs/super.c
>> index 80418ca8e215..07845d2f9ec4 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -1463,7 +1463,9 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>>   		sync_filesystem(sb);
>>   	shrink_dcache_sb(sb);
>>   	evict_inodes(sb);
>> -	if (sb->s_op->shutdown)
>> +	if (sb->s_op->remove_bdev)
>> +		sb->s_op->remove_bdev(sb, bdev, surprise);
>> +	else if (sb->s_op->shutdown)
>>   		sb->s_op->shutdown(sb);
> 
> This makes ->remove_bdev() and ->shutdown() mutually exclusive. I really
> really dislike this pattern. It introduces the possibility that a
> filesystem accidently implement both variants and assumes both are
> somehow called. That can be solved by an assert at superblock initation
> time but it's still nasty.
> 
> The other thing is that this just reeks of being the wrong api. We
> should absolutely aim for the methods to not be mutually exclusive. I
> hate that with a passion. That's just an ugly api and I want to have as
> little of that as possible in our code.

So what do you really want?

The original path to expand the shutdown() callback is rejected, and now 
the new callback is also rejected.

I guess the only thing left is to rename shutdown() to remove_bdev(), 
add the new parameters and keep existing fses doing what they do (aka, 
shutdown)?

Thanks,
Qu

> 
>>   
>>   	super_unlock_shared(sb);
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index b085f161ed22..5e84e06c7354 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -2367,7 +2367,25 @@ struct super_operations {
>>   				  struct shrink_control *);
>>   	long (*free_cached_objects)(struct super_block *,
>>   				    struct shrink_control *);
>> +	/*
>> +	 * Callback to shutdown the fs.
>> +	 *
>> +	 * If a fs can not afford losing any block device, implement this callback.
>> +	 */
>>   	void (*shutdown)(struct super_block *sb);
>> +
>> +	/*
>> +	 * Callback to handle a block device removal.
>> +	 *
>> +	 * Recommended to implement this for multi-device filesystems, as they
>> +	 * may afford losing a block device and continue operations.
>> +	 *
>> +	 * @surprse:	indicates a surprise removal. If true the device/media is
>> +	 *		already gone. Otherwise we're prepareing for an orderly
>> +	 *		removal.
>> +	 */
>> +	void (*remove_bdev)(struct super_block *sb, struct block_device *bdev,
>> +			    bool surprise);
>>   };
> 
> Yeah, I think that's just not a good api. That looks a lot to me like we
> should just collapse both functions even though earlier discussion said
> we shouldn't. Just do:
> 
> s/shutdown/remove_bdev/
> 
> or
> 
> s/shutdown/shutdown_bdev()
> 
> The filesystem will know whether it has to kill the filesystem or if it
> can keep going even if the device is lost. Hell, if we have to we could
> just have it return whether it killed the superblock or just the device
> by giving the method a return value. But for now it probably doesn't
> matter.


