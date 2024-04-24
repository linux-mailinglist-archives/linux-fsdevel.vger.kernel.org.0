Return-Path: <linux-fsdevel+bounces-17618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B508B062C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 11:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71C41C22885
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 09:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59977158DBA;
	Wed, 24 Apr 2024 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+CtAgPq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534DB158D9B
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 09:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951541; cv=none; b=GcJJr3ny64C687m3/HnsSquWDjkhCL4iLjlAa8qZnACKngsCz6SWmXuoNcwqotwCP/aVWDFw7X5ydPvsz/lVxiB2uk7ADWG1+7pmFJUedjWV+bY85Di0d5Bcu76Gl0AGByJpcy5WuTALRz91GRC1Am4wLpXaAlJgLz/K2nPxCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951541; c=relaxed/simple;
	bh=qc5CL3S71giAfySYaTVkfk5wuylLzDuZV+KpRU+IQUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VS9ZDACqzTczcGjaNIrpODKBs7sX66IoRjToNnFOCrby39DL8ailcSz7KQp6YaJ8qN5VJ57JmjnZrJpytBv0cBJW98HMpW9OGcLXZw+l7NlffhZ+pgsFOWlSWRt011ge6zAIL2XjlzQNy/twoF2HK7a/LMeJ/IJcpVZ1ZJjAuEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+CtAgPq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713951539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZUMWB0R88eBXuTxuh6JHDZn3KqkUsFmowtEVe2WSZFc=;
	b=W+CtAgPqdQKDRzXXsigA1RyiW3nvYSCCh4kv1+wFdKQpq1wVB6IPsaD5Q4JJUmQueeEamH
	tNsQfLqWR6deQIuEqYv/BDyfVJocRYg+XEhW9C64cRxjvUZyr6PHUKOUbT5WKlbcu0BWqv
	5VzJiFzDBxcX8AX8xTrHf6P8frYhpg0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-9crNMU02NHmJahcZ-aeWpg-1; Wed, 24 Apr 2024 05:38:55 -0400
X-MC-Unique: 9crNMU02NHmJahcZ-aeWpg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41a370b6acdso13635145e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 02:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713951534; x=1714556334;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZUMWB0R88eBXuTxuh6JHDZn3KqkUsFmowtEVe2WSZFc=;
        b=Q4yR904xvhnDyZgTLDliXK2TxctQqfwr6DHwvnZQISqYYScvE9D45Obm8FGKUxqfPY
         LJd4gaJOMjrJjvLZdGbckP6xt8MKKqiHPOJsqBST9EREBot2S9sJSwpVEpsYN5683osh
         t157pkIHL65hy99kSThTtp7SO2TJjNKLgCfmw0kQ8EmqywGnClWt5fCXfhkwTNQAm/Z7
         cZGTxT+WKoSYtg93nMDzP505ELZvu+xsuqd0QHdzOrv1Wuhnq683ue/hVGlgIBDXgHuz
         CNhvTRcYvTmvXS8oC4El5oE1IA8+jSLusVKluvddK6oRGPDmB2wugK5MCBMQPyDxbkQh
         mvSw==
X-Forwarded-Encrypted: i=1; AJvYcCVDv5FAAeLdl9KXMYzt299IQt6rtfxGuaRONpOqu+cW1wQPzOw7zu2SOuRS8fSbpyVoU0U4Pk1HfTq4xwcYGkjI0zjpjAPlwnTzYbhBrQ==
X-Gm-Message-State: AOJu0YwBvkJJ5v7DRAmld7q4lN+luJ5rh9tuftEUdz4Id3gEqsciI/zh
	qTMm1c5EYSyoGao12dgdfU0D6i6t02t2g3mXnaBTCEI5Ko+DXnjrg10JrW3xk5dL3Y1W4NTMxdd
	mKa3abZkEBhWBA8AFibZ4DFWTQMUhMzfD2jNg47OJhflMii/xVZPk5hgSLIwwLKM=
