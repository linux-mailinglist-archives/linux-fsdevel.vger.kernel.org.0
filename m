Return-Path: <linux-fsdevel+bounces-65797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 336CCC11922
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 22:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5835406CD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 21:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045E93074AC;
	Mon, 27 Oct 2025 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ghjuQXse"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5B92F691E
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761601292; cv=none; b=X97/n5+ous49P0Z/9/rna1TmMQ6OyDIIxE/nHXnuAF+MzC4zcm8UTAEieumA93/QAHN2fcw1INU1lFvWl6nAGufdVajn/1wAdePIz9Rp77PmVTyIghh061+wjSFB+jPcrUFji81AxE50+Pku22jZp2TqV7vWbFfTBdLbM1nZKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761601292; c=relaxed/simple;
	bh=dQWFOOYH4LUbeinVcTCYiaUbPT06g1hj6Ds3uCsB62s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LP6+FOTRdcyDLcO2PsIwdvblcSgCMFw5eJ2GZ6WK8uupvl3yUe56dQlrCKxzSLB1O3RSnzc1p/VhKw9hfjvR9mwJoicCvvj6D6EZkNVS//DQk9kkvWkOutIr81Q7kryQqjCGGgZDSsH+Lrgq1gQxLoulTso3g9JIGb7yxvZ5hSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ghjuQXse; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so5359008f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 14:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761601289; x=1762206089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sPbk0YaDnvFLBrFz9rB9p3NKwutMnXjW7aQLPhogcU8=;
        b=ghjuQXseCsl0sqz5r/UOaZQ/GVheE0+vaMGom43xpngX7ZwAJro5958IRWDtfdq6tK
         qLXQWuM16k0m+qv8E3lTIU/Z0BnqrbxfP89V25oov75u6YRPz4cTzuKPdRnkaNVeeZkQ
         6atVClbmcKXW8zudztwhderTnIsgtHSo0Tctyxia6KNEy1mFdWYe27Wc0MzDf12Uh4DP
         58sD3h6AioVUaeqbQHYKvuJzK6ybu6BGokBbx2c2tQymh9NloocZRRvW+bWcqDKz0rhi
         6yxrUMnT2+iZDh2BGXbjiriSxmWJvusFfnAJUsCEWYykZsIpZKiubOWT8dXR1iurOo8P
         aIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761601289; x=1762206089;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPbk0YaDnvFLBrFz9rB9p3NKwutMnXjW7aQLPhogcU8=;
        b=F7Rt7i2NYJJiUOJahWUcnoSYTXCCssZQzpBOCDK1L1vHzBfB8XPqLhmH7sGx2TcwFB
         IWDobkQNJG6uYD9wMYLBbjo9KCn1qb5p1cw13mlCTlXNjAE28sfvu3YkTkVDMCQ/w3k3
         083c08+9Byiux1JeuAyvSIVs2lS/0XGuDsQA9YYmMbSC96dvB33j17aKTNOsvCwvVZvn
         7LUcdRKzIDd5AyW12EplhRrOFe67qTJ9NAVdO3mcpSuPEi3TmcZcdJajdQnXrfYUFV87
         4D+C2bD17meAYnbIPWYPsk7gcARQbWrX+PtU2yez39+n8oQNCq4A3EEXJSVMfKGK2c/G
         r04g==
X-Forwarded-Encrypted: i=1; AJvYcCXhp5+QdxRFHKNnbZZUWRFA01lq1owUuph1GtSx4j3XjfVnHSFttpXATG21p//i/HU7jWoDtH92FNFPSvM4@vger.kernel.org
X-Gm-Message-State: AOJu0YzkluJTVETK7V2zOKHmdO7G9me4kW14lJRDAiI3EOzodhBHyFZf
	+361EbfhGjfjF+Xc/n9PmE3Z0VvJ4Z/pMNwyUzxfZ8DYY1Vv7vip32L/U5vAPvs7l/Q=
X-Gm-Gg: ASbGnct6S9Ae3b5GtJNy1HXlinRUROgypB6ie67MIqBh9m4PXEzisnY/nd9eizoWGnx
	rDXxePeBhN2CbkwdazbUUwFJF8bexSk2eJJ5PUHz15cmmX7ilAs2iljGE508RZfVctgNzh3GGu3
	PdzCjIRCFgyhElL0wF9+Nd/DIWPZCxtMwjrAvIHJMSL/1y1kl/c0z38ks2nFZrMIJ+st9qA09GG
	efsSTaOKdmqTpY4GzLj+NAYxEOtyhAgRTy/aaXxdc9ExmeBu0heyGx4R3su7dB0YbpLcAzOenmX
	9eaHUTOB10gCsGcfr9iG6up8KahCZxrIl0WyY+HwzbsLa0L/uv4dBSQ+X4FFUB8o7sRNmK2aw9X
	L8r/gFGxmZeKO99Z7j58/oU79D9zLgyt1mRM/fA3t5CjDvis89BC6IyIs06VRSFMJ4L/RJ+wOby
	EF4484AxgvT6/q45l2BPfLUYUTQ1f3
