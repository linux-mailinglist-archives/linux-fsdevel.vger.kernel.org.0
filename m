Return-Path: <linux-fsdevel+bounces-53025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1857AAE9294
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F9518911D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222362FCFF1;
	Wed, 25 Jun 2025 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="F2Lhy7YB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F5309DA0
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893575; cv=none; b=sBPHzmwhJ8lBFADmI7Ha++pYNg4kIEA7jiHIHJ2ybisyqIdI3q8nhYooHEV595iBPzDI4/yMcPUqdyNgPaFMSbWYZ23Ox9H358VQrnzTr4O6vw84tOqbNQYKENJO3zCy25IqNU7T09jQInX1zLnIVIBVjRHHQCzRCbs29uRcyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893575; c=relaxed/simple;
	bh=SUhfiaRdom8GiwIhJ8wQMxYxsTjqLfGzP5+hkUDllOo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hP3QjtGPPlVY/FiVsynIG6+v34/rcgQU9zTvDAbj5oQ8HkJDXBEyLbOKg41+rf/hZo9IbXjLKy/Z1nx1L0uKH2Y9kT5JRzMm0+tfIRLbYU7py2qdPz8dTrTi2wU66oYle3Sruqv03QdQ3aSUxGBfiv+RpvZXj9jUUx7dRhFOF3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=F2Lhy7YB; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so315415276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893572; x=1751498372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RO9J/1O/UI39hg/+jcvh/jRjoHLl2cHs/8R58PXGL84=;
        b=F2Lhy7YB1bGxzjs8ds+Is+bh6ADv4Y96vttsIJMLSSPOh+wHKOKm1LLsq9qJIFDfgh
         wqCtSVNrapeCIMIEQfE4YE+v6qQiA6VF9W0xCmcr0F9I9rx6ragFcDtE2fdemnMtLijB
         eJa78XB/wXRDjxkkhlFZDA6glvm7g2+NXGYa1qklk+eKBXWrUG6Y2qwTgl4yJIoKW80m
         4KhzSQkAqanS+yz6NNXmdAlK2WZZqJQgLkqpU7Fo/noBO8MrQkjqJMCsShW5yGG2eOej
         zPi/Kf1QdRJqjdWSdppae0B2aBhuWu0uJX639ixFUOdvNr7pXG9YucoItNMGyXUUrVLn
         qPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893572; x=1751498372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RO9J/1O/UI39hg/+jcvh/jRjoHLl2cHs/8R58PXGL84=;
        b=mFh+5aTMSbHlZw0JCpkY2VvujwedF4C1K3t3X8vGhviQ+IOEceVzQlC7OKeIstzlUz
         Psdasj9Q7EoxquF7jWqlvD9rj+1Q3Dw9ykr9sRaIFvAa55ARWzmATmZY4uqL80hbUFUT
         CtID035T/ZiZSFv2VO4zklbhL/toTjq8jHxXrbuhQPQzXPkZ/IBhK0/wLc6ZU14NXfXF
         OkYHpUY/nIjT/5tivdglDDem6aXE48KUuuGkMJjAPWv/BlUFEqhxv1hlE9RQVkuCmRKF
         M1rMRvRHtTn9wc3/B4DFaZ61ihjldYsrT28pz3N3BMOfD1qGQq7Uvjri5CS92PmLcAIP
         AdKg==
X-Forwarded-Encrypted: i=1; AJvYcCW673uQvGbzq/e9B7xLYDFd1Sb2/ZyijaKSYWY3ofqI313OPLa6Vvu2COmaLL0QYqEwS1pW0t7ldXK+3Ftp@vger.kernel.org
X-Gm-Message-State: AOJu0YxgAZ7aMsveXPNNbhY6DI2oCK4YGP1ZqQY287URgdFRA3+L2wMa
	FIjiP4sGz+Ag9F2arnUFeDRkk+xXP7BsW2PuxjgcYF3lc7fS5XG/ZbtvsjW90lUQdhA=
