Return-Path: <linux-fsdevel+bounces-53069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2538AAE99C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 11:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40FA1C24044
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5201F461D;
	Thu, 26 Jun 2025 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P5fgKDa+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1F1C7005
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929518; cv=none; b=NyaeBD2VLdcoALoFzbIFMk3ELRvu+iIdhp9csbnZN+/UFDARv9P0tAEE2/ldxqOt0PUGF6A1OuMqP4AMw8cBrU1wrjV0uLubh6NTImM7n7tE8QDrkP9JCm6DcD0MBEbPe83dAp01jPMW38pCb90uAoP/5nc6qDYZg8ag3J/2774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929518; c=relaxed/simple;
	bh=4q/7WtNfp2ZqEhqqzUo/NJxuU/TI/2QvHKkAb56VYdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8m5yPi4ev98kzkX6isyi7nSRKHFvrM9/AoejWSE0YT0BsB6WJLaHSwvKG6HxD10+oS+gIy91+JzDFDOtqqjsw4kuMkfjO3Ieyap12TmxWjpN0gi81rT5azrpI89GnVAT/arVh6mbT0jsqOrNKNxUbQNSqNwlIi6PX6qRznC3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P5fgKDa+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso596452f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750929514; x=1751534314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c6W4wlDqiomgp/Jq1hQYkIQoYQUhsw/H9C2s89PCdfg=;
        b=P5fgKDa+Gqq8uSpZCnYleZZblcK8D79AZtDdJtfkQbbiXVnXkc49UK9Bq/93ZLLUh2
         frm7S8fLmoyp4stmAnoUdf9Q/pDUxSqbWj/iQaxUnfmpAFKCyvmM8lwMSVy25hxNEbcG
         S6cF4uKM/nSwr/HHObWP6cMLSps+a0Te85kPqUNI0UMbql57ogrpOrxZAqn+uPQ8P8mQ
         Bqu4bDg6ibh7Ym9n461c1nJbfjVLR49AypIpJpAHJNTei0QVz0xuNiN6t4Q6Cr8yNpss
         Ow6CIcA+/mbtU2jvF4AJhMPT361ueq22hAq5whMRz7unbMXfpvrWBNdETcEmum9z83G1
         8yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750929514; x=1751534314;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6W4wlDqiomgp/Jq1hQYkIQoYQUhsw/H9C2s89PCdfg=;
        b=wHQsu1nUwfYQgLRN/J5SBQNfH01AWxr5pmpI04XJaAyrwZpeHQ8REE/sZD4s9camWi
         wpFBDJL62PAr60OBHe7/iJk5ygEreGda2Ur8zWzpOQccHHGmzuy9bQhVKtthdQ/btPYm
         8ycXyl+MNN5L8vNi3IqHoOm08/eEJgehlS5qy3Wv+1Unl26IyWt4WuGu0N42+gmmTKWC
         rzbwvv8RTn2GsMaj3O5U8jqZQZpuuQBMm5bPCUCaem9ynb854cgaVFIQ0Y8WBHIuoKii
         vDEJeo0EuT+3kHMferluz9F8FZI17U3azkxPVcQWeI0RqkKZyJeCVrBgJMUjWPGh+b+Y
         C+tA==
X-Forwarded-Encrypted: i=1; AJvYcCU6XnMd6axVoR7O9wwIsgJoog1qmkcbgdhWbTsY5Yx4PUjmHpckb45j7gQVg1TLAmhvJCpnXLUc4pylzJN9@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAeV9U6fJN2h2iv8MTf2cOTnc8IEauArqLN2TTcNSOnZkgSWq
	IWP9bQfb6grElfeGL+kcuK32+MsVlLcx70AiYGcG8NDL0fRacFvoriwu03BTgnGZVyw=
X-Gm-Gg: ASbGncswcnOGqk3fHjFBs2TKZNDiSwB4i960mUKAY8khDiKEMVirrf7zpbua3bxAGPx
	hMD5Z99E0xXwuxu8lwEFilBet0VAAjTAfy64rLzqu5pXE8C1lzDsOZ54iJAjHdwl0AHW3AMSZk9
	cZLQtkcCl5pQmYDhAy2zKoqSjrz8AEhUYo7FI3Mfn4Oq9Hw2yxZPkvDOgiPz9wiI8f0cFeHVhyw
	cemU1h0Tzis3f1X3Xf/YaJWEsyrJD0KC3og8yc4BX4XDesGT9qLNEQFnAOmFlYWsEzMf9P4QCBM
	Uh/iK1XZUbmHrW/G8HKQ5awO6xcDLyZyM6nzzzBoW80SGT5yEuG4FT0OPV26feYHSiX0Z8h3YmC
	Ktx9N+WSc3RDb+g==
