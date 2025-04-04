Return-Path: <linux-fsdevel+bounces-45775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DCDA7C0D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 17:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C15189F492
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3699E1F584E;
	Fri,  4 Apr 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="s4+Qr7zL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4FC1F4E57;
	Fri,  4 Apr 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781461; cv=none; b=ox4yvW77XkaBLaQrvQYnIirkDJEYV12ZTv7pYmM/P9izIhgrpGU/M0YAWaHOaL4gZMMWhu8jBLfudWcN5ClGX8bN3uMI/bt5eVZOeF22EK6xluqcZtmwey0vNAqclUi+4LPOM2/509ZY+JrlSdYpYqLhqZcmV9yucPyee2MNDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781461; c=relaxed/simple;
	bh=LHnS35U8gBv0D4O5Jd88bf0LA/0TioSxp/njvc2FFzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fui0juTRDw7+SYXTejNadNX0Dj0s5dKRDHPUjY/o+cJAJmFK1p0vFzC5Qj+8dW5nx+2NQ19/5LOQjyxU0WfkTxWXRjSx6in+jBt/KKTe8E8eQRHbH7ku2mKR3XiK8cjH/c81k/Ekap4KUKLCE2Jh1oSTSedqPkfEuu/G3KaybYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=s4+Qr7zL; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743781461; x=1775317461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4KrCtE/sXZ3BNNe21aeAaGtv43DEVIENoUwdd2sqOFQ=;
  b=s4+Qr7zLGa/XSlFK3IAonFYimnAAOcXbgClwmia2hA+t6WIKaabvRcWU
   SPDM2dYjZbBFR/RwGEX2ft0uJmlvg96sQNcnGAqLsVSwtTS5MzYs7+uLo
   8V6ltZqO8CkwlcKSxHg8/Zq57yMN4Xl5XouRYo5GRyg36R3BZD5zgPnth
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,188,1739836800"; 
   d="scan'208";a="7643503"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 15:44:14 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:31324]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.147:2525] with esmtp (Farcaster)
 id ea24aab9-5b16-4f64-955a-2db6935ecc80; Fri, 4 Apr 2025 15:44:12 +0000 (UTC)
