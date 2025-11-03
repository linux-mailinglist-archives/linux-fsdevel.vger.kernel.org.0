Return-Path: <linux-fsdevel+bounces-66860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6A6C2E10D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 21:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF1C54E15E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 20:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908042C15BA;
	Mon,  3 Nov 2025 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EAcTXB9L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17222C11C2
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762203316; cv=none; b=VuWszM7RzAtg8J7N6lOeozJeQmK9afZPpRpNN4DKqEgi0qMbcK+gBkl37EF/7MTdE3qS+M+m2+UTGOkg+2cR2Fm1JtaZNT+ImyP45UVSaevy8x4wiXuaOS3bjHnZxCSRRGhl+ybdM0AHca3++R7iBJLuibqA5kN3gV4jyKhBM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762203316; c=relaxed/simple;
	bh=j2ka0Du304eFSI3URmzk7ROBpiufWYwrutSpwJmt+gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2PSvVHu+kLIcOm1ZHWYEHPSHF4yinUWUJnhbqFB9nOsObU+d+aVtcVX2iHHXyv1+Vaol/TQW1rVUTKdoqa7wip4R9H5Zq6WConLrhMseaVQh0U9j6jn1KWWxsEcAO1TVbebfoh1aD1qfZphqs6KamWZmyoAp9rrVVLUhlnT2gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EAcTXB9L; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so33032065e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 12:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762203312; x=1762808112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=maeRjX1obKpA9rcTHZvyJjqqJETjy5RwGnFRm5Xcm8k=;
        b=EAcTXB9LcG0MIvCwVh1WFsdCeY6ltP07VDDPyOg+VAzQ+H3hUzsHEc2XKi+w7kTrWO
         POixBNO//7AXQH/3eZaWpI8U9Ga5ijbwt0G1MVvhF7cNWRoIkv5FfkFYkqy5l324jHSM
         pahRmkW/T1DjDRkBMF+AreR5csKnhATgheHGkfeKV6+Oxi2KRllghmOsufd/TsT2kbzI
         Kvt+JiKAzO/qKF8R4CSQ51Ty6QLOCZucRqaPiCk8xcx7U/I2NqV6OmjXY6HcJq5YD7MH
         EqvbHNYqKGUXTyToGZFlwBdsSSD2ACzdJoMd4tQGuWIyD2G98G7OLuzEhBwc7r6xppM6
         IFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762203312; x=1762808112;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maeRjX1obKpA9rcTHZvyJjqqJETjy5RwGnFRm5Xcm8k=;
        b=SUHXq50kT6IEX/vI66UwuUca04gzAoR2Y3bPaTyszLi63mBiWnNuzHEQA+EpcdUOqZ
         WN0GKI2BmWfnoKY2cUeiDcSaulkxXxLznmW7Iv3fJxQXlETy8c3KhssVHIlGUpJNTusv
         jHmTp8J5JM9nNcgIu3u3FQN6moZchoUx5Ub3SnEm6ykT6X0EbyB/zQBw7vnF7dJVoGHd
         XcS3dp2YWmfMGXvAt1PG5IJkBVgKjZKPOVZV/UOjvQmPPL2bsivujZdNqh63TqlfMFY/
         pSI1IOqDFDh9Rfv6J1MAwd/e7KTf01EJ4imU9cez5Y03Hz6UR2ZEyIc1HcnkRUyuvco9
         PQNg==
X-Forwarded-Encrypted: i=1; AJvYcCUrTKOYWpEGTVPulOvTsdUEfweynIq9otdVWeMD/BjtKfTFwLxZcZZksqunkp02pi4KIUNuBzSRoVY3AZGR@vger.kernel.org
X-Gm-Message-State: AOJu0YzrwMF3GjaqA4FWI9X6dN25tQiH9dg3/Rn2Yr2sQ7DkFatlc4U0
	S0yDpqzc4UClt9nyAzyLhyEztLbJjGUsSbiK6jkGdj+uA9YKPg1LRIZTm5/xkXAVHgU=
