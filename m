Return-Path: <linux-fsdevel+bounces-53329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624C6AEDC48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 14:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2EF3BA517
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 12:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E0E289E23;
	Mon, 30 Jun 2025 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXHClFS8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D01289838
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285275; cv=none; b=n4mDOVzveVFPTYMYhldNoqKvqKohyRuuIv/jovd9eR5tBjiMlS3ZTfUZxZsfB+OqYwZb/ZeHBJPNCfH/iyevxklUyBHDTcJUQp8a8s5TCxQIGPSCmcqzF9VfMaqQhiHlKFMnon+E1Cfi+VgG712NHZvlDR2fEOTnvxRko7NZ3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285275; c=relaxed/simple;
	bh=PPaBzak0+RimE+PKgsUHprexdhld3hxuOjOLlm3rLvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnRr/fdGOo+WvoW07yjWN9M41uY7EpSGgV7bRLLg+IBs5/LJWimk0Z3vz4roflbjde4wfRBYeDQCdyIS+H/R4XLyX/ildY0A6CTzMK/NB2F/3Sc3OWr5xcwCr07ZKWz6I/siKzDn7AFaq72LziEMtaagj40K8Yu6O0DmVhibBmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fXHClFS8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751285272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Op50PqPeT0HmpJeycMvUHdwxGaCisgrxovBuhS5pGjg=;
	b=fXHClFS8LdHAfBHZ1kVXPfU6q2FTRrhgVJ2SnpdomHTX7ZkV7J07zMQzVH05L2D/6PVQSn
	svP9AP1CU347X6AT753lbPHiqluhS2EXurymcOJz6rSws42cDQDjyl6Ln9+OjyhUDWrl+z
	HKF9Wm2Nle0CWVVv5Th944by2sdZMfo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-xr6PsEdtPTmngUjS4gN8dw-1; Mon, 30 Jun 2025 08:07:51 -0400
X-MC-Unique: xr6PsEdtPTmngUjS4gN8dw-1
X-Mimecast-MFC-AGG-ID: xr6PsEdtPTmngUjS4gN8dw_1751285270
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4532ff43376so18233895e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 05:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751285270; x=1751890070;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Op50PqPeT0HmpJeycMvUHdwxGaCisgrxovBuhS5pGjg=;
        b=aWzQLNeHpipZzfeJXJ20mTpalxdK0qeVDWwEtRhUOXSStK7ujDJ20MjS2rjiFDq0/m
         DlShw5Mar4d3gT0ADcgI5Cnc5AfxB9ATqn6cm6dE53fSuOweE2H8XviS9SW88GUtnhom
         hsFXnu1ewjP49Gl2muaKtyOcXs2zx5EiDjcL2QhXDWjIZFmCy5A4mSQo5DOKqmy5KRVR
         d6JPzPBMb5LYGqeZTLUhm9losV9u6bEPdNM5qUka9m56mZ+Ae2bXLwPNVh3EDbsxOk8/
         x22mMNvCC5qY7QTiuD3/f+CYbj6odxtTN7bj6Yu3FQ0ZHtKkWNnwKtkdZ60/f/eLkVjh
         YS3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiVcGJ3C/DdKMeogmZx4loL02l7BJKHj2bjchugEcx6F/oyYHgU28KaFHzUAiDIUfjd6RSfy67hg5NKcqL@vger.kernel.org
X-Gm-Message-State: AOJu0YxPEbybJgSOVPsMzk9ZUvPK0esLM39vJ3dwRgwUdzo2GRgrgbvP
	mrukCcvXzsMygmxNSvZ9QKo69GeHm8vd5WdjLggf/1THxLoUMfUWfllugXqEoWutiHE8XbCsk8b
	rY00BUUQgCp2PDciA2b+NJJhA1gCIhhXhNDQYoE5bHVDzbDiSaBtMaf8nKXl3pTAGG/w=
X-Gm-Gg: ASbGncsxc28PBo2XmisSCbw5ENdbbPAJQJtVf7rEaXpsIGGpDo6K7p/IiVr2Olhln2C
	guAyr7fCvjl65FpnokBNrgPd+fpTdPwmbHHer/rX++pjtagUHsDnhVjpUrXpshBBlLB5a8w7Fnj
	Jq7HtQ27U6Pw1mgteRY+ID4oPKBuernBBeAEFhWtUje//iFL4EnFyNtYkps2MKxn3CWKXhv+v9Y
	wq3fURXMr1Vx/OHLFg7Lg1rrZV7mhKQJuPTYsb+ZmneAxk99IM7oqGpt9I8N55fM3UsskudAbIG
	L1Xc+XYrSKDaWUtn37jt69nWpdtz2D9MKsb1NLdEMjv8pKj5FlwRIhcr/bt0sGZ+jTWqjAwyWgX
	yhge6xAsO04tWJi6ky+71DmtTSBa+2qKwpscfM3+u2prhhj2H2g==
X-Received: by 2002:a05:600c:608a:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-4538ee4f7c2mr121744215e9.7.1751285269725;
        Mon, 30 Jun 2025 05:07:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWCKm3o+0u7J/9o+MJEl+ALenW0yv9KxJ4HHuTU2e7vVeBpaNUvnmxNrecr9Wrf8EXQo2MMg==
