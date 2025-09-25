Return-Path: <linux-fsdevel+bounces-62810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C355BA155D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 22:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF3F4A446E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 20:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CD131FED4;
	Thu, 25 Sep 2025 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYY2FcXa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1A31D739
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758831237; cv=none; b=GYtIdfxUMzD9LpiXRK/o4HcwoxcRrfN11aigtJ+WGo+Ko/8o0OoMFlEUXbcFF56Wbc6XR/pQ9/UW/xDB5LsOt5tqfpWA+7g71+6BI1IHP0Fg8cAcAXyYpovolrNwgNCAxgA6qGJk+UBlf6tfss/F1DOUD/OM5F4THaoCee2jb1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758831237; c=relaxed/simple;
	bh=VRNU/SIeWDAUnJXorg9z/v07pFFZ+5txlBQH4Ycxe7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpfvhS1FxP7zDpZOBKZD+VAGQccr/Syldw82/Z013xSIi4r6tJUjy7rn2SZWbozoGBySB6bWtEFvMJIOYQmiMO3sZDRoxbJTGCwPsfhgobyO3SFTfRN1KNp83BBCsAZoLET9dvrVX0H2Uz/xN2Xp2WEN08X8wWOADulOb5sAFqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYY2FcXa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758831235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jt934pWl+waL11DifZ1ogJABhsR0QZuMWPNAUgnNLvs=;
	b=VYY2FcXaBZks3tU+nhQljYUYYKGFm63A2cYscpezfbVfBudBl20IX/+dpkL6dfCX/gcCju
	tvnuIOagUtuRqwfk6UJLN3BxWLFptVyFkC2KPSvfzXNJLWIMEOjDyntlebT+xNdG9hk0WE
	2er/TVG4PwbfwY9JFUnvj5fiBWEqFSk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-5AjkfIlMOFy_0y3H-R5cBA-1; Thu, 25 Sep 2025 16:13:53 -0400
X-MC-Unique: 5AjkfIlMOFy_0y3H-R5cBA-1
X-Mimecast-MFC-AGG-ID: 5AjkfIlMOFy_0y3H-R5cBA_1758831232
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f93db57449so694404f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 13:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758831232; x=1759436032;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jt934pWl+waL11DifZ1ogJABhsR0QZuMWPNAUgnNLvs=;
        b=vhL39Z5Ok3IkDdKV+iPuU811KFpPZ09gr1YgDBqLdM3HEm9LFsBbQ6PLhHY2ebbVmS
         rGc7gkvdCEHqSAOTxMhwIo3sv/8MM/LyskDT749P1aKwA5OnR6eQ4+Hd7woHtT+bkMdm
         m8TZKQQygi65bC9c9E5KSuZ+u69W6ujmfbBu8LPrRU515gmqyQjdfRqbEbWx+0vD40IZ
         M88tfVLpX5D5iHqa+UM1SAJSrtO+dKgVX4RtGF/EiQ26YslKPwk1iO7dHt9m93wNLdpo
         KlWyb9aIsW7cC/pdt6qLHH/9bzrxEj2EsNQ8gKKZzyl6pzQnHRvwNgNS2yOB5japMylw
         2J6w==
X-Forwarded-Encrypted: i=1; AJvYcCXTGR6NRRpV4ZOEwgHHEXM5p5RKApeFUYtUEl+dDUa6XIbtCG0clLxHe1or5slmc9rDF96hMtL5wCOBbHBQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzOFRZCbtUHpFwpc6xiTiZhlGCAIBNuz6cpA02ynZe5JoYdeoTd
	myoEsm9K1pSB7OwN6CatIewn+sapH/GX/RR0csiOZY7z7v3DpleRccCG+qcmw3O+eYU7hUNmIOH
	D+nG2y1ckqTgdHXPfria79Q0jK0onj1TSscj3ogGziKCnYROR7rka3F3hQkylgEbKtTU=
