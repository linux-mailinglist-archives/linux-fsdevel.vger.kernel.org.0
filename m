Return-Path: <linux-fsdevel+bounces-54668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8077EB02141
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F778585603
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA62B2EF293;
	Fri, 11 Jul 2025 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtmlqoxA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A3E2EF28C
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250143; cv=none; b=JQU/4VY3HNKtJpwgHD+rrEyoKsE5CPZQKA0wxtvhd+PQGByuDVyzY6PIc9dy9Tkf67XESzVFe1BYZZbQhnVNfHId8Qsp5/6HYDDaYlgY1VNb621fnfy7NJaBU3Gr2159N75VD+p6eaktSf/dTqm1srrJxBh9rtu0UQzThzQsh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250143; c=relaxed/simple;
	bh=JPB6gAXGCTid4CIekWWwDK3Km+g1N9mMWAgfD/eRVeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWsSsB2XzaTBgB6Q3OiOvRBiqCXnOu78RQzmbIndIx5Nt4OWGs5ACh16WCLxYWLo1TcUJ0xL5Z9Rd8+zs3FaSVlWjYnDuQn1ypAsnnmwrVIRajYOZKTxZDfpHjzOmrnaE2mTVjFPdIv+muHjsRUervyfrd5p6KpPE0I7k/xvhKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtmlqoxA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752250140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sWRifwM6LmNFYsjOSVY+1cdnVJWlu7pGI1FDkTerRIs=;
	b=WtmlqoxASsJCkQlzWcfIZ9t/Mn1HzurmTx1v6OsPYls5G78INQ8555Q4UpDGYwgCQP0ydE
	k79baHjkZHrqJl4G44okgi5cx+YrejHBewMBFvnE7B/LO7QjeS6VODzazVtU/pSfJ0crqB
	yW5oqKb+wyINAK5IrhamjOeoBqqQuWg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-zUfDnnWaPs2ndr_9nd1AgQ-1; Fri, 11 Jul 2025 12:08:59 -0400
X-MC-Unique: zUfDnnWaPs2ndr_9nd1AgQ-1
X-Mimecast-MFC-AGG-ID: zUfDnnWaPs2ndr_9nd1AgQ_1752250137
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450df53d461so17615395e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 09:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250137; x=1752854937;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sWRifwM6LmNFYsjOSVY+1cdnVJWlu7pGI1FDkTerRIs=;
        b=tUYuSJz5KZYl4fWjSRN1MDx98hMOUgERraQV1uXToeNX8sk0NDQvpST6IaZWabSmkJ
         VPH89J+g270AxifFC+x3YQFUDEntCqQ6h3XXRxAzOmUAiKDHm7cW4lhNkhlSxvrf+xgV
         XEbaJgPanbgYL3SuNrcCdtuZPqC9KGYebDXFQ1JoBh2DEkywp2z8krlsY0CDKB6nB8z7
         0lqeY8JPDf1LJdvR97+IBafWxEcErWsQ9g8iTavjSP7dUXZ+2u4JlZCw5vGhUqAj7mVu
         4rQUcuu43SDLbLLJ03vzQIOjZLLAYfh1IoTIvsyiZ/2dyZfPH9nBb6qBZVmo48i8RX6q
         1LEw==
X-Forwarded-Encrypted: i=1; AJvYcCWLziZZnJ6UVxNKbn4343enGpXiozpdP+x4wiC3J3/DUqtJ6ImXgoiwrgnu0/ZwoAqeFB1iU0uiqZkoBt7S@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpa0MSWshm52Le3kHKU6p3MiKXzlX5jVzdWnselFTtbqzK2LZq
	aPPqDWo8qQrvg7ccIdY8Iw4Y1cX2GGYWAkXD0I98CDHIBXO0KFAWdisLYOmo3OhRtycTrMLOhWz
	UGRTOZM2/nflWjTsF0OTo7IZLQlXAXvkI0oMzVn2MLaW1jMATueFm9A6bCXMb6hmyDUA=
