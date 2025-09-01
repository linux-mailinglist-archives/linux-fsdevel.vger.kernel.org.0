Return-Path: <linux-fsdevel+bounces-59773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC909B3E082
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B203B0118
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 10:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA9730FC0B;
	Mon,  1 Sep 2025 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEs2XUOp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4F32AD14
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723431; cv=none; b=GvVSkCaH+4h7Sj9fyjUD7P0InSBXKeWzR1WDjKhWiOBRS1kYe1Zl77n8PAgrawBzPrI+/jK3xd3Zo95c3fh0GLivoc/e7DOx4YXcu53ZoVKebboeE2ulVNJk67CVk0Z+MxH3FG2vm8u/KBsLD2M0cvmjp1BSHaDLe9K6Yo4TCaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723431; c=relaxed/simple;
	bh=lvzv60LKBxa0H21GOqSNuXFtwIgqJ+F5zPooU13Z+MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOSgeGJEy6Syn5Q+iyP07k/aK+DMYZ05FyX0rZglFZ0WAcnGfvrj05LcOfIAUkwgZ32rKJ+PpB4JkjbBLVLhYJ/RHaN9g2PO4RbtwWUkl14DmpwMWpecoe/gihYsXlYLiPH2dAusrlBWd/N2hYXbk3BYrVzx+ghOfUBzQVhwlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IEs2XUOp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756723429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zrru358Oin71TiKq2hMC68tlViLzszSZkEqb3BaG11I=;
	b=IEs2XUOpiOiJ7zZoDYb63g4FWTHZCy5hcK480H2zEajdo9PVm1zkY+xQfb++QqomOBDn6S
	2+d+9oVwOqbTjfT/iXQyC6xhOb9gVnKgzMsgGs2khStoRLJpz5gg3eUKV+hAS8jyoPbAhF
	8n1z/9F64XBQgf0Dh4YJoaCcYX5fF6A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-rrRZki5CMqqLfRyppJmHLg-1; Mon, 01 Sep 2025 06:43:48 -0400
X-MC-Unique: rrRZki5CMqqLfRyppJmHLg-1
X-Mimecast-MFC-AGG-ID: rrRZki5CMqqLfRyppJmHLg_1756723427
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b74ec7cd0so25549385e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 03:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756723427; x=1757328227;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zrru358Oin71TiKq2hMC68tlViLzszSZkEqb3BaG11I=;
        b=R5U9JkEilL93KCf6yd/muWfmqnXj8gLuVZaU4vXthEQrYeMSZVTbn9vsLv4ymuuqFd
         +AkMPWhVixhZx25OFrOruj8mviWiezKUlWksaL6Er3jtmYAW63fYWYtHfafS6Akj4Ji7
         RZxmHNvwmrVOdXswYKD0ShUgGpsOdoFZEQSdH/5moxo80VrL59vsY2K0/8fWXEPHLe2a
         8fBCGlSpGMy5eiSCb6kyQMJ+CqfofftTPJRrBu+gloOOeg6s/XwGFtsWaAn00JgTdXVd
         3vxDbzQXPbN7qdQtXMlGnYD/hRVHjWZH6A63VN36Md5YGiDZ9IReoDOWJmxQGP2hp464
         f6pg==
X-Forwarded-Encrypted: i=1; AJvYcCW8z5RLO8A4OlLysWeYPisC+Oq6pMSjJvfvZeYdN1CsAOAIPvAEHD5HTExxHtpbDaS9ue6qKg33pKFHIIbO@vger.kernel.org
X-Gm-Message-State: AOJu0YwbN0ppnmZ/c+bK1IErnEaTyKAG7BqijvNBuNe4HdyDkIoNZYJg
	SqPOGb+ixPlizmN5410hMkmW9cyfl4bXf8/dMu6EBB+ThHC2aOlQxGZfPqwEjfcGVIa3V0d8TKB
	lBwUYu3jiqehb80o7zmXcTgopAUOpq+MKTzqFKONSEmJsa89vpoG4fbI7KugnobWpwgo=
X-Gm-Gg: ASbGncs2lHJkHp02Ms5ICYeC9j6AJBVrtHZUpS9dCyyfQxzUThaOwuF7QycmpL236gg
	41MxGcLsb1EvSJKL68JrPvbV93wBj6/k8M7NaVkx10kQ0/F3XHPwyMdRgRRdTXVgwtSqJ2/k6/L
	AncL+plN8JB2eR+H+tb0vValGEWdz3dyrM2b+kSLJ86Ii4W7/Bivnzdk7tu+J8ZDs9R9IRC+58r
	4vIg2fwpc26Rx1VAi4VmHrI452gSMijocU2q332eIhJyMxo8W44kp4M2jjzGkLqkxIcdGHc3q12
	++6Qfabdt+jnRtxY3INn5cPn3KepSWxIKrnyaNHZrxTpmK812mogUGXfgSXbeR0SMR5quoxPLxW
	0zSbfu9OK/LHJf1ugfRgfpBZsdrR+KjdKPImGyd4bKOBZr5tg98TVwUbrjVt+XD/Qm+0=
