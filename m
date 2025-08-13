Return-Path: <linux-fsdevel+bounces-57717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66683B24B75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF20B17405D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A852F4A16;
	Wed, 13 Aug 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxWynHr8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB02C2EFD88;
	Wed, 13 Aug 2025 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093454; cv=none; b=GanJspbDOayWOxHXr/gKO8OfGgQJMsKKBaLs5SHS5IbOKowAgzQ3AatAW9QLwm/wgGDVwcJmgzsL+9BLDF/U43oMeIUTCtIGD+UoKEGbONfnIj8XydNzsUWqK4Sv4pGfYPvG/v0HA+qAjmzr9CGMoZfXvObhrWW3x6eJB6maPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093454; c=relaxed/simple;
	bh=VELwcFic5HUaVXkEp+0d8boD1gUSvHuqT+6BaOmZIyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQF/W2Wpywd3sKzt21FCh8JA3CqYG36tn6dnhtp5gbF3vtVOmvNZJ8SkH+C+V7EgRQGNCll0x6d3lQXN44ObvzFTVbg3jWY7j6LdHzpzBZMknzLkQriYA9K+rNunL5TLExrkph16M4zLPfuhZzDAHcQvLA0NG+1/jNZ375Rnlyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxWynHr8; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70884da4b55so68058866d6.3;
        Wed, 13 Aug 2025 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755093452; x=1755698252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5zqYBDHJl9ahDn9th72JcB6czovc9uCtW5RO9v9njY=;
        b=NxWynHr843I6zQopohQ5TG5mOHMH1+DHRdye0WdrxtU4BzGUSNDma7fPwNTcOPByBO
         nzLO/fbwPsLtjsx+0Jkkk/HOLHIhb72vIjvryzOIu+n2Q5tr/Y4GlDozUHxAkj9JxuCI
         HctLs/guz9NhcxBx4Hxyu2BbOhMFVNwD+khi+9/EkTxBwYcRCym2dQ/xNJZH8jqUQofp
         khPJPsLtWHsqhOG+zIehMQsiJ0oy5HbiRR9OQfqlCu2rThMikh45L0bRhWOBedwNwT7C
         EZhp9U9zFq3oAA+0teu85y0CPJK+NA4cASoiQf5QggQzy3/M224wqLVIS8qrCaDsIQyI
         LYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093452; x=1755698252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5zqYBDHJl9ahDn9th72JcB6czovc9uCtW5RO9v9njY=;
        b=bGCYi8B5r1OdXtxTYF98LhyTIbjBTZMSUMuxqQZD1QQRBwc1+jQDddkDiYv8IOtZWA
         Z3tDUyri+SAJEeXcLDKSxrIrdNxxnoQxFBIfUIhsv+qvPwKXHt3j07mZQHAlGLVWzq2S
         0YzrrKJgqq8GMkDcJvcVC6SxGgK97Qy4lxf8+G6NyZh0U8t0yEZtYwZze7xlGmGsnXJT
         5XdmYUTtpzq07coWaUSdHdP4jD0VTTaHOO/67D29tO0BXycnwNHTxMeLGZ5Gs0rvABAN
         cLEfhBSjAXiUZ1JOEDUmURC+pXl3YbOd9ww10ld7sbzbUMOje9alCSsQg5NxthKN6Vsg
         JSeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2n65Qo1mCQigpjDA6992XCY/z0+R+LGbUEy8ekB4e+/ZAAXkiPB2uaZugP8ylwKH4fkBy5TjopxsWT5Y4@vger.kernel.org, AJvYcCX4KVaYYqZqMke7h3WogV/dBP4FGnabAW/sYNVLVcDm1+TdoGzKDMc/rVxbH9kMzM+yDEb3NfX9fB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbDuxoXIaHnRN6+NO++UT47erDShufpXZ5O+N+rv1s2bdqIgJb
	ES58VgLpk5Ipx1zR9fnB+uaYDxhRQnhbE0taNYtTF7VAo5RIRAbxvKOr
X-Gm-Gg: ASbGncuAvsW3iERS9YE++hZmtt42Mn2kmD/BNn63OiudbWNaFUWrtgd1X1+qrGoSFyo
	6EclWGUFcHb5gKPpkuVjOewa8VPUBFkLMu1l6MdM+HLw45iuJsVYJkTUoW3g+pQG0wTt0sXohv4
	MSjSNLFmtGabxcOrFptYEfcUPBBoLus6oB3o1qJXSlJKmJhJBjqxsjbuL0IFThH7xtW5mTnbERB
	+QOTRFwWL/DAqEl6fvia4g2nqtCjtMAjYsDKI8qr5DIqaspnzu2yxeQBhWq7PP5FYo7krYIYmSx
	ugpnsp4NuxCbPLIxI2WSKvBJSIbWTdY/iDoXT5qyOicOcCbnr3+/ypWEeI05/AuChs2H1LJF3Ow
	BTDtHu6zED2Rk0SsgYH0=
