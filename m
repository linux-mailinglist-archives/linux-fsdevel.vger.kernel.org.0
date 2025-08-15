Return-Path: <linux-fsdevel+bounces-57989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F75DB27D2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 11:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F1FAC0CDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDEA2E5B11;
	Fri, 15 Aug 2025 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeJjTRx1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E52E5436;
	Fri, 15 Aug 2025 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250163; cv=none; b=SfkyMTtwMTE4bqVDOmUtfiUEj/NuvBIALWtd6l0ENVNkA/4XQSu4CMo6RdLKs7xAvTDYko7CJvEw5TEuEEBQJ45O94Hn75FKXNbeqe6ZPiJ1mfxwTSXh+8NoeAVsT0lWvnd/GGr6AYkcxqOEIQTgHfmu896q5rqjVQppRLetfLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250163; c=relaxed/simple;
	bh=gd0ZxxmMzE9rnFnN10LQnUDdvRZnbGWhtn9asMcFlSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gp0BieTPQsFC0zAD23F8q+XzjT8cw8G86iqK/gsSWL9Oyml3L6nr7NXMMGZ7gI3m8hG7vMt+5U8Px6rn4Kq6Svku9nERfT6BgLwBHmuaz1EKxwb00PS6h+pPSqrGbCtQ7bvVHtAUNJ4axiwmbb3YlecIPjuwbB6CuaL2qf/NTqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeJjTRx1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1abf5466so10063995e9.0;
        Fri, 15 Aug 2025 02:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755250160; x=1755854960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwWnSoQZBxGDEvy7LeuiGeEs7NklIXZHoSKPGcGLlO4=;
        b=CeJjTRx1h9WSl3WAdZyAMH7Ho/djmKAN9IM+QOaQn+XYUvxIcCmsvISSvw6pOWZgET
         Yi8AmrR3WSN8s/EgnU93ClyNM2zEnGxUebYMQuJER6qyoU8OjXKd8DlLiSNzmfuGxH+P
         2RKpvhIXOXKn92oOYnYUiDc0fNyeA7OSjySLXgTbbpTL62tWp96NjYuZBFWBOsaQigOB
         w7n9JlwB+G653H2WN2FqoYlkMwwGLbjJJGtqer75Rx5IV1AZ/XIVi1xgREdgSTIDvfYo
         U9NUHevbt474nZ40udrX9hFjDzC/e/bjAhngMOZYB5H4ml8sss1ovrJhgV/jp/KzRf5V
         QZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755250160; x=1755854960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwWnSoQZBxGDEvy7LeuiGeEs7NklIXZHoSKPGcGLlO4=;
        b=aiNv6mcqrFC9bzRdiEDUKdylBIS1881XZyWz8mvEUjxqf4jmWMCAAlmQxik6zeChQD
         48KF6lIVonjs5eXXowQSmzFyaqanQhBP4LX/OVw28kRUexZelUWziGszEH8d4vG27S05
         vIcpiBnWjxtWcPzmbVlQZOkQw1MAKUfwQlNnFKjylN3oI3X48KuYwztfU+BvCDbfKSiv
         z+qZs2P9OVu9Q4RIQRT7lkZyCbr+Yd3tr5mC2d057sdIw0KM9ChWYGOKCEzOcYnssMk3
         zQLxgvBaulzg2gS6Kog64ijzf0NKhQnknMJPPPe8mCBSXdHoUBWCHGEAqmPAHU2ATn3b
         SPng==
X-Forwarded-Encrypted: i=1; AJvYcCU265gWimPGQwbWywLqX2CdreesdKbAYo4x3VeAkr2+bw9L3uGEeyKSvxSm7rRob3KGR8hDPEp1mt8=@vger.kernel.org, AJvYcCViDUAFv9I80MSgopg7oW1InVDapgPEYnA4t5GNmH140CR73MYGuMSXHfpp7gHim3qYlN3Wh3PZd8mC3MXOqg==@vger.kernel.org, AJvYcCWiAkjiGkohU6vu9MOCPuvyjKBfEQSkfUet7+qnGNOf07Q+SupE5mI10IWsRVywUZ/zBHLQMG4zC4CQSdmq@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcT+NSSaqiU+nUkvt4oDX5fx6J+gBQZeR1xeT1KxmF648eCY+
	IacrWMDAFW4SVzk9eUi7T6xVfFEY0UsQKHkF0A3GmRk70oAKrZi8+0kx