X-Received: by 2002:a05:600c:1f13:b0:45b:8ab0:59a9 with SMTP id 5b1f17b1804b1-45b8ab05bd1mr39257205e9.18.1756723426864;
        Mon, 01 Sep 2025 03:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXxb4OFUEp+gmXD4h1anmHcaA/DXKzIrss5TRKXevtLzyH/iVfzwjgDIJ/CEIsJTOraM8Ezw==
X-Received: by 2002:a05:600c:1f13:b0:45b:8ab0:59a9 with SMTP id 5b1f17b1804b1-45b8ab05bd1mr39256555e9.18.1756723426359;
        Mon, 01 Sep 2025 03:43:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e74b72esm154711095e9.0.2025.09.01.03.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 03:43:45 -0700 (PDT)
Message-ID: <bfe1ae86-981a-4bd5-a96d-2879ef1b3af2@redhat.com>
Date: Mon, 1 Sep 2025 12:43:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] mm: establish const-correctness for pointer
 parameters
To: Max Kellermann <max.kellermann@ionos.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 willy@infradead.org, hughd@google.com, mhocko@suse.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
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
 linux-fsdevel@vger.kernel.org, conduct@kernel.org
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
 <f065d6ae-c7a7-4b43-9a7d-47b35adf944e@lucifer.local>
 <CAKPOu+9smVnEyiRo=gibtpq7opF80s5XiX=B8+fxEBV7v3-Gyw@mail.gmail.com>
 <76348dd5-3edf-46fc-a531-b577aad1c850@lucifer.local>
 <CAKPOu+-cWED5_KF0BecqxVGKJFWZciJFENxxBSOA+-Ki_4i9zQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAKPOu+-cWED5_KF0BecqxVGKJFWZciJFENxxBSOA+-Ki_4i9zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 12:20, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 12:04 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
>>
>> +cc CoC.
>>
>> On Mon, Sep 01, 2025 at 11:54:18AM +0200, Max Kellermann wrote:
>>> On Mon, Sep 1, 2025 at 11:44 AM Lorenzo Stoakes
>>> <lorenzo.stoakes@oracle.com> wrote:
>>>> You are purposefully engaging in malicious compliance here, this isn't how
>>>> things work.
>>>
>>> This accusation of yours is NOT:
>>> - Using welcoming and inclusive language
>>> - Being respectful of differing viewpoints and experiences
>>> - Showing empathy towards other community members
>>>
>>> This is also not constructive criticism. It's just a personal attack.
>>
>> It is absolutely none of these things, you admitted yourself you thought the
>> review was stupid and you used an LLM to adhere to it, clearly with bad faith
>> itnent.
> 
> There must be a huge misunderstanding somewhere. I and you guys must
> be talking in a completely different language. None of that is true
> from my perspective.
> 
> I never called any review stupid, nor did I admit that. I disagreed,
> but that's not the same thing. Remember when I told you "Let's agree
> to disagree"? It's perfectly fine to have different opinions. Please
> don't mix that up.
> 
>>>
>>> (I'm also still waiting for your reply to
>>> https://lore.kernel.org/lkml/CAKPOu+8esz_C=-m1+-Uip3ynbLm1geutJc7ip56mNJTOpm0BPA@mail.gmail.com/
>>> )
>>
>> Your behaviour there was appalling and clearly a personal attack.
> 
> It was not. Maybe you felt that way, but I did not intend you to feel
> that way. I would like to find out why you felt that way (because I
> don't have the slightest clue), that's why I asked, and why I'm
> waiting for your reply. If you would reply, maybe we could clear
> things up and resolve the misunderstanding.
> 
> It sounds like I won't ever have the chance to do that, so... farewell.

Let's all calm down a bit.

Max, I think this series here is valuable, and you can see that from the 
engagement from reviewers (this is a *good* thing, I sometimes wish I 
would get feedback that would help me improve my submissions).

So if you don't want to follow-up on this series to polish the patch 
descriptions etc,, let me now and I (or someone else around here) can 
drag it over the finishing line.

-- 
Cheers

David / dhildenb