X-Gm-Gg: ASbGncvA6Must9ffZssG1xOo5XT5DwiWetnyrLYdy7xWbCp+SbCa5GOUWTSWQYibENV
	2w+MkvXGcxbOpJ1otu3RVnOjHa+nEye/UUUYWObjt8SWNNKlIJIfYr/PSRyX3LJvUpcvEeBfIU0
	xChgZs5JSdHZT5E8zAmvSO0E3U+w3YP43Vc+GYE6rWBLAMHHLdlAvdnzKgCCqhZfoCOAUHntYUi
	8Jm1B4I6Vo2R/8+F88IVll1GnejxmFOHkyH7k9X8gziAD3nC58n5Uo7AVBqBrNHD43YAFdi4O61
	H8YhOGJc2G4vpaSqyZYAjQRJbKoDyzJ7B+hQHCHn/HTu6WVtbQE3TDZEDRhweYS/HnnEHxo8CQ3
	wNfaYh4vVhCy0M+hNwTOitt7IQrhwKxdaPD98A3dlDK8YHEHoSYQz
X-Google-Smtp-Source: AGHT+IEHduHWl+pOl18uO8sqkAHlRHUmh8yA8zbZaW9a7AAvhsk7bTscKnxbnJ0nK8vdM9txokq8qQ==
X-Received: by 2002:a05:6902:1247:b0:e82:24ae:c3ae with SMTP id 3f1490d57ef6-e8601725ac2mr6883222276.21.1750893572044;
        Wed, 25 Jun 2025 16:19:32 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:31 -0700 (PDT)
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 28/32] luo: allow preserving memfd
Date: Wed, 25 Jun 2025 23:18:15 +0000
Message-ID: <20250625231838.1897085-29-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
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

Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---
 MAINTAINERS    |   2 +
 mm/Makefile    |   1 +
 mm/memfd_luo.c | 501 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 504 insertions(+)
 create mode 100644 mm/memfd_luo.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 90554f3a1bec..163f38cd55b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14011,6 +14011,7 @@ F:	tools/testing/selftests/livepatch/
 
 LIVE UPDATE
 M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+R:	Pratyush Yadav <pratyush@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
@@ -14020,6 +14021,7 @@ F:	Documentation/userspace-api/liveupdate.rst
 F:	include/linux/liveupdate.h
 F:	include/uapi/linux/liveupdate.h
 F:	kernel/liveupdate/
+F:	mm/memfd_luo.c
 F:	tools/testing/selftests/liveupdate/
 
 LLC (802.2)
