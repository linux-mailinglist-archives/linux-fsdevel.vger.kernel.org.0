Return-Path: <linux-fsdevel+bounces-38209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B78C9FDC11
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 19:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C68161C71
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 18:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B837119539F;
	Sat, 28 Dec 2024 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b="AanS2JaR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728E78F34
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2024 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735412045; cv=none; b=ULBax4y27+a+8cqcfzoMhYWpyh1PwkORnJvgv8sIxyLEpJH7QSbkunId7VcMZMhs748BV9fyL1OHdnUVSn2yStocuOnQVulIV4jxwbHyffhEuhf3GlvTgP6GwL+lCJtgdCQb5UifSfzfOZL1HdHsJEQxKwBMYYJXCO5nakh4+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735412045; c=relaxed/simple;
	bh=Bx6utfrucYDjk/Ma5GOl5Si/kIydjJ8uP4TzaNJ9iyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0ttr+7mbqkcMvX1NGLpEIoeNPCRdG/hNoCfDlwE8Zjn3ObJsdo8Hoj2RXSwRCxdq3Y1JehjJ17He3XiMVIvB3UjkRGSd4mlSkq1ZB26xmPKwHlmvNUdIMNNAs6KOof+yVaFPoYQrUjpjpKk55ReQLzsDswmajT7alkDpnHWLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com; spf=pass smtp.mailfrom=colorfullife.com; dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b=AanS2JaR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorfullife.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so13388847a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2024 10:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20230601.gappssmtp.com; s=20230601; t=1735412041; x=1736016841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o4S0sqcHm4frtmlnS19N4Dv/daVSf9ZB3S3iMVK90YA=;
        b=AanS2JaRm3ZBg0bthkVruOgF7oB0tEbyw/GnEbRvPrtBwpUsgNYkGWAOB9xsL5G4gj
         1knbyzrNE+Sb/2wevC4y5B+B5YV5Ul8H9dh+FK91Pg2FSCYIQDGJA9bvtymMO8C6q6oH
         6whXu+V2sHzXqMGpvFc7OgDLFCcetnWhYkQW8zrvvxFwWswWO/Htc17vsM8LH3FZqkUD
         IGkLe4n32FxltYA+nFhA7RKLYsGRf5VxjW70jbmAjw2YmTIXDfj/vwColdjZZdHkHCmJ
         9fyXmqPnKw2EoiNVWeKiLD7kqP+mwg2Qkd0+Ztx0ei+aY042u+iUgRwnzoLTsBsfKHLI
         6daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735412041; x=1736016841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4S0sqcHm4frtmlnS19N4Dv/daVSf9ZB3S3iMVK90YA=;
        b=dlnU6Mi/qNyTDK9SBh4HxzZuatSmZg9alnruMdCBeBugUvrHJMedOKAOmDg0bjDcma
         kTb1jYQaTRiHgGkv7GVA4P2NucwIZUnWLGwqqTnQYBAhfkQuSqux/Y/7X+aEX8G+ZcJz
         tSqt+FBxfhn8hOnBlBtvj54O50JBCWKR04qHrxQV1mhCNUFVQbleYb0nudUb4ndTJMm4
         AykLCpCpH9ls51RT8BjvmBP9DDbTtJrVxLyhEwI9LK1+rR5xZhGgVRLNLHliJUYfsXu6
         NS/xZrkCv71S1tAPTewK28MeqeJd8ZWs4f9fdcxua4KCf0z0G7IGs3N48ibzCgoMM9TG
         qmjA==
X-Forwarded-Encrypted: i=1; AJvYcCWFgWz1DE5PZ/MhPxTWV1hsOpGv9TDfTnzyGBkMAXE6q8RJpGxNjiC9DQltX9EEIXkJUCU+5yEZgP0mZ8cK@vger.kernel.org
X-Gm-Message-State: AOJu0YyoyK0loxv9Nf4FGV10XJ316656C5Ww9gyqABu+Jz1/wqwYpCij
	mN6c3sjiskpXEjAlSyBaLz5zX/K/tMVny59t2xxMnoMy1enGZ8p102vcx0pwRQ==
X-Gm-Gg: ASbGncsRznHURNSySMEj4DRo3/0WdK1NWNWb9pK1aBA0yFrI39zO8pTTXNc4hxU24Y+
	OSJrQQ2H88sOVIqjSZJMD5lCvYe9s+oajclB4PJRXKncewZX/S2e2VyKFttFkYwz8iagaa+rn3O
	DelqufMRV4xE+Gh5ZC2e7FMz/vwWjFfj+I0pn6Vk407wKZhGk4xOCMXsMk4QEMcAtfap5mnvNFv
	uNv07CVmWGA2rFWsYb6CgDx0uB79FAgbUzWsTbwmyFuNGqOC1EwSt/zDVo+gUF4pLUTX2Yf6mra
	cflDQOC+g8gwIKzaMtFCWGU8tB0UIuUcB2GxrJzyTeVCAMMMk8b2wgkxM+TmeV1IW+mpFe1lyFj
	+Tqsn3h1yD1SPJYNgB5Y=