X-Gm-Gg: ASbGncuEn5adYV6QFyT1EJtn4gaOujbQjVNdOYl6iEjRL4yfi82XedGpqHCc+0W3FvS
	sgh/gUcB/jZCFt9omZgdOv/bsxn9eTUV/gO/9AbNlgPOCcWPmq08EYyFtoeyipqnnU9aSzCI6aV
	/RIyotjSC2G3MRxQ4EfPzmyD9d/cb4RA1gIE+aENn1SK9eniaiBrz7l1P9ux9rZXn58smU4U17B
	p12Qfgojt9kT6sBZk+8Lp/1ORtMCAQf1KA+dBWNwYzrfjl3xKPjk1UjvkWvqV/Mh2qDf/glN6lK
	5A2TuBb99n+BrFoZ4sfE6OwHz++G+jdFu8sYyXoabhGneF4ToLcJEnbC+5cOnRrRuaeSqbuB1I7
	mIsdDMcc8ZLZHG36uFleNMZsKgfNLiJbxlkPxNcCwMuZuGlRN90tXFV5MkCtvtWoYl9Q=
X-Received: by 2002:a05:6000:2106:b0:3a0:9dfc:da4 with SMTP id ffacd0b85a97d-3b5f18e8186mr2457644f8f.42.1752250136521;
        Fri, 11 Jul 2025 09:08:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrdLCVxQFXDZoHWBaArvI/JWAko/gQrTQgMVVG+YPHP+uyYAD1kv7dPFG807wqoEEoqy7oPQ==
X-Received: by 2002:a05:6000:2106:b0:3a0:9dfc:da4 with SMTP id ffacd0b85a97d-3b5f18e8186mr2457608f8f.42.1752250135821;
        Fri, 11 Jul 2025 09:08:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd537785sm52075745e9.23.2025.07.11.09.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 09:08:54 -0700 (PDT)
Message-ID: <e80c3fdd-782e-4857-810e-5b7384448154@redhat.com>
Date: Fri, 11 Jul 2025 18:08:53 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/filemap: Align last_index to folio size
To: Youling Tang <youling.tang@linux.dev>,
 Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, chizhiling@163.com,
 Youling Tang <tangyouling@kylinos.cn>, Chi Zhiling <chizhiling@kylinos.cn>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20250711055509.91587-1-youling.tang@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250711055509.91587-1-youling.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

CCing Ryan, who recently fiddled with readahead.