diff --git a/mm/Makefile b/mm/Makefile
index 1a7a11d4933d..63cca66c068a 100644
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
index 000000000000..339824ab6729
--- /dev/null
+++ b/mm/memfd_luo.c
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ * Changyuan Lyu <changyuanl@google.com>
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
+#include <linux/kexec_handover.h>
+#include <linux/shmem_fs.h>
+#include <linux/bits.h>
+#include "internal.h"
+
+static const char memfd_luo_compatible[] = "memfd-v1";
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
+struct memfd_luo_preserved_folio {
+	/*
+	 * The folio descriptor is made of 2 parts. The bottom 12 bits are used
+	 * for storing flags, the others for storing the PFN.
+	 */
+	u64 foliodesc;
+	u64 index;
+};
+
+static int memfd_luo_preserve_folios(struct memfd_luo_preserved_folio *pfolios,
+				     struct folio **folios,
+				     unsigned int nr_folios)
+{
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < nr_folios; i++) {
+		struct memfd_luo_preserved_folio *pfolio = &pfolios[i];
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
+	return 0;
+
+err_unpreserve:
+	i--;
+	for (; i >= 0; i--)
+		WARN_ON_ONCE(kho_unpreserve_folio(folios[i]));
+	return err;
+}
+
+static void memfd_luo_unpreserve_folios(const struct memfd_luo_preserved_folio *pfolios,
+					unsigned int nr_folios)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_folios; i++) {
+		const struct memfd_luo_preserved_folio *pfolio = &pfolios[i];
+		struct folio *folio;
+
+		if (!pfolio->foliodesc)
+			continue;
+
+		folio = pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
+
+		kho_unpreserve_folio(folio);
+		unpin_folio(folio);
+	}
+}
+
+static void *memfd_luo_create_fdt(unsigned long size)
+{
+	unsigned int order = get_order(size);
+	struct folio *fdt_folio;
+	int err = 0;
+	void *fdt;
+
+	if (order > MAX_PAGE_ORDER)
+		return NULL;
+
+	fdt_folio = folio_alloc(GFP_KERNEL, order);
+	if (!fdt_folio)
+		return NULL;
+
+	fdt = folio_address(fdt_folio);
+
+	err |= fdt_create(fdt, (1 << (order + PAGE_SHIFT)));
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
+static int memfd_luo_prepare(struct file *file, void *arg, u64 *data)
+{
+	struct memfd_luo_preserved_folio *preserved_folios;
+	struct inode *inode = file_inode(file);
+	unsigned int max_folios, nr_folios = 0;
+	int err = 0, preserved_size;
+	struct folio **folios;
+	long size, nr_pinned;
+	pgoff_t offset;
+	void *fdt;
+	u64 pos;
+
+	if (WARN_ON_ONCE(!shmem_file(file)))
+		return -EINVAL;
+
+	inode_lock(inode);
+	shmem_i_mapping_freeze(inode, true);
+
+	size = i_size_read(inode);
+	if ((PAGE_ALIGN(size) / PAGE_SIZE) > UINT_MAX) {
+		err = -E2BIG;
+		goto err_unlock;
+	}
+
+	/*
+	 * Guess the number of folios based on inode size. Real number might end
+	 * up being smaller if there are higher order folios.
+	 */
+	max_folios = PAGE_ALIGN(size) / PAGE_SIZE;
+	folios = kvmalloc_array(max_folios, sizeof(*folios), GFP_KERNEL);
+	if (!folios) {
+		err = -ENOMEM;
+		goto err_unfreeze;
+	}
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
+	/* nr_pinned won't be more than max_folios which is also unsigned int. */
+	nr_folios = (unsigned int)nr_pinned;
+
+	preserved_size = sizeof(struct memfd_luo_preserved_folio) * nr_folios;
+	if (check_mul_overflow(sizeof(struct memfd_luo_preserved_folio),
+			       nr_folios, &preserved_size)) {
+		err = -E2BIG;
+		goto err_unpin;
+	}
+
+	/*
+	 * Most of the space should be taken by preserved folios. So take its
+	 * size, plus a page for other properties.
+	 */
+	fdt = memfd_luo_create_fdt(PAGE_ALIGN(preserved_size) + PAGE_SIZE);
+	if (!fdt) {
+		err = -ENOMEM;
+		goto err_unpin;
+	}
+
+	pos = file->f_pos;
+	err = fdt_property(fdt, "pos", &pos, sizeof(pos));
+	if (err)
+		goto err_free_fdt;
+
+	err = fdt_property(fdt, "size", &size, sizeof(size));
+	if (err)
+		goto err_free_fdt;
+
+	err = fdt_property_placeholder(fdt, "folios", preserved_size,
+				       (void **)&preserved_folios);
+	if (err) {
+		pr_err("Failed to reserve folios property in FDT: %s\n",
+		       fdt_strerror(err));
+		err = -ENOMEM;
+		goto err_free_fdt;
+	}
+
+	err = memfd_luo_preserve_folios(preserved_folios, folios, nr_folios);
+	if (err)
+		goto err_free_fdt;
+
+	err = memfd_luo_finish_fdt(fdt);
+	if (err)
+		goto err_unpreserve;
+
+	err = kho_preserve_folio(virt_to_folio(fdt));
+	if (err)
+		goto err_unpreserve;
+
+	kvfree(folios);
+	inode_unlock(inode);
+
+	*data = virt_to_phys(fdt);
+	return 0;
+
+err_unpreserve:
+	memfd_luo_unpreserve_folios(preserved_folios, nr_folios);
+err_free_fdt:
+	folio_put(virt_to_folio(fdt));
+err_unpin:
+	unpin_folios(folios, nr_pinned);
+err_free_folios:
+	kvfree(folios);
+err_unfreeze:
+	shmem_i_mapping_freeze(inode, false);
+err_unlock:
+	inode_unlock(inode);
+	return err;
+}
+
+static int memfd_luo_freeze(struct file *file, void *arg, u64 *data)
+{
+	u64 pos = file->f_pos;
+	void *fdt;
+	int err;
+
+	if (WARN_ON_ONCE(!*data))
+		return -EINVAL;
+
+	fdt = phys_to_virt(*data);
+
+	/*
+	 * The pos or size might have changed since prepare. Everything else
+	 * stays the same.
+	 */
+	err = fdt_setprop(fdt, 0, "pos", &pos, sizeof(pos));
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void memfd_luo_cancel(struct file *file, void *arg, u64 data)
+{
+	const struct memfd_luo_preserved_folio *pfolios;
+	struct inode *inode = file_inode(file);
+	struct folio *fdt_folio;
+	void *fdt;
+	int len;
+
+	if (WARN_ON_ONCE(!data))
+		return;
+
+	inode_lock(inode);
+	shmem_i_mapping_freeze(inode, false);
+
+	fdt = phys_to_virt(data);
+	fdt_folio = virt_to_folio(fdt);
+	pfolios = fdt_getprop(fdt, 0, "folios", &len);
+	if (pfolios)
+		memfd_luo_unpreserve_folios(pfolios, len / sizeof(*pfolios));
+
+	kho_unpreserve_folio(fdt_folio);
+	folio_put(fdt_folio);
+	inode_unlock(inode);
+}
+
+static struct folio *memfd_luo_get_fdt(u64 data)
+{
+	return kho_restore_folio((phys_addr_t)data);
+}
+
+static void memfd_luo_finish(struct file *file, void *arg, u64 data,
+			     bool reclaimed)
+{
+	const struct memfd_luo_preserved_folio *pfolios;
+	struct folio *fdt_folio;
+	int len;
+
+	if (reclaimed)
+		return;
+
+	fdt_folio = memfd_luo_get_fdt(data);
+
+	pfolios = fdt_getprop(folio_address(fdt_folio), 0, "folios", &len);
+	if (pfolios)
+		memfd_luo_unpreserve_folios(pfolios, len / sizeof(*pfolios));
+
+	folio_put(fdt_folio);
+}
+
+static int memfd_luo_retrieve(void *arg, u64 data, struct file **file_p)
+{
+	const struct memfd_luo_preserved_folio *pfolios;
+	int nr_pfolios, len, ret = 0, i = 0;
+	struct address_space *mapping;
+	struct folio *folio, *fdt_folio;
+	const u64 *pos, *size;
+	struct inode *inode;
+	struct file *file;
+	const void *fdt;
+
+	fdt_folio = memfd_luo_get_fdt(data);
+	if (!fdt_folio)
+		return -ENOENT;
+
+	fdt = page_to_virt(folio_page(fdt_folio, 0));
+
+	pfolios = fdt_getprop(fdt, 0, "folios", &len);
+	if (!pfolios || len % sizeof(*pfolios)) {
+		pr_err("invalid 'folios' property\n");
+		ret = -EINVAL;
+		goto put_fdt;
+	}
+	nr_pfolios = len / sizeof(*pfolios);
+
+	size = fdt_getprop(fdt, 0, "size", &len);
+	if (!size || len != sizeof(u64)) {
+		pr_err("invalid 'size' property\n");
+		ret = -EINVAL;
+		goto put_folios;
+	}
+
+	pos = fdt_getprop(fdt, 0, "pos", &len);
+	if (!pos || len != sizeof(u64)) {
+		pr_err("invalid 'pos' property\n");
+		ret = -EINVAL;
+		goto put_folios;
+	}
+
+	file = shmem_file_setup("", 0, VM_NORESERVE);
+
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		pr_err("failed to setup file: %d\n", ret);
+		goto put_folios;
+	}
+
+	inode = file->f_inode;
+	mapping = inode->i_mapping;
+	vfs_setpos(file, *pos, MAX_LFS_FILESIZE);
+
+	for (; i < nr_pfolios; i++) {
+		const struct memfd_luo_preserved_folio *pfolio = &pfolios[i];
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
+			goto put_file;
+		}
+		index = pfolio->index;
+		flags = PRESERVED_FOLIO_FLAGS(pfolio->foliodesc);
+
+		/* Set up the folio for insertion. */
+		/*
+		 * TODO: Should find a way to unify this and
+		 * shmem_alloc_and_add_folio().
+		 */
+		__folio_set_locked(folio);
+		__folio_set_swapbacked(folio);
+
+		ret = mem_cgroup_charge(folio, NULL, mapping_gfp_mask(mapping));
+		if (ret) {
+			pr_err("shmem: failed to charge folio index %d: %d\n",
+			       i, ret);
+			goto unlock_folio;
+		}
+
+		ret = shmem_add_to_page_cache(folio, mapping, index, NULL,
+					      mapping_gfp_mask(mapping));
+		if (ret) {
+			pr_err("shmem: failed to add to page cache folio index %d: %d\n",
+			       i, ret);
+			goto unlock_folio;
+		}
+
+		if (flags & PRESERVED_FLAG_UPTODATE)
+			folio_mark_uptodate(folio);
+		if (flags & PRESERVED_FLAG_DIRTY)
+			folio_mark_dirty(folio);
+
+		ret = shmem_inode_acct_blocks(inode, 1);
+		if (ret) {
+			pr_err("shmem: failed to account folio index %d: %d\n",
+			       i, ret);
+			goto unlock_folio;
+		}
+
+		shmem_recalc_inode(inode, 1, 0);
+		folio_add_lru(folio);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+
+	inode->i_size = *size;
+	*file_p = file;
+	folio_put(fdt_folio);
+	return 0;
+
+unlock_folio:
+	folio_unlock(folio);
+	folio_put(folio);
+put_file:
+	fput(file);
+	i++;
+put_folios:
+	for (; i < nr_pfolios; i++) {
+		const struct memfd_luo_preserved_folio *pfolio = &pfolios[i];
+
+		folio = kho_restore_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
+		if (folio)
+			folio_put(folio);
+	}
+
+put_fdt:
+	folio_put(fdt_folio);
+	return ret;
+}
+
+static bool memfd_luo_can_preserve(struct file *file, void *arg)
+{
+	struct inode *inode = file_inode(file);
+
+	return shmem_file(file) && !inode->i_nlink;
+}
+
+static const struct liveupdate_file_ops memfd_luo_file_ops = {
+	.prepare = memfd_luo_prepare,
+	.freeze = memfd_luo_freeze,
+	.cancel = memfd_luo_cancel,
+	.finish = memfd_luo_finish,
+	.retrieve = memfd_luo_retrieve,
+	.can_preserve = memfd_luo_can_preserve,
+};
+
+static struct liveupdate_file_handler memfd_luo_handler = {
+	.ops = &memfd_luo_file_ops,
+	.compatible = memfd_luo_compatible,
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
2.50.0.727.gbf7dc18ff4-goog


