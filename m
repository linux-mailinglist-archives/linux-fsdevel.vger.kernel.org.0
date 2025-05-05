Return-Path: <linux-fsdevel+bounces-48039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A52AA901C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DCB3ACEE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15611C1F12;
	Mon,  5 May 2025 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RA+x5gBq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42409224CC
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438711; cv=none; b=L9H9JClMmvp2mOVzXjyRo6MuTrPw9HQAxX3UIbr3HxU6Vmj8fgjk3ViQiqIv6Ag68seIC1V4VECro1uURrRBhC991U9x2KCGookukJw1fBNVD21ek19KQCHxqKGyiJatP+DdkjmgIS2S6DdXiTLqHTVKSSMk4Agk1nqDSDvf6KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438711; c=relaxed/simple;
	bh=hjLXcSsWgHNnpJyCC6pKmusgdK1DykweXrwFWxrCgZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F62KdRBbnuL6fitw504Ei9RK/ZdnccW268NaRiPPWPo0dn4ka3FQOw4lDw/xWrWNwKbv7UeycANX7YQVuks2qFM+AbWT/yfUDEUXmPyM0VmhRm3Lv2QaDwJlatYC9i90nRkCZkBpXXyZjly50mhDx8bz+ialpN60dI2RnLJwLlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RA+x5gBq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746438708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ewS6Vik8l5cRJ8KrBPd45Zc0hKMID54cVJfZTT1QyCc=;
	b=RA+x5gBq3q+6YMV1L7ItlwG2e9O1mWKN9Gfvpcd2WSqqpnTDESlQNU7BmfcWPKviKjVXUR
	/zAXyJ1acbE8ke2S5kdBhw48GF2eJhcHkK106KAaT3USx3Ghh0bhkz+2am6lKH1j76oam0
	xp0yhln+qWmvgc8fLSOrG/itx3cf6ow=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-0wcMT-5vP4Ogl3gCLEjh8g-1; Mon, 05 May 2025 05:51:46 -0400
X-MC-Unique: 0wcMT-5vP4Ogl3gCLEjh8g-1
X-Mimecast-MFC-AGG-ID: 0wcMT-5vP4Ogl3gCLEjh8g_1746438706
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a064c45f03so1713894f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 02:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746438705; x=1747043505;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ewS6Vik8l5cRJ8KrBPd45Zc0hKMID54cVJfZTT1QyCc=;
        b=sd1ZnlH2a0EUO8YOU4QYKkj1ty7gka9aVZJqIORAM3OvBX8CAG6UDK1RBBA7a6Hc0k
         WuQHEEQ9SC7dfO/jepUsadWdlYoT30xpJQa9adQCCNKvK6NkFuyiLnOMqDCMqJ8QDUUn
         9sW+UZrpVpPEtOIPK9uPYEBPdPcU5K9t9EalHjm/T/q36M7I0fff6drBwr2BiUQBfIEc
         V6kZX4xoOJ7gXD6H7BJG/IeyBhXu0CKQNZJdryl+H5VrHLsKC0hbNqBfUyGAUedczf/A
         aR2H/xoZoW530pcoN7XlIzkR23lRzkI2uzczaVdQHhaDQc/KE0xzixttRd/yfWbNoAnp
         tpoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1lLsQlKzr6GL3Jh2K/F2nJJxJl0akAK1vgm3CzE5v+3HEIi0rLyRgBbHq54zUInF0I7OOrJnt00M0qd8E@vger.kernel.org
X-Gm-Message-State: AOJu0YyxfTadzxl5UP+u85lZE/1hnadClEnJ0D797rfVR8FSB8i1C0kP
	0YYEYnmE2vqLK7fS0oaWtKwPuKc4QKAdNexXisKOuQU5xoLa98qD92lzeyKTyF5rufVkEljGGdJ
	sPxRlieDljN0RU/1ydHjS76r0IRhsdGDJCVTANz39VTim2pPOWvpy8JSVPlpgevo=
X-Gm-Gg: ASbGncuX0elRCiTQ/RfopF3PamNOVnLBfqgZcobSj1nfTinH8tBUOprMHvtx7dEirpK
	v1K/uZfaml2atWSUh6xr3WvoUZA/JxJ9f31mIK0wt8CAAayL/gxvH7qsgIul1sscyMgfB0tNJHD
	lggVr6sUVSRnbMk0EdNzQAsXwn2zo8inql5ObYTXlrCQEBsKcB/Q0kl3Oey1hz5ssEIi6ZSFfrJ
	BoP59UUqlg8kOTqScfWNQwbSyjH3AAuZ1QfTv4PwAItRa/7Z+F1MCQVlVqIRGLA9jVO9kpYnYcY
	qt4rG4IlHVhKvQYfDY943v67TOMgB4qco9ns2K1zxgYywRZ9vGpowev3Sk4S4FEgZMwKcs8ffV6
	UHI4Qgd5IGQxQCINBW6tqGno7mCfa/fAIJ7TSJaM=
