Return-Path: <linux-fsdevel+bounces-62963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B68BA7AC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4081888E3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0301E221F1C;
	Mon, 29 Sep 2025 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OF6k+XtG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94620D4E9
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107823; cv=none; b=DzbrpdAfkwiTYhfGOjP27OyDzwZ9DpPyqY9NmAojN74/dgzcZ/ialah3Z2Os11m14dMHupJRgutO4cXN0MIp8acT0NgH446EIOSOQwzhDAWyseiXYiWQiUvJLBCkC8WRPgdm8fbDbDe0x9KoqlABhr9F8S7YAvMItoByiKqGWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107823; c=relaxed/simple;
	bh=uocVzTpuxi0ebUpykEeNIS1BP1SwChvze955nF6VwOw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9xHqwQO1Xtg2t86Yfgv/KV7b/uPiN7Vj2CNMnQ39K0b7+ZqKLPKD2zNfgqc6fP/eD2mtKPntgoFlFIkGo/dIw4w5j5Yf19X4ufkVuV9/7BruFjwrM5XX1o56fv9y5OXpi8ILEA/Ps99YkoaQ0oCWHduMbHDWZzCxMYRfr9GW6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=OF6k+XtG; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4dac61ed7a5so33575901cf.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107820; x=1759712620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9ZBZaC3vdnAz+H8XWrjcI+m01YkVPNevX7SPwh/ro8=;
        b=OF6k+XtG4d9+ONrAotco/CqbBeafIkR6hMFyu9AxUjIw33t1/slbCETYek9/e6CKSL
         WDHlANdhT1RVEI2NqV7APpmQEAZi7CBuFZP0mUqdjOU5sQHQNCLL9IVTMch8isWZbRRH
         Jj6laX9sMFlMUm2G69DVaUJEr9AjxJnovMFpySlIkxilGNQdQD58qMwHH8Sq2N5nRhCe
         8pAjR3KYnH0QdteTEpLo3BDz+deetpnYjv3KZyTeTg5wG4Y0xVr6jTzvQCJtNXPvnDNC
         arl6gFii5y9ghms5oY8wCsmpm7/6D3KotfrkUd5LOUu39spYG5VMVNkhVRwmw5aKC2+B
         9+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107820; x=1759712620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9ZBZaC3vdnAz+H8XWrjcI+m01YkVPNevX7SPwh/ro8=;
        b=WlMWEd7TUkLsP5N6P0VHWs39iLBi9FNrgCzleFpwYoH9lJl6nhdWRR6Y/+0mPmsdmY
         JFsL63pE7UBKSSXIYE9OljIG91rFpfL7CyyZzWMfivCRYm+/XLQQbTvK+TfkY1+y9eJ8
         Pv0CzyLQDMYrCBptelUEYULDAxppnZFOLqEuXEYzOivXGAjTnzsYgQLUKbt0iG+lNb7h
         qFDovdr+8LJCOCjNLvN2/3H67NqD97qUXE8jbUTHfEcRzNo0osPYdAVUsUcUSph8nwFj
         QRvGHCqs+3UUlYHvsmZ3tQhxnQB9KddqZ6ZAOszX+s+tIY3R488vzbZ8lQ/a3l9AQC5M
         t36g==
X-Forwarded-Encrypted: i=1; AJvYcCWd25uujeqs2UoAFPRKdYkTgjPr9Vxk4oFriH73F2i/UGB5tZS476Y+Nztp2ytcUsLfEw5Ml5BX1xp1RuME@vger.kernel.org
X-Gm-Message-State: AOJu0YxpniKAEnnXg8u9/dSYfMInmBJQHxo/MJCJf5Y2zVX388YEUq5w
	9EAbcolLhFmREFXaIgNj/cXY3bJE9fnvPe04g1jgUpZ2HAr4+gauKOJy7gKA1qODXdk=
