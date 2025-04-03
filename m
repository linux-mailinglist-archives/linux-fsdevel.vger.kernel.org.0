Return-Path: <linux-fsdevel+bounces-45676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2BAA7A954
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599291885257
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C233252901;
	Thu,  3 Apr 2025 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZjyH0/S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3DB194A60;
	Thu,  3 Apr 2025 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704780; cv=none; b=RktwrC4Li9JNjI0e5XBGaZm80GGvAgo4BUsEvA0ykWVzmUu5ErYzo6d3v+aKf49AwRw2e6GcPXk141Em6BT0k0Z/57a77+IjJjMWkIAMLppL8ipC1YUk2tj9IfN9TSWW9z9oTYMwufV0I5YGNyLVBLJ8C7OXMGrKMkfIjoMLjRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704780; c=relaxed/simple;
	bh=pq/Y85p+DKzedv8z8Lo6x95Rn19FRnxn9YzPc6zkHks=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=kMN+2Y3MdRX1PueL9RVXS/oIE8PFypLlQK3BcJj+77+CW9jiQu/2QrgWhw2mE4/YmQ09iaGdaDT4ymMinP9j7juOzCzcGtEo8tgDpOOeOjJOgb6DU9UxPjdV7ABljRAe2eVuh/STYM0iHAOVefMWP8BHrp7akLFpaZhdk+3ooRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZjyH0/S; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so1191348b3a.0;
        Thu, 03 Apr 2025 11:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743704778; x=1744309578; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i8joWbiVFz8a51W/uUR3H5ki4/NTpQHMOERnmG+lTxU=;
        b=TZjyH0/SB1HdIMKNI3wFnQ3JgSAGAO0hhtJTQOfEMEEIoMO3wsPigyF5ZtZckw4Cuz
         2IrFIOXJ/y2SD68ZayQPCdFrtaR5JBWOVd2piLyiR65UBDZtFOG4UJcvo6FbwNwnhLZw
         9xwUinicp8QMRwO7lxXKG6vhF+MAm5bydt1aEtP1QsQYb/t+axn+xqX2yXlU4plarvOy
         tlNcM7qXeqceMP7Y9oKXxZe7I0vHiT8X+sWAfM57q/am4M4Y9qv7vfEXZ0LW6nkBH0Yt
         ZIGaFVVw4KFdXYRp5Qn999kj+Mz0nK1L1MpgpreFecxeJA7h15+vTWTmH+RJfgKypsQ0
         PIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743704778; x=1744309578;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8joWbiVFz8a51W/uUR3H5ki4/NTpQHMOERnmG+lTxU=;
        b=ci5FNRLEA/qmWPSEFwnBUw/9+vQfAWy0Gm7PDd7g0qVyT3j8y33PgbxkpBgjNWKZR7
         W/Wx4fGyPqN+DkOceqdx5k4/bT8pgrV3KoaVV6TON5zHK9youBBOQdXuQphl/fJ74MJr
         9CkUS6oLfDmp0V//NOluJFs0EYUHU2JKsTB+NuPBRKOGPaS3MaEf1Pwxeb7rcd0ZkC24
         RAXJAzl4MkYDYthh3ZfpsXmpvgXl9KMHJclRSMiG9rtT/3carR1J3pLh16Ul7CoD6rYU
         s3d3gQqGkcOuH+EoIusVgr4uy5DQbhya4bg1cWrrcI1IyMun14s1iKI9juUT/fJhHTvC
         k9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVF/VhZIWQRaQnAXrdtNQiBQca6ByqP9GZMVO1aNqtTj99eV2qjBup7K9UFMl0qMdvCxDAUnTCmi/k8Q==@vger.kernel.org, AJvYcCVws5lohb1cBa7JOd2Prk9Ddg5RYcoNtjOWS0bQ/iJ6VYlIrU69/pvNUpz8E3bRCVCbf4En40y+JYx+oKuvlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCViy/BuhHeq+tjE4LmVMs5h4DZ+w1jPjTOGkvTCwMsjSHPskD
	wlS3ZD8SJO5J6ys1kwY/6W/MFAWWsSLMUp1dbQEAB1TCgpWeSmUYlVGNZhrR
