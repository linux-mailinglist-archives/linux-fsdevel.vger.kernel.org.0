Return-Path: <linux-fsdevel+bounces-59889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01387B3EB95
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58358188527A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15304258EE2;
	Mon,  1 Sep 2025 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGrKAEWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442DAD5A
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741978; cv=none; b=H0gxif3LQlds8cdDL/Ss6VZJtZyyKqNONBGcO4h9Vkr3y6Le2VJjBjzb9cWMj7QLzMshSQPW/QlrKikP3ngmN7sW77Uta4Zro2XJhsRhiEVYuXBKs2rS/7xx4WrbEekMq3ho2jZwrGpvzrgkCtVTNwU9+OTYDDh4kJ8cPO7H3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741978; c=relaxed/simple;
	bh=Gk5xf+LWqL8BAqZMRhulhezXCkqVROdiR0R2gZqxkY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnALb5aY/JWtIXtWPHTntAtat3rGejYe5lB4ukC+Xw5yqn2PIHuRB5FAWjAsFTK9XTPUoOHdWmqPdLVzh4b+AFITBNXMXCzmj0E6TVAb7rFz+qOignMlFETyPMT052udJsmFvnxJHFbl/RW3WIdXwVMu6C9Fv/WzZqSnJX0LMOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fGrKAEWB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756741976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mbEdJL0isBBnB3JXZr3cyBmB7UVFLdKlgzj7B1K9tQk=;
	b=fGrKAEWB4ljc5x+7TuxH4RZIiOuD7ul8CFrWQ7pbPKmiHZTCAQ22hbAwLGuFP1doJ6dR0O
	+Kl3O0gNMc0Kl8zInrvDfg4fQDZTdsqHsQbMttZK/8Vjv+RkPjo0UZsoGiK9GcdMu5wXwy
	YZkp5bVWt3NedshltadqTnBBnvUiuP8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-sLo3aX_QMVGevtnP6B6dkQ-1; Mon, 01 Sep 2025 11:52:54 -0400
X-MC-Unique: sLo3aX_QMVGevtnP6B6dkQ-1
X-Mimecast-MFC-AGG-ID: sLo3aX_QMVGevtnP6B6dkQ_1756741974
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so41989745e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 08:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756741973; x=1757346773;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbEdJL0isBBnB3JXZr3cyBmB7UVFLdKlgzj7B1K9tQk=;
        b=jdbODBHM/bILhUKI7pbrUeOJ9wUWwZ2Ryi+4Fhk0P8cxCU3bgvJBV+VBYK9BoBdwJ+
         x5WBqpeTAwzDIWc5wA0PtHGTxa45WCSOzY9AmGehFGBPi1KxMGAjrDnri+KUAocDnd+X
         4NSbkUqCJ1XByZ4K1wNYyc3sC3HjB34RJu2sgGWyqvSAB9ERY0Xnd0+VzSYiUarIdxhg
         P1aPdXf724IYLbGYBpivXTl1kn8aD4MDs5kR+Rd2FHRoABQvfecssmZlbvbAkWwCaZV6
         R+y9itd/kIWaIyHHHjTc7//9Kv+0sR0RusOV0Vdcptgc1MZzaYua/jSYykXpnvVAgaTd
         baNw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9IKMrFXtIxZJKKGgtz8tbZoZz3/R4tXX8ksG65WLennJS4/JGKS5VSczws7QpcvSkmMwilMQInuPsZQU@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoe4SG3qAS3jigXbeyTJzbXAt5JRqRrhIKPgkvOyB5PCZeDW+e
	C6id3JYeTSHLUFXKHTy1Xo9ZSJcIrcTHDumgcQx8dsC308++48zDoJAzNfyJOphqSQFWrWCXisP
	nqzV8QhBsvEUeqIOCQtZVA69zNdXU1h0i0P+tulCOKI5G1ilChNcK6n7Qf/sWpVpOAlA=
