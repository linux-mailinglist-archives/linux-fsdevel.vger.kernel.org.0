Return-Path: <linux-fsdevel+bounces-59824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74349B3E32E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297D23AC670
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0C534A33E;
	Mon,  1 Sep 2025 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aHgTrVy+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561FB346A11
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729852; cv=none; b=CKogv0HuqBiK4uTy86wXohQLBDbMvfm4T59y0DiCAMcgMVs7pJKfMYnaTr4LYgk6IpN+XG+4XWCcSxOITEPSl10NuNSKzPTvHgPKcIZXaeS+WmnHv36UIJZC6Vi6YxmeO7efx0PwWHlbYv13cc4CI/vdxRdHbiOkV7tWKeNP8zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729852; c=relaxed/simple;
	bh=EPJbyRWxHnT9AgTmdS6KO9CuajUKQ+wmYGiqrI3ZBAk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhYxov95/NGVfG7Oh5Nq2yteMvhgUfxK98Qhd8x2i8Yy6YWDlvns2ZDBtWSHmHGJGzua0c7jDrWfe9JH+EcciPCoeFMjYHc2eoDIJvGbH0bSHd5Bim/dSxTVeJylIjmXKubj6rhWBTNr10oQwkPhmj/VjbAXJhBArdJx5ivCLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aHgTrVy+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61e8fe26614so2177852a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729849; x=1757334649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDGNHui84WsHVpXgfTg7/ZQpp3R8ARaLofrymMcz4P4=;
        b=aHgTrVy+UXwL9vMATMLTBzYygvkvl1PXOOkgjbsIQG3AtnAibegqVurFbnCgst5vw3
         Tdn6BM6pdncPEzEN9ifHpCA8P6Pi4hRjnYSm2XHIsHhjBoa2yZ23NHuGkS26Mta2ynDG
         hHyJrdulDtB0BpZ5BnpS002ShEm4bThnIuHBA36CXsVQXZQl8TLN9ouFxkOu79st1Lun
         n/4mA3ksechY3UCwBukK3jOeMXCtdgFo4nnd+QD7ghAwOcthXOafw9+qg7Ty7/sIIJGA
         Xon6LXD5Nx/5nBd1kfpFV4EZRE0nIo8tJwVUDxwZbsqTwpnlVC8IN3f1JRwVMOGUYrZL
         3tqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729849; x=1757334649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDGNHui84WsHVpXgfTg7/ZQpp3R8ARaLofrymMcz4P4=;
        b=COXpKnq9aK2tx9KgCs3I6+ncX/FyW/A+XoHLeLDV+pB6RYGky/eTnA+BRdgF+n5LRV
         RY/WmVR6sxEwcJprhupPFjV+5Ejh42NiROWNUuivRnPnJkE2L2tGDiXiJXIrXC4I5ta9
         4D1ddslyLeOmfanPicQNoQdGZd24nR4TCSAHPrFzHrXOju65KVPHvHldwmxUshjCDiWE
         U0fDTAbxPD8UMc8ZoupMxvVH10cHKgf7P3qa1LSaYskMr5fwbRRz6613TlnQuQIu6lI2
         DTQND0z5FcnGpSggs2Q2QbM6lXj5HsUWmpbch4jqFtqqSEVr5U6MjriYU0Uao9vl+uYP
         Zjqg==
X-Forwarded-Encrypted: i=1; AJvYcCXaUEkasIh3+TN3k3hrQmaExL0XRndudj7mUJe+XB82BOcHN+secOSfBg1kZPfDXqzOewXCrNfO160gryd2@vger.kernel.org
X-Gm-Message-State: AOJu0YyYdBDGWUEvIUO03+ql6o7lK2GKGuulOaPSPpRFpM3Q6s9YnMad
	z9pSJ3Ljy2hgS4dm7MzbHsk4XkbyVvX/5gc7hAXZs9Hm9m2nrhkCFGeA9+cnrunvHZs=
X-Gm-Gg: ASbGncuRr7J2gLYbqXUWY7vxextFs2jaRu6b07JUH0WTx28+zgEfH+at94oLq3kS1Pb
	z08rHxKooAQLs0QlL0ysn7ZDdD8xH0g9AUwBn1GHiSuI39MurkeZ7iWw9su1zWRVlXOqhQ3vhGg
	0KTTFPLKYKDSL596p+d8ulH/9He6S6Da/bBZFwNQX1eOv0aUdyGlzcjhs/GOZvbn/rPTk4hukiN
	9jHE0URjUjmSnvNZWpsNyrayWqqRAv2v2X5YrlSuCJwWa6bSmdSacEv1bnH7wbymcGO/lUeISZq
	iA+YK/hMRNhuQq4Cs1BDhyIK4aq0whM0cPX8BcUi+W+0nvhkCdny11HLqOJAWNqGnsjW8PzaM7+
	ARQK+qcnQBhKOAJ00femLYpVgX+TyKUlIDZT27kZTD7VDzPheRaM0MRPfJb4IWZAwr/N+HDPclI
	Jtj5pC9G6nKo/CVoAxWOj57cFi2JUen4Ph