X-Google-Smtp-Source: AGHT+IHf9YD1SHw2OUXu56V+97edXC8Qj5MiJsLvI2eK3TkO2X6HY7zrYkCW9+id3cNuOI8zDkgtdw==
X-Received: by 2002:a05:6402:2813:b0:5d3:d7ae:a893 with SMTP id 4fb4d7f45d1cf-5d81de23133mr27217465a12.25.1735412040922;
        Sat, 28 Dec 2024 10:54:00 -0800 (PST)
Received: from ?IPV6:2003:d9:974e:9900:6aac:89d9:5e45:a0e6? (p200300d9974e99006aac89d95e45a0e6.dip0.t-ipconnect.de. [2003:d9:974e:9900:6aac:89d9:5e45:a0e6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a3d2sm12532440a12.16.2024.12.28.10.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Dec 2024 10:53:59 -0800 (PST)
Message-ID: <8d56b9d7-bb92-4c6e-ba8b-da3ec238943b@colorfullife.com>
Date: Sat, 28 Dec 2024 19:53:57 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 WangYuli <wangyuli@uniontech.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
 <20241226201158.GB11118@redhat.com>
 <1df49d97-df0e-4471-9e40-a850b758d981@colorfullife.com>
 <20241228143248.GB5302@redhat.com> <20241228152229.GC5302@redhat.com>
 <20241228163231.GA19293@redhat.com>
Content-Language: en-US
From: Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20241228163231.GA19293@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Oleg,

On 12/28/24 5:32 PM, Oleg Nesterov wrote:
> On 12/28, Oleg Nesterov wrote:
>> If nothing else, consider
>>
>> 	int CONDITION;
>> 	wait_queue_head_t WQ;
>>
>> 	void wake(void)
>> 	{
>> 		CONDITION = 1;
>> 		wake_up(WQ);
>> 	}
>>
>> 	void wait(void)
>> 	{
>> 		DEFINE_WAIT_FUNC(entry, woken_wake_function);
>>
>> 		add_wait_queue(WQ, entry);
>> 		if (!CONDITION)
>> 			wait_woken(entry, ...);
>> 		remove_wait_queue(WQ, entry);
>> 	}
>>
>> this code is correct even if LOAD(CONDITION) can leak into the critical
>> section in add_wait_queue(), so CPU running wait() can actually do
>>
>> 		// add_wait_queue
>> 		spin_lock(WQ->lock);
>> 		LOAD(CONDITION);	// false!
>> 		list_add(entry, head);
>> 		spin_unlock(WQ->lock);
>>
>> 		if (!false)		// result of the LOAD above
>> 			wait_woken(entry, ...);
>>
>> Now suppose that another CPU executes wake() between LOAD(CONDITION)
>> and list_add(entry, head). With your patch wait() will miss the event.
>> The same for __pollwait(), I think...
>>
>> No?
> Even simpler,
>
> 	void wait(void)
> 	{
> 		DEFINE_WAIT(entry);
>
> 		__set_current_state(XXX);
> 		add_wait_queue(WQ, entry);
>
> 		if (!CONDITION)
> 			schedule();
>
> 		remove_wait_queue(WQ, entry);
> 		__set_current_state(TASK_RUNNING);
> 	}
>
> This code is ugly but currently correct unless I am totally confused.

It is a chance of the add_wait_queue() path, thus impact on all calls.

With (busybox) "find /sys /proc | grep aaaabbbccc", I've seen 16385 
wakeup calls with empty queue, and just 6 with an entry in the queue.

But on other workloads, the ratio was more something like 75% 
empty/25%with entries.

I.e.: We would have long discussions if the change only helps for some 
usecases, and might have negative impact on other use cases.


And: Your proposal is in conflict with

https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/kernel/fork.c?h=v2.6.0&id=e220fdf7a39b54a758f4102bdd9d0d5706aa32a7 


But I do not see the issue, the worst possible scenario should be something like:

	// add_wait_queue
		spin_lock(WQ->lock);
		LOAD(CONDITION);	// false!
		list_add(entry, head);
		STORE(current_state)
		spin_unlock(WQ->lock);


--

     Manfred


