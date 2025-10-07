Return-Path: <linux-fsdevel+bounces-63557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234C5BC21A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 18:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD95D3B2135
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421AB2E7F29;
	Tue,  7 Oct 2025 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTO/FuVc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D328113FEE
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854118; cv=none; b=UrgRUoUTho7VlBZ1NcyzAJwQmhRsrOvVpdnX+/qlh2VIlg9vjfwBfLb1KHSlyoGmoHWc6Md+cUGkabD2NQ8GnDNhNVbaQsjG7HnylKKUao+mMbzJg0d55zCgL3FkJkif97nNQcAPXBC2uhLTF/033jqGsXOU/oG85jgvyYgFzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854118; c=relaxed/simple;
	bh=lvPYZKSeQucFx2SgeOdYOtw4O2ksAxgo0FsweuBHcec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c3M0xIYyeaFg5TQ4iy/DwqTrDNT0wXuQ+3oHRfztyU+qx7A2eiH/YPgVG8Mu92gf6K2f0ucW0kZAt8dLUPaWD0YOPfHeRi20tIQ8mAewbmlJQnDm3KxupnaiQgqqzCchzsWrp5AtDN5r2DRMrsgAIFrsimPq8RsOuxETQeG4ryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTO/FuVc; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e4d34ff05so31202495e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759854115; x=1760458915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPke7s3EpbXC6ErmX/FPvC/unGHuc//hg1lOBj1qibA=;
        b=RTO/FuVcWAZEL7PyaNzslaeUaM2MzZd2AkBd4aCwmY/eTVfp7SC7HJ1ssF0PXWT08e
         maZManOa5G3BTLFmqySoNEw3vwwlVwoNXIAxXCNrsWAOjv3SOVw07aBFhUiFB77wXtz3
         6nhD2+W0v88ruT10Aig3zmbiv0c0nFaQ6eTDlcToDuP9tb8F9SbODraysTlHVItw6RP1
         A1XEvtCN3aEgO6ciA9e2aLZLR8rnAVxuHPyI5hzvTnpKt1VoigO81QBdrYn6xPUlMwTH
         p6sxaNchGfarQYj6DmEzhcNtoeIkgaKzHbiY5wn8o3E3F16Zq4WvO4unMKqAYwhA9Ohx
         ueJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759854115; x=1760458915;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPke7s3EpbXC6ErmX/FPvC/unGHuc//hg1lOBj1qibA=;
        b=s6A9+ZSCk/O91gt4wncPtNyGXVntlP0WBpoK3A/63A/Uwfzzub1sYePAg6OKaz0lGN
         ULlTr9G35TEi/a79c3NPAd3RS5cg1REejkbpoa+ZpwyxUhqyxjVP1su+DvnayBlA+5cv
         jN2e4LnZKkStFOdnHf0bd/i4JV8UYGjPHej+pMkZ4nzR5DMaVfAgM4uQR5HOLfSmldUV
         22c7jHkL+MObczltDyXi9OIislsvjIBhWNK/q/gvZnF+KUEmcCBudx+dA1c/R/GJ+N6u
         +KkWXyB2XHsEBiIxn84dpNwALFCybl3hBuG1Tex/yufR8PicH18LYoipmaZHSkRes268
         2f0A==
X-Forwarded-Encrypted: i=1; AJvYcCUCLIwJllJFljn8MXh3KLpmyGGE2nQpThHJUqNd1Vw/LWByrc78RbVgxo2ivWhZEsm2+uW5rSrzEXa74XP4@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNd7iHyI6HaM/EUbdsg0J51Tw37CiXkrsQPBvniP3ONO1bFb2
	KhksdXiCXqz2mLkImhiuDUYT1i3Yk6jEgPERVKU6F1NgcmLEfBGiOtirt/qz5FmVSKKTLPSHTu+
	kA06prKsGsCVHmiOn8Q==
X-Google-Smtp-Source: AGHT+IH9zRUnvVJnJ2rKg3ul1/L1v9CwXrOUbkfQHeRTwHBdeUKC3Y5EGru7TMDFalytr+scT+ACzRCj8l6otsM=
X-Received: from wmri12-n1.prod.google.com ([2002:a05:600c:8a0c:10b0:46e:1110:d730])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1395:b0:46e:27fb:17f0 with SMTP id 5b1f17b1804b1-46fa9aa204cmr1824285e9.9.1759854115350;
 Tue, 07 Oct 2025 09:21:55 -0700 (PDT)