X-Gm-Gg: ASbGncuHRaulK5TYwGEdD0RPtISCNGWWYAI1Uu6LCD73NOUXrI2booOOUHuRa4mDUUL
	w82HynV192w0M1U5ZZF6DNXjxDny1CHFvx0xHOIq0/d93/dWY9rUp+E5RETMl0YEePAOv/P6tKP
	bkeSfQn+GN2iBrloPC1ntqPnQ2DG8+R6EUf2BLeZJQ52l7sHcPfM8GKynG3DvnYk91zB822ZzGl
	ZmdNFiL5L//dD1KA2wdr7KyimHpC/r5cVcj61V95RILq3vREYwm+9TGFOpEYOchq0HdmDb2vaOR
	zz7GX6tPmk97NHuZqpZl/v+2Mhit0Arp5MQ3clFeCGeKYypq2OhpvEo4/7pd4Se9w46F/DNKZ1s
	8JpWDjEIuoZeKU2buxlHa5JXjHNdmE8UliD6PHPg1tSqxzAGDohjGCiWW7nBaBenxrdILm6M7/J
	NdzyuXr1jXpBjcbIUQtIxz8rYjFe2i
X-Google-Smtp-Source: AGHT+IE10H11AdCpFcZo+kud9wUci9g/QjNXpF8kId7N/q2vHl0kUjCR57f1sJWtfpnjlo9cA3j/tg==
X-Received: by 2002:a05:622a:2609:b0:4da:155a:76fc with SMTP id d75a77b69052e-4da4744f3b0mr213359021cf.16.1759107819934;
        Sun, 28 Sep 2025 18:03:39 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:03:39 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 06/30] liveupdate: kho: move to kernel/liveupdate
Date: Mon, 29 Sep 2025 01:02:57 +0000
Message-ID: <20250929010321.3462457-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move KHO to kernel/liveupdate/ in preparation of placing all Live Update
core kernel related files to the same place.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/core-api/kho/concepts.rst       |  2 +-
 MAINTAINERS                                   |  2 +-
 init/Kconfig                                  |  2 ++
 kernel/Kconfig.kexec                          | 25 ----------------
 kernel/Makefile                               |  3 +-
 kernel/liveupdate/Kconfig                     | 30 +++++++++++++++++++
 kernel/liveupdate/Makefile                    |  4 +++
 kernel/{ => liveupdate}/kexec_handover.c      |  6 ++--
 .../{ => liveupdate}/kexec_handover_debug.c   |  0
 .../kexec_handover_internal.h                 |  0
 10 files changed, 42 insertions(+), 32 deletions(-)
 create mode 100644 kernel/liveupdate/Kconfig
 create mode 100644 kernel/liveupdate/Makefile
 rename kernel/{ => liveupdate}/kexec_handover.c (99%)
 rename kernel/{ => liveupdate}/kexec_handover_debug.c (100%)
 rename kernel/{ => liveupdate}/kexec_handover_internal.h (100%)

diff --git a/Documentation/core-api/kho/concepts.rst b/Documentation/core-api/kho/concepts.rst
index 36d5c05cfb30..d626d1dbd678 100644
--- a/Documentation/core-api/kho/concepts.rst
+++ b/Documentation/core-api/kho/concepts.rst
@@ -70,5 +70,5 @@ in the FDT. That state is called the KHO finalization phase.
 
 Public API
 ==========
-.. kernel-doc:: kernel/kexec_handover.c
+.. kernel-doc:: kernel/liveupdate/kexec_handover.c
    :export:
diff --git a/MAINTAINERS b/MAINTAINERS
index a6cbcc7fb396..e5c800ed4819 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13766,7 +13766,7 @@ S:	Maintained
 F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
 F:	include/linux/kexec_handover.h
-F:	kernel/kexec_handover*
+F:	kernel/liveupdate/kexec_handover*
 F:	tools/testing/selftests/kho/
 
 KEYS-ENCRYPTED
diff --git a/init/Kconfig b/init/Kconfig
index d295e79d3547..9952c112154f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2138,6 +2138,8 @@ config TRACEPOINTS
 
 source "kernel/Kconfig.kexec"
 
+source "kernel/liveupdate/Kconfig"
+
 endmenu		# General setup
 
 source "arch/Kconfig"
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index e68156d8c72b..15632358bcf7 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -94,31 +94,6 @@ config KEXEC_JUMP
 	  Jump between original kernel and kexeced kernel and invoke
 	  code in physical address mode via KEXEC
 
