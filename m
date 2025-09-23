Return-Path: <linux-fsdevel+bounces-62485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0D2B94D0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 09:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C5E7B1D35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 07:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352D83191BD;
	Tue, 23 Sep 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxS91bKP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B425C3191AF
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613115; cv=none; b=L4Z99QDbUkExAxK5KkWyo78smWOh3/Mu8cwWaKIKFLfjDltwFozGeKmgLuGxh9awI6INmPFF5eLou24ho2q6qxMblDH7GxCMT0i9XmuLKpqYlyVLcs5cq39mva7l0lCp/9/GpoHy9+ZcNr+dl3kDy/LrsW7DKaeUEquORpemsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613115; c=relaxed/simple;
	bh=fBafndRrS/cvR4it3eIK+X4JzSp3tuG+7bMO9l104b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Se+GrxJRdN/+MHNwbYMcIo/MXrKV9fpfB2in3OTFCcnuatqEBCPd8nSq5wr7Fxi1wcOCwMqwphhhYN++Y765nCSpk6v3MLUVZYyhxjVRovRzoYcvGtP1r/aunkWYzwXIYSfglA3HSMR16Shk73PTUlXRmpO6cvVET8WWIkxJfZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KxS91bKP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758613112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3+2f8veuvuQfgX39BgNLfIIBsGS5Oj+VIkm5FraHo3A=;
	b=KxS91bKPUWuUkwo445OzdzpBrIJId7rNkFJcynPhmPkKVjfcCNYpBs7Jn9rWbQOMQ9Kjwz
	RAAsyOO4kOKJtgGiI7ZbtQ3KNi/D6H0VN0IQ932Cny5fxDZFt2tkVLq6Yjm5YAfpg8vgRj
	e1mfuXpixC1LlyjGnwQe5CS1na9cPiI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-c7S9BRRYOd21J27P8_CkmA-1; Tue, 23 Sep 2025 03:38:30 -0400
X-MC-Unique: c7S9BRRYOd21J27P8_CkmA-1
X-Mimecast-MFC-AGG-ID: c7S9BRRYOd21J27P8_CkmA_1758613109
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46c84b3b27bso14714815e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 00:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758613109; x=1759217909;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+2f8veuvuQfgX39BgNLfIIBsGS5Oj+VIkm5FraHo3A=;
        b=AUVG1AhkfQhsiNoKT5jh7JHvuKHCHxKT1Hy+E4LDE9vKt/83RPOt4mXZaO/pOtPb/9
         IuqMJKt21JzWuLqSPDYkDLPYIlOI8EWDFt+83HtKb66c0On8X+1BOmPYjtHRy9+7r7Zj
         v2fjqqQ7tDoQfuA9LOpfSoZCCIukB+k12hrS7gh9rl/moWYKU5RK3w+K6BemPNIj7LOw
         RkWeVJZcV5KNvlk/2yYAR7lP3qlJ9XO3/owwyVdT8rFVOKzSB4bL0u2hV1klNgdE1jCj
         mW0DMTO8QndNBoyyU/0Bv+kK8aKqoWivT2+SbvvnM4NbMQb6Ekn1n/pZAM8qStshbwyq
         CxDw==
X-Forwarded-Encrypted: i=1; AJvYcCVOhkbtmSNHPrd1LoYdzZof0NtT7XND4GwYWc5x04LdhlPtOVnR2QoxrW7C2EiJFolwwmNrZ33j8mINadk5@vger.kernel.org
X-Gm-Message-State: AOJu0YzuDEvk/nbUvhS+Quu4jsx6OJ2bidopQJGi9IwAscm81iaKFwS+
	/zYn+YFasnvejnup3q7KAAefa4y9MnDGfs7WbNLFVaYE01GAn11kWmZcDK/bud1noCjdpsb2Z1L
	XirNPTDx7PW0MU+UKvZxWb2ozdbjamS2z17m0i2Pp3w5MBXWvsmKeV+ggOfMAF49S9q0=
X-Gm-Gg: ASbGncvPV2eWKU4IhixSbAMfqrPLfErEkuzXwXWbUDEWQqiHbCbWd0vyuHA4QZdJgPf
	la8sMv4dZZ9ymuNfkHSV4fMdVZhbdWnEdMm7AQfkgalB3nLs5o+2ME3WoJO9348n/G+jBTNm4G/
	E+y/p46p4SKQoc53+I2KqMkqh8e6YDhDJJvkvufkCBiEZ3gw8yBK6lqDhO7BxOVuGCOVDnQG0Jb
	EwcCGuHcKCZ3XdRBdCG7OwT/KCiz0ELbe8wttqYBuRQZOI1Lt/gC15QVjWEXDMdQXqkhB1AgXcZ
	zZuhy9dX+NlyF1T/G8fP+neZgHvUpouDQJyyc0qAnuo4Q43UxGlrXxBRcJrONAs8Y9dW87k=
X-Received: by 2002:a05:600c:3541:b0:45f:2843:e779 with SMTP id 5b1f17b1804b1-46e1d97a0ddmr18796925e9.8.1758613109150;
        Tue, 23 Sep 2025 00:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu/BPEIJsCwjIeyZic5miWaKNTnGiC069S6ggfgPcy4CJzDTmfq1ehSOcS1TWgHULTVLA7jw==
X-Received: by 2002:a05:600c:3541:b0:45f:2843:e779 with SMTP id 5b1f17b1804b1-46e1d97a0ddmr18796615e9.8.1758613108774;
        Tue, 23 Sep 2025 00:38:28 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1fd57.dip0.t-ipconnect.de. [79.241.253.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f9c62d083esm10698647f8f.32.2025.09.23.00.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 00:38:28 -0700 (PDT)
Message-ID: <8bef63c3-f424-4b53-9165-b9ad789f1ada@redhat.com>
Date: Tue, 23 Sep 2025 09:38:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cramfs: Fix incorrect physical page address calculation
To: Alistair Popple <apopple@nvidia.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org
Cc: Haiyue Wang <haiyuewa@163.com>, Nicolas Pitre <nico@fluxnic.net>
References: <20250923005333.3165032-1-apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250923005333.3165032-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.25 02:53, Alistair Popple wrote:
> Commit 21aa65bf82a7 ("mm: remove callers of pfn_t functionality")
> incorrectly replaced the pfn with the physical address when calling
> vmf_insert_mixed(). Instead the phys_to_pfn_t() call should have been
> replaced with PHYS_PFN().
> 
> Found by inspection after a similar issue was noted in fuse virtio_fs.
> 
> Fixes: 21aa65bf82a7 ("mm: remove callers of pfn_t functionality")
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> Cc: Haiyue Wang <haiyuewa@163.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

Hopefully that's all now -- scanned the original patch and all 
phys_to_pfn_t now seem to have a matching PHYS_PFN.

-- 
Cheers

David / dhildenb


