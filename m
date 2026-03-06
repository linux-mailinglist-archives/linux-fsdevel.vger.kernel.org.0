Return-Path: <linux-fsdevel+bounces-79646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEHEIUwNq2k/ZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 18:22:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E825225F2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 18:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E884B308E84B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 17:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ADC43CEFE;
	Fri,  6 Mar 2026 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muO0cZ9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9C93FFAB0;
	Fri,  6 Mar 2026 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817556; cv=none; b=CKQl5Fj87rbRl3H4BZJezVhcn5Ab0/7f6wJIGcNQ40ySfPNyF5Z54QTc3WPaONb1SUBbcWA8blpCajSmZSQhQzkPoG4fWnqnsH0+vWKUSIzv0sUGV9a9kWE4wZCfXi2aBYnDo+Wn+n4enIRnLgrWB0a0XSiw87O0rfoTzKLbzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817556; c=relaxed/simple;
	bh=/0oNlg7fiYv022nxhnrVEoCU64mvQSwuS01zGUwLSsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxGfjO9xzgbFXBrFus4WMN8D8ztGQZOP/OJFBm96Jp8Uo+wZiLFZlNM9bFv3JKjXJDKDWgrCMo03BMOiWemIQTjxOhAsQvn4Bz3+B0SLNP0PtbzmY73kHamBvGUQOJhlP22DA0kKTMsyK+8RmJJ7FCywsmQ4oDbhrqmB/Nk+Vhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muO0cZ9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C953C19425;
	Fri,  6 Mar 2026 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772817556;
	bh=/0oNlg7fiYv022nxhnrVEoCU64mvQSwuS01zGUwLSsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=muO0cZ9r+JBiL14XaQg5yw9LiQxGht59+apEgASJ2jR3LGxBAL2DsQtktz4uqSNqJ
	 PkXHY04N+jL5v3G1MiqgSB6TbYGHqdBDSNAWY/aNjQxFtJSBEK0S22O0Y9wGNaJP17
	 In19HrRalevmDmNv5JBdAdSrm7ZCxnFnlXDD6srzq008AVs4fRuyfSBrSnPz+RHps5
	 1lQ+eH6EvtYxUo4N0NJqRwDFaYVUx8J7UuASQtNTGCIpna7WU5kGuspoZHDKNb5Pl7
	 dHZou2u+P4ijg57yiLXnqs07Bf41RlHmXBQ2PWIXWVKS2bD7DRkDLEXTYWCMpSCDpW
	 ThUH3wtwpnBqA==
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
Subject: [PATCH v2 08/15] shmem, userfaultfd: use a VMA callback to handle UFFDIO_CONTINUE
Date: Fri,  6 Mar 2026 19:18:08 +0200
Message-ID: <20260306171815.3160826-9-rppt@kernel.org>
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
X-Rspamd-Queue-Id: 1E825225F2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79646-lists,linux-fsdevel=lfdr.de];
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

When userspace resolves a page fault in a shmem VMA with UFFDIO_CONTINUE
it needs to get a folio that already exists in the pagecache backing
that VMA.

Instead of using shmem_get_folio() for that, add a get_folio_noalloc()
method to 'struct vm_uffd_ops' that will return a folio if it exists in
the VMA's pagecache at given pgoff.

Implement get_folio_noalloc() method for shmem and slightly refactor
userfaultfd's mfill_get_vma() and mfill_atomic_pte_continue() to support
this new API.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/userfaultfd_k.h |  7 +++++++
 mm/shmem.c                    | 15 ++++++++++++++-
 mm/userfaultfd.c              | 32 ++++++++++++++++----------------
 3 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 56e85ab166c7..66dfc3c164e6 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -84,6 +84,13 @@ extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 struct vm_uffd_ops {
 	/* Checks if a VMA can support userfaultfd */
 	bool (*can_userfault)(struct vm_area_struct *vma, vm_flags_t vm_flags);
+	/*
+	 * Called to resolve UFFDIO_CONTINUE request.
+	 * Should return the folio found at pgoff in the VMA's pagecache if it
+	 * exists or ERR_PTR otherwise.
+	 * The returned folio is locked and with reference held.
+	 */
+	struct folio *(*get_folio_noalloc)(struct inode *inode, pgoff_t pgoff);
 };
 
 /* A combined operation mode + behavior flags. */
diff --git a/mm/shmem.c b/mm/shmem.c
index f2a25805b9bf..7bd887b64f62 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3295,13 +3295,26 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 	return ret;
 }
 
+static struct folio *shmem_get_folio_noalloc(struct inode *inode, pgoff_t pgoff)
+{
+	struct folio *folio;
+	int err;
+
+	err = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
+	if (err)
+		return ERR_PTR(err);
+
+	return folio;
+}
+
 static bool shmem_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags)
 {
 	return true;
 }
 
 static const struct vm_uffd_ops shmem_uffd_ops = {
-	.can_userfault	= shmem_can_userfault,
+	.can_userfault		= shmem_can_userfault,
+	.get_folio_noalloc	= shmem_get_folio_noalloc,
 };
 #endif /* CONFIG_USERFAULTFD */
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index b55d4a8d88cc..98ade14eaa5b 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -191,6 +191,7 @@ static int mfill_get_vma(struct mfill_state *state)
 	struct userfaultfd_ctx *ctx = state->ctx;
 	uffd_flags_t flags = state->flags;
 	struct vm_area_struct *dst_vma;
+	const struct vm_uffd_ops *ops;
 	int err;
 
 	/*
@@ -231,10 +232,12 @@ static int mfill_get_vma(struct mfill_state *state)
 	if (is_vm_hugetlb_page(dst_vma))
 		goto out;
 
-	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
+	ops = vma_uffd_ops(dst_vma);
+	if (!ops)
 		goto out_unlock;
-	if (!vma_is_shmem(dst_vma) &&
-	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
+
+	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE) &&
+	    !ops->get_folio_noalloc)
 		goto out_unlock;
 
 out:
@@ -577,6 +580,7 @@ static int mfill_atomic_pte_zeropage(struct mfill_state *state)
 static int mfill_atomic_pte_continue(struct mfill_state *state)
 {
 	struct vm_area_struct *dst_vma = state->vma;
+	const struct vm_uffd_ops *ops = vma_uffd_ops(dst_vma);
 	unsigned long dst_addr = state->dst_addr;
 	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
 	struct inode *inode = file_inode(dst_vma->vm_file);
@@ -586,16 +590,13 @@ static int mfill_atomic_pte_continue(struct mfill_state *state)
 	struct page *page;
 	int ret;
 
-	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
+	if (!ops)
+		return -EOPNOTSUPP;
+
+	folio = ops->get_folio_noalloc(inode, pgoff);
 	/* Our caller expects us to return -EFAULT if we failed to find folio */
-	if (ret == -ENOENT)
-		ret = -EFAULT;
-	if (ret)
-		goto out;
-	if (!folio) {
-		ret = -EFAULT;
-		goto out;
-	}
+	if (IS_ERR_OR_NULL(folio))
+		return -EFAULT;
 
 	page = folio_file_page(folio, pgoff);
 	if (PageHWPoison(page)) {
@@ -609,13 +610,12 @@ static int mfill_atomic_pte_continue(struct mfill_state *state)
 		goto out_release;
 
 	folio_unlock(folio);
-	ret = 0;
-out:
-	return ret;
+	return 0;
+
 out_release:
 	folio_unlock(folio);
 	folio_put(folio);
-	goto out;
+	return ret;
 }
 
 /* Handles UFFDIO_POISON for all non-hugetlb VMAs. */
-- 
2.51.0


