Return-Path: <linux-fsdevel+bounces-66895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9F6C300ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 09:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D15428225
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 08:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75293306B0D;
	Tue,  4 Nov 2025 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FqZ+grCQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84AB23F412
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245800; cv=none; b=gNS0bk8dqyRlLQoNW6iBZhw6F39F4rE6rmVFM+t64/o88zKkj6cyvrt5zm0kcVqOP88/GNfbsO3EJynsU9z699tJHzi+maN7u8gsCE/8RyOkgY5QFEmrJgHbR5uek1xseIcanHbQY7E3KZX/7jmGAyUJJ6tuSv8fnJX77KrbIA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245800; c=relaxed/simple;
	bh=oEpqgo6w4sem31KrNmcSIDyP0O9Mji7qPKVGxGe9g+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/AX2Bok7CF+jcnqXNWMw2ryVLadpaFVEwR6frYUQ0h7ZJQwNw2Nd+PlNBbr9K2IFMiAcs4RkkEyRt7hmB+gjD02HQ9/ayg3mogqZohqTCSfjuC9q8MBx/77n9cvHIrY4h4pZW3PZ7gYIssktRMi9uJQfzMLxhj5mrt/bLk2jqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FqZ+grCQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42557c5cedcso3108462f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 00:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762245797; x=1762850597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z8OQg4vvlc5BcTYkkqIh24YPQrHZD74zjRaHktvoOPw=;
        b=FqZ+grCQtdDbquUCHGroV589Y/PJh4GWAE304StP4BmP/bVlELIy4Ax5H7oTbKKRbb
         UNhD33NHMrDf4DSx8+XzrtS9W4Zk72JVCzCt0nqFwLCRDcPdl2b6ssAm6y7G7JGpIYJE
         kbEICWb8hXfJpaPhZNeGExJCsB3/eTMy654/1o/R4CgWk1xSvN9mrZlDOWlW8QK/FywP
         xQAH5lH7b+gXX1WRVCS1kZL0TJCHLd/cQcgdkbByWUK5Hh1NubSY/BTBbCl58wTpQydO
         OsJ16N4FPG4vREaDw3bzjFcXHUh53BhaD5TAiFCbFcurhB9CFUQeEj+vmC6sGrh1R60H
         0jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245797; x=1762850597;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8OQg4vvlc5BcTYkkqIh24YPQrHZD74zjRaHktvoOPw=;
        b=v3lRKh6G/4Y+irYjTT7ktlZ7GjjvK693mMOZmN67OaXLiDA/Bsfl7qHGd7xRETay9X
         dXaByKHAsrUnoKlZj8bEUdLruEDoXDH9LYIyFbx0jUusHFaXa00X4KgsVD7TuHQ+dpQh
         5cgmSYsYWcaB0xFuZtMOxtJ4U+SdjxKE3IuAtUHfn1ODqR0YcfaH4oSFeTd7Y81AVWPC
         aRY0uQBKfvgbvHUAbIWcGE375sD/T1FAm5MJBgTbTFGb6lR8TCSbPQ+pR6lYlG9LMF4m
         bdjjG/8swjBF9N60DtVhzLfR3zBXMErfIp+jON16J2Z2aIrk7q3G1idosmnAk5aiLKzQ
         Fi/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW52CvuI9Y2sXEin8vhlo1gplFZGatsotiEuEjrYL/m3RXVlj1ij19awUEJVVM7Bg80jRplhJTZPe4SCql+@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUFtL24JVxU0KPyIALmYzF+5xpqM7DqcjLu8DpBFdSRHt05W6
	VPq+9NdlcbE1vARA4QRSBHqKuRBvibRw/EK3AtZlFB8qNCJAhX+Bv7yhBFoJQ2wlAL8pufLcGd4
	s3eB1
