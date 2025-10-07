Return-Path: <linux-fsdevel+bounces-63566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F81ABC2BE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 23:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F0D3AF87D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 21:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E212475F7;
	Tue,  7 Oct 2025 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KCPijHzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4323623C38C
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 21:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759872491; cv=none; b=OlSva3RbR1XYapVIF2U6NEZ4MI6P0hPE0Iehr/cIU+SU4C2LMCzWybwVTnup3efhpJOViMSofxCJamOs0hkXa/s0CNSFsBLlA/6plztVqERtp1PpAjA9j72BZ72LpYWP1petmN8l0eWL7EIWhU68YHTU1gyQZk6GC21tjv232NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759872491; c=relaxed/simple;
	bh=pLO7rkTsoQ2oSd9v/1H7hskqPCX9Z2MtYRiTmkLXaAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSEJnyS6sqT2y7350HWUBe1gd+fysjlmTchuA2i5oTZoxQbobyrLN+dr6NHaoXQwX5oWI4KmrfdfVpnVmiV7mSCOJQXzlUu/b6aW0suKLEJvV8dBrkAflgiGQXoAFqefIP8e5Qv9qYdng5u+CKFa5M4dTmDK5L/MBDjoohkOJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KCPijHzW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso5168431f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759872487; x=1760477287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rsucf0vVsobG12gzxy2S7+2oOr6aeTIDSUzvjBpxYqI=;
        b=KCPijHzW9Acs6Id6BUsHiwyCQjPIZMuVVHHyRhw0fq0b9pWWouKR99+fzcuQWFDy3i
         3DJ9MwVd6LmwmjVCsYPhCvfc3giNuKIKPW1ReJGUxT8ONdY986NK784UM78sp22QtmZz
         bZclCq45KJnHgWlRAmngPcx9PiR9gQek4A0BvHam9AmOeNPO3Lk0LrnHos5CY7pgeOVC
         OGM75pIJt2CRXN1lBL9jEKF7RdywNGjWIRV2M01qvmmdmRBJdkolgELVIIATfpOUwup1
         sduAOGzkPhgCMS59FKwbCGWFxS+BOqvPs7Imwo0dWRanj6E4sPLwsGUepjscMxzmF4fz
         m0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759872487; x=1760477287;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rsucf0vVsobG12gzxy2S7+2oOr6aeTIDSUzvjBpxYqI=;
        b=ed7mek/ttI8RiF4UKClM8DjaX2YT1MGMONJHuQJXDWHgcQpNLf349SjPJRn6xf3ey/
         CJXVFDXK2AvYAfH6ni5Z8H0AOurWbtE5a+aC0MoBLMMhpJe4SIClB16lcZ/UQzFFFgWL
         Amfd6GCLf1IhnOcn2+UOSB+BHGeq7tlFsqyUh+vwt20lHQst/yCwxJ7C9zej9DWvSfMQ
         VDTDqxClk8iDzJE25TFAN/B0Ygw5Q8SOmTmh7ayGaCoL2/mJa/xTjFHB2Um+/8o+1/hl
         NzG6+tKa0+FLQLBYk7Q3lBdndVS+4wJuAQP3Gq8e50VhVodQ3qjwGBfdvb7ir1F1rN0W
         9HYA==
X-Forwarded-Encrypted: i=1; AJvYcCXzpolYv5Peh4PNm7SMokq2RVaAWWea5kFaAMiifJNyDZ9NUtv2Xxawpp/TtyfF3toEV+EwaihkXP5/gH29@vger.kernel.org
X-Gm-Message-State: AOJu0YyiMwdjvxZMV6RkB6Fz/wNRazxWI3tQcvzVTBZRZxgVAd/cGG04
	9JQmNVrnkb5gg8f24bZ6R9Tl8zRbCrlPsIgqhBdR6w9o7IGx8EPNHlDBnwbOFonF9Ac=
X-Gm-Gg: ASbGncu5ZRhPfN1I0MmrWgPrtvswSUu386X17K0NrY5WWvtHZj4TBELsNI1KF8AtDRZ
	zFHlyHv5C/H4es6uQ8xUxcIkIznWGpo1XAhEOQug5NURYIZe84vfvWCjPNY/SNbwW3Wgc505v+A
	97gfSXKUcu7bLKR9dbDTOg0jiyPIoUuzgpbKYr5cuB1w9iBLy1g3lqLHwjExA6YM2smcSJ0lHtA
	FIjhlt6MHpqCp9lvshJoMZQf9p+F9O5WniahlFrSR9gPUyCftaf6Et3QVcQzNCG23R79LIqnSU1
	KhCyoowp09soLQFY6Hga9wkgGgeKz9T47t8I63M63BgYEivTqQt89d4JS4XA62ucg0p9vJWFigJ
	Rth/9OJZhzYushXzoT4NIHh+qT3Q1AvYID/WItFZLchGv6ojPpvXB77ppGxu7cCk90y2zO314hq
	6dUB2zseJnKw==
