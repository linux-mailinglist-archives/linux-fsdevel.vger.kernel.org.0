Return-Path: <linux-fsdevel+bounces-35107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B860B9D139F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 15:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8F12814D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576F31AA1CE;
	Mon, 18 Nov 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k0Is1buZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9121A3A8A
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941403; cv=none; b=QBiQN8BU0B2hHpbcFiCfj7JWGG89ReNHCc9Sw2q3j/qcO0Ht8ydiBjbp6jl3ECwKFXNFuHhV5fIsTlcU2HTHpM27Bphf1zLWiMY7JP8+N/6136DWXgVOBtnSZ704aMfnoo0BGpwyz+jBU1XjTj39VsOkMzsTATmO/Ah7DL/hIKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941403; c=relaxed/simple;
	bh=jabCupIh1FJFAKWSdaG7M5rrT0Y7L0LAPYbB0FE65Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMfxShSI8/UZ6xvRFr20FwgSU6mU0L+aJKyoOTAxwEDhRypNBvkReG1kUaH82bblL4qce2dB242Jd6T4JSNmhlaGCzjS3YjR0h6fQK3NSQPhCZhgVHJfhVNj+dRVMZsfNt8SgeGsDdEFd6UhcD3qR2SZvIg6Bsc43CMPDx5VUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k0Is1buZ; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-296252514c2so2730265fac.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 06:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731941400; x=1732546200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=64rV6XVBsSRZD9lz1azW3sqQ1KWaD6KRPC47/eG5qsA=;
        b=k0Is1buZhEVRX8aA2YpNv8xH51kd3XdbQCdU6sjFm6apcmft7wlkZzhH7Mb9GK/+2G
         1ych5iZYYRNoEgNf/GkM0axLJb9fKsMg61umrjWEmu90EW9mrMb1789SRAbRJEhfjo6y
         Xmccgf3Vb9OQ5OYpKxWee2AxCS87/bX4pAKbglFrVIXGqo2Tj9/DNJukkN8cSrx9Vw6d
         GL5P2MEa+d1yuxxcKeDri93rmq7rjaGcTCBL87Ks5NGABsRSD9DPWYcfdy6Uhy0xWtZ5
         +SU85X3/ub2mgUOCY6QgZVRoxVXkkmtf+jTTNLtdabubJEcV5dBnSLlNhBBJk/jCdviS
         RnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941400; x=1732546200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64rV6XVBsSRZD9lz1azW3sqQ1KWaD6KRPC47/eG5qsA=;
        b=BSzJOp8c+L+jXM2G7iqK2j0orF6Ya/fzWY1gRJ06f6yFqlZDLvNvLzrPSTPQQApmi3
         Wc97pvUaoKvDUqDWQdWiv1KdwrC3j76v2WN8N4a/Z2ak7ifat0/6xerFs96pAt6k13aM
         7l5ATZpmwLJTZHn3DLRBrCmXdyp0uSrsDU24lZ86wofXDHgeZcrAvyIO9PNBJyVb+zZ1
         RwOIwVqPgAy5RVlycpcyKC1Tz09gNrdyNPu8ZkMFgM5ndPE88qQuRqyPim1s1YqIvMgx
         8oZPeUsVlhG2b6ErEiluSgB1wU2FUJWiX52ymAz/e9ae9krtvksCaXOHbBOEsN4RbYie
         LQ5g==
X-Gm-Message-State: AOJu0Yxpgj4aGJ5czItgpYlfzM16x2eguGNdTdZUZLFEnnICWGdY2qyw
	X9QnAkNOlOZvJoF9Mm0zoEV+zGlkwxlCXvMjHaSjO437MBMNgBbNYTuTs/3NUUg=
X-Google-Smtp-Source: AGHT+IF4SYJY9kdWkwrKjlAiH5Z+Bn8SZkqEPmKpcyMndgMPRn4H9T8dbqU6Hyt3/gFfCCmMTdbpdA==
X-Received: by 2002:a05:6870:ab0b:b0:287:1b05:297d with SMTP id 586e51a60fabf-2962e01ad0dmr10557378fac.33.1731941400385;
        Mon, 18 Nov 2024 06:50:00 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm2626597fac.2.2024.11.18.06.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 06:49:59 -0800 (PST)
Message-ID: <c54063db-5f82-46d6-ba7b-5e4a0073ebf9@kernel.dk>
Date: Mon, 18 Nov 2024 07:49:58 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] mm/filemap: make buffered writes work with
 RWF_UNCACHED
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, bfoster@redhat.com,
 Yang Erkun <yangerkun@huawei.com>
References: <20241114152743.2381672-2-axboe@kernel.dk>
 <20241114152743.2381672-12-axboe@kernel.dk>
 <01fadf73-6b0f-44ff-9325-515fae37d968@huawei.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <01fadf73-6b0f-44ff-9325-515fae37d968@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/24 1:42 AM, Baokun Li wrote:
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 45510d0b8de0..122ae821989f 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -2877,6 +2877,11 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
>>                   (iocb->ki_flags & IOCB_SYNC) ? 0 : 1);
>>           if (ret)
>>               return ret;
>> +    } else if (iocb->ki_flags & IOCB_UNCACHED) {
>> +        struct address_space *mapping = iocb->ki_filp->f_mapping;
>> +
>> +        filemap_fdatawrite_range_kick(mapping, iocb->ki_pos,
>> +                          iocb->ki_pos + count);
>>       }
>>   
> 
> Hi Jens,
> 
> The filemap_fdatawrite_range_kick() helper function is not added until
> the next patch, so you should swap the order of patch 10 and patch 11.

Ah thanks, not sure how I missed that. I'll swap them for the next
posting, and also do a basic bisection test just to ensure I did't do
more of those...

-- 
Jens Axboe

