Return-Path: <linux-fsdevel+bounces-22779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7234291C121
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 16:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3BC51F2299C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009801C8FA2;
	Fri, 28 Jun 2024 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpZLKDTp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3FC1C68A1;
	Fri, 28 Jun 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585354; cv=none; b=KK499P9jcUfW67JjP70ibnozMoAVz37VvOi7kC7Rm0JUznLYIrSMdo6/5Z0tAMGfyONwLwctd+ZZhZ1ZI9KEJNH3Sp0AJO+8uLeYqMHQeeOB/jR3r2Xe2KSXgd8tiYo+u3jZhKsIYiYtms1JKr+puQJDBpKBH5xpAl8HttQ2fXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585354; c=relaxed/simple;
	bh=3+RZKRxPc3tdSL+8XSiyeruuwKU4cyVaE9PeUJmhu9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKNeynd4Mwuh4EF1DwZB0zVk7KT6liTUsvn3sf5TyYdMZOt22vKXOZ1lqZ4diXt0/R8wxyTAdlDwHbljRpRX/aF9r+TsQM7PlDGWpVJiK2f3gVxEJld/OiIERlJOnJGeanbPo7srLXXUXuiyQ4ALUbVPJjJRrNDYZsVyps97hRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpZLKDTp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4255fc43f1cso4852835e9.0;
        Fri, 28 Jun 2024 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719585350; x=1720190150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4z0i7Y8HIpyBHs7U6k/ncTPiwaVGdjuzgwtoOXRYYA=;
        b=EpZLKDTpHg0mJa2p7C9Cl+b19cn94dMVruM/W5t98E4PDwBMFg11twXfSGgKpNEujm
         ZBLcjpj6R2P5t+v3HQUWvhyA6r2dvjt0C4XkjV6onNsrTjeFSRhzGfkv01q6Vd5EB2g5
         bV3PO9XZ5vFgi7FLff7UTJoIF+KNb7/WSBte/eTcfOKeb3zOK/QyrKycdSU9g8mY2gNI
         m90SYpHqGJtqSxA9lRZUC13zK5TDFKZNje9t7I05sYCKNyFaJipLZof2zS49DQ1kkwqi
         mK0keZexDmvSQRcDSFz/lapYOjiRRbAJ/dNh98TiXVhpG4vl1tKO0YKf6P4/lA9GcOEv
         q+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719585350; x=1720190150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4z0i7Y8HIpyBHs7U6k/ncTPiwaVGdjuzgwtoOXRYYA=;
        b=wwvb4CM4CkpIaY+ZAoSzJ6NFD4mYMtDdJ0JoMNGri4YlSatohPgQ5C8Y3owtj9P+0m
         IJVOnWvU4KiXlosGjIB9Z2lQwEtlUQLvQHV2T7QFWQPPREBuuChcrFYM4P9EWHbzlSRw
         j4CnCjjI9iTn9nOBcmjYycEiUQuICAPuJPe5RyNv6CfSxf+OuTnFZL/wETifKLAAFciO
         12MeZAMCzM/ClD9fM4ikoL3XuFre6FnvK1Jjzk/dYBJHviBAFoTw9A9La1o3eno3JJ17
         HFeHIQxUZuarZd6Z4D/ffscvlzTsQpJJ8vaArB5XO509KoEXg9HWik75AakRGALsTMMR
         9fug==
X-Forwarded-Encrypted: i=1; AJvYcCVViAmXn5Wz6yAutbUQqxAecPwIAeBBkNXHVtBu2iwqvkOsh/tLwREp7VymX5YONjkV+HQAjjHh0kCq22rUfqXw7n/KxcNFy393j8rO
X-Gm-Message-State: AOJu0YzO777xcs6dUL8KD2PfFv6v77uAqgG9FOWVbAx+VcsumtnRBSZY
	2C+CNq2ruI8VicOJMADeP4dNJSEfos/hKTt+EhKJmlxjEKXy3L4o
X-Google-Smtp-Source: AGHT+IGd3eQ3elvTRjJLRy2OtZfHZAmmKqAw7Y+Ixh6aVlwD1cFyrqWl7mIT5eMk3LnO8WFZlwnOkA==
X-Received: by 2002:a05:600c:3592:b0:424:798a:f7ee with SMTP id 5b1f17b1804b1-4248cc18166mr121847805e9.7.1719585349608;
        Fri, 28 Jun 2024 07:35:49 -0700 (PDT)
Received: from lucifer.home ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256af37828sm38985485e9.9.2024.06.28.07.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:35:47 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [RFC PATCH v2 7/7] tools: add skeleton code for userland testing of VMA logic
Date: Fri, 28 Jun 2024 15:35:28 +0100
Message-ID: <73c7a094524bdb21e25d8c436c9059820ad82cb5.1719584707.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1719584707.git.lstoakes@gmail.com>
References: <cover.1719584707.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Establish a new userland VMA unit testing implementation under
tools/testing which utilises existing logic providing maple tree support in
userland utilising the now-shared code previously exclusive to radix tree
testing.

This provides fundamental VMA operations whose API is defined in mm/vma.h,
while stubbing out superfluous functionality.