X-Gm-Gg: ASbGncsK7WPX+/RCOygQdY8nZMJW5z70Qf6MCPrMlfjsz3KtA6zVM3JodJ9XA4O5bCn
	XeKwyuyN28x139OSwvJcl5nS9DzH3FPvjWC+PGsdqC/KL/aAjhRnsWNa4ymyCFS1PPtUtFPFEpf
	/yCvcQS+UVnbB/bnLT4By0F/RUuYgEg4gQsgT+SlukG4yJI/CHTuZv/h0e3G29g4i4rK9JgeZDW
	ACm3CGtgMp9Ih1bMryoSOqnSLqhsnEugMucd5b/GcytK0jGxU3IvRfoSnJ1WrFNwwshwnd4sjGG
	OciZjElHzH+3j1m19c6T8C71EeroD7MTiewxH0Wnl7iEg9CDA0vYWj8ASxg2V/17uocHt8ZSHmt
	cnS7OkW9I9o1zZsuO1JArKtceHpFJTaoH0VCnuBAgSBS8c/+k1GEhHDPcCA5bVdWe3MNt
X-Received: by 2002:a05:6000:2304:b0:3ea:bed8:7040 with SMTP id ffacd0b85a97d-40e46ad00b9mr4712240f8f.25.1758831231694;
        Thu, 25 Sep 2025 13:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFVVNLdXy4p/tTQ+NT/ePAfr5Q0kgcDHv5gQvTT3sYR20nows4MCsqZEQWfZcFoJRiSMKYvg==
X-Received: by 2002:a05:6000:2304:b0:3ea:bed8:7040 with SMTP id ffacd0b85a97d-40e46ad00b9mr4712175f8f.25.1758831231212;
        Thu, 25 Sep 2025 13:13:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2ff6sm4094888f8f.56.2025.09.25.13.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 13:13:50 -0700 (PDT)
Message-ID: <c79173d8-6f18-40fa-9621-e691990501e4@redhat.com>
Date: Thu, 25 Sep 2025 22:13:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/12] KVM: guest_memfd: add module param for disabling
 TLB flushing
To: Dave Hansen <dave.hansen@intel.com>, "Roy, Patrick" <roypat@amazon.co.uk>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "willy@infradead.org" <willy@infradead.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>,
 "surenb@google.com" <surenb@google.com>, "mhocko@suse.com"
 <mhocko@suse.com>, "song@kernel.org" <song@kernel.org>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>,
 "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@fomichev.me"
 <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jannh@google.com"
 <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
 "shuah@kernel.org" <shuah@kernel.org>, "seanjc@google.com"
 <seanjc@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "Cali, Marco" <xmarcalx@amazon.co.uk>,
 "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 "Thomson, Jack" <jackabt@amazon.co.uk>,
 "derekmn@amazon.co.uk" <derekmn@amazon.co.uk>,
 "tabba@google.com" <tabba@google.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk>
 <20250924152214.7292-3-roypat@amazon.co.uk>
 <e25867b6-ffc0-4c7c-9635-9b3f47b186ca@intel.com>
 <c1875a54-0c87-450f-9370-29e7ec4fea3d@redhat.com>
 <82bff1c4-987f-46cb-833c-bd99eaa46e7a@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <82bff1c4-987f-46cb-833c-bd99eaa46e7a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.25 21:59, Dave Hansen wrote:
> On 9/25/25 12:20, David Hildenbrand wrote:
>> On 25.09.25 20:27, Dave Hansen wrote:
>>> On 9/24/25 08:22, Roy, Patrick wrote:
>>>> Add an option to not perform TLB flushes after direct map manipulations.
>>>
>>> I'd really prefer this be left out for now. It's a massive can of worms.
>>> Let's agree on something that works and has well-defined behavior before
>>> we go breaking it on purpose.
>>
>> May I ask what the big concern here is?
> 
> It's not a _big_ concern. 

Oh, I read "can of worms" and thought there is something seriously 
problematic :)

> I just think we want to start on something
> like this as simple, secure, and deterministic as possible.

Yes, I agree. And it should be the default. Less secure would have to be 
opt-in and documented thoroughly.

> 
> Let's say that with all the unmaps that load_unaligned_zeropad() faults
> start to bite us. It'll take longer to find them if the TLB isn't flushed.
> 
> Basically, it'll make the bad things happen sooner rather than later.

Agreed.

-- 
Cheers

David / dhildenb


