Return-Path: <linux-fsdevel+bounces-16006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A858969DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 11:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA4C289F71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31856EB79;
	Wed,  3 Apr 2024 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xo8J9Kph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7901B69302
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134903; cv=none; b=i8motJY8sC0VbOohBfukN7s9aQQCq++uddiv1/t+RMKCPOm+dPqNDYywuNWKBBtHx3YvU8FUOBBDWCBykCvmlVgeYcri/fzQ/Hfy3zvPFOAbdQkDpywwlZDmPHfQCM43j76Cq7t9zH/H8ACVFeo/pj8jg6MnY4GJ0w99SbcL4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134903; c=relaxed/simple;
	bh=DhjsvHFF3Q9Um+F/S7DVjInH1A+lh5cHR953HX9eg64=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kBAYk4igIUZ3hqNVDp4zdvF4EsHaaCXm7oms2wUR+uFaBWkcj+Sa7wS6wxAB0P/OnZIiKfxZUYVwk7gBk3W/a1Dx+YBTtJ9rp2mOtxrW9mG7P2OoKEf9++scCXsc86MRZ5/43oV5C/+4FZU8APk+JK2qZmDPL90oHmfYyI0i+5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xo8J9Kph; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so132314666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712134900; x=1712739700; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKTvyviZYK4YbCfgO7uqqTAP3INhOx4eFu+wuHKAZ6I=;
        b=Xo8J9KphdLmaXBF2eZBj1HSOFO9s03q34RxZHEBtsbzzRN+PnP0CLydgCE0ptbQUiU
         jwcwVrp5XsTyCYsvRvHK7TTeoTZIEAC4H11I9xRGsVUqbLXdrHBU/QXsIa0qnh9nsUOQ
         +Wo8wcwx912KwNnJ3b3qPN5KfkZpmP4XuBTSC1M3ugp2tI6kxrE7W4Bit7HJM23vwR9R
         AldJkkp/mS1veqKl5IFnVop8s3lVK0hb5YmX6R3ovgJF1V2GsHORZZtfKTdpy6MYwobl
         Av1cqkFwfYg8Agg7+zyQwW5HQnhG3dzPfnmA/ZxaeQ8eS23A1dQIKEiZHGM4H0gHSd7Q
         ODzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712134900; x=1712739700;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKTvyviZYK4YbCfgO7uqqTAP3INhOx4eFu+wuHKAZ6I=;
        b=YfQtbD/rrv5vvaxql0VOqaCfr7H6pBLF2lTcVfkFiaEeXNsguNce3LMtoJyBPqNQrU
         LD6pEghgcMT+RofwnzMVmR/lQwZR499oLrRhTVspfsVaiGhQ8X5/IgE1p1G5gpjO9BhW
         pocbmrXI0qTEVfEDb2+5so3OFwLgpVtfJTQROhmhpRbJj4hF4mVCO2kna1C/r3VkHmUd
         LljjdPqRCN4mzixbmPmxAPgLI2tcYVuAhTh8MI8hRw395byTNrYqQePPRjZLdOe2aBYr
         cGxJwmbFE92Rax5F6xXnq+JQm1ZGNdyzzjthhmgBbOG5vhGj8ad3ytnmubstGPXGW60R
         IJZg==
X-Gm-Message-State: AOJu0YzWkZjkYC2a0gLjZfgvmRN1gOlNO8tXmZNyigzgbPJE14FuKuaz
	l7/GU9n9o/9OplkhG+kpAyMLb4w0h2AziCyHWgtHE6WyTNY0iAQ7ao3oTbLUFEHqvWUyB0yXMMr
	p
X-Google-Smtp-Source: AGHT+IHqnq6TrzK6CGcuiWIu1r/1MnHiukQlVX9Fs+BaIaujE7Jz6ROZjS8yU5VEZEBBpP14UZFRfA==
X-Received: by 2002:a17:906:6a03:b0:a4e:279f:ab2c with SMTP id qw3-20020a1709066a0300b00a4e279fab2cmr2058442ejc.12.1712134899681;
        Wed, 03 Apr 2024 02:01:39 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id eb16-20020a170907281000b00a4e0df9e793sm7509361ejc.136.2024.04.03.02.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 02:01:39 -0700 (PDT)
Date: Wed, 3 Apr 2024 12:01:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] proc: rewrite stable_page_flags()
Message-ID: <1a6dc6a5-b5b6-494c-b94b-f6655da51bb9@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Matthew Wilcox (Oracle),

Commit ea1be2228bb6 ("proc: rewrite stable_page_flags()") from Mar
26, 2024 (linux-next), leads to the following Smatch static checker
warning:

fs/proc/page.c:156 stable_page_flags() warn: bit shifter 'PG_lru' used for logical '&'
fs/proc/page.c:207 stable_page_flags() warn: bit shifter 'KPF_HUGE' used for logical '&'

