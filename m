Return-Path: <linux-fsdevel+bounces-38201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 030479FDBB4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 17:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD901881EF9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922EA18A6CE;
	Sat, 28 Dec 2024 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b="DVlWArlU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C99474
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735404322; cv=none; b=PdY1HWxpFUPdrHmaG+3eLn84YU6+pZWG8cPG7nYHhzAbRczkluyD+Lk7cKQb3FftVySPt6zLgrk1YaiBkVe/vneYcLmXlUG9cFs4DWAYPpUq+dKP1H5lBb9BmkrQWilG/3ocZYTmJkUn1YImy1WmuOpgLAJ3uuB1Ec1sSN1OAXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735404322; c=relaxed/simple;
	bh=XPRidIZVC18CQUlEKufW8F52jxa4BJHyPOo2xrs11V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/k+JZXK2VFaN42eqcWasIujY+WeSd3+5hjmbEvNQV2na07h3candZJcoSzY3OV8yH33A4kXg/rxk+DFt/sp+38C4aL3zaQ2iki0UYSvE4zBMLOJpU08LgFf9QG9eVMCD4yFoRyJsXX6UexlornmKAe6q1Rddujx5SX2gp/vixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com; spf=pass smtp.mailfrom=colorfullife.com; dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b=DVlWArlU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorfullife.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so15801500a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2024 08:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20230601.gappssmtp.com; s=20230601; t=1735404318; x=1736009118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cz1VqmSfgwulj4TtgG0EFMyBOjhXN78eW0/1No1Ds5s=;
        b=DVlWArlUBAMQJbrOEpknvPgE6MCbg52xa47A0eVowXnoLhmSldmT7SuMX/kiU+xaAQ
         mh0uKIddoNfiAWZb/l8R7QjcTQnlPedjrIFDF+9tWkBDtTmDjFYdQ5RI8FFGysyNdJqI
         RH6EdaKdRuhKL1Q6rOpa6wGZuGm27lODmIlA366H7JehGyB3xdDGUtyOLLrtvF8OCTkv
         BD4kYkXhKtQvFTlZA1y3JgICJU5Flqu92i3iS4bqnj0gfvE0L3t2QgA8nReSqXfII+pc
         PUf05uwqM2FDgVqFEAMns9jnWQ3bkHgbIjzclc0ek9X0QlCcyVlb8Bvc/l9+nBcB4HOd
         Clvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735404318; x=1736009118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cz1VqmSfgwulj4TtgG0EFMyBOjhXN78eW0/1No1Ds5s=;
        b=IUmd7Vq6IcepKzbg4rq4NGhQIHLjsVlWKAAsgxc+NFEuLzmXacl0MUN6MgnpbL/ax8
         45tPa9LtZltZn+vjEsHczo64YDXaTNhYUIbCra1XpuvlryM3B5kQxRf/Aacx/teVrnmZ
         9fM/iXz4bp6wi/eZ8IzqA/Kx/XtRKG0LG+uFV1kL7/FitCXDUWP028N6mcC840nLuJIC
         uZJrcQkovC7yH1iLUSdOF8ljBSBRk6hOsbMYZQnn6MwrLS6kQeWdymePecDb7gDLkj7r
         nSQMyWGfBwqfZWWhSNWnBhjK+qyO0HMsO3ZAWoA+JDiQF02Ie0dcNXnBMIq5ulX8moZo
         Poiw==
X-Forwarded-Encrypted: i=1; AJvYcCXbnZuorh/2qt/R4D+H3cZt7030Q+kAMOzpOGBqS8E1dMQkwcqeD4ggEZomFBisD4dYBu8CCzx9uhI/OKBA@vger.kernel.org
X-Gm-Message-State: AOJu0YyZpsETUfcr62VSrEzYEymXxbzKh7FTfD6XkuGSC1Iyysw7bjQQ
	Sq2Dx8VUr5fJUS2BCPuh8Jano/3QI7OIk0V0yaEaAWE5DURIsa3jPnO4cxhynw==
