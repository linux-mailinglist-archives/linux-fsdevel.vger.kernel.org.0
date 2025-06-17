Return-Path: <linux-fsdevel+bounces-51920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6477ADD2B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E39B7A7227
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61F32EE60E;
	Tue, 17 Jun 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaVB/PMt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A12ED878
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175038; cv=none; b=Q/dI+1uxkva3Tzoq8g57ys5ePFwT/99mNXEskV8cA88pyMCTUSg74hvwBI1PevC2YhyBsLxN2djE+eIGvtTrS8m3onM+NsrahJTucwxBbuBPQNLAPDxzMETyIMvbVFPZLeO2j8mTK3MmEZza2trQRiwolz9wmaYErfwV4z4Q5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175038; c=relaxed/simple;
	bh=N+sqTwgnUIZg4czKbr4/JT7TGmW4bJe3WXX3qzBFdJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0/UJBVRkygvmab/70hho1hboEqi2XbxCARFEfMWi9ffncCVyovFspbJYclZUuglHz72SZCULExgpFSWaLMe0LaN6LaITrne6eW3XbunUpuZfdrhNei30AuJDH95xgNnopgNmfZgK0QHXvL1bGd8r+ptJ/vBSa3WbTqQKAxfGps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WaVB/PMt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750175035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+enD/DBO3lH97hAndG2Fd7ZdK35XEPxGRz1KxKwpT4=;
	b=WaVB/PMtm5IWrJswhvJBA+TcpLj6HitCMozYFeXn22J6CMPCNf0F0HFNy+8Yw3cC0R2svs
	bzM9DXy6DXwDvUSki2shud98tms1JEgIJ5RRbnta6ESXM5zhpk5i+kbfV6/5hVtpCDvN++
	w3wUnnV6pamsgwwL1M83cHJ4UhVswQo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-nWqOJLsqPB6vvbvhHGaLaQ-1; Tue, 17 Jun 2025 11:43:53 -0400
X-MC-Unique: nWqOJLsqPB6vvbvhHGaLaQ-1
X-Mimecast-MFC-AGG-ID: nWqOJLsqPB6vvbvhHGaLaQ_1750175032
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so3507348f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 08:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175032; x=1750779832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+enD/DBO3lH97hAndG2Fd7ZdK35XEPxGRz1KxKwpT4=;
        b=sjgIUsvNdpkSb4clzLUYb4FFDnMm9hKKD52t7VopqcPHhtOmakMGek/s5a/W9DMvUi
         Tbnrmq4Vc1PCwUPsZhx1OT8Cr4TsKG14frwZ036+Cc/bYpqfQZ4Qdsfct62nJWO5Kl3a
         8Ui1hyYXtRUtGHHvHRvpjuFSx1yyqjKUCxEvDVyLGZhBC2TvscMNNK8clkvg6hJrlXrt
         LzVETfuqnqhGeonXaCYb6LLlEw4WaDjvci8B24r4AmLswfjBew4bLkwT9+a5XuWIYgDL
         0vNK+ZP9qMaeQj2XZfEs00PMOoHSLnbJWCWzm+6nYBlXh3/AjNiU/o49A86sR03ox/OK
         xw+Q==
X-Gm-Message-State: AOJu0YxnoFZVeK3H66AW5R53C+XzQ9bvqn3NXAMspIhGkvKGuY5eMmGS
	faa2nz8UD9oCTAQlje0IhUjj2VQU4pI0OW6bm//B0tC4dFWI+DTBMcqUCeccue1GMYeorweBCxz
	U0FtqU/ehFdNX4kl6cu7qBL085MeqMQ4MLi1FMVjmE2Pl6lSU+lUIjv7qERWeub3jh2I=
X-Gm-Gg: ASbGncukpDY34fYTSIvxTVc8EFlDzBspNtq/+zOglufJ27or2eJQKc0IZ4wKmVAzw8e
	65uPn/swDWT31tXxqPnCgHRCpg71UcNRp6UPRaPYdgzYLHnwZXq6yvxRdYzkUcdM9+YWzYEs3GD
	c3sCz5cIVgUJ8v3Vnnh6lmHowBvnfBm7LoMwTMBh7+NeRrlJ9Zdd/8HfDovrh3kkBbiCOvJZHj0
	VQwQiJek5nRH3PaMpge+WU6tc+b8Pg1949Cq79gI6b7pIm1dvScOWOYXCvIvELllqBzYV04oCPR
	xNco0C7BIYde0qzuzy8QH8Wj7RyEC8vE8qKbDaWuTqYLZFYZgixtMWO0XUkJMyqZ5PhAz7lmlWV
	D6tByRA==
X-Received: by 2002:a5d:5847:0:b0:3a5:1c0d:85e8 with SMTP id ffacd0b85a97d-3a57237797bmr10355644f8f.22.1750175032059;
        Tue, 17 Jun 2025 08:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgGKPI0HPFQFNSDiU1UoCT4KWg9jjW+HS33TdpBy2263RBIYIhTEc5b/vsOH/vxH2erO7KQw==
X-Received: by 2002:a5d:5847:0:b0:3a5:1c0d:85e8 with SMTP id ffacd0b85a97d-3a57237797bmr10355602f8f.22.1750175031623;
        Tue, 17 Jun 2025 08:43:51 -0700 (PDT)
Received: from localhost (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568a547ecsm14548596f8f.17.2025.06.17.08.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:43:51 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH RFC 02/14] mm: drop highest_memmap_pfn
Date: Tue, 17 Jun 2025 17:43:33 +0200
Message-ID: <20250617154345.2494405-3-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617154345.2494405-1-david@redhat.com>
References: <20250617154345.2494405-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now unused, so let's drop it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/internal.h | 2 --
 mm/memory.c   | 2 --
 mm/mm_init.c  | 3 ---
 mm/nommu.c    | 1 -
 4 files changed, 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index f519eb7217c26..703871905fd6d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -503,8 +503,6 @@ static inline bool folio_needs_release(struct folio *folio)
 		(mapping && mapping_release_always(mapping));
 }
 
-extern unsigned long highest_memmap_pfn;
-
 /*
  * Maximum number of reclaim retries without progress before the OOM
  * killer is consider the only way forward.
diff --git a/mm/memory.c b/mm/memory.c
index 188b84ebf479a..a1b5575db52ac 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -146,8 +146,6 @@ __setup("norandmaps", disable_randmaps);
 unsigned long zero_pfn __read_mostly;
 EXPORT_SYMBOL(zero_pfn);
 
-unsigned long highest_memmap_pfn __read_mostly;
-
 /*
  * CONFIG_MMU architectures set up ZERO_PAGE in their paging_init()
  */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5c21b3af216b2..1dac66c209984 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -881,9 +881,6 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 	unsigned long pfn, end_pfn = start_pfn + size;
 	struct page *page;
 
-	if (highest_memmap_pfn < end_pfn - 1)
-		highest_memmap_pfn = end_pfn - 1;
-
 #ifdef CONFIG_ZONE_DEVICE
 	/*
 	 * Honor reservation requested by the driver for this ZONE_DEVICE
diff --git a/mm/nommu.c b/mm/nommu.c
index 38c22ea0a95c6..cd9ddbfe1af80 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -42,7 +42,6 @@
 #include <asm/mmu_context.h>
 #include "internal.h"
 
-unsigned long highest_memmap_pfn;
 int heap_stack_gap = 0;
 
 atomic_long_t mmap_pages_allocated;
-- 
2.49.0


