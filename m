Return-Path: <linux-fsdevel+bounces-16442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE11A89DACF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B8AB226C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7CA12FB15;
	Tue,  9 Apr 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dulfp2Et"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3A212FB25
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669982; cv=none; b=H1Nc44NGD4cvRcJctlMXBf0aMbdwXmHLuJVI4MvpEc8AKCAtW9DLNnbBL36Nw3hmJpvsiOQVglxaDmGqF7A6krYW3tw8yOdT5TL2wd+SmwNYqN39BpBO8PZn1oZGtsQNzyT7/hG6YpY4Gtv7uHIaF1+is6Zo+9JdEJyR/dHKWc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669982; c=relaxed/simple;
	bh=HNH3yn3ma3Z3TimaUKhxAREEHz+dwtR+taH4Sq4L344=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6rMHj8fQD5GbjFCSbb86MLM60KuPSE46Sdtu/Y2oUwTM1QhIBrOAKxbeeUON6YO/1ClsClJ4cP/QIpg+HHH7vFVy6yCGCGJihTEs/dyL6XzX44bPSEC6xHOo/TaszW804B31VUhZAFfnvnrsgVaSawJigL6cBWpiQmnae8JYl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dulfp2Et; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712669979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7/PnwX/P7cuzgGQPaLoiSR8a+Y/7EeOULG7uTkS8nhg=;
	b=dulfp2EtH7hnw+UE+FPfmS+Gj1rnvaMReTzbvAQeaMVvybmyHAOJnJEBAR5O8bHF3LvS3Z
	OLSz3fLUJ7ZMwQVOdsF9CFvqg6AtZFwuIqRqJB5Ru56Gd8CIsIJkrqZQw1KL98gimSSapP
	TMq0EcmleL1vrE84Dz9/o/1/x48IEI8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-FZtlKpYVPVensfin57QkWA-1; Tue, 09 Apr 2024 09:39:38 -0400
X-MC-Unique: FZtlKpYVPVensfin57QkWA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343e00c8979so2583897f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 06:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712669977; x=1713274777;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7/PnwX/P7cuzgGQPaLoiSR8a+Y/7EeOULG7uTkS8nhg=;
        b=EZbksIP1hkMyOllNfMGmwtRjAS96zzr0WYg2SZyNN+dUVWBJxRsS/pccSRnfBnZqwQ
         7AEzynCdxrnXaCt6GDkFZG+0/wtvzeW4cMwUEE4iB8Ww+LXXEHDA+IioDtP9Ir/24PI4
         Kl4X6tzsGXtwZVjVfooKxKiPLKOPuAnfOqi1/8UAOMc8mYxI9/bS2QaPnasrt/3aqw3d
         NS+MZFTQu+pYYZqcHLkqXqjpKsbMCuegz8d33GgR47dPRkzGfFsHbMBS7ahZNXsXIvYK
         HzwrhujEN1OAIltX27VCptmAJRlELhjh3jFknU5AvSe5iKO36ex91yq3pMrQgUQICAB0
         lXCA==
X-Forwarded-Encrypted: i=1; AJvYcCWqNSWK0sOnGPKmUkMw2PyDVMlYTts+ED343sP8YXKVgy3ALiZKwDLreirwtNTUToB2roXi5GOdT5Tc1ZZfEL8pV/AQQon3SeMcQDCo1g==
X-Gm-Message-State: AOJu0YxjTz41MRlcv0Dy5f1uxqWHuq5G5D/KvPQO/KQfZ6BEWY9hmLPX
	o5OxFt2FK5VwPUyWr9eEYamQTYxzBjB5M4kIOSTfh2sZv7uX8THz5v2SJg6JKP9fL+RctVxUXeX
	LuMcXi+9OKhupbuHpCIiGLxOneswEHvrWu6Eem8sWWPC0r1Xq5tv7M5fGudFHT0Q=
X-Received: by 2002:a5d:58cf:0:b0:33e:c389:69ff with SMTP id o15-20020a5d58cf000000b0033ec38969ffmr8604240wrf.68.1712669977287;
        Tue, 09 Apr 2024 06:39:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG33/5GMyzJ45fIAQhjWXdC6KRuDW/dQWems7MCHbqoigg+vO3je6/p2J0kpc3OPWlQX4rFdQ==
X-Received: by 2002:a5d:58cf:0:b0:33e:c389:69ff with SMTP id o15-20020a5d58cf000000b0033ec38969ffmr8604227wrf.68.1712669976836;
        Tue, 09 Apr 2024 06:39:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:be00:a285:bc76:307d:4eaa? (p200300cbc70abe00a285bc76307d4eaa.dip0.t-ipconnect.de. [2003:cb:c70a:be00:a285:bc76:307d:4eaa])
        by smtp.gmail.com with ESMTPSA id e27-20020a5d595b000000b003445bb2362esm8924396wri.65.2024.04.09.06.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 06:39:36 -0700 (PDT)
Message-ID: <eb153cdb-6228-435a-916a-77f4166d4cd2@redhat.com>
Date: Tue, 9 Apr 2024 15:39:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Convert pagecache_isize_extended to use a folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20240405180038.2618624-1-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240405180038.2618624-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.04.24 20:00, Matthew Wilcox (Oracle) wrote:
> Remove four hidden calls to compound_head().  Also exit early if the
> filesystem block size is >= PAGE_SIZE instead of just equal to PAGE_SIZE.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   mm/truncate.c | 36 +++++++++++++++++-------------------
>   1 file changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 725b150e47ac..e99085bf3d34 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -764,15 +764,15 @@ EXPORT_SYMBOL(truncate_setsize);
>    * @from:	original inode size
>    * @to:		new inode size
>    *
> - * Handle extension of inode size either caused by extending truncate or by
> - * write starting after current i_size. We mark the page straddling current
> - * i_size RO so that page_mkwrite() is called on the nearest write access to
> - * the page.  This way filesystem can be sure that page_mkwrite() is called on
> - * the page before user writes to the page via mmap after the i_size has been
> - * changed.
> + * Handle extension of inode size either caused by extending truncate or
> + * by write starting after current i_size.  We mark the page straddling
> + * current i_size RO so that page_mkwrite() is called on the first
> + * write access to the page.  The filesystem will update its per-block
> + * information before user writes to the page via mmap after the i_size
> + * has been changed.

Did you intend not to s/page/folio/ ?

>    *
>    * The function must be called after i_size is updated so that page fault
> - * coming after we unlock the page will already see the new i_size.
> + * coming after we unlock the folio will already see the new i_size.
>    * The function must be called while we still hold i_rwsem - this not only
>    * makes sure i_size is stable but also that userspace cannot observe new
>    * i_size value before we are prepared to store mmap writes at new inode size.
> @@ -781,31 +781,29 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


