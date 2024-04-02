Return-Path: <linux-fsdevel+bounces-15874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDC8895411
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 14:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247541F25118
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 12:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C79185261;
	Tue,  2 Apr 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fj0kHomC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F407EF10
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062563; cv=none; b=mKbTB2XMxH47qGmRK3k/8jI0Zd+GT7roPd7wTX/bN6e2Ur8TP20Eo8q2yjiHTpDpaL7oHxdG/kwpwxzZo7xtjeYsWZe9kfvzrQb0juQ2JapU+6dGILc5HJ8BGbAfVaMNRkZ9Ix7m4dVpRKscfvKFgZ+B7I1toV03NoGebr7akgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062563; c=relaxed/simple;
	bh=zN8QbrS4azbPCsghFpZd2U9tA5iFf1lkMG/47l0YA4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoAt/Ryx59ucbofcplfGt+Qh097NY6o2vv3V5MCX8GHW45JONQ2TW7XIToYeQdOoWAdfrHjT0Oi39x7RONz81zcKKA1Wx3CifW2r/pAb6BMLi+2EUgsSLqOGWy/YN9na+GgrYA5oSagBAEKRVIXkBeJwiGEvwJZ5yagvWCs984U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fj0kHomC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712062560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7LWvvJr0ZLeVlbglQU3vOlFLqLTXjJjluvDd3mIpGc=;
	b=fj0kHomCx+QBfVD12G/6ClWpGqWAlqODDDI775NUdm0sWGuf2Qfz69bqU/X36fWnHzWyCD
	zKS8BZp9FztncWR6srfIteOZTGJxivcANcX9pSYTsO7tL0XMFbxSbZcaev4H3uVBGLvDFS
	x7y/aV3282qDG2ZhKF4Nu+2lKMLMuvw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-rp9IQ797NSqx0sgO2R02KQ-1; Tue,
 02 Apr 2024 08:55:55 -0400
X-MC-Unique: rp9IQ797NSqx0sgO2R02KQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FBAA2823F33;
	Tue,  2 Apr 2024 12:55:54 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.247])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 02C913C22;
	Tue,  2 Apr 2024 12:55:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v1 3/3] mm: use "GUP-fast" instead "fast GUP" in remaining comments
Date: Tue,  2 Apr 2024 14:55:16 +0200
Message-ID: <20240402125516.223131-4-david@redhat.com>
In-Reply-To: <20240402125516.223131-1-david@redhat.com>
References: <20240402125516.223131-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Let's fixup the remaining comments to consistently call that thing
"GUP-fast". With this change, we consistently call it "GUP-fast".

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/filemap.c    | 2 +-
 mm/khugepaged.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 387b394754fa..c668e11cd6ef 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1810,7 +1810,7 @@ EXPORT_SYMBOL(page_cache_prev_miss);
  * C. Return the page to the page allocator
  *
  * This means that any page may have its reference count temporarily
- * increased by a speculative page cache (or fast GUP) lookup as it can
+ * increased by a speculative page cache (or GUP-fast) lookup as it can
  * be allocated by another user before the RCU grace period expires.
  * Because the refcount temporarily acquired here may end up being the
  * last refcount on the page, any page allocation must be freeable by
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 38830174608f..6972fa05132e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1169,7 +1169,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	 * huge and small TLB entries for the same virtual address to
 	 * avoid the risk of CPU bugs in that area.
 	 *
-	 * Parallel fast GUP is fine since fast GUP will back off when
+	 * Parallel GUP-fast is fine since GUP-fast will back off when
 	 * it detects PMD is changed.
 	 */
 	_pmd = pmdp_collapse_flush(vma, address, pmd);
-- 
2.44.0


