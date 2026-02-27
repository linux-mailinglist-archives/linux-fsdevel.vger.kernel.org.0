Return-Path: <linux-fsdevel+bounces-78780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLiCBTL8oWl4yAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:18:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFAD1BD7F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABDD23095C62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB0C478876;
	Fri, 27 Feb 2026 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYP8hi5N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED56472782;
	Fri, 27 Feb 2026 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223081; cv=none; b=OKgK/7cHFPocTQcqodpchbOKM7mMFwNu/DIv0UgdF3N+hWPZIzFbT0FqMZRdl+wdvE+OHIJtCg/55kOsIzmluWkskTsqMPyaGET3fGz0wdpCYgUAIffPTYjmBfjm66+RC13AtdA+xQ3Gce1bbEqZb+ByG2FZf294Tkf6tDnsZ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223081; c=relaxed/simple;
	bh=Ms86RD0Otoj1d6fzyHR5o28Ex/YjZExC3FyxUcdS+A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuwmsR3lDvcvutfj5OE65RtDzhoVCQCNLmRnux4FIEPnVA7gKMf65IxbwF8MD8ONLGyQ4DsOTFCKKnERzcsGeCL8yBoNfUpPuRPULoWrsBZuqmZFzIwigaGZbwKuI4bB9jSjksFTCKksaH5dEq1Drbk3OkbF9qfRIp0yIExvNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYP8hi5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DAAC116C6;
	Fri, 27 Feb 2026 20:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772223081;
	bh=Ms86RD0Otoj1d6fzyHR5o28Ex/YjZExC3FyxUcdS+A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYP8hi5N5sGdSXGeQeQx0PGG2qoBngPOdHIav4EUqj7du6tyiIkdIqI1w8m/NqulN
	 yXTxgx+g53/5ilvSpYisK6g/8IOBFrnfp7OT3nq69Vw+lSxB4peBlnL7oBBrBFteR+
	 M2xZ9SjZBvkW0pqpQ/Xabhkha8T9/aSY5mi7v8CLxJ+sb4/YPmxDWucCxYnzccFDiZ
	 EBFkzzUicUwOCfYz7Mnqy0dyy3jiaAtOm+CqJElfZ27AJo9RZVjXuSUjS95x5xGJ2w
	 JLFZQYbU59MSVTJrtE+3FkB7Em2PBv3oHfoONvXgNLI0cd8vWkaGCUZ4/ZP0s9duB7
	 TSoGd5pRM7nbA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "linux-mm @ kvack . org" <linux-mm@kvack.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v1 08/16] mm/memory: move adjusting of address range to unmap_vmas()
Date: Fri, 27 Feb 2026 21:08:39 +0100
Message-ID: <20260227200848.114019-9-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227200848.114019-1-david@kernel.org>
References: <20260227200848.114019-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,ziepe.ca,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,vger.kernel.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-78780-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EFAD1BD7F3
X-Rspamd-Action: no action

__zap_vma_range() has two callers, whereby
zap_page_range_single_batched() documents that the range must fit into
the VMA range.

So move adjusting the range to unmap_vmas() where it is actually
required and add a safety check in __zap_vma_range() instead. In
unmap_vmas(), we'd never expect to have empty ranges (otherwise, why
have the vma in there in the first place).

__zap_vma_range() will no longer be called with start == end, so
cleanup the function a bit. While at it, simplify the overly long
comment to its core message.

We will no longer call uprobe_munmap() for start == end, which actually
seems to be the right thing to do.

Note that hugetlb_zap_begin()->...->adjust_range_if_pmd_sharing_possible()
cannot result in the range exceeding the vma range.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 58 +++++++++++++++++++++--------------------------------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f0aaec57a66b..fdcd2abf29c2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2073,44 +2073,28 @@ static void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	tlb_end_vma(tlb, vma);
 }
 
-
-static void __zap_vma_range(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, unsigned long start_addr,
-		unsigned long end_addr, struct zap_details *details)
+static void __zap_vma_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end,
+		struct zap_details *details)
 {
-	unsigned long start = max(vma->vm_start, start_addr);
-	unsigned long end;
-
-	if (start >= vma->vm_end)
-		return;
-	end = min(vma->vm_end, end_addr);
-	if (end <= vma->vm_start)
-		return;
+	VM_WARN_ON_ONCE(start >= end || !range_in_vma(vma, start, end));
 
 	if (vma->vm_file)
 		uprobe_munmap(vma, start, end);
 
-	if (start != end) {
-		if (unlikely(is_vm_hugetlb_page(vma))) {
-			/*
-			 * It is undesirable to test vma->vm_file as it
-			 * should be non-null for valid hugetlb area.
-			 * However, vm_file will be NULL in the error
-			 * cleanup path of mmap_region. When
-			 * hugetlbfs ->mmap method fails,
-			 * mmap_region() nullifies vma->vm_file
-			 * before calling this function to clean up.
-			 * Since no pte has actually been setup, it is
-			 * safe to do nothing in this case.
-			 */
-			if (vma->vm_file) {
-				zap_flags_t zap_flags = details ?
-				    details->zap_flags : 0;
-				__unmap_hugepage_range(tlb, vma, start, end,
-							     NULL, zap_flags);
-			}
-		} else
-			unmap_page_range(tlb, vma, start, end, details);
+	if (unlikely(is_vm_hugetlb_page(vma))) {
+		zap_flags_t zap_flags = details ? details->zap_flags : 0;
+
+		/*
+		 * vm_file will be NULL when we fail early while instantiating
+		 * a new mapping. In this case, no pages were mapped yet and
+		 * there is nothing to do.
+		 */
+		if (!vma->vm_file)
+			return;
+		__unmap_hugepage_range(tlb, vma, start, end, NULL, zap_flags);
+	} else {
+		unmap_page_range(tlb, vma, start, end, details);
 	}
 }
 
@@ -2174,8 +2158,9 @@ void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap)
 				unmap->vma_start, unmap->vma_end);
 	mmu_notifier_invalidate_range_start(&range);
 	do {
-		unsigned long start = unmap->vma_start;
-		unsigned long end = unmap->vma_end;
+		unsigned long start = max(vma->vm_start, unmap->vma_start);
+		unsigned long end = min(vma->vm_end, unmap->vma_end);
+
 		hugetlb_zap_begin(vma, &start, &end);
 		__zap_vma_range(tlb, vma, start, end, &details);
 		hugetlb_zap_end(vma, &details);
@@ -2204,6 +2189,9 @@ void zap_page_range_single_batched(struct mmu_gather *tlb,
 
 	VM_WARN_ON_ONCE(!tlb || tlb->mm != vma->vm_mm);
 
+	if (unlikely(!size))
+		return;
+
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
 				address, end);
 	hugetlb_zap_begin(vma, &range.start, &range.end);
-- 
2.43.0