X-Google-Smtp-Source: AGHT+IHqXS/5UfjAOvdA06A2MvNA06Js3gSo3Wd4dquS+f89kqx+UCNvUIep87qbq7GCT4O3wpDyJw==
X-Received: by 2002:a05:6000:2401:b0:3e7:46bf:f89d with SMTP id ffacd0b85a97d-4266e8de2c2mr486406f8f.44.1759872487392;
        Tue, 07 Oct 2025 14:28:07 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b510ffd77sm716373a91.7.2025.10.07.14.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 14:28:06 -0700 (PDT)
Message-ID: <8e3ee208-e0d1-4799-a70b-fd4e4de34bc5@suse.com>
Date: Wed, 8 Oct 2025 07:58:01 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Direct IO reads being split unexpected at page boundary, but in
 the middle of a fs block (bs > ps cases)
To: "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig
 <hch@infradead.org>, linux-bcachefs@vger.kernel.org
References: <048c3d9c-6cba-438a-a3a9-d24ac14feb62@gmx.com>
 <aOPbMs4_wML4qxUg@casper.infradead.org>
 <c9fae0e3-88ad-4e50-a54e-8a73cdc72e38@gmx.com>
 <20251007145843.GP1587915@frogsfrogsfrogs>
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
In-Reply-To: <20251007145843.GP1587915@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/8 01:28, Darrick J. Wong 写道:
> On Tue, Oct 07, 2025 at 01:00:58PM +1030, Qu Wenruo wrote:
>>
>>
>> 在 2025/10/7 01:37, Matthew Wilcox 写道:
>>> On Wed, Oct 01, 2025 at 10:59:18AM +0930, Qu Wenruo wrote:
>>>> Recently during the btrfs bs > ps direct IO enablement, I'm hitting a case
>>>> where:
>>>>
>>>> - The direct IO iov is properly aligned to fs block size (8K, 2 pages)
>>>>     They do not need to be large folio backed, regular incontiguous pages
>>>>     are supported.
>>>>
>>>> - The btrfs now can handle sub-block pages
>>>>     But still require the bi_size and (bi_sector << 9) to be block size
>>>>     aligned.
>>>>
>>>> - The bio passed into iomap_dio_ops::submit_io is not block size
>>>>     aligned
>>>>     The bio only contains one page, not 2.
>>>
>>> That seems like a bug in the VFS/iomap somewhere.  Maybe try cc'ing the
>>> people who know this code?
>>>
>>
>> Add xfs and bcachefs subsystem into CC.
>>
>> The root cause is that, function __bio_iov_iter_get_pages() can split the
>> iov.
>>
>> In my case, I hit the following dio during iomap_dio_bio_iter();
>>
>>   fsstress-1153      6..... 68530us : iomap_dio_bio_iter: length=81920
>> nr_pages=20 enter
>>   fsstress-1153      6..... 68539us : iomap_dio_bio_iter: length=81920
>> realsize=69632(17 pages)
>>   fsstress-1153      6..... 68540us : iomap_dio_bio_iter: nr_pages=3 for next
>>
>> Which bio_iov_iter_get_pages() split the 20 pages into two segments (17 + 3
>> pages).
>> That 17/3 split is not meeting the btrfs' block size requirement (in my case
>> it's 8K block size).
> 
> Just out of curiosity, what are the corresponding
> iomap_iter_{src,dst}map tracepoints for these iomap_dio_bio_iters?

None, those are adhoc added trace_printk()s.

> 
> I'm assuming there's one mapping for all 80k of data?
> 
>> I'm seeing XFS having a comment related to bio_iov_iter_get_pages() inside
>> xfs_file_dio_write(), but there is no special checks other than
>> iov_iter_alignment() check, which btrfs is also doing.
>>
>> I guess since XFS do not need to bother data checksum thus such split is not
>> a big deal?
> 
> I think so too.  The bios all point to the original iomap_dio so the
> ioend only gets called once for the the full write IO, so a completion
> of an out of place write will never see sub-block ranges.
> 
>> On the other hand, bcachefs is doing reverting to the block boundary instead
>> thus solved the problem.
>> However btrfs is using iomap for direct IOs, thus we can not manually revert
>> the iov/bio just inside btrfs.
>>
>> So I guess in this case we need to add a callback for iomap, to get the fs
>> block size so that at least iomap_dio_bio_iter() can revert to the fs block
>> boundary?
> 
> Or add a flags bit to iomap_dio_ops to indicate that the fs requires
> block sized bios?

Yep, that's the next step.

> 
> I'm guessing that you can't do sub-block directio writes to btrfs
> either?

Exactly.

Thanks,
Qu

> 
> --D
> 
>> Thanks,
>> Qu
>>
> 