X-Gm-Gg: ASbGnctzNVEsbTdpEXNvpmrN+r6StwiWHrvFJYj6/noq5xEYjQWLmPZAPWmyc4iIL+U
	R28GLJ5089g5An0nuYhqWigBzYYcKxlF5mIu8nus2mRrfwn/smY086avn4Kge08sWc/QJ7z50Dw
	lOOfLp2Tl5rN3efvwWROZeKis9Mjl2eVcBO8WDv7ezLZPE1TV7wHaKsdKFh8USE45sbSUTqgHxE
	gpKm4z5MaPftRM99YNBT2A+ckyA7v+qeLkiTJqhC1uCtRatfKLl0Qb609HZiEC2R7Fub/p9//3+
	dGfmiOmGJ23lD/YTHU5+d+0hTksxG08LNsPwZ37a9wsT3j9SbdNYI+cOCCloAmeY8AWFkIgM8Dg
	Q4FNUciaZuWtSfSL1I8o=
X-Google-Smtp-Source: AGHT+IEwCOkVYEmRIyllgGUbBkB/nkRg+m8awrnv/+Y37IbH6AsgZsVAegd6S/68CdBE0Kokug+VPA==
X-Received: by 2002:a17:907:7f8e:b0:aa6:9198:75a2 with SMTP id a640c23a62f3a-aac334e51afmr2680214366b.44.1735404317930;
        Sat, 28 Dec 2024 08:45:17 -0800 (PST)
Received: from ?IPV6:2003:d9:974e:9900:6aac:89d9:5e45:a0e6? (p200300d9974e99006aac89d95e45a0e6.dip0.t-ipconnect.de. [2003:d9:974e:9900:6aac:89d9:5e45:a0e6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e895366sm1258629566b.73.2024.12.28.08.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Dec 2024 08:45:16 -0800 (PST)
Message-ID: <addb53ac-2f46-45db-83ce-c6b28e40d831@colorfullife.com>
Date: Sat, 28 Dec 2024 17:45:15 +0100
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
Content-Language: en-US
From: Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20241228152229.GC5302@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Oleg,

On 12/28/24 4:22 PM, Oleg Nesterov wrote:
> On 12/28, Oleg Nesterov wrote:
>>>   int __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
>>>   	      int nr_exclusive, void *key)
>>>   {
>>> +	if (list_empty(&wq_head->head)) {
>>> +		struct list_head *pn;
>>> +
>>> +		/*
>>> +		 * pairs with spin_unlock_irqrestore(&wq_head->lock);
>>> +		 * We actually do not need to acquire wq_head->lock, we just
>>> +		 * need to be sure that there is no prepare_to_wait() that
>>> +		 * completed on any CPU before __wake_up was called.
>>> +		 * Thus instead of load_acquiring the spinlock and dropping
>>> +		 * it again, we load_acquire the next list entry and check
>>> +		 * that the list is not empty.
>>> +		 */
>>> +		pn = smp_load_acquire(&wq_head->head.next);
>>> +
>>> +		if(pn == &wq_head->head)
>>> +			return 0;
>>> +	}
>> Too subtle for me ;)
>>
>> I have some concerns, but I need to think a bit more to (try to) actually
>> understand this change.
> If nothing else, consider
>
> 	int CONDITION;
> 	wait_queue_head_t WQ;
>
> 	void wake(void)
> 	{
> 		CONDITION = 1;
> 		wake_up(WQ);
> 	}
>
> 	void wait(void)
> 	{
> 		DEFINE_WAIT_FUNC(entry, woken_wake_function);
>
> 		add_wait_queue(WQ, entry);
> 		if (!CONDITION)
> 			wait_woken(entry, ...);
> 		remove_wait_queue(WQ, entry);
> 	}
>
> this code is correct even if LOAD(CONDITION) can leak into the critical
> section in add_wait_queue(), so CPU running wait() can actually do
>
> 		// add_wait_queue
> 		spin_lock(WQ->lock);
> 		LOAD(CONDITION);	// false!
> 		list_add(entry, head);
> 		spin_unlock(WQ->lock);
>
> 		if (!false)		// result of the LOAD above
> 			wait_woken(entry, ...);
>
> Now suppose that another CPU executes wake() between LOAD(CONDITION)
> and list_add(entry, head). With your patch wait() will miss the event.
> The same for __pollwait(), I think...
>
> No?

Yes, you are right.

CONDITION =1 is worst case written to memory from the store_release() in 
spin_unlock().

this pairs with the load_acquire for spin_lock(), thus LOAD(CONDITION) 
is safe.

It could still work for prepare_to_wait and thus fs/pipe, since then the 
smb_mb() in set_current_state prevents earlier execution.


--

     Manfred


