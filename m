Return-Path: <linux-fsdevel+bounces-52720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C014FAE6030
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3A94C1AA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8218727AC21;
	Tue, 24 Jun 2025 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LCaVwYQ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD36727A12D
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750755970; cv=none; b=OBqJTc6lbrJ/0O8CqXQtOTRyNxVrs/azmXs9CLa45BgdB5mRdD5cbNEVIpBIXpudFrtFojzAvTynb+GlVH+62f4+1bksm+TOOlT6QalbLmTMkZjbxdBtbIEvhNyxMnygBPG5xTg88QBEMsFy9Uf/tTGNyg9yucuYuiuLzgiF8Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750755970; c=relaxed/simple;
	bh=uPhY5Zza+vkrnIMPgNzYziK32kqInkX8XjtgEE9coxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAoZ4xGdzeq+b8u5Ii/BSXylgHQ2QTZ0Ca/Z6VOpKTKaA9EOxDFYO3KtL7YcuP+PzOr3XyqWGyLpQjJPV27r52oEbHnawWrU8iwXvSPVdCcjXbev9xwvVPBedJbS+MZfV4m/kC7OjfFGiAD6eHdrqDGlhXUXin4RnP2sgWxla0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LCaVwYQ1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-453426170b6so36169355e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 02:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750755967; x=1751360767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DHWcoiAYJOa0+7KNnNcZSmg0oht47ewTSBLsTJYssfY=;
        b=LCaVwYQ1MxLzgg8zc0qzkaDLfbgcHqkyPScMTbVo2pLC3M9vLOrLDVYlF0zdBzbbuF
         W07A3e6mVFFOBjIRwHGCVXj7uc4+PC2vOHzjRKyd0f1hmpDDVr+Nrtba4AlNAVzspb2N
         0i/5cSB158tKH6fj1sbyb+qs1FW+xSqKkhJhaMFkVSkYItajmDkhkLNU1njuQpZ7+t0e
         4DN3lP7QbB66BK+N6tXv5PTE1y5NFcYVKZZZi3KpOy2UaNPmVVI46fuHflsZAYDUrrte
         oAUkzCmrdBb4ORgTerqX1avGXRaB1qujV1VIzB+N5rgQdgNNHySv/4WskroZn+V04Fnc
         xdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750755967; x=1751360767;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHWcoiAYJOa0+7KNnNcZSmg0oht47ewTSBLsTJYssfY=;
        b=TSJ1S+w07dAVqMdu9InYb5YhmvWKb0whpXYFiz/sxvm9BywlXkwtoaEISIxT1gwcnO
         KT7hdLWMR/nK+vZ/7F/GLrNdaDiluOA2gZvQpuU8yl4+eW2qEHGW0RWx1dIOAyWDr2Lb
         gtkIuDDYGYuUd+RGww2nCmxTOlto+S2IxA0av2Bx50cHfV4QndCEsB+Rn3jR3qvCWdnS
         hwJb4z5sRqoDDYPvylH9W5V1aOMnN5WK5/q/nNcBsThvzBRXSINaGbT8dCkb1ELNswp+
         VeBxm7ElYf4wWCW9GeOol+E2nLgC9ym1GoaRRDhOruslj9KAfy491P9P5CXh7K1+i6HD
         irHA==
X-Forwarded-Encrypted: i=1; AJvYcCWLCfx/IqL0kaUieOhH9FCGbh3O6jK1JwTXeHC4ktIi5rszCWYrjhxgIR8hAkLwixkeplGhFZpm7EIsIBrW@vger.kernel.org
X-Gm-Message-State: AOJu0YyMTz/3lhhSG8mAg1o8s1JpXuXlwXqceXLJaJe9p28ESTDYPAWu
	5Fil2pXiJsP4EpgcNew7dDuhLQyuEBsNo+ymcx4/5en8hENSI6rXBgAHz+G+s0Dv4k8=
