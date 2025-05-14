Return-Path: <linux-fsdevel+bounces-49053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1B1AB79E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E9E4C7A2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD93253F25;
	Wed, 14 May 2025 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjauxxvn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E51C25394B
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266223; cv=none; b=DalbPs7NBamH8409Utf0GF21sdozA7PrmxoPnfd0bUUDqGwBzUxZNuvjf8el3ezKIOphPJSrWDpCFpUMn2YSBpwyhrHAYdlAHrwUxZHoLH1VeK168k+nvqD5XdFu7Znn4imVsRgeI73xb0BXTyxOXwyAvzaJpR+utrXkfn3QFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266223; c=relaxed/simple;
	bh=HJj8WHDdya4gA/Ti/ZVYOZJkvqr0Goeoxk9qXCNBqnE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=apsP+pZs+ue3aegjmoHbFmOQLimRkFGNQLRHz2PvZqWhfzStwOam1TICmLyxC5mG23zSf4QSgKyL3ekgXoD8t+lChFztyUoXBod65ncZ1UWurHN+aAelTN7DEmMPURGqy+ZPtpblSMIUuPnWh4mkbcH7xGEiAtZ0ZXoSPXYwdp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rjauxxvn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30adbe9b568so291317a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266221; x=1747871021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ybRHoummrWWH+GOSU2oOA7jlRVO35C0Hs9Na7WUf7vY=;
        b=rjauxxvnkmlCQciFC1cBv84vzGq+Wfhw+sBoog1q+7lIVhyHjKqv9dHEwEllbtNE+K
         LY5n/2YXuYow3vbKac+ROkRTBVDfYptKw3hC5SAtR89RzHjIX3L9n86Oy0dJSgZqHzkC
         dtcRZuWueadH5QXTyWN4mIyF4VTfEPS89m/kiwRmMWHpuAhGCtqQFUQTXuxfOldsc5RK
         rTG7HJTYD4JDnd/0udIc/RBXFZOhfqkvlYozhqsbWjUy1JjYG5dmsGnwOgIqIE/w0ogV
         B8JyhJL96locyMTIAgkVSxvT6xzMRVS2YFNZlNDT4l2UbyQwVoK2PAQxvzVMGMGlMpqE
         W2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266221; x=1747871021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybRHoummrWWH+GOSU2oOA7jlRVO35C0Hs9Na7WUf7vY=;
        b=jYpv271waUDRRmxbcXVSE4cd4cid2CYbNMX5AM3KOer3mcx8uEcKRM8Sa/jU16l9Sw
         bVdpzPNtKlckVVXDJMjogBAUeHUafH9wWad/TljvhLiJ0xdEnEoDJrSSpCZd0tccQlSv
         gspxdFeCrYnGIpAtJ5rlgipDmReqmE0PE8PUZFDyjJBYdwOsoHLqNLjO6xEbdZaFuaP8
         HjlJIqQbstqaaliF+MscURzjmAB0JuV0as9y/gr76joEGL7p1nB/CYEjpPqvZNMIEbgM
         O+tbWKryggA/vfAeGBj3NBW/ncrQEuHOfF484wqMAQT0HRNWK7TmIaFKqRQytN3LB0DJ
         rAyA==
X-Forwarded-Encrypted: i=1; AJvYcCXZwKDoiAZRpx2+1in6IPrz+Ic27i0fpprbdL92WVwM/XdEpZ3ID2f3Mu1yHpr6lBd8nA1+PSYUzoaxiH7w@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg2tRXmz7Pvsw4NBM9KiGHXf0gdvUmJ4ifJ4PXSrvZamoCmxRQ
	yMa1DDZY9rpRCAtRvEVAJfuBdOnPqslIKhfzcpg8NGkbNhkHMisybqznhTgFmJjnTOmnYYyVT/6
	w+nslJckO/eMwBAKeXMw7oA==
X-Google-Smtp-Source: AGHT+IF7CTIjvQ3/Yejxf4LzxERKUbwh5QUADPu51M5AW0vpxWcS4ShcwU93trN4MwXAS2gTS+MsKTv3PqeW6YPJgA==
X-Received: from pjuj4.prod.google.com ([2002:a17:90a:d004:b0:30a:89a8:cef0])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a85:b0:30a:3dde:6af4 with SMTP id 98e67ed59e1d1-30e2e687a50mr6884071a91.31.1747266221046;
 Wed, 14 May 2025 16:43:41 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:07 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <8f8b6d6f44cdc6b27db11e1e867dc92efca6d177.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 28/51] mm: Introduce guestmem_hugetlb to support
 folio_put() handling of guestmem pages
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

The PGTY_guestmem_hugetlb is introduced so folios can be marked for
further cleanup by guestmem_hugetlb.

guestmem_hugetlb folios can have positive mapcounts, which will
conflict with the installation of a page type. Hence,
PGTY_guestmem_hugetlb will only be installed when a folio is
truncated, after the folio has been unmapped and has a mapcount of 0.

