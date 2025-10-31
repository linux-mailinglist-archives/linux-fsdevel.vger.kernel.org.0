Return-Path: <linux-fsdevel+bounces-66546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B66C2314A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 03:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD9BB34F7FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 02:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9A530DEA7;
	Fri, 31 Oct 2025 02:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUKSpV+A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F048D30C63A
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 02:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879356; cv=none; b=HtdIzioXeNMBnuiYezUA3iUMd1OqgZiNJz/238rUVEo3vM/HA6Nl19wKQ0PO6kzHC36RJ7y8tFvEu0kpmxKBfSR2oG9QgGjWs1wwG+UlondJKQ83Kx1UpvyCzS8biPxQFkAQcnSDJCO3ibHPwn2Q/3NU3ZAbYObCA6dtHJDt9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879356; c=relaxed/simple;
	bh=35IxH3AVqIfszjuIBMqHIXPBco12DNO3hgOgY8U+IZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXK0GjmNAlRIRx7VPofQmaX2I7zxqbd3ECU7wJhq8KoHrQ5EhhUMZ1A5IxX+Ok9Ymv+NICdLtxAo/0oT1w74nO1Vaec1qdK2rMlIgYnfcw4f4VaRLMdwHlsZUbHb3w1Lunyb+I2COyon6cuYOmPrADpgarp86NpyW4jqBQ23xds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUKSpV+A; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d70df0851so362768166b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 19:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761879353; x=1762484153; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbb+HtAkz5E08qbbx7069G9TclCwWAydoNERXltG7Jo=;
        b=SUKSpV+An5JSUBKscu1wjho+soc8GgEgqx6fvdHdzodN5+9H9hUeqyt3WIZOKE2u/v
         fKjmkMROf3QduSKuo/t3i1I4EAij19g3XkdJw3c/hBQPyOGHSecwutAv4KD9ba7Mv2cS
         7x9BwI3mP1gEUTXPod50HuwSlcheiGh9RSAlWowCIFTkbk2Oza/sg/0VDuLVfSDnZfUt
         5m/qWZ5GSfkT8jR62GAfyITZ9/t19429B3YTzZS30Pdx9492WKOIhDi9YNhmomccnxH8
         cgORH0ya+pKllOSDnyf+7uuDLyQdA506b/OdWf6kVHUnOQ9S5/LhKA9SaBaYlp4npdn9
         lDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761879353; x=1762484153;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dbb+HtAkz5E08qbbx7069G9TclCwWAydoNERXltG7Jo=;
        b=LmDuE6g+Rq8xAIVD7zRxDRkjluEPYrimxK3Mw2Egn2hFyJiKPt7BM8qAU4cQC/tgsA
         9ivekF5JxopznNOgvCNHjAapU/J0h8SJF7B/bIxJY8pcS/Ph7WQ5tlE9yDT/oVsmDmcI
         TJSvMkUaGmMkzLv3dtTc5TDXkTIDI7/VN7HeKMoa2AjyzzRWcEVtiLdumlQThQ10mZUH
         vSuyhe+0GzhAZpf3DyKMmAcvjzKXXtSI6IT3LZ+3i2B71VrQSlsk43H6Ey1sr2eaY3A6
         T8CN7YjVhQKvZJohITkJC0jrNfqdFaRtbNLZ9EjoqyzBh4alkZt1u8Od/7nv2FRi6U4N
         wWeg==
X-Forwarded-Encrypted: i=1; AJvYcCV1kdkLAlVgfWcYY+WiZeA7ddJGjjP2As/u/kVDoyOYpLc4dPfzVFrN9cy3Yo90oxIEZn+TV6zaRQMnmdAb@vger.kernel.org
X-Gm-Message-State: AOJu0YzxvOhZv0PkPxqGunLWavYqB3hg7jWKjt7OcISc25l0akN2hSXm
	YXSTRpJ3wKrhxccEePtBtKXCKIlWmRQUy/u3zwtHueKd9AlrcNDidHkZ
X-Gm-Gg: ASbGnctZJH4ZvT2T5AIyD9LzXfBRghYH/Us86mgdCmVpfRnK+B60nWYt1xXpzJuHYsR
	H523rFPWzqFZog6VJBD4dBHSbTV+5g4N4iD3lPHyT1cspAyQM8DpgFLJOE9VzACuVQTKsR3pxcK
	XIpsRrdndLNFgYcmZZStB/XeOj70m7gY9dQeiVHrAiQSIlNElBQAistjlmkdX8W42PCae/w0u2O
	dK4kLHSgXf6ZFgJ8fi423CJGcgYsnFQctP/0Cd+PRDw4ofwZzjEFniLpHXb5YHTLTJeW3T4IffF
	6UQt1YwydliokelmK4OqB6RYy8oKs8D3jnfiVWW/r3W5ek6Ef+AX+pWWxtY5vquV+Hns3UhC9Li
	Qy04G5dPeo7vh0Nam1WwTEER2KiUKXvTP0J4NTDxM98YJprolw5hVEWlFAuimzyCyaUY0BD4QcX
	k=
