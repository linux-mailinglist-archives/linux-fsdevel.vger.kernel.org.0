Return-Path: <linux-fsdevel+bounces-59887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2617B3EB0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC884816A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5525320A33;
	Mon,  1 Sep 2025 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXKcvchO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867D432F750
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740671; cv=none; b=CPHo21bdarOApuZLzBAgrHR/XYLPyJ60xVE0VYuNN7VMu0IpW9H7elsmiOnIb6shmdQS3RyCt21VgJyFvRkH+0BVimQVMTFiJ5qhMbyMEtVJHWxzm5fzANmdQMYfPmewtPE6c3Ac7etCFmAI9t3CXaPu3KddduyFOvgSVXSbLFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740671; c=relaxed/simple;
	bh=UmXs/mAAcGXTyBFx7dzdfPfbfWd50ZnzhhH6JngBXr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vl/MSoBAklEO7WAK80vC1beYebvF5GWHe1YiQdLs5U7FwsYVMVdTX93zfuNDe2vUB0cj4AA4gaHZnJCKWcmSNiOhpJFAUuxDQWV7do6eU0fzl1ZW4+a313PDjMUa7Q/1x6c8KABmjAFgTdtsgQdL+rwWEhWanMxO3E+lsw6qc1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXKcvchO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756740668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8YTT8+1IeuyKjTNBNgyuW533+ZZMqmvm3Kt72V4BMjc=;
	b=OXKcvchO+J+Jb1noTQd6izRm116sWx7PndoDLsErRrTVSwsXNsj4Ly3LTO+WBOn181esi+
	SxoYegamMq+34qqW3gHRdK/3IYeemxwcYcMHHumYqoeKCAx16aePq1QjTdCn6ai9E45dFj
	KoRfIycCN7qCipMo2O7x3o0T8ua7fkw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-wIRjtSdCOju-7G4YdfkwSg-1; Mon, 01 Sep 2025 11:31:07 -0400
X-MC-Unique: wIRjtSdCOju-7G4YdfkwSg-1
X-Mimecast-MFC-AGG-ID: wIRjtSdCOju-7G4YdfkwSg_1756740666
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ce65accfc7so4044897f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 08:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756740666; x=1757345466;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YTT8+1IeuyKjTNBNgyuW533+ZZMqmvm3Kt72V4BMjc=;
        b=NgNkbW550qSckLKGuq8i5FpKl+2kBFrIu76EOvAx/y9TOzoI6x29h8bP+LL58gE3Tv
         Rctx1QRIUUZuyJRlDLTuXeAQII1XfDnRsBG5hRnqLqOfZ3Bn3N6yBGxOBPQxiytXnuel
         R8Izi/8B41+rqDjNnf3MWX39eUYwsF63QvERHmvXq4ZV+BOXyxP5G5REOouO6ds3dQ0I
         ctjb/7SD3xah2IYdCOtoNUtJas1Ebrw/MqvDwdHuEp5V+GYgUwKTd/BGiyQYaPw+MqSA
         4dJgYcGSTZIJQck+gbtub4WrQJwt9mO3nh5YFegrCOIVdeqy0keGfiaQMuzwblqHbnrx
         CQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCUGPJ88uVtdi4TNkJSjrDoxDPHa9UOaRaCnEhLstZDFEzQ5op64QkF9qV95WNyLMbYAO5Rf0x5CHLjFaQQ1@vger.kernel.org
X-Gm-Message-State: AOJu0YxjOYT3Jm/l75PcCOtASRpHENIyxnJZf3E7YD+J79bRl8iDJnFl
	Dd9zdLDAqM2+5XYxDaf5H2dctSTyv6jmaTneoo8nRb61r9UVC22gw46qwG8LAEWMRpDKMB0YU2U
	Fr6YY6rkEnEA+W/ytKQ05cL/QhB+Vr4RsInu6AY93VUQgJcWsqnBrtLqyoxLfgTE41gY=
