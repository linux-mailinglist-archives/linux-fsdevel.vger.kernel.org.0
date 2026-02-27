Return-Path: <linux-fsdevel+bounces-78787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PenMw38oWl4yAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:18:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4B31BD7AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6F4F309B595
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4F647AF46;
	Fri, 27 Feb 2026 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmPRcYz6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8561D86DC;
	Fri, 27 Feb 2026 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223180; cv=none; b=SehRYKtr5RMIkU+SGUaTpC98WC8sIOF/yGoUuNC2ieLKvVDm4R3n4kZGp3Oi8PvrTu/j989M7cpFR7qeq5jd7Z7hfOMy4/+uzQEFsBt9Yc+Ke+cV9PtC2C/4ORW8JRoFiOTpZ5zEj8j9pldNg1sHfFXpKMjDk2PPd1kXHhNeW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223180; c=relaxed/simple;
	bh=EEBn7CIEirsPder1HwHu0zod3+a5jIJfhj8EcLUi1fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxQBA+g07oC1ABkGYH+XLQJ3VWutKFxRsO2VAeGmEY+V5Uo8v5AORi1rhlJboTgyDrjAPSVZAOYYIcQqGjHana41LhDesDKlXE0hDmy/Sud1mr1Vk01mQxNKc0TU8QRr6s5/XpRk09MYb7Mki1gXcS2ScjAsWy1yq+EP+bOOxB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmPRcYz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4803DC116C6;
	Fri, 27 Feb 2026 20:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772223179;
	bh=EEBn7CIEirsPder1HwHu0zod3+a5jIJfhj8EcLUi1fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmPRcYz6lMupOBBWcIq2xxzw3ZjqLWbh14Q/EzEzzNOPR2bXzATrQ2or0dA35uMRH
	 qQSbMuAtuGPbagAqsNu+bWeITN3fvbriqugq0wAAivv3oBid5ydJfxz6kgH0ggobHr
	 FcqROWqyx31WFNdZnxZqeabN5HI3T4ByIsihTtRpKekFZlg/CHSxlrBVD1TU/sPfLX
	 PtMx1nnJm8R4PN5iGseQ/FJczpNis/rWhHyMfhYrvINAqI8qSVqCSM1beRCreQXnWF
	 uj0oTpBBfR/1UoZQaN9rvvSM//RXewIO1Dwy6rYXGjaI0s2HIGsuNkmVQpYm8jSfVj
	 CC7PaJu+lCODg==
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
Subject: [PATCH v1 14/16] mm: rename zap_page_range_single() to zap_vma_range()
Date: Fri, 27 Feb 2026 21:08:45 +0100
Message-ID: <20260227200848.114019-15-david@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,ziepe.ca,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,vger.kernel.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-78787-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA4B31BD7AF
X-Rspamd-Action: no action

Let's rename it to make it better match our new naming scheme.

While at it, polish the kerneldoc.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/s390/mm/gmap_helpers.c          |  2 +-
 drivers/android/binder/page_range.rs |  4 ++--
 drivers/android/binder_alloc.c       |  2 +-
 include/linux/mm.h                   |  4 ++--
 kernel/bpf/arena.c                   |  2 +-
 kernel/events/core.c                 |  2 +-
 mm/madvise.c                         |  4 ++--
 mm/memory.c                          | 14 +++++++-------
 net/ipv4/tcp.c                       |  6 +++---
 rust/kernel/mm/virt.rs               |  4 ++--
 10 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index ae2d59a19313..f8789ffcc05c 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -89,7 +89,7 @@ void gmap_helper_discard(struct mm_struct *mm, unsigned long vmaddr, unsigned lo
 		if (!vma)
 			return;
 		if (!is_vm_hugetlb_page(vma))
-			zap_page_range_single(vma, vmaddr, min(end, vma->vm_end) - vmaddr);
+			zap_vma_range(vma, vmaddr, min(end, vma->vm_end) - vmaddr);
 		vmaddr = vma->vm_end;
 	}
 }