X-Received: by 2002:a05:600c:608a:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-4538ee4f7c2mr121743605e9.7.1751285269149;
        Mon, 30 Jun 2025 05:07:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f40:b300:53f7:d260:aff4:7256? (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c0812sm162261985e9.34.2025.06.30.05.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 05:07:48 -0700 (PDT)
Message-ID: <c08d13ba-d199-4a9a-8be2-56074fac3f74@redhat.com>
Date: Mon, 30 Jun 2025 14:07:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 11/29] mm/migrate: move movable_ops page handling out
 of move_to_new_folio()
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-12-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250618174014.1168640-12-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.06.25 19:39, David Hildenbrand wrote:
> Let's move that handling directly into migrate_folio_move(), so we can
> simplify move_to_new_folio(). While at it, fixup the documentation a
> bit.
> 
> Note that unmap_and_move_huge_page() does not care, because it only
> deals with actual folios. (we only support migration of
> individual movable_ops pages)
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/migrate.c | 61 ++++++++++++++++++++++++----------------------------
>   1 file changed, 28 insertions(+), 33 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 456e41dad83a2..db807f9bbf975 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1024,11 +1024,12 @@ static int fallback_migrate_folio(struct address_space *mapping,
>   }
>   
>   /*
> - * Move a page to a newly allocated page
> - * The page is locked and all ptes have been successfully removed.
> + * Move a src folio to a newly allocated dst folio.
>    *
> - * The new page will have replaced the old page if this function
> - * is successful.
> + * The src and dst folios are locked and the src folios was unmapped from
> + * the page tables.
> + *
> + * On success, the src folio was replaced by the dst folio.
>    *
>    * Return value:
>    *   < 0 - error code
> @@ -1037,34 +1038,30 @@ static int fallback_migrate_folio(struct address_space *mapping,
>   static int move_to_new_folio(struct folio *dst, struct folio *src,
>   				enum migrate_mode mode)
>   {
> +	struct address_space *mapping = folio_mapping(src);
>   	int rc = -EAGAIN;
> -	bool is_lru = !__folio_test_movable(src);
>   
>   	VM_BUG_ON_FOLIO(!folio_test_locked(src), src);
>   	VM_BUG_ON_FOLIO(!folio_test_locked(dst), dst);
>   
> -	if (likely(is_lru)) {
> -		struct address_space *mapping = folio_mapping(src);
> -
> -		if (!mapping)
> -			rc = migrate_folio(mapping, dst, src, mode);
> -		else if (mapping_inaccessible(mapping))
> -			rc = -EOPNOTSUPP;
> -		else if (mapping->a_ops->migrate_folio)
> -			/*
> -			 * Most folios have a mapping and most filesystems
> -			 * provide a migrate_folio callback. Anonymous folios
> -			 * are part of swap space which also has its own
> -			 * migrate_folio callback. This is the most common path
> -			 * for page migration.
> -			 */
> -			rc = mapping->a_ops->migrate_folio(mapping, dst, src,
> -								mode);
> -		else
> -			rc = fallback_migrate_folio(mapping, dst, src, mode);
> +	if (!mapping)
> +		rc = migrate_folio(mapping, dst, src, mode);
> +	else if (mapping_inaccessible(mapping))
> +		rc = -EOPNOTSUPP;
> +	else if (mapping->a_ops->migrate_folio)
> +		/*
> +		 * Most folios have a mapping and most filesystems
> +		 * provide a migrate_folio callback. Anonymous folios
> +		 * are part of swap space which also has its own
> +		 * migrate_folio callback. This is the most common path
> +		 * for page migration.
> +		 */
> +		rc = mapping->a_ops->migrate_folio(mapping, dst, src,
> +							mode);
> +	else
> +		rc = fallback_migrate_folio(mapping, dst, src, mode);
>   
> -		if (rc != MIGRATEPAGE_SUCCESS)
> -			goto out;
> +	if (rc == MIGRATEPAGE_SUCCESS) {
>   		/*
>   		 * For pagecache folios, src->mapping must be cleared before src
>   		 * is freed. Anonymous folios must stay anonymous until freed.
> @@ -1074,10 +1071,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
>   
>   		if (likely(!folio_is_zone_device(dst)))
>   			flush_dcache_folio(dst);
> -	} else {
> -		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
>   	}
> -out:
>   	return rc;
>   }
>   
> @@ -1328,20 +1322,21 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>   	int rc;
>   	int old_page_state = 0;
>   	struct anon_vma *anon_vma = NULL;
> -	bool is_lru = !__folio_test_movable(src);
>   	struct list_head *prev;
>   
>   	__migrate_folio_extract(dst, &old_page_state, &anon_vma);
>   	prev = dst->lru.prev;
>   	list_del(&dst->lru);
>   
> +	if (unlikely(__folio_test_movable(src))) {
> +		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
> +		goto out_unlock_both;
> +	}
> +


I suspect this was the issue I was chasing:

diff --git a/mm/migrate.c b/mm/migrate.c
index 9dd327a63abc5..22c115710d0e2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1330,6 +1330,8 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
  
         if (unlikely(__folio_test_movable(src))) {
                 rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
+               if (rc)
+                       goto out;
                 goto out_unlock_both;
         }
  

Testing ...

-- 
Cheers,

David / dhildenb


