Return-Path: <linux-fsdevel+bounces-59920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE889B3F017
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 22:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FEA1A86FD1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 20:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B561A27FB37;
	Mon,  1 Sep 2025 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KtJaWD0O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37FD27F74C
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759855; cv=none; b=PrXFMivYCT1mPjhaU/jvrnNlHAhsw1ZsjwORLtLtKSBwAlcWuSzvxdAkjzYxP+IVaiUtCjXrZ0xdXAMZJevyUjygLNBAqY1l2fI5+RelL0iLGOedvE4i45JO9SwZp2UKR0qGRpRQ5cvhAQ0qS7lA9W4YUkRitYSOUob83dqt5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759855; c=relaxed/simple;
	bh=G9fQmLCfKmFA44mJm/ujwf2i5TqVTmSI2avVaselzL4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIuyYVb69oh6fYslHVC4CTUcj+gO/unhpmtf6ce5fXM9q4hqXgNJ+y1Adns6PiGIda7D+AmTcT7WHoKCiaDNOFGT78oeFcw82CZA+6afNqQtYw+kqrU4MLEqBSvJpl4vZflH9G+5bNZPGmd7U+yGtW7KnT6/oQuS720DKSlBWkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KtJaWD0O; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7a16441so730363266b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759851; x=1757364651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3uoyKSyOaO3f7nxjstRVXs4aNsGaCK5BZpTMsYSqag=;
        b=KtJaWD0OBN1VVuuda+jgLk8NC0/k1xZZ3SKPBX/0KMoGr5GtEMhmcmKpwqLMVOW/MN
         vaDuMg/Wk7xrizVBHFI0Ek/Nj11ivZ62pvECahho/Fvb2Bk/uE0euUcD1A98ufdHe6VS
         0tpinaSW1SpRX15c2xZeACGeo40LFGp65K0t2xm8lnSSTvgFLsG9uDNzXJwVoY0/82uJ
         LcXtCjWeMMr+oZ0ZJwEL9zpvhSqyXeHkCnoSH52I1GX4CYUKEQecrdO2N4kd2VwnAg4Q
         Y8Gi0GHpWkq8OwIjfaFXsY5YDo0LvwvyWYKa0p+4a2LNZtiAgoxkuoGMCyeLIG5q81XG
         GUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759851; x=1757364651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3uoyKSyOaO3f7nxjstRVXs4aNsGaCK5BZpTMsYSqag=;
        b=hwyOd8qnQLbwZbavq3MY7QT34DGbXaERChhUayBiaCN+WySx4Xc2zs0WR/KWkYKrJe
         wjYRkvPk+B7kgE7G01Lp2LPEF0OYtzoqLb9JB5nFZ6Aechn1gWPcEXxG23okWn5seqI6
         o5evbM6sEosyiVQbVfGceOjXNbSRDNOcBdc1OHd2ELoQGAm/d6R4qqYaIobVDXifaX8a
         V3MWJ8z6uMnFpnm/+msH9KoLvH/osvOiJFJLi6QwBlfBKcsiRGulbjOBYOBW00Cgi/uV
         te/NpXP8v7/4unnip8FYtJTPPVOhIX2a3mEZFY20e9SckKvO7p66Q8TsSXCY1xYmzESg
         qoCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAC8Gk6PvUFyeBFY2STSiIHnorB3jdJ7Am6Enasecrh227cEOj0JCdup4qgPQclQpawXyL3El4U3DSlHMs@vger.kernel.org
X-Gm-Message-State: AOJu0YyU6ZjPH5QylwGrVjJAcrRVxPWN8sE5sY19C0SzTaux4UFDTped
	jZyEB/LLzaLjcMhm3EZOm8YmQtjHDYwY9npyh4ZZemVKSLKG32JFu9Jx86PswWFyt5A=