X-Gm-Gg: ASbGncsU6fBNxSDptzBI49eKFF6dgcQD7DK6yuvIFU3U4bVP8TcQikrXJ3A+9pNZ3KR
	bLOEObVuP3hWRkA0HFm6la+sExnnQpdNO6VGFCbA73ejnGIEjHucBD9ZvstTmIJcdosS7S13b6m
	RRy0KaiQrB+WXDHopS0YMIgWXRkHNrwoCgpQlzFSH+OUPj9NxiRjnjFl1sH+EzGU5Fek9novCP1
	4wAQtmQ6mwVqksmiIP/dbWWggE/dRzYIlyktX/o+H3nKhDspUh4ujTJUaMOE6frIzKlbmNLY4K1
	wZ0TnhL7N22cqqanfsbsvJ8/kTwMBtdieQBUs5NYmrvsXoozMtYT4vYyhExAQJw0HISL+Z4Gits
	KTXmCUBEZm7SroBy9QuUVa8sOJsAb8wSu07sNoT/COT08wqnkrNXN8jxCMqxaT7G/J4Y=
X-Received: by 2002:a05:6000:26c6:b0:3c9:fc3c:3aa3 with SMTP id ffacd0b85a97d-3d1dfc07101mr7979328f8f.40.1756740666162;
        Mon, 01 Sep 2025 08:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKlIIY39+g2NinA80se2q6FMUup0twhlH6ge5YEtWwcm43BDQMJ3/bW/VElP4ZEtqi2ehfyw==
X-Received: by 2002:a05:6000:26c6:b0:3c9:fc3c:3aa3 with SMTP id ffacd0b85a97d-3d1dfc07101mr7979248f8f.40.1756740665572;
        Mon, 01 Sep 2025 08:31:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d690f2ebb9sm5229370f8f.20.2025.09.01.08.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 08:31:04 -0700 (PDT)
Message-ID: <4597944e-a8f5-44df-adf3-558940e88598@redhat.com>
Date: Mon, 1 Sep 2025 17:31:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] mm, s390: constify mapping related test
 functions for improved const-correctness
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 willy@infradead.org, hughd@google.com, mhocko@suse.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com, deller@gmx.de,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, weixugc@google.com, baolin.wang@linux.alibaba.com,
 rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
 broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
 mpe@ellerman.id.au, nysal@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-7-max.kellermann@ionos.com>
 <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
 <CAKPOu+-_E6qKmRo8UXg+5wy9fACX5JHwqjV6uou6aueA_Y7iRA@mail.gmail.com>
 <0bcb2d4d-9fb5-40c0-ab61-e021277a6ba3@redhat.com>
 <CAKPOu+8SdvDAcNS12TjHWq_QL6pXnw4Pnhrq2_4DgJg8ASc67A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAKPOu+8SdvDAcNS12TjHWq_QL6pXnw4Pnhrq2_4DgJg8ASc67A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 17:22, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 5:11 PM David Hildenbrand <david@redhat.com> wrote:
>>>> Should this also be *const ?
>>>
>>> No. These are function protoypes. A "const" on a parameter value
>>> (pointer address, not pointed-to memory) makes no sense on a
>>> prototype.
>>
>> But couldn't you argue the same about variable names? In most (not all
>> :) ) we keep declaration + definition in sync. So thus my confusion.
> 
> Variable names in the prototypes have no effect either, but they serve
> as useful documentation.
> 
> Whereas the "const" on a parameter value documents nothing - it's an
> implementation detail whether the function would like to modify
> parameter values. That implementation detail has no effect for the
> caller.
> 
> Of course, we could have "const" in the prototype as well. This boils
> down to personal taste. It's not my taste (has no use, has no effect,
> documents nothing, only adds noise for no gain), so I didn't add it.
> If you prefer to have that, I'll leave my taste and home and add it,
> but only after you guys make up your minds about whether you want to
> have const parameters at all.

Valid points. The problem is that it could very soon become inconsistent.

For example, when I write a new function I usually just copy what I have
from the definition into the declaration.

For example, checkpatch complains about missing variable names and I 
think it complains when "extern" is used for functions.

If we were to decide to go that route (not keep them in perfect sync), I 
guess it would be reasonable to extend checkpatch to warn if "*const" is 
used in a declaration. (perl magic, no idea how hard that would be)

I'm sure there are false positives in the following:

$ git grep "\*const" *.h | grep -v inline | wc -l
403

-- 
Cheers

David / dhildenb


