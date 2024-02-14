Return-Path: <linux-fsdevel+bounces-11524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 543D28544EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 10:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46CE1F2B9A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 09:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15021171E;
	Wed, 14 Feb 2024 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0fEL7wE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C80F125C2
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902402; cv=none; b=TUnYzqZsINaIx+C8mQsFwqOT27CU1GCG8xPE36wsSisoDNxSqvOlZwhKU4/Iyh6mrnP3Knd/Y9ocwI0EB8QlWFl7oQz51Qdxq3alpRGbDO6QJWYARvtPP+ShotHxQZC3c9tPByfEfQO4HfchbvlyT0NxEVVdemCtMTHUaAHshmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902402; c=relaxed/simple;
	bh=JttM7pWiMdZp6KWHnTVYllrfplU6h2dEhA/eAiM7F0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHbkYQux0l4DmLld1pWOUuIrfluwj9w43k+II8D8bqTDGbRgrxTWWFpjH3tXzjjotQSrMtiwWs2wUiYMg6Asos6G8CjjFwO2g3ceOGKKmEwCObZ71qlRJK4LVmNP1x0+DeVxLEOA8THTTHItnKrV8cCdsOYTJG8hedH6msl6vNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0fEL7wE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707902399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bHq3K7VCRkjLofJOm0plsMOTBizMDzjuCqAhJEDYdQE=;
	b=Q0fEL7wEf4VvirNVAo1aanr3e+/eTj/J/1gVeUisNNAHb/EIq3utBQwrlvo3yW2LD0HJZ/
	c+6PhnKgWE0TxOBRlDKj9lEwbTEWTPYozzPDiS0Hs4hxUuKTo0nEBAk5Ur9JBsha9JdYLO
	VGZFvPhjmhp8CS6QFmJBRR05ZeqFpYs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-43qdP1HjPbmbfRVoJDK1Jw-1; Wed, 14 Feb 2024 04:19:58 -0500
X-MC-Unique: 43qdP1HjPbmbfRVoJDK1Jw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33cf0130b21so159788f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 01:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902397; x=1708507197;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHq3K7VCRkjLofJOm0plsMOTBizMDzjuCqAhJEDYdQE=;
        b=pPFOcZaiWJ+s1g3qyTfemyeL3o83i78LiHnxfwMm6MBNJVKCH55nY5sqJx4lARLy3H
         ovMlt5jjGN+Lj8MPa0iDt+m84iDQavDFwvSHSQFZQ+XQ2uSjnbIxItMc1RagqRIa5OpM
         PEzx2kJ2c+ys6oTSbSfc4FffHL0jrmP63N01GeBoY3EtNr9ffeTJ9f01GSr+upVp0/xH
         wVFcRFADbsf3kmBV2BK5I6ts8fui6GySV1TpKj0a/A8cM5K9vFTG5kvUSO3EcKFuKdBL
         rynxD6OFYOVQbvQZhObQUV9geilMkUDRiROvZOEO9ErZ5de+h5aEZ5b7CpKu+KFJNNg/
         2JVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLJ4KtZZtxVNIsuYHmkA6mxzDB98yRzk+l395vbY6hZpFFR+jqY6nTD+YRALop90SrS4ARXYit9cg44fdk5gN9JKXi4e/3eFAPB6SosQ==
X-Gm-Message-State: AOJu0Yz2GFhFnOfFUxhKPLx016rCj9QB387DKr3rKzrCTbj9omBv6eyJ
	4Oy7fQ6soeLue4EqBjnh4TpVIaD34n/M1bu+1RlHPGOxj5PARwviFjtw+xJgn6vd6kRXCGrb7FY
	CohFHqGDWXF1gOUTAFGEpQioIIeLVHUeQEO4Y6JJIP6Elh70oMUpPQ0/beqM2kxk=
X-Received: by 2002:adf:eac5:0:b0:33b:2153:b0f3 with SMTP id o5-20020adfeac5000000b0033b2153b0f3mr1385050wrn.29.1707902396951;
        Wed, 14 Feb 2024 01:19:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7u4R95UWK5JICK9JeUR18Sa1YTFb32Dm+FsKJFJVjyvLsLwJdWxBIBp70yvOC5cgN3itCNQ==
X-Received: by 2002:adf:eac5:0:b0:33b:2153:b0f3 with SMTP id o5-20020adfeac5000000b0033b2153b0f3mr1385027wrn.29.1707902396601;
        Wed, 14 Feb 2024 01:19:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZDqHXEOWIwF6EX5vKEWuGcLSrBezsYxPwj3QQyxsUFzBM3U3WkZlz1VrP6yy4LW1hO8/kggmvLEGsGecX893d99h1hofrnyb5D7yyZSjDMXNU4ui11Z9z7yFGLMxZfz5zzaLuwh9+RHsPKuJyleKtSwQQMRIoxGgR2qTKwPZPHVTeG27rDs8O0t8AU/QY59u3PqImKOSkaJC+5Ka1/I5zY++0KWMyyMQbr34ZAijocedaeEO4ebW0GPQbMhoSkmpHuFWliBjiEv5HR92vBBToVwhr4XGq6tqh44XF3PzuLVJT/md2m8WINh8BQLxqaa89ljTNpNQkbjVwcqouThQ/4tv3l8qVMoke37V5+xLVJRwNncf22tJWBiNWEuBt/j5jtzZOBTXsRQFU9Wr2fwaAChihqx6OaBkAuRDVtjIP3kRxLYRkBnZcn2eutj4Ec/kHSlknI6D3B3QmM51uV2hypXJ8wgftfWNdGZ/TMJot2iNcz510QIaifZ1LyQmCVuoSUDoioAGYnk/Fj+bForCE9KxlnfMZ7/9Xx8B1Ubeq5Cj2BazFCcD0t7n0Q7rOIfED
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id c18-20020adfef52000000b0033af3a43e91sm11742691wrp.46.2024.02.14.01.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 01:19:56 -0800 (PST)
Message-ID: <114da9e0-c7f4-4c3b-ab2f-f030466efedc@redhat.com>
Date: Wed, 14 Feb 2024 10:19:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] mm: memcg: make memcg huge page split support any
 order split.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>, linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Zach O'Keefe <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Mcgrof Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-4-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240213215520.1048625-4-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.02.24 22:55, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It sets memcg information for the pages after the split. A new parameter
> new_order is added to tell the order of subpages in the new page, always 0
> for now. It prepares for upcoming changes to support split huge page to
> any lower order.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Nothing jumped at me.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


