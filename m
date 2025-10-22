Return-Path: <linux-fsdevel+bounces-65208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F63BFE23B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 22:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991011A04F70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 20:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAF82F9D83;
	Wed, 22 Oct 2025 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emYQfEev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304DF1E51EF
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164325; cv=none; b=B9wR8vGsO+Or8oNu/7v9TBj5E7bdDs6y+yKN1OLFrmVfS9OrtngCgzTPRb5EMV3jPPP14yAuAMgyaYTW4paEropwkwHArVOVCD0JG9hppHrAHvQStz7G7vPg1JlnAurXdwyTLEEULIjZEp3cS8dAJxPTHvS9OS7x/KPdbBq/Gj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164325; c=relaxed/simple;
	bh=Z459dht6gE8XeDgV1qENj3inkdPtfrSAdn9EtsTw0Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJq5FEk5f1xw9KDOYiztF5Bk41uZtUVJZw5zrZcBR1Fb9Gjt79EVsbft0AtwWc+eKvbkHHLcbzjM32G+rAlj/HSGiMhW5FmkcQAISlSZrWUpMqNu1fxi6WnvoDfGsP7w/GapdLIVf0MFjQh7oNPvraCJEbRXySxX8uzCL4YrzLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=emYQfEev; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761164323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qQBmXsw5V4eGrvR9Tz7wn2FNoM8/TbO0Z6U8kNgiKEk=;
	b=emYQfEevZtmx7vV6O5KDcA+Yf6XNM44lLZOzzGcPj5s+M1w1l6eklUhrvPBXTUOKQZ/T/0
	aNGlduCzqBUQcKYTVbXwKEPrNUXb7CBnO7oRLAl6Tt4uhtO2BZ7777IdI5/zsDLQAvnWv+
	k2IY5tFpLb44TRfWooUm3gqmfndxdBg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-crjVDfc8M2adHuQSBv68nw-1; Wed, 22 Oct 2025 16:18:42 -0400
X-MC-Unique: crjVDfc8M2adHuQSBv68nw-1
X-Mimecast-MFC-AGG-ID: crjVDfc8M2adHuQSBv68nw_1761164321
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471201dc0e9so79565e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 13:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761164321; x=1761769121;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQBmXsw5V4eGrvR9Tz7wn2FNoM8/TbO0Z6U8kNgiKEk=;
        b=FhS9V7GI42IhlHxXvbI+YlggX36RAuzFCEvewnlM0PuGsM9n2dd4kIFWuc606slFRn
         a30dnKhq6P/N6D8fE39g3D3+dIQS65xKmUFXTQ+4VoFj/L3JP0mD5hKzceQ6gCrsOmh4
         8H2WFsDqOMJYaIQKQmRWCCOuWJOyr8nCsCOgcX0tdQFXS1F3ei1UGxs0TeJljLce6UWg
         Lh6BcO0H0uesKv4YjtX9bHYhANpJ6yCMT4TtkFXnDc7oVLRIfYMBSGJkKDYat9qZ0tRM
         YJOQDxhqYmhvP2TjFGPdcYbjgexz4mkIsdVbD+y515ul70ndmO0vAkhFZ6PVYIA1frEs
         9YLw==
X-Forwarded-Encrypted: i=1; AJvYcCW6kTIbO9dWFbkR1S/xiLJWBZN7EByqJABLOSFYe43QMpa+AONsdNfSgVeV8g14UaaU31AUc3BqapLikvwW@vger.kernel.org
X-Gm-Message-State: AOJu0YzhpjVwI1g3n1drW8K2xDYGmdATZy0/lNdf/Kal+Ner8iV1SQHj
	Y425F9vIWmA3kZGl48htXqX3hEgZOOIHKV7aFazuO+7lXnm3MgArBWZqjl9AbFkMLqMh6RupYhO
	LMZj8b5v13DIn64iuiGsQVlwW+OJyA/Lv0wQjQTMmeCPIjPi3J6ho9R5qVF6/tBO3Xdk=
X-Gm-Gg: ASbGnctAfcIF+QmA7PKpl47n23Yba7B7cE8mmoQ36O0VWkcBXSfc7yjYK5JkzL7T0Iz
	14YulwfDv/9vCANCam/yiIT/bCkmmUku41DbMnSIk2rOBjHd855vlRnyRcICo3n7KDhXkUH47To
	xcQsLfdeZaV7CNcBmcOratDAgbwuw5zmrUUzPaQbeD3fcCsGUFE8Sp2G+5KsR/oxbenAn1tSMJ+
	cxiWmPg0VZ2KQbvUnCv6Ht35yNFaLyBbKptKdWFp8vV1myWO0/7n8U5sikcKugYZbtvQwdcGYJB
	kqANnJqcZeIob5XLoSHriOo28cw0jsWvQh+ASNVh6AV4bbwf3QYtgwySvAqCDUYO59BgW/ZdNAb
	+zJcFS+cQ7JuGEPMS0+71cWvTucSeIash5aP0kzUrjrLTTHeE53kAShwldtE2fji/CncjdlL652
	vn5hy/Vkzf7g53cQvx23/tuVxtxTc=
X-Received: by 2002:a05:600c:354a:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-47117903f24mr147151215e9.20.1761164320900;
        Wed, 22 Oct 2025 13:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHv1MI1KgUeIM4e592xdEkhILAGzFJn2fdCT+0ozCWrbyg+uo/HqoutZfyrh7Unzhv5piUSA==
X-Received: by 2002:a05:600c:354a:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-47117903f24mr147151025e9.20.1761164320417;
        Wed, 22 Oct 2025 13:18:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496be2eb6sm44115165e9.2.2025.10.22.13.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 13:18:39 -0700 (PDT)
Message-ID: <b2aa1edd-42f1-485d-b569-791a1e885487@redhat.com>
Date: Wed, 22 Oct 2025 22:18:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm/huge_memory: fix kernel-doc comments for
 folio_split() and related.
To: Zi Yan <ziy@nvidia.com>, linmiaohe@huawei.com, jane.chu@oracle.com
Cc: kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org,
 nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251022033531.389351-1-ziy@nvidia.com>
 <20251022033531.389351-5-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251022033531.389351-5-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.25 05:35, Zi Yan wrote:
> try_folio_split_to_order(), folio_split, __folio_split(), and
> __split_unmapped_folio() do not have correct kernel-doc comment format.
> Fix them.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