diff --git a/drivers/android/binder/page_range.rs b/drivers/android/binder/page_range.rs
index fdd97112ef5c..2fddd4ed8d4c 100644
--- a/drivers/android/binder/page_range.rs
+++ b/drivers/android/binder/page_range.rs
@@ -130,7 +130,7 @@ pub(crate) struct ShrinkablePageRange {
     pid: Pid,
     /// The mm for the relevant process.
     mm: ARef<Mm>,
-    /// Used to synchronize calls to `vm_insert_page` and `zap_page_range_single`.
+    /// Used to synchronize calls to `vm_insert_page` and `zap_vma_range`.
     #[pin]
     mm_lock: Mutex<()>,
     /// Spinlock protecting changes to pages.
@@ -719,7 +719,7 @@ fn drop(self: Pin<&mut Self>) {
 
     if let Some(vma) = mmap_read.vma_lookup(vma_addr) {
         let user_page_addr = vma_addr + (page_index << PAGE_SHIFT);
-        vma.zap_page_range_single(user_page_addr, PAGE_SIZE);
+        vma.zap_vma_range(user_page_addr, PAGE_SIZE);
     }
 
     drop(mmap_read);
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index dd2046bd5cde..e4488ad86a65 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1185,7 +1185,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	if (vma) {
 		trace_binder_unmap_user_start(alloc, index);
 
-		zap_page_range_single(vma, page_addr, PAGE_SIZE);
+		zap_vma_range(vma, page_addr, PAGE_SIZE);
 
 		trace_binder_unmap_user_end(alloc, index);
 	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4bd1500b9630..833bedd3f739 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2835,7 +2835,7 @@ struct page *vm_normal_page_pud(struct vm_area_struct *vma, unsigned long addr,
 
 void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 		  unsigned long size);
-void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
+void zap_vma_range(struct vm_area_struct *vma, unsigned long address,
 			   unsigned long size);
 /**
  * zap_vma - zap all page table entries in a vma
@@ -2843,7 +2843,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
  */
 static inline void zap_vma(struct vm_area_struct *vma)
 {
-	zap_page_range_single(vma, vma->vm_start, vma->vm_end - vma->vm_start);
+	zap_vma_range(vma, vma->vm_start, vma->vm_end - vma->vm_start);
 }
 struct mmu_notifier_range;
 
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index c34510d83b1f..37843c6a4764 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -656,7 +656,7 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 	guard(mutex)(&arena->lock);
 	/* iterate link list under lock */
 	list_for_each_entry(vml, &arena->vma_list, head)
-		zap_page_range_single(vml->vma, uaddr, PAGE_SIZE * page_cnt);
+		zap_vma_range(vml->vma, uaddr, PAGE_SIZE * page_cnt);
 }
 
 static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c94c56c94104..5ee02817c3bc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7215,7 +7215,7 @@ static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
 #ifdef CONFIG_MMU
 	/* Clear any partial mappings on error. */
 	if (err)
-		zap_page_range_single(vma, vma->vm_start, nr_pages * PAGE_SIZE);
+		zap_vma_range(vma, vma->vm_start, nr_pages * PAGE_SIZE);
 #endif
 
 	return err;
diff --git a/mm/madvise.c b/mm/madvise.c
index fb5fcdff2b66..6e66f56ff1a6 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -832,7 +832,7 @@ static int madvise_free_single_vma(struct madvise_behavior *madv_behavior)
  * Application no longer needs these pages.  If the pages are dirty,
  * it's OK to just throw them away.  The app will be more careful about
  * data it wants to keep.  Be sure to free swap resources too.  The
- * zap_page_range_single call sets things up for shrink_active_list to actually
+ * zap_vma_range call sets things up for shrink_active_list to actually
  * free these pages later if no one else has touched them in the meantime,
  * although we could add these pages to a global reuse list for
  * shrink_active_list to pick up before reclaiming other pages.
@@ -1191,7 +1191,7 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
 		 * OK some of the range have non-guard pages mapped, zap
 		 * them. This leaves existing guard pages in place.
 		 */
-		zap_page_range_single(vma, range->start, range->end - range->start);
+		zap_vma_range(vma, range->start, range->end - range->start);
 	}
 
 	/*
diff --git a/mm/memory.c b/mm/memory.c
index e611e9af4e85..dd737b6d28c0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2215,14 +2215,14 @@ void zap_vma_range_batched(struct mmu_gather *tlb,
 }
 
 /**
- * zap_page_range_single - remove user pages in a given range
- * @vma: vm_area_struct holding the applicable pages
- * @address: starting address of pages to zap
+ * zap_vma_range - zap all page table entries in a vma range
+ * @vma: the vma covering the range to zap
+ * @address: starting address of the range to zap
  * @size: number of bytes to zap
  *
- * The range must fit into one VMA.
+ * The provided address range must be fully contained within @vma.
  */
-void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
+void zap_vma_range(struct vm_area_struct *vma, unsigned long address,
 		unsigned long size)
 {
 	struct mmu_gather tlb;
@@ -2250,7 +2250,7 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 	    		!(vma->vm_flags & VM_PFNMAP))
 		return;
 
-	zap_page_range_single(vma, address, size);
+	zap_vma_range(vma, address, size);
 }
 EXPORT_SYMBOL_GPL(zap_vma_ptes);
 
