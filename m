Return-Path: <linux-fsdevel+bounces-29574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B89397AEA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 12:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4020E1C23453
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF78A16193C;
	Tue, 17 Sep 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLqmIprJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16FD14BFA3
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568431; cv=none; b=CLKt1pUirpB7rNbdwZ/jNsLadZDoU1O1oUf2Zfm9Ph6Htip23HstB7xfw+1ebZvJ8BETcHGLvfjqf2xov3pZsHHcugy7zYYsRs+asDBflqXDTcF7v5HbFqNd8XbLs0bwt97ixHqfq3xbs8I0eo2AFDykw0y0GshwhcIY8ILy+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568431; c=relaxed/simple;
	bh=qe4jWrZe8Skbk/Q/ZNbiXKEoBv6Z8lAP9Ny5GlSyazg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FN9gR9BSQ0jnot/+vPQvhxkwiEPA/My8hnoGNvAWze+XvxCgfi+ePUUM7zCUHJ6rQwNKWli8Gnb8R8Jp28kiZss2gW1Uw4BymPi+gq0dis+k6UOQB5p+wXtzJkDjI+XAs5JakmPIhZgr2yaKFR8PES8Dtx+cT+boKKlM30KfPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLqmIprJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726568428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6ZCJTmJx2xNT3osb0wa+deaEyFcFSSWyiY3NZGLuGe4=;
	b=BLqmIprJ1EW0rZxGoiQQkoRXMQAUofH9dUgLRePXLS4hu2Npa7eaDeeuWgwbOWzOZ32Rnf
	lAPtkJSCcDYVCEcEbweIp4uVpjpOl+JvCiW4RGv/rBoG15qC/FtQALOS8g6YqfvqiWw+Vd
	epXmQ9GcKdl2XwL9vbydEwZFcWXCQno=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-tAJgcqKOOf2ifqL6EnSuZw-1; Tue, 17 Sep 2024 06:20:27 -0400
X-MC-Unique: tAJgcqKOOf2ifqL6EnSuZw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c251bcb728so2977009a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 03:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726568426; x=1727173226;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZCJTmJx2xNT3osb0wa+deaEyFcFSSWyiY3NZGLuGe4=;
        b=D86icClJ7fm/I/A+cJe2v8lcyxmSYTXwl2umMeotyV2zhVQJAImDnsx9mmYxcwntJx
         79NZck34Z4G8KElkf/A7mOZmdThI2Z+fRG1tq8yLWiv+uTwpU6wD/3LWHww4/nL9J1o8
         0aShXzK7cf/Y1auSwueMOL2HqeMvvnyPOEGjzDZTk+rsauAYA7RFQzmvi2TTbRw6h3ek
         aPDd4gFU5cuZhjqlJU0WCDR0DS41EgmLbcT1DtJBPxPRvcLtoMpZ/Ph/zmX/p1p11rCA
         L4EBeEVdemclpd/jrgKBl9NE/SpCLO+BDKQfjc3/eqrfHQ6f1bktBCeaARnygkQ6eOao
         ijMw==
X-Forwarded-Encrypted: i=1; AJvYcCU4m+shnTigPcZzmIm/O3oo6j3PapLm180t7Snc1tR4pcsbPRwMjKg4GytCe5bp36c4nLhekGor5JQ2UICc@vger.kernel.org
X-Gm-Message-State: AOJu0YxfUcQZPKufTFLT2uuZg0N4Z2jJgpkX0gjoxe2a7TGEOlPnKxPW
	bg0bAaa6EFMc5AL2ZYJJR5vyfANJcjCpC+tFccu1rHJFlALFoKiXYRWVNbaZhpvklsmot9GAfQG
	Js4JlHwTmWARk21ejMU9mqSqmUCKlUDWSpPk/RNQ7iwFW0qJOqOXfZbg6VQ/MonKk6k7/i6w=
X-Received: by 2002:a05:6402:280a:b0:5c2:8249:b2d3 with SMTP id 4fb4d7f45d1cf-5c413e4c51fmr15560407a12.26.1726568426149;
        Tue, 17 Sep 2024 03:20:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKO0hNuKYYyiVpmnAX1arSFAg5yVO4DtVE3xUZpqnqvalCbFtGjpIfHmfyO2kH806kqBFSKw==
X-Received: by 2002:a05:6402:280a:b0:5c2:8249:b2d3 with SMTP id 4fb4d7f45d1cf-5c413e4c51fmr15560373a12.26.1726568425483;
        Tue, 17 Sep 2024 03:20:25 -0700 (PDT)
Received: from [192.168.55.136] (tmo-067-108.customers.d1-online.com. [80.187.67.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc8a51dsm3510875a12.97.2024.09.17.03.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 03:20:25 -0700 (PDT)
Message-ID: <4ced9211-2bd7-4257-a9fc-32c775ceffef@redhat.com>
Date: Tue, 17 Sep 2024 12:20:22 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/7] m68k/mm: Change pmd_val()
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Guo Ren <guoren@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20240917073117.1531207-1-anshuman.khandual@arm.com>
 <20240917073117.1531207-2-anshuman.khandual@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240917073117.1531207-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.24 09:31, Anshuman Khandual wrote:
> This changes platform's pmd_val() to access the pmd_t element directly like
> other architectures rather than current pointer address based dereferencing
> that prevents transition into pmdp_get().
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/m68k/include/asm/page.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
> index 8cfb84b49975..be3f2c2a656c 100644
> --- a/arch/m68k/include/asm/page.h
> +++ b/arch/m68k/include/asm/page.h
> @@ -19,7 +19,7 @@
>    */
>   #if !defined(CONFIG_MMU) || CONFIG_PGTABLE_LEVELS == 3
>   typedef struct { unsigned long pmd; } pmd_t;
> -#define pmd_val(x)	((&x)->pmd)
> +#define pmd_val(x)	((x).pmd)
>   #define __pmd(x)	((pmd_t) { (x) } )
>   #endif
>   

Trying to understand what's happening here, I stumbled over

commit ef22d8abd876e805b604e8f655127de2beee2869
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Jan 31 13:45:36 2020 +0100

     m68k: mm: Restructure Motorola MMU page-table layout
     
     The Motorola 68xxx MMUs, 040 (and later) have a fixed 7,7,{5,6}
     page-table setup, where the last depends on the page-size selected (8k
     vs 4k resp.), and head.S selects 4K pages. For 030 (and earlier) we
     explicitly program 7,7,6 and 4K pages in %tc.
     
     However, the current code implements this mightily weird. What it does
     is group 16 of those (6 bit) pte tables into one 4k page to not waste
     space. The down-side is that that forces pmd_t to be a 16-tuple
     pointing to consecutive pte tables.
     
     This breaks the generic code which assumes READ_ONCE(*pmd) will be
     word sized.

Where we did

  #if !defined(CONFIG_MMU) || CONFIG_PGTABLE_LEVELS == 3
-typedef struct { unsigned long pmd[16]; } pmd_t;
-#define pmd_val(x)     ((&x)->pmd[0])
-#define __pmd(x)       ((pmd_t) { { (x) }, })
+typedef struct { unsigned long pmd; } pmd_t;
+#define pmd_val(x)     ((&x)->pmd)
+#define __pmd(x)       ((pmd_t) { (x) } )
  #endif

So I assume this should be fine

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


