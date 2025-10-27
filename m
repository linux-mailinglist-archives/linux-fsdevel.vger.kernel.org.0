Return-Path: <linux-fsdevel+bounces-65689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5535AC0CB76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 10:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DFF40195D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 09:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442132F0C45;
	Mon, 27 Oct 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jED3ioSl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26715270ED2
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557692; cv=none; b=X8Bm+qfcY1hbT9MAFEe1mmWBrFFNuCdBe9dLcLxbWu0msNd1rJWlfUkTRm5C5db13djdMy+SzvntNAOPUAKruw22oJv6b+wS+Ju8iIACKUL0E5W+Lpxc5qZ3Www/mUb6vBXNC4cJKspgkoyLPpQmgMwIq9v7yY0LEc3Lx8T614c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557692; c=relaxed/simple;
	bh=c7pWnfUI5l93xQMWezruXtzU0006jy+k7UTgGV61vbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iW5jCiHuLpLhxc2GG3NpeA6X7b+e1gZbopbN7ecmFBYQuHVWnku4SSxAvmAq7zFfNVOPJPEKb9RvLgj8rZbOIGgRcwhcYGqVPJIRVfg5+IESRa5Qdl+eAe4zFuXgExYFteDQJuedvku1PXT3rjw6zxuJPwRoHuFZF/MpQYmsVBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jED3ioSl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761557690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=enI7LZNpEoEgG2kCIqkqYuUnATtEoWBy7Pep0LNgBPY=;
	b=jED3ioSlNDzyRnVlA5d2JKz84s4Hx+gvlGp9us1FkFfvvA0nR4IdNdhwhoZJw9IaxX6c7H
	yRk8G49Th6EAoXmzQ2pGQQnyCMdx2/yGpLu5tOV11I7Q8Xbm60z6exI73whe1XVyAUNRCg
	Rw76/i/CM6l3bliE7qpGew5dO/0qLvw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-MYCnYgrYMbGCQ5nQFZxlEw-1; Mon, 27 Oct 2025 05:34:48 -0400
X-MC-Unique: MYCnYgrYMbGCQ5nQFZxlEw-1
X-Mimecast-MFC-AGG-ID: MYCnYgrYMbGCQ5nQFZxlEw_1761557687
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4770be47bfcso2477025e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 02:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761557687; x=1762162487;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enI7LZNpEoEgG2kCIqkqYuUnATtEoWBy7Pep0LNgBPY=;
        b=nkWqBPwhg58uahilTbBBweInaFSyKX8sVZWq3fcPEqYXStvC2gvY3wPxFFPYF7Diel
         Mlt4IH2XHNQtIvZ7tc4DKsLxv4G4IXFL3zQbFJw4xRJLKYUj8Ll/nGu5cXsS+LZVTZwt
         tOh4ac1NfXMgfHhDBCILLh4gIbNrk65eFxjjsYf7MAFkZpMqluDCa5IaMN+4qjpA4jXT
         EICKv+7N2loXuI0Q/Z6oZzW+haPrvGw3WcIxbvczq2AMXJS7epzSkiXC0QESvrxD34sT
         LYq7X6WTmZlryEtrPOSIQSn6UUh4+4TDXYpW6qHYy9CBP9H0It8YHYR2Qsc9jdfCnUW3
         heIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaOSXkVsgsFLY1FWssm0j0rXB7CYy74IWKCiT2pZSBP0AxCYxIuejGZC6YuKYXFeFgnVxNiGPQR7grChXi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/LsDgX/BIRsUXrocV4CMd+o+uTQl6Q33yG6XOHReg+l1ATp6K
	te9VDthiXXPVAIlV8+yV1fdfQHT2Ea9PxNniErJ8eK5bnDy5A9loNBpcG7nk0VkhLIIdnYLjW0E
	b5n0uMRvj9jLYIAKbwd5jvyStJtLSqOdNW42GIkTmwZjZnmJT4MVOqEUTRDy2KXCr8eo=