X-Google-Smtp-Source: AGHT+IEPVWYOW1Qw7RHmxY5d3RyavzVwVHRUCIcIazMEU/qKAeEKYC6A/Yg2I1/b5u9yQwqTJYXI4w==
X-Received: by 2002:a05:6000:2489:b0:428:5673:11d8 with SMTP id ffacd0b85a97d-429a7e4ee4emr833511f8f.23.1761601288394;
        Mon, 27 Oct 2025 14:41:28 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d22ea8sm92983895ad.45.2025.10.27.14.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 14:41:27 -0700 (PDT)
Message-ID: <c4cc53b4-cc1a-4269-b67c-817a0d7f3929@suse.com>
Date: Tue, 28 Oct 2025 08:11:21 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
To: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20251023135559.124072-1-hch@lst.de>
 <20251023135559.124072-2-hch@lst.de>
 <20251027161027.GS3356773@frogsfrogsfrogs>
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
In-Reply-To: <20251027161027.GS3356773@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/28 02:40, Darrick J. Wong 写道:
> On Thu, Oct 23, 2025 at 03:55:42PM +0200, Christoph Hellwig wrote:
>> From: Qu Wenruo <wqu@suse.com>
>>
>> Btrfs requires all of its bios to be fs block aligned, normally it's
>> totally fine but with the incoming block size larger than page size
>> (bs > ps) support, the requirement is no longer met for direct IOs.
>>
>> Because iomap_dio_bio_iter() calls bio_iov_iter_get_pages(), only
>> requiring alignment to be bdev_logical_block_size().
>>
>> In the real world that value is either 512 or 4K, on 4K page sized
>> systems it means bio_iov_iter_get_pages() can break the bio at any page
>> boundary, breaking btrfs' requirement for bs > ps cases.
>>
>> To address this problem, introduce a new public iomap dio flag,
>> IOMAP_DIO_FSBLOCK_ALIGNED.
>>
>> When calling __iomap_dio_rw() with that new flag, iomap_dio::flags will
>> inherit that new flag, and iomap_dio_bio_iter() will take fs block size
>> into the calculation of the alignment, and pass the alignment to
>> bio_iov_iter_get_pages(), respecting the fs block size requirement.
>>
>> The initial user of this flag will be btrfs, which needs to calculate the
>> checksum for direct read and thus requires the biovec to be fs block
>> aligned for the incoming bs > ps support.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   fs/iomap/direct-io.c  | 13 ++++++++++++-
>>   include/linux/iomap.h |  8 ++++++++
>>   2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index 5d5d63efbd57..ce9cbd2bace0 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -336,10 +336,18 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>>   	int nr_pages, ret = 0;
>>   	u64 copied = 0;
>>   	size_t orig_count;
>> +	unsigned int alignment = bdev_logical_block_size(iomap->bdev);
>>   
>>   	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
>>   		return -EINVAL;
>>   
>> +	/*
>> +	 * Align to the larger one of bdev and fs block size, to meet the
>> +	 * alignment requirement of both layers.
>> +	 */
>> +	if (dio->flags & IOMAP_DIO_FSBLOCK_ALIGNED)
>> +		alignment = max(alignment, fs_block_size);
>> +
>>   	if (dio->flags & IOMAP_DIO_WRITE) {
>>   		bio_opf |= REQ_OP_WRITE;
>>   
>> @@ -434,7 +442,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>>   		bio->bi_end_io = iomap_dio_bio_end_io;
>>   
>>   		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
>> -				bdev_logical_block_size(iomap->bdev) - 1);
>> +					     alignment - 1);
>>   		if (unlikely(ret)) {
>>   			/*
>>   			 * We have to stop part way through an IO. We must fall
>> @@ -639,6 +647,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>   	if (iocb->ki_flags & IOCB_NOWAIT)
>>   		iomi.flags |= IOMAP_NOWAIT;
>>   
>> +	if (dio_flags & IOMAP_DIO_FSBLOCK_ALIGNED)
>> +		dio->flags |= IOMAP_DIO_FSBLOCK_ALIGNED;
>> +
>>   	if (iov_iter_rw(iter) == READ) {
>>   		/* reads can always complete inline */
>>   		dio->flags |= IOMAP_DIO_INLINE_COMP;
>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
>> index 73dceabc21c8..4da13fe24ce8 100644
>> --- a/include/linux/iomap.h
>> +++ b/include/linux/iomap.h
>> @@ -518,6 +518,14 @@ struct iomap_dio_ops {
>>    */
>>   #define IOMAP_DIO_PARTIAL		(1 << 2)
>>   
>> +/*
>> + * Ensure each bio is aligned to fs block size.
>> + *
>> + * For filesystems which need to calculate/verify the checksum of each fs
>> + * block. Otherwise they may not be able to handle unaligned bios.
>> + */
>> +#define IOMAP_DIO_FSBLOCK_ALIGNED	(1 << 3)
> 
> A new flag requires an update to IOMAP_F_FLAGS_STRINGS in trace.h for
> tracepoint decoding.

I'm wondering who should fix this part.

The original author (myself) or Christoph?

Thanks,
Qu

> 
> The rest of the changes look ok to me, modulo hch's subsequent fixups.
> 
> --D
> 
>>   ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>   		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>>   		unsigned int dio_flags, void *private, size_t done_before);
>> -- 
>> 2.47.3
>>
>>


