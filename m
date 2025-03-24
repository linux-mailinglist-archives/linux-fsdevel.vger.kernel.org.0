Return-Path: <linux-fsdevel+bounces-44855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2FDA6D477
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 07:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1A91891B15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 06:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2929204C01;
	Mon, 24 Mar 2025 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AvNOsxdM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41675204F74
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742799215; cv=none; b=CeqSn6T9Q+A6EoKGqYEJX6dRSMxIpcYqqr2rjtP43Wo9zvOh+VVaOFdd5HHkBpeaezwFqsvFwmJHMtw/KxEZtx7Xh92sgaqsMRrsyX99qkKyDqgsWuCva8E2ihqvp//dXhCHmVT/4KKrYLmWBfNV1+rRgfLSZu+gMl8llsvZCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742799215; c=relaxed/simple;
	bh=nrkJk9DKEGt/dov8Gi4x/jNgwqImygJxo/xULmqLdas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OXg2CkNraroguGsDzdYehqGAPlFTB8JV+gxZKRryBwbGMyNzWiF7o2+xzqEcGm/j1SuCCYaink9Jg8KkxqvnmJinSb7x3Ku9zrYAfDDhGDdBnOJdumOmi3YH7ZFwwGxm4OHly7pXvun65EMYS1StmUZXmeC8XOHfxXiLtKrsjek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AvNOsxdM; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-85b418faf73so955028739f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Mar 2025 23:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742799212; x=1743404012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xl8IF5RHpUU1Lg7cJxOKLVwxFTCbPq38iLJ6S8yYG08=;
        b=AvNOsxdM5EMdfxvwysARbn1btARGyZcSAvnc7mVNMFh52iKQukt0ePXdvMsIi8Wx3C
         iiKsBEzRD0hNvs4SJJDtTSvhixpXGTDRweKZBkz77H83mxy6/35WssYCJFsDhC0BVKac
         lMi3ZyDgwvKwnFyL+V3ieH02EZK+2A/nEPGo+z1UsP8pxu5zQKxw2CnURY+e+C1WjyOw
         MLYIbJdd8fHf60PhCOq4gLy6IOm7YOTYl9L3WYazlZtQEOo4eTaV/1FL9Yjd+wS/yzOc
         UGGk4Iw9sLGDNcpqa90VfdS4dz09UPAogTrOCP7dO+P3F5wnSd1eMP8wmvjwW7bLhbWA
         wVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742799212; x=1743404012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xl8IF5RHpUU1Lg7cJxOKLVwxFTCbPq38iLJ6S8yYG08=;
        b=dgEz22fu6Wwc10LbH93YFJy+I242nVW/BaJE3/ZmpYw1r0zdRVUFoeXo6lWpLdbxT6
         26hc1t0pBj6p3t3na9MK+eS2rhj0QRAxtX0uNn2Pza+uI5Q3YUn2ssVT9WUVQjRIOSXh
         gvj3h1UKdgFVHlsUJMfypiC4qP7Mf6utMBbxIUZpX6EZ4NvFlOr9d0VLZj+zSdqYi159
         V5X17qBmEog1h6gGJDqZ3cbThEF//ZkZzKav8aouMB5gaLN+UacRyBDMoq7mFtspA9SK
         oSgTyvH5+DK7/GW8oC5Y8cnBUKs100cuvuXGdRFbTh+j+2+nEQ31Mh+VfVxxcgHAybBk
         Y2mA==
X-Forwarded-Encrypted: i=1; AJvYcCUGRQrdznyl2xj4z42YCFR7KOS9vx7UMl6pp08EgkK1DDbBMEndvHFhdzVe9oei/POeFW/iK4Pi5UsvOJ7m@vger.kernel.org
X-Gm-Message-State: AOJu0YxCs1l6zhC/AoSfFIJ63VExTgiP3K+N79YUxgS1UfiDl1qGAuOz
	ETShdqPMwKhOYvB+FleSIG+q3JrUyn5aE+jG7TqtFuY6c2RwPCVUQrcd82cuC9Gy+hhCnOwUxUd
	EOw==
X-Google-Smtp-Source: AGHT+IGLukfQgJAXKk11u4fnuWxiAd2otr8HGeGoAqGpKKKT8IRHd3Jidw+Bw0GLHnKZol10jN2Ijr7hn10=
X-Received: from iosu9.prod.google.com ([2002:a05:6602:29a9:b0:85b:606c:d446])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:418f:b0:85b:3f06:1fd4
 with SMTP id ca18e2360f4ac-85e2cb5960dmr918008339f.9.1742799212314; Sun, 23
 Mar 2025 23:53:32 -0700 (PDT)
Date: Mon, 24 Mar 2025 06:53:26 +0000
In-Reply-To: <20250324065328.107678-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324065328.107678-1-avagin@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324065328.107678-2-avagin@google.com>
Subject: [PATCH 1/3] fs/proc: extend the PAGEMAP_SCAN ioctl to report guard regions
From: Andrei Vagin <avagin@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	criu@lists.linux.dev, Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Andrei Vagin <avagin@gmail.com>

Introduce the PAGE_IS_GUARD flag in the PAGEMAP_SCAN ioctl to expose
information about guard regions. This allows userspace tools, such as
CRIU, to detect and handle guard regions.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 Documentation/admin-guide/mm/pagemap.rst |  1 +
 fs/proc/task_mmu.c                       | 17 ++++++++++-------
 include/uapi/linux/fs.h                  |  1 +
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index a297e824f990..1f49762190eb 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -234,6 +234,7 @@ Following flags about pages are currently supported:
 - ``PAGE_IS_PFNZERO`` - Page has zero PFN
 - ``PAGE_IS_HUGE`` - Page is PMD-mapped THP or Hugetlb backed
 - ``PAGE_IS_SOFT_DIRTY`` - Page is soft-dirty
+- ``PAGE_IS_GUARD`` - Page is a part of a guard region
 
 The ``struct pm_scan_arg`` is used as the argument of the IOCTL.
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c17615e21a5d..cc35d8990c54 100644
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
@@ -2108,12 +2109,14 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 		if (!pte_swp_uffd_wp_any(pte))
 			categories |= PAGE_IS_WRITTEN;
 
-		if (p->masks_of_interest & PAGE_IS_FILE) {
-			swp = pte_to_swp_entry(pte);
-			if (is_pfn_swap_entry(swp) &&
-			    !folio_test_anon(pfn_swap_entry_folio(swp)))
-				categories |= PAGE_IS_FILE;
-		}
+		swp = pte_to_swp_entry(pte);
+		if (is_guard_swp_entry(swp))
+			categories |= PAGE_IS_GUARD;
+		else if ((p->masks_of_interest & PAGE_IS_FILE) &&
+			 is_pfn_swap_entry(swp) &&
+			 !folio_test_anon(pfn_swap_entry_folio(swp)))
+			categories |= PAGE_IS_FILE;
+
 		if (pte_swp_soft_dirty(pte))
 			categories |= PAGE_IS_SOFT_DIRTY;
 	}
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
2.49.0.395.g12beb8f557-goog


