Return-Path: <linux-fsdevel+bounces-39030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F529A0B432
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 11:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45681162380
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 10:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332852045B3;
	Mon, 13 Jan 2025 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUE8kD6P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA23204589
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763079; cv=none; b=Kpl0EoH8klV1iSpRh7+klqskDa25sQZj7MPqJt26ZDNsEvorO6UWSFtn9ZRlsZb1V8aZnGQH7xinTug1i4rmqhvI+ZbmMakJEJ2eT6EK8Jl0PmbMuXOi0Q09XtLZ1T89Pats31n7yfo1WnGbD90xrAITRUnNjl1EO7JvD+iCtBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763079; c=relaxed/simple;
	bh=M13Uuivjyk41iEeYw6ipMT/Bx3PLhoM9UzP1cSIO3A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiOR1CmSF0LUgmtc2KFaUu+1o5OW3g2jBrwVb0Re3749xo4SQ/x8otUx6wpM3wxS4DEbaqb2JSkuRilpBrV6IxkCjjSD8I6cUCDHQP4me66FMxTxIjvp5rrR6hc5p3Fp5/EChKNnV9ilvPsAKKsPh78cpoCrrxXLdDluU910OMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUE8kD6P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736763077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YZBajfUNgRiEJRmGIjwkNpRomTM63CRth9yeImlQ4I4=;
	b=NUE8kD6PmgVcbCKo7UEYPwHDvCMJMiUQppr2a+63KYUGLUruTwawQGSWvqf9tbr2+Clw7E
	O8XjFNIrc4OdDm5Nvof3FDjRQquZ0iHR2IAchK4QiRFaFZVwPleGQhMm1dq8PZpBt8G5M9
	2QjmIG7GgNz9Pz7rQ2B42sBcpLXxD0s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-4t1vtSRTPXylTN6IIpTKXQ-1; Mon, 13 Jan 2025 05:11:13 -0500
X-MC-Unique: 4t1vtSRTPXylTN6IIpTKXQ-1
X-Mimecast-MFC-AGG-ID: 4t1vtSRTPXylTN6IIpTKXQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aaf8396f65fso405887266b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 02:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736763072; x=1737367872;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YZBajfUNgRiEJRmGIjwkNpRomTM63CRth9yeImlQ4I4=;
        b=Keq8VDrE1cZjxkW3sri9O2kkRIs/ABIQ3nn9fCpiY8gaK+Wxnyu3MGBUAykvsEYFyc
         BvCzi8rMemxfdULDMH0M2TErFZhK0+HFQA7CSxfRpiPtafbO9TUUkxxLBoZEwalxQsKy
         6BMN81yg+BsCnS5j/CS+UYpt3xc6J273aQ/6SwK6cUShiz22yvsn/qiSNzl4p9YGFTAe
         xqQOUmAdaX/OZ9zJwbaW7m7rcT2my+c3IGrEulg9qfKLm3Zf0LUrn7u1ABNDBr8iils+
         yRdcL4Nr5NTQde4XMBC3LdVQZr5Ov7h38D2om3ILYBSDS2ZuhhjIufDTK21D07+nobD8
         ATRA==
X-Forwarded-Encrypted: i=1; AJvYcCVqG9Mep7rAzytj11z4OwhGFrUwCo8AOZkcEyX1Es1kSUIKdkvIYpS9Qe9McSsRBBQB8i30DnTGzWZLdRxL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ObURhcJ/Dmyg4Lobke2QdUynn2E2y1pUGpsIPqyLqe0ySdnY
	9WPjB/D7eW34XeKS/UvVWhUGb9dnQk7MdnUXq47p6zpLxq9/IOYwFneQwFMlmvZC3Yceup0vceD
	CEa7/z7y9rR/uYS62L2FP1B7un3fkO8nrj95vEy3W7uxQPCE0MZWswbsGMGpCM+0=
X-Gm-Gg: ASbGncsNVGX/SbEMJ6HFiIyem1TVAtZ5y8A9uzDJmcYOBtOu6z79i0MYIab8HdF6twS
	8PAk982jRUcigG/FglQIBE5Q1tqWAm76N4exlz+trIxlw0jx6WVjQIFWyy4VluooYsHi2ZxcO4y
	SPLEQFeDzFlmitgazV5TBQoyINwung1M/uo1ToiHPw0r46oPWEBhpGKO7ts1pH9HmD+cWlD4aQ7
	wKwJ0juSutzfGQZNwM3e6OJsYfwlLEeFQNw38XU61KU7QAvDCJjDQoBYvbsZqs+WpowJOL7VGeu
	PEsoMbXetGFHExs=
X-Received: by 2002:a17:906:7953:b0:aa6:6ea7:e5a7 with SMTP id a640c23a62f3a-ab2ab6f348cmr1725616266b.28.1736763072038;
        Mon, 13 Jan 2025 02:11:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdirr8D1MdJ8hZhK3LadmHC0HxERF0KeEuDEciej7XDiPtcSZAmFDQxQhmEiGpM73ALQDUcw==
X-Received: by 2002:a17:906:7953:b0:aa6:6ea7:e5a7 with SMTP id a640c23a62f3a-ab2ab6f348cmr1725613566b.28.1736763071607;
        Mon, 13 Jan 2025 02:11:11 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm485906366b.94.2025.01.13.02.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 02:11:10 -0800 (PST)
Message-ID: <a75e6fa9-d08a-45d8-b501-a9d9d0325951@redhat.com>
Date: Mon, 13 Jan 2025 11:11:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] mm: Remove PG_reclaim
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Christian Brauner <brauner@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dan Carpenter <dan.carpenter@linaro.org>, David Airlie <airlied@gmail.com>,
 Hao Ge <gehao@kylinos.cn>, Jani Nikula <jani.nikula@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Josef Bacik <josef@toxicpanda.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>,
 Yu Zhao <yuzhao@google.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
 <20250113093453.1932083-9-kirill.shutemov@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250113093453.1932083-9-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.01.25 10:34, Kirill A. Shutemov wrote:
> Nobody sets the flag anymore.
> 
> Remove the PG_reclaim, making PG_readhead exclusive user of the page
> flag bit.
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


