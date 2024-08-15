Return-Path: <linux-fsdevel+bounces-26053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB5A952C93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B5CB297A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807461C9EB5;
	Thu, 15 Aug 2024 10:04:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4191AC8BC;
	Thu, 15 Aug 2024 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716276; cv=none; b=GUwmGZnSq7Hcotq5+MMp3EGcwjPYeFdUEwR1Omz+DWWvq7IV38bRFHxGJlEZL3B7jju5W5vZtF5vU5E7T6jc5ykA+NdATKLFpKLd0wOao867+a84+tRdudYdiHD6eO0YT+YvAd7CrBRdGti6n49/roRuvUTWA5fYxceQ8rnu2So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716276; c=relaxed/simple;
	bh=LMI9zugfdC8nxqWGFsq56iMeNYCzn8+Pg1VGDx+73zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Loog+qfUCdOTw91ErYMAI6N5OLXG+ogUjuWNpN9Xs2K3Pme3Je0e45bX6LAl23s4xBHYVMwjYGJ+pQWJ0iYxrO4rF0sm0wKqXUy19SBgfUDnFTnZFJjJMC+qcjrW3z3dT3DW1FKSsE/B0mdmREwZOeVs7vERmTIB+0vTIw6GJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Wl11n6qm7z9sRJ;
	Thu, 15 Aug 2024 12:04:29 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: david@redhat.com
Cc: agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	borntraeger@linux.ibm.com,
	corbet@lwn.net,
	frankja@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	imbrenda@linux.ibm.com,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	svens@linux.ibm.com,
	willy@infradead.org
Subject: Re: [PATCH v1 07/11] mm/huge_memory: convert split_huge_pages_pid() from follow_page() to folio_walk
Date: Thu, 15 Aug 2024 12:04:23 +0200
Message-ID: <20240815100423.974775-1-p.raghav@samsung.com>
In-Reply-To: <20240802155524.517137-8-david@redhat.com>
References: <20240802155524.517137-8-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Wl11n6qm7z9sRJ

Hi David,

On Fri, Aug 02, 2024 at 05:55:20PM +0200, David Hildenbrand wrote:
>  			continue;
>  		}
>  
> -		/* FOLL_DUMP to ignore special (like zero) pages */
> -		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
> -
> -		if (IS_ERR_OR_NULL(page))
> +		folio = folio_walk_start(&fw, vma, addr, 0);
> +		if (!folio)
>  			continue;
>  
> -		folio = page_folio(page);
>  		if (!is_transparent_hugepage(folio))
>  			goto next;
>  
> @@ -3544,13 +3542,19 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>  
>  		if (!folio_trylock(folio))
>  			goto next;
> +		folio_get(folio);

Shouldn't we lock the folio after we increase the refcount on the folio?
i.e we do folio_get() first and then folio_trylock()?

That is how it was done before (through follow_page) and this patch changes
that. Maybe it doesn't matter? To me increasing the refcount and then
locking sounds more logical but I do see this ordering getting mixed all
over the kernel.

> +		folio_walk_end(&fw, vma);
>  
>  		if (!split_folio_to_order(folio, new_order))
>  			split++;
>  
>  		folio_unlock(folio);
> -next:
>  		folio_put(folio);
> +
> +		cond_resched();
> +		continue;
> +next:
> +		folio_walk_end(&fw, vma);
>  		cond_resched();
>  	}
>  	mmap_read_unlock(mm);
> -- 
> 2.45.2

-- 
Pankaj Raghav