Date: Tue,  7 Oct 2025 16:21:36 +0000
In-Reply-To: <20251002075202.11306-1-acsjakub@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251002075202.11306-1-acsjakub@amazon.de>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007162136.1885546-1-aliceryhl@google.com>
Subject: [PATCH] mm: use enum for vm_flags
From: Alice Ryhl <aliceryhl@google.com>
To: acsjakub@amazon.de
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, 
	chengming.zhou@linux.dev, david@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, peterx@redhat.com, 
	xu.xin16@zte.com.cn, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

The bindgen tool is better able to handle BIT(_) declarations when used
in an enum.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Hi Jakub,

what do you think about modifying the patch like this to use an enum? It
resolves the issues brought up in
	https://lore.kernel.org/all/CAH5fLghTu-Zcm9e3Hy07nNtvB_-hRjojAWDoq-hhBYGE7LPEbQ@mail.gmail.com/

Feel free to squash this patch into your patch.

 include/linux/mm.h              | 90 +++++++++++++++++----------------
 rust/bindings/bindings_helper.h |  1 -
 2 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7916d527f687..69da7ce13e50 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -273,57 +273,58 @@ extern unsigned int kobjsize(const void *objp);
  * vm_flags in vm_area_struct, see mm_types.h.
  * When changing, update also include/trace/events/mmflags.h
  */