X-Gm-Gg: ASbGncsF7zkrdn5Yv3F1Q0Rkn4GSdu/CJJH54+OIOOTrNYpgvDGG/eubeAcS87Z8Oc+
	7PWlpzrq9pJj9QLTJ1L8NGR2tSwCQWwpNLLQrWN0xuKpjz+P6WIUm29xIrMTzIodoGmpQ12/1Iw
	dSkx4Xp0wFiCb3h9Uk5+eLQMopHEkxABEmBLt1hnN/1kZrnpXGrCxOVLCUHVJkzvlnFPHbWu4Ld
	b5H95JMcoHLd7IowNqpz/M3BxBYVueXERzQjHD/wtzy9o3AVUYR1tlnzp8CjJJ7hM5PpOUPAPbU
	hE+ACeyHtGbrGV5i9YLGDTV9firxpMVvJup20gWX5ktIYC9IPd16BLbFSyOWhFAdqWjLOs7JHvt
	EOPgOMMlHE6D5m/bV8YKgBcwwAAa1oc6aHCGElnbbHQYJYblhHR3UYH5oVqDQYk/L6ke6HZF+9Z
	GG7tmWg9Mjyg==
X-Google-Smtp-Source: AGHT+IF+kyfLy/7halE6ohPvWdKODLSTE3Iw+QGXQQKUCPSBld9coa2uwxZQM6hjpcHr1YUXB6hPCA==
X-Received: by 2002:a05:600c:c8a:b0:459:d9d5:7f2b with SMTP id 5b1f17b1804b1-45a21868766mr14961525e9.16.1755250159582;
        Fri, 15 Aug 2025 02:29:19 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4? ([2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb68079336sm1217362f8f.53.2025.08.15.02.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 02:29:18 -0700 (PDT)
Message-ID: <cb94236f-e5eb-4f74-be3f-3f3fcaecfdcd@gmail.com>
Date: Fri, 15 Aug 2025 10:29:17 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] mm/huge_memory: convert "tva_flags" to "enum
 tva_type"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, david@redhat.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-3-usamaarif642@gmail.com>
 <CALOAHbAe9Rbb2iC3Vnw29jxHEQiWA83jw72fb_CQKGDFHv6+FQ@mail.gmail.com>
 <c8a47a7d-3810-426f-a2cf-7c020ce25c7d@gmail.com>
 <20250814181101.9e15c8c0202face2230ad1fb@linux-foundation.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250814181101.9e15c8c0202face2230ad1fb@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/08/2025 02:11, Andrew Morton wrote:
> On Thu, 14 Aug 2025 11:43:16 +0100 Usama Arif <usamaarif642@gmail.com> wrote:
> 
>>
>>
>>> Hello Usama,
>>>
>>> This change is also required by my BPF-based THP order selection
>>> series [0]. Since this patch appears to be independent of the series,
>>> could we merge it first into mm-new or mm-everything if the series
>>> itself won't be merged shortly?
>>>
>>> Link: https://lwn.net/Articles/1031829/ [0]
>>>
>>
>> Thanks for reviewing!
>>
>> All of the patches in the series have several acks/reviews. Only a small change
>> might be required in selftest, so hopefully the next revision is the last one.
>>
>> Andrew - would it be ok to start including this entire series in the mm-new now?
>>
> 
> https://lkml.kernel.org/r/0879b2c9-3088-4f92-8d73-666493ec783a@gmail.com
> led me to expect a v5 series?

yes, small changes changes needed, was thinking of doing fixlet but will send
v5 for it. Thanks!