X-Gm-Gg: ASbGncuYlLan/LK3QUZSMBp4f1Mg+Omw9/qZ3PDiHt7brUDq6gdBG4VVSt5VvKLn5+X
	yAseDM/cIladz7qlCKRlyISbpiJomEDwjc9BoOh4ZagIJegDm/qA8vGG6ZGebDB/1TnRO1X2QSO
	D/iL4pZ29V3QzKyNX3HoxDPB4d2RMGCkl1M/iq0dMifa+nt/WO7R9cffLw7jfnQ2xVh8t0AiIBD
	8C0uO/bU7E3VtpxF3/GcVf+le531UJdTeew/4AT/uRs1WrTQ81jFdRH2BsQaa2USnKh7Tye3cd8
	Ao/iR3QcTfP4WU6tp1agm1OcdRv7ionVHzHuBpiCacZltAuDmHbpJPev9949vlCKW8MKgUnRczU
	mG/8tCHlRqtSZEDFeOyDuFO19Vox3M92mT4clnBeWU/n7939v3BUrFZrBDbwObEVmT+Pklhrd7h
	HYK267b2F4WfT28+AyDV66JPT6S9uaZxFQ
X-Google-Smtp-Source: AGHT+IHpQqCA9H+O3+CE5gTkKZKcF7k6oI5kQsi6mdSUrMDC8NBoCachyUvtoP/lhYVN+0jVOidhhg==
X-Received: by 2002:a17:907:9611:b0:afe:74a3:f78b with SMTP id a640c23a62f3a-b01d98b4c39mr886692466b.59.1756759850966;
        Mon, 01 Sep 2025 13:50:50 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:50 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 12/12] mm: constify highmem related functions for improved const-correctness
Date: Mon,  1 Sep 2025 22:50:21 +0200
Message-ID: <20250901205021.3573313-13-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lots of functions in mm/highmem.c do not write to the given pointers
and do not call functions that take non-const pointers and can
therefore be constified.

This includes functions like kunmap() which might be implemented in a
way that writes to the pointer (e.g. to update reference counters or
mapping fields), but currently are not.

kmap() on the other hand cannot be made const because it calls
set_page_address() which is non-const in some
architectures/configurations.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/arm/include/asm/highmem.h    |  6 +++---
 arch/xtensa/include/asm/highmem.h |  2 +-
 include/linux/highmem-internal.h  | 36 +++++++++++++++----------------
 include/linux/highmem.h           |  8 +++----
 mm/highmem.c                      | 10 ++++-----
 5 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index b4b66220952d..bdb209e002a4 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -46,9 +46,9 @@ extern pte_t *pkmap_page_table;
 #endif
 
 #ifdef ARCH_NEEDS_KMAP_HIGH_GET
-extern void *kmap_high_get(struct page *page);
+extern void *kmap_high_get(const struct page *page);
 
-static inline void *arch_kmap_local_high_get(struct page *page)
+static inline void *arch_kmap_local_high_get(const struct page *page)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !cache_is_vivt())
 		return NULL;
@@ -57,7 +57,7 @@ static inline void *arch_kmap_local_high_get(struct page *page)
 #define arch_kmap_local_high_get arch_kmap_local_high_get
 
 #else /* ARCH_NEEDS_KMAP_HIGH_GET */
-static inline void *kmap_high_get(struct page *page)
+static inline void *kmap_high_get(const struct page *page)
 {
 	return NULL;
 }
diff --git a/arch/xtensa/include/asm/highmem.h b/arch/xtensa/include/asm/highmem.h
index 34b8b620e7f1..b55235f4adac 100644
--- a/arch/xtensa/include/asm/highmem.h
+++ b/arch/xtensa/include/asm/highmem.h
@@ -29,7 +29,7 @@
 
 #if DCACHE_WAY_SIZE > PAGE_SIZE
 #define get_pkmap_color get_pkmap_color
-static inline int get_pkmap_color(struct page *page)
+static inline int get_pkmap_color(const struct page *page)
 {
 	return DCACHE_ALIAS(page_to_phys(page));
 }
diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 36053c3d6d64..0574c21ca45d 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -7,7 +7,7 @@
  */
 #ifdef CONFIG_KMAP_LOCAL
 void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
-void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
+void *__kmap_local_page_prot(const struct page *page, pgprot_t prot);
 void kunmap_local_indexed(const void *vaddr);
 void kmap_local_fork(struct task_struct *tsk);
 void __kmap_local_sched_out(void);
@@ -33,7 +33,7 @@ static inline void kmap_flush_tlb(unsigned long addr) { }
 #endif
 
 void *kmap_high(struct page *page);
-void kunmap_high(struct page *page);
+void kunmap_high(const struct page *page);
 void __kmap_flush_unused(void);
 struct page *__kmap_to_page(void *addr);
 
@@ -50,7 +50,7 @@ static inline void *kmap(struct page *page)
 	return addr;
 }
 
-static inline void kunmap(struct page *page)
+static inline void kunmap(const struct page *page)
 {
 	might_sleep();
 	if (!PageHighMem(page))
@@ -68,12 +68,12 @@ static inline void kmap_flush_unused(void)
 	__kmap_flush_unused();
 }
 
-static inline void *kmap_local_page(struct page *page)
+static inline void *kmap_local_page(const struct page *page)
 {
 	return __kmap_local_page_prot(page, kmap_prot);
 }
 
-static inline void *kmap_local_page_try_from_panic(struct page *page)
+static inline void *kmap_local_page_try_from_panic(const struct page *page)
 {
 	if (!PageHighMem(page))
 		return page_address(page);
@@ -81,13 +81,13 @@ static inline void *kmap_local_page_try_from_panic(struct page *page)
 	return NULL;
 }
 
-static inline void *kmap_local_folio(struct folio *folio, size_t offset)
+static inline void *kmap_local_folio(const struct folio *folio, size_t offset)
 {
-	struct page *page = folio_page(folio, offset / PAGE_SIZE);
+	const struct page *page = folio_page(folio, offset / PAGE_SIZE);
 	return __kmap_local_page_prot(page, kmap_prot) + offset % PAGE_SIZE;
 }
 
-static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_local_page_prot(const struct page *page, pgprot_t prot)
 {
 	return __kmap_local_page_prot(page, prot);
 }
@@ -102,7 +102,7 @@ static inline void __kunmap_local(const void *vaddr)
 	kunmap_local_indexed(vaddr);
 }
 
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_atomic_prot(const struct page *page, pgprot_t prot)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		migrate_disable();
@@ -113,7 +113,7 @@ static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 	return __kmap_local_page_prot(page, prot);
 }
 
-static inline void *kmap_atomic(struct page *page)
+static inline void *kmap_atomic(const struct page *page)
 {
 	return kmap_atomic_prot(page, kmap_prot);
 }
@@ -173,32 +173,32 @@ static inline void *kmap(struct page *page)
 	return page_address(page);
 }
 
-static inline void kunmap_high(struct page *page) { }
+static inline void kunmap_high(const struct page *page) { }
 static inline void kmap_flush_unused(void) { }
 
-static inline void kunmap(struct page *page)
+static inline void kunmap(const struct page *page)
 {
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(page_address(page));
 #endif
 }
 
-static inline void *kmap_local_page(struct page *page)
+static inline void *kmap_local_page(const struct page *page)
 {
 	return page_address(page);
 }
 
-static inline void *kmap_local_page_try_from_panic(struct page *page)
+static inline void *kmap_local_page_try_from_panic(const struct page *page)
 {
 	return page_address(page);
 }
 
-static inline void *kmap_local_folio(struct folio *folio, size_t offset)
+static inline void *kmap_local_folio(const struct folio *folio, size_t offset)
 {
 	return folio_address(folio) + offset;
 }
 
