Return-Path: <linux-fsdevel+bounces-22449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C19917333
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 23:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102AE286FA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 21:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9671F17F4E3;
	Tue, 25 Jun 2024 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lagVaS03"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E989176AAF;
	Tue, 25 Jun 2024 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350293; cv=none; b=EPPValsNzz8UNx5UNqyiYy18swANRopNgnx2apRvIZ+oIXBV2uFMxN+uB9cYxUjNeV2NoISn8K82KuU0KJTq8TjcOO07D7BqxIc+8+5KUS7yvVDxVmsW4bbCor6YVOb8dvs+AaablVb5TYwD3KMdw3StXdJzGYD4okcUiwfCn1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350293; c=relaxed/simple;
	bh=z22rC2d+tdG992WQD+/IlVFv4wF2WVaOL0fVpFvwpBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vb0mr09c88NSaopy15pZ175fkM5gm/1yltzgGoB9Cq8D0RArm3VyRLZu4COk2VOYn9UbbrUTIs9HSazI3IXfLPgpg2/dOWzGbi7jYNXfUuR0iCURsdY4GI4PDc0ErXeZ6siLnj+Uedj9Tiwz60LzuKTt01X4AYFqVTsDslLszJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lagVaS03; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xaYHyg9fqZq3nYOQo5wO57AGN36TvtPlQVk14puk+DA=; b=lagVaS03mlmoCwvSrG6D+LUG2+
	Fi55kw6uylROLhR/b3asWKar4z1DVfPI8Zx6eDePs065Aw2GJbU27/jXON88nl8ly2UFNzFMdyhq6
	xTFAmVMHRX1eaXc7E6kr82Ajx4DFJnY3CJ7ihI9Pd0OhdowQEbi2q1kpQdaKWFIlTnN4CHIHEDDzL
	Se0Kh1j4fHy1a0QowgVfVWo9xFpFIqCzZR98LoKFyACcY7CrqGQwia1FtNalh4ZAIDFryr/Ei058o
	N/EIBYRHlOp4HycUSP75Jl20rW784nZ/HnkbYkyFPBbZYUE95akF2oceXMqy8WKuLf/cPCotiHCkR
	bMQscKvA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMDYG-0000000BXYc-1UQV;
	Tue, 25 Jun 2024 21:18:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: [PATCH v2 4/5] tools: Add support for running rosebush tests in userspace
Date: Tue, 25 Jun 2024 22:17:59 +0100
Message-ID: <20240625211803.2750563-5-willy@infradead.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240625211803.2750563-1-willy@infradead.org>
References: <20240625211803.2750563-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable make -C tools/testing/radix-tree.  Much easier to debug than
an in-kernel module.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/include/linux/rosebush.h        |  1 +
 tools/testing/radix-tree/.gitignore   |  1 +
 tools/testing/radix-tree/Makefile     |  6 ++++-
 tools/testing/radix-tree/kunit/test.h | 20 +++++++++++++++
 tools/testing/radix-tree/rosebush.c   | 36 +++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 tools/include/linux/rosebush.h
 create mode 100644 tools/testing/radix-tree/kunit/test.h
 create mode 100644 tools/testing/radix-tree/rosebush.c

diff --git a/tools/include/linux/rosebush.h b/tools/include/linux/rosebush.h
new file mode 100644
index 000000000000..3f12f4288250
--- /dev/null
+++ b/tools/include/linux/rosebush.h
@@ -0,0 +1 @@
+#include "../../../include/linux/rosebush.h"
diff --git a/tools/testing/radix-tree/.gitignore b/tools/testing/radix-tree/.gitignore
index 49bccb90c35b..fb154f26bdab 100644
--- a/tools/testing/radix-tree/.gitignore
+++ b/tools/testing/radix-tree/.gitignore
@@ -9,3 +9,4 @@ radix-tree.c
 xarray
 maple
 ma_xa_benchmark
+rosebush
diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index 7527f738b4a1..982ff4b7fdeb 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -4,7 +4,7 @@ CFLAGS += -I. -I../../include -I../../../lib -g -Og -Wall \
 	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
 LDFLAGS += -fsanitize=address -fsanitize=undefined
 LDLIBS+= -lpthread -lurcu
-TARGETS = main idr-test multiorder xarray maple
+TARGETS = main idr-test multiorder xarray maple rosebush
 CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o \
 			 slab.o maple.o
 OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
@@ -36,6 +36,8 @@ xarray: $(CORE_OFILES)
 
 maple: $(CORE_OFILES)
 
+rosebush: $(CORE_OFILES)
+
 multiorder: multiorder.o $(CORE_OFILES)
 
 clean:
@@ -62,6 +64,8 @@ xarray.o: ../../../lib/xarray.c ../../../lib/test_xarray.c
 
 maple.o: ../../../lib/maple_tree.c ../../../lib/test_maple_tree.c
 
+rosebush.o: ../../../lib/rosebush.c ../../../lib/test_rosebush.c
+
 generated/map-shift.h:
 	@if ! grep -qws $(SHIFT) generated/map-shift.h; then		\
 		echo "#define XA_CHUNK_SHIFT $(SHIFT)" >		\
diff --git a/tools/testing/radix-tree/kunit/test.h b/tools/testing/radix-tree/kunit/test.h
new file mode 100644
index 000000000000..0805e3695762
--- /dev/null
+++ b/tools/testing/radix-tree/kunit/test.h
@@ -0,0 +1,20 @@
+struct kunit {
+};
+
+struct kunit_case {
+	void (*run_case)(struct kunit *test);
+};
+
+struct kunit_suite {
+	char *name;
+	struct kunit_case *test_cases;
+};
+
+#define KUNIT_CASE(test_name) { .run_case = test_name, }
+#define kunit_test_suite(x)
+
+#define KUNIT_EXPECT_EQ(test, left, right)				\
+	KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, NULL)
+#define KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, fmt, ...)		\
+	assert(left == right)
+
diff --git a/tools/testing/radix-tree/rosebush.c b/tools/testing/radix-tree/rosebush.c
new file mode 100644
index 000000000000..51703737833e
--- /dev/null
+++ b/tools/testing/radix-tree/rosebush.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * rosebush.c: Userspace testing for rosebush test-suite
+ * Copyright (c) 2024 Oracle Corporation
+ * Author: Matthew Wilcox <willy@infradead.org>
+ */
+
+#include "test.h"
+#include <stdlib.h>
+#include <time.h>
+
+#define module_init(x)
+#define module_exit(x)
+#define MODULE_AUTHOR(x)
+#define MODULE_LICENSE(x)
+#define dump_stack()	assert(0)
+
+#include "../../../lib/rosebush.c"
+#include "../../../lib/test_rosebush.c"
+
+int __weak main(void)
+{
+	struct kunit test;
+	int i;
+
+	assert(rosebush_suite.test_cases == rosebush_cases);
+
+	for (i = 0; i < ARRAY_SIZE(rosebush_cases); i++) {
+		if (!rosebush_cases[i].run_case)
+			continue;
+		printf("i = %d %p\n", i, rosebush_cases[i].run_case);
+		rosebush_cases[i].run_case(&test);
+	}
+
+	return 0;
+}
-- 
2.43.0