X-Gm-Gg: ASbGncvUCM2MVfjm3G2UxHlmf8EtEewQzh7kSGMgP9RAPi7cSHYq1+Peifbk310Ua5z
	aMHWaAl6gPoRlVbFwXKIknqUY41H3CYLb6qjj8rPOZeyvWn314IEuJ5uiWAeOepBWoBVTAyR4XX
	u32ji4/rUZJAqfYWqn7iTuySs3uvDjePCNwNv9hQFeVAaQJeTjSVN88+xAMDmIavjzjG4ZiO8JB
	ENkKLeXFMWt9osBkKG/orWY/H3GSnhjzRxVBiLs7BrK9+hoordOR+nd1B6aUYUOTT8nbDhNO1gx
	qDPPozmXIwVA3ofwUN+3jHkI5UI0M4gtt3Fr
X-Google-Smtp-Source: AGHT+IFzdkVH8O4H6PmP4y3ASE2O4PZq/WxHQhWE6aXJwl7VKMvYTzCoqEedxpCOQGUvQgwDhai21g==
X-Received: by 2002:a05:6a00:22cb:b0:736:3be3:3d77 with SMTP id d2e1a72fcca58-739e4b6681cmr803125b3a.16.1743704777684;
        Thu, 03 Apr 2025 11:26:17 -0700 (PDT)
Received: from dw-tp ([171.76.86.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d1810sm1821580b3a.24.2025.04.03.11.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 11:26:17 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, djwong@kernel.org, ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] traceevent/block: Add REQ_ATOMIC flag to block trace events
In-Reply-To: <cad0a39d-32d2-4e66-b12b-2969026ece37@oracle.com>
Date: Thu, 03 Apr 2025 23:52:58 +0530
Message-ID: <87tt752jgd.fsf@gmail.com>
References: <1cbcee1a6a39abb41768a6b1c69ec8751ed0215a.1743656654.git.ritesh.list@gmail.com> <cad0a39d-32d2-4e66-b12b-2969026ece37@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 03/04/2025 06:28, Ritesh Harjani (IBM) wrote:
>> Filesystems like XFS can implement atomic write I/O using either REQ_ATOMIC
>> flag set in the bio or via CoW operation. It will be useful if we have a
>> flag in trace events to distinguish between the two. 
>
> I suppose that this could be useful. So far I test with block driver 
> traces, i.e. NVMe or SCSI internal traces, just to ensure that we see 
> the requests sent as expected
>

Right.

> This patch adds
>> char 'a' to rwbs field of the trace events if REQ_ATOMIC flag is set in
>> the bio.
>
> All others use uppercase characters, so I suggest that you continue to 
> use that.

It will be good to know on whether only uppercase characters are allowed
or we are good with smallcase characters too? 

> Since 'A' is already used, how about 'U' for untorn? Or 'T' 
> for aTOMic :)
>

If 'a' is not allowed, then we can change it to 'T' maybe.

-ritesh


>> 
>> <W/ REQ_ATOMIC>
>> =================
>> xfs_io-1107    [002] .....   406.206441: block_rq_issue: 8,48 WSa 16384 () 768 + 32 none,0,0 [xfs_io]
>> <idle>-0       [002] ..s1.   406.209918: block_rq_complete: 8,48 WSa () 768 + 32 none,0,0 [0]
>> 
>> <W/O REQ_ATOMIC>
>> ===============
>> xfs_io-1108    [002] .....   411.212317: block_rq_issue: 8,48 WS 16384 () 1024 + 32 none,0,0 [xfs_io]
>> <idle>-0       [002] ..s1.   411.215842: block_rq_complete: 8,48 WS () 1024 + 32 none,0,0 [0]
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   include/trace/events/block.h | 2 +-
>>   kernel/trace/blktrace.c      | 2 ++
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
>> index bd0ea07338eb..de538b110ea1 100644
>> --- a/include/trace/events/block.h
>> +++ b/include/trace/events/block.h
>> @@ -11,7 +11,7 @@
>>   #include <linux/tracepoint.h>
>>   #include <uapi/linux/ioprio.h>
>> 
>> -#define RWBS_LEN	8
>> +#define RWBS_LEN	9
>> 
>>   #define IOPRIO_CLASS_STRINGS \
>>   	{ IOPRIO_CLASS_NONE,	"none" }, \
>> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
>> index 3679a6d18934..6badf296ab2b 100644
>> --- a/kernel/trace/blktrace.c
>> +++ b/kernel/trace/blktrace.c
>> @@ -1896,6 +1896,8 @@ void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
>>   		rwbs[i++] = 'S';
>>   	if (opf & REQ_META)
>>   		rwbs[i++] = 'M';
>> +	if (opf & REQ_ATOMIC)
>> +		rwbs[i++] = 'a';
>> 
>>   	rwbs[i] = '\0';
>>   }
>> --
>> 2.48.1
>> 

