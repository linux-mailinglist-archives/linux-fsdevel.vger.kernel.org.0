Return-Path: <linux-fsdevel+bounces-52882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFB8AE7EDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 12:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A381E189EADC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9752029AAEC;
	Wed, 25 Jun 2025 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/wtGTNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A6275871
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846497; cv=none; b=bdOU8rUFnpBNZoryTSKI7jqcy7OEGrDt7G4oZi3oV5lcQCXFG/V9O1GhVXok3Z2Fs80/6c8MuSLOVSloxKbxkrxcbPRNMxE8WVw9TonIr0gVXuyxo9X998iNs5xoWrcFIcyLGTOcF3mYQWpG2wTsczj8F8DEL8qP8NdDtr65z6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846497; c=relaxed/simple;
	bh=PzO6ztBfNimSyfx64qkZBXAUmYb+kTXD/55VqloyB5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZscB2V0wOwLIPhvCmCuWnybk+UzfNYFJu6v/nGZ7ZQ2FIf5GkOOaepMNveeE1yNDRKdi1+a8HwHblxI7rEgPH7Z2CLOGC5D4OIJKBXzrLJigcJmgMZPb9OAW+BvfwcNwSqwHktJHWw2S08bXlXRjB9pOqmlQQ975WIfA2QXVldI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/wtGTNC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750846494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XjdslU0hJ7FdAOMc0fmPmVs8CPi2M/vDu4x7gBoGlaw=;
	b=L/wtGTNCF1/yqGhXCRQJRYiDUb66NXlDfCvEyadVfl04hwwrNR6iM1ilqR1fjV047UGksW
	lt7z6ut7RPi1O6hkd1RAGZnjOT0PKZO4W7XY2saU8XG+ZuUHZlR38weKEaI5an/16sMNSM
	bYviktckhVH5JmQZoNLn1nqOb+UtPkQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-EkLlqSvkMXyXAsY4_OrqHA-1; Wed, 25 Jun 2025 06:14:52 -0400
X-MC-Unique: EkLlqSvkMXyXAsY4_OrqHA-1
X-Mimecast-MFC-AGG-ID: EkLlqSvkMXyXAsY4_OrqHA_1750846492
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-453817323afso4889705e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 03:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750846492; x=1751451292;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XjdslU0hJ7FdAOMc0fmPmVs8CPi2M/vDu4x7gBoGlaw=;
        b=YjNtu1v4VQYg4mSqxjBEG9GV+dM2Cp9an1BwTQKHkEc2s5Rq1UVfQ6ym9I/rzQg1GS
         4ej8wG5bpATtHz18hnC4jZPvE1b9S/vQSvNkjJPA1STDYg7RDtzvCnGCfdf8DXdVT58G
         TN3UgG454EurfFbFKm+D9Q6wXEPj7U1pVLLTsJDNBp3boWSz2zAfWDzYEYYG1dY888AJ
         2Zt/IXU7xRGGJ9+BRCKt0I7rZQdNZpHWC53x5kxNjbbCragFxQybZ39q57ge815Nblat
         KXsMwV9HUj9S996AkmLAFP/KSmYLhhdTVZ6Qq3Z1lseAtbLRgTU7iT2GQOTF5XLZZ02/
         53rA==
X-Forwarded-Encrypted: i=1; AJvYcCVjgPpDILYPZfJBwuYTUbtOaktrtDbMWeCLRmFtRWV0pqDQOFyoCtIEpEF1sCBuQd4KY0ecfTwVH4D5jiR6@vger.kernel.org
X-Gm-Message-State: AOJu0YzFvGfE7CKBA5//EeutUqgcC1fc8jZPLJOXcjpVZbJjIR0XDhft
	mv1UAapDnUIt4tMdxEEykVvjwWpG05kOzu00gl8eTbj6Rk61rtwvby6e2BjzGYoV1ZOj1J8J6Xz
	zhvOmf4jHfTPNAGAthFXwAAnFm488eBggQAn6qkzcTM2oL7NvXWGd7E4t37WFZDyH9ng=
X-Gm-Gg: ASbGncuple13OXDduAUnnZm8UxjKWgEtjVXdfnT+m/DaYZ026bRo0sWwqMpbrN1yJh1
	/2OkVuDAEPMLA53BoD88OhoS/Ie2XoB+xbZYZpM1/8wsWlFVmK6Q8liZtCZ/C7TREOHvDzGasXm
	RlX60YWr82hwi28ayaxh9tvm6h1xX1gBvP61lxPBU9qtcHXSmp3N7CbkGWGaURj4NvSZ5ZUBw62
	a9hiGCznY88z/47pGEuMeZTPpv5VtLPMNVIEwMxm58m/VhHmFU4RH9D0j8sVGuKHx/QAmNXOI8H
	MOIURcqxrdumDzN9yN8P4qp2K1W9yXTGr5a78TWA9QjeF4WF+DxuzA==
X-Received: by 2002:a05:600c:348f:b0:450:d00d:588b with SMTP id 5b1f17b1804b1-45381ac2563mr24960845e9.9.1750846491760;
        Wed, 25 Jun 2025 03:14:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH9JVXQGzeiIaOJETPwD0mhFgfVQwPa4nS7QJxUmuEV97nlCNLYTvAiF9sgliseCzUuOgbUg==
X-Received: by 2002:a05:600c:348f:b0:450:d00d:588b with SMTP id 5b1f17b1804b1-45381ac2563mr24960365e9.9.1750846491347;
        Wed, 25 Jun 2025 03:14:51 -0700 (PDT)
Received: from [192.168.3.141] (p57a1abde.dip0.t-ipconnect.de. [87.161.171.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm10471655e9.10.2025.06.25.03.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 03:14:50 -0700 (PDT)
Message-ID: <77dc3ddb-f748-48bf-8dc4-b8f904611f98@redhat.com>
Date: Wed, 25 Jun 2025 12:14:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/14] mm/memory: factor out common code from
 vm_normal_page_*()
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, nvdimm@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Alistair Popple
 <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-11-david@redhat.com>
 <aFu5Bn2APcr2sf7k@localhost.localdomain>
 <1ea2de52-7684-4e27-a8e9-233390f63eeb@redhat.com>
 <aFu_VeTRSk4Pz-ZL@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aFu_VeTRSk4Pz-ZL@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.25 11:20, Oscar Salvador wrote:
> On Wed, Jun 25, 2025 at 10:57:39AM +0200, David Hildenbrand wrote:
>> I don't think that comment is required anymore -- we do exactly what
>> vm_normal_page() does + documents,
>>
>> What the current users are is not particularly important anymore.
>>
>> Or why do you think it would still be important?
> 
> Maybe the current users are not important, but at least a comment directing
> to vm_normal_page like "See comment in vm_normal_page".
> Here, and in vm_normal_page_pud().
> 
> Just someone has it clear why we're only checking for X and Y when we find a
> pte/pmd/pud special.
> 
> But not really a strong opinion here, just I think that it might be helpful.

I was already debating with myself whether to add full kerneldoc for 
these functions ... but yeah, to me the link to "vm_normal_page()" is 
obvious, but we can just spell it out "see vm_normal_page()".

-- 
Cheers,

David / dhildenb


