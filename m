Return-Path: <linux-fsdevel+bounces-59885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F747B3EB00
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9785A188A843
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F512EC08F;
	Mon,  1 Sep 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JajueSMK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F362EC08B
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740330; cv=none; b=ubAk23ARh4jfTuuyyxJ37OrXZfcme7/0OiS3sqJtDeNAkexWFuMp7YhxKmHnsMjOfy0GbLsy1828DCzI/TDPJe/YHjoDNrZVM0Dnt9UQjXnXo2oJUKgUeeO8y2AzUDQsFuHdF4dOrRSQxYMof+Ia2R2y00arnkJQKJIf604WDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740330; c=relaxed/simple;
	bh=iLPg5/NsqE2fgJNlNze5wZTZC18RwFd3hiEqg2oxKz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOvEQYdcSbGTr08nG5BL845jHTXUbBzpwC3tXO5FryFuz0krWzdyuJ9STryjJfQXnOGhtF773BF7HzpZSpSsq6fO4jSLignLNLvAvj14/Hce+ediSPJkzLNPsbVlXpMCtqvoukzqPjgmQOol16bbVNtNcjKLfL6IRolrjovBsmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JajueSMK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756740327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t7wTvc9eUbw7jtHlrnxQy+rN4qRUOO7ojXz7+PUk6M8=;
	b=JajueSMKM0IjV39DBZ6nXqgNqJmzASMyInByClVwCfutfAFEEr0Kl5ZWFHBJ3mCOLJmKWv
	iPYBCXfVcizcWGyeTIWqoBgm5gC/hyA59PIWTOOQM3SBS8/9FPtjk6+obGoNdPT6dYlOPX
	K65Jz9MGigTWU44Xe8gSUvqZau9e9WY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-FXDp-bKZPbumKywRWPoWbA-1; Mon, 01 Sep 2025 11:25:26 -0400
X-MC-Unique: FXDp-bKZPbumKywRWPoWbA-1
X-Mimecast-MFC-AGG-ID: FXDp-bKZPbumKywRWPoWbA_1756740325
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3d3d2472b92so1008472f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 08:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756740325; x=1757345125;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7wTvc9eUbw7jtHlrnxQy+rN4qRUOO7ojXz7+PUk6M8=;
        b=etK9lnBHjzthOY+5YVFJBmHRUnv4ifsTEFykiQUUICk6my4JqC1DfUwpALK6yBbX9k
         JDGuNkPPu6ICmv+i1gPzG15Nqd2x9Jb4JFI5cjfZWdgwMErUJq2fN02/rQ2h5dz5o3DB
         lSffy/E3piBaeFYSAnDb9kiSAMvt1g6OXHXGZixszrlu1lwLTLvBm5C6I8Ejww2cAVTk
         pPnAvHSVScllcYQ5wT9gMO4LwNg/Idba4IPrz4Tj9IkDOkYsGKiB3QDhTU7ULUhorSML
         DXGN4QljbMZpv+C/D68QAByc5r/E3hP8OSI4Jm4WGmGSS0k7Rg+vy9bOtHiZxoiBFt5e
         BHag==
X-Forwarded-Encrypted: i=1; AJvYcCWeTvzAgm/AtAycC6qliYCOajOembsXuM9pUzLRdU3fS/gfii+HUb8qPG8o4a4zHjiZ5ve5jG0ZM/9u1PKt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2gY/KZYvwRm+9qx9fbMmsuP7TExMzcuMd3vKv/fTIRZSHzh7G
	2FvPfLVDaOTCIARaZpwKzTqBdC0WpzqmUJ3r+6XdUNsd5rD5VFn4y/sZtSLtr8BjoqE/vGVnMRD
	FNg6Pi99wEIo9Nnt4p6Ry4+w5JUiJwF53oZpfw9TPVRtbxg9KaqfAKepgtXPGf5SkDA4=
X-Gm-Gg: ASbGnctXjXTTWK6nW3irvFLwg2VxcIevKgj5+KdXtmp3dF0b6+lVw+WeIeo4YGRjDFK
	lQa1KX3LkW3atpNbwbEamwtBSoEuvmr9dsp5+/ucgRWRhTqAO/+d9YJuvCcPz2+dftvYWkC5iM2
	dPnUB1bFqTyKOm239LGSO+/7sXjs25NQS9iLwbLWz8HkFm4d1XDWkQvBqIVed4V0EYUtjaeI3zt
	IlQruNSjAr9JVnfajAl4tvgA18s9IPYqfKfQ5vRX6ddLwMEKaXFtkTHfpmxTMxc9iz4Ase7gPKv
	3sRi/w4ZakELHMyf5LhD1cyKYgYlQu3eT1u3qsCvga+AFwQ29S8p8qts8hx5aR13EBw1B+P/vDh
	97hO97Q7Aq3E2WkpW5LkgjRCwVSRFnVKLd+KK10IhvkqdmkX47FSJzyR3+U+Gc8alfCc=
X-Received: by 2002:a5d:5d09:0:b0:3b8:893f:a185 with SMTP id ffacd0b85a97d-3d1df34f216mr7377164f8f.53.1756740324996;
        Mon, 01 Sep 2025 08:25:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyQFfDTfcx6weYHYURNCUN2TyUMgP1+sDx60HW3E6IenOe07uG2Bl4c+GEZR2K3WNO1i1qFA==
X-Received: by 2002:a5d:5d09:0:b0:3b8:893f:a185 with SMTP id ffacd0b85a97d-3d1df34f216mr7377103f8f.53.1756740324457;
        Mon, 01 Sep 2025 08:25:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d21a80c723sm10724135f8f.9.2025.09.01.08.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 08:25:23 -0700 (PDT)
Message-ID: <4ce074b4-8f79-4e69-81c1-d6e28239ccf0@redhat.com>
Date: Mon, 1 Sep 2025 17:25:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/12] mm: constify assert/test functions in mm.h
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
 <20250901123028.3383461-12-max.kellermann@ionos.com>
 <081a7335-ec84-4e26-9ea2-251e3fc42277@redhat.com>
 <CAKPOu+8xJJ91pOymWxJ0W3wum_mHPkn_nR7BegzmrjFwEMLrGg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAKPOu+8xJJ91pOymWxJ0W3wum_mHPkn_nR7BegzmrjFwEMLrGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 17:17, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 4:07 PM David Hildenbrand <david@redhat.com> wrote:
>>> -static inline void assert_fault_locked(struct vm_fault *vmf)
>>> +static inline void assert_fault_locked(const struct vm_fault *vmf)
>>>    {
>>
>> This confused me a bit: in the upper variant it's "*const" and here it's
>> "const *".
> 
> That was indeed a mistake. Both should be "const*const".
> 
>> There are multiple such cases here, which might imply that it is not
>> "relatively trivial to const-ify them". :)
> 
> I double-checked this patch and couldn't find any other such mistake.
> Or do you mean the function vs prototype thing on parameter values?

If there is a simple rule (declaration/definition), then it's trivial. 
Probably worth spelling out that rule somewhere (unless I missed it).

As raised in the other reply, not sure if we should just keep them in sync.

I'm, not the biggest fan of the *const in general here. I can see why 
Andrew suggested it, but only doing that for pointers is a bit weird. 
Anyhow, that discussion is likely happening elsewhere, and I don't think 
there is real harm when doing it, as long as we are consistent with what 
we're doing.

-- 
Cheers

David / dhildenb


