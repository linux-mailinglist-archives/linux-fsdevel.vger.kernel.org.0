Return-Path: <linux-fsdevel+bounces-32234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894799A28F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 18:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB031C218BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCDA1DF966;
	Thu, 17 Oct 2024 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H/KTB3Yb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10B11DF74C
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182823; cv=none; b=LFzbi7se78KNgT8V7oUow/C+Isn5qLcs+zrOJuLMzkTaAd08IKGy1blgMRWVsgD4v1rdO25N7uNbQKlnPlz8GpzWquxjamaDLM8sbTb0z6PenOj9UMlSZIf2T7IFj4InjBGfj2dPcfCGDRpy/qncqaariI5WZujvcTb0xFAOWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182823; c=relaxed/simple;
	bh=yoEuYNpDLTcqlOrcwsDe+hvhIkPXA709M40hhaLRE1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGAZXDimE8ILCESx4IEcXJqrZ13GJ9VnVsOxpg5Zc2WuKaf0rQuCAUq7mPCuByItfBrpRGfL1e6TAW9QV7wPsanl4sUJAjoM4FoHBlvmPhzKt9dKvoZKKhOW688T4z5PY5C7KrY7takQs7NDy+esZuILTwS6QL6rWAZL0EUGZ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H/KTB3Yb; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-836d2437852so52205839f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 09:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729182820; x=1729787620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0ti0XsvTZ/XzR+pwVr3tLSQQ+95HGH92FNh0wKLCeg=;
        b=H/KTB3YbKW93VN+yF/1sDZTk4UnJDsJx6MWqBLRqWGqGpAAL/QqtYzO8YSXaFBnPwA
         XLYg3E5+PWBX89hCnFBYY89XPngsHg+Y2JOQkKtdR1iP0DNTqQq9KVETD4sQDYhPVgA6
         vd3fmtLU5+m+53D8wRzXvx3nKPtzBVQD8lHlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729182820; x=1729787620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0ti0XsvTZ/XzR+pwVr3tLSQQ+95HGH92FNh0wKLCeg=;
        b=YAnPW8ZPjoR9+2LaPdbNV9XC0/Cj5z5VJ9Z4ZHDEO7oQV7L8mj2c5pZU/tD5CTnkIr
         4pB+gHQpDNvNjqyEg3pAyw69eExaiW/u16PPpAoAUJc52OfP26/rIHS/8f2OHsD3akdV
         2ZSO122cExIWqp8WXKR8EkuPp7xmd9vxASDTnGU5me83NKPHvFlkjvater423OekmV4m
         m42cTqJoieqJETnHVc8dXEi7eiaXstVczcGMaTBqCY1y1e5dDacESn7MTHGgVCFKhMSa
         k7u1VY8oG2akUbQcsQh2REXrLLdO0e8v+N49V86RTHXQt9fFHiX5bR5ylSumaV53tkRi
         Gofw==
X-Forwarded-Encrypted: i=1; AJvYcCUn1VdvhBJDuFAp4mAmqUSLrD+sHn2BoP6zRuLaZHCaeGNIx7iPpSsUSBt8iIbHAsYtG7cS9TiyeQAHwiW/@vger.kernel.org
X-Gm-Message-State: AOJu0YyntgJ0/jcx/6C9pbmeneraX+Ltsjah/lflTBGbHHDX3EApZ+OI
	hxGYO+yDGXU00l5qyeXM+noDN5OZYNezfNzFeCwxWNBFrhtY2L4UfsHijZKUQPw=
X-Google-Smtp-Source: AGHT+IGZj5VTEGoyvHrGcQoBTDUL1ECuKHmy2uuHvPmgVMAluVOKOTXVY2rCJ8eR0erFZ+BzRAd48w==
X-Received: by 2002:a92:b701:0:b0:3a3:dadc:12d9 with SMTP id e9e14a558f8ab-3a3dadc1780mr74371115ab.25.1729182819840;
        Thu, 17 Oct 2024 09:33:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec9b252bsm1417359173.57.2024.10.17.09.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 09:33:39 -0700 (PDT)
Message-ID: <e0b9d4ad-0d47-499a-9ec8-7307b67cae5c@linuxfoundation.org>
Date: Thu, 17 Oct 2024 10:33:38 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: The "make headers" requirement, revisited: [PATCH v3 3/3]
 selftests: pidfd: add tests for PIDFD_SELF_*
To: John Hubbard <jhubbard@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Christian Brauner <christian@brauner.io>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <6dd57f0e-34b4-4456-854b-a8abdba9163b@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <6dd57f0e-34b4-4456-854b-a8abdba9163b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/24 20:01, John Hubbard wrote:
> On 10/16/24 1:00 PM, Shuah Khan wrote:
>> On 10/16/24 04:20, Lorenzo Stoakes wrote:
> ...
>>> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
>>> index 88d6830ee004..1640b711889b 100644
>>> --- a/tools/testing/selftests/pidfd/pidfd.h
>>> +++ b/tools/testing/selftests/pidfd/pidfd.h
>>> @@ -50,6 +50,14 @@
>>>   #define PIDFD_NONBLOCK O_NONBLOCK
>>>   #endif
>>> +/* System header file may not have this available. */
>>> +#ifndef PIDFD_SELF_THREAD
>>> +#define PIDFD_SELF_THREAD -100
>>> +#endif
>>> +#ifndef PIDFD_SELF_THREAD_GROUP
>>> +#define PIDFD_SELF_THREAD_GROUP -200
>>> +#endif
>>> +
>>
>> As mentioned in my response to v1 patch:
>>
>> kselftest has dependency on "make headers" and tests include
>> headers from linux/ directory
> 
> Wait, what?! Noooo!
> 
> Hi, Shuah! :)
> 
> We have had this conversation before. And there were fireworks coming from
> various core kernel developers who found that requirement to be unacceptable.
> 
> And in response, I made at selftests/mm tests buildable *without* requiring
> a "make headers" first, in [1].
> 
> I haven't followed up with other subsystems, but...maybe I should. Because
> otherwise we're just going to keep having this discussion.
> 
> The requirement to do "make headers" is not a keeper. Really.

The reason we added the requirement to avoid duplicate defines
such as this one added to kselftest source files. These are
error prone and hard to resolve.

In some cases, these don't become uapi and don't make it into
system headers. selftests are in a category of depending on
kernel headers to be able to test some features.

Getting rid of this dependency mean, tests will be full of local
defines such as this one which will become unmanageable overtime.

The discussion should be: "How do we get rid of the dependency without
introducing local defines?" not just "Let's get rid of the dependency"

thanks,
-- Shuah