On 11.07.25 07:55, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> On XFS systems with pagesize=4K, blocksize=16K, and CONFIG_TRANSPARENT_HUGEPAGE
> enabled, We observed the following readahead behaviors:
>   # echo 3 > /proc/sys/vm/drop_caches
>   # dd if=test of=/dev/null bs=64k count=1
>   # ./tools/mm/page-types -r -L -f  /mnt/xfs/test
>   foffset	offset	flags
>   0	136d4c	__RU_l_________H______t_________________F_1
>   1	136d4d	__RU_l__________T_____t_________________F_1
>   2	136d4e	__RU_l__________T_____t_________________F_1
>   3	136d4f	__RU_l__________T_____t_________________F_1
>   ...
>   c	136bb8	__RU_l_________H______t_________________F_1
>   d	136bb9	__RU_l__________T_____t_________________F_1
>   e	136bba	__RU_l__________T_____t_________________F_1
>   f	136bbb	__RU_l__________T_____t_________________F_1   <-- first read
>   10	13c2cc	___U_l_________H______t______________I__F_1   <-- readahead flag
>   11	13c2cd	___U_l__________T_____t______________I__F_1
>   12	13c2ce	___U_l__________T_____t______________I__F_1
>   13	13c2cf	___U_l__________T_____t______________I__F_1
>   ...
>   1c	1405d4	___U_l_________H______t_________________F_1
>   1d	1405d5	___U_l__________T_____t_________________F_1
>   1e	1405d6	___U_l__________T_____t_________________F_1
>   1f	1405d7	___U_l__________T_____t_________________F_1
>   [ra_size = 32, req_count = 16, async_size = 16]
> 
>   # echo 3 > /proc/sys/vm/drop_caches
>   # dd if=test of=/dev/null bs=60k count=1
>   # ./page-types -r -L -f  /mnt/xfs/test
>   foffset	offset	flags
>   0	136048	__RU_l_________H______t_________________F_1
>   ...
>   c	110a40	__RU_l_________H______t_________________F_1
>   d	110a41	__RU_l__________T_____t_________________F_1
>   e	110a42	__RU_l__________T_____t_________________F_1   <-- first read
>   f	110a43	__RU_l__________T_____t_________________F_1   <-- first readahead flag
>   10	13e7a8	___U_l_________H______t_________________F_1
>   ...
>   20	137a00	___U_l_________H______t_______P______I__F_1   <-- second readahead flag (20 - 2f)
>   21	137a01	___U_l__________T_____t_______P______I__F_1
>   ...
>   3f	10d4af	___U_l__________T_____t_______P_________F_1
>   [first readahead: ra_size = 32, req_count = 15, async_size = 17]
> 
> When reading 64k data (same for 61-63k range, where last_index is page-aligned
> in filemap_get_pages()), 128k readahead is triggered via page_cache_sync_ra()
> and the PG_readahead flag is set on the next folio (the one containing 0x10 page).
> 
> When reading 60k data, 128k readahead is also triggered via page_cache_sync_ra().
> However, in this case the readahead flag is set on the 0xf page. Although the
> requested read size (req_count) is 60k, the actual read will be aligned to
> folio size (64k), which triggers the readahead flag and initiates asynchronous
> readahead via page_cache_async_ra(). This results in two readahead operations
> totaling 256k.
> 
> The root cause is that when the requested size is smaller than the actual read
> size (due to folio alignment), it triggers asynchronous readahead. By changing
> last_index alignment from page size to folio size, we ensure the requested size
> matches the actual read size, preventing the case where a single read operation
> triggers two readahead operations.
> 
> After applying the patch:
>   # echo 3 > /proc/sys/vm/drop_caches
>   # dd if=test of=/dev/null bs=60k count=1
>   # ./page-types -r -L -f  /mnt/xfs/test
>   foffset	offset	flags
>   0	136d4c	__RU_l_________H______t_________________F_1
>   1	136d4d	__RU_l__________T_____t_________________F_1
>   2	136d4e	__RU_l__________T_____t_________________F_1
>   3	136d4f	__RU_l__________T_____t_________________F_1
>   ...
>   c	136bb8	__RU_l_________H______t_________________F_1
>   d	136bb9	__RU_l__________T_____t_________________F_1
>   e	136bba	__RU_l__________T_____t_________________F_1   <-- first read
>   f	136bbb	__RU_l__________T_____t_________________F_1
>   10	13c2cc	___U_l_________H______t______________I__F_1   <-- readahead flag
>   11	13c2cd	___U_l__________T_____t______________I__F_1
>   12	13c2ce	___U_l__________T_____t______________I__F_1
>   13	13c2cf	___U_l__________T_____t______________I__F_1
>   ...
>   1c	1405d4	___U_l_________H______t_________________F_1
>   1d	1405d5	___U_l__________T_____t_________________F_1
>   1e	1405d6	___U_l__________T_____t_________________F_1
>   1f	1405d7	___U_l__________T_____t_________________F_1
>   [ra_size = 32, req_count = 16, async_size = 16]
> 
> The same phenomenon will occur when reading from 49k to 64k. Set the readahead
> flag to the next folio.
> 
> Because the minimum order of folio in address_space equals the block size (at
> least in xfs and bcachefs that already support bs > ps), having request_count
> aligned to block size will not cause overread.
> 
> Co-developed-by: Chi Zhiling <chizhiling@kylinos.cn>
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>   include/linux/pagemap.h | 6 ++++++
>   mm/filemap.c            | 5 +++--
>   2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index e63fbfbd5b0f..447bb264fd94 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -480,6 +480,12 @@ mapping_min_folio_nrpages(struct address_space *mapping)
>   	return 1UL << mapping_min_folio_order(mapping);
>   }
>   
> +static inline unsigned long
> +mapping_min_folio_nrbytes(struct address_space *mapping)
> +{
> +	return mapping_min_folio_nrpages(mapping) << PAGE_SHIFT;
> +}
> +
>   /**
>    * mapping_align_index() - Align index for this mapping.
>    * @mapping: The address_space.
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 765dc5ef6d5a..56a8656b6f86 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2584,8 +2584,9 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>   	unsigned int flags;
>   	int err = 0;
>   
> -	/* "last_index" is the index of the page beyond the end of the read */
> -	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
> +	/* "last_index" is the index of the folio beyond the end of the read */
> +	last_index = round_up(iocb->ki_pos + count, mapping_min_folio_nrbytes(mapping));
> +	last_index >>= PAGE_SHIFT;
>   retry:
>   	if (fatal_signal_pending(current))
>   		return -EINTR;


-- 
Cheers,

David / dhildenb


