Return-Path: <linux-fsdevel+bounces-78775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBHgB337oWl4yAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:15:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ED81BD6D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 167EF31DAF68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B248E477E2C;
	Fri, 27 Feb 2026 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgnVpkaH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0FD450915;
	Fri, 27 Feb 2026 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223015; cv=none; b=qJx3doZU3KPZ5EYLd48MBQ9+1//7OXAQ2t85AoE2B0Bg4nMOnOqbZ6YSoSVUhMb7VPkAmKUXj0l04o4C7yBTmVT9w4G3MBEXpP4kr3xUE8BsGYzxKvImQcdBYDPMD1R/LjppzZRoVOticTY9MhvMbBb6AoUJ8NQv9/i/KvNW0ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223015; c=relaxed/simple;
	bh=hLgJdGT31V5wnxVFe1vHLMNm/KVuWNy5vLAGWsJg21c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdBRGP/AorCTiUizlOro3HgbqYs03tAHClIsvQszwO7aYsckVoKxQFtFc0e7/wl7NZ502oUVM7t/j1Kqrs/q9Vm43g/M0YVR81jtXNMHUU91EvuNhnp5WwzShU6tQuoUbaHRSgc94VUoSq0/zJ7T+JFTU7Phu39hv/1UaxMQTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgnVpkaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E261C116C6;
	Fri, 27 Feb 2026 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772223014;
	bh=hLgJdGT31V5wnxVFe1vHLMNm/KVuWNy5vLAGWsJg21c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgnVpkaHaAkciLTAeL0+EHoy6ULSwuu9fj3VyFkgJooaJcw9CuTij8hQME2UbVNWD
	 Yvc/lVRhwFa8DPT/JmgPCmNWacY7labSQ2afT1BQfoxShbwEJk2Jn8z7NxsGfCsqtz
	 PFpbCDhsNtcpqdguKU2gvD4AUwof1y66dauCjiXbAiMN6CyWf4CltYotNxCjssrHCp
	 /q9YFMkt4jNd7FScndseUUa/D3NnepYZOmjVGGfCd+L3Hgug9STuzNp9OaPEgAhBvJ
	 WiDRQIsjsWJIIKTyzXG8Pn+MIUoCY9cTsDjzXp52+rtBZSOfNAH+NerJi1RRj2Hxlh
	 G0ODowk2+zwXQ==
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
Subject: [PATCH v1 04/16] mm/memory: simplify calculation in unmap_mapping_range_tree()
Date: Fri, 27 Feb 2026 21:08:35 +0100
Message-ID: <20260227200848.114019-5-david@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,ziepe.ca,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,vger.kernel.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-78775-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8ED81BD6D8
X-Rspamd-Action: no action

Let's simplify the calculation a bit further to make it easier to get,
reusing vma_last_pgoff() which we move from interval_tree.c to mm.h.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm.h |  5 +++++
 mm/interval_tree.c |  5 -----
 mm/memory.c        | 12 +++++-------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a8138ff7d1fa..d3ef586ee1c0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4000,6 +4000,11 @@ static inline unsigned long vma_pages(const struct vm_area_struct *vma)
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
 
+static inline unsigned long vma_last_pgoff(struct vm_area_struct *vma)
+{
+	return vma->vm_pgoff + vma_pages(vma) - 1;
+}
+
 static inline unsigned long vma_desc_size(const struct vm_area_desc *desc)
 {
 	return desc->end - desc->start;
diff --git a/mm/interval_tree.c b/mm/interval_tree.c
index 32e390c42c53..32bcfbfcf15f 100644
--- a/mm/interval_tree.c
+++ b/mm/interval_tree.c
@@ -15,11 +15,6 @@ static inline unsigned long vma_start_pgoff(struct vm_area_struct *v)
 	return v->vm_pgoff;
 }
 
-static inline unsigned long vma_last_pgoff(struct vm_area_struct *v)
-{
-	return v->vm_pgoff + vma_pages(v) - 1;
-}
-
 INTERVAL_TREE_DEFINE(struct vm_area_struct, shared.rb,
 		     unsigned long, shared.rb_subtree_last,
 		     vma_start_pgoff, vma_last_pgoff, /* empty */, vma_interval_tree)
diff --git a/mm/memory.c b/mm/memory.c
index 5c47309331f5..e4154f03feac 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4227,17 +4227,15 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
 					    struct zap_details *details)
 {
 	struct vm_area_struct *vma;
-	pgoff_t vba, vea, zba, zea;
 	unsigned long start, size;
 	struct mmu_gather tlb;
 
 	vma_interval_tree_foreach(vma, root, first_index, last_index) {
-		vba = vma->vm_pgoff;
-		vea = vba + vma_pages(vma) - 1;
-		zba = max(first_index, vba);
-		zea = min(last_index, vea);
-		start = ((zba - vba) << PAGE_SHIFT) + vma->vm_start;
-		size = (zea - zba + 1) << PAGE_SHIFT;
+		const pgoff_t start_idx = max(first_index, vma->vm_pgoff);
+		const pgoff_t end_idx = min(last_index, vma_last_pgoff(vma)) + 1;
+
+		start = vma->vm_start + ((start_idx - vma->vm_pgoff) << PAGE_SHIFT);
+		size = (end_idx - start_idx) << PAGE_SHIFT;
 
 		tlb_gather_mmu(&tlb, vma->vm_mm);
 		zap_page_range_single_batched(&tlb, vma, start, size, details);
-- 
2.43.0


