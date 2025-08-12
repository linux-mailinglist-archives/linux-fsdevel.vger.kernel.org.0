Return-Path: <linux-fsdevel+bounces-57583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF881B23A4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 22:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B20897A985B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4D82D7391;
	Tue, 12 Aug 2025 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdKTo4EJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1326828C02D
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755032302; cv=none; b=S477w/n6b3z6S//VdlZA25XPpnu51gaBghwqTzn6rUWpz9ZUvPSLV3R13TwaKvWzMgISclmDTmz2xAg+f5d2EV/CN2vsE1kn9YI9lQAbrObJBDMszfYQfU9nnSNnB6S6JByHW55c7TE5W3i3157Ivbczmh0TFBZCZzmJUQChBVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755032302; c=relaxed/simple;
	bh=DCuRnIiqwJw4vWxPzd4k0W11x+S9xn/rh2v0FdqiHq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rV45yW5pQEIPF+2+xYX/k3pECeYwglAKmH5i9Any7wlZMIauOqcmOIa+in/Kv62h7ZpKvIMo7cNSQCOV2U/tEINTgQH/wxcCFuuKxEgBtjNj7YcUFkubMuPBI+MbaSDkYSc+VhcNJO0oUMvaHjQLI1GjlI0L2VpbysP/UUnA0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdKTo4EJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755032300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uLgG1VOToCvTU0vQ2PDerMB8RO+pRBAvNmdyO/d/EYc=;
	b=OdKTo4EJrLf/eQ5iqmGIFofnw+/HRZvbX+6KEB/nlLKte8M+1nn3qccH0xcNMgunvDLEbG
	PsQuHMgP4lAKwdMW1PJtWgiF6S7SHa4DYVDrf6KXxns6tYYN/M4Xs2mYc75JUOc5i7nzsx
	QwMYZpknfBR79xZ7ty0Bv+OCMgAxfIU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-qRMTyhDDMuCcH4eU1JoBiw-1; Tue, 12 Aug 2025 16:58:17 -0400
X-MC-Unique: qRMTyhDDMuCcH4eU1JoBiw-1
X-Mimecast-MFC-AGG-ID: qRMTyhDDMuCcH4eU1JoBiw_1755032297
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b7886bfc16so3738371f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 13:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755032296; x=1755637096;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLgG1VOToCvTU0vQ2PDerMB8RO+pRBAvNmdyO/d/EYc=;
        b=gQddRD2nyv4hbFDeYgAoY0eg1NmHOZaobVxik35cxl3D+sBfkptytUoycBsyuqnw+w
         KBJczmEIYlgj90TdvzqJ9RTTHNSO6oBiIQhZAwswgCjVBKwju8c0uWiMcGC5SWnb0SBG
         bo5+Af/socauAyfqzQqo1SXtXmJ2IPXIM4mxPWVZWQs4Hy7laPiCIG9sQKRjGBNkwzhu
         QQNCE2lD924HuC2/yxBL0kLxYLbIS/W7adQ8uSKGpSYT0LmqfMrs4RCW3oFqTRR12Tk/
         NqaXJc0ml3cVUekwWI/Xvt3k/ToMQvl3LpKpKlfjs7F3JIuDHXp+CP2QcTkHqeF5v+Ve
         bZMA==
X-Forwarded-Encrypted: i=1; AJvYcCUtpNxJTkOAoq4M6vd8jwsuxZXluRRgyQHjc2emE/1TevVJHGlR7B4ShiJoDyUpuxnu74jTE/fPHjvSL/G/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2s2BNQrdjKB7Q6gLogoAJ6lTPpkyGmcZ9J4mLXrVpJnF//Pcw
	EYgc4KeDXZP6om0PQ5Q4j6M2KtP5XhsyiJ2tDKHztOTl1FBTEr2LQj0UvB57qc6YASp/SXeqW4t
	G15V1ik1kuZFgY7wb2pOo9jPAcOGcXVOlUNaTCeWfSh76Sx/WdhpZ77ZkY7CR07W+Cbc=
X-Gm-Gg: ASbGnctfUR1KpOqafnDs2BQgYrBUm+wlr51mNBV4iK1DWHvwXTTp/4rs80IIW54joOZ
	jWJw6WOkPJTcb7iNov5rgBLLMk3Nf4RrNG2i8iqdA6B1EKPB4GCR+dgKhGlScyBGY1Z0yPfAwMm
	FR2WYN7o827tyopE5x2eyHAVrEbke9a7WITDCKYwrQ7N4KUvigMocvk6Ciyb7BBd+WTyWlK5N3y
	FVziJDBVDihahIi7idlatMcRdzbfpRIcFl4OOPWa/rpVkVz8aE1DQMazRuE8OR6ilioLJd+UIUB
	9oBRcLgs5dRnkDmpSlGyToINFU3XYpaSYSaUx45s5F3zpE178zGGRC3NdBHvljW5z8Qnm5bdGdC
	ibUvthdLQEBLHwkpnyhQn1QVuKHJW8iEmmNqsQUx57MYtmjuwc7gRPkHm9XsU0b1VEIk=
X-Received: by 2002:a05:6000:2405:b0:3b8:ffd1:80d2 with SMTP id ffacd0b85a97d-3b917e465abmr240570f8f.24.1755032296526;
        Tue, 12 Aug 2025 13:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFus9+PSGOYma3qAIBPvbqxlVjhulo3axCz2Rux1VimjwnzUeqE708H1Yik5XMuzNAGjgNRLQ==
X-Received: by 2002:a05:6000:2405:b0:3b8:ffd1:80d2 with SMTP id ffacd0b85a97d-3b917e465abmr240547f8f.24.1755032296092;
        Tue, 12 Aug 2025 13:58:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:cb00:c425:8b4b:d9ad:eee0? (p200300d82f30cb00c4258b4bd9adeee0.dip0.t-ipconnect.de. [2003:d8:2f30:cb00:c425:8b4b:d9ad:eee0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf93dsm45534645f8f.27.2025.08.12.13.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 13:58:15 -0700 (PDT)
Message-ID: <26a947b7-eb42-480e-9b17-3fb819ba896f@redhat.com>
Date: Tue, 12 Aug 2025 22:58:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: remove redundant __GFP_NOWARN
To: Qianfeng Rong <rongqianfeng@vivo.com>, SeongJae Park <sj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rik van Riel
 <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20250812135225.274316-1-rongqianfeng@vivo.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250812135225.274316-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.25 15:52, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> No functional changes.
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


