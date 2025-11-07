Return-Path: <linux-fsdevel+bounces-67493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C67CAC41BC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 22:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5927D4FC5B8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 21:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93F1346E4F;
	Fri,  7 Nov 2025 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jYp1oEsv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689A8345CC0
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549569; cv=none; b=VreTaxd9WP9rNsGZdS5vSJem4638/qPaHXZKYL2pH5/E1hEL7A6G7HWCH/E3hGDg9DxnldROpdJoe6TtEesRexZ0iFa/9KD1QLYK14OceXlf8sSJ0ITpO1m7kXsrldnFanp4Z+sJ59nurztxYoUSsDFVJXXCYGoTUDEm7fAyTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549569; c=relaxed/simple;
	bh=EjQ8peAIc9yOOF6qNCxFHDArIE9acUxfCw5wzzZBPRw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEhXBlUCPnwPlon5UW13IsIiq0O1UJygxFxKiZBGtX/aV+DhE0UeA4xJwSJzZ3Gvub+KzSYQA8yrURLDabKatMM0qizFoSXRl094O0LOnHeXSsjMBiKJw/rZ3ziMikiEHPvs/wrJC1nHF/RJTbAYf6SybLIwuoKCuYjzHWIooRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=jYp1oEsv; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63f9beb27b9so1111520d50.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 13:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549565; x=1763154365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09YtFNBuBcrdwWRDfQe183nmO/j9JR0mycDV+z3OXls=;
        b=jYp1oEsvwiMVCppoMBjyctPF65EBEQIeY8ZleBIsO/Ztlh7muD07Nj7oLhZ6V1bOfH
         RkxfqmKk/a9bM2H9lUZmmlcmxtj0rnBaabvEuyYoLpZieEIDJDwv/S9kjQsobMoxnn56
         w9HRrSQkZz0Zxidc1+T/LMNw4pFOE6QI1xA8ZsuNE3jQDdyDPzjMHYlvmNfY67LfCXJ8
         6ORaEwG4hWwu79W+WZLUhyusuXsrx/Ff/JUmTSznTAlduqBk8b8wbSRuzylxxB9JgCk5
         X5hRZyVhetRLdrOFe1P0Gb8bjN7AsxgIovMVtt2jMOZqSn2vwf3eER+Bl9RLeQJZxcRd
         e3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549565; x=1763154365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=09YtFNBuBcrdwWRDfQe183nmO/j9JR0mycDV+z3OXls=;
        b=HV+Gf7HZRWpCLDAilo2VhD2rMWYw1lLvgMisbwxHArS9JfjjT1YFce+4q8hPvmcZQB
         V2dPN/ZEs1ND3jHh5eAUHEtv3rfZfDMVDFuSph6qRRRxl2V7Q8UQLt9gZj+o2vXMX39h
         AgW9KWDK/vpuwoUxHQGH4V6RLF1loPsHyWUg6XmuOTReSlDt4WCNMm110iqKrBSCJrHE
         P+QyXg3flTJWm5/nshJhtUD6sO9qA8e4txdl2+MwIC7MqThjYStCrFtxjb7rorc6xj0Z
         hpHKK+2jDnYE1E3pq/OKcSw4Lx4LUdNcbsSPOm3h/imxerf3r/30JRTLUOMzwXupuRQh
         S1yg==
X-Forwarded-Encrypted: i=1; AJvYcCWOi6cygXFZTzKmaV67wsmUjaFKlmTMj1ELZhtfcO+50g6V1iIt7KNPj7hYvpIppUUz3q6v0kH4p2OH002R@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8J8oBz+V4C2BVIXn5Jq+ubd4CyMFjiP1X+UsrIg+tLfzFLEF7
	NUWL9kVVGCIVoS7s/XjBiPjqjN6naiNGWr3b5Y614yVvWD7MPwt8SK724hWrp/ATVas=
