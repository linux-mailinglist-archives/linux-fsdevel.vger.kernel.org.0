Return-Path: <linux-fsdevel+bounces-38247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84749FE080
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 20:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F48161C9F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 19:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A00E19924D;
	Sun, 29 Dec 2024 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b="WpRZR31a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3415B122
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735502088; cv=none; b=XDznNfNjZTQGjipznSc4GeOOh2Jcv92tNHgenI4sI2jIm+1Ov8IIVIPXRRWYlPbHPG4RFNsg7pRYKRrkDt1FEVj21xwWFxsYRNNfeAvl8qSW515TBRYCRCll8B26CQsEQm7qOiCYXw6pSgvl60oAvBtMpc1JA5cAW4SxIARLVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735502088; c=relaxed/simple;
	bh=89exbBplTDFMEPCbOMpnMwdjSE0lo3ARCbzg7lyHf3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubU9jDatV2fUlEss/Q4F5P0Nbe6PtUaMQJVOXkpsmDlAMcFrbVPT4wSAVBb/owWtFKbT3hycd9wSuPZYslNXcmVGg4HCxh0LhrRJ/fGnh6Qrm7KKVuwZ6UotQ+gkYk0lF1mpKfE7RmzZJK0fIpAzkTTaUN8sXpLMyLxvedgIKd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com; spf=pass smtp.mailfrom=colorfullife.com; dkim=pass (2048-bit key) header.d=colorfullife-com.20230601.gappssmtp.com header.i=@colorfullife-com.20230601.gappssmtp.com header.b=WpRZR31a; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorfullife.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa689a37dd4so1302039666b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 11:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20230601.gappssmtp.com; s=20230601; t=1735502085; x=1736106885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6rLOEzdCsvFVb2NPJLn8m6iPng/kY6RSTEP5K2vQx0U=;
        b=WpRZR31aqAiXRfO3Mx5hXmnDD63pg24UjkyIJhQKY7l3/fxvn5+Nzm6WQczQEwkCal
         BCZEX5TDqEfOR9V6xcO4LEjr9WXajxidDSZNRAfc0ptmzuuHU74QHQIs45/34A65D/pv
         pFigTCYpYIKJqwF04pW/pXGBS+TsAfj7JnOHuElcq4nie6kCH6sZRI6CviGNhychLHl/
         cKXrTpQcPsd99WuhWohNatZfCla0qOEhaX22qvPkSxHMKcOulqvm6tP2P3QTDGNMgzc/
         xmwJiNK5fTevhBQaQJjWlyTcYqpkL2UFwXF49A5nTqskMPheJ2seqP3MY+WEyILQgTKG
         6CYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735502085; x=1736106885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rLOEzdCsvFVb2NPJLn8m6iPng/kY6RSTEP5K2vQx0U=;
        b=JZ79F6vzDWzGMS46p6yDT/+RLfAGoY4RewN2sgGqsM2iBEMWJYXobCgI7CAGKu9FyS
         T2UAQUwUE0UoRu7E35Uq79fEVLEiWrDkfPORsAXCeO/3B488bMwqyiWIsX+S6S4SReD7
         stJUdmkRwT13OjGoGAw9C2pPMknBApFTNF3OEJka+uXr5n0aoWYlA5GpjbEB1kl6SyXr
         //YAOdnwsAeIQCT3NZs36rCbTo/wDqC8ZGNWcyVAedVo7RGOIYF8Q/bWaZf3VTQjQbvY
         /y3W8F0sJSWJBGjyboaueLKs5RrJyZbxiGsNrtTdKRMFYlK68sQUFBHR9xCGGxlUeOVy
         cBlw==
X-Forwarded-Encrypted: i=1; AJvYcCV4mxnmQDZUZgIFErzq0rGdgbjynKCJ/qxaimgjC1TCcUsR5mN0/ZbhKAsVdIfLHdGbEYotTuaobRzggfgy@vger.kernel.org
X-Gm-Message-State: AOJu0YzEIMrofN8lhypaR95+GWHDaGEMgjmd/+qRDugue45xve6FXmaj
	i1cSJJHM+ar5M2n5pcsjbsznNpztWf9QMyouOv9yH2MXseG3fONubnNDznsWjw==