This exists as a proof-of-concept, with the test implementation functional
and sufficient to allow userland compilation of vma.c, but containing only
cursory tests to demonstrate basic functionality.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 MAINTAINERS                            |   1 +
 include/linux/atomic.h                 |   2 +-
 include/linux/mmzone.h                 |   3 +-
 tools/testing/vma/.gitignore           |   6 +
 tools/testing/vma/Makefile             |  15 +
 tools/testing/vma/errors.txt           |   0
 tools/testing/vma/generated/autoconf.h |   2 +
 tools/testing/vma/linux/atomic.h       |  12 +
 tools/testing/vma/linux/mmzone.h       |  38 ++
 tools/testing/vma/vma.c                | 207 ++++++
 tools/testing/vma/vma_internal.h       | 882 +++++++++++++++++++++++++
 11 files changed, 1166 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/vma/.gitignore
 create mode 100644 tools/testing/vma/Makefile
 create mode 100644 tools/testing/vma/errors.txt
 create mode 100644 tools/testing/vma/generated/autoconf.h
 create mode 100644 tools/testing/vma/linux/atomic.h
 create mode 100644 tools/testing/vma/linux/mmzone.h
 create mode 100644 tools/testing/vma/vma.c
 create mode 100644 tools/testing/vma/vma_internal.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0847cb5903ab..410062bd8e21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23983,6 +23983,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	mm/vma.c
 F:	mm/vma.h
 F:	mm/vma_internal.h
+F:	tools/testing/vma
 
 VMALLOC
 M:	Andrew Morton <akpm@linux-foundation.org>
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8dd57c3a99e9..badfba2fd10f 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -81,4 +81,4 @@
 #include <linux/atomic/atomic-long.h>
 #include <linux/atomic/atomic-instrumented.h>
 
-#endif /* _LINUX_ATOMIC_H */
+#endif	/* _LINUX_ATOMIC_H */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 41458892bc8a..30a22e57fa50 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1,4 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
 #ifndef _LINUX_MMZONE_H
 #define _LINUX_MMZONE_H
 