X-Gm-Gg: ASbGncuXhXnb6QjFTJHVJa2RCgiyGCV4/J8EYCBClpbVMIyULmiYLpFefyGByLshZnV
	Cz/PLsv3D81LH/nuUWIAdhQfh1ARmsMaQi41UV+Fj2GKNga62/p6QFoWcp0npVDfBJV/RW987tH
	cXTgf1lV43XW/GSrDJKhuEt4ST8qsGWNDZjiu+8SdmygPUOdqIPzms2teuv01tow8+7Z1f+9TGl
	RpcosvK94L8VN+Kl0CRh2avhGrF8CbfPavzYyf5Vgo4mCyi3t4mWAgEvYFM6lYxN6nkkb12SuX6
	4IaneBJu7JR5tTghl2ALxRUHq8psVzjUUagJ/Aw8Xi16xqOO5ahdRnj71dpthv73gGjam75y/M7
	NUovEX5QZZeVMdQ9wwm/PP0iN6pjDCL1GQKM/wu2J4atchnhIVWUoDLiYSr/6tTRCkkfvaRDIsM
	Fh6A3H0G6C4EbQ47j495k3j4syjrGS
X-Google-Smtp-Source: AGHT+IHcxVMLEjsCN3tP3SOCmhMrXVcx1aq4U0rFYWNl4ESqrNLr0Wbr2a7xCOUr/03qng5mxWtUpA==
X-Received: by 2002:a5d:59c5:0:b0:429:c66c:5bc9 with SMTP id ffacd0b85a97d-429c66c6504mr8548058f8f.27.1762245796719;
        Tue, 04 Nov 2025 00:43:16 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6823f78sm2034186b3a.63.2025.11.04.00.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 00:43:16 -0800 (PST)
Message-ID: <414a076b-174d-414a-b629-9f396bce5538@suse.com>
Date: Tue, 4 Nov 2025 19:13:04 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] fs: fully sync all fses even for an emergency
 sync
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 Askar Safin <safinaskar@gmail.com>
References: <cover.1762142636.git.wqu@suse.com>
 <7b7fd40c5fe440b633b6c0c741d96ce93eb5a89a.1762142636.git.wqu@suse.com>
 <aQiYZqX5aGn-FW56@infradead.org>
 <cbf7af56-c39a-4f42-b76d-0d1b3fecba9f@suse.com>
 <urm6i5idr36jcs7oby33mngrqaa6eu6jky3kubkr3fyhlt6lnd@wqrerkdn3vma>
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
In-Reply-To: <urm6i5idr36jcs7oby33mngrqaa6eu6jky3kubkr3fyhlt6lnd@wqrerkdn3vma>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



[...]
>>> On Mon, Nov 03, 2025 at 02:37:29PM +1030, Qu Wenruo wrote:
>>>> At this stage, btrfs is only one super block update away to be fully committed.
>>>> I believe it's the more or less the same for other fses too.
>>>
>>> Most file systems do not need a superblock update to commit data.
>>
>> That's the main difference, btrfs always needs a superblock update to switch
>> metadata due to its metadata COW nature.
>>
>> The only good news is, emergency sync is not that a hot path, we have a lot
>> of time to properly fix.
> 
> I'd say even better news is that emergency sync is used practically only
> when debugging the kernel. So we can do what we wish and will have to live
> with whatever pain we inflict onto ourselves ;).

Then what about some documents around the sysrq-s usage?

The current docs only shows "Will attempt to sync all mounted 
filesystems", thus I guess that's the reason why the original reporter 
is testing it, expecting it's a proper way to sync the fses.

> 
>>>> The problem is the next step, sync_bdevs().
>>>> Normally other fses have their super block already updated in the page
>>>> cache of the block device, but btrfs only updates the super block during
>>>> full transaction commit.
>>>>
>>>> So sync_bdevs() may work for other fses, but not for btrfs, btrfs is
>>>> still using its older super block, all pointing back to the old metadata
>>>> and data.
>>>>
>>>
>>> At least for XFS, no metadata is written through the block device
>>> mapping anyway.
>>>
>>
>> So does that mean sync_inodes_one_sb() on XFS (or even ext4?) will always
>> submit needed metadata (journal?) to disk?
> 
> No, sync_inodes_one_sb() will just prepare transaction in memory (both for
> ext4 and xfs). For ext4 sync_fs_one_sb() with wait == 0 will start writeback
> of this transaction to the disk and sync_fs_one_sb() with wait == 1 will make
> sure the transaction is fully written out (committed). For xfs
> sync_fs_one_sb() with wait == 0 does nothing, sync_fs_one_sb() with wait
> == 1 makes sure the transaction is committed.

Then my question is, why EXT4 (and XFS) is fine with the emergency sync 
with a power loss, at least according to the original reporter.

Is the journal already committed for every metadata changes?

Thanks,
Qu

> 
> 								Honza