X-Google-Smtp-Source: AGHT+IFKdIH/XV8PMBLWofBOVQFCiNzD1MryqiWSI9A5CR0R39RCWddVIJNZ79UXnDKy/e8yeVnjDw==
X-Received: by 2002:a05:6402:2549:b0:618:afa:70b1 with SMTP id 4fb4d7f45d1cf-61d26c32e70mr6177153a12.20.1756729848021;
        Mon, 01 Sep 2025 05:30:48 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:47 -0700 (PDT)
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
Subject: [PATCH v5 08/12] mm: constify arch_pick_mmap_layout() for improved const-correctness
Date: Mon,  1 Sep 2025 14:30:24 +0200
Message-ID: <20250901123028.3383461-9-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901123028.3383461-1-max.kellermann@ionos.com>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function only reads from the rlimit pointer (but writes to the
mm_struct pointer which is kept without `const`).

All callees are already const-ified or (internal functions) are being
constified by this patch.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/s390/mm/mmap.c              | 5 +++--
 arch/sparc/kernel/sys_sparc_64.c | 3 ++-
 arch/x86/mm/mmap.c               | 7 ++++---
 include/linux/sched/mm.h         | 4 ++--
 mm/util.c                        | 9 ++++++---
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index c0f619fb9ab3..a47c7133d82a 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -47,7 +47,7 @@ static unsigned long mmap_base_legacy(unsigned long rnd)
 }
 
 static inline unsigned long mmap_base(unsigned long rnd,
-				      struct rlimit *rlim_stack)
+				      const struct rlimit *const rlim_stack)
 {
 	unsigned long gap = rlim_stack->rlim_cur;
 	unsigned long pad = stack_maxrandom_size() + stack_guard_gap;
@@ -169,7 +169,8 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
  * This function, called very early during the creation of a new
  * process VM image, sets up which VM layout function to use:
  */
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *const mm,
+			   const struct rlimit *const rlim_stack)
 {
 	unsigned long random_factor = 0UL;
 
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 785e9909340f..1c243bb461b2 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -294,7 +294,8 @@ static unsigned long mmap_rnd(void)
 	return rnd << PAGE_SHIFT;
 }
 
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *const mm,
+			   const struct rlimit *const rlim_stack)
 {
 	unsigned long random_factor = mmap_rnd();
 	unsigned long gap;
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index 708f85dc9380..13bde4ba2f24 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -80,7 +80,7 @@ unsigned long arch_mmap_rnd(void)
 }
 
 static unsigned long mmap_base(unsigned long rnd, unsigned long task_size,
-			       struct rlimit *rlim_stack)
+			       const struct rlimit *const rlim_stack)
 {
 	unsigned long gap = rlim_stack->rlim_cur;
 	unsigned long pad = stack_maxrandom_size(task_size) + stack_guard_gap;
@@ -110,7 +110,7 @@ static unsigned long mmap_legacy_base(unsigned long rnd,
  */
 static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
 		unsigned long random_factor, unsigned long task_size,
-		struct rlimit *rlim_stack)
+		const struct rlimit *const rlim_stack)
 {
 	*legacy_base = mmap_legacy_base(random_factor, task_size);
 	if (mmap_is_legacy())
@@ -119,7 +119,8 @@ static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
 		*base = mmap_base(random_factor, task_size, rlim_stack);
 }
 
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *const mm,
+			   const struct rlimit *const rlim_stack)
 {
 	if (mmap_is_legacy())
 		mm_flags_clear(MMF_TOPDOWN, mm);
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2201da0afecc..0232d983b715 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -178,7 +178,7 @@ static inline void mm_update_next_owner(struct mm_struct *mm)
 #endif
 
 extern void arch_pick_mmap_layout(struct mm_struct *mm,
-				  struct rlimit *rlim_stack);
+				  const struct rlimit *rlim_stack);
 
 unsigned long
 arch_get_unmapped_area(struct file *filp, unsigned long addr,
@@ -211,7 +211,7 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 				  unsigned long flags, vm_flags_t vm_flags);
 #else
 static inline void arch_pick_mmap_layout(struct mm_struct *mm,
-					 struct rlimit *rlim_stack) {}
+					 const struct rlimit *rlim_stack) {}
 #endif
 
 static inline bool in_vfork(struct task_struct *tsk)
diff --git a/mm/util.c b/mm/util.c
index f5a35efba7bf..24f08217cd95 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -431,7 +431,8 @@ static int mmap_is_legacy(const struct rlimit *const rlim_stack)
 #define MIN_GAP		(SZ_128M)
 #define MAX_GAP		(STACK_TOP / 6 * 5)
 
-static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
+static unsigned long mmap_base(const unsigned long rnd,
+			       const struct rlimit *const rlim_stack)
 {
 #ifdef CONFIG_STACK_GROWSUP
 	/*
@@ -462,7 +463,8 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
 #endif
 }
 
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *const mm,
+			   const struct rlimit *const rlim_stack)
 {
 	unsigned long random_factor = 0UL;
 
@@ -478,7 +480,8 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	}
 }
 #elif defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *const mm,
+			   const struct rlimit *const rlim_stack)
 {
 	mm->mmap_base = TASK_UNMAPPED_BASE;
 	mm_flags_clear(MMF_TOPDOWN, mm);
-- 
2.47.2