X-Gm-Gg: ASbGncvH3miss8c1UgnHjSU4wPPBA1CJdaj/3nRq9f/ce/GSaPpF7dBV9G7x443IBeV
	yDlncMMqG8qlGsPcMKvHrpEc65XTupNJEI0YN3G21B4fVeg3m7tRoraR5m4u8TRpsoWzI9tqd7a
	ahf3lUK8mmO74XMjdZilPL7Bc+5IwaYu2befZESQXRkB119tEGql/6CtsoTE61sm7nTmbVrC/MF
	HGjOnVxL6v+g2rEnnoX7+PgxT8TL1DAerbdG9PMf6+E91w1KI5xVMv1W6sx81O8v2J6r8f4R0zk
	Np46zLpYxS0vN9qjUaVTQvqa+N01DUaawiASSEubWaU6MNKe9dOKXcVguKuM4/qUS0DU/8YCtKt
	zgg3kX96QKZK7tw==
X-Google-Smtp-Source: AGHT+IHt1CghqLrmgenA0n5fZVf5QwIrBcdRezEwkp7DF7SGAA3wlRjWDCdNhOIS5p86WcawFevWBQ==
X-Received: by 2002:a05:6000:430c:b0:3a3:598f:5a97 with SMTP id ffacd0b85a97d-3a6e71c5b60mr1850925f8f.9.1750755966919;
        Tue, 24 Jun 2025 02:06:06 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159df71ccbsm10270564a91.10.2025.06.24.02.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 02:06:06 -0700 (PDT)
Message-ID: <8db82a80-242f-41ff-84b8-601d6dcd9b9d@suse.com>
Date: Tue, 24 Jun 2025 18:36:01 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk
References: <cover.1750397889.git.wqu@suse.com>
 <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
 <aFji5yfAvEeuwvXF@infradead.org>
 <20250623-worte-idolisieren-75354608512a@brauner>
 <aFldWPte-CK2PKSM@infradead.org>
 <84d61295-9c4a-41e8-80f0-dcf56814d0ae@suse.com>
 <20250624-geerntet-haare-2ce4cc42b026@brauner>
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
In-Reply-To: <20250624-geerntet-haare-2ce4cc42b026@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/24 18:21, Christian Brauner 写道:
> On Tue, Jun 24, 2025 at 06:57:08AM +0930, Qu Wenruo wrote:
>>
>>
>> 在 2025/6/23 23:27, Christoph Hellwig 写道:
>>> On Mon, Jun 23, 2025 at 12:56:28PM +0200, Christian Brauner wrote:
>>>>           void (*shutdown)(struct super_block *sb);
>>>> +       void (*drop_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
>>>>    };
>>>>
>>>> You might want to drop a block device independent of whether the device
>>>> was somehow lost. So I find that a bit more flexible.
>>>
>>> Drop is weird word for what is happening here, and if it wasn't for the
>>> context in this thread I'd expect it to be about refcounting in Linux.
>>>
>>> When the VFS/libfs does an upcall into the file system to notify it
>>> that a device is gone that's pretty much a device loss.  I'm not married
>>> to the exact name, but drop seems like a pretty bad choice.
>>
>> What about a more common used term, mark_dead()?
>>
>> It's already used in blk_holder_ops, and I'd say it's more straighforward to
>> me, compared to shutdown()/goingdown().
> 
> But it's not about the superblock going down necessarily. It's about the
> device going away for whatever reason:
> 
> void (*yank_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
> void (*pull_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
> void (*unplug_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
> void (*remove_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);

All sound good to me, although the last one sounds better.

> 
> On a single device superblock unplugging that device would obviously
> cause an actual shutdown. On multi-device superblocks it doesn't always.
> 
> (That brings me to another thought. Is there a use-case for knowing in
> advance whether removing a device would shut down the superblock?

Maybe another interface like can_remove_bdev()?

It's not hard for btrfs to provide it, we already have a check function 
btrfs_check_rw_degradable() to do that.

Although I'd say, that will be something way down the road.

We even don't have a proper way to let end user configure the device 
loss behavior.
E.g. some end users may prefer a full shutdown to be extra cautious, 
other than continue degraded.

Thanks,
Qu

> Because then the ability to probe whether a device can be safely
> removed or an option to only remove the device if it can be removed
> without killing the superblock would be a natural extension.)

