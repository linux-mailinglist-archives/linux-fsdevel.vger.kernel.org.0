Return-Path: <linux-fsdevel+bounces-48299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B99AACF6A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 23:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF681B67009
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 21:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B62D217647;
	Tue,  6 May 2025 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MDzsGYuX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053C1FBC92
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746566291; cv=none; b=okKeKcJnjo/DqpDNwq0DPCIAoSzEm2RO5O+YPnsLprjelJBpLIcAh9iiuCmnbWEmIipcapZigjugldC0yS8afL8rK0v0dnR6eWFiVpegTOr8w4rvejY5OO/O1HnpY33htnau8ULPumdhQoCt68q5XEXAKelrioC9kt8HISRbKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746566291; c=relaxed/simple;
	bh=ZbUVsEPh6tdbg1Nr8t8A3+DYza+dfr7oWIBRauQ+wn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxPVrh3loqrzfs/GFWZMFIasNZTFAA/1+712FyIeGi0G5sRlq7zcy+PYHBVal11Yy+CY2AF+lqXj0q8tDMONC4yMJduKSQgV216SFFchMyRDBB2WF+5sr1EX71P+OqL0vtFXTnypbzTLXqa/ikpLAJRXdIWIlUHXUwFTqBHjt3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MDzsGYuX; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3da741bcedcso32605ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 14:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746566288; x=1747171088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vhk1HBI/4LMXTfhNfYxi9xZ9PhHpTPrJe65ilxoqp+Y=;
        b=MDzsGYuX/TEG/ZFEhjWcGRvGLlKwySKWFNkxfBfe9VLqC1hAF9tZQbHP6x8/4TDn8t
         8pLwVxGXT6oMj3cRUkyGlZPe/fkcZFaCQ0jQLd4GrcR+MHRb9brDdrgnpgx0iFlPz5Ka
         GrOA77VdUHOKx/4VYKhZKjvudtRONZzXi3MGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746566288; x=1747171088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vhk1HBI/4LMXTfhNfYxi9xZ9PhHpTPrJe65ilxoqp+Y=;
        b=Ml4xkbPzQHFp47MpG89ikyLMA5WZP8YILApTaCu6wHX+fo36YBE5A5OO8yDj5i1qYZ
         Bez/94hZioexHE0tXfKBIPaer575euqEmPUmDrFU2/AE4bILlXXkBWAmYVHUJ/i/X2Sq
         FhcJwnUzhZcz8Zh1PY/wnuYh/wGOxop5C+b5aqzB2updkO5iQtHITD+158pnEMLYLTEb
         9uSNEeV/R8haDFVfLK9gWx/KC4ZEqZ3+w2BgRglp8n9kwxpTaaCXlYjoGPFzNqY2gwOD
         +UYuwmy91fkW+/6XXs0aCAhVp4ihuw5afTpB7qFi7tE2fZzocZDU+1s8tBOfjURg5NQf
         VRVg==
X-Forwarded-Encrypted: i=1; AJvYcCXqSJzq86yy+5VaE7a2ni0TmitHIdv9aEc22xex7DCTegbmhpY2RiDGL7JgcsrWMPbqOEPktsvruqWBcx0m@vger.kernel.org
X-Gm-Message-State: AOJu0YzlaCcFWxOXFpjjc5/AKiqC0B1hqh3Pkbv5Wv5ka3tO7D56+BAn
	H998KZc6SdGFMUXe/27vZA+jfmqqdcvxFkwQmQiAgoEfMjKbhqjmAq0/3JrwGKg=
X-Gm-Gg: ASbGncs1xtI3b+02I0vDBymSVZAkcenQh8nfccMKddyYMqp7aRaJM2VS7GWpnn/Hyb4
	9zXJvh4D1eLcUXQ+wuPvwciT98z/yFLA+IKu+9NgTOgqobncFrJgzFL4CL1BS5R3Jr8L8DBawPH
	Vfq5nhw1JNimDYLiCcwQUvd+VZvhpku8doUp2v5HBj67+isYbdbbbXzXHN8tEqjTCQzk0RtbJLy
	u14kzAAA8EZcuB3RtCgsXQQ2N+h+i5StuISRDoG65R/DbAkIxAtBHYSoH4CrawPCxk8woI8RLLm
	+yoJR5iyEQBt6PRh/ZBrQmC9HTZDHZNoYdSx/Gvlin/OEYFvJKg=