diff --git a/tools/testing/vma/.gitignore b/tools/testing/vma/.gitignore
new file mode 100644
index 000000000000..d915f7d7fb1a
--- /dev/null
+++ b/tools/testing/vma/.gitignore
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+generated/bit-length.h
+generated/map-shift.h
+idr.c
+radix-tree.c
+vma
diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
new file mode 100644
index 000000000000..a12fb6596016
--- /dev/null
+++ b/tools/testing/vma/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+.PHONY: default
+
+default: vma
+
+include ../shared/shared.mk
+
+OFILES = vma.o $(SHARED_OFILES) maple-shim.o
+TARGETS = vma
+
+vma:	$(OFILES)
+
+clean:
+	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h
diff --git a/tools/testing/vma/errors.txt b/tools/testing/vma/errors.txt
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/vma/generated/autoconf.h b/tools/testing/vma/generated/autoconf.h
new file mode 100644
index 000000000000..92dc474c349b
--- /dev/null
+++ b/tools/testing/vma/generated/autoconf.h
@@ -0,0 +1,2 @@
+#include "bit-length.h"
+#define CONFIG_XARRAY_MULTI 1
diff --git a/tools/testing/vma/linux/atomic.h b/tools/testing/vma/linux/atomic.h
new file mode 100644
index 000000000000..e01f66f98982
--- /dev/null
+++ b/tools/testing/vma/linux/atomic.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _LINUX_ATOMIC_H
+#define _LINUX_ATOMIC_H
+
+#define atomic_t int32_t
+#define atomic_inc(x) uatomic_inc(x)
+#define atomic_read(x) uatomic_read(x)
+#define atomic_set(x, y) do {} while (0)
+#define U8_MAX UCHAR_MAX
+
+#endif	/* _LINUX_ATOMIC_H */
diff --git a/tools/testing/vma/linux/mmzone.h b/tools/testing/vma/linux/mmzone.h
new file mode 100644
index 000000000000..e6a96c686610
--- /dev/null
+++ b/tools/testing/vma/linux/mmzone.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_MMZONE_H
+#define _LINUX_MMZONE_H
+
+#include <linux/atomic.h>
+
+struct pglist_data *first_online_pgdat(void);
+struct pglist_data *next_online_pgdat(struct pglist_data *pgdat);
+
+#define for_each_online_pgdat(pgdat)			\
+	for (pgdat = first_online_pgdat();		\
+	     pgdat;					\
+	     pgdat = next_online_pgdat(pgdat))
+
+enum zone_type {
+	__MAX_NR_ZONES
+};
+
+#define MAX_NR_ZONES __MAX_NR_ZONES
+#define MAX_PAGE_ORDER 10
+#define MAX_ORDER_NR_PAGES (1 << MAX_PAGE_ORDER)
+
+#define pageblock_order		MAX_PAGE_ORDER
+#define pageblock_nr_pages	BIT(pageblock_order)
+#define pageblock_align(pfn)	ALIGN((pfn), pageblock_nr_pages)
+#define pageblock_start_pfn(pfn)	ALIGN_DOWN((pfn), pageblock_nr_pages)
+
+struct zone {
+	atomic_long_t		managed_pages;
+};
+
+typedef struct pglist_data {
+	struct zone node_zones[MAX_NR_ZONES];
+
+} pg_data_t;
+
+#endif /* _LINUX_MMZONE_H */
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
new file mode 100644
index 000000000000..ac7f917ab108
--- /dev/null
+++ b/tools/testing/vma/vma.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "maple-shared.h"
+#include "vma_internal.h"
+
+/*
+ * Directly import the VMA implementation here. Our vma_internal.h wrapper
+ * provides userland-equivalent functionality for everything vma.c uses.
+ */
+#include "../../../mm/vma.c"
+
+const struct vm_operations_struct vma_dummy_vm_ops;
+
+#define ASSERT_TRUE(_expr)						\
+	do {								\
+		if (!(_expr)) {						\
+			fprintf(stderr,					\
+				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
+				__FILE__, __LINE__, __FUNCTION__, #_expr); \
+			return false;					\
+		}							\
+	} while (0)
+#define ASSERT_FALSE(_expr) ASSERT_TRUE(!(_expr))
+#define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
+#define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
+
+static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
+					unsigned long start,
+					unsigned long end,
+					pgoff_t pgoff,
+					vm_flags_t flags)
+{
+	struct vm_area_struct *ret = vm_area_alloc(mm);
+
+	if (ret == NULL)
+		return NULL;
+
+	ret->vm_start = start;
+	ret->vm_end = end;
+	ret->vm_pgoff = pgoff;
+	ret->__vm_flags = flags;
+
+	return ret;
+}
+
+static bool test_simple_merge(void)
+{
+	struct vm_area_struct *vma;
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	struct vm_area_struct *vma_left = alloc_vma(&mm, 0, 0x1000, 0, flags);
+	struct vm_area_struct *vma_middle = alloc_vma(&mm, 0x1000, 0x2000, 1, flags);
+	struct vm_area_struct *vma_right = alloc_vma(&mm, 0x2000, 0x3000, 2, flags);
+	VMA_ITERATOR(vmi, &mm, 0x1000);
+
+	ASSERT_FALSE(vma_link(&mm, vma_left));
+	ASSERT_FALSE(vma_link(&mm, vma_middle));
+	ASSERT_FALSE(vma_link(&mm, vma_right));
+
+	vma = vma_merge_new_vma(&vmi, vma_left, vma_middle, 0x1000,
+				0x2000, 1);
+	ASSERT_NE(vma, NULL);
+
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x3000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+	ASSERT_EQ(vma->vm_flags, flags);
+
+	vm_area_free(vma);
+	mtree_destroy(&mm.mm_mt);
+
+	return true;
+}
+
+static bool test_simple_modify(void)
+{
+	struct vm_area_struct *vma;
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	struct vm_area_struct *init_vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
+	VMA_ITERATOR(vmi, &mm, 0x1000);
+
+	ASSERT_FALSE(vma_link(&mm, init_vma));
+
+	/*
+	 * The flags will not be changed, the vma_modify_flags() function
+	 * performs the merge/split only.
+	 */
+	vma = vma_modify_flags(&vmi, NULL, init_vma,
+			       0x1000, 0x2000, VM_READ | VM_MAYREAD);
+	ASSERT_NE(vma, NULL);
+	/* We modify the provided VMA, and on split allocate new VMAs. */
+	ASSERT_EQ(vma, init_vma);
+
+	ASSERT_EQ(vma->vm_start, 0x1000);
+	ASSERT_EQ(vma->vm_end, 0x2000);
+	ASSERT_EQ(vma->vm_pgoff, 1);
+
+	/*
+	 * Now walk through the three split VMAs and make sure they are as
+	 * expected.
+	 */
+
+	vma_iter_set(&vmi, 0);
+	vma = vma_iter_load(&vmi);
+
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x1000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+
+	vm_area_free(vma);
+	vma_iter_clear(&vmi);
+
+	vma = vma_next(&vmi);
+
+	ASSERT_EQ(vma->vm_start, 0x1000);
+	ASSERT_EQ(vma->vm_end, 0x2000);
+	ASSERT_EQ(vma->vm_pgoff, 1);
+
+	vm_area_free(vma);
+	vma_iter_clear(&vmi);
+
+	vma = vma_next(&vmi);
+
+	ASSERT_EQ(vma->vm_start, 0x2000);
+	ASSERT_EQ(vma->vm_end, 0x3000);
+	ASSERT_EQ(vma->vm_pgoff, 2);
+
+	vm_area_free(vma);
+	mtree_destroy(&mm.mm_mt);
+
+	return true;
+}
+
+static bool test_simple_expand(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x1000, 0, flags);
+	VMA_ITERATOR(vmi, &mm, 0);
+
+	ASSERT_FALSE(vma_link(&mm, vma));
+
+	ASSERT_FALSE(vma_expand(&vmi, vma, 0, 0x3000, 0, NULL));
+
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x3000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+
+	vm_area_free(vma);
+	mtree_destroy(&mm.mm_mt);
+
+	return true;
+}
+
+static bool test_simple_shrink(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
+	VMA_ITERATOR(vmi, &mm, 0);
+
+	ASSERT_FALSE(vma_link(&mm, vma));
+
+	ASSERT_FALSE(vma_shrink(&vmi, vma, 0, 0x1000, 0));
+
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x1000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+
+	vm_area_free(vma);
+	mtree_destroy(&mm.mm_mt);
+
+	return true;
+}
+
+int main(void)
+{
+	int num_tests = 0, num_fail = 0;
+
+	maple_tree_init();
+
+#define TEST(name)							\
+	do {								\
+		num_tests++;						\
+		if (!test_##name()) {					\
+			num_fail++;					\
+			fprintf(stderr, "Test " #name " FAILED\n");	\
+		}							\
+	} while (0)
+
+	TEST(simple_merge);
+	TEST(simple_modify);
+	TEST(simple_expand);
+	TEST(simple_shrink);
+
+#undef TEST
+
+	printf("%d tests run, %d passed, %d failed.\n",
+	       num_tests, num_tests - num_fail, num_fail);
+
+	return EXIT_SUCCESS;
+}
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
new file mode 100644
index 000000000000..093560e5b2ac
--- /dev/null
+++ b/tools/testing/vma/vma_internal.h
@@ -0,0 +1,882 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * vma_internal.h
+ *
+ * Header providing userland wrappers and shims for the functionality provided
+ * by mm/vma_internal.h.
+ *
+ * We make the header guard the same as mm/vma_internal.h, so if this shim
+ * header is included, it precludes the inclusion of the kernel one.
+ */
+
+#ifndef __MM_VMA_INTERNAL_H
+#define __MM_VMA_INTERNAL_H
+
+#define __private
+#define __bitwise
+#define __randomize_layout
+
+#define CONFIG_MMU
+#define CONFIG_PER_VMA_LOCK
+
+#include <stdlib.h>
+
+#include <linux/list.h>
+#include <linux/maple_tree.h>
+#include <linux/mm.h>
+#include <linux/rbtree.h>
+#include <linux/rwsem.h>
+
+#define VM_WARN_ON(_expr) (WARN_ON(_expr))
+#define VM_WARN_ON_ONCE(_expr) (WARN_ON_ONCE(_expr))
+#define VM_BUG_ON(_expr) (BUG_ON(_expr))
+#define VM_BUG_ON_VMA(_expr, _vma) (BUG_ON(_expr))
+
+#define VM_NONE		0x00000000
+#define VM_READ		0x00000001
+#define VM_WRITE	0x00000002
+#define VM_EXEC		0x00000004
+#define VM_SHARED	0x00000008
+#define VM_MAYREAD	0x00000010
+#define VM_MAYWRITE	0x00000020
+#define VM_GROWSDOWN	0x00000100
+#define VM_PFNMAP	0x00000400
+#define VM_LOCKED	0x00002000
+#define VM_IO           0x00004000
+#define VM_DONTEXPAND	0x00040000
+#define VM_ACCOUNT	0x00100000
+#define VM_MIXEDMAP	0x10000000
+#define VM_STACK	VM_GROWSDOWN
+#define VM_SHADOW_STACK	VM_NONE
+#define VM_SOFTDIRTY	0
+
+#define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
+#define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
+
+#define FIRST_USER_ADDRESS	0UL
+#define USER_PGTABLES_CEILING	0UL
+
+#define vma_policy(vma) NULL
+
+#define down_write_nest_lock(sem, nest_lock)
+
+#define pgprot_val(x)		((x).pgprot)
+#define __pgprot(x)		((pgprot_t) { (x) } )
+
+#define for_each_vma(__vmi, __vma)					\
+	while (((__vma) = vma_next(&(__vmi))) != NULL)
+
+/* The MM code likes to work with exclusive end addresses */
+#define for_each_vma_range(__vmi, __vma, __end)				\
+	while (((__vma) = vma_find(&(__vmi), (__end))) != NULL)
+
+#define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
+
+#define PHYS_PFN(x)	((unsigned long)((x) >> PAGE_SHIFT))
+
+#define test_and_set_bit(nr, addr) __test_and_set_bit(nr, addr)
+#define test_and_clear_bit(nr, addr) __test_and_clear_bit(nr, addr)
+
+#define TASK_SIZE ((1ul << 47)-PAGE_SIZE)
+
+#define AS_MM_ALL_LOCKS 2
+
+#define current NULL
+
+/* We hardcode this for now. */
+#define sysctl_max_map_count 0x1000000UL
+
+#define pgoff_t unsigned long
+typedef unsigned long	pgprotval_t;
+typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
+typedef unsigned long vm_flags_t;
+typedef __bitwise unsigned int vm_fault_t;
+
+typedef struct refcount_struct {
+	atomic_t refs;
+} refcount_t;
+
+struct kref {
+	refcount_t refcount;
+};
+
+struct anon_vma {
+	struct anon_vma *root;
+	struct rb_root_cached rb_root;
+};
+
+struct anon_vma_chain {
+	struct anon_vma *anon_vma;
+	struct list_head same_vma;
+};
+
+struct anon_vma_name {
+	struct kref kref;
+	/* The name needs to be at the end because it is dynamically sized. */
+	char name[];
+};
+
+struct vma_iterator {
+	struct ma_state mas;
+};
+
+#define VMA_ITERATOR(name, __mm, __addr)				\
+	struct vma_iterator name = {					\
+		.mas = {						\
+			.tree = &(__mm)->mm_mt,				\
+			.index = __addr,				\
+			.node = NULL,					\
+			.status = ma_start,				\
+		},							\
+	}
+
+struct address_space {
+	struct rb_root_cached	i_mmap;
+	unsigned long		flags;
+	atomic_t		i_mmap_writable;
+};
+
+struct vm_userfaultfd_ctx {};
+struct mempolicy {};
+struct mmu_gather {};
+struct mutex {};
+#define DEFINE_MUTEX(mutexname) \
+	struct mutex mutexname = {}
+
+struct mm_struct {
+	struct maple_tree mm_mt;
+	int map_count;			/* number of VMAs */
+	unsigned long total_vm;	   /* Total pages mapped */
+	unsigned long locked_vm;   /* Pages that have PG_mlocked set */
+	unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
+	unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
+	unsigned long stack_vm;	   /* VM_STACK */
+};
+
+struct vma_lock {
+	struct rw_semaphore lock;
+};
+
+
+struct file {
+	struct address_space	*f_mapping;
+};
+
+struct vm_area_struct {
+	/* The first cache line has the info for VMA tree walking. */
+
+	union {
+		struct {
+			/* VMA covers [vm_start; vm_end) addresses within mm */
+			unsigned long vm_start;
+			unsigned long vm_end;
+		};
+#ifdef CONFIG_PER_VMA_LOCK
+		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
+#endif
+	};
+
+	struct mm_struct *vm_mm;	/* The address space we belong to. */
+	pgprot_t vm_page_prot;          /* Access permissions of this VMA. */
+
+	/*
+	 * Flags, see mm.h.
+	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
+	 */
+	union {
+		const vm_flags_t vm_flags;
+		vm_flags_t __private __vm_flags;
+	};
+
+#ifdef CONFIG_PER_VMA_LOCK
+	/* Flag to indicate areas detached from the mm->mm_mt tree */
+	bool detached;
+
+	/*
+	 * Can only be written (using WRITE_ONCE()) while holding both:
+	 *  - mmap_lock (in write mode)
+	 *  - vm_lock->lock (in write mode)
+	 * Can be read reliably while holding one of:
+	 *  - mmap_lock (in read or write mode)
+	 *  - vm_lock->lock (in read or write mode)
+	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
+	 * while holding nothing (except RCU to keep the VMA struct allocated).
+	 *
+	 * This sequence counter is explicitly allowed to overflow; sequence
+	 * counter reuse can only lead to occasional unnecessary use of the
+	 * slowpath.
+	 */
+	int vm_lock_seq;
+	struct vma_lock *vm_lock;
+#endif
+
+	/*
+	 * For areas with an address space and backing store,
+	 * linkage into the address_space->i_mmap interval tree.
+	 *
+	 */
+	struct {
+		struct rb_node rb;
+		unsigned long rb_subtree_last;
+	} shared;
+
+	/*
+	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
+	 * list, after a COW of one of the file pages.	A MAP_SHARED vma
+	 * can only be in the i_mmap tree.  An anonymous MAP_PRIVATE, stack
+	 * or brk vma (with NULL file) can only be in an anon_vma list.
+	 */
+	struct list_head anon_vma_chain; /* Serialized by mmap_lock &
+					  * page_table_lock */
+	struct anon_vma *anon_vma;	/* Serialized by page_table_lock */
+
+	/* Function pointers to deal with this struct. */
+	const struct vm_operations_struct *vm_ops;
+
+	/* Information about our backing store: */
+	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
+					   units */
+	struct file * vm_file;		/* File we map to (can be NULL). */
+	void * vm_private_data;		/* was vm_pte (shared mem) */
+
+#ifdef CONFIG_ANON_VMA_NAME
+	/*
+	 * For private and shared anonymous mappings, a pointer to a null
+	 * terminated string containing the name given to the vma, or NULL if
+	 * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
+	 */
+	struct anon_vma_name *anon_name;
+#endif
+#ifdef CONFIG_SWAP
+	atomic_long_t swap_readahead_info;
+#endif
+#ifndef CONFIG_MMU
+	struct vm_region *vm_region;	/* NOMMU mapping region */
+#endif
+#ifdef CONFIG_NUMA
+	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
+#endif
+	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+} __randomize_layout;
+
+struct vm_fault {};
+
+struct vm_operations_struct {
+	void (*open)(struct vm_area_struct * area);
+	/**
+	 * @close: Called when the VMA is being removed from the MM.
+	 * Context: User context.  May sleep.  Caller holds mmap_lock.
+	 */
+	void (*close)(struct vm_area_struct * area);
+	/* Called any time before splitting to check if it's allowed */
+	int (*may_split)(struct vm_area_struct *area, unsigned long addr);
+	int (*mremap)(struct vm_area_struct *area);
+	/*
+	 * Called by mprotect() to make driver-specific permission
+	 * checks before mprotect() is finalised.   The VMA must not
+	 * be modified.  Returns 0 if mprotect() can proceed.
+	 */
+	int (*mprotect)(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, unsigned long newflags);
+	vm_fault_t (*fault)(struct vm_fault *vmf);
+	vm_fault_t (*huge_fault)(struct vm_fault *vmf, unsigned int order);
+	vm_fault_t (*map_pages)(struct vm_fault *vmf,
+			pgoff_t start_pgoff, pgoff_t end_pgoff);
+	unsigned long (*pagesize)(struct vm_area_struct * area);
+
+	/* notification that a previously read-only page is about to become
+	 * writable, if an error is returned it will cause a SIGBUS */
+	vm_fault_t (*page_mkwrite)(struct vm_fault *vmf);
+
+	/* same as page_mkwrite when using VM_PFNMAP|VM_MIXEDMAP */
+	vm_fault_t (*pfn_mkwrite)(struct vm_fault *vmf);
+
+	/* called by access_process_vm when get_user_pages() fails, typically
+	 * for use by special VMAs. See also generic_access_phys() for a generic
+	 * implementation useful for any iomem mapping.
+	 */
+	int (*access)(struct vm_area_struct *vma, unsigned long addr,
+		      void *buf, int len, int write);
+
+	/* Called by the /proc/PID/maps code to ask the vma whether it
+	 * has a special name.  Returning non-NULL will also cause this
+	 * vma to be dumped unconditionally. */
+	const char *(*name)(struct vm_area_struct *vma);
+
+#ifdef CONFIG_NUMA
+	/*
+	 * set_policy() op must add a reference to any non-NULL @new mempolicy
+	 * to hold the policy upon return.  Caller should pass NULL @new to
+	 * remove a policy and fall back to surrounding context--i.e. do not
+	 * install a MPOL_DEFAULT policy, nor the task or system default
+	 * mempolicy.
+	 */
+	int (*set_policy)(struct vm_area_struct *vma, struct mempolicy *new);
+
+	/*
+	 * get_policy() op must add reference [mpol_get()] to any policy at
+	 * (vma,addr) marked as MPOL_SHARED.  The shared policy infrastructure
+	 * in mm/mempolicy.c will do this automatically.
+	 * get_policy() must NOT add a ref if the policy at (vma,addr) is not
+	 * marked as MPOL_SHARED. vma policies are protected by the mmap_lock.
+	 * If no [shared/vma] mempolicy exists at the addr, get_policy() op
+	 * must return NULL--i.e., do not "fallback" to task or system default
+	 * policy.
+	 */
+	struct mempolicy *(*get_policy)(struct vm_area_struct *vma,
+					unsigned long addr, pgoff_t *ilx);
+#endif
+	/*
+	 * Called by vm_normal_page() for special PTEs to find the
+	 * page for @addr.  This is useful if the default behavior
+	 * (using pte_page()) would not find the correct page.
+	 */
+	struct page *(*find_special_page)(struct vm_area_struct *vma,
+					  unsigned long addr);
+};
+
+static inline void vma_iter_invalidate(struct vma_iterator *vmi)
+{
+	mas_pause(&vmi->mas);
+}
+
+static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
+{
+	return __pgprot(pgprot_val(oldprot) | pgprot_val(newprot));
+}
+
+static inline pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	return __pgprot(vm_flags);
+}
+
+static inline bool is_shared_maywrite(vm_flags_t vm_flags)
+{
+	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
+		(VM_SHARED | VM_MAYWRITE);
+}
+
+static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
+{
+	return is_shared_maywrite(vma->vm_flags);
+}
+
+static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
+{
+	/*
+	 * Uses mas_find() to get the first VMA when the iterator starts.
+	 * Calling mas_next() could skip the first entry.
+	 */
+	return mas_find(&vmi->mas, ULONG_MAX);
+}
+
+static inline bool vma_lock_alloc(struct vm_area_struct *vma)
+{
+	vma->vm_lock = calloc(1, sizeof(struct vma_lock));
+
+	if (!vma->vm_lock)
+		return false;
+
+	init_rwsem(&vma->vm_lock->lock);
+	vma->vm_lock_seq = -1;
+
+	return true;
+}
+
+static inline void vma_assert_write_locked(struct vm_area_struct *);
+static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
+{
+	/* When detaching vma should be write-locked */
+	if (detached)
+		vma_assert_write_locked(vma);
+	vma->detached = detached;
+}
+
+extern const struct vm_operations_struct vma_dummy_vm_ops;
+
+static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
+{
+	memset(vma, 0, sizeof(*vma));
+	vma->vm_mm = mm;
+	vma->vm_ops = &vma_dummy_vm_ops;
+	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	vma_mark_detached(vma, false);
+}
+
+static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma = calloc(1, sizeof(struct vm_area_struct));
+
+	if (!vma)
+		return NULL;
+
+	vma_init(vma, mm);
+	if (!vma_lock_alloc(vma)) {
+		free(vma);
+		return NULL;
+	}
+
+	return vma;
+}
+
+static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
+{
+	struct vm_area_struct *new = calloc(1, sizeof(struct vm_area_struct));
+
+	if (!new)
+		return NULL;
+
+	memcpy(new, orig, sizeof(*new));
+	if (!vma_lock_alloc(new)) {
+		free(new);
+		return NULL;
+	}
+	INIT_LIST_HEAD(&new->anon_vma_chain);
+
+	return new;
+}
+
+/*
+ * These are defined in vma.h, but sadly vm_stat_account() is referenced by
+ * kernel/fork.c, so we have to these broadly available there, and temporarily
+ * define them here to resolve the dependency cycle.
+ */
+
+#define is_exec_mapping(flags) \
+	((flags & (VM_EXEC | VM_WRITE | VM_STACK)) == VM_EXEC)
+
+#define is_stack_mapping(flags) \
+	(((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK))
+
+#define is_data_mapping(flags) \
+	((flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE)
+
+static inline void vm_stat_account(struct mm_struct *mm, vm_flags_t flags,
+				   long npages)
+{
+	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm)+npages);
+
+	if (is_exec_mapping(flags))
+		mm->exec_vm += npages;
+	else if (is_stack_mapping(flags))
+		mm->stack_vm += npages;
+	else if (is_data_mapping(flags))
+		mm->data_vm += npages;
+}
+
+#undef is_exec_mapping
+#undef is_stack_mapping
+#undef is_data_mapping
+
+/* Currently stubbed but we may later wish to un-stub. */
+static inline void vm_acct_memory(long pages);
+static inline void vm_unacct_memory(long pages)
+{
+	vm_acct_memory(-pages);
+}
+
+static inline void mapping_allow_writable(struct address_space *mapping)
+{
+	atomic_inc(&mapping->i_mmap_writable);
+}
+
+static inline void vma_set_range(struct vm_area_struct *vma,
+				 unsigned long start, unsigned long end,
+				 pgoff_t pgoff)
+{
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+}
+
+static inline
+struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
+{
+	return mas_find(&vmi->mas, max - 1);
+}
+
+static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
+			unsigned long start, unsigned long end, gfp_t gfp)
+{
+	__mas_set_range(&vmi->mas, start, end - 1);
+	mas_store_gfp(&vmi->mas, NULL, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void mmap_assert_locked(struct mm_struct *);
+static inline struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+						unsigned long start_addr,
+						unsigned long end_addr)
+{
+	unsigned long index = start_addr;
+
+	mmap_assert_locked(mm);
+	return mt_find(&mm->mm_mt, &index, end_addr - 1);
+}
+
+static inline
+struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
+{
+	return mtree_load(&mm->mm_mt, addr);
+}
+
+static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
+{
+	return mas_prev(&vmi->mas, 0);
+}
+
+static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
+{
+	mas_set(&vmi->mas, addr);
+}
+
+static inline bool vma_is_anonymous(struct vm_area_struct *vma)
+{
+	return !vma->vm_ops;
+}
+
+/* Defined in vma.h, so temporarily define here to avoid circular dependency. */
+#define vma_iter_load(vmi) \
+	mas_walk(&(vmi)->mas)
+
+static inline struct vm_area_struct *
+find_vma_prev(struct mm_struct *mm, unsigned long addr,
+			struct vm_area_struct **pprev)
+{
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, addr);
+
+	vma = vma_iter_load(&vmi);
+	*pprev = vma_prev(&vmi);
+	if (!vma)
+		vma = vma_next(&vmi);
+	return vma;
+}
+
+#undef vma_iter_load
+
+static inline void vma_iter_init(struct vma_iterator *vmi,
+		struct mm_struct *mm, unsigned long addr)
+{
+	mas_init(&vmi->mas, &mm->mm_mt, addr);
+}
+
+/* Stubbed functions. */
+
+static inline struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
+static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
+					struct vm_userfaultfd_ctx vm_ctx)
+{
+	return true;
+}
+
+static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
+				    struct anon_vma_name *anon_name2)
+{
+	return true;
+}
+
+static inline void might_sleep(void)
+{
+}
+
+static inline unsigned long vma_pages(struct vm_area_struct *vma)
+{
+	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+}
+
+static inline void fput(struct file *)
+{
+}
+
+static inline void mpol_put(struct mempolicy *)
+{
+}
+
+static inline void vma_lock_free(struct vm_area_struct *vma)
+{
+	free(vma->vm_lock);
+}
+
+static inline void __vm_area_free(struct vm_area_struct *vma)
+{
+	vma_lock_free(vma);
+	free(vma);
+}
+
+static inline void vm_area_free(struct vm_area_struct *vma)
+{
+	__vm_area_free(vma);
+}
+
+static inline void lru_add_drain(void)
+{
+}
+
+static inline void tlb_gather_mmu(struct mmu_gather *, struct mm_struct *)
+{
+}
+
+static inline void update_hiwater_rss(struct mm_struct *)
+{
+}
+
+static inline void update_hiwater_vm(struct mm_struct *)
+{
+}
+
+static inline void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
+		      struct vm_area_struct *vma, unsigned long start_addr,
+		      unsigned long end_addr, unsigned long tree_end,
+		      bool mm_wr_locked)
+{
+	(void)tlb;
+	(void)mas;
+	(void)vma;
+	(void)start_addr;
+	(void)end_addr;
+	(void)tree_end;
+	(void)mm_wr_locked;
+}
+
+static inline void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
+		   struct vm_area_struct *vma, unsigned long floor,
+		   unsigned long ceiling, bool mm_wr_locked)
+{
+	(void)tlb;
+	(void)mas;
+	(void)vma;
+	(void)floor;
+	(void)ceiling;
+	(void)mm_wr_locked;
+}
+
+static inline void mapping_unmap_writable(struct address_space *)
+{
+}
+
+static inline void flush_dcache_mmap_lock(struct address_space *)
+{
+}
+
+static inline void tlb_finish_mmu(struct mmu_gather *)
+{
+}
+
+static inline void get_file(struct file *)
+{
+}
+
+static inline int vma_dup_policy(struct vm_area_struct *, struct vm_area_struct *)
+{
+	return 0;
+}
+
+static inline int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct *)
+{
+	return 0;
+}
+
+static inline void vma_start_write(struct vm_area_struct *)
+{
+}
+
+static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
+					 unsigned long start,
+					 unsigned long end,
+					 long adjust_next)
+{
+	(void)vma;
+	(void)start;
+	(void)end;
+	(void)adjust_next;
+}
+
+static inline void vma_iter_free(struct vma_iterator *vmi)
+{
+	mas_destroy(&vmi->mas);
+}
+
+static inline void vm_acct_memory(long pages)
+{
+}
+
+static inline void vma_interval_tree_insert(struct vm_area_struct *,
+					    struct rb_root_cached *)
+{
+}
+
+static inline void vma_interval_tree_remove(struct vm_area_struct *,
+					    struct rb_root_cached *)
+{
+}
+
+static inline void flush_dcache_mmap_unlock(struct address_space *)
+{
+}
+
+static inline void anon_vma_interval_tree_insert(struct anon_vma_chain*,
+						 struct rb_root_cached *)
+{
+}
+
+static inline void anon_vma_interval_tree_remove(struct anon_vma_chain*,
+						 struct rb_root_cached *)
+{
+}
+
+static inline void uprobe_mmap(struct vm_area_struct *)
+{
+}
+
+static inline void uprobe_munmap(struct vm_area_struct *vma,
+				 unsigned long start, unsigned long end)
+{
+	(void)vma;
+	(void)start;
+	(void)end;
+}
+
+static inline void i_mmap_lock_write(struct address_space *)
+{
+}
+
+static inline void anon_vma_lock_write(struct anon_vma *)
+{
+}
+
+static inline void vma_assert_write_locked(struct vm_area_struct *)
+{
+}
+
+static inline void unlink_anon_vmas(struct vm_area_struct *)
+{
+}
+
+static inline void anon_vma_unlock_write(struct anon_vma *)
+{
+}
+
+static inline void i_mmap_unlock_write(struct address_space *)
+{
+}
+
+static inline void anon_vma_merge(struct vm_area_struct *,
+				  struct vm_area_struct *)
+{
+}
+
+static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
+					 unsigned long start,
+					 unsigned long end,
+					 struct list_head *unmaps)
+{
+	(void)vma;
+	(void)start;
+	(void)end;
+	(void)unmaps;
+
+	return 0;
+}
+
+static inline void mmap_write_downgrade(struct mm_struct *)
+{
+}
+
+static inline void mmap_read_unlock(struct mm_struct *)
+{
+}
+
+static inline void mmap_write_unlock(struct mm_struct *)
+{
+}
+
+static inline bool can_modify_mm(struct mm_struct *mm,
+				 unsigned long start,
+				 unsigned long end)
+{
+	(void)mm;
+	(void)start;
+	(void)end;
+
+	return true;
+}
+
+static inline void arch_unmap(struct mm_struct *mm,
+				 unsigned long start,
+				 unsigned long end)
+{
+	(void)mm;
+	(void)start;
+	(void)end;
+}
+
+static inline void mmap_assert_locked(struct mm_struct *)
+{
+}
+
+static inline bool mpol_equal(struct mempolicy *, struct mempolicy *)
+{
+	return true;
+}
+
+static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
+			  unsigned long vm_flags)
+{
+	(void)vma;
+	(void)vm_flags;
+}
+
+static inline bool mapping_can_writeback(struct address_space *)
+{
+	return true;
+}
+
+static inline bool is_vm_hugetlb_page(struct vm_area_struct *)
+{
+	return false;
+}
+
+static inline bool vma_soft_dirty_enabled(struct vm_area_struct *)
+{
+	return false;
+}
+
+static inline bool userfaultfd_wp(struct vm_area_struct *)
+{
+	return false;
+}
+
+static inline void mmap_assert_write_locked(struct mm_struct *)
+{
+}
+
+static inline void mutex_lock(struct mutex *)
+{
+}
+
+static inline void mutex_unlock(struct mutex *)
+{
+}
+
+static inline bool mutex_is_locked(struct mutex *)
+{
+	return true;
+}
+
+static inline bool signal_pending(void *)
+{
+	return false;
+}
+
+#endif	/* __MM_VMA_INTERNAL_H */
-- 
2.45.1


