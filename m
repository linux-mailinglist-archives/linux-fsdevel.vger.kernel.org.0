Return-Path: <linux-fsdevel+bounces-44186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF199A646E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 10:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D55127A17F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5353021D3EA;
	Mon, 17 Mar 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYgjh1lf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3107014A8B
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203116; cv=none; b=P98dzLk94QIAvYP6YpX5Bk6vlRRue/9CfI9wBGfGFPA2ZTsYhAOnAKoOjb8/U85xX+HFExyaPkcBEs/XKcN3HQa3qAck87lSfX9Q9w11slFOXkVB5UL3pRR/yun4n/Ojk/Vxtz92rqFMtHOK8zV8IRWQwuRyVY8seFbtZwaIFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203116; c=relaxed/simple;
	bh=rkHyUOIK5DaxK4NdmSboXpHJ+X3bYYMRt6rPqOAGiW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxIyi/YJ1Zgo8+OX8wTBqVYJViHkQjIAJzNDufWzwWCMhBiPldJMjfZFAXBjdo725k2/GJ0YC9L/WZHkZ9l+6X88gTB7MhEkC6SkihzIZhCTqapc8aS1UQCgSnyN+uZSbYtILEPrB9b59e06doad51/65gjEd+6YOj5HufkZN5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYgjh1lf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742203113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zzLBGJTtvmWYR8X7R8ZfegRuqABpUdMz74YAoQBOnu8=;
	b=gYgjh1lf4kigZDXT7QP02JAWeYFgyW66qvAZqhKXiYZfFoHp1ch7IK9PSg3VP0es7IGMcZ
	OALQsOvhNnDrdZoePKr9AgSLT+JJvYtS3wWx8Dn5ElHCTki84sRxkfhG4Ua5NvH2vpWsMc
	OmxLCPXpSiOofXxQEPc9WSv4Do8ZbP4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-kuQxd7q4PyyEixgS0-jncQ-1; Mon, 17 Mar 2025 05:18:31 -0400
X-MC-Unique: kuQxd7q4PyyEixgS0-jncQ-1
X-Mimecast-MFC-AGG-ID: kuQxd7q4PyyEixgS0-jncQ_1742203110
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394c747c72so8725335e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 02:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742203110; x=1742807910;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zzLBGJTtvmWYR8X7R8ZfegRuqABpUdMz74YAoQBOnu8=;
        b=ifPZXS4Oiy5Sf4Mwg1bRtJ18vlykQb0iY67afDwJcdeQgZpcLWzOLRHPBEe+Rp5Y61
         B/HMjD4Ln4n1/ZHbgfj4i3iVSr2fU/maXLmiK4XHOiyyCtawWWca0FoidZoJ4OjnohQS
         DhoUzAgKUvwAQpizNQW3i9bTDd73WoH9e9gBEkWjCkvhhn3H0LOLOfYrL8fSb4QPhBxm
         y5OpB9wjpjysECLCYkFUj9HVGiN57yEV5YcIEu6RTEU7JMJPs4bwsJAhu/svGqcd28K9
         78+GM/javo//5enz17GrlzBIv33/habzEZf2k+4CbVqUnTZGA2KkCHNKxz/TM9+fc53W
         +JdA==
X-Forwarded-Encrypted: i=1; AJvYcCVYLysMhKF7gp4PAc+2qjoERLGXkzGCK4iraiBVJZUlhaVG36JGLxNDv9lR8+jHJhG7DveqjLFW8+caW8y6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0C75P/1SkjCC9PDlIwNbJVvRuvtvIc63IQpQsG7H8mxEs35GZ
	3SOhXqPtevQoaamlaER0GHsVtsoiXiGhpmWQRZZTM8OhUMoDG6XaIpOYCH/FAYokvW06k4jNsg1
	4raDJm7pB0DKZ26Mhw5SpLn789rXPnM/E7NSrVsqlfxi5Vh4oV9twkb0uQ1QGKAc=