X-Google-Smtp-Source: AGHT+IFpHk5pQBDYwwsiLWpQpbOPKy4lZ7v78aysy0xnjiL8OlSxn4Rht5C6ZYA1xIGMHAe6XCbhlQ==
X-Received: by 2002:a05:6214:519e:b0:709:8fad:cd2d with SMTP id 6a1803df08f44-709e89f7a9cmr35795856d6.43.1755093451573;
        Wed, 13 Aug 2025 06:57:31 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:1::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca363fesm192739836d6.31.2025.08.13.06.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:57:30 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@redhat.com,
	linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	corbet@lwn.net,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	baohua@kernel.org,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	ziy@nvidia.com,
	laoar.shao@gmail.com,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	vbabka@suse.cz,
	jannh@google.com,
	Arnd Bergmann <arnd@arndb.de>,
	sj@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 3/7] mm/huge_memory: respect MADV_COLLAPSE with PR_THP_DISABLE_EXCEPT_ADVISED
Date: Wed, 13 Aug 2025 14:55:38 +0100
Message-ID: <20250813135642.1986480-4-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813135642.1986480-1-usamaarif642@gmail.com>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

Let's allow for making MADV_COLLAPSE succeed on areas that neither have
VM_HUGEPAGE nor VM_NOHUGEPAGE when we have THP disabled
unless explicitly advised (PR_THP_DISABLE_EXCEPT_ADVISED).

MADV_COLLAPSE is a clear advice that we want to collapse.

Note that we still respect the VM_NOHUGEPAGE flag, just like
MADV_COLLAPSE always does. So consequently, MADV_COLLAPSE is now only
refused on VM_NOHUGEPAGE with PR_THP_DISABLE_EXCEPT_ADVISED,
including for shmem.

Co-developed-by: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/huge_mm.h    | 8 +++++++-
 include/uapi/linux/prctl.h | 2 +-
 mm/huge_memory.c           | 5 +++--
 mm/memory.c                | 6 ++++--
 mm/shmem.c                 | 2 +-
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 92ea0b9771fae..1ac0d06fb3c1d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -329,7 +329,7 @@ struct thpsize {
  * through madvise or prctl.
  */
 static inline bool vma_thp_disabled(struct vm_area_struct *vma,
-		vm_flags_t vm_flags)
+		vm_flags_t vm_flags, bool forced_collapse)
 {
 	/* Are THPs disabled for this VMA? */
 	if (vm_flags & VM_NOHUGEPAGE)
@@ -343,6 +343,12 @@ static inline bool vma_thp_disabled(struct vm_area_struct *vma,
 	 */
 	if (vm_flags & VM_HUGEPAGE)
 		return false;
+	/*
+	 * Forcing a collapse (e.g., madv_collapse), is a clear advice to
+	 * use THPs.
+	 */
+	if (forced_collapse)
+		return false;
 	return mm_flags_test(MMF_DISABLE_THP_EXCEPT_ADVISED, vma->vm_mm);
 }
 
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 150b6deebfb1e..51c4e8c82b1e9 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -185,7 +185,7 @@ struct prctl_mm_map {
 #define PR_SET_THP_DISABLE	41
 /*
  * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
- * VM_HUGEPAGE).
+ * VM_HUGEPAGE, MADV_COLLAPSE).
  */
 # define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
 #define PR_GET_THP_DISABLE	42
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9c716be949cbf..1eca2d543449c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -104,7 +104,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 {
 	const bool smaps = type == TVA_SMAPS;
 	const bool in_pf = type == TVA_PAGEFAULT;
-	const bool enforce_sysfs = type != TVA_FORCED_COLLAPSE;
+	const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
+	const bool enforce_sysfs = !forced_collapse;
 	unsigned long supported_orders;
 
 	/* Check the intersection of requested and supported orders. */
@@ -122,7 +123,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	if (!vma->vm_mm)		/* vdso */
 		return 0;
 
-	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags))
+	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags, forced_collapse))
 		return 0;
 
 	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
diff --git a/mm/memory.c b/mm/memory.c
index 7b1e8f137fa3f..e4f533655305a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5332,9 +5332,11 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	 * It is too late to allocate a small folio, we already have a large
 	 * folio in the pagecache: especially s390 KVM cannot tolerate any
 	 * PMD mappings, but PTE-mapped THP are fine. So let's simply refuse any
-	 * PMD mappings if THPs are disabled.
+	 * PMD mappings if THPs are disabled. As we already have a THP ...
+	 * behave as if we are forcing a collapse.
 	 */
-	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags))
+	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags,
+						     /* forced_collapse=*/ true))
 		return ret;
 
 	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
diff --git a/mm/shmem.c b/mm/shmem.c
index e2c76a30802b6..d945de3a7f0e7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1817,7 +1817,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	vm_flags_t vm_flags = vma ? vma->vm_flags : 0;
 	unsigned int global_orders;
 
-	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags)))
+	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags, shmem_huge_force)))
 		return 0;
 
 	global_orders = shmem_huge_global_enabled(inode, index, write_end,
-- 
2.47.3


