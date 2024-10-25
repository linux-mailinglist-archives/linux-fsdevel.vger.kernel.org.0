Return-Path: <linux-fsdevel+bounces-32872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3509AFEA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 11:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FF21F239F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4A41D9669;
	Fri, 25 Oct 2024 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nr1ut9cp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234291D4350;
	Fri, 25 Oct 2024 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849468; cv=none; b=lV8SSo0mOMxfCdlCaKBDiJYN+qRPJHDYopI/a9mDRszDfCYPDK+q/lCO9XYOxJWItF1HO5NCHBWiGQnZsvjotnytncAHe2JsfcIW8uHQKBgbzkXUiVDeSVVznQoHmxGAnupQru4EhDV98ljt6HA8TCAhMdqDlw3KDdmhSqWb2Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849468; c=relaxed/simple;
	bh=RiySH0Di17880CySej7mFgHZ6gWr+yrYcOvr4fWorhA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=L31GDCh6+i/E+B1SWFTVOQRnISdFZXzTzbbwekOv7OrZNI3aIeqLuqg3psoynzwt2PBSkcxF5CylVuavU3+YsEZ67XFvgSm1spu6lcUvaMBpCffPFsMffMIpHBgYxCYg9XkhblLzWBZXVzyKar0EqcA8+vWD36k7t8Yjjr58JqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nr1ut9cp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c767a9c50so15194315ad.1;
        Fri, 25 Oct 2024 02:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729849464; x=1730454264; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I2vYx2/rEp8wlF3jW81PbjikWNTSn7Ck1hGTS7SC6dw=;
        b=Nr1ut9cpkh+nwIpEwzf+kLjw5ZKTR5MMOFbnH61a2KLfMpSXqexGQ5MVDDi/ud31du
         5vXhCUr20tI5AbZJtQ8poVS1+nRXH61rdcjDwaZl0iKSd202ZBmc5Ugx4WmPyE6QBvQ6
         Sli+F2t7c6LFPJLtg3h7hEdUvVAxMbfo+jZxrVh7+NakIElnsDgSfh3HV+TxKckMEwT2
         bRSO1sVqGJfqQDqWK3417955peru50/MdhgXPOZw7E5GhrxTqKy37bkY+Wqxt6ViB8OV
         4AUb6+g2ZgvgczIuUm7vmnpmm6zVzn4Y+NC+W8LoAwgpNt1MXjEH6ky+bN5mFbeXTTxk
         EhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729849464; x=1730454264;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2vYx2/rEp8wlF3jW81PbjikWNTSn7Ck1hGTS7SC6dw=;
        b=o9J/Zzw1uwaatQPt1bmyA7v7hip17AlGJt8m74oeO8qNkQuaRmE9EEMASsJdSOc6eS
         n6TQ1WqKmM5IfZ+dOp6RP+AmZ9k1CbnUSFd+bZsOiBp4N7hc0VUQAZXF05xYqk9l91pw
         NX5a9Hsecbm0MEsPADK2RAnGln8BYEZcgcAgNhpma4t2y2X3TVjrgLwe4BOTUw9dVoKT
         0OX5cnejtPF8P74cbqZ9UNiljwQUQQo8i2kjsNkwwVErU0QDRLq9LoPxgVnT3nfUWJpa
         gwgiGpv6h70/gpeul0pwM8v+Xhdjoh/GwtbYA8Fdv59CN+c75FbRYaxtC+vM3wZC/cCu
         Otaw==
X-Forwarded-Encrypted: i=1; AJvYcCVallf1nMmxL6Yct5Nq+akJThP4XkjwbeJHbA/ALvr/hWCk5Hz/Zz2AZWV/2XT3lE07NCfvYJDPpuMJ@vger.kernel.org, AJvYcCVvmH45XEDzxCpjPHGmUyPETOfkRxNadP/MCZWfg8xaMk4cs3XYJ4CzNogFDBYCJHY3rcQhvAs1GkqSr7yA4g==@vger.kernel.org, AJvYcCWXZbs12o8CNV+6pmHATTTY84FnH03tx34P/SY56CeqTZ8SItDDIC7dAz7egtUOSbo2/atESdBEEDGsgave@vger.kernel.org, AJvYcCX5JzKlIocmHp4FnDzeD/sn41fOFffdtgmYRNfJj+k3q0QkBlv8I5cJrTSaBXelEc9/muLDol2OVhFD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8iCOWXv2SGaxMZ3IsjXO2ggA3GApBMwzwddH5ZoMQcwnB5Jy9
	MEABOwuePFGHGUyamZPqyfv6C1Gx1QaT/U0vXjTtKWczbU/O9AkpZ2TEzQ==
X-Google-Smtp-Source: AGHT+IEKMi61ubnLsED0Ch9ULwO86yZJnZaVs5ux4KzM+ZVBXDu99ZcjoX0VFZ66bFtVIBgR4gemHQ==
X-Received: by 2002:a17:902:f685:b0:20c:6023:2268 with SMTP id d9443c01a7336-20fab2da17dmr99091045ad.40.1729849464273;
        Fri, 25 Oct 2024 02:44:24 -0700 (PDT)
Received: from dw-tp ([171.76.85.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02df41sm6361145ad.192.2024.10.25.02.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:44:23 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
In-Reply-To: <1efb8d6d-ba2e-499d-abc5-e4f9a1e54e89@oracle.com>
Date: Fri, 25 Oct 2024 15:01:03 +0530
Message-ID: <87zfmsmsvc.fsf@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com> <f5bd55d32031b49bdd9e2c6d073787d1ac4b6d78.1729825985.git.ritesh.list@gmail.com> <1efb8d6d-ba2e-499d-abc5-e4f9a1e54e89@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


Hi John, 

John Garry <john.g.garry@oracle.com> writes:

> On 25/10/2024 04:45, Ritesh Harjani (IBM) wrote:
>> Filesystems like ext4 can submit writes in multiples of blocksizes.
>> But we still can't allow the writes to be split. Hence let's check if
>> the iomap_length() is same as iter->len or not.
>> 
>> This shouldn't affect XFS since it anyways checks for this in
>> xfs_file_write_iter() to not support atomic write size request of more
>> than FS blocksize.
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   fs/iomap/direct-io.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index ed4764e3b8f0..1d33b4239b3e 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -306,7 +306,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   	size_t copied = 0;
>>   	size_t orig_count;
>>   
>> -	if (atomic && length != fs_block_size)
>> +	if (atomic && length != iter->len)
>>   		return -EINVAL;
>
> Here you expect just one iter for an atomic write always.

Here we are lifting the limitation of iomap to support entire iter->len
rather than just 1 fsblock. 

>
> In 6/6, you are saying that iomap does not allow an atomic write which 
> covers unwritten and written extents, right?

No, it's not that. If FS does not provide a full mapping to iomap in
->iomap_begin then the writes will get split. For atomic writes this
should not happen, hence the check in iomap above to return -EINVAL if
mapped length does not match iter->len.

>
> But for writing a single fs block atomically, we don't mandate it to be 
> in unwritten state. So there is a difference in behavior in writing a 
> single FS block vs multiple FS blocks atomically.

Same as mentioned above. We can't have atomic writes to get split.
This patch is just lifting the restriction of iomap to allow more than
blocksize but the mapped length should still meet iter->len, as
otherwise the writes can get split.

>
> So we have 3x choices, as I see:
> a. add a check now in iomap that the extent is in written state (for an 
> atomic write)
> b. add extent zeroing code, as I was trying for originally
> c. document this peculiarity
>
> Thanks,
> John

