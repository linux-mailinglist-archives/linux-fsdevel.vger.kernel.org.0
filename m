Return-Path: <linux-fsdevel+bounces-49051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B476CAB79DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9723C188AE63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6640252917;
	Wed, 14 May 2025 23:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3WPbM3Qt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F72517BC
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266220; cv=none; b=KNpC6KswPhPtOUuy5VtwwEvk047V7peRbEXuRfz7yoWTjliKtRVbs3TZvdS7BHiRMxr6Z327YnSulDvOtKjG3yce0BZbHyWuqAj2/+00Q7bq/K6kxMRCqBWvlLvSJtIYvyvcaC8qGcWZKOkiHQ+T4Oy6dQ4SHgcr6+Pl7RTxchk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266220; c=relaxed/simple;
	bh=CY4bTSNeZPPROcrIeiO6I6OWg6zoDnaqUze/3Ax9ufY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CSZ5dyKC7sZCh0XE63oQTe65ElY8fiD1Q9atBbacfLGVMNHyIVmRhZDmkuF29ncAH7Om/tJAWyIZ3yQFc+gI/2q9OMgZkNCY08XyJeR3r6W7qzaOYy9gJbV2+0tsAXpY7B60nlXhbArHoiSHrrwqDQXzjDKUqiv4eBlj9WUmxms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3WPbM3Qt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ab4d56096so389027a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266218; x=1747871018; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTxikc62gZoeyz7SAyFK4qZ9SsMpsyITZnnPziBCTKM=;
        b=3WPbM3Qt1NsRnOqdUxu1QcT2TteijobkjfB1GDWiQ3yCZ9ikwO37owIj+f6KUnW9/r
         SkFh6VxNKJtQoZOz+lu2sBXsBPrmTrko5gIb9NWcidO6uO5vNyL4FcGOqK8odH1jBl6O
         o1hCR1YQ+exUl8k/NggB3TuZGcej2Q4H/9aXsnpmbmzW0OKF7XNqtO52jWvbQoaeg5zC
         52dlZ9W4fPRvHbD1Um8zyArC7Tktugd5+lHNsLGIRauceioORIUzyUxmRU73YPX5WlbY
         18FIex+5eTOrHntGB1HmRcxq2h6i5iD/GbE/SKqIzxK4fLQsPM26ivqp6yuJ+bziDNY6
         STZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266218; x=1747871018;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTxikc62gZoeyz7SAyFK4qZ9SsMpsyITZnnPziBCTKM=;
        b=Y6NwcQNX6D92LxJEVHNSbvpL4lk19mdR2kDh2AaEbwq9bXFC33MBKv13OrVKbccLQD
         OcLM+flNADZJeGTXaR7GQsI8Qgj0b+7CwO1DPfF4X6fIZNp/4V5wBLDnqXcaC4T0M6FW
         K8TZpFuJGE6qJSVca7rG4KxgG/V/yWCPTQclVfW60iuvdUxgi4/5PoIq8HuKnS87r5Qb
         F2CoERZoDjdcrd//WoitGFOZ4Y1En80EuxV8fdyGGpe9f+hTorKJQdNu5nDafw/dLEHL
         YOYgJYbIPFSKtuQV5UN6zwIbtpTlJ6K8UvhHTgGM7yTzgRSbXp225sURIxOaLfeaZhQD
         4KtA==
X-Forwarded-Encrypted: i=1; AJvYcCUvZd2CRyWKXUqCc/HpBkYigjuoDtaoejGAljpyYJ6WE+x39AQ5TbpZWMFiIZgNl/Xij7kUUX0h3FOMbj6f@vger.kernel.org
X-Gm-Message-State: AOJu0YxUJZqk2DcROfv0BG3wesMmQpvIS8gV0UZiDKip2SUVTXxAul8z
	jviF0PwuyCI1OKq7xpzZUBRunrg2M1QiOX9k8/T0d5kK2DQES0aQeUcC6NTt1R1L7LUmvV0QNlr
	KpB1lpTs+sHoqq9WhpvCKdg==
X-Google-Smtp-Source: AGHT+IElJzF9b5y9iQhVl4MWgA/5M09NCf7n3sHbhDGMjoGMq56uDKR3Aes/09IOTbaGDebGEYQU1jlk3yzx6ggjqQ==
X-Received: from pjxx15.prod.google.com ([2002:a17:90b:58cf:b0:2f9:c349:2f84])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d8b:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-30e2e616623mr10140667a91.17.1747266217551;
 Wed, 14 May 2025 16:43:37 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:05 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <3a897dc919d25951816cba95dd53bfeb2ea6e581.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 26/51] mm: Consolidate freeing of typed folios on final folio_put()
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: ackerleytng@google.com, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

From: Fuad Tabba <tabba@google.com>

Some folio types, such as hugetlb, handle freeing their own folios.

The guestmem_hugetlb folio, to be introduced in a later patch,
requires extra handling as part of the freeing process.

As a first step towards that, this patch consolidates freeing folios
that have a type. The first user is hugetlb folios. Later in this
patch series, guestmem_hugetlb will become the second user of this.

Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I881dc58ca89603ddd1e8e1ccca8f5dbfc80c43be
---
 include/linux/page-flags.h | 15 +++++++++++++++
 mm/swap.c                  | 23 ++++++++++++++++++-----
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index e6a21b62dcce..9dd60fb8c33f 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -985,6 +985,21 @@ static inline bool page_has_type(const struct page *page)
 	return page_mapcount_is_type(data_race(page->page_type));
 }
 
+static inline int page_get_type(const struct page *page)
+{
+	return page->page_type >> 24;
+}
+
+static inline bool folio_has_type(const struct folio *folio)
+{
+	return page_has_type(&folio->page);
+}
+
+static inline int folio_get_type(const struct folio *folio)
+{
+	return page_get_type(&folio->page);
+}
+
 #define FOLIO_TYPE_OPS(lname, fname)					\
 static __always_inline bool folio_test_##fname(const struct folio *folio) \
 {									\
diff --git a/mm/swap.c b/mm/swap.c
index 77b2d5997873..d0a5971787c4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -94,6 +94,19 @@ static void page_cache_release(struct folio *folio)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
 }
 
+static void free_typed_folio(struct folio *folio)
+{
+	switch (folio_get_type(folio)) {
+#ifdef CONFIG_HUGETLBFS
+	case PGTY_hugetlb:
+		free_huge_folio(folio);
+		return;
+#endif
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+
 void __folio_put(struct folio *folio)
 {
 	if (unlikely(folio_is_zone_device(folio))) {
@@ -101,8 +114,8 @@ void __folio_put(struct folio *folio)
 		return;
 	}
 
-	if (folio_test_hugetlb(folio)) {
-		free_huge_folio(folio);
+	if (unlikely(folio_has_type(folio))) {
+		free_typed_folio(folio);
 		return;
 	}
 
@@ -964,13 +977,13 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 		if (!folio_ref_sub_and_test(folio, nr_refs))
 			continue;
 
-		/* hugetlb has its own memcg */
-		if (folio_test_hugetlb(folio)) {
+		if (unlikely(folio_has_type(folio))) {
+			/* typed folios have their own memcg, if any */
 			if (lruvec) {
 				unlock_page_lruvec_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
-			free_huge_folio(folio);
+			free_typed_folio(folio);
 			continue;
 		}
 		folio_unqueue_deferred_split(folio);
-- 
2.49.0.1045.g170613ef41-goog


