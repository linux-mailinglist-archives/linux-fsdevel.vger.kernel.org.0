Return-Path: <linux-fsdevel+bounces-50429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD73BACC192
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 09:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3733A4282
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 07:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC18327FD63;
	Tue,  3 Jun 2025 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWechPIa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D33B27FB29
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748937524; cv=none; b=gNvdx7FB48t9h7CIs29j5u79dsA1fdtf/esLWP9r6zQzvcRZ5EHA9QSAOgZfHwWc5Q3CAiL3fR9EOcZX2c6xeKDPkHbdnNvpYIZan7CAX/NzrDC2//Wveu3BB7oz+jfDRL1KJyUapPV6+c1eZybDCGDuMmGixmJPr9lYDUrZA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748937524; c=relaxed/simple;
	bh=cy72lPA7fIybA0rZs5R1Jbp8qv0j8pisUfL/1px13qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lzxsqj2c3PXuOPUWF0laM81dtwnhGPi80WJCnP39BJ+GssED9mmVtRsknbaiTh7Ueb3HRihSwhmo4Cwt8xY0DrmDQDpblexe8yB+jFW5n4vPFSKhhAcJo9hBVzLkzb7UQ7ukBj5K84eHzhr5MeGf4g/i+LiWdGZ/zCbCm9zAb0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWechPIa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748937520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CU0N6UgF0Wu801mnXgPiaSIy9UpUp1v4ajkhrRpQ1f8=;
	b=gWechPIaKg3cfG4Aw1SwO+HjAchk8QLcqDTiepGPsuJ3UIzDaeTsz/pREmYWnwJiSxbi7t
	jKvIIn3HuETuA9Ieff4wetHhpwpdAWoMjQuXqqnA64DEumVgl1nSZ1Z1JZkOEqLQXbkBEK
	FOVj8ySqg1kh4OcWPeOCFnIIN7kJ2Oc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-FD5Q3-OJPL2R0yBUPGW5-Q-1; Tue, 03 Jun 2025 03:58:37 -0400
X-MC-Unique: FD5Q3-OJPL2R0yBUPGW5-Q-1
X-Mimecast-MFC-AGG-ID: FD5Q3-OJPL2R0yBUPGW5-Q_1748937516
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43eed325461so35918605e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 00:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748937516; x=1749542316;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CU0N6UgF0Wu801mnXgPiaSIy9UpUp1v4ajkhrRpQ1f8=;
        b=U+0PSWahSxs1ixhqQy8l1KjqIhGR+OIsxD1/WYwUqDsKdMBQPGZkvq+cC5eF9H8aMp
         1KCWDrVJrkEs9GY9ZnXteG04L4y8bEtnPwC3bHeB055J8n6m9wY0cEeO6iHPlRcaWNfD
         UWS9m3mU5L1PqBf/jiTxsYAWZ4Dx4veg8IfLUtALwyjZojVeVinlkkhpCD3lMiJQstwe
         js5l/wmxZpX1zYeWrn0rvaEULzjekBTkEyCRZaWZZVO12itjZv6dCjHmeEvTonN4sFpv
         Wkcpj29+aGG8x5aQH+5ygVE9xbF1Rq4w+srH/cqgJO8dFy+aT3gqRwjYJ6kdlClTC0Bk
         SMbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV0JwbeyQXfjBK5vi4+GTDqhw3bM5Lbsqqqmgtjr5CRZdwxdSApRK1ncysIoksj47G+UjpbANsfqYWUtzi@vger.kernel.org
X-Gm-Message-State: AOJu0YwzBK25zUkelP4tQzkcNlWsOnMQ+dZlS3hQDu39hfiQcsPvAQDI
	K9QjMV0PILmunjleDErlYWP47FARGG03uqUkzx6bjDpvAB1PeIfLdED1NDX611hybQ13f6nIPR8
	UQk4L6F0W4BMLBj68TTSt8C2g7ODZuZEc3VE1y03UAs5FxzJASSFiEibjTxLZ7Gfp6/w=
X-Gm-Gg: ASbGncual++5nTBoP+P6z7RVRtRtXf25CWqvg3NcOSCV99i0HDVm6zpsJH1BnPAks37
	Ltx8CTtcXjIkJJMiBiOwu7QH43tW94+W2kFSgevHSHHgXlgYlWZ5N5MWzOBLtPlOEIsyNkEQY9k
	6fiL9AAiN4OXomESFxHJAb/Ffk6l/PmfJACap3llySzNVuSw0Mz9xpUrZC2XoIdNmWPnQbg2vlG
	P2CN+YMpYSepeQjFPmHYQZDHH/+sgTl5r8OUxaasIJq7Kz8psqnJCv6ttERM4EhBDhqsbwV9WMo
	5yk2k0oQtKX2/Hw3y4uLjaDqMri1lrjD6ukQnuzqLPEtVQf8n0DJUPB1r1gZD58H0KtJi+xKaPe
	JvHGPdIxvzLA8oxxCtD+wuTfvVHlKCoQOMoyuLpI=