X-Received: by 2002:a05:600c:4ed4:b0:419:e25e:ef62 with SMTP id g20-20020a05600c4ed400b00419e25eef62mr1269877wmq.40.1713951534209;
        Wed, 24 Apr 2024 02:38:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm4M1VwrMlxKqcBLI0bDh8kyh4Nz7qvnr7GQWuHTSSZ/9CIqCuVx+jkSRRpDzKruNuXlPp3g==
X-Received: by 2002:a05:600c:4ed4:b0:419:e25e:ef62 with SMTP id g20-20020a05600c4ed400b00419e25eef62mr1269861wmq.40.1713951533808;
        Wed, 24 Apr 2024 02:38:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:1f00:7a4e:8f21:98db:baef? (p200300cbc70d1f007a4e8f2198dbbaef.dip0.t-ipconnect.de. [2003:cb:c70d:1f00:7a4e:8f21:98db:baef])
        by smtp.gmail.com with ESMTPSA id bi12-20020a05600c3d8c00b0041a959036f2sm7117510wmb.43.2024.04.24.02.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 02:38:53 -0700 (PDT)
Message-ID: <1af4fd61-7926-47c8-be45-833c0dbec08b@redhat.com>
Date: Wed, 24 Apr 2024 11:38:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/18] mm: allow for detecting underflows with
 page_mapcount() again
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Peter Xu
 <peterx@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Yang Shi <shy828301@gmail.com>,
 Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Hugh Dickins <hughd@google.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Muchun Song <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <naoya.horiguchi@nec.com>,
 Richard Chang <richardycc@google.com>
References: <20240409192301.907377-1-david@redhat.com>
 <20240409192301.907377-2-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240409192301.907377-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.04.24 21:22, David Hildenbrand wrote:
> Commit 53277bcf126d ("mm: support page_mapcount() on page_has_type()
> pages") made it impossible to detect mapcount underflows by treating
> any negative raw mapcount value as a mapcount of 0.
> 
> We perform such underflow checks in zap_present_folio_ptes() and
> zap_huge_pmd(), which would currently no longer trigger.
> 
> Let's check against PAGE_MAPCOUNT_RESERVE instead by using
> page_type_has_type(), like page_has_type() would, so we can still catch
> some underflows.
> 
> Fixes: 53277bcf126d ("mm: support page_mapcount() on page_has_type() pages")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/mm.h | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ef34cf54c14f..0fb8a40f82dd 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1229,11 +1229,10 @@ static inline void page_mapcount_reset(struct page *page)
>    */
>   static inline int page_mapcount(struct page *page)
>   {
> -	int mapcount = atomic_read(&page->_mapcount) + 1;
> +	int mapcount = atomic_read(&page->_mapcount);
>   
>   	/* Handle page_has_type() pages */
> -	if (mapcount < 0)
> -		mapcount = 0;
> +	mapcount = page_type_has_type(mapcount) ? 0 : mapcount + 1;
>   	if (unlikely(PageCompound(page)))
>   		mapcount += folio_entire_mapcount(page_folio(page));
>   

 From b49849001f3d2aad0af93cf2098065d7cbd9a959 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 24 Apr 2024 10:50:09 +0200
Subject: [PATCH] !fixup: mm: allow for detecting underflows with
  page_mapcount() again

Let's make page_mapcount() slighly more efficient by inlining the
page_type_has_type() check.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  include/linux/mm.h | 5 +++--
  1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc33f8269fb52..cf700c5cdd58b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1229,10 +1229,11 @@ static inline void page_mapcount_reset(struct page *page)
   */
  static inline int page_mapcount(struct page *page)
  {
-	int mapcount = atomic_read(&page->_mapcount);
+	int mapcount = atomic_read(&page->_mapcount) + 1;
  
  	/* Handle page_has_type() pages */
-	mapcount = page_type_has_type(mapcount) ? 0 : mapcount + 1;
+	if (mapcount < PAGE_MAPCOUNT_RESERVE + 1)
+		mapcount = 0;
  	if (unlikely(PageCompound(page)))
  		mapcount += folio_entire_mapcount(page_folio(page));
  
-- 
2.44.0


-- 
Cheers,

David / dhildenb


