Return-Path: <linux-fsdevel+bounces-50041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C7EAC7A31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 10:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E9F501068
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 08:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678D121A44C;
	Thu, 29 May 2025 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G8E6sIz7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE54B1EB2F;
	Thu, 29 May 2025 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748507052; cv=none; b=oBNDbokM/LJHYXFb8tdkoTNzFPbX8CjlQn7wGhjVoRY5+cwExhg0TkGN5+z24kaWHN3lZmuHTrF705W5iv/yaPi3LtNKETpt1qhUu5mAkprWSSUVsX/+SBwoioBWSIEScnbYfpWUTjAlzLp+fsOYyyUVHx+nHTO86d1/CIulO0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748507052; c=relaxed/simple;
	bh=RIJKgny14IykmPjf5Bf9kyBbM164mxDIhs0UrJ22eDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qp9+vCFU1kExuY2OkVHOtRqo9ci9fB0Ff2/UE/EOHqvxSBQs4J/iEBS6yiFVrgKDNXB3jEZx/f4upZxeeN1ugEDLMzCLlrI3H5vtyw8xZjFgqPnVVnnsuHr+Z4t00JDUwP+ji4HpxclzXQXTRTegcahhWWlEuPLLxwTaKWySE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G8E6sIz7; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748507046; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HepIRzU9yVfyc0yQbJg8CFCDS1fs2gXvJNO7QTz5Ovs=;
	b=G8E6sIz7puwJ/OZer7Hdvi/DmUH9PaCh3Vh0Cr0DywuXQvUiqRq+GgLws7DKfzr+99rhSFN3J4DrdEGzMCRbHSUubCS8eAXWDXTmRB9XKS/kbreDiGCryU3vmKMZEsDvM8yAyMVjSj5DUlWXRSB6SHYeYwqlZpDUIiek+eeXUSk=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WcGcFkd_1748507044 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 May 2025 16:24:05 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com,
	david@redhat.com
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: shmem: disallow hugepages if the system-wide shmem THP sysfs settings are disabled
Date: Thu, 29 May 2025 16:23:55 +0800
Message-ID: <c1a6fe55f668cfe87ad113faa49120f049ba9cb5.1748506520.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MADV_COLLAPSE will ignore the system-wide shmem THP sysfs settings, which
means that even though we have disabled the shmem THP configuration, MADV_COLLAPSE
will still attempt to collapse into a shmem THP. This violates the rule we have
agreed upon: never means never.

Then the current strategy is:
For shmem, if none of always, madvise, within_size, and inherit have enabled
PMD-sized mTHP, then MADV_COLLAPSE will be prohibited from collapsing PMD-sized mTHP.

For tmpfs, if the mount option is set with the 'huge=never' parameter, then
MADV_COLLAPSE will be prohibited from collapsing PMD-sized mTHP.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/huge_memory.c |  2 +-
 mm/shmem.c       | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d3e66136e41a..a8cfa37cae72 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -166,7 +166,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	 * own flags.
 	 */
 	if (!in_pf && shmem_file(vma->vm_file))
-		return shmem_allowable_huge_orders(file_inode(vma->vm_file),
+		return orders & shmem_allowable_huge_orders(file_inode(vma->vm_file),
 						   vma, vma->vm_pgoff, 0,
 						   !enforce_sysfs);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 4b42419ce6b2..4dbb28d85cd9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -613,7 +613,7 @@ static unsigned int shmem_get_orders_within_size(struct inode *inode,
 }
 
 static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
-					      loff_t write_end, bool shmem_huge_force,
+					      loff_t write_end,
 					      struct vm_area_struct *vma,
 					      unsigned long vm_flags)
 {
@@ -625,7 +625,7 @@ static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index
 		return 0;
 	if (shmem_huge == SHMEM_HUGE_DENY)
 		return 0;
-	if (shmem_huge_force || shmem_huge == SHMEM_HUGE_FORCE)
+	if (shmem_huge == SHMEM_HUGE_FORCE)
 		return maybe_pmd_order;
 
 	/*
@@ -860,7 +860,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 }
 
 static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
-					      loff_t write_end, bool shmem_huge_force,
+					      loff_t write_end,
 					      struct vm_area_struct *vma,
 					      unsigned long vm_flags)
 {
@@ -1261,7 +1261,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 			STATX_ATTR_NODUMP);
 	generic_fillattr(idmap, request_mask, inode, stat);
 
-	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
+	if (shmem_huge_global_enabled(inode, 0, 0, NULL, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
 
 	if (request_mask & STATX_BTIME) {
@@ -1768,7 +1768,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 		return 0;
 
 	global_orders = shmem_huge_global_enabled(inode, index, write_end,
-						  shmem_huge_force, vma, vm_flags);
+						  vma, vm_flags);
 	/* Tmpfs huge pages allocation */
 	if (!vma || !vma_is_anon_shmem(vma))
 		return global_orders;
@@ -1790,7 +1790,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	/* Allow mTHP that will be fully within i_size. */
 	mask |= shmem_get_orders_within_size(inode, within_size_orders, index, 0);
 
-	if (vm_flags & VM_HUGEPAGE)
+	if (shmem_huge_force || (vm_flags & VM_HUGEPAGE))
 		mask |= READ_ONCE(huge_shmem_orders_madvise);
 
 	if (global_orders > 0)
-- 
2.43.5


