Return-Path: <linux-fsdevel+bounces-78782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIcqMmH7oWl4yAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:15:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4861BD6B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3582C30A1459
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E463847AF64;
	Fri, 27 Feb 2026 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+uZFzLt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608E0478E27;
	Fri, 27 Feb 2026 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223098; cv=none; b=pnxmZrU0VPfIfar41Wy/2dfSYflfpX/dVe2m/iH+QQ78bx0PodPW++oAJzeKTdsbwnB3JKkV8+Ro/TVFX14RVKIdiAohHBzjGmAEVhDegt1BOpwoP/wxiwwOytoGX1r4iYE0LcmFR76c45muiOpDpstr5B52qXlEtiBPKVBLouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223098; c=relaxed/simple;
	bh=KcfCcPy+dBQFq2iZWWRAzMkc9iA3mhQIqe4VKvKm/84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Es3tNLruDZ8BRldSbrztSDLpD95RQYXczH+wkVwMDCaB0UMMbu2ST5bcqF7cdhrt3m42B49q99q/Azv3vfFVEPJbOVx8sExf7zi86DeEZHoG+GkgWykwaSyhx2C+6Pu9m/N02pdrR3dJybk8K7R5ADxMPQChpaadBZtqk/ZNZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+uZFzLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83C0C2BC86;
	Fri, 27 Feb 2026 20:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772223098;
	bh=KcfCcPy+dBQFq2iZWWRAzMkc9iA3mhQIqe4VKvKm/84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+uZFzLtdrG65b8hmVxNKYNlrS/AesJe5C0CdRLLG0CXN4yBdaUTdPL6zW++yDFfV
	 d9morv+7a1pkXjkKZLGhg42leomEsG3yOY/LUvmeI7p74dvImpIdlZ+hVxW2bRPJa1
	 EnR+f8uCtq2nwqb4bowrT5fporOqCSIT2OWtiwOHYZKKevZ2sqcl0dhKRiXN/W1VTf
	 T3JnjgarvGwRpiC+6sbx7CJfmMTNXMJbxZ+2eZvxX9FSc8qEYjP7BB1HwU+r3h1AXj
	 QaDl1DJbAtFutxlyg3qP2d0PNjBvS5b6oUjoQZ0i0yJpmByBkdKGovCyF8vwNHNDEe
	 YwpOXuN0+M/Ig==
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
Subject: [PATCH v1 09/16] mm/memory: convert details->even_cows into details->skip_cows
Date: Fri, 27 Feb 2026 21:08:40 +0100
Message-ID: <20260227200848.114019-10-david@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,ziepe.ca,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,vger.kernel.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-78782-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: AA4861BD6B1
X-Rspamd-Action: no action

The current semantics are confusing: simply because someone specifies an
empty zap_detail struct suddenly makes should_zap_cows() behave
differently. The default should be to also zap CoW'ed anonymous pages.

Really only unmap_mapping_pages() and friends want to skip zapping of
these anon folios.

So let's invert the meaning; turn the confusing "reclaim_pt" check that
overrides other properties in should_zap_cows() into a safety check.

Note that the only caller that sets reclaim_pt=true is
madvise_dontneed_single_vma(), which wants to zap any pages.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm.h |  2 +-
 mm/madvise.c       |  1 -
 mm/memory.c        | 12 ++++++------
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d3ef586ee1c0..21b67c203e62 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2798,7 +2798,7 @@ extern void pagefault_out_of_memory(void);
  */
 struct zap_details {
 	struct folio *single_folio;	/* Locked folio to be unmapped */
-	bool even_cows;			/* Zap COWed private pages too? */
+	bool skip_cows;			/* Do not zap COWed private pages */
 	bool reclaim_pt;		/* Need reclaim page tables? */
 	zap_flags_t zap_flags;		/* Extra flags for zapping */
 };
diff --git a/mm/madvise.c b/mm/madvise.c
index 557a360f7919..b51f216934f3 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -853,7 +853,6 @@ static long madvise_dontneed_single_vma(struct madvise_behavior *madv_behavior)
 	struct madvise_behavior_range *range = &madv_behavior->range;
 	struct zap_details details = {
 		.reclaim_pt = true,
-		.even_cows = true,
 	};
 
 	zap_page_range_single_batched(
diff --git a/mm/memory.c b/mm/memory.c
index fdcd2abf29c2..7d7c24c6917c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1554,11 +1554,13 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 static inline bool should_zap_cows(struct zap_details *details)
 {
 	/* By default, zap all pages */
-	if (!details || details->reclaim_pt)
+	if (!details)
 		return true;
 
+	VM_WARN_ON_ONCE(details->skip_cows && details->reclaim_pt);
+
 	/* Or, we zap COWed pages only if the caller wants to */
-	return details->even_cows;
+	return !details->skip_cows;
 }
 
 /* Decides whether we should zap this folio with the folio pointer specified */
@@ -2149,8 +2151,6 @@ void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap)
 	struct mmu_notifier_range range;
 	struct zap_details details = {
 		.zap_flags = ZAP_FLAG_DROP_MARKER | ZAP_FLAG_UNMAP,
-		/* Careful - we need to zap private pages too! */
-		.even_cows = true,
 	};
 
 	vma = unmap->first;
@@ -4282,7 +4282,7 @@ void unmap_mapping_folio(struct folio *folio)
 	first_index = folio->index;
 	last_index = folio_next_index(folio) - 1;
 
-	details.even_cows = false;
+	details.skip_cows = true;
 	details.single_folio = folio;
 	details.zap_flags = ZAP_FLAG_DROP_MARKER;
 
@@ -4312,7 +4312,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
 	pgoff_t	first_index = start;
 	pgoff_t	last_index = start + nr - 1;
 
-	details.even_cows = even_cows;
+	details.skip_cows = !even_cows;
 	if (last_index < first_index)
 		last_index = ULONG_MAX;
 
-- 
2.43.0


