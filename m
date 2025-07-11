Return-Path: <linux-fsdevel+bounces-54669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F60B02178
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80AE418869AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36012EF2BD;
	Fri, 11 Jul 2025 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCFRpgJv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2D2D29B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250561; cv=none; b=EZFkM95fM/A/2hmvoXpez+gufO7LrUmDpHMEKmFUGuhV8Wt8b5AYC6maGeagl2XqXt2+SgYZag0os/Uq+7cp4iCS4OM7R+zGqR+IKe3PHxyeb9XuOar2dL0GLuJyQl9w5oHRx97ni73cDKs0bo4yh7qtW1VvPhYvEDsaybRucuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250561; c=relaxed/simple;
	bh=GaTXTSHhNy3zov9cV9sYYuEC/xhj+9jFrbDYc2p4QMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYw8s+ye0vC3DUPLn4gqYognk712kiAdlvQGO2ssJ/RAf3JM+oGFXE0rFwRdFo/58lvkAdhW4VkT5bbBPfmcU82wAFcHChsLKKNXVr13gAFWqupmJknRzyU95M9GM2a5WhwizWo8TzU2GV1CIKM6ZxbawGOASbPL+tPXJh+NA9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCFRpgJv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752250558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B4PdbUTlAoNvyMFKR6OePMk99FSDqKOEu6bezLg3CZ0=;
	b=aCFRpgJvJI0fSTC4JCmHVnCCMOo91Fxfe3RHl2oIwzjVN/MooPnsUoXk295CtEMTNCtjyF
	gBMJLULU38jUDbJOo3E4VfdXgvG7EP8b8Ra7ncV6sIGsSXxvo4IZMDKmxHrS49DuIMn1Ic
	qhciAY8TXc5CR23EgisreC4NUBFbrbQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-SbErz1ANMXqwLPLFewWYwQ-1; Fri, 11 Jul 2025 12:15:56 -0400
X-MC-Unique: SbErz1ANMXqwLPLFewWYwQ-1
X-Mimecast-MFC-AGG-ID: SbErz1ANMXqwLPLFewWYwQ_1752250555
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so2935895e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 09:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250555; x=1752855355;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B4PdbUTlAoNvyMFKR6OePMk99FSDqKOEu6bezLg3CZ0=;
        b=brfrdBqm9aC85KFKKatKThw5oRZfY4VI1X55R2Vm3SOgtZ4PMHbTpHOmxho8SGefkR
         pHN2dA3FLJ6lbRmUuw6moyj0WJr3zGmK6pO5GWIyIzFnW9UpFtBohgjDArkR9Z6znjT/
         Khwc6yIC7Lm6gzvJcKOg9/GJMivLF3VZL6EYqBlsN3/5SXPxddVKOzoADRHi0xb97s9D
         k791V9CzJrarxmHTbvdalb6OW6f18UET/QkHET9F4YC1A9HlyjXo/ZgdJr2bvZ0Q8hvX
         Yx8hMItmPscu7K2/D5YQcr8iEpRpHP0qwfvO2s+u9vs8NdgxCmySgySkocqj6IfbJw4M
         B8Zg==
X-Gm-Message-State: AOJu0YyejDMGj1uzlABsbNzj7tuiGwWHUtT01uY7O77ORhAEO0qaa8WR
	4nnf1/1Ynv5baEHFqmei/IKrQASrWbt0Q2eNTVQxTHz3Nkh0jQLM7xlvqfrON0btHNcHeI522ca
	gF55zoPrQCASuuXrYP81+6lRftGKMfkKBACd1tY9y3j8mSdbG3Joda4wF+V/ljLIGo0w=
X-Gm-Gg: ASbGncsr/mYmxYyWosGc1Y5CakYTDoy53tOm5/ynTIe5zWpkHUNzEg5GiAQ+cCuGvl8
	3ag5YO6xFXca80PDyDT6Jgwos7w7MAvNYk+z8V4bNJIvCho5i7DNdWXcRLoJuNggDmQnxrGPXkx
	Zn4dgIkp69q5DWF4lGNEZbwnM8jsvP9jc9Rpt6zsa6M4jKJnKrMCONCR16/4IZt5o5yWSKZtS+a
	FQAEQjVg3W8Pp7/tMxcg6p3wZuokzBYVCdFHQLuNdvYmO6eT4pXrLftWrtK5hRGhLdRQk5rvxbi
	Ka3q0cnemEydWiJ924NojgsOYVPff2a19ICEkj6HpO79A2LT7GFEw9qw6sHoN62y1Vdz5bMMjZT
	axNlm/GgO07nsiZf4On+Oo9meKnAOPOpTj65xY+28pb8DcnIoL4lrAkj0Grj81ycPFzg=
X-Received: by 2002:a05:600c:4684:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-454ec276b88mr40690225e9.18.1752250554856;
        Fri, 11 Jul 2025 09:15:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1a5E76BIpgezsbveDVnmxTjzk9mC3/6Cc7fl4zhaGnS7tXf6VRuARN3jKkYuVE7SAT26gyA==
X-Received: by 2002:a05:600c:4684:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-454ec276b88mr40689655e9.18.1752250554433;
        Fri, 11 Jul 2025 09:15:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d5f5sm4888486f8f.56.2025.07.11.09.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 09:15:54 -0700 (PDT)
Message-ID: <479b493c-92c4-424a-a5c0-1c29a4325d15@redhat.com>
Date: Fri, 11 Jul 2025 18:15:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] readahead: Use folio_nr_pages() instead of shift
 operation
To: Chi Zhiling <chizhiling@163.com>, willy@infradead.org,
 akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chi Zhiling <chizhiling@kylinos.cn>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20250710060451.3535957-1-chizhiling@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250710060451.3535957-1-chizhiling@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.25 08:04, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> folio_nr_pages() is faster helper function to get the number of pages
> when NR_PAGES_IN_LARGE_FOLIO is enabled.
> 
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> ---
>   mm/readahead.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 95a24f12d1e7..406756d34309 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -649,7 +649,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
>   	 * Ramp up sizes, and push forward the readahead window.
>   	 */
>   	expected = round_down(ra->start + ra->size - ra->async_size,
> -			1UL << folio_order(folio));
> +			folio_nr_pages(folio));
>   	if (index == expected) {
>   		ra->start += ra->size;
>   		/*

This should probably get squashed in Ryans commit?

LGTM

-- 
Cheers,

David / dhildenb