fs/proc/page.c
    110 u64 stable_page_flags(const struct page *page)
    111 {
    112         const struct folio *folio;
    113         unsigned long k;
    114         unsigned long mapping;
    115         bool is_anon;
    116         u64 u = 0;
    117 
    118         /*
    119          * pseudo flag: KPF_NOPAGE
    120          * it differentiates a memory hole from a page with no flags
    121          */
    122         if (!page)
    123                 return 1 << KPF_NOPAGE;
    124         folio = page_folio(page);
    125 
    126         k = folio->flags;
    127         mapping = (unsigned long)folio->mapping;
    128         is_anon = mapping & PAGE_MAPPING_ANON;
    129 
    130         /*
    131          * pseudo flags for the well known (anonymous) memory mapped pages
    132          */
    133         if (page_mapped(page))
    134                 u |= 1 << KPF_MMAP;
    135         if (is_anon) {
    136                 u |= 1 << KPF_ANON;
    137                 if (mapping & PAGE_MAPPING_KSM)
    138                         u |= 1 << KPF_KSM;
    139         }
    140 
    141         /*
    142          * compound pages: export both head/tail info
    143          * they together define a compound page's start/end pos and order
    144          */
    145         if (page == &folio->page)
    146                 u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
    147         else
    148                 u |= 1 << KPF_COMPOUND_TAIL;
    149         if (folio_test_hugetlb(folio))
    150                 u |= 1 << KPF_HUGE;
                             ^^^^^^^^^^^^^
Here KPF_HUGE is a shifter

    151         /*
    152          * We need to check PageLRU/PageAnon
    153          * to make sure a given page is a thp, not a non-huge compound page.
    154          */
    155         else if (folio_test_large(folio)) {
--> 156                 if ((k & PG_lru) || is_anon)
                             ^^^^^^^^^^
The PG_lru enum isn't used consistently.  Should this be?:

	if ((k & (1 << PG_lru)) || ...


    157                         u |= 1 << KPF_THP;
    158                 else if (is_huge_zero_folio(folio)) {
    159                         u |= 1 << KPF_ZERO_PAGE;
    160                         u |= 1 << KPF_THP;
    161                 }
    162         } else if (is_zero_pfn(page_to_pfn(page)))
    163                 u |= 1 << KPF_ZERO_PAGE;
    164 
    165         /*
    166          * Caveats on high order pages: PG_buddy and PG_slab will only be set
    167          * on the head page.
    168          */
    169         if (PageBuddy(page))
    170                 u |= 1 << KPF_BUDDY;
    171         else if (page_count(page) == 0 && is_free_buddy_page(page))
    172                 u |= 1 << KPF_BUDDY;
    173 
    174         if (PageOffline(page))
    175                 u |= 1 << KPF_OFFLINE;
    176         if (PageTable(page))
    177                 u |= 1 << KPF_PGTABLE;
    178 
    179 #if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
    180         u |= kpf_copy_bit(k, KPF_IDLE,          PG_idle);
    181 #else
    182         if (folio_test_idle(folio))
    183                 u |= 1 << KPF_IDLE;
    184 #endif
    185 
    186         u |= kpf_copy_bit(k, KPF_LOCKED,        PG_locked);
    187         u |= kpf_copy_bit(k, KPF_SLAB,                PG_slab);
    188         u |= kpf_copy_bit(k, KPF_ERROR,                PG_error);
    189         u |= kpf_copy_bit(k, KPF_DIRTY,                PG_dirty);
    190         u |= kpf_copy_bit(k, KPF_UPTODATE,        PG_uptodate);
    191         u |= kpf_copy_bit(k, KPF_WRITEBACK,        PG_writeback);
    192 
    193         u |= kpf_copy_bit(k, KPF_LRU,                PG_lru);
    194         u |= kpf_copy_bit(k, KPF_REFERENCED,        PG_referenced);
    195         u |= kpf_copy_bit(k, KPF_ACTIVE,        PG_active);
    196         u |= kpf_copy_bit(k, KPF_RECLAIM,        PG_reclaim);
    197 
    198 #define SWAPCACHE ((1 << PG_swapbacked) | (1 << PG_swapcache))
    199         if ((k & SWAPCACHE) == SWAPCACHE)
    200                 u |= 1 << KPF_SWAPCACHE;
    201         u |= kpf_copy_bit(k, KPF_SWAPBACKED,        PG_swapbacked);
    202 
    203         u |= kpf_copy_bit(k, KPF_UNEVICTABLE,        PG_unevictable);
    204         u |= kpf_copy_bit(k, KPF_MLOCKED,        PG_mlocked);
    205 
    206 #ifdef CONFIG_MEMORY_FAILURE
    207         if (u & KPF_HUGE)
                    ^^^^^^^^^^^^
Here it is a mask.

    208                 u |= kpf_copy_bit(k, KPF_HWPOISON,        PG_hwpoison);
    209         else
    210                 u |= kpf_copy_bit(page->flags, KPF_HWPOISON,        PG_hwpoison);
    211 #endif
    212 
    213 #ifdef CONFIG_ARCH_USES_PG_UNCACHED
    214         u |= kpf_copy_bit(k, KPF_UNCACHED,        PG_uncached);
    215 #endif
    216 
    217         u |= kpf_copy_bit(k, KPF_RESERVED,        PG_reserved);
    218         u |= kpf_copy_bit(k, KPF_MAPPEDTODISK,        PG_mappedtodisk);
    219         u |= kpf_copy_bit(k, KPF_PRIVATE,        PG_private);
    220         u |= kpf_copy_bit(k, KPF_PRIVATE_2,        PG_private_2);
    221         u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,        PG_owner_priv_1);
    222         u |= kpf_copy_bit(k, KPF_ARCH,                PG_arch_1);
    223 #ifdef CONFIG_ARCH_USES_PG_ARCH_X
    224         u |= kpf_copy_bit(k, KPF_ARCH_2,        PG_arch_2);
    225         u |= kpf_copy_bit(k, KPF_ARCH_3,        PG_arch_3);
    226 #endif
    227 
    228         return u;
    229 };

regards,
dan carpenter

