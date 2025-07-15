Return-Path: <linux-fsdevel+bounces-54980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BDAB0612A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196459201C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F362472B0;
	Tue, 15 Jul 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Elb+dvkp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C202E241122
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589114; cv=none; b=oz0xXeGNKN1iZQmt9I3vTeJf5W6jEIcKzCdR7nqV8X+fI8o9XJ2lAm0QLSzqXJqlfSccqc3l6zOUR0FqJdZRybEQDwrWygUspL15CriTj6rCbpWAr329rX6u3Gsj+XW1wEp/dRscQoUFGTVdTjNfP6NtC/wkX5eMeUsfuLQlKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589114; c=relaxed/simple;
	bh=q6++1c2ADBvgs9g4B37AnH974+HtqY3SPSEInNO/cyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGvR0IRJG+S2rVeA/tnNKBnyfb0vQvNNxX4sWjOpezIKHrebylakDTJ/Ikah0efA4XraAf7+lyXdBeGFx3oMdcVFmAzimTyB5QD1IIKPGwXigkuHsHEnaoY6Rhqpb7CCFvBxtUTf7JaNmhEYwpF4Z84kv/Xr4lI3HG7zzGzqW6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Elb+dvkp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752589111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCz3aFtz9BoXuFwRStITMsUKAM3VRx5ZileAaCmlgUc=;
	b=Elb+dvkpDrd+BKVrNBAT6k25Yt5h/ApO6tanaXQ546iXtyxfBcf5y3qQwNrgfiuLbyj9Xe
	QoIDaFGV3HjxmPHBWbX4avMpSaDPdb1aMDifuTSCv+Hf3jIc+lnHe4AZ8Qa+Bn/3bkb0n2
	IXQ6G1y6MBgUnUk8YMwq0Mcinctpr54=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-f4yflnAjNSWC11pJdiDMcw-1; Tue, 15 Jul 2025 10:18:30 -0400
X-MC-Unique: f4yflnAjNSWC11pJdiDMcw-1
X-Mimecast-MFC-AGG-ID: f4yflnAjNSWC11pJdiDMcw_1752589109
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so2255783f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 07:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589109; x=1753193909;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCz3aFtz9BoXuFwRStITMsUKAM3VRx5ZileAaCmlgUc=;
        b=ElQCuqV6o+bXDT1QGuUJd9Pd3xF/sMJq+jVlzB6cFsBXdNHtC2yEWMtbTIA1Ax9xNP
         Rp8EoQs1ilP8NMaSd32dHt/Ng4N32WIPskXP/IwbCcB4jvhWxRmjI/0cycwbONT2jWGD
         s7i0c/VRwfWeK8kXdp+MkzNsUyk0aCBKBqpBrOs/JAJsWNLwXSbPTol9161ZkW6Sv1WO
         SRWcyCyvRdzFTvd5/HmaHToteblbNM4+Oc59c8NdI0+ghzGdeNgbXG4PK38sC2We2P/P
         CJWdYQqCtnStFDzdbb4+Zv0ZWebMBDi2LsE7Ct4/BkjJqTC4XV7GDqie12sD6h8/+nPr
         zYOg==
X-Forwarded-Encrypted: i=1; AJvYcCUS5y+U3A4bTyy4vvUjE12eK709ZgK+TsXWOjFc24I8uYG7+n3AEiHqDDpifPzYiCCBOoFJnwP/WofZAr8f@vger.kernel.org
X-Gm-Message-State: AOJu0YyHdp/3Gg1ejKyWZQfd5RK5CuIe2Rv97lEkvNVC247mAxmZmKrn
	Ezn57SQ91szCQcJtEF03IGEmucLCsWzru4kXB0T03oCYT3dBZs9DI61jhwj7z4rW85KXNBeudOr
	5rBtaRo25jDL2TsH4fdDMjnRwxv4c/8fRYR3PaJ04honf3LySNFL0H4QIdDxYqpcRaKI=
X-Gm-Gg: ASbGncsuYed+NIZWnBWEaAIBwLRsA9dPj2lviM3g/zO+2DVI0SZ6bAPWwY3cVDhZ5xb
	krPd8FpzX6srTOdzczjspiRRYFkJtHGJ7F7CkwL0koal0CtXYtXMXfXYW4N0eAbniW0cWCImMkx
	3sQEYWPgnUv/gdJqhiLXhPzeIy7Mpv3dmY4zF8GPI38Yt09pNA9X6krZWsdso3ORV6dkjvdNnUS
	qszfswpn4g18R9gbCVWGnCtzgCutF0Yy9Fo7pBhNhXSoB7OZsS7nn1iNQrlFPFQH+8OxXZnW5om
	/7X70ynQ1fiE2iCZvpm3ERScsDA5pN4lkBUntYIMHLEaKODjEZcN3bkm/RxbVaGaeVaadNd7bra
	9hKoWse+YvsKeqROPnqBhKoYp86i0AHG4c77eEzCs1G5nfzEuKZVnVsPXECtIBX7PBrk=
X-Received: by 2002:a05:6000:643:b0:3a5:25e0:1851 with SMTP id ffacd0b85a97d-3b5f1875e37mr15346477f8f.7.1752589108651;
        Tue, 15 Jul 2025 07:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiBepijZKJjM02yAnF9OJBk4VUiu5bY/nT8xuLFQ4t33OnHfJOgjJeATj2QBAyc/L6yPLj6g==
X-Received: by 2002:a05:6000:643:b0:3a5:25e0:1851 with SMTP id ffacd0b85a97d-3b5f1875e37mr15346404f8f.7.1752589108184;
        Tue, 15 Jul 2025 07:18:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1de0sm15098577f8f.24.2025.07.15.07.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:18:27 -0700 (PDT)
Message-ID: <3336b153-7600-4b1a-9acc-0ecde8d32cdc@redhat.com>
Date: Tue, 15 Jul 2025 16:18:26 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] huge_memory: add
 huge_zero_page_shrinker_(init|exit) function
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-3-kernel@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250707142319.319642-3-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.07.25 16:23, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Add huge_zero_page_shrinker_init() and huge_zero_page_shrinker_exit().
> As shrinker will not be needed when static PMD zero page is enabled,
> these two functions can be a no-op.
> 
> This is a preparation patch for static PMD zero page. No functional
> changes.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   mm/huge_memory.c | 38 +++++++++++++++++++++++++++-----------
>   1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d3e66136e41a..101b67ab2eb6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -289,6 +289,24 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
>   }
>   
>   static struct shrinker *huge_zero_page_shrinker;
> +static int huge_zero_page_shrinker_init(void)
> +{
> +	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
> +	if (!huge_zero_page_shrinker)
> +		return -ENOMEM;
> +
> +	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
> +	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
> +	shrinker_register(huge_zero_page_shrinker);
> +	return 0;
> +}
> +
> +static void huge_zero_page_shrinker_exit(void)
> +{
> +	shrinker_free(huge_zero_page_shrinker);
> +	return;
> +}

While at it, we should rename most of that to "huge_zero_folio" I assume.

-- 
Cheers,

David / dhildenb


