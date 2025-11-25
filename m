Return-Path: <linux-fsdevel+bounces-69820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63523C861BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2FF84EB7F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9269F3314BC;
	Tue, 25 Nov 2025 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YtQtC6Cg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1736B331203
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089978; cv=none; b=ilv1BD+mnLuTyIZmWLkGq/Jn/e152B5S4qdTujRRT6uRWneIadmlFa0hceTkzY13gsH4R1zPLvziiFqAToMdEzLTWE0zHU5aGVD7qjw6eyxGoyflk60CxxjnRO2bMr7GcLpfAKH3GmK1ZVJR02QFc8cr5yVY2ASybeGUGC7wWQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089978; c=relaxed/simple;
	bh=FoZhYQ5anN9QvxDg+LqoX1tvpbpX6PKiEw9R3dzkS2M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+e/2McFx3PxvweXwsQwbGLEvhd49S9U3Py4PgZEMKww7fsea0KHcr0cTfNnIa+prxOT+efLYuk/8fzpbg48xW45dqKxBMJN6S56xRS9OkrHS/IY7CaU8SUIb3QB9XSXUoaBdMqPIFUshhMgWA2CrQlp9dcyaB69FpDy93XxXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=YtQtC6Cg; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-787c9f90eccso59974457b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 08:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764089974; x=1764694774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoq1KHM//ceWZHYzHvP2GAeyKGu/ekSRGep2L5s8MQE=;
        b=YtQtC6Cg9C6m65HMIAnsVp0IM5jeaLNY89HFe+MJVan7NgwA5/CUxtovNkY0SakgTS
         pNpRqjZFOMMqo3i1q4hnsnd+S9QWWVh9xYwnYDCR58bhR3rG3BvfIo1/bKMnJc+fufre
         Hoj+ksyxMmKoHQddOKEbh7NzYpj6iK9iJ51e4o2nHPurpXzB/liExEC5kZ+ATHC4T47F
         5Jt0xZtRJpYoOIjlJhid2fWJrGPvoNg5YDTwxiXPN4ElQQiIzPHGqJnYN32I0447zbWm
         k/0zJ5DXi3Ycr8Wo7dCUVRsmLWPkMVTRXbaAyt9Ss/IfxvDndW8WJp0f50nYutbaojaC
         UcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089974; x=1764694774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hoq1KHM//ceWZHYzHvP2GAeyKGu/ekSRGep2L5s8MQE=;
        b=LWk7WaKtSTajpyGxf/IjhVg1+3OUYIGqtxu/SZ45csz22Zu0/ks6cvlZDD7RhBJcXN
         CGb9MKsS8V6ocT/u1M+e+yGOYyruUAUFsJE2w7216MFbMLmDtq2zzWR7ve1hidQv2fro
         P8yMvyY5Y5TP12CstKfBGbc+TOM4DNgX4pLGBUOawobKVGj4gem+chunOMi6ZPSV255P
         SFRiTUaQxp7NFQ72vPhb33hopJ5fBKidZoRH3lZcENj4tr55DuSUva7Bb2W7qHWE6lvf
         7EW3TC2DYtFFvuom5jJK9f3YKIx/eGf4iG94va9BcPi5YhqevKPxQZuJKBW1LYgyfQdk
         +tYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXphgIphoZnweYpDCLhPehgZhQPfv4DfxRds9bMPDWdgpnVBDlJ6EBxUJrD2ejwyN/wL9NT+Ae+M4E5te5e@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/acYSRRP3a23hPuLCFTwXMOCs8eDAGhi5qJRc3K+ETzc8HnV
	MKmAhuy8L7P/Yq+gkN7VZG9rTIZql2hQwR/11MrR1QJ9a4euAtL1X6CLFjiOcJSMQBY=
