Return-Path: <linux-fsdevel+bounces-67062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B605C33BD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 03:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E08624E94E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 02:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8D92253FF;
	Wed,  5 Nov 2025 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOXRdKOU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A791E5207
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762308495; cv=none; b=WK3t2L87UPzZlV5J2rf1AvY5n211urXSvXBen4bA5hl6rGEkVHg7rAXIGC5LIJlbPWI24IXq522T60l1tgX90lPqm7sXRe1FiPpTO36XF9dSQPnRy0weFQFLyJ+15HaL6AP7ci0o7n0YKYmM72npfma4nDKDyKzLLJCdlnrVdN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762308495; c=relaxed/simple;
	bh=aCIePvxR6b0aME6sxxADpgHuW9tgTHqfJqmmFPqOqb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hx/Z8mHBQje1bj2pSWhrSV/Na8sXxJAq90dWGrILt7dg2mfYN+Qm8n9XuXzhQPTLdR+9bV/SYt/GyV28gku+t5yrI4tID1fKaAUB6/eERIuB8gAP6GyXXjAwg0oq1Bvcw+ScrReGtjl5QcFwX9IxD+pE/s8CSWeYyb82bjOTZW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOXRdKOU; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ba599137cf7so221734a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 18:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762308493; x=1762913293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4yDBu3bQnhMe9kSGDJfDwWvTH191XsVU1fFztibKfQ=;
        b=AOXRdKOUWbvJa/YjPYbAkr6KmAf/lpgcXmUSDMlJy4DYU6lDrP6RkJyQnnU8PTt7ke
         2sY+RCUIJTIcQig8mGcG5B3Qu74NRGKT6e2gucYzRCyw68u3Pxc6r2DV2z4GhAvecxsc
         M9hVastkDwW3WAqenP+6idkb7Yif1hEeYLO9+Zf3Txax7je4fkY4p+Ch5NTCg2FNHrgx
         X1ALGtL14NAxGbczmqgoq/HBmD9874hXQHTZx3j3lXwqrycY1t3Pl2jwCZmxgN6vIaIy
         FFHgaA11QsAfEFUtoKWa/9nuuOomJepM+uB1M1KJ4mb6OKwJf8I/DpYIAOi9vYjMCcDu
         UI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762308493; x=1762913293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4yDBu3bQnhMe9kSGDJfDwWvTH191XsVU1fFztibKfQ=;
        b=r+wBKgMfg0ZFebWKr677ng7w8nYSnDgcZt0wQEo8WTA2Jmy+MwA8Iw1tD0tKEPTq3J
         4bMFUcxmuBD23UBs+9MQXom7hSTBOvJGPvGB/gUi+vS4AkeyM9GixcGtFav2OuTDtFTA
         167iwJBOodJJfy8B1hoI93nFJ7sXoPk9BV8fga0BW7rzwZJgYgTjgG6poD71bRzNeEu2
         o0GyXEoU9rAIfH0JZb2KVjpOPwD2s8hYII1XkLsgJ3Y14+T+eYO7qh7r/Pr/c7Z2Rywb
         XdIGkdA8sP3aGfezyIWUomW3Zc3t8+ACu2z6m0JmWwqb5vqtAGy4T+FHRT70SV6n3yhT
         +Cnw==
X-Forwarded-Encrypted: i=1; AJvYcCVwkS0xVj0DA+fnxOg+NLLodUZh3Sgxf2KBiuvntrWYCOR1pAqVHJHwnsfovVap2pvmSiP6dBOmsT/fp1za@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu2cS3prirg1egPVGMP3A2IXQNGrdqL6NlW71A+CJOwJvXrTCL
	rWEpRDN2L87o3pkYll1XN+Pa1bfYa8E1R/dtPn/ERs1+FK8EwMcpwiQs
X-Gm-Gg: ASbGnctj4X9fwp05ZBpKZdCV7U0DldtaFg2ynQGHkB1h+Md7YVAP3ZhKrlSzVS1bu6h
	tKNjvjFUG37SUOVW/EcyD2r1eJMlruTcqKnEccUYBZu1nNYUk5npcmmwi4GvYmJZHze3bAconZ4
	NpZEOLM0jMawqm77qt7QlOOaz9BKMc75nTRQ6/njguCl8p4UeWSyfPl72hOA26aLvWbSOTGIfhd
	N009eX2AiQr2GXobXSf1sRb96z3gH10cmiOeSHI4Ojtb4uZTxdkjTJlF3LwIEShdV1Q0VOIgtv0
	0CJptKb39SRdlHf2Zz20HUkpjvIxwBlzJg6iUWnznzhLX1wRADWFaULRiyn75OXgNxEgw2RjsCf
	MjHGL3i2/Zq8JC5KLPA3bxjaolE8alCtAunq4DmlgN0CkjSNarypeMttv7GqH8omBqJmmA4Wwfv
	llvxDNgdNlI/qUwDdbN56jpos=
X-Google-Smtp-Source: AGHT+IHFEEDEwbkYMhDcYlAouSByZjRV09d05fMzqHjwPvk8mlwVG2htfWc/MvggLNSc+kqx17qoEQ==
X-Received: by 2002:a17:903:2448:b0:295:6d30:e263 with SMTP id d9443c01a7336-2962adafc02mr23971055ad.40.1762308492736;
        Tue, 04 Nov 2025 18:08:12 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601978210sm42828115ad.2.2025.11.04.18.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 18:08:12 -0800 (PST)
Message-ID: <221cdf62-f8aa-421b-9d39-d540cbe7346f@gmail.com>
Date: Wed, 5 Nov 2025 10:08:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] xfs: check the return value of sb_min_blocksize()
 in xfs_fs_fill_super
To: "Darrick J. Wong" <djwong@kernel.org>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig
 <hch@infradead.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
 <20251103163617.151045-5-yangyongpeng.storage@gmail.com>
 <20251104154209.GA196362@frogsfrogsfrogs>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <20251104154209.GA196362@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/4/25 23:42, Darrick J. Wong wrote:
> On Tue, Nov 04, 2025 at 12:36:17AM +0800, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> sb_min_blocksize() may return 0. Check its return value to avoid the
>> filesystem super block when sb->s_blocksize is 0.
>>
>> Cc: <stable@vger.kernel.org> # v6.15
>> Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
>> for sb_set_blocksize()")
> 
> Odd line wrapping, does this actually work with $stablemaintainer
> scripts?
> 

Sorry for my mistake. I’ve sent v6 patch to fix this issue.

Yongpeng,

>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> Otherwise looks fine to me
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
>> ---
>>   fs/xfs/xfs_super.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index 1067ebb3b001..bc71aa9dcee8 100644
>> --- a/fs/xfs/xfs_super.c
>> +++ b/fs/xfs/xfs_super.c
>> @@ -1693,7 +1693,10 @@ xfs_fs_fill_super(
>>   	if (error)
>>   		return error;
>>   
>> -	sb_min_blocksize(sb, BBSIZE);
>> +	if (!sb_min_blocksize(sb, BBSIZE)) {
>> +		xfs_err(mp, "unable to set blocksize");
>> +		return -EINVAL;
>> +	}
>>   	sb->s_xattr = xfs_xattr_handlers;
>>   	sb->s_export_op = &xfs_export_operations;
>>   #ifdef CONFIG_XFS_QUOTA
>> -- 
>> 2.43.0
>>
>>


