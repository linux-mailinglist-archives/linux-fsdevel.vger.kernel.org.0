Return-Path: <linux-fsdevel+bounces-47514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDACA9F1FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 15:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012F7189079E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D6826A098;
	Mon, 28 Apr 2025 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKjNnPZu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4001FE455
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846318; cv=none; b=HyJC2GupNTaJ0qM7FGyjD5ncAJhGBwNVd+lY9RID/x5jL3VvBIIFBGp29n0qCNJA/FxOSPT3kgXAFTUjNht9HrW/fDnoF7OiEI+UEKzDVMHdC54jJPqfGf9A70SjxuiKTO9TmI88AFUVFEY/jvv2RFnamf+kEE2k2u9+5lfqvmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846318; c=relaxed/simple;
	bh=cgGOdJdQKd3Sd5NLjSW5tNE5E8ySLu8H4Y6uiXifc/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCuqJSxWtMlc2ureHFV7ljha4xxR0swhiJ7ZtN2nmdEjJhIX5Q3fkhpTiD3S477wEXe25VPq0ay3lXGFDTYA1HL1LHViIF+65dYrcTwfM1AA6To3HrlOi/m1Q7xOMYbvTmwxIO8NvkC//XB69Cvr+f4a5xng/Ru9SXlvJHEz9J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vKjNnPZu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso42878515e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745846314; x=1746451114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QLjtDonXd6nOPiRG5veDBiA9DDAtKfzTU28EI3o9QMU=;
        b=vKjNnPZuUMWCMgarIuUnftlQ9fHDwAUQOpv4x2zGvZHrn0+9wge39X8AqAU9dg2O0G
         0yx1kCJ6ILZw88U9NhGFqXlUTU8AMXzqyPy2L0TgVCtrqSzIGSo5xx+cAlRf4WJIUYse
         UpwB0mXZ5r3qs1tgZCy5SoNZgXEHPt23RyTmicDc0Ba2VFXZyi9lmJzwCND6YYGD/ZPc
         V7LF0dMuddTAPdz3k5NZXt5YsdMnEH2Jq2CFUFKR5UBRFaAPj4CxLQkeKLFlvCLV6Xto
         /pDzFKCH0zbbh3R4DWdZMurEinVgCO05cVzaFL2juaijasPj0nX2Ln0EI5K1y8/CbOC6
         bwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745846314; x=1746451114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLjtDonXd6nOPiRG5veDBiA9DDAtKfzTU28EI3o9QMU=;
        b=h7/TNZ2ERG0p4ey0ANvpdlKhIjpSkW/o4B3BF0c9l2ftTfy3Qb3XrcZO+krOIOwoH0
         w7deOPvaKv7w5xDGPpzc2XUfSk3KHFOb5VCJZrIyv+dwsNLTFEQeiAVM8J5am8YkqVPJ
         pb4VVwGPNTn94lgOs2YcsA13Vlw7l0ShAxGpAodymgJH397gRSjkO+3H0HsfjFQQq2Le
         oiLdSld81m0QX6NKT+evmyiw8sVG+SvHAuNj2EH2uM+BWcTirv+5w4hLlfNFx2UsDXsN
         Yd+NC144yRvXmU5Y88ViIgagvo6NFqW1Kfme3hESpAzoZ25Cj/C6R3cmAV/e/eyq0gMh
         oGUw==
X-Forwarded-Encrypted: i=1; AJvYcCUtfib4qoE9HqG1pav7N21epFaf+eugqNK29i8LfZZZ/CfH/wy09V4VMbQKJPmVaK+aojTZKVVJr7tqzO0C@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4OCWZlGRrVaP7CgGae56hQOdfQ7BYliRjfDBdAX1UOS/pmaFr
	YQk9MiVHb5Ky4rdi7TYeWSMDDwihJfAjP0cVqtPxKgu49QHD9SlyQtU3wnjBFSM=
X-Gm-Gg: ASbGncvQ0BBqsOAkBuWJtBE2aY21smZ3FPJyA+8Wos3+xwgXpamGqSO6xKY/PLlLwLV
	mhJzeDttj0+AVlUft8MgTXsK61LbBKzfHiynjl20kk6a5NKeJzE5L07Nu/qFwshKxPVnkneES4l
	37mN/SnQYg9E6yOomb6bqhivuNRM6S2QRRIDihRaoCtPflUZRGskPNF8oZxqfuvRwlx/CNKWDu+
	91Wr8hbHnctgwgMKoqKZGr97enzFfQ7Qs4PtFwoj5zhkUnaGPMH8GNQeXTYTc2wzoU3iHVCpQOJ
	J035Cf+BvYkX9GRvNUbwTDveOwa9433mf8GS9OC+lv29qyddQA==
X-Google-Smtp-Source: AGHT+IEstSuLcp0r6LTE8DVYxX00SLEy2jiuNAsyGuZuIWabf9Oo9L//GavpHSs2zltChGRSJdTLVA==
X-Received: by 2002:a05:600c:a181:b0:43d:fa59:be38 with SMTP id 5b1f17b1804b1-440abe464eamr46893135e9.32.1745846314445;
        Mon, 28 Apr 2025 06:18:34 -0700 (PDT)
