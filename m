Return-Path: <linux-fsdevel+bounces-79650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JrvD7gNq2k/ZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 18:24:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E88B422601D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 18:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 352AE305831B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 17:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9654836AB5F;
	Fri,  6 Mar 2026 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngPuMDYO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B83659F8;
	Fri,  6 Mar 2026 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817581; cv=none; b=rpf6xG9AwSd69XQH/TQcH8hN1ilu+k4MJkZuWNmPDdZ/5sLHnQrKYTZmaxZqI23HVWtS6Bf44Zu0Fxx/3bQ7JTFiwbVFIrhQ7VTourWA3wmv9ykXLUm2xxETPz0N0FRhvLRRGXMyDBU2ImHqS0h0jQScQXY+G6ijyOc5C1VeeDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817581; c=relaxed/simple;
	bh=D2z107Crk/aKX5jAkrVRRaT1KD/wz+I3gmrbuJFA7+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNeDV+7l/OW3jZyyUFmJYjOsLhw/1Jqr4paUcV25dKNHUTdwV/F4qJl5wqKviSMbbgdCrDIjwlLPnDH8vAyAp8ebEVCacEEsdo8deLb6DBdABitb4YsMVz0ieRWyxOPvkI+VsNwFI5oFqRoa80awJ4Uge70ywi09kRA8ZZ0tY94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngPuMDYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BED3C4CEF7;
	Fri,  6 Mar 2026 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772817580;
	bh=D2z107Crk/aKX5jAkrVRRaT1KD/wz+I3gmrbuJFA7+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ngPuMDYOlU0mS+ASFRSNx8uaRHF9kFKx0o8JB0Q8efPd7kbzUcnYwjsCOJjXJpfG9
	 zVkLPIpevfPpHikwzQ8vofWtaw8pOystr4JUYmsveUeFSZ27lHyXPw5IwgE34H3niA
	 6tViETw/ALirduugAdhngm9PvkddKiL8mR1puYQEBKKjXeFmqbS0PjRhhOyiIk2pLf
	 2ICVUi2AUzCNuukDh9OwdRURRDUsnfH9IHXfawgc4eaZcUzrU/genjD9gL8O0xAF8N
	 m5StoeImAE7EMg3Mih2E+7lLLKRY5i/yfXYNpa2RZDhsS13WvOMyEG+CX0bBmf/7Ax
	 rPWnW2MdDsOww==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Oscar Salvador <osalvador@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 12/15] mm: generalize handling of userfaults in __do_fault()
Date: Fri,  6 Mar 2026 19:18:12 +0200
Message-ID: <20260306171815.3160826-13-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306171815.3160826-1-rppt@kernel.org>
References: <20260306171815.3160826-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E88B422601D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79650-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.977];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Peter Xu <peterx@redhat.com>

When a VMA is registered with userfaulfd, its ->fault()
method should check if a folio exists in the page cache and call
handle_userfault() with appropriate mode:

- VM_UFFD_MINOR if VMA is registered in minor mode and the folio exists
- VM_UFFD_MISSING if VMA is registered in missing mode and the folio
  does not exist

Instead of calling handle_userfault() directly from a specific ->fault()
handler, call __do_userfault() helper from the generic __do_fault().

For VMAs registered with userfaultfd the new __do_userfault() helper
will check if the folio is found in the page cache using
vm_uffd_ops->get_folio_noalloc() and call handle_userfault() with the
appropriate mode.

Make vm_uffd_ops->get_folio_noalloc() required method for non-anonymous
VMAs mapped at PTE level.

Signed-off-by: Peter Xu <peterx@redhat.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/memory.c      | 43 +++++++++++++++++++++++++++++++++++++++++++
 mm/shmem.c       | 12 ------------
 mm/userfaultfd.c |  8 ++++++++
 3 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 07778814b4a8..e2183c44d70b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5328,6 +5328,41 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	return VM_FAULT_OOM;
 }
 
+#ifdef CONFIG_USERFAULTFD
+static vm_fault_t __do_userfault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct inode *inode;
+	struct folio *folio;
+
+	if (!(userfaultfd_missing(vma) || userfaultfd_minor(vma)))
+		return 0;
+
+	inode = file_inode(vma->vm_file);
+	folio = vma->vm_ops->uffd_ops->get_folio_noalloc(inode, vmf->pgoff);
+	if (!IS_ERR_OR_NULL(folio)) {
+		/*
+		 * TODO: provide a flag for get_folio_noalloc() to avoid
+		 * locking (or even the extra reference?)
+		 */
+		folio_unlock(folio);
+		folio_put(folio);
+		if (userfaultfd_minor(vma))
+			return handle_userfault(vmf, VM_UFFD_MINOR);
+	} else {
+		if (userfaultfd_missing(vma))
+			return handle_userfault(vmf, VM_UFFD_MISSING);
+	}
+
+	return 0;
+}
+#else
+static inline vm_fault_t __do_userfault(struct vm_fault *vmf)
+{
+	return 0;
+}
+#endif
+
 /*
  * The mmap_lock must have been held on entry, and may have been
  * released depending on flags and vma->vm_ops->fault() return value.
@@ -5360,6 +5395,14 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 			return VM_FAULT_OOM;
 	}
 
+	/*
+	 * If this is an userfaultfd trap, process it in advance before
+	 * triggering the genuine fault handler.
+	 */
+	ret = __do_userfault(vmf);
+	if (ret)
+		return ret;
+
 	ret = vma->vm_ops->fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
 			    VM_FAULT_DONE_COW)))
diff --git a/mm/shmem.c b/mm/shmem.c
index 68620caaf75f..239545352cd2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2489,13 +2489,6 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	fault_mm = vma ? vma->vm_mm : NULL;
 
 	folio = filemap_get_entry(inode->i_mapping, index);
-	if (folio && vma && userfaultfd_minor(vma)) {
-		if (!xa_is_value(folio))
-			folio_put(folio);
-		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
-		return 0;
-	}
-
 	if (xa_is_value(folio)) {
 		error = shmem_swapin_folio(inode, index, &folio,
 					   sgp, gfp, vma, fault_type);
@@ -2540,11 +2533,6 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	 * Fast cache lookup and swap lookup did not find it: allocate.
 	 */
 
-	if (vma && userfaultfd_missing(vma)) {
-		*fault_type = handle_userfault(vmf, VM_UFFD_MISSING);
-		return 0;
-	}
-
 	/* Find hugepage orders that are allowed for anonymous shmem and tmpfs. */
 	orders = shmem_allowable_huge_orders(inode, vma, index, write_end, false);
 	if (orders > 0) {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 7cd7c5d1ce84..2ac5fad0ed6c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2045,6 +2045,14 @@ bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
 	    !vma_is_anonymous(vma))
 		return false;
 
+	/*
+	 * File backed memory with PTE level mappigns must implement
+	 * ops->get_folio_noalloc()
+	 */
+	if (!vma_is_anonymous(vma) && !is_vm_hugetlb_page(vma) &&
+	    !ops->get_folio_noalloc)
+		return false;
+
 	return ops->can_userfault(vma, vm_flags);
 }
 
-- 
2.51.0