X-Google-Smtp-Source: AGHT+IHUA+sn2FCbduj4eCJZBOdW4tseCQ5oMi7Bx4Yf5oLI8Rys2VzAzxELUSzWphfH7ztNR5z4iA==
X-Received: by 2002:a92:b0f:0:b0:3da:7237:525a with SMTP id e9e14a558f8ab-3da738e5fb2mr7278445ab.8.1746566288378;
        Tue, 06 May 2025 14:18:08 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a916042sm2419259173.40.2025.05.06.14.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 14:18:07 -0700 (PDT)
Message-ID: <17464a97-e7be-49d4-9422-96ff824dba7c@linuxfoundation.org>
Date: Tue, 6 May 2025 15:18:06 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
To: Peter Zijlstra <peterz@infradead.org>, John Hubbard <jhubbard@nvidia.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oliver Sang <oliver.sang@intel.com>, seanjc@google.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <5b0b8e1e-6f50-4e18-bf46-39b00376c26e@nvidia.com>
 <20250501114235.GP4198@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250501114235.GP4198@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/25 05:42, Peter Zijlstra wrote:
> On Wed, Oct 16, 2024 at 07:14:34PM -0700, John Hubbard wrote:
>> On 10/16/24 3:06 PM, Lorenzo Stoakes wrote:
>>> On Wed, Oct 16, 2024 at 02:00:27PM -0600, Shuah Khan wrote:
>>>> On 10/16/24 04:20, Lorenzo Stoakes wrote:
>> ...
>>>>> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
>>>>> index 88d6830ee004..1640b711889b 100644
>>>>> --- a/tools/testing/selftests/pidfd/pidfd.h
>>>>> +++ b/tools/testing/selftests/pidfd/pidfd.h
>>>>> @@ -50,6 +50,14 @@
>>>>>     #define PIDFD_NONBLOCK O_NONBLOCK
>>>>>     #endif
>>>>> +/* System header file may not have this available. */
>>>>> +#ifndef PIDFD_SELF_THREAD
>>>>> +#define PIDFD_SELF_THREAD -100
>>>>> +#endif
>>>>> +#ifndef PIDFD_SELF_THREAD_GROUP
>>>>> +#define PIDFD_SELF_THREAD_GROUP -200
>>>>> +#endif
>>>>> +
>>>>
>>>> As mentioned in my response to v1 patch:
>>>>
>>>> kselftest has dependency on "make headers" and tests include
>>>> headers from linux/ directory
>>>
>>> Right but that assumes you install the kernel headers on the build system,
>>> which is quite a painful thing to have to do when you are quickly iterating
>>> on a qemu setup.
>>>
>>> This is a use case I use all the time so not at all theoretical.
>>>
>>
>> This is turning out to be a fairly typical reaction from kernel
>> developers, when presented with the "you must first run make headers"
>> requirement for kselftests.
>>
>> Peter Zijlstra's "NAK NAK NAK" response [1] last year was the most
>> colorful, so I'll helpfully cite it here. :)
> 
> Let me re-try this.
> 
> This is driving me insane. I've spend the past _TWO_ days trying to
> build KVM selftests and I'm still failing.
> 
> This is absolute atrocious crap and is costing me valuable time.
> 
> Please fix this fucking selftests shit to just build. This is unusable
> garbage.

I don't recall all the reasons why kselftests needed "make headers"
One reason I could think of was that when a new test depends on a
header change, the test won't build unless headers are installed.

If this requirement is causing problems for tests that don't fall
into the category and we probably have more of them mow, we can
clean that up.

John, you mentioned you got mm tests working without headers?
Can you share the commit here.

thanks,
-- Shuah



