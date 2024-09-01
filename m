Return-Path: <linux-fsdevel+bounces-28146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E417D967573
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 09:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E301F21DCE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F402614290C;
	Sun,  1 Sep 2024 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOEGwOy2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96424A1B;
	Sun,  1 Sep 2024 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725176128; cv=none; b=QXOviUkN/BKHjsJ9WgpFBY2tuDhiyLCX8xSzMgnGnmQD3P2Y/28LB8/QwvbdiTVh+pXDCJ8olaQdfM/j/Shw9z5gAVMKiURywc6a1EjyDec2a2K0INOPeI3MYdKPaVC6zhdziBtdieyJlwDk0tdmgu53ttc3q02knO42c8aVBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725176128; c=relaxed/simple;
	bh=xb2w4zkpdpNjvY/zJYCRxZq9smLkIi0O47kz49XBMuk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a4TMPnNTH0rwYBVbP6PlqYBMGBJLrCcii61/DRrYG1Jh6CHppf2SaEls+i5NpiP1frfXLDVrbQ0t4AYNtKKEaSpI1358dVHq3odPvxuBUyeXnNtfET25feGnbyIZQt19tO1kbt9k67XSzVxkBdAABc94WVDoSf7OdtE091dU690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOEGwOy2; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c35b72f943so5115386d6.0;
        Sun, 01 Sep 2024 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725176125; x=1725780925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zRk8FmcCEyWHwfxzNws/I37iaouQcScazIoErvdmxJQ=;
        b=XOEGwOy2V1emqBwyWmUL9H1BDodzlh+277M7UFlicvb2pHpz4VAsqAR4x/M6Vw+6BE
         0mDOyFKnkYrj4MIpgAPSCUAEgU+AbSo7eZr4j0Q9ONWkHtwwSf5fneq0gQOLKM+7hjZF
         mIM5V7rZ0wx2XVWuT5r3Vk9Upp1dVd9ltZu5hYqHSfdeSzCz7In4eNdeWNs+ViqzqlUB
         Kf+/qRqWxkDnMb4/DCC7LtYiA9/JAQbl1ttLTU6+H2o3+OyJwlbjyVB21DD4c7at46MW
         sVyXo3opWwVcHcuafb4gml32WcpmzxtmbLlhkBhNHOKfU7k4N9LhON88HesEqgEULyDn
         34rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725176125; x=1725780925;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRk8FmcCEyWHwfxzNws/I37iaouQcScazIoErvdmxJQ=;
        b=mA4yxlAtw6zm/hgiPXwlJTxYcZgpv826Pyrb3LJwPTOEMHJAxo2xeXrlLLMExzt5a9
         8rNIRG1uXX00pjfa9rC1UsexwvqREZS+imJ8J5fZfQ4vLTf1tIn91CK0ob8UPJUnyeCM
         lPQbN3B3e9mjOmd6Li0tAY4lq0soZ8HveUjdsoBS7PC9z3DcdCUWU0DIzs2u+zt43HMQ
         g7C1oe++jhYdM0EIBuw5mT+dE7x23PJd+PCd8kPaHYa/F+R6aiLSd10ch7TM2vj0bn8z
         misfCjkdHS0b2v5lMIBUjARUSe5Km4kO5vhQ/AGW6hhLt1lUuiJE4RVXZhYKE94qZNTT
         GPAA==
X-Forwarded-Encrypted: i=1; AJvYcCU3P9VPKDjAU0lhR8MQhJtvOz03M272xKt/HeizMclLffplP0dU9L0gr+EHiBcNfkCMsTmWks1Arxy9n/cA@vger.kernel.org, AJvYcCXhNqimnajfgN9wRbdsn530NonC02iW6Ox47Rc46qs45w7i9D39extp2ZWvPLg814RLjYlWamvXcfmfC5Gm@vger.kernel.org
X-Gm-Message-State: AOJu0YxHXT3uiXXuhWsp/YgZzai1ux+bOPYyZlR3NEdcS1/DWQkc1OiW
	ztUsIU/qeo0wuWrpWrFpIJD3A4Vp2Tat0Baz+UL0zlTuzIiJ0xQd
X-Google-Smtp-Source: AGHT+IGopVNCbqfR8SyeF9VBFoj3evG9Be/sQnBDiT7qZGdARPPheaeMeOqIT+iO4r/GipINmuMAEg==
X-Received: by 2002:ad4:5f45:0:b0:6c3:5e89:3b60 with SMTP id 6a1803df08f44-6c35e893d2dmr34342936d6.3.1725176125433;
        Sun, 01 Sep 2024 00:35:25 -0700 (PDT)
Received: from [10.36.8.169] (pat-199-212-65-137.resnet.yorku.ca. [199.212.65.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340ca58f1sm30672066d6.108.2024.09.01.00.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2024 00:35:25 -0700 (PDT)
From: Iman Seyed <imandevel@gmail.com>
X-Google-Original-From: Iman Seyed <ImanDevel@gmail.com>
Message-ID: <3e61af1f-5dd6-4bf1-ad9d-047d015f3888@gmail.com>
Date: Sun, 1 Sep 2024 03:35:24 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] inotify: set ret in inotify_read() to -EAGAIN only when
 O_NONBLOCK is set
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240901030150.76054-1-ImanDevel@gmail.com>
 <ZtQRKfuawk6borTL@visitorckw-System-Product-Name>
Content-Language: en-US
In-Reply-To: <ZtQRKfuawk6borTL@visitorckw-System-Product-Name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kuan-Wei,

I just looked over the assembly generated by GCC and Clang
with the O2 level of optimization, and you're right. Both
Generate the identical assembly. It seem like my patch
would only affect the appearance of the code.

Kind Regards,
Iman

On 9/1/24 03:00, Kuan-Wei Chiu wrote:
> On Sat, Aug 31, 2024 at 11:01:50PM -0400, imandevel@gmail.com wrote:
>> From: Iman Seyed <ImanDevel@gmail.com>
>>
>> Avoid setting ret to -EAGAIN unnecessarily. Only set
>> it when O_NONBLOCK is specified; otherwise, leave ret
>> unchanged and proceed to set it to -ERESTARTSYS.
>>
> Hi Iman,
>
> Have you checked the code generated by gcc before and after applying
> this patch? My intuition suggests that the compiler optimization might
> result in the same code being produced.
>
> Regards,
> Kuan-Wei
>
>> Signed-off-by: Iman Seyed <ImanDevel@gmail.com>
>> ---
>>   fs/notify/inotify/inotify_user.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
>> index 4ffc30606e0b..d5d4b306a33d 100644
>> --- a/fs/notify/inotify/inotify_user.c
>> +++ b/fs/notify/inotify/inotify_user.c
>> @@ -279,9 +279,11 @@ static ssize_t inotify_read(struct file *file, char __user *buf,
>>   			continue;
>>   		}
>>   
>> -		ret = -EAGAIN;
>> -		if (file->f_flags & O_NONBLOCK)
>> +		if (file->f_flags & O_NONBLOCK) {
>> +			ret = -EAGAIN;
>>   			break;
>> +		}
>> +
>>   		ret = -ERESTARTSYS;
>>   		if (signal_pending(current))
>>   			break;
>> -- 
>> 2.46.0
>>

