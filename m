Return-Path: <linux-fsdevel+bounces-38724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D4CA0719B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 10:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459D83A8406
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B3A2153FE;
	Thu,  9 Jan 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="URXqYp9L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D32153CE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415422; cv=none; b=hiQ33Z4OkM/EQZWncgLtu2gtH1D2WeR3zksrTgUXCBL5MG2jjsbm6+fBwlCv3pOAtoN19iSSFMVdkBoW41UIpijaCL62xPkSXo6Hefa1OQ268dupuXPpkZa8cMVXhJ68VV2i7kLJX/SZP8KYOMYLpfuPXogy2qV3Nzhfk0J+zzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415422; c=relaxed/simple;
	bh=/Y7vshFyp+S1ZNQo5QoPrTX6A5Pvuo7WfnstfrwZxZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouqDuMlbUnrnQHI1P7RRn3/oYLSMsiiK3Jgd+Sm/bjhkv0UY0Npu4msJem3mFxkRyaNJcSa7PyBya/0aDpT0Di85sSad/VTmSy5/b29f7qFIrAe6J4764l13CnlfbQzlKVJ5tXh49zTV6G/4BZ3naT37Y+DshQKoFmjsRcTneqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=URXqYp9L; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2163bd70069so10822995ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2025 01:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736415420; x=1737020220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XcSbx1LF493qhjKry/nZNlaGERbQhtYPTAQgAOWQyVg=;
        b=URXqYp9LJnEWi/WJgrOpmKW2PJ+7wHscm3opYsrG+hIK3Ikuz0ZbAd21gFLG4thsj9
         o5wtEmuuL9YxRLA/6cyacKVEPSg3jiqpDp8WeMPDK9bszK0d1BQ9pcjT8LmyPYcpZzJg
         BBrbCwRok37Bkb06Nq7gfIsWQit+B51/tmLpf3rB7yWN+8dzQ10TCmx6pvOkYEVcGqsX
         JeZ/C/AjuZCKWUWOhRzwDEhM3zUC9muX/8gaLZupF2uOD/lBSY/ExbTPmwxDkLFJR05p
         zlNEwHW1oVirqcj6rimIA7SH/hq5YXmFyZDErfKMDxNhuFGcY5y3JNJLJ1Ffkwek/bSe
         25Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736415420; x=1737020220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XcSbx1LF493qhjKry/nZNlaGERbQhtYPTAQgAOWQyVg=;
        b=se8i9JICFYpirC3ln+qYh2E3R2eOVZ1aBvhdDlz09LYzP1YlkBKTbA2FSPlb3NIHqU
         xceDZuSvKt3XVKtkrIheiPSAB7P7R3K8SNscQgFCy9eYVpAD5O/PIfHHAt2UmJZTepJj
         7L9bMpxN9qtatVKXj9x/XLzeddSHMIrAs7NEFrroApXE0znQAG1D/5mqVjVUjaT+r5hF
         oO0uAk4GG8NAcrwP6a7Omk+WV22lE/PlXnHK3521RchslluoLsVJcIIVMYYW3UZFVxn7
         k0IcuWihONwXsjzUdqRhLPg7B9gu2Nvfj2WOd+hZExBkloJiKGFStGD4qkvc+VJIYpzG
         SDWg==
X-Forwarded-Encrypted: i=1; AJvYcCXPiiPi6Q1GLxZznarWc7G2lc5v80H2KPPoVdsk5GI4jcVW8tZiIMdP89ZTEoabD/LAh49u6O+49lLQTPD0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb72nLUxLhDbOI1f51rK0BFuyn/c/+v6+sFcfLV2TlDBi9FPvh
	2lJ9vSQ7tEl8gedPwzF80nB7F+4HF2GuhlC6/UEEG+OBs4jMFUFxjgZ2y8qsnmpXBpMz2ua3T3O
	MNJA=
X-Gm-Gg: ASbGnctTyPI+L6Pddr43qeK8bW07GqIXf7JA6Fc55EQRSGw3XmSLTd34Yp1TqWRwhCi
	DgW3ro2jL92lon/6NRdQoD0dt0SHVe24IjXk9sOSy+MCE0ekcj5MUvN0e3KXHQWtIAA3V48vJBY
	xM9R6O+tz3QAZAkcTBaPFFWeLwOmnHg7S1RwMICI8rFUeQQHEvlya+rK8FMoJVJ4fbbWtnXeRzY
	yrdRBLCRCyFgUJoT2CiHqfntk50h/ghmEpzSdpnOyfxFH27u4Plok/fPQ/hYBU59M4=
X-Google-Smtp-Source: AGHT+IGojiWk/1gT/7D4/Bn9x5ciCyKBW6DXVbq8kH6J+vNptBrJUgGdPyWUs9OwXpei8EJsrIl0sg==
X-Received: by 2002:a05:6a20:8411:b0:1e1:a434:2964 with SMTP id adf61e73a8af0-1e88cf63b7bmr10109548637.2.1736415420397;
        Thu, 09 Jan 2025 01:37:00 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbab4sm36620666b3a.94.2025.01.09.01.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 01:36:59 -0800 (PST)
Message-ID: <6f33c048-81ad-4d15-872d-187e965e6d79@daynix.com>
Date: Thu, 9 Jan 2025 18:36:52 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
 <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
 <20250109024247-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250109024247-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/09 16:43, Michael S. Tsirkin wrote:
> On Thu, Jan 09, 2025 at 04:41:50PM +0900, Akihiko Odaki wrote:
>> On 2025/01/09 16:31, Michael S. Tsirkin wrote:
>>> On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
>>>> tun used to simply advance iov_iter when it needs to pad virtio header,
>>>> which leaves the garbage in the buffer as is. This is especially
>>>> problematic when tun starts to allow enabling the hash reporting
>>>> feature; even if the feature is enabled, the packet may lack a hash
>>>> value and may contain a hole in the virtio header because the packet
>>>> arrived before the feature gets enabled or does not contain the
>>>> header fields to be hashed. If the hole is not filled with zero, it is
>>>> impossible to tell if the packet lacks a hash value.
>>>>
>>>> In theory, a user of tun can fill the buffer with zero before calling
>>>> read() to avoid such a problem, but leaving the garbage in the buffer is
>>>> awkward anyway so fill the buffer in tun.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>
>>> But if the user did it, you have just overwritten his value,
>>> did you not?
>>
>> Yes. but that means the user expects some part of buffer is not filled after
>> read() or recvmsg(). I'm a bit worried that not filling the buffer may break
>> assumptions others (especially the filesystem and socket infrastructures in
>> the kernel) may have.
>>
>> If we are really confident that it will not cause problems, this behavior
>> can be opt-in based on a flag or we can just write some documentation
>> warning userspace programmers to initialize the buffer.
> 
> It's been like this for years, I'd say we wait until we know there's a problem?

Perhaps we can just leave it as is. Let me ask filesystem and networking 
people:

Is it OK to leave some part of buffer uninitialized with read_iter() or 
recvmsg()?

> 
>>>
>>>> ---
>>>>    drivers/net/tun_vnet.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
>>>> index fe842df9e9ef..ffb2186facd3 100644
>>>> --- a/drivers/net/tun_vnet.c
>>>> +++ b/drivers/net/tun_vnet.c
>>>> @@ -138,7 +138,8 @@ int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>>>>    	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
>>>>    		return -EFAULT;
>>>> -	iov_iter_advance(iter, sz - sizeof(*hdr));
>>>> +	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
>>>> +		return -EFAULT;
>>>>    	return 0;
>>>>    }
>>>>
>>>> -- 
>>>> 2.47.1
>>>
> 