Received: from [192.168.0.14] ([82.76.212.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a538f4aasm122672975e9.38.2025.04.28.06.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 06:18:34 -0700 (PDT)
Message-ID: <d8b619d7-6480-411d-95cb-496411b47ff8@linaro.org>
Date: Mon, 28 Apr 2025 14:18:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs/vfs.fixes v2] eventpoll: Set epoll timeout if it's in
 the future
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Alexander Duyck <alexander.h.duyck@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20250416185826.26375-1-jdamato@fastly.com>
 <20250426-haben-redeverbot-0b58878ac722@brauner>
 <ernjemvwu6ro2ca3xlra5t752opxif6pkxpjuegt24komexsr6@47sjqcygzako>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <ernjemvwu6ro2ca3xlra5t752opxif6pkxpjuegt24komexsr6@47sjqcygzako>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/25 1:14 PM, Jan Kara wrote:
> On Sat 26-04-25 14:29:15, Christian Brauner wrote:
>> On Wed, Apr 16, 2025 at 06:58:25PM +0000, Joe Damato wrote:
>>> Avoid an edge case where epoll_wait arms a timer and calls schedule()
>>> even if the timer will expire immediately.
>>>
>>> For example: if the user has specified an epoll busy poll usecs which is
>>> equal or larger than the epoll_wait/epoll_pwait2 timeout, it is
>>> unnecessary to call schedule_hrtimeout_range; the busy poll usecs have
>>> consumed the entire timeout duration so it is unnecessary to induce
>>> scheduling latency by calling schedule() (via schedule_hrtimeout_range).
>>>
>>> This can be measured using a simple bpftrace script:
>>>
>>> tracepoint:sched:sched_switch
>>> / args->prev_pid == $1 /
>>> {
>>>   print(kstack());
>>>   print(ustack());
>>> }
>>>
>>> Before this patch is applied:
>>>
>>>   Testing an epoll_wait app with busy poll usecs set to 1000, and
>>>   epoll_wait timeout set to 1ms using the script above shows:
>>>
>>>      __traceiter_sched_switch+69
>>>      __schedule+1495
>>>      schedule+32
>>>      schedule_hrtimeout_range+159
>>>      do_epoll_wait+1424
>>>      __x64_sys_epoll_wait+97
>>>      do_syscall_64+95
>>>      entry_SYSCALL_64_after_hwframe+118
>>>
>>>      epoll_wait+82
>>>
>>>   Which is unexpected; the busy poll usecs should have consumed the
>>>   entire timeout and there should be no reason to arm a timer.
>>>
>>> After this patch is applied: the same test scenario does not generate a
>>> call to schedule() in the above edge case. If the busy poll usecs are
>>> reduced (for example usecs: 100, epoll_wait timeout 1ms) the timer is
>>> armed as expected.
>>>
>>> Fixes: bf3b9f6372c4 ("epoll: Add busy poll support to epoll with socket fds.")
>>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>> ---
>>>  v2: 
>>>    - No longer an RFC and rebased on vfs/vfs.fixes
>>>    - Added Jan's Reviewed-by
>>>    - Added Fixes tag
>>>    - No functional changes from the RFC
>>>
>>>  rfcv1: https://lore.kernel.org/linux-fsdevel/20250415184346.39229-1-jdamato@fastly.com/
>>>
>>>  fs/eventpoll.c | 10 +++++++++-
>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
>>> index 100376863a44..4bc264b854c4 100644
>>> --- a/fs/eventpoll.c
>>> +++ b/fs/eventpoll.c
>>> @@ -1996,6 +1996,14 @@ static int ep_try_send_events(struct eventpoll *ep,
>>>  	return res;
>>>  }
>>>  
>>> +static int ep_schedule_timeout(ktime_t *to)
>>> +{
>>> +	if (to)
>>> +		return ktime_after(*to, ktime_get());
>>> +	else
>>> +		return 1;
>>> +}
>>> +
>>>  /**
>>>   * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
>>>   *           event buffer.
>>> @@ -2103,7 +2111,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>>>  
>>>  		write_unlock_irq(&ep->lock);
>>>  
>>> -		if (!eavail)
>>> +		if (!eavail && ep_schedule_timeout(to))
>>>  			timed_out = !schedule_hrtimeout_range(to, slack,
>>>  							      HRTIMER_MODE_ABS);
>>
>> Isn't this buggy? If @to is non-NULL and ep_schedule_timeout() returns
>> false you want to set timed_out to 1 to break the wait. Otherwise you
>> hang, no?
> 
> Yep, looks like that. Good spotting!
> 

I second that. Also, isn't ep_schedule_timeout buggy too? It compares a
timeout value with the current time, that has to be reworked as well.

I see this patch already queued for stable/linux-6.14.y. What's the plan
with it?

Thanks,
ta