X-Gm-Gg: ASbGncvhrUtc6Akz403sbEv9K7K/4MnAi0/Hy62W+CGc+hJd+UP+oQJmztmrgvPowZF
	X+5pg5RpI65M2E+zN4/9toXOxNnptRTP3W4KQGtembl41/92aoZTvr5aN9t84eVlA1zK19XPd1x
	ZHkJhfwglKw7rxpo53lYsQAnw5pafhsGYffhXHi0eZtO7T+kni3xPDjJieyv0BZy5WBkTziMgUw
	Ue8x089yC2yC7IxwFSsLbzPFljN1UH2TufNvR+d5wwDtM2Qd1XrPB0B22VOhW1/fNq+nBlrAcUo
	laKbnbzISkcDcUY3e9dP8Tp95WIVr7RJpVoQVE6UbM/B6naO1PZuUaqvEal5JufJ7C1KgzFX80z
	q9Qrok/XtZQdfmyY0IWoUIWrGYb/0vOF322S3boViigBQ8h8qkvjkBkJ8U+gvtVglWRh+Ia2jpl
	G5D9741PuoTkLR4LyrYTGIMZh9aQIgmjqFHumbFpfkyeLb53I2grV2xWRrOrwG+eJ/MMF0wEaNF
	9+BcxQ=
X-Google-Smtp-Source: AGHT+IGhyqko2XNGAQ+MbliOV7Q7lZRrugm5nEIedcDe3Hixtd5DaNp0Tw4exj+v0JxhFqTVbLupfA==
X-Received: by 2002:a05:690c:45c5:b0:786:45ce:9bd3 with SMTP id 00721157ae682-78ab6f345bamr29492047b3.34.1764089974430;
        Tue, 25 Nov 2025 08:59:34 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a5518sm57284357b3.14.2025.11.25.08.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:59:33 -0800 (PST)
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
Subject: [PATCH v8 14/18] mm: memfd_luo: allow preserving memfd
Date: Tue, 25 Nov 2025 11:58:44 -0500
Message-ID: <20251125165850.3389713-15-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
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

Once preserved, the file cannot grow or shrink, and all its pages are
pinned to avoid migrations and swapping. The file can still be read from
or written to.

Use vmalloc to get the buffer to hold the folios, and preserve
it using kho_preserve_vmalloc(). This doesn't have the size limit.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 MAINTAINERS                   |   2 +
 include/linux/kho/abi/memfd.h |  77 +++++
 mm/Makefile                   |   1 +
 mm/memfd_luo.c                | 516 ++++++++++++++++++++++++++++++++++
 4 files changed, 596 insertions(+)
 create mode 100644 include/linux/kho/abi/memfd.h
 create mode 100644 mm/memfd_luo.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 868d3d23fdea..425c46bba764 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14469,6 +14469,7 @@ F:	tools/testing/selftests/livepatch/
 LIVE UPDATE
 M:	Pasha Tatashin <pasha.tatashin@soleen.com>
 M:	Mike Rapoport <rppt@kernel.org>
+R:	Pratyush Yadav <pratyush@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/core-api/liveupdate.rst
@@ -14477,6 +14478,7 @@ F:	include/linux/liveupdate.h
 F:	include/linux/liveupdate/
 F:	include/uapi/linux/liveupdate.h
 F:	kernel/liveupdate/
+F:	mm/memfd_luo.c
 
 LLC (802.2)
 L:	netdev@vger.kernel.org
diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
new file mode 100644
index 000000000000..da7d063474a1
--- /dev/null
+++ b/include/linux/kho/abi/memfd.h
@@ -0,0 +1,77 @@
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
+#ifndef _LINUX_KHO_ABI_MEMFD_H
+#define _LINUX_KHO_ABI_MEMFD_H
+
+#include <linux/types.h>
+#include <linux/kexec_handover.h>
+
+/**
+ * DOC: memfd Live Update ABI
+ *
+ * This header defines the ABI for preserving the state of a memfd across a
+ * kexec reboot using the LUO.
+ *
+ * The state is serialized into a packed structure `struct memfd_luo_ser`
+ * which is handed over to the next kernel via the KHO mechanism.
+ *
+ * This interface is a contract. Any modification to the structure layout
+ * constitutes a breaking change. Such changes require incrementing the
+ * version number in the MEMFD_LUO_FH_COMPATIBLE string.
+ */
+
+/**
+ * MEMFD_LUO_FOLIO_DIRTY - The folio is dirty.
+ *
+ * This flag indicates the folio contains data from user. A non-dirty folio is
+ * one that was allocated (say using fallocate(2)) but not written to.
+ */
+#define MEMFD_LUO_FOLIO_DIRTY		BIT(0)
+
+/**
+ * MEMFD_LUO_FOLIO_UPTODATE - The folio is up-to-date.
+ *
+ * An up-to-date folio has been zeroed out. shmem zeroes out folios on first
+ * use. This flag tracks which folios need zeroing.
+ */
+#define MEMFD_LUO_FOLIO_UPTODATE	BIT(1)
+
+/**
+ * struct memfd_luo_folio_ser - Serialized state of a single folio.
+ * @pfn:       The page frame number of the folio.
+ * @flags:     Flags to describe the state of the folio.
+ * @index:     The page offset (pgoff_t) of the folio within the original file.
+ */
+struct memfd_luo_folio_ser {
+	u64 pfn:52;
+	u64 flags:12;
+	u64 index;
+} __packed;
+
+/**
+ * struct memfd_luo_ser - Main serialization structure for a memfd.
+ * @pos:       The file's current position (f_pos).
+ * @size:      The total size of the file in bytes (i_size).
+ * @nr_folios: Number of folios in the folios array.
+ * @folios:    KHO vmalloc descriptor pointing to the array of
+ *             struct memfd_luo_folio_ser.
+ */
+struct memfd_luo_ser {
+	u64 pos;
+	u64 size;
+	u64 nr_folios;
+	struct kho_vmalloc folios;
+} __packed;
+
+/* The compatibility string for memfd file handler */
+#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v1"
+
+#endif /* _LINUX_KHO_ABI_MEMFD_H */
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
index 000000000000..4f6ba63b4310
--- /dev/null
+++ b/mm/memfd_luo.c
@@ -0,0 +1,516 @@
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
+/**
+ * DOC: Memfd Preservation via LUO
+ *
+ * Overview
+ * ========
+ *
+ * Memory file descriptors (memfd) can be preserved over a kexec using the Live
+ * Update Orchestrator (LUO) file preservation. This allows userspace to
+ * transfer its memory contents to the next kernel after a kexec.
+ *
+ * The preservation is not intended to be transparent. Only select properties of
+ * the file are preserved. All others are reset to default. The preserved
+ * properties are described below.
+ *
+ * .. note::
+ *    The LUO API is not stabilized yet, so the preserved properties of a memfd
+ *    are also not stable and are subject to backwards incompatible changes.
+ *
+ * .. note::
+ *    Currently a memfd backed by Hugetlb is not supported. Memfds created
+ *    with ``MFD_HUGETLB`` will be rejected.
+ *
+ * Preserved Properties
+ * ====================
+ *
+ * The following properties of the memfd are preserved across kexec:
+ *
+ * File Contents
+ *   All data stored in the file is preserved.
+ *
+ * File Size
+ *   The size of the file is preserved. Holes in the file are filled by
+ *   allocating pages for them during preservation.
+ *
+ * File Position
+ *   The current file position is preserved, allowing applications to continue
+ *   reading/writing from their last position.
+ *
+ * File Status Flags
+ *   memfds are always opened with ``O_RDWR`` and ``O_LARGEFILE``. This property
+ *   is maintained.
+ *
+ * Non-Preserved Properties
+ * ========================
+ *
+ * All properties which are not preserved must be assumed to be reset to
+ * default. This section describes some of those properties which may be more of
+ * note.
+ *
+ * ``FD_CLOEXEC`` flag
+ *   A memfd can be created with the ``MFD_CLOEXEC`` flag that sets the
+ *   ``FD_CLOEXEC`` on the file. This flag is not preserved and must be set
+ *   again after restore via ``fcntl()``.
+ *
+ * Seals
+ *   File seals are not preserved. The file is unsealed on restore and if
+ *   needed, must be sealed again via ``fcntl()``.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/file.h>
+#include <linux/io.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/memfd.h>
+#include <linux/liveupdate.h>
+#include <linux/shmem_fs.h>
+#include <linux/vmalloc.h>
+#include "internal.h"
+
+static int memfd_luo_preserve_folios(struct file *file,
+				     struct kho_vmalloc *kho_vmalloc,
+				     struct memfd_luo_folio_ser **out_folios_ser,
+				     u64 *nr_foliosp)
+{
+	struct inode *inode = file_inode(file);
+	struct memfd_luo_folio_ser *folios_ser;
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
+		*out_folios_ser = NULL;
+		memset(kho_vmalloc, 0, sizeof(*kho_vmalloc));
+		return 0;
+	}
+
+	/*
+	 * Guess the number of folios based on inode size. Real number might end
+	 * up being smaller if there are higher order folios.
+	 */
+	max_folios = PAGE_ALIGN(size) / PAGE_SIZE;
+	folios = kvmalloc_array(max_folios, sizeof(*folios), GFP_KERNEL);
+	if (!folios)
+		return -ENOMEM;
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
+	folios_ser = vcalloc(nr_folios, sizeof(*folios_ser));
+	if (!folios_ser) {
+		err = -ENOMEM;
+		goto err_unpin;
+	}
+
+	for (i = 0; i < nr_folios; i++) {
+		struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+		struct folio *folio = folios[i];
+		unsigned int flags = 0;
+
+		err = kho_preserve_folio(folio);
+		if (err)
+			goto err_unpreserve;
+
+		if (folio_test_dirty(folio))
+			flags |= MEMFD_LUO_FOLIO_DIRTY;
+		if (folio_test_uptodate(folio))
+			flags |= MEMFD_LUO_FOLIO_UPTODATE;
+
+		pfolio->pfn = folio_pfn(folio);
+		pfolio->flags = flags;
+		pfolio->index = folio->index;
+	}
+
+	err = kho_preserve_vmalloc(folios_ser, kho_vmalloc);
+	if (err)
+		goto err_unpreserve;
+
+	kvfree(folios);
+	*nr_foliosp = nr_folios;
+	*out_folios_ser = folios_ser;
+
+	/*
+	 * Note: folios_ser is purposely not freed here. It is preserved
+	 * memory (via KHO). In the 'unpreserve' path, we use the vmap pointer
+	 * that is passed via private_data.
+	 */
+	return 0;
+
+err_unpreserve:
+	for (i = i - 1; i >= 0; i--)
+		kho_unpreserve_folio(folios[i]);
+	vfree(folios_ser);
+err_unpin:
+	unpin_folios(folios, nr_folios);
+err_free_folios:
+	kvfree(folios);
+
+	return err;
+}
+
+static void memfd_luo_unpreserve_folios(struct kho_vmalloc *kho_vmalloc,
+					struct memfd_luo_folio_ser *folios_ser,
+					u64 nr_folios)
+{
+	long i;
+
+	if (!nr_folios)
+		return;
+
+	kho_unpreserve_vmalloc(kho_vmalloc);
+
+	for (i = 0; i < nr_folios; i++) {
+		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+		struct folio *folio;
+
+		if (!pfolio->pfn)
+			continue;
+
+		folio = pfn_folio(pfolio->pfn);
+
+		kho_unpreserve_folio(folio);
+		unpin_folio(folio);
+	}
+
+	vfree(folios_ser);
+}
+
+static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
+{
+	struct inode *inode = file_inode(args->file);
+	struct memfd_luo_folio_ser *folios_ser;
+	struct memfd_luo_ser *ser;
+	u64 nr_folios;
+	int err = 0;
+
+	inode_lock(inode);
+	shmem_freeze(inode, true);
+
+	/* Allocate the main serialization structure in preserved memory */
+	ser = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(ser)) {
+		err = PTR_ERR(ser);
+		goto err_unlock;
+	}
+
+	ser->pos = args->file->f_pos;
+	ser->size = i_size_read(inode);
+
+	err = memfd_luo_preserve_folios(args->file, &ser->folios,
+					&folios_ser, &nr_folios);
+	if (err)
+		goto err_free_ser;
+
+	ser->nr_folios = nr_folios;
+	inode_unlock(inode);
+
+	args->private_data = folios_ser;
+	args->serialized_data = virt_to_phys(ser);
+
+	return 0;
+
+err_free_ser:
+	kho_unpreserve_free(ser);
+err_unlock:
+	shmem_freeze(inode, false);
+	inode_unlock(inode);
+	return err;
+}
+
+static int memfd_luo_freeze(struct liveupdate_file_op_args *args)
+{
+	struct memfd_luo_ser *ser;
+
+	if (WARN_ON_ONCE(!args->serialized_data))
+		return -EINVAL;
+
+	ser = phys_to_virt(args->serialized_data);
+
+	/*
+	 * The pos might have changed since prepare. Everything else stays the
+	 * same.
+	 */
+	ser->pos = args->file->f_pos;
+
+	return 0;
+}
+
+static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
+{
+	struct inode *inode = file_inode(args->file);
+	struct memfd_luo_ser *ser;
+
+	if (WARN_ON_ONCE(!args->serialized_data))
+		return;
+
+	inode_lock(inode);
+	shmem_freeze(inode, false);
+
+	ser = phys_to_virt(args->serialized_data);
+
+	memfd_luo_unpreserve_folios(&ser->folios, args->private_data,
+				    ser->nr_folios);
+
+	kho_unpreserve_free(ser);
+	inode_unlock(inode);
+}
+
+static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_ser,
+				     u64 nr_folios)
+{
+	u64 i;
+
+	for (i = 0; i < nr_folios; i++) {
+		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+		struct folio *folio;
+		phys_addr_t phys;
+
+		if (!pfolio->pfn)
+			continue;
+
+		phys = PFN_PHYS(pfolio->pfn);
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
+	struct memfd_luo_folio_ser *folios_ser;
+	struct memfd_luo_ser *ser;
+
+	if (args->retrieved)
+		return;
+
+	ser = phys_to_virt(args->serialized_data);
+	if (!ser)
+		return;
+
+	if (ser->nr_folios) {
+		folios_ser = kho_restore_vmalloc(&ser->folios);
+		if (!folios_ser)
+			goto out;
+
+		memfd_luo_discard_folios(folios_ser, ser->nr_folios);
+		vfree(folios_ser);
+	}
+
+out:
+	kho_restore_free(ser);
+}
+
+static int memfd_luo_retrieve_folios(struct file *file,
+				     struct memfd_luo_folio_ser *folios_ser,
+				     u64 nr_folios)
+{
+	struct inode *inode = file_inode(file);
+	struct address_space *mapping = inode->i_mapping;
+	struct folio *folio;
+	int err = -EIO;
+	long i;
+
+	for (i = 0; i < nr_folios; i++) {
+		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+		phys_addr_t phys;
+		u64 index;
+		int flags;
+
+		if (!pfolio->pfn)
+			continue;
+
+		phys = PFN_PHYS(pfolio->pfn);
+		folio = kho_restore_folio(phys);
+		if (!folio) {
+			pr_err("Unable to restore folio at physical address: %llx\n",
+			       phys);
+			goto put_folios;
+		}
+		index = pfolio->index;
+		flags = pfolio->flags;
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
+		if (flags & MEMFD_LUO_FOLIO_UPTODATE)
+			folio_mark_uptodate(folio);
+		if (flags & MEMFD_LUO_FOLIO_DIRTY)
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
+	return 0;
+
+unlock_folio:
+	folio_unlock(folio);
+	folio_put(folio);
+put_folios:
+	/*
+	 * Note: don't free the folios already added to the file. They will be
+	 * freed when the file is freed. Free the ones not added yet here.
+	 */
+	for (long j = i + 1; j < nr_folios; j++) {
+		const struct memfd_luo_folio_ser *pfolio = &folios_ser[j];
+
+		folio = kho_restore_folio(pfolio->pfn);
+		if (folio)
+			folio_put(folio);
+	}
+
+	return err;
+}
+
+static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
+{
+	struct memfd_luo_folio_ser *folios_ser;
+	struct memfd_luo_ser *ser;
+	struct file *file;
+	int err;
+
+	ser = phys_to_virt(args->serialized_data);
+	if (!ser)
+		return -EINVAL;
+
+	file = shmem_file_setup("", 0, VM_NORESERVE);
+
+	if (IS_ERR(file)) {
+		pr_err("failed to setup file: %pe\n", file);
+		return PTR_ERR(file);
+	}
+
+	vfs_setpos(file, ser->pos, MAX_LFS_FILESIZE);
+	file->f_inode->i_size = ser->size;
+
+	if (ser->nr_folios) {
+		folios_ser = kho_restore_vmalloc(&ser->folios);
+		if (!folios_ser) {
+			err = -EINVAL;
+			goto put_file;
+		}
+
+		err = memfd_luo_retrieve_folios(file, folios_ser, ser->nr_folios);
+		vfree(folios_ser);
+		if (err)
+			goto put_file;
+	}
+
+	args->file = file;
+	kho_restore_free(ser);
+
+	return 0;
+
+put_file:
+	fput(file);
+
+	return err;
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
+	int err = liveupdate_register_file_handler(&memfd_luo_handler);
+
+	if (err && err != -EOPNOTSUPP) {
+		pr_err("Could not register luo filesystem handler: %pe\n",
+		       ERR_PTR(err));
+
+		return err;
+	}
+
+	return 0;
+}
+late_initcall(memfd_luo_init);
-- 
2.52.0.460.gd25c4c69ec-goog


