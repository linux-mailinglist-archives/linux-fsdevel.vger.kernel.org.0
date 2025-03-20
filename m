Return-Path: <linux-fsdevel+bounces-44514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29841A69FE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 07:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711AF7AC63E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 06:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5861F03F2;
	Thu, 20 Mar 2025 06:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NSeLspLx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B181EE010
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 06:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742452792; cv=none; b=d0YGuvZIS42hO1T1kiadu9ZHJxkrZsomvHdydzzfN6jP0QFjtwsUDJYHaTso1HQMFEFId90bfUgU/41Uu6GBQU/iCtQNAEyGXYcybUZ65o4i3nZOWbjvThROI50A0JUAGJ1c5SoKNVepVsWJ+oCGP6a0XE3MPmCtTfdG9jyOruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742452792; c=relaxed/simple;
	bh=GGGsjxJMNQjlKcl7gJ/10cnjYtrTd6brHOM5zCrOplI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s78g8qE3KcI0cD73TU3y2mMp0SG8kpotb8K+Tw27nX0imBePePjBqAtALiDVDafbBoVZY1PaIsYyNzUcLBxuA4bKxJT36YbscaCVPNJCjB7QptCLSOvmXPfwVu9+jM9qzMeoijdOmId2kHQyZaYLbDFs3WE8cy9F4CJI0LGKsCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NSeLspLx; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-85b41b906b3so50730639f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 23:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742452789; x=1743057589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+zYWV6NSopuldnNVazhY6YUnTYuwrgpgyF3WHeSVI8=;
        b=NSeLspLxbeNdCL94XY08vBx9yNnirfvjiNL3NVkGOZ/O7Yw0TM6cTTabwFs6IcHmyT
         rD6jrdJ536gqlo3QEwMYOobzi97er6AX09U9p60PuIeVXK655fwe6oe5HGRUWxxPNLKm
         4hiuOQhhcjfLbqc8fWD1hcA8MkHGp+tKLANWi/FLxNaj6QNAckBxpDlawUdiDCE85zBR
         /PmHaqVHdCRbcgjeVMRPgZ1zMZmAuSWfJr6AnD+0g5VWehmbBuz2cUP2WQA2ayxFpZYo
         e4WFwgOZSkAGidhhcbq3b6qGENLxgN2eMkQtlaZmUi1HD6cMbm746hq5GsVNpgGQqvfe
         5bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742452789; x=1743057589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+zYWV6NSopuldnNVazhY6YUnTYuwrgpgyF3WHeSVI8=;
        b=d7/cb5p/hgsOThzqPYqZWWsGvoyY9sAmPiPnzwUkKGfL8xAAros7+6o/nHJYjtoFXs
         1u3GQU9LD1QRXxF+K0+tU4HLUjZERov4X/4fhGxWv71lSsrsihn0lFfMcyFgBwn9cFQx
         II8jxZkd3AnMBQLcItGOuDh1faHfnxDiG+J0vslo4w+1RBE69C+baK/4dPiC7lHQHp+L
         iEpVvGRZs1pocY4L83LG97W9xy2XLJuYbQv1gptLqZEQTqmbvhBbgruWqlCsoBxShex9
         rCiujOrcQ4GVuj9rMFgUbY/0oBbKI2bxpCr0ZfKyitkof7F0+fnzUaWeuQrbHsA8kw9z
         Pz6A==
X-Forwarded-Encrypted: i=1; AJvYcCXGy3jeitZlDjIt9X5H+zXmm3uLmrySu+Hp5tmYEhss3aPDRxecs/WBYTK5l5FzFRti6qrLPNwkgAQmMbMk@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPij1aE82uPO3dvY6dKGx/d/Ijuuw81l/nj7yGHijQjAE/qIc
	/LclsQ5e5XKtiCpXw83CNMUmupENlvXIlBh6KIU0Hx+WrzrnLNp9ZNpjpMYy0LeSJMG149+tBFf
	UVg==
X-Google-Smtp-Source: AGHT+IEbcL33dk/wm6GLcLtAt9md7WDVC/RMdK0m0WYXEIIuByDZLRnpM5nzkyuglrbRs0eWMcYPoPCXpKg=
X-Received: from iobbw12.prod.google.com ([2002:a05:6602:398c:b0:85d:9d10:cab7])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:4c8d:b0:85b:46d7:1886
 with SMTP id ca18e2360f4ac-85e137da946mr646941939f.7.1742452788937; Wed, 19
 Mar 2025 23:39:48 -0700 (PDT)
Date: Thu, 20 Mar 2025 06:39:02 +0000
In-Reply-To: <20250320063903.2685882-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320063903.2685882-1-avagin@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320063903.2685882-2-avagin@google.com>
Subject: [PATCH 1/2] fs/proc: extend the PAGEMAP_SCAN ioctl to report guard regions
From: Andrei Vagin <avagin@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Andrei Vagin <avagin@gmail.com>

Introduce the PAGE_IS_GUARD flag in the PAGEMAP_SCAN ioctl to expose
information about guard regions. This allows userspace tools, such as
CRIU, to detect and handle guard regions.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 Documentation/admin-guide/mm/pagemap.rst | 1 +
 fs/proc/task_mmu.c                       | 8 ++++++--
 include/uapi/linux/fs.h                  | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index a297e824f990..7997b67ffc97 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -234,6 +234,7 @@ Following flags about pages are currently supported:
 - ``PAGE_IS_PFNZERO`` - Page has zero PFN
 - ``PAGE_IS_HUGE`` - Page is PMD-mapped THP or Hugetlb backed
 - ``PAGE_IS_SOFT_DIRTY`` - Page is soft-dirty
+- ``PAGE_IS_GUARD`` - Page is a guard region
 
 The ``struct pm_scan_arg`` is used as the argument of the IOCTL.
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c17615e21a5d..698d660bfee4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2067,7 +2067,8 @@ static int pagemap_release(struct inode *inode, struct file *file)
 #define PM_SCAN_CATEGORIES	(PAGE_IS_WPALLOWED | PAGE_IS_WRITTEN |	\
 				 PAGE_IS_FILE |	PAGE_IS_PRESENT |	\
 				 PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |	\
-				 PAGE_IS_HUGE | PAGE_IS_SOFT_DIRTY)
+				 PAGE_IS_HUGE | PAGE_IS_SOFT_DIRTY |	\
+				 PAGE_IS_GUARD)
 #define PM_SCAN_FLAGS		(PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC)
 
 struct pagemap_scan_private {
@@ -2108,8 +2109,11 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 		if (!pte_swp_uffd_wp_any(pte))
 			categories |= PAGE_IS_WRITTEN;
 
+		swp = pte_to_swp_entry(pte);
+		if (is_guard_swp_entry(swp))
+			categories |= PAGE_IS_GUARD;
+
 		if (p->masks_of_interest & PAGE_IS_FILE) {
-			swp = pte_to_swp_entry(pte);
 			if (is_pfn_swap_entry(swp) &&
 			    !folio_test_anon(pfn_swap_entry_folio(swp)))
 				categories |= PAGE_IS_FILE;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 2bbe00cf1248..8aa66c5f69b7 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -363,6 +363,7 @@ typedef int __bitwise __kernel_rwf_t;
 #define PAGE_IS_PFNZERO		(1 << 5)
 #define PAGE_IS_HUGE		(1 << 6)
 #define PAGE_IS_SOFT_DIRTY	(1 << 7)
+#define PAGE_IS_GUARD		(1 << 8)
 
 /*
  * struct page_region - Page region with flags
-- 
2.49.0.rc1.451.g8f38331e32-goog