X-Gm-Gg: ASbGncsNbKNN22/3yfS7ONLPLW8yy/k8a3mVe1xGsUZvVjaWoudbbsnxhexO9+u/vsh
	axHzwdOudr8UtS/B63ybYSfLi5pe9qrjTUvAfI0+ZLJqpX3c+dpQuaA3R8yrJs5LaBJAJmWkGI1
	ajAFSW8Hurfg82SLGNE1r2kTcv5vrwQfFbIwY5rp+S83bvq4Q2Zn5OBRjq88kNo+rRIKJgfiTbl
	Ml1nP9XZtDm1TF3P9elMkl/kLDd2+e8iXaMyzDGxbQYqIi1FLbToogf3MvJpHVQtcQJDYnHlfXw
	FGgnTTzBZa0FAi3P3cl4D7BqgksDsZIQTGuVlMHPm7DzqdYJZKYpdwej2qCDBQloPQ0YQHN0iXD
	HaDcuftmawPelszr/2ZJVMkDApjLxjO4OYBOvOgAe0cxYFgIsLBu5dVRhJaUMKuYcsKFS7POCif
	9YepEm38nfV/Ew1SExWzLrj7TUo0ZwIe1jvsNfOJ33u5m0B6kSNiC5stJO5mCxB2WpgzSPp245N
	Q==
X-Google-Smtp-Source: AGHT+IFsnvJKTM+35vwbspipp4TGFGs25ZYPlOLbrN33R++DlcW3HXwiogWfPX3LSZ/C792wt/YuwA==
X-Received: by 2002:a05:690e:42c8:b0:63b:6e65:ba27 with SMTP id 956f58d0204a3-640d45eeacemr331165d50.50.1762549565168;
        Fri, 07 Nov 2025 13:06:05 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:06:04 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
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
	chrisl@kernel.org
Subject: [PATCH v5 17/22] mm: memfd_luo: allow preserving memfd
Date: Fri,  7 Nov 2025 16:03:15 -0500
Message-ID: <20251107210526.257742-18-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <ptyadav@amazon.de>

The ability to preserve a memfd allows userspace to use KHO and LUO to
transfer its memory contents to the next kernel. This is useful in many
ways. For one, it can be used with IOMMUFD as the backing store for
IOMMU page tables. Preserving IOMMUFD is essential for performing a
hypervisor live update with passthrough devices. memfd support provides
the first building block for making that possible.

For another, applications with a large amount of memory that takes time
to reconstruct, reboots to consume kernel upgrades can be very
expensive. memfd with LUO gives those applications reboot-persistent
memory that they can use to quickly save and reconstruct that state.

While memfd is backed by either hugetlbfs or shmem, currently only
support on shmem is added. To be more precise, support for anonymous
shmem files is added.

The handover to the next kernel is not transparent. All the properties
of the file are not preserved; only its memory contents, position, and
size. The recreated file gets the UID and GID of the task doing the
restore, and the task's cgroup gets charged with the memory.

After LUO is in prepared state, the file cannot grow or shrink, and all
its pages are pinned to avoid migrations and swapping. The file can
still be read from or written to.

Use vmalloc to get the buffer to hold the folios, and preserve
it using kho_preserve_vmalloc(). This doesn't have the size limit.

Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---
 MAINTAINERS                          |   2 +
 include/linux/liveupdate/abi/memfd.h |  88 ++++
 mm/Makefile                          |   1 +
 mm/memfd_luo.c                       | 609 +++++++++++++++++++++++++++
 4 files changed, 700 insertions(+)
 create mode 100644 include/linux/liveupdate/abi/memfd.h
 create mode 100644 mm/memfd_luo.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 11b546168fb1..3497354b7fbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14514,6 +14514,7 @@ F:	tools/testing/selftests/livepatch/
 
 LIVE UPDATE
 M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+R:	Pratyush Yadav <pratyush@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/core-api/liveupdate.rst