X-Gm-Gg: ASbGncsIRAcaVhm+LQRgNagkI1SHoqqQ+PvfBwjTiqOPqHD+JYzbJ1bigQMKcO9nipe
	puEHmEg+gcOu4+7EvsN/oUw2C/btqjBDEgdP4BoaMghN9a1gGEfsqe63N98iAsno6sr24FvDLnM
	AByye3pCamy/iVhg6UuB4np/jqGkKtBSEKiU7d2hBUun1t+OkqmWE16kDEyyOhaRu8wzHkgAQ2o
	eDRuWo+Mt3100eVHTuO+c1Jr65az9PDQbFehRX0vZHGCBx8lo//L5CkhFR088kvgkfZosq7u/yH
	JXN5vfvvUOQHx8GzLga5cT13SvQ7WjCxm74Pv+ffLsLzjB87kvCFdMKaEOm1SK9/PgOdlNyjHTj
	rvj6xApMT37onC5RJ62i6O7kjjLFtA2E4vC/9ONhm52yaLa+ocd4JtKmn/6CamkVGsrg=
X-Received: by 2002:adf:a3d5:0:b0:3d3:b30:4cf2 with SMTP id ffacd0b85a97d-3d30b30546dmr3216774f8f.19.1756741973371;
        Mon, 01 Sep 2025 08:52:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWAtKuDlQ702dYFHQ1RXyln2bmyih7xTaCXC/Ysq58gGE3o708RIRxMtCSozokpICZYopN0g==
X-Received: by 2002:adf:a3d5:0:b0:3d3:b30:4cf2 with SMTP id ffacd0b85a97d-3d30b30546dmr3216732f8f.19.1756741972788;
        Mon, 01 Sep 2025 08:52:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9dbfsm15756340f8f.43.2025.09.01.08.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 08:52:52 -0700 (PDT)
Message-ID: <001833dc-ee02-4bd3-8a37-820d0cd56be0@redhat.com>
Date: Mon, 1 Sep 2025 17:52:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] mm: constify pagemap related test functions for
 improved const-correctness
To: Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 willy@infradead.org, hughd@google.com, mhocko@suse.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Liam.Howlett@oracle.com,
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
 <20250901123028.3383461-3-max.kellermann@ionos.com>
 <26cb47bb-df98-4bda-a101-3c27298e4452@lucifer.local>
 <CAKPOu+_aj3wA14VaZo8_k+ukw0OafsSz_Bxa120SQbYi4SqR7g@mail.gmail.com>
 <8e3f20bf-eda7-496c-9fb2-60f5f940af22@lucifer.local>
 <925480c3-d0ff-4f24-ada0-966ad9a83080@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <925480c3-d0ff-4f24-ada0-966ad9a83080@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 17:47, Vlastimil Babka wrote:
> On 9/1/25 17:14, Lorenzo Stoakes wrote:
>> On Mon, Sep 01, 2025 at 04:50:50PM +0200, Max Kellermann wrote:
>>> On Mon, Sep 1, 2025 at 4:25 PM Lorenzo Stoakes
>>> <lorenzo.stoakes@oracle.com> wrote:
>>>> 1. (most useful) Const pointer (const <type> *<param>) means that the dereffed
>>>>     value is const, so *<param> = <val> or <param>-><field> = <val> are prohibited.
>>>
>>> Only this was what my initial patch was about.
>>
>> Right agreed then.
>>
>>>
>>>> 2. (less useful) We can't modify the actual pointer value either, so
>>>>     e.g. <param> = <new param> is prohibited.
>>>
>>> This wasn't my idea, it was Andrew Morton's idea, supported by Yuanchu Xie:
>>>   https://lore.kernel.org/lkml/CAJj2-QHVC0QW_4X95LLAnM=1g6apH==-OXZu65SVeBj0tSUcBg@mail.gmail.com/
>>
>> Andrew said:
>>
>> "Not that I'm suggesting that someone go in and make this change."
>>
>> And Yuanchu said:
>>
>> "Longer function readability would benefit from that, but it's IMO infeasible to
>> do so everywhere."
>>
>> (he also mentions it'd be good if gcc could wran on it).
>>
>> So this isn't quite true actually.
> 
> I understood it the same, that it would be nice if gcc treated incoming
> params (i.e. pointers, not pointed-to values) as const and warn otherwise,
> but not suggesting we should start doing that manually.
> 
> I personally agree that adding those extra "const" is of little value and
> makes the function definition lines longer and harder to read and so would
> rather not add those.
> 
> I mean we could first collectively decide (and that's not a review
> half-suggesting we do them) that we want them, and document that, but AFAIK
> that's not the case yet. While there's already an agreement that const
> pointed-to values is a good thing and nobody objects that.

Yeah, and discussed elsewhere in this series, it would also have to be 
clarified how to deal with the *const" (or const values in general) with 
function declaration vs. definition. I don't think we really have 
written-down rule for that yet.

-- 
Cheers

David / dhildenb