X-Google-Smtp-Source: AGHT+IFaVEZlf1vH3SzuCruGg4BO7/3SvDRPUOGQR9RtSR34EJQMmXJ0JlLsI6L2lpx3vT3NXuIEKA==
X-Received: by 2002:a17:907:3f13:b0:b0e:d477:4972 with SMTP id a640c23a62f3a-b707019d264mr198901366b.25.1761879353147;
        Thu, 30 Oct 2025 19:55:53 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077cd2d48sm48761266b.60.2025.10.30.19.55.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Oct 2025 19:55:52 -0700 (PDT)
Date: Fri, 31 Oct 2025 02:55:51 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
	kernel@pankajraghav.com, akpm@linux-foundation.org,
	mcgrof@kernel.org, nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Yang Shi <shy828301@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 3/3] mm/huge_memory: fix kernel-doc comments for
 folio_split() and related.
Message-ID: <20251031025551.bmt4wh6e6tmhcr4i@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251030014020.475659-1-ziy@nvidia.com>
 <20251030014020.475659-4-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030014020.475659-4-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 29, 2025 at 09:40:20PM -0400, Zi Yan wrote:
>try_folio_split_to_order(), folio_split, __folio_split(), and
>__split_unmapped_folio() do not have correct kernel-doc comment format.
>Fix them.
>
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Acked-by: David Hildenbrand <david@redhat.com>

Generally looks good, while some nit below.

>---
> include/linux/huge_mm.h | 10 ++++++----
> mm/huge_memory.c        | 27 +++++++++++++++------------
> 2 files changed, 21 insertions(+), 16 deletions(-)
>
>diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>index 34f8d8453bf3..cbb2243f8e56 100644
>--- a/include/linux/huge_mm.h
>+++ b/include/linux/huge_mm.h
>@@ -386,9 +386,9 @@ static inline int split_huge_page_to_order(struct page *page, unsigned int new_o
> 	return split_huge_page_to_list_to_order(page, NULL, new_order);
> }
> 
>-/*
>- * try_folio_split_to_order - try to split a @folio at @page to @new_order using
>- * non uniform split.
>+/**
>+ * try_folio_split_to_order() - try to split a @folio at @page to @new_order
>+ * using non uniform split.

This looks try_folio_split_to_order() only perform non uniform split, while the
following comment mentions it will try uniform split if non uniform split is
not supported. 

Do you think this is a little confusing?

>  * @folio: folio to be split
>  * @page: split to @new_order at the given page
>  * @new_order: the target split order
>@@ -398,7 +398,7 @@ static inline int split_huge_page_to_order(struct page *page, unsigned int new_o
>  * folios are put back to LRU list. Use min_order_for_split() to get the lower
>  * bound of @new_order.
>  *
>- * Return: 0: split is successful, otherwise split failed.
>+ * Return: 0 - split is successful, otherwise split failed.
>  */
> static inline int try_folio_split_to_order(struct folio *folio,
> 		struct page *page, unsigned int new_order)
>@@ -486,6 +486,8 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
> /**
>  * folio_test_pmd_mappable - Can we map this folio with a PMD?
>  * @folio: The folio to test
>+ *
>+ * Return: true - @folio can be mapped, false - @folio cannot be mapped.
>  */
> static inline bool folio_test_pmd_mappable(struct folio *folio)
> {
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index 0e24bb7e90d0..381a49c5ac3f 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -3567,8 +3567,9 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
> 		ClearPageCompound(&folio->page);
> }
> 
>-/*
>- * It splits an unmapped @folio to lower order smaller folios in two ways.
>+/**
>+ * __split_unmapped_folio() - splits an unmapped @folio to lower order folios in
>+ * two ways: uniform split or non-uniform split.
>  * @folio: the to-be-split folio
>  * @new_order: the smallest order of the after split folios (since buddy
>  *             allocator like split generates folios with orders from @folio's

In the comment of __split_unmapped_folio(), we have some description about the
split behavior, e.g. update stat, unfreeze.

Is this out-dated?

-- 
Wei Yang
Help you, Help me

