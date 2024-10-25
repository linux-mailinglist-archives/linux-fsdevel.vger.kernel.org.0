Return-Path: <linux-fsdevel+bounces-32876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD7A9B0033
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 12:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739C51F22A59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 10:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63C31E47DB;
	Fri, 25 Oct 2024 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3woiGZs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693591E3790;
	Fri, 25 Oct 2024 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852499; cv=none; b=Q2uC2BOWPIi6+RZdnZVGt0QwpjjhJ0vS8MshYbc9OoZMe60nn1dQpUA2VeBzSbkalAV9GSaStooOUiFIJtsKVeUezajEKxsE5rEj2UMc/5y+WCOr9GdIDFa/Va+qgFpUrp7nVgk1KiB/LLKEGSRG3H5gGXPThWXd/TfyiEMgHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852499; c=relaxed/simple;
	bh=vQIGZCQM+Ro8SHEiXXYjCp7c88ij9t+EESA1LElNFkE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=hngiAp+h/GuqiGcXHqUE8J8bIjm8W9pwFNUeu4v+CGWo5CyIYjw2SWaRCmNJ1piyAHC7kJBnv/bDkMU0Xsc+9HDRFMghhyCqWaDNstUtNDxSCuZamSJln3K9rFL6q3VWZeMAvE/5H52DxuN3b+qEETlGJCON33i9fxqLHGpXCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3woiGZs; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e60d3adecbso1030847b6e.2;
        Fri, 25 Oct 2024 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729852495; x=1730457295; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=baV+LvfDxbD01NcPOpa/WcmCQh/8Ep70mWJOpY30DKc=;
        b=W3woiGZsoctvkbrD3ZGiSZYXKpsmhKwfFdqSiuVE/EE3qQDriMjQ/M0kVQJkRkydK5
         g3kZ1ZDrL0RKDfUSD2OUkHqJPAYopzna2EO0VtqTd6cNp0xp6x4V7Uq6guvjT1mHJpym
         HzH/KwVkPG19JW9L+xhIdKjdfk6UdS2ItROKqEvzXUXhaAKKFrNs8c9Oga2VTfFWr1SM
         2mjP/QXHIZHQYeS0eDE3bcmKTg0wZBAiKsR7tAevf071S9LQaRrLuiOKrd8myh9BsTOv
         XuE/IP3GHbJ5AQ0lzIlaCH4VYZJdFB/LwwEqlfhsxwY853xYlJYEF/IJfA0PE0iNQfdd
         1gEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729852495; x=1730457295;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baV+LvfDxbD01NcPOpa/WcmCQh/8Ep70mWJOpY30DKc=;
        b=Lj4ipToqxmDO5jBP7kjLeZ2bCwUdpFfzsof9Wno2jn5c8cZNEV+18yyrVla6ws3e57
         lv/JSXWQJHJEmjydRSWZFDRa8D5Z4OftAmPsh130JCkBfshrG9+qklBV7Dtwt2vncOpW
         07M5r86OWY8QvppYA0jyeiLpvb9BePBFQ5mKKkQxx56BioCkQqnwjlcEPwegdzBPr76j
         bSc3+u52cmwwrQsKVqlz+EaKK/ZMh6l2rlXK8XioknXJSpz0kbpzI+NTUt7hPRTi6n5B
         QLIfORvIt7ZsSXeqEhai8+YsrumwrfoZcZjc5XyUA+l42T2q65I0CC0mesRKNlP5C+n5
         +O5g==
X-Forwarded-Encrypted: i=1; AJvYcCUfyPqv6Y5eVZyf3Sf0NW4ZARoI3u2exlgZ5zIqB73fYKxWFTyRDKVr6eRvIVya8rZK3lvEzdoVEapChk/wtA==@vger.kernel.org, AJvYcCVXgAS87WdUlg3o80xT50lFisJ7M76y4zJCZz3IXqVWJbbsmn65ygCgI02u1KrkqKwvtu0DnI5bvtvp@vger.kernel.org, AJvYcCVXsMtNUQkTZ+0NMe7o6+p9WFQ185ggR7426Vrh63bR/ndcvfZ5mbtki+r+Iok0vLAx6WvyHTml8X5l@vger.kernel.org, AJvYcCX9GGVw7x3mLZydc4ImfEQ1KLVdLjFLM1ak/wuLM007RuAgJiLswEVC/tR9+Go2Tdd2Tp4H6jpun6XIlzr8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb8Kt3z8wGxYzYqLA0Obtacq2vPQ371HpuYlQuy+0Qa1zQGpHU
	CV2HFvj7HWc3Rtk/+sgjDAqCrwzPdBHjitO9H2YHNmGwGuwcusgyhrvNZA==
X-Google-Smtp-Source: AGHT+IH1NwPYS2VjuxS6rZCRQmV20NcvIjnn5Ki0GniF51Ojsurcv5YvNqfe7WKEOQ3/FeRwOGpWxw==
X-Received: by 2002:a05:6808:3092:b0:3e3:982c:ebf9 with SMTP id 5614622812f47-3e6244ffe2fmr8747837b6e.5.1729852495304;
        Fri, 25 Oct 2024 03:34:55 -0700 (PDT)
Received: from dw-tp ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8a77412sm786552a12.94.2024.10.25.03.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 03:34:54 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/6] ext4: Check for atomic writes support in write iter
In-Reply-To: <b6f456bb-9998-4789-830d-45767dbbfdea@oracle.com>
Date: Fri, 25 Oct 2024 16:03:02 +0530
Message-ID: <87wmhwmq01.fsf@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com> <319766d2fd03bd47f773d320577f263f68ba67a1.1729825985.git.ritesh.list@gmail.com> <b6f456bb-9998-4789-830d-45767dbbfdea@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 25/10/2024 04:45, Ritesh Harjani (IBM) wrote:
>> Let's validate using generic_atomic_write_valid() in
>> ext4_file_write_iter() if the write request has IOCB_ATOMIC set.
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   fs/ext4/file.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>> 
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index f14aed14b9cf..b06c5d34bbd2 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -692,6 +692,20 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   	if (IS_DAX(inode))
>>   		return ext4_dax_write_iter(iocb, from);
>>   #endif
>> +
>> +	if (iocb->ki_flags & IOCB_ATOMIC) {
>> +		size_t len = iov_iter_count(from);
>> +		int ret;
>> +
>> +		if (!IS_ALIGNED(len, EXT4_SB(inode->i_sb)->fs_awu_min) ||
>> +			len > EXT4_SB(inode->i_sb)->fs_awu_max)
>> +			return -EINVAL;
>
> this looks ok, but the IS_ALIGNED() check looks odd. I am not sure why 
> you don't just check that fs_awu_max >= len >= fs_awu_min
>

I guess this was just a stricter check. But we anyways have power_of_2
and other checks in generic_atomic_write_valid(). So it does not matter. 

I can change this in v2. 

Thanks!

>> +
>> +		ret = generic_atomic_write_valid(iocb, from);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	if (iocb->ki_flags & IOCB_DIRECT)
>>   		return ext4_dio_write_iter(iocb, from);
>>   	else

-ritesh

