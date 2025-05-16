Return-Path: <linux-fsdevel+bounces-49252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 122F7AB9BDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A26DA22919
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D44C23C50B;
	Fri, 16 May 2025 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3U5GJwi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A9CA32
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398072; cv=none; b=FySMa73VIO4ISY8MtKgF+FJI1+VN5WZyrzQlskxc7jhB7DwgSuWZJWSVO6Vmj3BPn3d1aUVhpakwtZTSEV+xeLXneySeb8k2h57KMhpoLCbcC1BZz+O7gAGKdojwFNfPLnBmQLFnGcr9QGvvF9YHCeZxp6xMmomsWlTpKIII7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398072; c=relaxed/simple;
	bh=1VvtFkkKFjo2pE3834NRlQen1hQkRX4RVWbKJtTc2Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBujXMrK2A7q+hhuozcdR2IGApqzBbBXa2qtvk8YZqkjb6BqjnfTtPnzez/H37ZEBd9HpXZrfxVF0QHsIGcXFWc0aeBujxgT4vYRcy41w2YyWp9qhp/TTk5KYo4sT4W5vPmidpWPkcGI7we9Vbxn+VT1lxk5sJQAswMwDz0j6nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3U5GJwi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747398069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p311k/uFNyubAfqIeQckgS+ItWxcWXuDkXFewvNpY5Q=;
	b=H3U5GJwi+5Skx49ee8F17YmJGdmbpQwcbs6IpVnuo4k8Pi8Ww8sKeqMr1cE0a/ZG9hQoud
	yedSd7QJETxPaeeC0huolCSAK6RK8F9RrVguDxFjvsOBTBLOpuLv+rG1g0pTXxbUx6ld0h
	i0RN/c35DFTXc/3PMVxotv6lh/Emp/4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-VYtXnSyjP_Cpbf6sfbk6CQ-1; Fri, 16 May 2025 08:21:08 -0400
X-MC-Unique: VYtXnSyjP_Cpbf6sfbk6CQ-1
X-Mimecast-MFC-AGG-ID: VYtXnSyjP_Cpbf6sfbk6CQ_1747398067
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a0b570a73eso1317948f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 05:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747398067; x=1748002867;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p311k/uFNyubAfqIeQckgS+ItWxcWXuDkXFewvNpY5Q=;
        b=ZDukS2gz3uzSgHS0JkPs8sUHrk6FZ4SHYBCmlOuQVaGPu9jEHPv05nTES8pkJeaqdl
         8AhhP88Tgh8DDoAhOT0++CLbD1phMpT2DMV1Hb8nM1BjBL6DNzxScFQff3rMwCewTvqA
         z4yrKdOdBm7No4dyvhv71zdGZUlFX+7ZEes6L3hMfQ8Myi4K9ow6Q1hO/aPvGSEiXrIe
         PtgHXrqNayPtYtpeXvM2ZCUvwkpcBEI35pQ4aRv+GgQRhfVc4hZiuul5vOX0VuK9N858
         eIkHpT//HQu2fUCMgSRnDGvshrpctycqGXHIjsJLLjmXaDX+r8dywdWUwhm+KF7m8+rL
         NItQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdVLd0oKXK858RJYQ49V3nA/CII2waeks/BIBQ2qpU3NUQoSASQIpSpFoLoXqF//OVI3gYRZatSlac5LTT@vger.kernel.org
X-Gm-Message-State: AOJu0YwQV0t+OPpJviK7uNYgLnvkDdcHvmPPeGEAJes0lB68AycavwoZ
	wyYhfF1D6Lxd43cRrRsQIrhxKPTwiBaMQ3iV+axXfaNxmC0Zwf1Z9CpF94rsr4kSDhe/928xePb
	vH2f51YKsD2WBCE/eQvBQJFAzYwqElKiSV9MG5uZN4en5OtdmWatLZcV3XtZBbzxUF10=
X-Gm-Gg: ASbGncvcC3VO6tq4k9zaMl/Nj4ytXleYMqQ0A74Un07zEhBLnUv43yDhgvVTBMI7ok7
	7eXy+3xGPp9eNUrWgwIQuTY7H8MXTJqg5uiqat1SaE3ObXr4jCg3DnJexjat0Pop+Z9gBfJDT58
	7yEqlcLU3+OvauFmxymA1T4pk9NXqHKeLVj4m9tol1yvUjfJyZDoNbyUpNtQBUzx7ewWNVS6J9D
	Y/I0RnQR96VaF/gZB48L9d5Djak0CG1r+adKtc6mT0aViGWquNfgOMsN0hdAA4DSeDz4pEWhOX7
	5vrR/ilixapcq94hX2hqyWejhIb5EhHo2o1drcdqTrrvDB1ERtkK2rXq1105pvAyEXWGUwJmVqD
	DfMFB2oZczBp24w3g0f4ZNnDiiZbxnh3HMNzC+1Y=
X-Received: by 2002:a05:6000:4382:b0:39f:4d62:c5fc with SMTP id ffacd0b85a97d-3a35c834e90mr3358776f8f.35.1747398067239;
        Fri, 16 May 2025 05:21:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhO/Ha0JNlb5S9EDS2aoRrcqRFXHIbX9PwCply8D0+BG5jF4bRQPNgekhCfxjNKRh5VtcGmw==
X-Received: by 2002:a05:6000:4382:b0:39f:4d62:c5fc with SMTP id ffacd0b85a97d-3a35c834e90mr3358751f8f.35.1747398066844;
        Fri, 16 May 2025 05:21:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:4700:e6f9:f453:9ece:7602? (p200300d82f474700e6f9f4539ece7602.dip0.t-ipconnect.de. [2003:d8:2f47:4700:e6f9:f453:9ece:7602])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39517f7sm103020455e9.20.2025.05.16.05.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 05:21:05 -0700 (PDT)
Message-ID: <cb52312d-348b-49d5-b0d7-0613fb38a558@redhat.com>
Date: Fri, 16 May 2025 14:21:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] mm: add large zero page for efficient zeroing of larger
 segments
To: Pankaj Raghav <p.raghav@samsung.com>, "Darrick J . Wong"
 <djwong@kernel.org>, hch@lst.de, willy@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
 Andrew Morton <akpm@linux-foundation.org>, kernel@pankajraghav.com
References: <20250516101054.676046-1-p.raghav@samsung.com>
 <20250516101054.676046-2-p.raghav@samsung.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250516101054.676046-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.05.25 12:10, Pankaj Raghav wrote:
> Introduce LARGE_ZERO_PAGE of size 2M as an alternative to ZERO_PAGE of
> size PAGE_SIZE.
> 
> There are many places in the kernel where we need to zeroout larger
> chunks but the maximum segment we can zeroout at a time is limited by
> PAGE_SIZE.
> 
> This is especially annoying in block devices and filesystems where we
> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
> bvec support in block layer, it is much more efficient to send out
> larger zero pages as a part of single bvec.
> 
> While there are other options such as huge_zero_page, they can fail
> based on the system memory pressure requiring a fallback to ZERO_PAGE[3].

Instead of adding another one, why not have a config option that will 
always allocate the huge zeropage, and never free it?

I mean, the whole thing about dynamically allocating/freeing it was for 
memory-constrained systems. For large systems, we just don't care.

-- 
Cheers,

David / dhildenb