X-Gm-Gg: ASbGncsmV1UNNysH/ckDzZ3Jw26EEgppFuQHB06y9GgPpYjUFMerGdIUSmLMmgTENWg
	229iqQvCbfwMAEjQTZEIb0rvt8RAjUVoFE1iBTwkR9yJxEDmk6VOjRxtbO2NWTh6JlU+o3SHiWw
	P+2ycy9vzIca/4Ir59DbbljNyBoGkp2ZV2eI1zNSM3WAXDU3fIA0lkx2Oo0QFfI4D9+QhzdwFVE
	Iwuztkuo+bXOSZjIpdDJbxsOXM214ieM8xuZbHsyO5S7QfXZDRxCUjg2Wm+VO/yt3EMJhDASYcE
	sF2Wam/hleDehkP3vXgw8TF0n7YJzNb+9AEM8UcKARWpqDDXL16G4hYS1NLV/SAjFQ/1iUDeiq7
	0KAQEqxxpRE1dWPsmCsZbtm498AnJKZsFgSRblmkx/asOWRTlDnwtzAX6r6ZhAPwEhZI+oVFN3V
	0bKPnARmLHAAjIl5lFjLRDbFF8pfc=
X-Received: by 2002:a05:600c:800f:b0:471:672:3486 with SMTP id 5b1f17b1804b1-475d2e7e9c3mr74954765e9.15.1761557687240;
        Mon, 27 Oct 2025 02:34:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbYhXBdD/2sb21JkRwYqN4qMp1O+MlBYVpVhQAmAEtPEi4yKtKC4y56wL69hYkHpXzsclqsw==
X-Received: by 2002:a05:600c:800f:b0:471:672:3486 with SMTP id 5b1f17b1804b1-475d2e7e9c3mr74954495e9.15.1761557686886;
        Mon, 27 Oct 2025 02:34:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dcbe5587sm146578635e9.0.2025.10.27.02.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 02:34:46 -0700 (PDT)
Message-ID: <0fd86682-0679-48ee-8622-d9d7a977d69c@redhat.com>
Date: Mon, 27 Oct 2025 10:34:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries
 beyond i_size
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-mm <linux-mm@kvack.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Kiryl Shutsemau <kas@kernel.org>
References: <20251023093251.54146-1-kirill@shutemov.name>
 <20251023093251.54146-2-kirill@shutemov.name>
 <18262e42-9686-43c1-8f5f-0595b5a00de1@redhat.com>
 <ca03ba53-388d-4ac4-abf3-062dcdf6ff00@app.fastmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <ca03ba53-388d-4ac4-abf3-062dcdf6ff00@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.10.25 21:32, Kirill A. Shutemov wrote:
> 
> 
> On Fri, Oct 24, 2025, at 16:42, David Hildenbrand wrote:
>> On 23.10.25 11:32, Kiryl Shutsemau wrote:
>>>    	addr0 = addr - start * PAGE_SIZE;
>>>    	if (folio_within_vma(folio, vmf->vma) &&
>>> -	    (addr0 & PMD_MASK) == ((addr0 + folio_size(folio) - 1) & PMD_MASK)) {
>>> +	    (addr0 & PMD_MASK) == ((addr0 + folio_size(folio) - 1) & PMD_MASK) &&
>>
>> Isn't this just testing whether addr0 is aligned to folio_size(folio)?
>> (given that we don't support folios > PMD_SIZE), like
>>
>> 	IS_ALIGNED(addr0, folio_size(folio))
> 
> Actually, no. VMA can be not aligned to folio_size().

Ah, I missed that we can also have folio sizes besides PMD_SIZE here.

So it's all about testing whether the complete folio would be mapped by 
a single page table.

(a helper would be nice, but cannot immediately come up with a good name)

-- 
Cheers

David / dhildenb