X-Received: by 2002:a05:600c:3e83:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-450d8846c1dmr174157535e9.10.1748937516076;
        Tue, 03 Jun 2025 00:58:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuF8+vnhtRNmRyCVVcDcXRSlMRzaw2IM+WDvELnB/XLtRFKZRwQLOj0Esqbuh3xRvpcNyDMA==
X-Received: by 2002:a05:600c:3e83:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-450d8846c1dmr174157115e9.10.1748937515629;
        Tue, 03 Jun 2025 00:58:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:f000:eec9:2b8d:4913:f32a? (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de. [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb00ccsm151727445e9.17.2025.06.03.00.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 00:58:35 -0700 (PDT)
Message-ID: <053ae9ec-1113-4ed8-9625-adf382070bc5@redhat.com>
Date: Tue, 3 Jun 2025 09:58:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xarray: Add a BUG_ON() to ensure caller is not sibling
To: Dev Jain <dev.jain@arm.com>, Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, anshuman.khandual@arm.com, ryan.roberts@arm.com
References: <20250528113124.87084-1-dev.jain@arm.com>
 <30EECA35-4622-46B5-857D-484282E92AAF@nvidia.com>
 <4fb15ee4-1049-4459-a10e-9f4544545a20@arm.com>
 <B3C9C9EA-2B76-4AE5-8F1F-425FEB8560FD@nvidia.com>
 <8fb366e2-cec2-42ba-97c4-2d927423a26e@arm.com>
 <EF500105-614C-4D06-BE7A-AFB8C855BC78@nvidia.com>
 <a3311974-30ae-42b6-9f26-45e769a67522@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a3311974-30ae-42b6-9f26-45e769a67522@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.06.25 07:23, Dev Jain wrote:
> 
> On 02/06/25 8:33 pm, Zi Yan wrote:
>> On 29 May 2025, at 23:44, Dev Jain wrote:
>>
>>> On 30/05/25 4:17 am, Zi Yan wrote:
>>>> On 28 May 2025, at 23:17, Dev Jain wrote:
>>>>
>>>>> On 28/05/25 10:42 pm, Zi Yan wrote:
>>>>>> On 28 May 2025, at 7:31, Dev Jain wrote:
>>>>>>
>>>>>>> Suppose xas is pointing somewhere near the end of the multi-entry batch.
>>>>>>> Then it may happen that the computed slot already falls beyond the batch,
>>>>>>> thus breaking the loop due to !xa_is_sibling(), and computing the wrong
>>>>>>> order. Thus ensure that the caller is aware of this by triggering a BUG
>>>>>>> when the entry is a sibling entry.
>>>>>> Is it possible to add a test case in lib/test_xarray.c for this?
>>>>>> You can compile the tests with “make -C tools/testing/radix-tree”
>>>>>> and run “./tools/testing/radix-tree/xarray”.
>>>>> Sorry forgot to Cc you.
>>>>> I can surely do that later, but does this patch look fine?
>>>> I am not sure the exact situation you are describing, so I asked you
>>>> to write a test case to demonstrate the issue. :)
>>>
>>> Suppose we have a shift-6 node having an order-9 entry => 8 - 1 = 7 siblings,
>>> so assume the slots are at offset 0 till 7 in this node. If xas->xa_offset is 6,
>>> then the code will compute order as 1 + xas->xa_node->shift = 7. So I mean to
>>> say that the order computation must start from the beginning of the multi-slot
>>> entries, that is, the non-sibling entry.
>> Got it. Thanks for the explanation. It will be great to add this explanation
>> to the commit log.
>>
>> I also notice that in the comment of xas_get_order() it says
>> “Called after xas_load()” and xas_load() returns NULL or an internal
>> entry for a sibling. So caller is responsible to make sure xas is not pointing
>> to a sibling entry. It is good to have a check here.
>>
>> In terms of the patch, we are moving away from BUG()/BUG_ON(), so I wonder
>> if there is a less disruptive way of handling this. Something like return
>> -EINVAL instead with modified function comments and adding a comment
>> at the return -EIVAL saying something like caller needs to pass
>> a non-sibling entry.
> 
> What's the reason for moving away from BUG_ON()?

BUG_ON is in general a bad thing. See 
Documentation/process/coding-style.rst and the history on the related 
changes for details.

Here, it is less critical than it looks.

XA_NODE_BUG_ON is only active with XA_DEBUG.

And XA_DEBUG is only defined in

tools/testing/shared/xarray-shared.h:#define XA_DEBUG

So IIUC, it's only active in selftests, and completely inactive in any 
kernel builds.

-- 
Cheers,

David / dhildenb