-static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_local_page_prot(const struct page *page, pgprot_t prot)
 {
 	return kmap_local_page(page);
 }
@@ -215,7 +215,7 @@ static inline void __kunmap_local(const void *addr)
 #endif
 }
 
-static inline void *kmap_atomic(struct page *page)
+static inline void *kmap_atomic(const struct page *page)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		migrate_disable();
@@ -225,7 +225,7 @@ static inline void *kmap_atomic(struct page *page)
 	return page_address(page);
 }
 
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_atomic_prot(const struct page *page, pgprot_t prot)
 {
 	return kmap_atomic(page);
 }
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6234f316468c..105cc4c00cc3 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -43,7 +43,7 @@ static inline void *kmap(struct page *page);
  * Counterpart to kmap(). A NOOP for CONFIG_HIGHMEM=n and for mappings of
  * pages in the low memory area.
  */
-static inline void kunmap(struct page *page);
+static inline void kunmap(const struct page *page);
 
 /**
  * kmap_to_page - Get the page for a kmap'ed address
@@ -93,7 +93,7 @@ static inline void kmap_flush_unused(void);
  * disabling migration in order to keep the virtual address stable across
  * preemption. No caller of kmap_local_page() can rely on this side effect.
  */
-static inline void *kmap_local_page(struct page *page);
+static inline void *kmap_local_page(const struct page *page);
 
 /**
  * kmap_local_folio - Map a page in this folio for temporary usage
@@ -129,7 +129,7 @@ static inline void *kmap_local_page(struct page *page);
  * Context: Can be invoked from any context.
  * Return: The virtual address of @offset.
  */
-static inline void *kmap_local_folio(struct folio *folio, size_t offset);
+static inline void *kmap_local_folio(const struct folio *folio, size_t offset);
 
 /**
  * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
@@ -176,7 +176,7 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
  * kunmap_atomic(vaddr2);
  * kunmap_atomic(vaddr1);
  */
-static inline void *kmap_atomic(struct page *page);
+static inline void *kmap_atomic(const struct page *page);
 
 /* Highmem related interfaces for management code */
 static inline unsigned long nr_free_highpages(void);
diff --git a/mm/highmem.c b/mm/highmem.c
index ef3189b36cad..b5c8e4c2d5d4 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -61,7 +61,7 @@ static inline int kmap_local_calc_idx(int idx)
 /*
  * Determine color of virtual address where the page should be mapped.
  */
-static inline unsigned int get_pkmap_color(struct page *page)
+static inline unsigned int get_pkmap_color(const struct page *page)
 {
 	return 0;
 }
@@ -334,7 +334,7 @@ EXPORT_SYMBOL(kmap_high);
  *
  * This can be called from any context.
  */
-void *kmap_high_get(struct page *page)
+void *kmap_high_get(const struct page *page)
 {
 	unsigned long vaddr, flags;
 
@@ -356,7 +356,7 @@ void *kmap_high_get(struct page *page)
  * If ARCH_NEEDS_KMAP_HIGH_GET is not defined then this may be called
  * only from user context.
  */
-void kunmap_high(struct page *page)
+void kunmap_high(const struct page *page)
 {
 	unsigned long vaddr;
 	unsigned long nr;
@@ -508,7 +508,7 @@ static inline void kmap_local_idx_pop(void)
 #endif
 
 #ifndef arch_kmap_local_high_get
-static inline void *arch_kmap_local_high_get(struct page *page)
+static inline void *arch_kmap_local_high_get(const struct page *page)
 {
 	return NULL;
 }
@@ -572,7 +572,7 @@ void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
 }
 EXPORT_SYMBOL_GPL(__kmap_local_pfn_prot);
 
-void *__kmap_local_page_prot(struct page *page, pgprot_t prot)
+void *__kmap_local_page_prot(const struct page *page, pgprot_t prot)
 {
 	void *kmap;
 
-- 
2.47.2