X-Received: by 2002:a5d:64ef:0:b0:3a0:6a86:9477 with SMTP id ffacd0b85a97d-3a097a3e8a9mr8921387f8f.0.1746438705512;
        Mon, 05 May 2025 02:51:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQIr0akqqVpSfJA+WqHy/RkGIsb/kMplUD1UgGlE7QwSA+HczFWZoFmADtXqSrBLR7+KQVbw==
X-Received: by 2002:a5d:64ef:0:b0:3a0:6a86:9477 with SMTP id ffacd0b85a97d-3a097a3e8a9mr8921367f8f.0.1746438705146;
        Mon, 05 May 2025 02:51:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73d:2400:3be1:a856:724c:fd29? (p200300cbc73d24003be1a856724cfd29.dip0.t-ipconnect.de. [2003:cb:c73d:2400:3be1:a856:724c:fd29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b1702dsm9703021f8f.88.2025.05.05.02.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 02:51:44 -0700 (PDT)
Message-ID: <48b4aa79-943b-46bc-ac24-604fdf998566@redhat.com>
Date: Mon, 5 May 2025 11:51:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/5] mm/readahead: Honour new_order in
 page_cache_ra_order()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Dave Chinner <david@fromorbit.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-2-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250430145920.3748738-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.25 16:59, Ryan Roberts wrote:
> page_cache_ra_order() takes a parameter called new_order, which is
> intended to express the preferred order of the folios that will be
> allocated for the readahead operation. Most callers indeed call this
> with their preferred new order. But page_cache_async_ra() calls it with
> the preferred order of the previous readahead request (actually the
> order of the folio that had the readahead marker, which may be smaller
> when alignment comes into play).
> 
> And despite the parameter name, page_cache_ra_order() always treats it
> at the old order, adding 2 to it on entry. As a result, a cold readahead
> always starts with order-2 folios.
> 
> Let's fix this behaviour by always passing in the *new* order.
> 
> Worked example:
> 
> Prior to the change, mmaping an 8MB file and touching each page
> sequentially, resulted in the following, where we start with order-2
> folios for the first 128K then ramp up to order-4 for the next 128K,
> then get clamped to order-5 for the rest of the file because pa_pages is
> limited to 128K:
> 
> TYPE    STARTOFFS     ENDOFFS       SIZE  STARTPG    ENDPG   NRPG  ORDER
> -----  ----------  ----------  ---------  -------  -------  -----  -----
> FOLIO  0x00000000  0x00004000      16384        0        4      4      2
> FOLIO  0x00004000  0x00008000      16384        4        8      4      2
> FOLIO  0x00008000  0x0000c000      16384        8       12      4      2
> FOLIO  0x0000c000  0x00010000      16384       12       16      4      2
> FOLIO  0x00010000  0x00014000      16384       16       20      4      2
> FOLIO  0x00014000  0x00018000      16384       20       24      4      2
> FOLIO  0x00018000  0x0001c000      16384       24       28      4      2
> FOLIO  0x0001c000  0x00020000      16384       28       32      4      2
> FOLIO  0x00020000  0x00030000      65536       32       48     16      4
> FOLIO  0x00030000  0x00040000      65536       48       64     16      4
> FOLIO  0x00040000  0x00060000     131072       64       96     32      5
> FOLIO  0x00060000  0x00080000     131072       96      128     32      5
> FOLIO  0x00080000  0x000a0000     131072      128      160     32      5
> FOLIO  0x000a0000  0x000c0000     131072      160      192     32      5

Interesting, I would have thought we'd ramp up earlier.

> ...
> 
> After the change, the same operation results in the first 128K being
> order-0, then we start ramping up to order-2, -4, and finally get
> clamped at order-5:
> 
> TYPE    STARTOFFS     ENDOFFS       SIZE  STARTPG    ENDPG   NRPG  ORDER
> -----  ----------  ----------  ---------  -------  -------  -----  -----
> FOLIO  0x00000000  0x00001000       4096        0        1      1      0
> FOLIO  0x00001000  0x00002000       4096        1        2      1      0
> FOLIO  0x00002000  0x00003000       4096        2        3      1      0
> FOLIO  0x00003000  0x00004000       4096        3        4      1      0
> FOLIO  0x00004000  0x00005000       4096        4        5      1      0
> FOLIO  0x00005000  0x00006000       4096        5        6      1      0
> FOLIO  0x00006000  0x00007000       4096        6        7      1      0
> FOLIO  0x00007000  0x00008000       4096        7        8      1      0
> FOLIO  0x00008000  0x00009000       4096        8        9      1      0
> FOLIO  0x00009000  0x0000a000       4096        9       10      1      0
> FOLIO  0x0000a000  0x0000b000       4096       10       11      1      0
> FOLIO  0x0000b000  0x0000c000       4096       11       12      1      0
> FOLIO  0x0000c000  0x0000d000       4096       12       13      1      0
> FOLIO  0x0000d000  0x0000e000       4096       13       14      1      0
> FOLIO  0x0000e000  0x0000f000       4096       14       15      1      0
> FOLIO  0x0000f000  0x00010000       4096       15       16      1      0
> FOLIO  0x00010000  0x00011000       4096       16       17      1      0
> FOLIO  0x00011000  0x00012000       4096       17       18      1      0
> FOLIO  0x00012000  0x00013000       4096       18       19      1      0
> FOLIO  0x00013000  0x00014000       4096       19       20      1      0
> FOLIO  0x00014000  0x00015000       4096       20       21      1      0
> FOLIO  0x00015000  0x00016000       4096       21       22      1      0
> FOLIO  0x00016000  0x00017000       4096       22       23      1      0
> FOLIO  0x00017000  0x00018000       4096       23       24      1      0
> FOLIO  0x00018000  0x00019000       4096       24       25      1      0
> FOLIO  0x00019000  0x0001a000       4096       25       26      1      0
> FOLIO  0x0001a000  0x0001b000       4096       26       27      1      0
> FOLIO  0x0001b000  0x0001c000       4096       27       28      1      0
> FOLIO  0x0001c000  0x0001d000       4096       28       29      1      0
> FOLIO  0x0001d000  0x0001e000       4096       29       30      1      0
> FOLIO  0x0001e000  0x0001f000       4096       30       31      1      0
> FOLIO  0x0001f000  0x00020000       4096       31       32      1      0
> FOLIO  0x00020000  0x00024000      16384       32       36      4      2
> FOLIO  0x00024000  0x00028000      16384       36       40      4      2
> FOLIO  0x00028000  0x0002c000      16384       40       44      4      2
> FOLIO  0x0002c000  0x00030000      16384       44       48      4      2
> FOLIO  0x00030000  0x00034000      16384       48       52      4      2
> FOLIO  0x00034000  0x00038000      16384       52       56      4      2
> FOLIO  0x00038000  0x0003c000      16384       56       60      4      2
> FOLIO  0x0003c000  0x00040000      16384       60       64      4      2
> FOLIO  0x00040000  0x00050000      65536       64       80     16      4
> FOLIO  0x00050000  0x00060000      65536       80       96     16      4
> FOLIO  0x00060000  0x00080000     131072       96      128     32      5
> FOLIO  0x00080000  0x000a0000     131072      128      160     32      5
> FOLIO  0x000a0000  0x000c0000     131072      160      192     32      5
> FOLIO  0x000c0000  0x000e0000     131072      192      224     32      5

Similar here, do you know why we don't ramp up earlier. Allocating that 
many order-0 + order-2 pages looks a bit suboptimal to me for a 
sequential read.

I wonder if you're change will have a measurable downside on sequential 
read. Anyhow, I think it was already not behaving how I would have 
expected it ... :)

Acked-by: David Hildenbrand <david@redhat.com>

> ...
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   mm/readahead.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 6a4e96b69702..8bb316f5a842 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -479,9 +479,6 @@ void page_cache_ra_order(struct readahead_control *ractl,
>   
>   	limit = min(limit, index + ra->size - 1);
>   
> -	if (new_order < mapping_max_folio_order(mapping))
> -		new_order += 2;
> -
>   	new_order = min(mapping_max_folio_order(mapping), new_order);
>   	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>   	new_order = max(new_order, min_order);
> @@ -683,6 +680,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
>   	ra->size = get_next_ra_size(ra, max_pages);
>   	ra->async_size = ra->size;
>   readit:
> +	order += 2;
>   	ractl->_index = ra->start;
>   	page_cache_ra_order(ractl, ra, order);
>   }


-- 
Cheers,

David / dhildenb