X-Farcaster-Flow-ID: ea24aab9-5b16-4f64-955a-2db6935ecc80
Received: from EX19D020UWA004.ant.amazon.com (10.13.138.231) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 15:44:08 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D020UWA004.ant.amazon.com (10.13.138.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 15:44:07 +0000
Received: from email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 15:44:07 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com (Postfix) with ESMTPS id A7CCB41FBE;
	Fri,  4 Apr 2025 15:44:05 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <muchun.song@linux.dev>,
	<hughd@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <jack@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@Oracle.com>, <jannh@google.com>,
	<ryan.roberts@arm.com>, <david@redhat.com>, <jthoughton@google.com>,
	<peterx@redhat.com>, <graf@amazon.de>, <jgowans@amazon.com>,
	<roypat@amazon.co.uk>, <derekmn@amazon.com>, <nsaenz@amazon.es>,
	<xmarcalx@amazon.com>, <kalyazin@amazon.com>
Subject: [PATCH v3 1/6] mm: userfaultfd: generic continue for non hugetlbfs
Date: Fri, 4 Apr 2025 15:43:47 +0000
Message-ID: <20250404154352.23078-2-kalyazin@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404154352.23078-1-kalyazin@amazon.com>
References: <20250404154352.23078-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Remove shmem-specific code from UFFDIO_CONTINUE implementation for
non-huge pages by calling vm_ops->fault().  A new VMF flag,
FAULT_FLAG_USERFAULT_CONTINUE, is introduced to avoid recursive call to
handle_userfault().

Suggested-by: James Houghton <jthoughton@google.com>
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 include/linux/mm_types.h |  4 ++++
 mm/hugetlb.c             |  2 +-
 mm/shmem.c               |  9 ++++++---
 mm/userfaultfd.c         | 37 +++++++++++++++++++++++++++----------
 4 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0234f14f2aa6..2f26ee9742bf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1429,6 +1429,9 @@ enum tlb_flush_reason {
  * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
  *                        We should only access orig_pte if this flag set.
  * @FAULT_FLAG_VMA_LOCK: The fault is handled under VMA lock.
+ * @FAULT_FLAG_USERFAULT_CONTINUE: The fault handler must not call userfaultfd
+ *                                 minor handler as it is being called by the
+ *                                 userfaultfd code itself.
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -1467,6 +1470,7 @@ enum fault_flag {
 	FAULT_FLAG_UNSHARE =		1 << 10,
 	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
 	FAULT_FLAG_VMA_LOCK =		1 << 12,
+	FAULT_FLAG_USERFAULT_CONTINUE = 1 << 13,
 };
 
 typedef unsigned int __bitwise zap_flags_t;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 97930d44d460..c004cfdcd4e2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6228,7 +6228,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		}
 
 		/* Check for page in userfault range. */
-		if (userfaultfd_minor(vma)) {
+		if (userfaultfd_minor(vma) && !(vmf->flags & FAULT_FLAG_USERFAULT_CONTINUE)) {
 			folio_unlock(folio);
 			folio_put(folio);
 			/* See comment in userfaultfd_missing() block above */
diff --git a/mm/shmem.c b/mm/shmem.c
index 1ede0800e846..b4159303fe59 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2467,7 +2467,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	fault_mm = vma ? vma->vm_mm : NULL;
 
 	folio = filemap_get_entry(inode->i_mapping, index);
-	if (folio && vma && userfaultfd_minor(vma)) {
+	if (folio && vma && userfaultfd_minor(vma) &&
+	    !(vmf->flags & FAULT_FLAG_USERFAULT_CONTINUE)) {
 		if (!xa_is_value(folio))
 			folio_put(folio);
 		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
@@ -2727,6 +2728,8 @@ static vm_fault_t shmem_falloc_wait(struct vm_fault *vmf, struct inode *inode)
 static vm_fault_t shmem_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
+	enum sgp_type sgp = vmf->flags & FAULT_FLAG_USERFAULT_CONTINUE ?
+	    SGP_NOALLOC : SGP_CACHE;
 	gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
 	struct folio *folio = NULL;
 	vm_fault_t ret = 0;
@@ -2743,8 +2746,8 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 	}
 
 	WARN_ON_ONCE(vmf->page != NULL);
-	err = shmem_get_folio_gfp(inode, vmf->pgoff, 0, &folio, SGP_CACHE,
-				  gfp, vmf, &ret);
+	err = shmem_get_folio_gfp(inode, vmf->pgoff, 0, &folio, sgp, gfp, vmf,
+				  &ret);
 	if (err)
 		return vmf_error(err);
 	if (folio) {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index d06453fa8aba..4b3dbc7dac64 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -380,30 +380,47 @@ static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 	return ret;
 }
 
-/* Handles UFFDIO_CONTINUE for all shmem VMAs (shared or private). */
+/* Handles UFFDIO_CONTINUE for all VMAs */
 static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 				     struct vm_area_struct *dst_vma,
 				     unsigned long dst_addr,
 				     uffd_flags_t flags)
 {
-	struct inode *inode = file_inode(dst_vma->vm_file);
-	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
 	struct folio *folio;
 	struct page *page;
 	int ret;
+	struct vm_fault vmf = {
+		.vma = dst_vma,
+		.address = dst_addr,
+		.flags = FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE |
+		    FAULT_FLAG_USERFAULT_CONTINUE,
+		.pte = NULL,
+		.page = NULL,
+		.pgoff = linear_page_index(dst_vma, dst_addr),
+	};
+
+	if (!dst_vma->vm_ops || !dst_vma->vm_ops->fault)
+		return -EINVAL;
 
-	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
-	/* Our caller expects us to return -EFAULT if we failed to find folio */
-	if (ret == -ENOENT)
+retry:
+	ret = dst_vma->vm_ops->fault(&vmf);
+	if (ret & VM_FAULT_ERROR) {
 		ret = -EFAULT;
-	if (ret)
 		goto out;
-	if (!folio) {
-		ret = -EFAULT;
+	}
+
+	if (ret & VM_FAULT_NOPAGE) {
+		ret = -EAGAIN;
 		goto out;
 	}
 
-	page = folio_file_page(folio, pgoff);
+	if (ret & VM_FAULT_RETRY)
+		goto retry;
+
+	page = vmf.page;
+	folio = page_folio(page);
+	BUG_ON(!folio);
+
 	if (PageHWPoison(page)) {
 		ret = -EIO;
 		goto out_release;
-- 
2.47.1