-config KEXEC_HANDOVER
-	bool "kexec handover"
-	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
-	depends on !DEFERRED_STRUCT_PAGE_INIT
-	select MEMBLOCK_KHO_SCRATCH
-	select KEXEC_FILE
-	select DEBUG_FS
-	select LIBFDT
-	select CMA
-	help
-	  Allow kexec to hand over state across kernels by generating and
-	  passing additional metadata to the target kernel. This is useful
-	  to keep data or state alive across the kexec. For this to work,
-	  both source and target kernels need to have this option enabled.
-
-config KEXEC_HANDOVER_DEBUG
-	bool "kexec handover debug interface"
-	depends on KEXEC_HANDOVER
-	depends on DEBUG_FS
-	help
-	  Allow to control kexec handover device tree via debugfs
-	  interface, i.e. finalize the state or aborting the finalization.
-	  Also, enables inspecting the KHO fdt trees with the debugfs binary
-	  blobs.
-
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	default ARCH_DEFAULT_CRASH_DUMP
diff --git a/kernel/Makefile b/kernel/Makefile
index 9fe722305c9b..e83669841b8c 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -52,6 +52,7 @@ obj-y += printk/
 obj-y += irq/
 obj-y += rcu/
 obj-y += livepatch/
+obj-y += liveupdate/
 obj-y += dma/
 obj-y += entry/
 obj-y += unwind/
@@ -82,8 +83,6 @@ obj-$(CONFIG_CRASH_DUMP_KUNIT_TEST) += crash_core_test.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
-obj-$(CONFIG_KEXEC_HANDOVER) += kexec_handover.o
-obj-$(CONFIG_KEXEC_HANDOVER_DEBUG) += kexec_handover_debug.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
new file mode 100644
index 000000000000..eebe564b385d
--- /dev/null
+++ b/kernel/liveupdate/Kconfig
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "Live Update"
+
+config KEXEC_HANDOVER
+	bool "kexec handover"
+	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
+	depends on !DEFERRED_STRUCT_PAGE_INIT
+	select MEMBLOCK_KHO_SCRATCH
+	select KEXEC_FILE
+	select DEBUG_FS
+	select LIBFDT
+	select CMA
+	help
+	  Allow kexec to hand over state across kernels by generating and
+	  passing additional metadata to the target kernel. This is useful
+	  to keep data or state alive across the kexec. For this to work,
+	  both source and target kernels need to have this option enabled.
+
+config KEXEC_HANDOVER_DEBUG
+	bool "kexec handover debug interface"
+	depends on KEXEC_HANDOVER
+	depends on DEBUG_FS
+	help
+	  Allow to control kexec handover device tree via debugfs
+	  interface, i.e. finalize the state or aborting the finalization.
+	  Also, enables inspecting the KHO fdt trees with the debugfs binary
+	  blobs.
+
+endmenu
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
new file mode 100644
index 000000000000..67c7f71b33fa
--- /dev/null
+++ b/kernel/liveupdate/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
+obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
diff --git a/kernel/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
similarity index 99%
rename from kernel/kexec_handover.c
rename to kernel/liveupdate/kexec_handover.c
index 61b31cfc75f2..71e98c44cf47 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -24,8 +24,8 @@
  * KHO is tightly coupled with mm init and needs access to some of mm
  * internal APIs.
  */
-#include "../mm/internal.h"
-#include "kexec_internal.h"
+#include "../../mm/internal.h"
+#include "../kexec_internal.h"
 #include "kexec_handover_internal.h"
 
 #define KHO_FDT_COMPATIBLE "kho-v1"
@@ -1129,7 +1129,7 @@ static int __kho_finalize(void)
 	err |= fdt_finish_reservemap(root);
 	err |= fdt_begin_node(root, "");
 	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
-	/**
+	/*
 	 * Reserve the preserved-memory-map property in the root FDT, so
 	 * that all property definitions will precede subnodes created by
 	 * KHO callers.
diff --git a/kernel/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
similarity index 100%
rename from kernel/kexec_handover_debug.c
rename to kernel/liveupdate/kexec_handover_debug.c
diff --git a/kernel/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
similarity index 100%
rename from kernel/kexec_handover_internal.h
rename to kernel/liveupdate/kexec_handover_internal.h
-- 
2.51.0.536.g15c5d4f767-goog