X-Gm-Gg: ASbGncvsplkpW5vTTRFJz8i/fCYyoTrbL3UmIj4TkLhLWICRIIcyfCxBy2L0vr7LPsR
	sY/XWGLPRwWRUV5AjPStDmR9Oy9LH3hLMh/MWTbc8RpbLHCKU1sUpSL6RdtDx18zn0MU0T4W4v4
	JZEeLwWioA43L0bFOyq1/oNIIKwyaWzTgit29Aop489H/28QcAVzQHtnTtOoDx8jc0Bf7GaNzTC
	KorybHTt14XN89W4LZTL9t0BMux9X9WqQNS/PsQZhKLLPjtR0SuBEShOIyv61m0/ohtknKoKpYG
	IO++yS1LrhK9ex3Phi48B2SAKf4k8uX/f7+jcIie8dXgxpcHW+rMCHsGlfaX/xoolkZ7u3TcGqg
	FwYdLKmyjX9KAuULoULj0H8Y/7SCENeVB++pPpsov6lM=
X-Received: by 2002:a05:600c:4c98:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-43d1ec7a331mr115924955e9.9.1742203110551;
        Mon, 17 Mar 2025 02:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHskErAHor5DG91Ii7jyOLdrIojcU+A3rb+T3y6TxwSm29YAkqBThDASO6dno/FmvGLWAV6Qw==
X-Received: by 2002:a05:600c:4c98:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-43d1ec7a331mr115924695e9.9.1742203110152;
        Mon, 17 Mar 2025 02:18:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:aa00:ab00:6415:bbb7:f3a1? (p200300cbc73caa00ab006415bbb7f3a1.dip0.t-ipconnect.de. [2003:cb:c73c:aa00:ab00:6415:bbb7:f3a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffc49adsm99021785e9.24.2025.03.17.02.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 02:18:29 -0700 (PDT)
Message-ID: <4a336393-6cf3-4053-8137-c6d724c3cb5f@redhat.com>
Date: Mon, 17 Mar 2025 10:18:28 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/page: Refactoring to reduce code duplication.
To: Liu Ye <liuyerd@163.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, ran.xiaokai@zte.com.cn, dan.carpenter@linaro.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Liu Ye <liuye@kylinos.cn>
References: <20250317080118.95696-1-liuyerd@163.com>
 <1c7018f1-fdc5-4fc6-adc7-fae592851710@redhat.com>
 <2ecdf349-779f-43d5-ae3d-55d973ea50e9@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2ecdf349-779f-43d5-ae3d-55d973ea50e9@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.03.25 10:13, Liu Ye wrote:
> 
> 在 2025/3/17 16:56, David Hildenbrand 写道:
>> On 17.03.25 09:01, Liu Ye wrote:
>>> From: Liu Ye <liuye@kylinos.cn>
>>>
>>> The function kpageflags_read and kpagecgroup_read is quite similar
>>> to kpagecount_read. Consider refactoring common code into a helper
>>> function to reduce code duplication.
>>>
>>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>>> ---
>>>    fs/proc/page.c | 158 ++++++++++++++++---------------------------------
>>>    1 file changed, 50 insertions(+), 108 deletions(-)
>>>
>>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>>> index a55f5acefa97..f413016ebe67 100644
>>> --- a/fs/proc/page.c
>>> +++ b/fs/proc/page.c
>>> @@ -37,19 +37,17 @@ static inline unsigned long get_max_dump_pfn(void)
>>>    #endif
>>>    }
>>>    -/* /proc/kpagecount - an array exposing page mapcounts
>>> - *
>>> - * Each entry is a u64 representing the corresponding
>>> - * physical page mapcount.
>>> - */
>>> -static ssize_t kpagecount_read(struct file *file, char __user *buf,
>>> -                 size_t count, loff_t *ppos)
>>> +static ssize_t kpage_read(struct file *file, char __user *buf,
>>> +        size_t count, loff_t *ppos,
>>> +        u64 (*get_page_info)(struct page *))
>>
>> Can we just indicate using an enum which operation to perform, so we can avoid having+passing these functions?
>>
> Like this? Good idea, I'll send a new patch later.
> 
> enum kpage_operation {
>      KPAGE_FLAGS,
>      KPAGE_COUNT,
>      KPAGE_CGROUP,
> };
> 
> static u64 get_page_info(struct page *page, enum kpage_operation op)
> {
>      switch (op) {
>      case KPAGE_FLAGS:
>          return stable_page_flags(page);
>      case KPAGE_COUNT:
>          return page_count(page);
>      case KPAGE_CGROUP:
>          return page_cgroup_ino(page);
>      default:
>          return 0;
>      }
> }


Likely it's best to inline get_page_info() into kpage_read() to just get 
rid of it.


-- 
Cheers,

David / dhildenb


