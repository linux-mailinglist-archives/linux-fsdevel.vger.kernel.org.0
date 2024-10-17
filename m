Return-Path: <linux-fsdevel+bounces-32258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC4E9A2DEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8B2283451
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1724E1DED54;
	Thu, 17 Oct 2024 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YnFSF1YN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12071DE4D3
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193834; cv=none; b=kqSXtb9oKdgnizmXryGxQmmAQIe8t04z4V/Q6ZpvYbqMKBux49rG26WnYzSrVY68b0Aj89Cje7cBwsS9jZd/MnJhZVDhN3KQdgYWnzGhLGqpO1Xa1bx2R0qXlS5ilJilyrN9OJkOpczNDdM7KN7pV+WiIuPCmRZeAH2s7RxrrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193834; c=relaxed/simple;
	bh=6L2ezWNP+KL59GOZ8iDTVIF/P5jFnKtwE3A7kCOMqW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZPosAkThdyNVhlSjiztoqmNyBEfmfoJJMjS9PNt/uxc0PpV27ThHjzqyTxYT5UiGYAH64dH0nts5TdPRGJzr9N07nHvvZv81eRE0fTe65j/W/b0bIhex4M+LjvfWOzF54zcW+xycUqXzJKQHX7Jp68tcXjSFHXq6Ek3fow62cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YnFSF1YN; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3a309154aso5071535ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729193828; x=1729798628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kDt4PSqwqzed7xdM+ppYuwWc64+1n90tTzAqCyOu+w=;
        b=YnFSF1YNhRvaF8FL4iIGaevu7KtnoK5ntetHSNcvxqkRy7KNZaeftfj9BrbbSpTBHl
         e0iFiGzwfwIzBp0b5KYlorjB8GQ4Gu29uF8T2fvjrFe1m1NM2r5R75mDDS51FIrsBv2W
         BJj5hFEhF7we+hv/j/ogxMwjaWRleiYqZQVkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729193828; x=1729798628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kDt4PSqwqzed7xdM+ppYuwWc64+1n90tTzAqCyOu+w=;
        b=rLxKnXXJ8yESDJFNO7DzgK0g4Jgro2RR9T+zKljGa6NwPDLWsnRvQtWrEU+8TIBHcH
         VP7WkxlW0v3EahudnNkzZCjiM3Xna1m7gBD/msPthj6CLi/jjRG6h2PvsLhscUYrgRxp
         3XLVgcqeOQEFEWBbBsiwJh7Fye5PuUJ9RCqMBQAhMOKQNPklJ0/vh+QFVhjrk3G5+9eP
         QCSBSAL9wAnMMzxMemTZ2x0vOadeIGqBqijjC6I9lP8Z8W6402dFJvZRkVPe2Uzz9MZB
         Ee7SFAgYztlr4k/2qxVsNJwdcdTXMtVat8JWhDLMGCysLKCCBVbgoYY3SOSALID3b4Xf
         JYpw==
X-Forwarded-Encrypted: i=1; AJvYcCV2shkC+nP3AUO0Wxf/OVLhofQghZEXvLWYsOrjgRuN4vC6UR0hS8wD9fCqDxvFRxUT64zb/mFhswiVBQlS@vger.kernel.org
X-Gm-Message-State: AOJu0YwGqBJMzJ3saKsmYUxSaJ8CTavy7Z70uVzP8/F9vlFY1lqQHlfg
	22z+sWtg3BsTbIsS/1AH2UWsNoHmb1xGKJfOGVACViuqTMeP4xcIEYh3RI8SzC4=
X-Google-Smtp-Source: AGHT+IFkoyHAtNPtcVEkmnW87sgrwm9C/4bHGNtVw7TLSwB6i4QHE4KUdS6c4sui6FUCDwQh0ZK9/g==
X-Received: by 2002:a92:b701:0:b0:3a3:dadc:12d9 with SMTP id e9e14a558f8ab-3a3dadc1780mr78958115ab.25.1729193827785;
        Thu, 17 Oct 2024 12:37:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d70747besm15386025ab.11.2024.10.17.12.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 12:37:07 -0700 (PDT)
Message-ID: <a6f56949-7db2-4587-a3c7-3c583cba2fe4@linuxfoundation.org>
Date: Thu, 17 Oct 2024 13:37:06 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 John Hubbard <jhubbard@nvidia.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oliver Sang <oliver.sang@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <84c0de17-899e-46fd-8b72-534d8a02c259@linuxfoundation.org>
 <6080fb15-9073-461c-a87d-80e6daa326e6@lucifer.local>
 <6e0bef3a-6667-461a-80f9-791891e11d8d@lucifer.local>
 <97b6a4ea-d53a-47f1-8e64-5b9558f194c1@nvidia.com>
 <28184c3d-3c88-4f8a-a25d-7b5268b55c93@lucifer.local>
 <79f70ce6-f2ad-4fa6-90b9-6a0a936669e5@nvidia.com>
 <de39bf17-a75f-4151-9569-cd85c26fc19c@lucifer.local>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <de39bf17-a75f-4151-9569-cd85c26fc19c@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 11:38, Lorenzo Stoakes wrote:
> On Thu, Oct 17, 2024 at 10:37:00AM -0700, John Hubbard wrote:
>> On 10/17/24 10:28 AM, Lorenzo Stoakes wrote:
>>> On Thu, Oct 17, 2024 at 10:17:54AM -0700, John Hubbard wrote:
>>>> On 10/17/24 5:06 AM, Lorenzo Stoakes wrote:
>> ...
>>>>> 	#ifndef __TOOLS_LINUX_PIDFD_H
>>>>> 	#define __TOOLS_LINUX_PIDFD_H
>>>>>
>>>>> 	/*
>>>>> 	 * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
>>>>> 	 * work around this by setting the header guard.
>>>>> 	 */
>>>>> 	#define _LINUX_FCNTL_H
>>>>> 	#include "../../../include/uapi/linux/pidfd.h"
>>>>> 	#undef _LINUX_FCNTL_H
>>>>>
>>>>> 	#endif /* __TOOLS_LINUX_PIDFD_H */
>>>>>
>>>>>
>>>>> Then the test code needs only to update the pidfd.h file to #include
>>>>> <linux/pidfd.h> and add a simple $(TOOLS_INCLUDES) to the CFLAGS += line in
>>>>> the pidfd self tests Makefile and we should be all good.
>>>>

I like this solution. I should have read this message first before
handling the others.

>>>> Yes.
>>>>
>>>>>
>>>>> That way we always import everything in this header correctly, we directly
>>>>> document this issue, we include the header as you would in userland and we
>>>>> should cover off all the issues?
>>>>
>>>> Very nice!
>>>
>>> Thanks!
>>>
>>> I saw from your other thread the idea was to take snapshots and to run scripts
>>> to compare etc. but I suppose putting this into the known-stub directory
>>
>> Actually, I'm not running scripts, because the only time things need to
>> change is when new selftests require a new include, or when something
>> changes that selftests depend on.
>>
>>> tools/include/linux rather than tools/include/uapi/linux would avoid a conflict
>>> here.
>>
>> This is the first time I've actually looked at tools/include/linux. That
>> sounds about right, though.
>>
>>>
>>> Or would you say the wrapper should regardless be in the uapi/linux directory?
>>>
>>
>> No, not if there is already a better location, as you pointed out.
> 
> OK perfect, I have a patch series ready to go with this (and addressing
> Christian's comments).
> 
> Shuah - if you are open to this approach then we should be good to go!

I am caught up with the discussion now. I am good with this change.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

