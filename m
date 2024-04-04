Return-Path: <linux-fsdevel+bounces-16112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAE7898843
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 14:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004881F21DDA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 12:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E734182869;
	Thu,  4 Apr 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Vb5l3iau"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5589745C4
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235087; cv=none; b=uN6N8aNPfCThotYVe72LXc7DutzWkVdffEi87FCb66hP5EU0oCxGoACyeWXZqxg9/1xoHVfNHXE9wwoUZXoHkTpSz5Q4xjweQxKRJj3zbHxTBoiVyp5oAqfDFw0vwswoWVYRzjujC1ReYss+yoB727339DoIMVActqqmUHMhg84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235087; c=relaxed/simple;
	bh=6mmk60SJwL0LXWdZ8yrVVh1oB9nLf+a+MA2UbF/G0Nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjYmnWjYCqGR4oHDvVmt85+W5PU2XyD3uWqxwbjqProdQDoyjQOS4dQwJnr15p1KssoCHcmU4drTVTIGjSgY6NUOsiwjH4u6suo/+HPia3mlUUtHq1yjliQOsDIESM6pNEYi1kQLLE2xKLwfsfUakeJKr72HS3MmIx9H1buzGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Vb5l3iau; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a4930d9c48so165002eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Apr 2024 05:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712235084; x=1712839884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dilzk8OWnGF3Bf9NwUgRR1mfv9NXWl/ZDYX9xlEWStQ=;
        b=Vb5l3iauXqNex1rxcOcEjCVFW5+iWQhpjMF3kQhm6uBmlV4ZVYvILJlfhyfpeg4bEo
         eMCmOMvG0xoSABIt2YLOFCBNHFl9bpMtLdR2uOcSnAoTttDh6mtgocOnE+hvtG7Zv1O5
         FnY8KwWmOvp8NDgPC3mFgPUgoGGw6/b6c/upIUAuL6dTxQIwE8g6/SNbv03uxdcTeqR9
         EP0+KhPReopauw725KM96+4eNrw3zL7+/f6KVJfOuEi6psjT4WHw8lpY2Kgh0vK1N8qX
         Jo990re/wiNNX7eqDIaAu162kkQO5B3PqP2jac3f0EcMMI320e0TmwdSBSXxUWk2cJ3b
         S09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712235084; x=1712839884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dilzk8OWnGF3Bf9NwUgRR1mfv9NXWl/ZDYX9xlEWStQ=;
        b=MdEpoZrVElbx0/WMcMXk4s62AQb616zkB46MEzPpyhHNQAkZ0hv47f0TLUUQ4KCbgG
         jf5186LoeuXknvFP50tl1FNr/zbuzQxf7HIZkl3MdxCTr+D1W1fScWpnX9qBDIm4jI86
         TYUpBs7g0Uud1t4hFryM6F5mzGf4n7sgQVFqTQXxDUEP1frdz0iwul/SMha8Nv3BWJcf
         K7iDiIji2+ohW7Ka3Vnn5t8xydQIPvwExhfVGuJ/Z1g5hdUO4UIZYpwoArNdBsSc7err
         KqelnMzu2FI/1E4iZBFgffuF1/YQGHjSGA5mpzW+H10UXii41kNjkXzOEotc+uhHCu/x
         HmZg==
X-Gm-Message-State: AOJu0Yy7WZG3JMhbm18vahM1R7RnljLKl7TJl02ROB1a5tkxFc33q1jV
	fhDyOwOoMCeTakVKst7BR/MNApNoGMhcbXC6sEe4A6wAM+cZhGLIXJjfM8pZFqSRY9KT/1ONwbK
	A
X-Google-Smtp-Source: AGHT+IEOyTdjzEM+MCVLEuWyT1lE/tYHGjCVZ1Xw0SF+ZD0utMXPJq0W7lqLBA3lNOcCFZ2B3tN5jw==
X-Received: by 2002:a05:6358:3414:b0:183:e7b6:60b1 with SMTP id h20-20020a056358341400b00183e7b660b1mr2236039rwd.1.1712235083603;
        Thu, 04 Apr 2024 05:51:23 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id b26-20020a6567da000000b005dc507e8d13sm11739074pgs.91.2024.04.04.05.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 05:51:22 -0700 (PDT)
Message-ID: <6bb82916-7c79-4af9-9dd1-f668845aa418@kernel.dk>
Date: Thu, 4 Apr 2024 06:51:21 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] timerfd: convert to ->read_iter()
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240403140446.1623931-1-axboe@kernel.dk>
 <20240403140446.1623931-2-axboe@kernel.dk> <20240403224037.GM538574@ZenIV>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240403224037.GM538574@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 4:40 PM, Al Viro wrote:
> On Wed, Apr 03, 2024 at 08:02:52AM -0600, Jens Axboe wrote:
> 
>> -		res = put_user(ticks, (u64 __user *) buf) ? -EFAULT: sizeof(ticks);
>> +		res = copy_to_iter(&ticks, sizeof(ticks), to);
> 
> Umm...  That's not an equivalent transformation - different behaviour on
> short copy; try to call it via read(fd, unmapped_buffer, 8) and see what
> happens.
> 
> copy_to_iter() returns the amount copied; no data copied => return 0, not -EFAULT.

Gah yes, ironically I did a bunch of conversions yesterday and it's all
fine. Not sure wha thappened here. I'll fix it up.

>> +	ufd = get_unused_fd_flags(O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));
> 
> You do realize that get_unused_fd_flags() ignores O_RDWR (or
> O_NDELAY), right? Mixing those with O_CLOEXEC makes sense for
> anon_inode_getfd(), but here you have separate calls of
> get_unused_fd_flags() and anon_inode_getfile(), so...

I do, but figured it was cleaner that way. But I can change the flag
passing, ditto for the other ones.

-- 
Jens Axboe


