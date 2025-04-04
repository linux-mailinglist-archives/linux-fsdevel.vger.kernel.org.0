Return-Path: <linux-fsdevel+bounces-45777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347F4A7C0E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 17:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BBE917BBB3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401551F7580;
	Fri,  4 Apr 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="koZrHj+Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0A41F5619;
	Fri,  4 Apr 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781482; cv=none; b=Vycmi+nl8rn/xGhb86psanK6m5rzJB4AbQa5LyihBNcSipSrB5RWcTMWOPbHjRYjzmsw+Bj2Bv2poeNaAB7A3Fqj+lz96Bew+oyAL+5fCX5Wws6sBXsUMuUrZSf9eEcX+KKTaPjgIlj/D64e4HEQjH115HzchMuKHG9HpZscF+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781482; c=relaxed/simple;
	bh=Zqlld3krwRFainf0w6FOLkLziDdo9PB2J5/SAXPM7D4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9CZxDKVmA+kHFdvUYHWUNf+k0DZLFy4fKUG4ecGzsOA1CPgfki0QH81qS4Vwysda8redOJnpYGB10GLse5TeBvgyE6Nfi5lfU3YDpdmzflFchYIjgBtdeWlcY09f4U4aqMAfDLU+qbZX2UcFp6y/Np6LBxaD7g5gqPVM5/gGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=koZrHj+Z; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743781481; x=1775317481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wZsvbmbu/0jS7xgl288uAUsGSomu15ez6E6onuR11lQ=;
  b=koZrHj+ZUX8Tznh94BPVVGjZd/4GUX94cStFTwOwqvCgje4VFH0Wm7Hl
   NNDqRQ5xYOxGqFA4u/iaVY/Y0HAzMhJ6B2ibwJSxYRxQDwfbFRYJ01PQm
   ah32QbEDCXxGMv4JzfPzufR3As00TYFVcQfTR8dYKEj/BjQ4Jibt7DPG2
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,188,1739836800"; 
   d="scan'208";a="508886507"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 15:44:36 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:55309]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.140:2525] with esmtp (Farcaster)
 id 2332ab5f-8f03-4ed5-a407-5ac2d770b39b; Fri, 4 Apr 2025 15:44:35 +0000 (UTC)
X-Farcaster-Flow-ID: 2332ab5f-8f03-4ed5-a407-5ac2d770b39b
Received: from EX19D020UWC003.ant.amazon.com (10.13.138.187) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 15:44:34 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D020UWC003.ant.amazon.com (10.13.138.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 15:44:33 +0000
Received: from email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 15:44:33 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com (Postfix) with ESMTPS id 3EB8EA02DE;
	Fri,  4 Apr 2025 15:44:31 +0000 (UTC)
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
Subject: [PATCH v3 3/6] mm: userfaultfd: use can_userfault vma operation
Date: Fri, 4 Apr 2025 15:43:49 +0000
Message-ID: <20250404154352.23078-4-kalyazin@amazon.com>
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

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 include/linux/userfaultfd_k.h | 13 ++++++-------
 mm/userfaultfd.c              | 10 +++++++---
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 75342022d144..64551e8a55fb 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -221,8 +221,8 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 	if (vm_flags & VM_DROPPABLE)
 		return false;
 
-	if ((vm_flags & VM_UFFD_MINOR) &&
-	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
+	if (!vma->vm_ops->can_userfault ||
+	    !vma->vm_ops->can_userfault(vma, VM_UFFD_MINOR))
 		return false;
 
 	/*
@@ -235,16 +235,15 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 #ifndef CONFIG_PTE_MARKER_UFFD_WP
 	/*
 	 * If user requested uffd-wp but not enabled pte markers for
-	 * uffd-wp, then shmem & hugetlbfs are not supported but only
-	 * anonymous.
+	 * uffd-wp, then only anonymous is supported.
 	 */
 	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
 		return false;
 #endif
 
-	/* By default, allow any of anon|shmem|hugetlb */
-	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
-	    vma_is_shmem(vma);
+	return vma_is_anonymous(vma) ||
+	    (vma->vm_ops->can_userfault &&
+	     vma->vm_ops->can_userfault(vma, vm_flags));
 }
 
 static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 4b3dbc7dac64..0aa82c968e16 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -728,6 +728,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	unsigned long src_addr, dst_addr;
 	long copied;
 	struct folio *folio;
+	bool can_userfault;
 
 	/*
 	 * Sanitize the command parameters:
@@ -787,10 +788,13 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
 					     src_start, len, flags);
 
-	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
+	can_userfault = dst_vma->vm_ops->can_userfault &&
+	    dst_vma->vm_ops->can_userfault(dst_vma, __VM_UFFD_FLAGS);
+
+	if (!vma_is_anonymous(dst_vma) && !can_userfault)
 		goto out_unlock;
-	if (!vma_is_shmem(dst_vma) &&
-	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
+
+	if (!can_userfault && uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
 		goto out_unlock;
 
 	while (src_addr < src_start + len) {
-- 
2.47.1