@@ -3018,7 +3018,7 @@ static int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long add
 	 * maintain page reference counts, and callers may free
 	 * pages due to the error. So zap it early.
 	 */
-	zap_page_range_single(vma, addr, size);
+	zap_vma_range(vma, addr, size);
 	return error;
 }
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index befcde27dee7..cb4477ef1529 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2104,7 +2104,7 @@ static int tcp_zerocopy_vm_insert_batch_error(struct vm_area_struct *vma,
 		maybe_zap_len = total_bytes_to_map -  /* All bytes to map */
 				*length + /* Mapped or pending */
 				(pages_remaining * PAGE_SIZE); /* Failed map. */
-		zap_page_range_single(vma, *address, maybe_zap_len);
+		zap_vma_range(vma, *address, maybe_zap_len);
 		err = 0;
 	}
 
@@ -2112,7 +2112,7 @@ static int tcp_zerocopy_vm_insert_batch_error(struct vm_area_struct *vma,
 		unsigned long leftover_pages = pages_remaining;
 		int bytes_mapped;
 
-		/* We called zap_page_range_single, try to reinsert. */
+		/* We called zap_vma_range, try to reinsert. */
 		err = vm_insert_pages(vma, *address,
 				      pending_pages,
 				      &pages_remaining);
@@ -2269,7 +2269,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
 	total_bytes_to_map = avail_len & ~(PAGE_SIZE - 1);
 	if (total_bytes_to_map) {
 		if (!(zc->flags & TCP_RECEIVE_ZEROCOPY_FLAG_TLB_CLEAN_HINT))
-			zap_page_range_single(vma, address, total_bytes_to_map);
+			zap_vma_range(vma, address, total_bytes_to_map);
 		zc->length = total_bytes_to_map;
 		zc->recv_skip_hint = 0;
 	} else {
diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index b8e59e4420f3..04b3cc925d67 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -113,7 +113,7 @@ pub fn end(&self) -> usize {
     /// kernel goes further in freeing unused page tables, but for the purposes of this operation
     /// we must only assume that the leaf level is cleared.
     #[inline]
-    pub fn zap_page_range_single(&self, address: usize, size: usize) {
+    pub fn zap_vma_range(&self, address: usize, size: usize) {
         let (end, did_overflow) = address.overflowing_add(size);
         if did_overflow || address < self.start() || self.end() < end {
             // TODO: call WARN_ONCE once Rust version of it is added
@@ -124,7 +124,7 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
         // sufficient for this method call. This method has no requirements on the vma flags. The
         // address range is checked to be within the vma.
         unsafe {
-            bindings::zap_page_range_single(self.as_ptr(), address, size)
+            bindings::zap_vma_range(self.as_ptr(), address, size)
         };
     }
 
-- 
2.43.0


