Return-Path: <linux-fsdevel+bounces-45776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22887A7C0D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 17:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B8C17BD8A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A32A1F8676;
	Fri,  4 Apr 2025 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QVFG3Qax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66311F4E57;
	Fri,  4 Apr 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781469; cv=none; b=IcFMGsj8RPXwlHt4YNJdwRFpQPpxYE25QAQa+RxvVRKKMB48bulgI3Tmp3DJsMSguZ2/9vuEOcoZOYhMEtfYiqehwRfp+R3G490TRyGpaBVp57mkzdCNoTtilZldweXh5X+/BBvnGkiXeB5AcEKzz3AyEc9KXTyvpirM88Q8XiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781469; c=relaxed/simple;
	bh=SInnc81YoyJKGYedRoWj/e7x6DFjSaGbOR4nt0IIepQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbUYJBUfrFq374GYhmwP4mOw2bz/vR0wVAqYrxPpJhu6F7Md2F1HinlrD3XOSEZ98QhbOkifC/5IUQKHIgqXnMctRcquF6wyt/lSlJyKzljVoxMABwe3eHNF3ttYk/zH/NryZLk+TcxXdhMfJ4hUIHA5uf7+Pwd7hi0Ah+xFMWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QVFG3Qax; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743781468; x=1775317468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dh/0PI2ns4oZ37OX+8TMvz834BKQ/4DyQ5yTHrbPiLw=;
  b=QVFG3QaxmCrGVKvb0SR++lXOwXXPCHhFmq3GdDqLDT7kVWJ+TY4sLZiq
   qe8FQqxwhaC5SZw/a2Q3u9T9pMfyUBiiInAqmyMELzjiqyRF+FuqaLUw4
   eOqe81x9vX3RA9cxHshwBq0sDsaF57pwIheXdCIYYtZvYICfJpVjt9C7w
   4=;
X-IronPort-AV: E=Sophos;i="6.15,188,1739836800"; 
   d="scan'208";a="732940908"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 15:44:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:37011]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id 08c94e81-d4d9-4237-8218-603f770ff779; Fri, 4 Apr 2025 15:44:21 +0000 (UTC)
X-Farcaster-Flow-ID: 08c94e81-d4d9-4237-8218-603f770ff779
Received: from EX19D003UWB003.ant.amazon.com (10.13.138.116) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 15:44:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D003UWB003.ant.amazon.com (10.13.138.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 15:44:21 +0000
Received: from email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 15:44:21 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com (Postfix) with ESMTPS id 709954032D;
	Fri,  4 Apr 2025 15:44:18 +0000 (UTC)
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
Subject: [PATCH v3 2/6] mm: provide can_userfault vma operation
Date: Fri, 4 Apr 2025 15:43:48 +0000
Message-ID: <20250404154352.23078-3-kalyazin@amazon.com>
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

The new operation allows to decouple the userfaulfd code from
dependencies to VMA types, specifically, shmem and hugetlb.  The
vm_flags bitmap argument is processed with "any" logic, meaning if the
VMA type supports any of the flags set, it returns true.  This is to
avoid multiple calls when checking for __VM_UFFD_FLAGS.

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 include/linux/mm.h | 5 +++++
 mm/hugetlb.c       | 7 +++++++
 mm/shmem.c         | 8 ++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8483e09aeb2c..488d721d8542 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -680,6 +680,11 @@ struct vm_operations_struct {
 	 */
 	struct page *(*find_special_page)(struct vm_area_struct *vma,
 					  unsigned long addr);
+	/*
+	 * True if the VMA supports userfault at least for one of the vm_flags
+	 */
+	bool (*can_userfault)(struct vm_area_struct *vma,
+			      unsigned long vm_flags);
 };
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c004cfdcd4e2..f3901c11e1fd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5143,6 +5143,12 @@ static unsigned long hugetlb_vm_op_pagesize(struct vm_area_struct *vma)
 	return huge_page_size(hstate_vma(vma));
 }
 
+static bool hugetlb_vm_op_can_userfault(struct vm_area_struct *vma,
+					unsigned long vm_flags)
+{
+	return true;
+}
+
 /*
  * We cannot handle pagefaults against hugetlb pages at all.  They cause
  * handle_mm_fault() to try to instantiate regular-sized pages in the
@@ -5168,6 +5174,7 @@ const struct vm_operations_struct hugetlb_vm_ops = {
 	.close = hugetlb_vm_op_close,
 	.may_split = hugetlb_vm_op_split,
 	.pagesize = hugetlb_vm_op_pagesize,
+	.can_userfault = hugetlb_vm_op_can_userfault,
 };
 
 static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
diff --git a/mm/shmem.c b/mm/shmem.c
index b4159303fe59..0b9e19abd1e9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2891,6 +2891,12 @@ static struct mempolicy *shmem_get_policy(struct vm_area_struct *vma,
 	return mpol_shared_policy_lookup(&SHMEM_I(inode)->policy, index);
 }
 
+static bool shmem_can_userfault(struct vm_area_struct *vma,
+				unsigned long vm_flags)
+{
+	return true;
+}
+
 static struct mempolicy *shmem_get_pgoff_policy(struct shmem_inode_info *info,
 			pgoff_t index, unsigned int order, pgoff_t *ilx)
 {
@@ -5309,6 +5315,7 @@ static const struct vm_operations_struct shmem_vm_ops = {
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
 #endif
+	.can_userfault  = shmem_can_userfault,
 };
 
 static const struct vm_operations_struct shmem_anon_vm_ops = {
@@ -5318,6 +5325,7 @@ static const struct vm_operations_struct shmem_anon_vm_ops = {
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
 #endif
+	.can_userfault  = shmem_can_userfault,
 };
 
 int shmem_init_fs_context(struct fs_context *fc)
-- 
2.47.1