X-Gm-Gg: ASbGncs2DGg09ursVl270Mc8u2gNkzxzlyiN8G0+FPZsk80AJeKXHZP7I1QGgqHmXhK
	jD9Ogyt4nnmm15Y/wnDeFNu8IW1aDOyCRBHqU+zEngs9/mE5sF+yKYmVb22XBWQzmcOQ8BJMXlf
	o8z5gj2uI1EDp9URBnHO1Va2u9kDyCvaotw29lY9mTm+JJOx9IfuKzQY+RjnS5x/s6O5DE72uxX
	NbuATz1lMP1M/bCxKpl/VZgUFh0gvxmHTwTh5hmCYPlmCnmodw9PPLeGxqKoytLxzBaf/ee1LRB
	LoIfkBeKa9rf9ViJ/R/lt5Kx7Sxat+9GCoDU27phgTM+idfEhhAtxGISF5pQ5B9gxN1YKg4g2Tj
	nn+aBFHKRm+o1vljf6Q==
X-Google-Smtp-Source: AGHT+IGNaYL5uK3mtFpgyy53W/IFSqxzcnP9vMbLH6FJ/DvBzoqOMAA/v+EAyySZBikXDWZJJLZecQ==
X-Received: by 2002:a17:907:3da2:b0:aac:1ff1:d33d with SMTP id a640c23a62f3a-aac2ba3f45emr3130153266b.30.1735502084431;
        Sun, 29 Dec 2024 11:54:44 -0800 (PST)
Received: from ?IPV6:2003:d9:9728:db00:502f:cab3:2b8a:2c53? (p200300d99728db00502fcab32b8a2c53.dip0.t-ipconnect.de. [2003:d9:9728:db00:502f:cab3:2b8a:2c53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e8893ccsm1388850066b.42.2024.12.29.11.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2024 11:54:42 -0800 (PST)
Message-ID: <a71a7cad-c007-45be-9fd1-22642b835edd@colorfullife.com>
Date: Sun, 29 Dec 2024 20:54:40 +0100
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
 <addb53ac-2f46-45db-83ce-c6b28e40d831@colorfullife.com>
 <20241229115741.GB27491@redhat.com>
 <ee120531-5857-4bfc-908c-8a6f1f3e7385@colorfullife.com>
 <20241229130543.GC27491@redhat.com> <20241229131338.GD27491@redhat.com>
Content-Language: en-US
From: Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20241229131338.GD27491@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Oleg,

On 12/29/24 2:13 PM, Oleg Nesterov wrote:
> Sorry for the noise...
>
> and currently this is fine. But if we want to add the wq_has_sleeper()
> checks into fs/pipe.c then pipe_poll() needs smp_mb() after it calls
> poll_wait().
>
> Agreed?

Yes, agreed.

Just the comment in pipe_poll() was a bit tricky for me.

https://elixir.bootlin.com/linux/v6.12.6/source/fs/pipe.c#L670

If i understand it right, from memory ordering perspective, it is 
undefined if pipe->head/tail is written before or after updating the 
linked list in the poll table entry.

But: Reading cannot happen before taking the spinlock.

CPU1:

pipe_poll()-> poll_wait()->__pollwait()->add_wait_queue()->spin_lock()
LOAD(pipe->head, pipe->tail)
<<<<< insert here CPU2
<add to wait queue>
pipe_poll()-> poll_wait()->__pollwait()->add_wait_queue()->spin_unlock()
<use pipe->head, pipe->tail>

CPU2:

pipe_update_tail()
mutex_unlock()
wake_up_interruptible_sync_poll
spin_lock() >>>>> this closes the potential race

perhaps:

     /*
      * .. and only then can you do the racy tests. That way,
      * if something changes and you got it wrong, the poll
      * table entry will wake you up and fix it.

+   * The memory barrier for this READ_ONCE is provided by

+   * poll_wait()->__pollwait()->add_wait_queue()->spin_lock()

+ * It pairs with the spin_lock() in wake_up

      */
     head = READ_ONCE(pipe->head);

> On 12/29, Oleg Nesterov wrote:
>> On 12/29, Manfred Spraul wrote:
>>>> I think that your patch (and the original patch from WangYuli) has the same
>>>> proble with pipe_poll()->poll_wait()->__pollwait().
>>> What is the memory barrier for pipe_poll()?
>>>
>>> There is poll_wait()->__pollwait()->add_wait_queue()->spin_unlock(). thus
>>> only store_release.
>>>
>>> And then READ_ONCE(), i.e. no memory barrier.
>>>
>>> Thus the CPU would be free to load pipe->head and pipe->tail before adding
>>> the entry to the poll table.
>>>
>>> Correct?
>> Yes, this was my thinking.
>>
>> See also my initial reply to WangYuli
>> https://lore.kernel.org/all/20241226160007.GA11118@redhat.com/
>>
>> Do you agree?
>>
>> Oleg.