@@ -14522,6 +14523,7 @@ F:	include/linux/liveupdate.h
 F:	include/linux/liveupdate/
 F:	include/uapi/linux/liveupdate.h
 F:	kernel/liveupdate/
+F:	mm/memfd_luo.c
 
 LLC (802.2)
 L:	netdev@vger.kernel.org
diff --git a/include/linux/liveupdate/abi/memfd.h b/include/linux/liveupdate/abi/memfd.h
new file mode 100644
index 000000000000..bf848e5bd1de
--- /dev/null
+++ b/include/linux/liveupdate/abi/memfd.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * Copyright (C) 2025 Amazon.com Inc. or its affiliates.
+ * Pratyush Yadav <ptyadav@amazon.de>
+ */
+
+#ifndef _LINUX_LIVEUPDATE_ABI_MEMFD_H
+#define _LINUX_LIVEUPDATE_ABI_MEMFD_H
+
+/**
+ * DOC: memfd Live Update ABI
+ *
+ * This header defines the ABI for preserving the state of a memfd across a
+ * kexec reboot using the LUO.
+ *
+ * The state is serialized into a Flattened Device Tree which is then handed
+ * over to the next kernel via the KHO mechanism. The FDT is passed as the
+ * opaque `data` handle in the file handler callbacks.
+ *
+ * This interface is a contract. Any modification to the FDT structure,
+ * node properties, compatible string, or the layout of the serialization
+ * structures defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in the MEMFD_LUO_FH_COMPATIBLE string.
+ *
+ * FDT Structure Overview:
+ *   The memfd state is contained within a single FDT with the following layout:
+ *
+ *   .. code-block:: none
+ *
+ *     / {
+ *         pos = <...>;
+ *         size = <...>;
+ *         nr_folios = <...>;
+ *         folios = < ... binary data ... >;
+ *     };
+ *
+ *   Node Properties:
+ *     - pos: u64
+ *       The file's current position (f_pos).
+ *     - size: u64
+ *       The total size of the file in bytes (i_size).
+ *     - nr_folios: u64
+ *       Number of folios in folios array. Only present when size > 0.
+ *     - folios: struct kho_vmalloc
+ *       KHO vmalloc preservation for an array of &struct memfd_luo_folio_ser,
+ *       one for each preserved folio from the original file's mapping. Only
+ *       present when size > 0.
+ */
+
+/**
+ * struct memfd_luo_folio_ser - Serialized state of a single folio.
+ * @foliodesc: A packed 64-bit value containing both the PFN and status flags of
+ *             the preserved folio. The upper 52 bits store the PFN, and the
+ *             lower 12 bits are reserved for flags (e.g., dirty, uptodate).
+ * @index:     The page offset (pgoff_t) of the folio within the original file's
+ *             address space. This is used to correctly position the folio
+ *             during restoration.
+ *
+ * This structure represents the minimal information required to restore a
+ * single folio in the new kernel. An array of these structs forms the binary
+ * data for the "folios" property in the handover FDT.
+ */
+struct memfd_luo_folio_ser {
+	u64 foliodesc;
+	u64 index;
+};
+
+/* The strings used for memfd KHO FDT sub-tree. */
+
+/* 64-bit pos value for the preserved memfd */
+#define MEMFD_FDT_POS		"pos"
+
+/* 64-bit size value of the preserved memfd */
+#define MEMFD_FDT_SIZE		"size"
+
+#define MEMFD_FDT_FOLIOS	"folios"
+
+/* Number of folios in the folios array. */
+#define MEMFD_FDT_NR_FOLIOS	"nr_folios"
+
+/* The compatibility string for memfd file handler */
+#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v1"
+
+#endif /* _LINUX_LIVEUPDATE_ABI_MEMFD_H */
diff --git a/mm/Makefile b/mm/Makefile
index 21abb3353550..7738ec416f00 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
+obj-$(CONFIG_LIVEUPDATE) += memfd_luo.o
 obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
 ifdef CONFIG_SWAP
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
new file mode 100644
index 000000000000..e366de627264
--- /dev/null
+++ b/mm/memfd_luo.c
@@ -0,0 +1,609 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * Copyright (C) 2025 Amazon.com Inc. or its affiliates.
+ * Pratyush Yadav <ptyadav@amazon.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/file.h>
+#include <linux/io.h>
+#include <linux/libfdt.h>
+#include <linux/liveupdate.h>
+#include <linux/liveupdate/abi/memfd.h>
+#include <linux/kexec_handover.h>
+#include <linux/shmem_fs.h>
+#include <linux/bits.h>
+#include <linux/vmalloc.h>
+#include "internal.h"
+
+#define PRESERVED_PFN_MASK		GENMASK(63, 12)
+#define PRESERVED_PFN_SHIFT		12
+#define PRESERVED_FLAG_DIRTY		BIT(0)
+#define PRESERVED_FLAG_UPTODATE		BIT(1)
+
+#define PRESERVED_FOLIO_PFN(desc)	(((desc) & PRESERVED_PFN_MASK) >> PRESERVED_PFN_SHIFT)
+#define PRESERVED_FOLIO_FLAGS(desc)	((desc) & ~PRESERVED_PFN_MASK)
+#define PRESERVED_FOLIO_MKDESC(pfn, flags) (((pfn) << PRESERVED_PFN_SHIFT) | (flags))
+
+struct memfd_luo_private {
+	struct memfd_luo_folio_ser *pfolios;
+	u64 nr_folios;
+};
+
+static struct memfd_luo_folio_ser *memfd_luo_preserve_folios(struct file *file, void *fdt,
+							     u64 *nr_foliosp)
+{
+	struct inode *inode = file_inode(file);
+	struct memfd_luo_folio_ser *pfolios;
+	struct kho_vmalloc *kho_vmalloc;
+	unsigned int max_folios;
+	long i, size, nr_pinned;
+	struct folio **folios;
+	int err = -EINVAL;
+	pgoff_t offset;
+	u64 nr_folios;
+
+	size = i_size_read(inode);
+	/*
+	 * If the file has zero size, then the folios and nr_folios properties
+	 * are not set.
+	 */
+	if (!size) {
+		*nr_foliosp = 0;
+		return NULL;
+	}
+
+	/*
+	 * Guess the number of folios based on inode size. Real number might end
+	 * up being smaller if there are higher order folios.
+	 */
+	max_folios = PAGE_ALIGN(size) / PAGE_SIZE;
+	folios = kvmalloc_array(max_folios, sizeof(*folios), GFP_KERNEL);
+	if (!folios)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Pin the folios so they don't move around behind our back. This also
+	 * ensures none of the folios are in CMA -- which ensures they don't
+	 * fall in KHO scratch memory. It also moves swapped out folios back to
+	 * memory.
+	 *
+	 * A side effect of doing this is that it allocates a folio for all
+	 * indices in the file. This might waste memory on sparse memfds. If
+	 * that is really a problem in the future, we can have a
+	 * memfd_pin_folios() variant that does not allocate a page on empty
+	 * slots.
+	 */
+	nr_pinned = memfd_pin_folios(file, 0, size - 1, folios, max_folios,
+				     &offset);
+	if (nr_pinned < 0) {
+		err = nr_pinned;
+		pr_err("failed to pin folios: %d\n", err);
+		goto err_free_folios;
+	}
+	nr_folios = nr_pinned;
+
+	err = fdt_property(fdt, MEMFD_FDT_NR_FOLIOS, &nr_folios, sizeof(nr_folios));
+	if (err)
+		goto err_unpin;
+
+	err = fdt_property_placeholder(fdt, MEMFD_FDT_FOLIOS, sizeof(*kho_vmalloc),
+				       (void **)&kho_vmalloc);
+	if (err) {
+		pr_err("Failed to reserve '%s' property in FDT: %s\n",
+		       MEMFD_FDT_FOLIOS, fdt_strerror(err));
+		err = -ENOMEM;
+		goto err_unpin;
+	}
+
+	pfolios = vcalloc(nr_folios, sizeof(*pfolios));
+	if (!pfolios) {
+		err = -ENOMEM;
+		goto err_unpin;
+	}
+
+	for (i = 0; i < nr_folios; i++) {
+		struct memfd_luo_folio_ser *pfolio = &pfolios[i];
+		struct folio *folio = folios[i];
+		unsigned int flags = 0;
+		unsigned long pfn;
+
+		err = kho_preserve_folio(folio);
+		if (err)
+			goto err_unpreserve;
+
+		pfn = folio_pfn(folio);
+		if (folio_test_dirty(folio))
+			flags |= PRESERVED_FLAG_DIRTY;
+		if (folio_test_uptodate(folio))
+			flags |= PRESERVED_FLAG_UPTODATE;
+
+		pfolio->foliodesc = PRESERVED_FOLIO_MKDESC(pfn, flags);
+		pfolio->index = folio->index;
+	}
+
+	err = kho_preserve_vmalloc(pfolios, kho_vmalloc);
+	if (err)
+		goto err_unpreserve;
+
+	kvfree(folios);
+	*nr_foliosp = nr_folios;
+	return pfolios;
+
+err_unpreserve:
+	i--;
+	for (; i >= 0; i--)
+		WARN_ON_ONCE(kho_unpreserve_folio(folios[i]));
+	vfree(pfolios);
+err_unpin:
+	unpin_folios(folios, nr_folios);
+err_free_folios:
+	kvfree(folios);
+	return ERR_PTR(err);
+}
+
+static void memfd_luo_unpreserve_folios(void *fdt, struct memfd_luo_folio_ser *pfolios,
+					u64 nr_folios)
+{
+	struct kho_vmalloc *kho_vmalloc;
+	long i;
+
+	if (!nr_folios)
+		return;
+
+	kho_vmalloc = (struct kho_vmalloc *)fdt_getprop(fdt, 0, MEMFD_FDT_FOLIOS, NULL);
+	/* The FDT was created by this kernel so expect it to be sane. */
+	WARN_ON_ONCE(!kho_vmalloc);
+	kho_unpreserve_vmalloc(kho_vmalloc);
+
+	for (i = 0; i < nr_folios; i++) {
+		const struct memfd_luo_folio_ser *pfolio = &pfolios[i];
+		struct folio *folio;
+
+		if (!pfolio->foliodesc)
+			continue;
+
+		folio = pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
+
+		WARN_ON_ONCE(kho_unpreserve_folio(folio));
+		unpin_folio(folio);
+	}
+
+	vfree(pfolios);
+}
+
+static struct memfd_luo_folio_ser *memfd_luo_fdt_folios(const void *fdt, u64 *nr_folios)
+{
+	const struct kho_vmalloc *kho_vmalloc;
+	struct memfd_luo_folio_ser *pfolios;
+	const u64 *nr;
+	int len;
+
+	nr = fdt_getprop(fdt, 0, MEMFD_FDT_NR_FOLIOS, &len);
+	if (!nr || len != sizeof(*nr)) {
+		pr_err("invalid '%s' property\n", MEMFD_FDT_NR_FOLIOS);
+		return NULL;
+	}
+
+	kho_vmalloc = fdt_getprop(fdt, 0, MEMFD_FDT_FOLIOS, &len);
+	if (!kho_vmalloc || len != sizeof(*kho_vmalloc)) {
+		pr_err("invalid '%s' property\n", MEMFD_FDT_FOLIOS);
+		return NULL;
+	}
+
+	pfolios = kho_restore_vmalloc(kho_vmalloc);
+	if (!pfolios)
+		return NULL;
+
+	*nr_folios = *nr;
+	return pfolios;
+}
+
+static void *memfd_luo_create_fdt(void)
+{
+	struct folio *fdt_folio;
+	int err = 0;
+	void *fdt;
+
+	/*
+	 * The FDT only contains a couple of properties and a kho_vmalloc
+	 * object. One page should be enough for that.
+	 */
+	fdt_folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+	if (!fdt_folio)
+		return NULL;
+
+	fdt = folio_address(fdt_folio);
+
+	err |= fdt_create(fdt, folio_size(fdt_folio));
+	err |= fdt_finish_reservemap(fdt);
+	err |= fdt_begin_node(fdt, "");
+	if (err)
+		goto free;
+
+	return fdt;
+
+free:
+	folio_put(fdt_folio);
+	return NULL;
+}
+
+static int memfd_luo_finish_fdt(void *fdt)
+{
+	int err;
+
+	err = fdt_end_node(fdt);
+	if (err)
+		return err;
+
+	return fdt_finish(fdt);
+}
+
+static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
+{
+	struct inode *inode = file_inode(args->file);
+	struct memfd_luo_folio_ser *pfolios;
+	struct memfd_luo_private *private;
+	u64 pos, nr_folios;
+	int err = 0;
+	void *fdt;
+	long size;
+
+	private = kmalloc(sizeof(*private), GFP_KERNEL);
+	if (!private)
+		return -ENOMEM;
+
+	inode_lock(inode);
+	shmem_i_mapping_freeze(inode, true);
+
+	size = i_size_read(inode);
+
+	fdt = memfd_luo_create_fdt();
+	if (!fdt) {
+		err = -ENOMEM;
+		goto err_unlock;
+	}
+
+	pos = args->file->f_pos;
+	err = fdt_property(fdt, MEMFD_FDT_POS, &pos, sizeof(pos));
+	if (err)
+		goto err_free_fdt;
+
+	err = fdt_property(fdt, MEMFD_FDT_SIZE, &size, sizeof(size));
+	if (err)
+		goto err_free_fdt;
+
+	pfolios = memfd_luo_preserve_folios(args->file, fdt, &nr_folios);
+	if (IS_ERR(pfolios)) {
+		err = PTR_ERR(pfolios);
+		goto err_free_fdt;
+	}
+
+	err = memfd_luo_finish_fdt(fdt);
+	if (err)
+		goto err_unpreserve_folios;
+
+	err = kho_preserve_folio(virt_to_folio(fdt));
+	if (err)
+		goto err_unpreserve_folios;
+
+	inode_unlock(inode);
+
+	private->pfolios = pfolios;
+	private->nr_folios = nr_folios;
+	args->private_data = private;
+	args->serialized_data = virt_to_phys(fdt);
+	return 0;
+
+err_unpreserve_folios:
+	memfd_luo_unpreserve_folios(fdt, pfolios, nr_folios);
+err_free_fdt:
+	folio_put(virt_to_folio(fdt));
+err_unlock:
+	shmem_i_mapping_freeze(inode, false);
+	inode_unlock(inode);
+	kfree(private);
+	return err;
+}
+
+static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
+{
+	u64 pos = args->file->f_pos;
+	void *fdt;
+	int err;
+
+	if (WARN_ON_ONCE(!args->serialized_data))
+		return -EINVAL;
+
+	fdt = phys_to_virt(args->serialized_data);
+
+	/*
+	 * The pos might have changed since prepare. Everything else stays the
+	 * same.
+	 */
+	err = fdt_setprop(fdt, 0, "pos", &pos, sizeof(pos));
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
+{
+	struct memfd_luo_private *private = args->private_data;
+	struct inode *inode = file_inode(args->file);
+	struct folio *fdt_folio;
+	void *fdt;
+
+	if (WARN_ON_ONCE(!args->serialized_data || !args->private_data))
+		return;
+
+	inode_lock(inode);
+	shmem_i_mapping_freeze(inode, false);
+
+	fdt = phys_to_virt(args->serialized_data);
+	fdt_folio = virt_to_folio(fdt);
+
+	memfd_luo_unpreserve_folios(fdt, private->pfolios, private->nr_folios);
+
+	kho_unpreserve_folio(fdt_folio);
+	folio_put(fdt_folio);
+	inode_unlock(inode);
+	kfree(private);
+}
+
+static struct folio *memfd_luo_get_fdt(u64 data)
+{
+	return kho_restore_folio((phys_addr_t)data);
+}
+
+static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *pfolios,
+				     long nr_folios)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_folios; i++) {
+		const struct memfd_luo_folio_ser *pfolio = &pfolios[i];
+		struct folio *folio;
+		phys_addr_t phys;
+
+		if (!pfolio->foliodesc)
+			continue;
+
+		phys = PFN_PHYS(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
+		folio = kho_restore_folio(phys);
+		if (!folio) {
+			pr_warn_ratelimited("Unable to restore folio at physical address: %llx\n",
+					    phys);
+			continue;
+		}
+
+		folio_put(folio);
+	}
+}
+
+static void memfd_luo_finish(struct liveupdate_file_op_args *args)
+{
+	const struct memfd_luo_folio_ser *pfolios;
+	struct folio *fdt_folio;
+	const void *fdt;
+	u64 nr_folios;
+
+	if (args->retrieved)
+		return;
+
+	fdt_folio = memfd_luo_get_fdt(args->serialized_data);
+	if (!fdt_folio) {
+		pr_err("failed to restore memfd FDT\n");
+		return;
+	}
+
+	fdt = folio_address(fdt_folio);
+
+	pfolios = memfd_luo_fdt_folios(fdt, &nr_folios);
+	if (!pfolios)
+		goto out;
+
+	memfd_luo_discard_folios(pfolios, nr_folios);
+	vfree(pfolios);
+
+out:
+	folio_put(fdt_folio);
+}
+
+static int memfd_luo_retrieve_folios(struct file *file, const void *fdt)
+{
+	const struct memfd_luo_folio_ser *pfolios;
+	struct inode *inode = file_inode(file);
+	struct address_space *mapping;
+	struct folio *folio;
+	u64 nr_folios;
+	long i = 0;
+	int err;
+
+	/* Careful: folios don't exist in FDT on zero-size files. */
+	if (!inode->i_size)
+		return 0;
+
+	pfolios = memfd_luo_fdt_folios(fdt, &nr_folios);
+	if (!pfolios) {
+		pr_err("failed to fetch preserved folio list\n");
+		return -EINVAL;
+	}
+
+	inode = file->f_inode;
+	mapping = inode->i_mapping;
+
+	for (; i < nr_folios; i++) {
+		const struct memfd_luo_folio_ser *pfolio = &pfolios[i];
+		phys_addr_t phys;
+		u64 index;
+		int flags;
+
+		if (!pfolio->foliodesc)
+			continue;
+
+		phys = PFN_PHYS(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
+		folio = kho_restore_folio(phys);
+		if (!folio) {
+			pr_err("Unable to restore folio at physical address: %llx\n",
+			       phys);
+			goto put_folios;
+		}
+		index = pfolio->index;
+		flags = PRESERVED_FOLIO_FLAGS(pfolio->foliodesc);
+
+		/* Set up the folio for insertion. */
+		__folio_set_locked(folio);
+		__folio_set_swapbacked(folio);
+
+		err = mem_cgroup_charge(folio, NULL, mapping_gfp_mask(mapping));
+		if (err) {
+			pr_err("shmem: failed to charge folio index %ld: %d\n",
+			       i, err);
+			goto unlock_folio;
+		}
+
+		err = shmem_add_to_page_cache(folio, mapping, index, NULL,
+					      mapping_gfp_mask(mapping));
+		if (err) {
+			pr_err("shmem: failed to add to page cache folio index %ld: %d\n",
+			       i, err);
+			goto unlock_folio;
+		}
+
+		if (flags & PRESERVED_FLAG_UPTODATE)
+			folio_mark_uptodate(folio);
+		if (flags & PRESERVED_FLAG_DIRTY)
+			folio_mark_dirty(folio);
+
+		err = shmem_inode_acct_blocks(inode, 1);
+		if (err) {
+			pr_err("shmem: failed to account folio index %ld: %d\n",
+			       i, err);
+			goto unlock_folio;
+		}
+
+		shmem_recalc_inode(inode, 1, 0);
+		folio_add_lru(folio);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+
+	vfree(pfolios);
+	return 0;
+
+unlock_folio:
+	folio_unlock(folio);
+	folio_put(folio);
+	i++;
+put_folios:
+	/*
+	 * Note: don't free the folios already added to the file. They will be
+	 * freed when the file is freed. Free the ones not added yet here.
+	 */
+	for (; i < nr_folios; i++) {
+		const struct memfd_luo_folio_ser *pfolio = &pfolios[i];
+
+		folio = kho_restore_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
+		if (folio)
+			folio_put(folio);
+	}
+
+	vfree(pfolios);
+	return err;
+}
+
+static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
+{
+	struct folio *fdt_folio;
+	const u64 *pos, *size;
+	struct file *file;
+	int len, ret = 0;
+	const void *fdt;
+
+	fdt_folio = memfd_luo_get_fdt(args->serialized_data);
+	if (!fdt_folio)
+		return -ENOENT;
+
+	fdt = page_to_virt(folio_page(fdt_folio, 0));
+
+	size = fdt_getprop(fdt, 0, "size", &len);
+	if (!size || len != sizeof(u64)) {
+		pr_err("invalid 'size' property\n");
+		ret = -EINVAL;
+		goto put_fdt;
+	}
+
+	pos = fdt_getprop(fdt, 0, "pos", &len);
+	if (!pos || len != sizeof(u64)) {
+		pr_err("invalid 'pos' property\n");
+		ret = -EINVAL;
+		goto put_fdt;
+	}
+
+	file = shmem_file_setup("", 0, VM_NORESERVE);
+
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		pr_err("failed to setup file: %d\n", ret);
+		goto put_fdt;
+	}
+
+	vfs_setpos(file, *pos, MAX_LFS_FILESIZE);
+	file->f_inode->i_size = *size;
+
+	ret = memfd_luo_retrieve_folios(file, fdt);
+	if (ret)
+		goto put_file;
+
+	args->file = file;
+	folio_put(fdt_folio);
+	return 0;
+
+put_file:
+	fput(file);
+put_fdt:
+	folio_put(fdt_folio);
+	return ret;
+}
+
+static bool memfd_luo_can_preserve(struct liveupdate_file_handler *handler,
+				   struct file *file)
+{
+	struct inode *inode = file_inode(file);
+
+	return shmem_file(file) && !inode->i_nlink;
+}
+
+static const struct liveupdate_file_ops memfd_luo_file_ops = {
+	.freeze = memfd_luo_freeze,
+	.finish = memfd_luo_finish,
+	.retrieve = memfd_luo_retrieve,
+	.preserve = memfd_luo_preserve,
+	.unpreserve = memfd_luo_unpreserve,
+	.can_preserve = memfd_luo_can_preserve,
+	.owner = THIS_MODULE,
+};
+
+static struct liveupdate_file_handler memfd_luo_handler = {
+	.ops = &memfd_luo_file_ops,
+	.compatible = MEMFD_LUO_FH_COMPATIBLE,
+};
+
+static int __init memfd_luo_init(void)
+{
+	int err;
+
+	err = liveupdate_register_file_handler(&memfd_luo_handler);
+	if (err)
+		pr_err("Could not register luo filesystem handler: %d\n", err);
+
+	return err;
+}
+late_initcall(memfd_luo_init);
-- 
2.51.2.1041.gc1ab5b90ca-goog


