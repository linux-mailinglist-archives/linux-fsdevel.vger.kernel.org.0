Return-Path: <linux-fsdevel+bounces-56500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1788B17BDA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 06:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792995A76ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 04:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8CE1E9B1A;
	Fri,  1 Aug 2025 04:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpKwrCgj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6F926ACB;
	Fri,  1 Aug 2025 04:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754022872; cv=none; b=huQ4uHfwMHSt4dwbIx5hHZGZKeSKmPkFrL+jS9ogLBaxQG4bwXwquaJOlkvRLKil+TnlVk7Fbqf63V0E/ISQOtt46OHMCm7+/U/pXrvmrhOTyVPSbVcnPlvRm2VTiDQ3v+kqIkfpF/RC0FSKtFqxV4EF5796Oxv+6GaBWATCMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754022872; c=relaxed/simple;
	bh=g54viIUtOxVSs1aexxwT6KRtQkgjFfpt8K6GqFRJV3E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=WX0Z2f789JF0PVugr0C0gYe9gn8OKCh5U0iJvRkgXrGM5nG1tqkpTZJXhQ2PonEwgVMPSzDYdboNBL3YrIddZBkNFy5g5+GxsSe4Fou0ugifsZxUFemL3D1vEUBuPsz/q8OyXdEouojYaFMG0owsr7J8hDFcUgOt0eJJgMP/rhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpKwrCgj; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so1258211a12.0;
        Thu, 31 Jul 2025 21:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754022870; x=1754627670; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hvy1+S1s4fKJdVyggMwF0uoMUuYMvpNuWclsNDW3SSw=;
        b=fpKwrCgjIl7+1FBNiFMScmYuQwACei0wX52ynPHnTUc45XWMsNZoDvvVI6sc+5eSfL
         VVwu+nE1Fe0bA4eatyOvLVXtgP4MeusfZrK1nJGR4OIdptSPgm4bkWYSQcDtXF4+yEZ/
         SCcBkqNeN3iKURKDHRCB/MNwRMpHwcU0DQ8Rv74UnCbqPNvfWEhIEp7J6LNY5H/bziLV
         BVptHU9qvVHPU4WVKSE0yug/I7jWYYFp+LQg0z0+NC39E3CFwZ1IIXu/ZSXjjNxi/BCD
         S7w1eO08TA+0GKJ/uWXLXWqFbzzoYAI1DmdMGxbZSAr7a+glFvBj4fhfdlyywOsVlG+D
         f4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754022870; x=1754627670;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hvy1+S1s4fKJdVyggMwF0uoMUuYMvpNuWclsNDW3SSw=;
        b=vcm2vt8MCSsGixajlZkOWbZOXvKVphGIsBk5T7EG8827ydMPRGBHb4X/TB8w9vAvjY
         y/f5qnlU/9ZFesul97gRe3QbzkkfYoUmtsVf7Ue5fSKwZ3usm0a2zJiBxxeWuVGR6AfR
         DO84/PQ7pTSaGnDSxldY4+daykhBakA/ozNCMwMucZ8ramXBj7y1SQJ/EJfBL8KpQqLT
         pqSRLoBkVdOmxidWAjhfD3ZY/gzZafMNW6ASQdZNeozE21eAmvl+Bfc+UQX+mzRcOsty
         9NOdo+eE7n1cJNNLPBmAsOPPOkVGUgxiXLlprbqYfuY3GbDESKIKGa+8afcGJrJToX4K
         Fqvw==
X-Forwarded-Encrypted: i=1; AJvYcCUh1zM5ZWVDLuzM3vG3rDeT3NCtx12b84cG2W0f5VTx7llRCgVyHAKjvDUIABC6Uzw2IGXs5tY1F/1wGg==@vger.kernel.org, AJvYcCXAM+LsqhK9KbePRbdAEi/xTPxv6KPzN/7Qe3bky+P3TiDrIVswKhh91XUXpju5iD5tHfdv1IkMcQo7mSRkXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfkLF7uj1pD5ituBnGgDyze1ET3teT7JI4wI1sYOZRkXipR7JO
	CfrdwdzDRYAWCflvNsUotC/7KqRckwIye+ydENNxoO8aJdqteYRWa0o0
X-Gm-Gg: ASbGncsiOlhQeisXlTWeKHh7IS/4B3bqi+0GI77U/oFljGj2mET6JCuLuAO0AIbq57B
	JdidF4Muy1CfZ/HW+rwPJvORJmNZBqfKhT3BGXKh/QB1oY+2aL9NBjlKW/W8E7Jek1qoMooGVc1
	FMA5QC5gCZglvHCJ4w3W9HsnhFCQpZlK4J5+706X7GOoYkEGFal76Ao4mWwHM+w8Yq1M3LhGkyP
	Lonw1RkB11tOZCf6KWm5F5NO7Gl8T09ikMX3j+JAav83xNaghq47bk8P3GZz29TrCvHS7KnYeKx
	4xxYBCPJtm+C7sk7LazTGNWn0MOzlTiVBeYXGXA6cKcfsSIT6EHxdrzqncv3htG6ShEaPzLH77i
	EC01QeRSMKivIigo=
X-Google-Smtp-Source: AGHT+IH3hwA2OpRbr/zHoWNUCy0aIL06wDEuaRMcP/tc6VQhVRBB71zAOlOqZeisNVx6p6jZ1hMqIA==
X-Received: by 2002:a17:902:ea12:b0:240:a8c8:5f6f with SMTP id d9443c01a7336-2422a6a7c11mr18344715ad.27.1754022870462;
        Thu, 31 Jul 2025 21:34:30 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e7d8sm31815305ad.42.2025.07.31.21.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 21:34:29 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org, x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, kernel@pankajraghav.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC v2 3/4]  mm: add largest_zero_folio() routine
In-Reply-To: <20250724145001.487878-4-kernel@pankajraghav.com>
Date: Fri, 01 Aug 2025 10:00:27 +0530
Message-ID: <87seibr7do.fsf@gmail.com>
References: <20250724145001.487878-1-kernel@pankajraghav.com> <20250724145001.487878-4-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> Add largest_zero_folio() routine so that huge_zero_folio can be

[largest]_zero_folio() can sound a bit confusing with largest in it's
name. Maybe optimal_zero_folio()? 

No hard opinion though. Will leave it upto you. 

-ritesh

> used directly when CONFIG_STATIC_HUGE_ZERO_FOLIO is enabled. This will
> return ZERO_PAGE folio if CONFIG_STATIC_HUGE_ZERO_FOLIO is disabled or
> if we failed to allocate a huge_zero_folio.
>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  include/linux/huge_mm.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 78ebceb61d0e..c44a6736704b 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -716,4 +716,21 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
>  	return split_folio_to_list_to_order(folio, NULL, new_order);
>  }
>  
> +/*
> + * largest_zero_folio - Get the largest zero size folio available
> + *
> + * This function will return huge_zero_folio if CONFIG_STATIC_HUGE_ZERO_FOLIO
> + * is enabled. Otherwise, a ZERO_PAGE folio is returned.
> + *
> + * Deduce the size of the folio with folio_size instead of assuming the
> + * folio size.
> + */
> +static inline struct folio *largest_zero_folio(void)
> +{
> +	struct folio *folio = get_static_huge_zero_folio();
> +
> +	if (folio)
> +		return folio;
> +	return page_folio(ZERO_PAGE(0));
> +}
>  #endif /* _LINUX_HUGE_MM_H */
> -- 
> 2.49.0

