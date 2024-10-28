Return-Path: <linux-fsdevel+bounces-33034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 673759B21E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 02:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D68D1F211F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 01:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C09D14375C;
	Mon, 28 Oct 2024 01:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rq39yErg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CB413C8E2;
	Mon, 28 Oct 2024 01:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730078097; cv=none; b=Pedo+zxMlWc3fif/kWAiEIfNVKpEPv9Pj9tg0zvv37JX8ujHYz/+4hGXkbhDfQqbT16UvD5sJWe+9z3Doocqm8J5M2PMSAxHV3UDsZ01R9fslI6VsNWWQuqyALB7At0hheUIlhtXvEzN+3lZF4n9NYpJu7eFU+11E9fa6L93X2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730078097; c=relaxed/simple;
	bh=GTI6i0pThJZo81GUgdeUZUnuzLBh1utpF3tlZ9PMBBk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Ac7hUoDU9ryUvfWMMLnyCQCPt0faLiGBetLZUplktLOHWFCTJtSn1n93iv2ndbS5YbYwZPXg/TZwUo7ZkOeFeRs2UhoeHanIkCa/gAJlySi5quW0xRiRzQjHUFr0om0pSmxU1ECaX+mYIfN1Ci772zz80L9pxG4KjlfP73Sgj1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rq39yErg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20e6981ca77so39996595ad.2;
        Sun, 27 Oct 2024 18:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730078095; x=1730682895; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+qDYDK7YLyDPpDO5MLd5DHVRviFiGrPx0QghsTgPlL0=;
        b=Rq39yErgS96SnzL6hI5BGpFa3wFlhTlcBgPAeagt8C7xgCjNYEG9cQBK2cCisHXx53
         j+O57KIA5BE2/e7REBp2ImVyvjE6ElTmNsC+wAPcIjU+Ig3yoE/4db2gGVLeVNIXA3v7
         3x572RPz1gk/yHVoDkN0i3IlhZx9bsoVXKVyve/1nqq8d8Rhuq9eInr/AG4m447lm7Fo
         I63B3zWyV9T40ZCyjLoUNjPMkYYuLkKOGCtmSmn9vvHc99oKO392ZEcKQ9CW088C01hU
         kYWx9UhZ6qeVp5B4DyifGCJzOViWqtDovkBS4nQ3uIuiRh1alHbOQ0CskE0WE9m3ddjY
         d6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730078095; x=1730682895;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qDYDK7YLyDPpDO5MLd5DHVRviFiGrPx0QghsTgPlL0=;
        b=Uxl+7joqfEWloIDBUoSf6z4K99AmkLvqfGQTrdVgR5XI3o5oH6cy8cu3yuNSGEK3sn
         qaEuNETEHHh3pbZgI+8f9H9hBhxrQptV9+Dg8CDmYWu4eRx+oArV2BCtS0spQ4fLeN30
         iBaMUYM33Tm6Tz+3sViWj+8FUAcnWc5q/TCufo9dura91WO8v8tjq1EFa1+XADWQaU4u
         8iU6B7JMGZ1H36hW3ttbXfavM6rrK/yQLLVpgdXkCHz1WjykSivU2nmX9AzBufk0c7Xm
         UGUzWe5qAj2gjozHtDM07/kLLsa4OvjLD26mOLPISZ8+DDgybd7fWr0zfSOgxvtbY10W
         jeZg==
X-Forwarded-Encrypted: i=1; AJvYcCUeFfnUw/RQGAqJdQyc2wognK3ikpO2hTt1gczFrdnmcHPZ6KPlGNaMYNrbmI3VPU0AlcPi8zPxra456xhe@vger.kernel.org, AJvYcCWnBLnru0O5hhatBAE5/c/rBP+ilp+ZS/BUfhXfpkBr8BnMQbdObBARVUcMxIe6oAr68OAlxShTdaLfJwIj@vger.kernel.org, AJvYcCXIBCcLM0EwvtgtyYl9wDxo/BeNW3HZbST1ASgjaEt6PDrSTvQeuff8pmEtHrwID6yjUaTMhjofMNM4@vger.kernel.org
X-Gm-Message-State: AOJu0YxKhTMRaYv6dZi/b0KHKutDV/KcrZe8bbqYBnjVgdt2/HEODm+L
	INr+8fTl8glprFWW8Np8LNLHceooTAPaqae90s7dIGYAUr28P0BfvKUWWw==
X-Google-Smtp-Source: AGHT+IEIa1FGEG3VEnL+DXLN983cKV18Q6uhWAJQzSEwm6vWL2MM1AzDhwotPIvH6JEsdKUcMX8dEQ==
X-Received: by 2002:a17:902:f54e:b0:20b:5439:f194 with SMTP id d9443c01a7336-210c6898707mr87541815ad.16.1730078093311;
        Sun, 27 Oct 2024 18:14:53 -0700 (PDT)
Received: from dw-tp ([171.76.83.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc013462sm40900805ad.178.2024.10.27.18.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 18:14:52 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, John Garry <john.g.garry@oracle.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] ext4: Warn if we ever fallback to buffered-io for DIO atomic writes
In-Reply-To: <Zx6+F4Cl1owSDspD@dread.disaster.area>
Date: Mon, 28 Oct 2024 06:39:36 +0530
Message-ID: <87iktdm3sf.fsf@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com> <7c4779f1f0c8ead30f660a2cfbdf4d7cc08e405a.1729825985.git.ritesh.list@gmail.com> <Zx6+F4Cl1owSDspD@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


Hi Dave, 

Dave Chinner <david@fromorbit.com> writes:

> On Fri, Oct 25, 2024 at 09:15:53AM +0530, Ritesh Harjani (IBM) wrote:
>> iomap will not return -ENOTBLK in case of dio atomic writes. But let's
>> also add a WARN_ON_ONCE and return -EIO as a safety net.
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/ext4/file.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index f9516121a036..af6ebd0ac0d6 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -576,8 +576,16 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>  		iomap_ops = &ext4_iomap_overwrite_ops;
>>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>>  			   dio_flags, NULL, 0);
>> -	if (ret == -ENOTBLK)
>> +	if (ret == -ENOTBLK) {
>>  		ret = 0;
>> +		/*
>> +		 * iomap will never return -ENOTBLK if write fails for atomic
>> +		 * write. But let's just add a safety net.
>> +		 */
>> +		if (WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC))
>> +			ret = -EIO;
>> +	}
>
> Why can't the iomap code return EIO in this case for IOCB_ATOMIC?
> That way we don't have to put this logic into every filesystem.

This was origially intended as a safety net hence the WARN_ON_ONCE.
Later Darrick pointed out that we still might have an unconverted
condition in iomap which can return ENOTBLK for DIO atomic writes (page
cache invalidation).

You pointed it right that it should be fixed in iomap. However do you
think filesystems can still keep this as safety net (maybe no need of
WARN_ON_ONCE).

>
> When/if we start supporting atomic writes for buffered IO, then it's
> worth pushing this out to filesystems, but right now it doesn't seem
> necessary...
>
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