Signed-off-by: Fuad Tabba <tabba@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Change-Id: I635f8929e06f73d7899737bd47090b7cbc7222dc
---
 include/linux/page-flags.h | 17 +++++++++++++++++
 mm/Kconfig                 | 10 ++++++++++
 mm/Makefile                |  1 +
 mm/debug.c                 |  1 +
 mm/guestmem_hugetlb.c      | 14 ++++++++++++++
 mm/guestmem_hugetlb.h      |  9 +++++++++
 mm/swap.c                  |  9 +++++++++
 7 files changed, 61 insertions(+)
 create mode 100644 mm/guestmem_hugetlb.c
 create mode 100644 mm/guestmem_hugetlb.h

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 9dd60fb8c33f..543f6481ca60 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -965,6 +965,7 @@ enum pagetype {
 	PGTY_zsmalloc		= 0xf6,
 	PGTY_unaccepted		= 0xf7,
 	PGTY_large_kmalloc	= 0xf8,
+	PGTY_guestmem_hugetlb	= 0xf9,
 
 	PGTY_mapcount_underflow = 0xff
 };
@@ -1114,6 +1115,22 @@ FOLIO_TYPE_OPS(hugetlb, hugetlb)
 FOLIO_TEST_FLAG_FALSE(hugetlb)
 #endif
 
+/*
+ * PGTY_guestmem_hugetlb, for now, is used to mark a folio as requiring further
+ * cleanup by the guestmem_hugetlb allocator.  This page type is installed only
+ * at truncation time, by guest_memfd, if further cleanup is required.  It is
+ * safe to install this page type at truncation time because by then mapcount
+ * would be 0.
+ *
+ * The plan is to always set this page type for any folios allocated by
+ * guestmem_hugetlb once typed folios can be mapped to userspace cleanly.
+ */
+#ifdef CONFIG_GUESTMEM_HUGETLB
+FOLIO_TYPE_OPS(guestmem_hugetlb, guestmem_hugetlb)
+#else
+FOLIO_TEST_FLAG_FALSE(guestmem_hugetlb)
+#endif
+
 PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
 
 /*
diff --git a/mm/Kconfig b/mm/Kconfig
index e113f713b493..131adc49f58d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1216,6 +1216,16 @@ config SECRETMEM
 	  memory areas visible only in the context of the owning process and
 	  not mapped to other processes and other kernel page tables.
 
+config GUESTMEM_HUGETLB
+	bool "Enable guestmem_hugetlb allocator for guest_memfd"
+	depends on HUGETLBFS
+	help
+	  Enable this to make HugeTLB folios available to guest_memfd
+	  (KVM virtualization) as backing memory.
+
+	  This feature wraps HugeTLB as a custom allocator that
+	  guest_memfd can use.
+
 config ANON_VMA_NAME
 	bool "Anonymous VMA name support"
 	depends on PROC_FS && ADVISE_SYSCALLS && MMU
diff --git a/mm/Makefile b/mm/Makefile
index e7f6bbf8ae5f..c91c8e8fef71 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -127,6 +127,7 @@ obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
 obj-$(CONFIG_PAGE_TABLE_CHECK) += page_table_check.o
 obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
 obj-$(CONFIG_SECRETMEM) += secretmem.o
+obj-$(CONFIG_GUESTMEM_HUGETLB) += guestmem_hugetlb.o
 obj-$(CONFIG_CMA_SYSFS) += cma_sysfs.o
 obj-$(CONFIG_USERFAULTFD) += userfaultfd.o
 obj-$(CONFIG_IDLE_PAGE_TRACKING) += page_idle.o
diff --git a/mm/debug.c b/mm/debug.c
index db83e381a8ae..439ab128772d 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -56,6 +56,7 @@ static const char *page_type_names[] = {
 	DEF_PAGETYPE_NAME(table),
 	DEF_PAGETYPE_NAME(buddy),
 	DEF_PAGETYPE_NAME(unaccepted),
+	DEF_PAGETYPE_NAME(guestmem_hugetlb),
 };
 
 static const char *page_type_name(unsigned int page_type)
diff --git a/mm/guestmem_hugetlb.c b/mm/guestmem_hugetlb.c
new file mode 100644
index 000000000000..51a724ebcc50
--- /dev/null
+++ b/mm/guestmem_hugetlb.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * guestmem_hugetlb is an allocator for guest_memfd. guest_memfd wraps HugeTLB
+ * as an allocator for guest_memfd.
+ */
+
+#include <linux/mm_types.h>
+
+#include "guestmem_hugetlb.h"
+
+void guestmem_hugetlb_handle_folio_put(struct folio *folio)
+{
+	WARN_ONCE(1, "A placeholder that shouldn't trigger. Work in progress.");
+}
diff --git a/mm/guestmem_hugetlb.h b/mm/guestmem_hugetlb.h
new file mode 100644
index 000000000000..5c9452b77252
--- /dev/null
+++ b/mm/guestmem_hugetlb.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_GUESTMEM_HUGETLB_H
+#define _LINUX_MM_GUESTMEM_HUGETLB_H
+
+#include <linux/mm_types.h>
+
+void guestmem_hugetlb_handle_folio_put(struct folio *folio);
+
+#endif
diff --git a/mm/swap.c b/mm/swap.c
index d0a5971787c4..2747230ced89 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -40,6 +40,10 @@
 
 #include "internal.h"
 
+#ifdef CONFIG_GUESTMEM_HUGETLB
+#include "guestmem_hugetlb.h"
+#endif
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/pagemap.h>
 
@@ -101,6 +105,11 @@ static void free_typed_folio(struct folio *folio)
 	case PGTY_hugetlb:
 		free_huge_folio(folio);
 		return;
+#endif
+#ifdef CONFIG_GUESTMEM_HUGETLB
+	case PGTY_guestmem_hugetlb:
+		guestmem_hugetlb_handle_folio_put(folio);
+		return;
 #endif
 	default:
 		WARN_ON_ONCE(1);
-- 
2.49.0.1045.g170613ef41-goog