X-Gm-Gg: ASbGncss9gPQQvXHEUjGLGi5GDwT2uAwBWQAlEs+yTdOCWToPY/4pWoVErTvUlCrTOt
	GcO2Uc0puGJTem7abYW/L+fBJ9mn8yIlq0O/gRZamXI9y9r9zSrJFxk05l7oecgeVaq6hokBmub
	zsMpu1yRt05afrJW68Q2+jmuBykvcSukuvuyz+1dAiGksTbJp9LgIc3P2UTaEAT2ZZSj/Ydm+/J
	XRYVahDEqdZrwsxpHzraCQH0PVcAd+BCcQXc/zsjHes9T9UOR7+zaeVOqOYDs3zC1j02weCKfHT
	znsZByzQs5yZ/Xp+9Te/20RC5bnePEVF4S7BVjjrP7/j1U4VhLXpYYePiqENTIvJDEk5juyI9C4
	/qfTFRNeXzH7F2uYPE69PqTlmoGImFjKTu9VEIIhjOyPvwDffNjSFZDQx/PNGNuPbHMe8tQcrp6
	UyJRRUWE5syO6WDeFCB7Dj/+nMZXpTAyAMq3VswcI=
X-Google-Smtp-Source: AGHT+IEKmdFdDLRL0MpaKaBKWM8pPd65NhFlvW6yDCYoa7VcttAa1gHqo3eQEjKzWWMrrpeoxZkZcw==
X-Received: by 2002:a05:6000:3108:b0:429:cc35:7032 with SMTP id ffacd0b85a97d-429dbd10259mr612205f8f.23.1762203311977;
        Mon, 03 Nov 2025 12:55:11 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599f14c6sm2076927a91.10.2025.11.03.12.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 12:55:11 -0800 (PST)
Message-ID: <cbf7af56-c39a-4f42-b76d-0d1b3fecba9f@suse.com>
Date: Tue, 4 Nov 2025 07:25:06 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] fs: fully sync all fses even for an emergency
 sync
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 Askar Safin <safinaskar@gmail.com>
References: <cover.1762142636.git.wqu@suse.com>
 <7b7fd40c5fe440b633b6c0c741d96ce93eb5a89a.1762142636.git.wqu@suse.com>
 <aQiYZqX5aGn-FW56@infradead.org>
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
In-Reply-To: <aQiYZqX5aGn-FW56@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/3 22:26, Christoph Hellwig 写道:
> The emergency sync being non-blocking goes back to day 1.  I think the
> idea behind it is to not lock up a already messed up system by
> blocking forever, even if it is in workqueue.  Changing this feels
> a bit risky to me.

Considering everything is already done in task context (baked by the 
global per-cpu workqueue), it at least won't block anything else.

And I'd say if the fs is already screwed up and hanging, the 
sync_inodes_one_sb() call are more likely to hang than the final 
sync_fs() call.

> 
> On Mon, Nov 03, 2025 at 02:37:29PM +1030, Qu Wenruo wrote:
>> At this stage, btrfs is only one super block update away to be fully committed.
>> I believe it's the more or less the same for other fses too.
> 
> Most file systems do not need a superblock update to commit data.

That's the main difference, btrfs always needs a superblock update to 
switch metadata due to its metadata COW nature.

The only good news is, emergency sync is not that a hot path, we have a 
lot of time to properly fix.

>> The problem is the next step, sync_bdevs().
>> Normally other fses have their super block already updated in the page
>> cache of the block device, but btrfs only updates the super block during
>> full transaction commit.
>>
>> So sync_bdevs() may work for other fses, but not for btrfs, btrfs is
>> still using its older super block, all pointing back to the old metadata
>> and data.
>>
> 
> At least for XFS, no metadata is written through the block device
> mapping anyway.
> 

So does that mean sync_inodes_one_sb() on XFS (or even ext4?) will 
always submit needed metadata (journal?) to disk?

Thanks,
Qu