-#define VM_NONE		0
+enum {
+	VM_NONE		= 0,
 
-#define VM_READ		BIT(0)		/* currently active flags */
-#define VM_WRITE	BIT(1)
-#define VM_EXEC		BIT(2)
-#define VM_SHARED	BIT(3)
+	VM_READ		= BIT(0),		/* currently active flags */
+	VM_WRITE	= BIT(1),
+	VM_EXEC		= BIT(2),
+	VM_SHARED	= BIT(3),
 
 /* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
-#define VM_MAYREAD	BIT(4)		/* limits for mprotect() etc */
-#define VM_MAYWRITE	BIT(5)
-#define VM_MAYEXEC	BIT(6)
-#define VM_MAYSHARE	BIT(7)
+	VM_MAYREAD	= BIT(4),		/* limits for mprotect() etc */
+	VM_MAYWRITE	= BIT(5),
+	VM_MAYEXEC	= BIT(6),
+	VM_MAYSHARE	= BIT(7),
 
-#define VM_GROWSDOWN	BIT(8)		/* general info on the segment */
+	VM_GROWSDOWN	= BIT(8),		/* general info on the segment */
 #ifdef CONFIG_MMU
-#define VM_UFFD_MISSING	BIT(9)		/* missing pages tracking */
+	VM_UFFD_MISSING	= BIT(9),		/* missing pages tracking */
 #else /* CONFIG_MMU */
-#define VM_MAYOVERLAY	BIT(9)		/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
+	VM_MAYOVERLAY	= BIT(9),		/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
 #define VM_UFFD_MISSING	0
 #endif /* CONFIG_MMU */
-#define VM_PFNMAP	BIT(10)		/* Page-ranges managed without "struct page", just pure PFN */
-#define VM_UFFD_WP	BIT(12)		/* wrprotect pages tracking */
-
-#define VM_LOCKED	BIT(13)
-#define VM_IO           BIT(14)		/* Memory mapped I/O or similar */
-
-					/* Used by sys_madvise() */
-#define VM_SEQ_READ	BIT(15)		/* App will access data sequentially */
-#define VM_RAND_READ	BIT(16)		/* App will not benefit from clustered reads */
-
-#define VM_DONTCOPY	BIT(17)		/* Do not copy this vma on fork */
-#define VM_DONTEXPAND	BIT(18)		/* Cannot expand with mremap() */
-#define VM_LOCKONFAULT	BIT(19)		/* Lock the pages covered when they are faulted in */
-#define VM_ACCOUNT	BIT(20)		/* Is a VM accounted object */
-#define VM_NORESERVE	BIT(21)		/* should the VM suppress accounting */
-#define VM_HUGETLB	BIT(22)		/* Huge TLB Page VM */
-#define VM_SYNC		BIT(23)		/* Synchronous page faults */
-#define VM_ARCH_1	BIT(24)		/* Architecture-specific flag */
-#define VM_WIPEONFORK	BIT(25)		/* Wipe VMA contents in child. */
-#define VM_DONTDUMP	BIT(26)		/* Do not include in the core dump */
+	VM_PFNMAP	= BIT(10),		/* Page-ranges managed without "struct page", just pure PFN */
+	VM_UFFD_WP	= BIT(12),		/* wrprotect pages tracking */
+
+	VM_LOCKED	= BIT(13),
+	VM_IO           = BIT(14),		/* Memory mapped I/O or similar */
+
+						/* Used by sys_madvise() */
+	VM_SEQ_READ	= BIT(15),		/* App will access data sequentially */
+	VM_RAND_READ	= BIT(16),		/* App will not benefit from clustered reads */
+
+	VM_DONTCOPY	= BIT(17),		/* Do not copy this vma on fork */
+	VM_DONTEXPAND	= BIT(18),		/* Cannot expand with mremap() */
+	VM_LOCKONFAULT	= BIT(19),		/* Lock the pages covered when they are faulted in */
+	VM_ACCOUNT	= BIT(20),		/* Is a VM accounted object */
+	VM_NORESERVE	= BIT(21),		/* should the VM suppress accounting */
+	VM_HUGETLB	= BIT(22),		/* Huge TLB Page VM */
+	VM_SYNC		= BIT(23),		/* Synchronous page faults */
+	VM_ARCH_1	= BIT(24),		/* Architecture-specific flag */
+	VM_WIPEONFORK	= BIT(25),		/* Wipe VMA contents in child. */
+	VM_DONTDUMP	= BIT(26),		/* Do not include in the core dump */
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
-# define VM_SOFTDIRTY	BIT(27)		/* Not soft dirty clean area */
+	VM_SOFTDIRTY	= BIT(27),		/* Not soft dirty clean area */
 #else
 # define VM_SOFTDIRTY	0
 #endif
 
-#define VM_MIXEDMAP	BIT(28)		/* Can contain "struct page" and pure PFN pages */
-#define VM_HUGEPAGE	BIT(29)		/* MADV_HUGEPAGE marked this vma */
-#define VM_NOHUGEPAGE	BIT(30)		/* MADV_NOHUGEPAGE marked this vma */
-#define VM_MERGEABLE	BIT(31)		/* KSM may merge identical pages */
+	VM_MIXEDMAP	= BIT(28),		/* Can contain "struct page" and pure PFN pages */
+	VM_HUGEPAGE	= BIT(29),		/* MADV_HUGEPAGE marked this vma */
+	VM_NOHUGEPAGE	= BIT(30),		/* MADV_NOHUGEPAGE marked this vma */
+	VM_MERGEABLE	= BIT(31),		/* KSM may merge identical pages */
 
 #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
 #define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
@@ -333,14 +334,15 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_6	38	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
-#define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
-#define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
-#define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
-#define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
-#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
-#define VM_HIGH_ARCH_6	BIT(VM_HIGH_ARCH_BIT_6)
+	VM_HIGH_ARCH_0	= BIT(VM_HIGH_ARCH_BIT_0),
+	VM_HIGH_ARCH_1	= BIT(VM_HIGH_ARCH_BIT_1),
+	VM_HIGH_ARCH_2	= BIT(VM_HIGH_ARCH_BIT_2),
+	VM_HIGH_ARCH_3	= BIT(VM_HIGH_ARCH_BIT_3),
+	VM_HIGH_ARCH_4	= BIT(VM_HIGH_ARCH_BIT_4),
+	VM_HIGH_ARCH_5	= BIT(VM_HIGH_ARCH_BIT_5),
+	VM_HIGH_ARCH_6	= BIT(VM_HIGH_ARCH_BIT_6),
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
+};
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
 # define VM_PKEY_SHIFT VM_HIGH_ARCH_BIT_0
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 2e43c66635a2..04b75d4d01c3 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -108,7 +108,6 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
 
 const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
 const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
-const vm_flags_t RUST_CONST_HELPER_VM_MERGEABLE = VM_MERGEABLE;
 
 #if IS_ENABLED(CONFIG_ANDROID_BINDER_IPC_RUST)
 #include "../../drivers/android/binder/rust_binder.h"
-- 
2.51.0.618.g983fd99d29-goog


