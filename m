Return-Path: <linux-fsdevel+bounces-55242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110DDB08BE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C00A620CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9C529B772;
	Thu, 17 Jul 2025 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCkX2a96"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7862136358
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752771; cv=none; b=EUlaP9BokKKEh7uWK2I4PfJG9QIvYyf/osvZHF5BRQQL61OXezqVbY2PAoUl66+8fwHAxXqjQHHG7tn76T+qmBj2G6u6BiPDos3ZLyf85+fZgbRcl7Kz50+F/abybjSJl5pYpuSMuUZdiiUYfuYx3cQPrFpG+53B180E+iOe6Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752771; c=relaxed/simple;
	bh=y5Yvsl4fGOPbGkM+LLjwuxdkLlvSVR7Mj0EaWJvOXyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmmlqKEMUm4Uvexe1Bm1YzqwsWJXYy8E7yB4i44/qaxrSO5Ff7MBaVwBtdCmAk5r4z8Hhw7LOikW1E+XgDK01DwvIU+rAnFiOumysk66WPCnPfmhGWnFOwZXfX3IlCUhg0zXEXp+P2oFGrQEWz2j93qNkGkzLss5OWdJVlswcZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCkX2a96; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752752768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f3CNnOqez6AzkBc0azQI5WcTOpAKQZ1WjefmRJbSD+o=;
	b=GCkX2a96l1NJI7SCSTPx0BhcJi2OopMdNEofOIDF9yyUaGnDvjsmACrAyjz7sbH4P7fsSL
	m0JFVqFQarxAxo0zmjQNBHg3zH1qBbNOiNlxk+ZNyfYNoKNFuejbLgrM7/R6lXbFffFoaw
	BI3SGYZxzBqRFrlpKIencpQBcBXlbE8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-89BE2iI2NgakwNz5eb7fXw-1; Thu, 17 Jul 2025 07:46:07 -0400
X-MC-Unique: 89BE2iI2NgakwNz5eb7fXw-1
X-Mimecast-MFC-AGG-ID: 89BE2iI2NgakwNz5eb7fXw_1752752766
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d30992bcso6602805e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 04:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752752766; x=1753357566;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f3CNnOqez6AzkBc0azQI5WcTOpAKQZ1WjefmRJbSD+o=;
        b=L3KuKvDkuDeBtqm4nLcfoqHiG4RMLIHjJN1faCzQzKtQz0AkAaMbFJ7lmhtVjc3Sli
         Aa8z7D2MunlmjQXIMotTuCelOB/xaAUpns4xIp3GSSYN/BbTYXILb3+v2J5dQmO8luH5
         5cw06pVfAvptZL9FlH8Vk+MEyQny/CEbZ+l3IapjQfbgba5h2scdYo9Ns2i/9dOmI1fe
         grr4qLZ3ebsdqlgVZWtFgigDyqHOWEcjPBNWYKQ4RbhyAGWrmJnMBHYfiXeSfABTaQc3
         7Rg7knJOcw/Z98Hd1XNFE/+LGG8I9iPVQjZqVQXXC2Atld1VEq0GJAwESrJ5R4obEDNZ
         m5Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVrLvzxSQUzT76YmkQH2k+5dhPULvTQdIiPSmypPltYRFkPlc6ygsr8NaX1+quAUHt7a2LHsYs4ZNYpFVDH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk2u0lDONzrcPzCBjLfrQTZ9FT1UVPr+pU8Ya91l5YXzeVU8T2
	8rBGWnj0dhL3aDgJH8gDpsgWUwOr6zHxMeE4NNUGyHSmzD9AIdYNeIOi6XHal7nK+nnLPHIVC3O
	SSZdsjJooc+F7HBh7DxWUteV2lSlgVsDXF74kMfUoMfTNjbmFpXooenIXxSKl1fqn/nU=
X-Gm-Gg: ASbGnctcGYnlomx24nC/Gdo1Ti0gP8erhOjt48lxawVIkOMBFRmY0OEDbOID2k2b1Xd
	aS7xxEttH3r/7x5GSyxGN6Jj3da64dQxBiGMafhiO/yhuJsWuflI65LU3rcaT6AzKzTru/ZSjUi
	sG9P1KJACfqMAtkcBvdFzOFPVN4lA84worLbHht2/3DmXUZ8HID/sBlevyP0H4d42le36h3uLCv
	BxKp0FJdhvbsogkyJ185u7dbHmgUp65YdiyAKahTJei3hI5+nrGg4sZ4FZ0Sp7knzCDQicCd26X
	sSR5A3qVTNtxdOJ60v38sgu6zI/xS4liG5/oza0bLFkxla9zYnsZtk0XpzRUpfxZFOUoqzWJTjp
	YHK2Sp/5asTN6lBQg0fu0TV307Bvk9aRBeAoTV6aOq6KNkf3uVf+QWrqXztlA7FrN
X-Received: by 2002:a05:600c:a10f:b0:454:ad94:4b3d with SMTP id 5b1f17b1804b1-4562e37a0f7mr44076175e9.1.1752752765702;
        Thu, 17 Jul 2025 04:46:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmFjfdXEG/fRnZhxAAlgeVgrboqZitpFuKt4eHOADc0jjqpqiFBONXu1paEh0mp24W2TnnLQ==
X-Received: by 2002:a05:600c:a10f:b0:454:ad94:4b3d with SMTP id 5b1f17b1804b1-4562e37a0f7mr44075725e9.1.1752752765217;
        Thu, 17 Jul 2025 04:46:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7? (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc91d8sm20291948f8f.42.2025.07.17.04.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:46:04 -0700 (PDT)
Message-ID: <ea55eb30-552a-4fca-83e0-342ec7c98768@redhat.com>
Date: Thu, 17 Jul 2025 13:46:03 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: add static PMD zero page
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-4-kernel@pankajraghav.com>
 <26fded53-b79d-4538-bc56-3d2055eb5d62@redhat.com>
 <fbcb6038-43a9-4d47-8cf7-f5ca32824079@redhat.com>
 <gr6zfputin56222rjxbvnsacvuhh3ghabjbk6dgf4mcvgm2bs6@w7jak5ywgskw>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <gr6zfputin56222rjxbvnsacvuhh3ghabjbk6dgf4mcvgm2bs6@w7jak5ywgskw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.07.25 12:34, Pankaj Raghav (Samsung) wrote:
>>> Then, we'd only need a config option to allow for that to happen.
>>
>> Something incomplete and very hacky just to give an idea. It would try allocating
>> it if there is actual code running that would need it, and then have it
>> stick around forever.
>>
> Thanks a lot for this David :) I think this is a much better idea and
> reduces the amount code and reuse the existing infrastructure.
> 
> I will try this approach in the next version.
> 
> <snip>
>> +       /*
>> +        * Our raised reference will prevent the shrinker from ever having
>> +        * success -> static.
>> +        */
>> +       if (atomic_read(&huge_zero_folio_is_static))
>> +               return huge_zero_folio;
>> +       /* TODO: memblock allocation if buddy is not up yet? Or Reject that earlier. */
> 
> Do we need memblock allocation? At least the use cases I forsee for
> static pmd zero page are all after the mm is up. So I don't see why we
> need to allocate it via memblock.

Even better!

We might want to detect whether allocation of the huge zeropage failed a 
couple of times and then just give up. Otherwise, each and every user of 
the largest zero folio will keep allocating it.

-- 
Cheers,

David / dhildenb