X-Google-Smtp-Source: AGHT+IFAmnjJ1pjUbU6WkCuamLJK9N8VeYcd0XVx+r04EarjM02GChLGl7kM32anWrD0BGbJoTJFqg==
X-Received: by 2002:a05:6000:25ca:b0:3a4:f379:65bc with SMTP id ffacd0b85a97d-3a6ed64a81emr5288789f8f.40.1750929513973;
        Thu, 26 Jun 2025 02:18:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5383eb6sm4034185a91.10.2025.06.26.02.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 02:18:33 -0700 (PDT)
Message-ID: <fd3d7d4a-ebad-4ec2-8a9b-4bf783034a05@suse.com>
Date: Thu, 26 Jun 2025 18:48:29 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] fs: add a new remove_bdev() super operations callback
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
References: <cover.1750895337.git.wqu@suse.com>
 <c8853ae1710df330e600a02efe629a3b196dde88.1750895337.git.wqu@suse.com>
 <20250626-schildern-flutlicht-36fa57d43570@brauner>
 <e8709e52-5a64-470e-922f-c026190fcd91@suse.com>
 <20250626-fazit-neubau-ef77346c5d8b@brauner>
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
In-Reply-To: <20250626-fazit-neubau-ef77346c5d8b@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/26 18:40, Christian Brauner 写道:
> On Thu, Jun 26, 2025 at 06:14:03PM +0930, Qu Wenruo wrote:
>>
>>
>> 在 2025/6/26 18:08, Christian Brauner 写道:
>>> On Thu, Jun 26, 2025 at 09:23:42AM +0930, Qu Wenruo wrote:
>>>> The new remove_bdev() call back is mostly for multi-device filesystems
>>>> to handle device removal.
>>>>
>>>> Some multi-devices filesystems like btrfs can have the ability to handle
>>>> device lose according to the setup (e.g. all chunks have extra mirrors),
>>>> thus losing a block device will not interrupt the normal operations.
>>>>
>>>> Btrfs will soon implement this call back by:
>>>>
>>>> - Automatically degrade the fs if read-write operations can be
>>>>     maintained
>>>>
>>>> - Shutdown the fs if read-write operations can not be maintained
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    fs/super.c         |  4 +++-
>>>>    include/linux/fs.h | 18 ++++++++++++++++++
>>>>    2 files changed, 21 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/super.c b/fs/super.c
>>>> index 80418ca8e215..07845d2f9ec4 100644
>>>> --- a/fs/super.c
>>>> +++ b/fs/super.c
>>>> @@ -1463,7 +1463,9 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>>>>    		sync_filesystem(sb);
>>>>    	shrink_dcache_sb(sb);
>>>>    	evict_inodes(sb);
>>>> -	if (sb->s_op->shutdown)
>>>> +	if (sb->s_op->remove_bdev)
>>>> +		sb->s_op->remove_bdev(sb, bdev, surprise);
>>>> +	else if (sb->s_op->shutdown)
>>>>    		sb->s_op->shutdown(sb);
>>>
>>> This makes ->remove_bdev() and ->shutdown() mutually exclusive. I really
>>> really dislike this pattern. It introduces the possibility that a
>>> filesystem accidently implement both variants and assumes both are
>>> somehow called. That can be solved by an assert at superblock initation
>>> time but it's still nasty.
>>>
>>> The other thing is that this just reeks of being the wrong api. We
>>> should absolutely aim for the methods to not be mutually exclusive. I
>>> hate that with a passion. That's just an ugly api and I want to have as
>>> little of that as possible in our code.
>>
>> So what do you really want?
>>
>> The original path to expand the shutdown() callback is rejected, and now the
>> new callback is also rejected.
>>
>> I guess the only thing left is to rename shutdown() to remove_bdev(), add
>> the new parameters and keep existing fses doing what they do (aka,
>> shutdown)?
> 
> Yes. My original understanding had been that ->remove_bdev() would be
> called in a different codepath than ->shutdown() and they would be
> complimentary. So sorry for the back and forth here. If that's not the
> case I don't see any point in having two distinct methods.

That's fine, just want to do a final confirmation that everyone is fine 
with such change:

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b085f161ed22..c11b9219863b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2367,7 +2367,8 @@ struct super_operations {
                                   struct shrink_control *);
         long (*free_cached_objects)(struct super_block *,
                                     struct shrink_control *);
-       void (*shutdown)(struct super_block *sb);
+       void (*remove_bdev)(struct super_block *sb, struct block_device 
*bdev,
+                           bool surprise);
  };

  /*

