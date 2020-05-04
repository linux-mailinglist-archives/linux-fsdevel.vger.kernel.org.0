Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EACA1C37A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 13:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgEDLEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 07:04:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35495 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728599AbgEDLEF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 07:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588590240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGTNvTFWRk5PNhFeR+pDoIIHcLadrpmg+OUkZLe0AM0=;
        b=Q+m3qN0cg4oHFrBiH0PYcNqpESfRpGpqSbVCgbuYYu8PY70KH281FXntvMfBXhkAsb/v5c
        IyI82cDtYAz5BYVVx0zsFLoqkx6zAA0WCQi81TBoyPjFpCdAsfNrSBYWOYdINrQ1WFChTz
        XQJcFXWwSbchl2Hii9xgW+qCvVihu3s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82--ErBm0VoOUCUIwgdleOqDA-1; Mon, 04 May 2020 07:03:59 -0400
X-MC-Unique: -ErBm0VoOUCUIwgdleOqDA-1
Received: by mail-wm1-f71.google.com with SMTP id s12so4677466wmj.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 04:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HGTNvTFWRk5PNhFeR+pDoIIHcLadrpmg+OUkZLe0AM0=;
        b=QJ1YYv9pQJTkMY5477M2GxoHiqBCcwzJqepcwGeUOS9rJbaG4S4meekvA+mrCyn8Cb
         xjwH31NoKT9MPYK57lfmfnideHbzlM1cccXM+DqVe4RkGRnlJdIMMkHWVBZH7l+wPKpX
         2TXmXuGgwgn1KSdj7fhyyi8T5pFXceakjRwaZbIJCr1RHuoM3Utv//q3x/KZ0DOxOSGK
         x99DMYvQKDh2TE2xOoJ8IW7kdIvn9Rup6/uV7+ewIpEUOtfptMFH+zYtMlj0iK/Xjlos
         WZiDXXwmX2p3CtqG/baN6LnXIfaLLY/dhxSFZEUAAdPlmBrx+yLvZZrOfkLUp+TMRDes
         EURA==
X-Gm-Message-State: AGi0Pua3kHbYFg0dezhPI8Rjw7OzFQWrsMUEJe4ThpcJF6Tx0WaJKw6v
        II3XOpr/QR24R5DugJ/F0UCe5j3VCimgIZMfeCMb4Ma3keLJdnOp41j1AyTUDPw1Qovk0H30Gve
        sIQfquZNPDdY81/ju5G7kO9tolQ==
X-Received: by 2002:a05:600c:21ca:: with SMTP id x10mr13389614wmj.113.1588590237221;
        Mon, 04 May 2020 04:03:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypKjeQyVv5zRPQ7aICRYZ0sMZAtZDqbG7MhZ3RkTKsWX40wgBG0HIR9xnW0BIQwyAeP1qUNYhA==
X-Received: by 2002:a05:600c:21ca:: with SMTP id x10mr13389521wmj.113.1588590236123;
        Mon, 04 May 2020 04:03:56 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.213])
        by smtp.gmail.com with ESMTPSA id a13sm10885750wrv.67.2020.05.04.04.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 04:03:55 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v2 3/5] kunit: tests for stats_fs API
Date:   Mon,  4 May 2020 13:03:42 +0200
Message-Id: <20200504110344.17560-4-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200504110344.17560-1-eesposit@redhat.com>
References: <20200504110344.17560-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add kunit tests to extensively test the stats_fs API functionality.

In order to run them, the kernel .config must set CONFIG_KUNIT=y
and a new .kunitconfig file must be created with CONFIG_STATS_FS=y
and CONFIG_STATS_FS_TEST=y

Tests can be then started by running the following command from the root
directory of the linux kernel source tree:
./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all`

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 fs/Kconfig                   |    6 +
 fs/stats_fs/Makefile         |    2 +
 fs/stats_fs/stats_fs-tests.c | 1088 ++++++++++++++++++++++++++++++++++
 3 files changed, 1096 insertions(+)
 create mode 100644 fs/stats_fs/stats_fs-tests.c

diff --git a/fs/Kconfig b/fs/Kconfig
index 1b0de0f19e96..0844e8defd22 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -334,4 +334,10 @@ config STATS_FS
 	  stats_fs is a virtual file system that provides counters and
 	  other statistics about the running kernel.
 
+config STATS_FS_TEST
+	bool "Tests for stats_fs"
+	depends on STATS_FS && KUNIT
+	help
+	  tests for the stats_fs API.
+
 endmenu
diff --git a/fs/stats_fs/Makefile b/fs/stats_fs/Makefile
index 94fe52d590d5..9db130fac6b6 100644
--- a/fs/stats_fs/Makefile
+++ b/fs/stats_fs/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 stats_fs-objs	:= stats_fs.o
+stats_fs-tests-objs	:= stats_fs-tests.o
 
 obj-$(CONFIG_STATS_FS)	+= stats_fs.o
+obj-$(CONFIG_STATS_FS_TEST) += stats_fs-tests.o
diff --git a/fs/stats_fs/stats_fs-tests.c b/fs/stats_fs/stats_fs-tests.c
new file mode 100644
index 000000000000..46c3fb510ee9
--- /dev/null
+++ b/fs/stats_fs/stats_fs-tests.c
@@ -0,0 +1,1088 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/anon_inodes.h>
+#include <linux/spinlock.h>
+#include <linux/uaccess.h>
+#include <linux/rwsem.h>
+#include <linux/list.h>
+#include <linux/kref.h>
+
+#include <linux/limits.h>
+#include <linux/stats_fs.h>
+#include <kunit/test.h>
+#include "internal.h"
+
+#define STATS_FS_STAT(el, x, ...)                                              \
+	{                                                                      \
+		.name = #x, .offset = offsetof(struct container, el.x),        \
+		##__VA_ARGS__                                                  \
+	}
+
+#define ARR_SIZE(el) ((int)(sizeof(el) / sizeof(struct stats_fs_value) - 1))
+
+struct test_values_struct {
+	uint64_t u64;
+	int32_t s32;
+	bool bo;
+	uint8_t u8;
+	int16_t s16;
+};
+
+struct container {
+	struct test_values_struct vals;
+};
+
+struct stats_fs_value test_values[6] = {
+	STATS_FS_STAT(vals, u64, .type = STATS_FS_U64,
+		      .aggr_kind = STATS_FS_NONE, .mode = 0),
+	STATS_FS_STAT(vals, s32, .type = STATS_FS_S32,
+		      .aggr_kind = STATS_FS_NONE, .mode = 0),
+	STATS_FS_STAT(vals, bo, .type = STATS_FS_BOOL,
+		      .aggr_kind = STATS_FS_NONE, .mode = 0),
+	STATS_FS_STAT(vals, u8, .type = STATS_FS_U8, .aggr_kind = STATS_FS_NONE,
+		      .mode = 0),
+	STATS_FS_STAT(vals, s16, .type = STATS_FS_S16,
+		      .aggr_kind = STATS_FS_NONE, .mode = 0),
+	{ NULL },
+};
+
+struct stats_fs_value test_aggr[4] = {
+	STATS_FS_STAT(vals, s32, .type = STATS_FS_S32,
+		      .aggr_kind = STATS_FS_MIN, .mode = 0),
+	STATS_FS_STAT(vals, bo, .type = STATS_FS_BOOL,
+		      .aggr_kind = STATS_FS_MAX, .mode = 0),
+	STATS_FS_STAT(vals, u64, .type = STATS_FS_U64,
+		      .aggr_kind = STATS_FS_SUM, .mode = 0),
+	{ NULL },
+};
+
+struct stats_fs_value test_same_name[3] = {
+	STATS_FS_STAT(vals, s32, .type = STATS_FS_S32,
+		      .aggr_kind = STATS_FS_NONE, .mode = 0),
+	STATS_FS_STAT(vals, s32, .type = STATS_FS_S32,
+		      .aggr_kind = STATS_FS_MIN, .mode = 0),
+	{ NULL },
+};
+
+struct stats_fs_value test_all_aggr[6] = {
+	STATS_FS_STAT(vals, s32, .type = STATS_FS_S32,
+		      .aggr_kind = STATS_FS_MIN, .mode = 0),
+	STATS_FS_STAT(vals, bo, .type = STATS_FS_BOOL,
+		      .aggr_kind = STATS_FS_COUNT_ZERO, .mode = 0),
+	STATS_FS_STAT(vals, u64, .type = STATS_FS_U64,
+		      .aggr_kind = STATS_FS_SUM, .mode = 0),
+	STATS_FS_STAT(vals, u8, .type = STATS_FS_U8, .aggr_kind = STATS_FS_AVG,
+		      .mode = 0),
+	STATS_FS_STAT(vals, s16, .type = STATS_FS_S16,
+		      .aggr_kind = STATS_FS_MAX, .mode = 0),
+	{ NULL },
+};
+
+#define def_u64 ((uint64_t)64)
+
+#define def_val_s32 ((int32_t)S32_MIN)
+#define def_val_bool ((bool)true)
+#define def_val_u8 ((uint8_t)127)
+#define def_val_s16 ((int16_t)10000)
+
+#define def_val2_s32 ((int32_t)S16_MAX)
+#define def_val2_bool ((bool)false)
+#define def_val2_u8 ((uint8_t)255)
+#define def_val2_s16 ((int16_t)-20000)
+
+struct container cont = {
+	.vals = {
+			.u64 = def_u64,
+			.s32 = def_val_s32,
+			.bo = def_val_bool,
+			.u8 = def_val_u8,
+			.s16 = def_val_s16,
+		},
+};
+
+struct container cont2 = {
+	.vals = {
+			.u64 = def_u64,
+			.s32 = def_val2_s32,
+			.bo = def_val2_bool,
+			.u8 = def_val2_u8,
+			.s16 = def_val2_s16,
+		},
+};
+
+static void get_stats_at_addr(struct stats_fs_source *src, void *addr,
+			      int *aggr, int *val, int use_addr)
+{
+	struct stats_fs_value *entry;
+	struct stats_fs_value_source *src_entry;
+	int counter_val = 0, counter_aggr = 0;
+
+	list_for_each_entry (src_entry, &src->values_head, list_element) {
+		if (use_addr && src_entry->base_addr != addr)
+			continue;
+
+		for (entry = src_entry->values; entry->name; entry++) {
+			if (entry->aggr_kind == STATS_FS_NONE)
+				counter_val++;
+			else
+				counter_aggr++;
+		}
+	}
+
+	if (aggr)
+		*aggr = counter_aggr;
+
+	if (val)
+		*val = counter_val;
+}
+
+int source_has_subsource(struct stats_fs_source *src,
+			 struct stats_fs_source *sub)
+{
+	struct stats_fs_source *entry;
+
+	list_for_each_entry (entry, &src->subordinates_head, list_element) {
+		if (entry == sub)
+			return 1;
+	}
+	return 0;
+}
+
+int get_number_subsources(struct stats_fs_source *src)
+{
+	struct stats_fs_source *entry;
+	int counter = 0;
+
+	list_for_each_entry (entry, &src->subordinates_head, list_element) {
+		counter++;
+	}
+	return counter;
+}
+
+int get_number_values(struct stats_fs_source *src)
+{
+	int counter = 0;
+
+	get_stats_at_addr(src, NULL, NULL, &counter, 0);
+	return counter;
+}
+
+int get_total_number_values(struct stats_fs_source *src)
+{
+	struct stats_fs_source *sub_entry;
+	int counter = 0;
+
+	get_stats_at_addr(src, NULL, NULL, &counter, 0);
+
+	list_for_each_entry (sub_entry, &src->subordinates_head, list_element) {
+		counter += get_total_number_values(sub_entry);
+	}
+
+	return counter;
+}
+
+int get_number_aggregates(struct stats_fs_source *src)
+{
+	int counter = 0;
+
+	get_stats_at_addr(src, NULL, &counter, NULL, 1);
+	return counter;
+}
+
+int get_number_values_with_base(struct stats_fs_source *src, void *addr)
+{
+	int counter = 0;
+
+	get_stats_at_addr(src, addr, NULL, &counter, 1);
+	return counter;
+}
+
+int get_number_aggr_with_base(struct stats_fs_source *src, void *addr)
+{
+	int counter = 0;
+
+	get_stats_at_addr(src, addr, &counter, NULL, 1);
+	return counter;
+}
+
+static void test_empty_folder(struct kunit *test)
+{
+	struct stats_fs_source *src;
+
+	src = stats_fs_source_create("kvm_%d", 123);
+	KUNIT_EXPECT_EQ(test, strcmp(src->name, "kvm_123"), 0);
+	KUNIT_EXPECT_EQ(test, get_number_subsources(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_values(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), 0);
+	stats_fs_source_put(src);
+}
+
+static void test_add_subfolder(struct kunit *test)
+{
+	struct stats_fs_source *src, *sub;
+
+	src = stats_fs_source_create("parent");
+	sub = stats_fs_source_create("child");
+	stats_fs_source_add_subordinate(src, sub);
+	KUNIT_EXPECT_EQ(test, source_has_subsource(src, sub), true);
+	KUNIT_EXPECT_EQ(test, get_number_subsources(src), 1);
+	KUNIT_EXPECT_EQ(test, get_number_values(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_values(sub), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(sub), 0);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+
+	stats_fs_source_put(sub);
+	sub = stats_fs_source_create("not a child");
+	KUNIT_EXPECT_EQ(test, source_has_subsource(src, sub), false);
+	KUNIT_EXPECT_EQ(test, get_number_subsources(src), 1);
+
+	stats_fs_source_put(sub);
+	stats_fs_source_put(src);
+}
+
+static void test_add_value(struct kunit *test)
+{
+	struct stats_fs_source *src;
+	int n;
+
+	src = stats_fs_source_create("parent");
+
+	// add values
+	n = stats_fs_source_add_values(src, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+
+	// add same values, nothing happens
+	n = stats_fs_source_add_values(src, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, -EEXIST);
+	n = get_number_values_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+
+	// size is invaried
+	KUNIT_EXPECT_EQ(test, get_number_values(src), ARR_SIZE(test_values));
+
+	// no aggregates
+	n = get_number_aggr_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, get_number_values(src), ARR_SIZE(test_values));
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), 0);
+
+	stats_fs_source_put(src);
+}
+
+static void test_add_value_in_subfolder(struct kunit *test)
+{
+	struct stats_fs_source *src, *sub, *sub_not;
+	int n;
+
+	src = stats_fs_source_create("parent");
+	sub = stats_fs_source_create("child");
+
+	// src -> sub
+	stats_fs_source_add_subordinate(src, sub);
+
+	// add values
+	n = stats_fs_source_add_values(sub, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(sub, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+	KUNIT_EXPECT_EQ(test, get_number_values(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), 0);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src),
+			ARR_SIZE(test_values));
+
+	KUNIT_EXPECT_EQ(test, get_number_values(sub), ARR_SIZE(test_values));
+	// no values in sub
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(sub), 0);
+
+	// different folder
+	sub_not = stats_fs_source_create("not a child");
+
+	// add values
+	n = stats_fs_source_add_values(sub_not, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(sub_not, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+	KUNIT_EXPECT_EQ(test, get_number_values(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), 0);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src),
+			ARR_SIZE(test_values));
+
+	// remove sub, check values is 0
+	stats_fs_source_remove_subordinate(src, sub);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+
+	// re-add sub, check value are added
+	stats_fs_source_add_subordinate(src, sub);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src),
+			ARR_SIZE(test_values));
+
+	// add sub_not, check value are twice as many
+	stats_fs_source_add_subordinate(src, sub_not);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src),
+			ARR_SIZE(test_values) * 2);
+
+	KUNIT_EXPECT_EQ(test, get_number_values(sub_not),
+			ARR_SIZE(test_values));
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(sub_not), 0);
+
+	stats_fs_source_put(sub);
+	stats_fs_source_put(sub_not);
+	stats_fs_source_put(src);
+}
+
+static void test_search_value(struct kunit *test)
+{
+	struct stats_fs_source *src;
+	uint64_t ret;
+	int n;
+
+	src = stats_fs_source_create("parent");
+
+	// add values
+	n = stats_fs_source_add_values(src, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+
+	// get u64
+	n = stats_fs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, def_u64);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	n = stats_fs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	n = stats_fs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, ((bool)ret), def_val_bool);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	// get a non-added value
+	n = stats_fs_source_get_value_by_name(src, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	stats_fs_source_put(src);
+}
+
+static void test_search_value_in_subfolder(struct kunit *test)
+{
+	struct stats_fs_source *src, *sub;
+	uint64_t ret;
+	int n;
+
+	src = stats_fs_source_create("parent");
+	sub = stats_fs_source_create("child");
+
+	// src -> sub
+	stats_fs_source_add_subordinate(src, sub);
+
+	// add values to sub
+	n = stats_fs_source_add_values(sub, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(sub, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+
+	n = stats_fs_source_get_value_by_name(sub, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, def_u64);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = stats_fs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = stats_fs_source_get_value_by_name(sub, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = stats_fs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = stats_fs_source_get_value_by_name(sub, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, ((bool)ret), def_val_bool);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = stats_fs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = stats_fs_source_get_value_by_name(sub, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+	n = stats_fs_source_get_value_by_name(src, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	stats_fs_source_put(sub);
+	stats_fs_source_put(src);
+}
+
+static void test_search_value_in_empty_folder(struct kunit *test)
+{
+	struct stats_fs_source *src;
+	uint64_t ret;
+	int n;
+
+	src = stats_fs_source_create("empty folder");
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_subsources(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_values(src), 0);
+
+	n = stats_fs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = stats_fs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = stats_fs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = stats_fs_source_get_value_by_name(src, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	stats_fs_source_put(src);
+}
+
+static void test_add_aggregate(struct kunit *test)
+{
+	struct stats_fs_source *src;
+	int n;
+
+	src = stats_fs_source_create("parent");
+
+	// add aggr to src, no values
+	n = stats_fs_source_add_values(src, test_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	// count values
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+
+	// add same array again, should not be added
+	n = stats_fs_source_add_values(src, test_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, -EEXIST);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+
+	KUNIT_EXPECT_EQ(test, get_number_values(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), ARR_SIZE(test_aggr));
+
+	stats_fs_source_put(src);
+}
+
+static void test_add_aggregate_in_subfolder(struct kunit *test)
+{
+	struct stats_fs_source *src, *sub, *sub_not;
+	int n;
+
+	src = stats_fs_source_create("parent");
+	sub = stats_fs_source_create("child");
+	// src->sub
+	stats_fs_source_add_subordinate(src, sub);
+
+	// add aggr to sub
+	n = stats_fs_source_add_values(sub, test_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+	KUNIT_EXPECT_EQ(test, get_number_values(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), 0);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+
+	KUNIT_EXPECT_EQ(test, get_number_values(sub), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(sub), ARR_SIZE(test_aggr));
+
+	// not a child
+	sub_not = stats_fs_source_create("not a child");
+
+	// add aggr to "not a child"
+	n = stats_fs_source_add_values(sub_not, test_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub_not, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+	KUNIT_EXPECT_EQ(test, get_number_values(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), 0);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+
+	// remove sub
+	stats_fs_source_remove_subordinate(src, sub);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+
+	// re-add both
+	stats_fs_source_add_subordinate(src, sub);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+	stats_fs_source_add_subordinate(src, sub_not);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+
+	KUNIT_EXPECT_EQ(test, get_number_values(sub_not), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(sub_not),
+			ARR_SIZE(test_aggr));
+
+	stats_fs_source_put(sub);
+	stats_fs_source_put(sub_not);
+	stats_fs_source_put(src);
+}
+
+static void test_search_aggregate(struct kunit *test)
+{
+	struct stats_fs_source *src;
+	uint64_t ret;
+	int n;
+
+	src = stats_fs_source_create("parent");
+	n = stats_fs_source_add_values(src, test_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+	n = get_number_aggr_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = stats_fs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	n = stats_fs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, (int64_t)ret, S64_MAX);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	n = stats_fs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	n = stats_fs_source_get_value_by_name(src, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+	stats_fs_source_put(src);
+}
+
+static void test_search_aggregate_in_subfolder(struct kunit *test)
+{
+	struct stats_fs_source *src, *sub;
+	uint64_t ret;
+	int n;
+
+	src = stats_fs_source_create("parent");
+	sub = stats_fs_source_create("child");
+
+	stats_fs_source_add_subordinate(src, sub);
+
+	n = stats_fs_source_add_values(sub, test_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+	n = get_number_aggr_with_base(sub, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	// no u64 in test_aggr
+	n = stats_fs_source_get_value_by_name(sub, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = stats_fs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = stats_fs_source_get_value_by_name(sub, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, (int64_t)ret, S64_MAX);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = stats_fs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = stats_fs_source_get_value_by_name(sub, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = stats_fs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = stats_fs_source_get_value_by_name(sub, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+	n = stats_fs_source_get_value_by_name(src, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	stats_fs_source_put(sub);
+	stats_fs_source_put(src);
+}
+
+void test_search_same(struct kunit *test)
+{
+	struct stats_fs_source *src;
+	uint64_t ret;
+	int n;
+
+	src = stats_fs_source_create("parent");
+	n = stats_fs_source_add_values(src, test_same_name, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, 1);
+	n = get_number_aggr_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, 1);
+
+	n = stats_fs_source_add_values(src, test_same_name, &cont);
+	KUNIT_EXPECT_EQ(test, n, -EEXIST);
+	n = get_number_values_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, 1);
+	n = get_number_aggr_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, 1);
+
+	// returns first the value
+	n = stats_fs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	stats_fs_source_put(src);
+}
+
+static void test_add_mixed(struct kunit *test)
+{
+	struct stats_fs_source *src;
+	int n;
+
+	src = stats_fs_source_create("parent");
+
+	n = stats_fs_source_add_values(src, test_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = stats_fs_source_add_values(src, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+
+	n = stats_fs_source_add_values(src, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, -EEXIST);
+	n = get_number_values_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+	n = stats_fs_source_add_values(src, test_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, -EEXIST);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+
+	KUNIT_EXPECT_EQ(test, get_number_values(src), ARR_SIZE(test_values));
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), ARR_SIZE(test_aggr));
+	stats_fs_source_put(src);
+}
+
+static void test_search_mixed(struct kunit *test)
+{
+	struct stats_fs_source *src, *sub;
+	uint64_t ret;
+	int n;
+
+	src = stats_fs_source_create("parent");
+	sub = stats_fs_source_create("child");
+	stats_fs_source_add_subordinate(src, sub);
+
+	// src has the aggregates, sub the values. Just search
+	n = stats_fs_source_add_values(sub, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(sub, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+	n = stats_fs_source_add_values(src, test_aggr, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+
+	// u64 is sum so again same value
+	n = stats_fs_source_get_value_by_name(sub, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, def_u64);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = stats_fs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, def_u64);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	// s32 is min so return the value also in the aggregate
+	n = stats_fs_source_get_value_by_name(sub, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = stats_fs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	// bo is max
+	n = stats_fs_source_get_value_by_name(sub, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, (bool)ret, def_val_bool);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = stats_fs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, (bool)ret, def_val_bool);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	n = stats_fs_source_get_value_by_name(sub, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+	n = stats_fs_source_get_value_by_name(src, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	stats_fs_source_put(sub);
+	stats_fs_source_put(src);
+}
+
+static void test_all_aggregations_agg_val_val(struct kunit *test)
+{
+	struct stats_fs_source *src, *sub1, *sub2;
+	uint64_t ret;
+	int n;
+
+	src = stats_fs_source_create("parent");
+	sub1 = stats_fs_source_create("child1");
+	sub2 = stats_fs_source_create("child2");
+	stats_fs_source_add_subordinate(src, sub1);
+	stats_fs_source_add_subordinate(src, sub2);
+
+	n = stats_fs_source_add_values(sub1, test_all_aggr, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub1, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+	n = stats_fs_source_add_values(sub2, test_all_aggr, &cont2);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub2, &cont2);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	n = stats_fs_source_add_values(src, test_all_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	// sum
+	n = stats_fs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, def_u64 * 2);
+
+	// min
+	n = stats_fs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+
+	// count_0
+	n = stats_fs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 1ull);
+
+	// avg
+	n = stats_fs_source_get_value_by_name(src, "u8", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 191ull);
+
+	// max
+	n = stats_fs_source_get_value_by_name(src, "s16", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int16_t)ret, def_val_s16);
+
+	stats_fs_source_put(sub1);
+	stats_fs_source_put(sub2);
+	stats_fs_source_put(src);
+}
+
+static void test_all_aggregations_val_agg_val(struct kunit *test)
+{
+	struct stats_fs_source *src, *sub1, *sub2;
+	uint64_t ret;
+	int n;
+
+	src = stats_fs_source_create("parent");
+	sub1 = stats_fs_source_create("child1");
+	sub2 = stats_fs_source_create("child2");
+	stats_fs_source_add_subordinate(src, sub1);
+	stats_fs_source_add_subordinate(src, sub2);
+
+	n = stats_fs_source_add_values(src, test_all_aggr, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+	n = stats_fs_source_add_values(sub2, test_all_aggr, &cont2);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub2, &cont2);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	n = stats_fs_source_add_values(sub1, test_all_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub1, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	n = stats_fs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, def_u64);
+	n = stats_fs_source_get_value_by_name(sub1, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	n = stats_fs_source_get_value_by_name(sub2, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, def_u64);
+
+	n = stats_fs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+	n = stats_fs_source_get_value_by_name(sub1, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int64_t)ret, S64_MAX); // MIN
+	n = stats_fs_source_get_value_by_name(sub2, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val2_s32);
+
+	n = stats_fs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (bool)ret, def_val_bool);
+	n = stats_fs_source_get_value_by_name(sub1, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	n = stats_fs_source_get_value_by_name(sub2, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (bool)ret, def_val2_bool);
+
+	n = stats_fs_source_get_value_by_name(src, "u8", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (uint8_t)ret, def_val_u8);
+	n = stats_fs_source_get_value_by_name(sub1, "u8", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	n = stats_fs_source_get_value_by_name(sub2, "u8", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (uint8_t)ret, def_val2_u8);
+
+	n = stats_fs_source_get_value_by_name(src, "s16", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int16_t)ret, def_val_s16);
+	n = stats_fs_source_get_value_by_name(sub1, "s16", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int64_t)ret, S64_MIN); // MAX
+	n = stats_fs_source_get_value_by_name(sub2, "s16", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int16_t)ret, def_val2_s16);
+
+	stats_fs_source_put(sub1);
+	stats_fs_source_put(sub2);
+	stats_fs_source_put(src);
+}
+
+static void test_all_aggregations_agg_val_val_sub(struct kunit *test)
+{
+	struct stats_fs_source *src, *sub1, *sub11;
+	uint64_t ret;
+	int n;
+
+	src = stats_fs_source_create("parent");
+	sub1 = stats_fs_source_create("child1");
+	sub11 = stats_fs_source_create("child11");
+	stats_fs_source_add_subordinate(src, sub1);
+	stats_fs_source_add_subordinate(sub1, sub11); // changes here!
+
+	n = stats_fs_source_add_values(sub1, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(sub1, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+	n = stats_fs_source_add_values(sub11, test_values, &cont2);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(sub11, &cont2);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src),
+			ARR_SIZE(test_values) * 2);
+
+	n = stats_fs_source_add_values(sub1, test_all_aggr, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub1, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+	n = stats_fs_source_add_values(sub11, test_all_aggr, &cont2);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub11, &cont2);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	n = stats_fs_source_add_values(src, test_all_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	// sum
+	n = stats_fs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, def_u64 * 2);
+
+	// min
+	n = stats_fs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+
+	// count_0
+	n = stats_fs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 1ull);
+
+	// avg
+	n = stats_fs_source_get_value_by_name(src, "u8", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 191ull);
+
+	// max
+	n = stats_fs_source_get_value_by_name(src, "s16", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int16_t)ret, def_val_s16);
+
+	stats_fs_source_put(sub1);
+	stats_fs_source_put(sub11);
+	stats_fs_source_put(src);
+}
+
+static void test_all_aggregations_agg_no_val_sub(struct kunit *test)
+{
+	struct stats_fs_source *src, *sub1, *sub11;
+	uint64_t ret;
+	int n;
+
+	src = stats_fs_source_create("parent");
+	sub1 = stats_fs_source_create("child1");
+	sub11 = stats_fs_source_create("child11");
+	stats_fs_source_add_subordinate(src, sub1);
+	stats_fs_source_add_subordinate(sub1, sub11);
+
+	n = stats_fs_source_add_values(sub11, test_all_aggr, &cont2);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub11, &cont2);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+
+	n = stats_fs_source_add_values(src, test_all_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	// sum
+	n = stats_fs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, def_u64);
+
+	// min
+	n = stats_fs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val2_s32);
+
+	// count_0
+	n = stats_fs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 1ull);
+
+	// avg
+	n = stats_fs_source_get_value_by_name(src, "u8", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (uint8_t)ret, def_val2_u8);
+
+	// max
+	n = stats_fs_source_get_value_by_name(src, "s16", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int16_t)ret, def_val2_s16);
+
+	stats_fs_source_put(sub1);
+	stats_fs_source_put(sub11);
+	stats_fs_source_put(src);
+}
+
+static void test_all_aggregations_agg_agg_val_sub(struct kunit *test)
+{
+	struct stats_fs_source *src, *sub1, *sub11, *sub12;
+	uint64_t ret;
+	int n;
+
+	src = stats_fs_source_create("parent");
+	sub1 = stats_fs_source_create("child1");
+	sub11 = stats_fs_source_create("child11");
+	sub12 = stats_fs_source_create("child12");
+	stats_fs_source_add_subordinate(src, sub1);
+	stats_fs_source_add_subordinate(sub1, sub11);
+	stats_fs_source_add_subordinate(sub1, sub12);
+
+	n = stats_fs_source_add_values(sub11, test_all_aggr, &cont2);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub11, &cont2);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	n = stats_fs_source_add_values(sub12, test_all_aggr, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub12, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+
+	n = stats_fs_source_add_values(src, test_all_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	n = stats_fs_source_add_values(sub1, test_all_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub1, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	// sum
+	n = stats_fs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, def_u64 * 2);
+
+	// min
+	n = stats_fs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+
+	// count_0
+	n = stats_fs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 1ull);
+
+	// avg
+	n = stats_fs_source_get_value_by_name(src, "u8", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (uint8_t)ret,
+			(uint8_t)((def_val2_u8 + def_val_u8) / 2));
+
+	// max
+	n = stats_fs_source_get_value_by_name(src, "s16", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int16_t)ret, def_val_s16);
+
+	stats_fs_source_put(sub1);
+	stats_fs_source_put(sub11);
+	stats_fs_source_put(sub12);
+	stats_fs_source_put(src);
+}
+
+static struct kunit_case stats_fs_test_cases[] = {
+	KUNIT_CASE(test_empty_folder),
+	KUNIT_CASE(test_add_subfolder),
+	KUNIT_CASE(test_add_value),
+	KUNIT_CASE(test_add_value_in_subfolder),
+	KUNIT_CASE(test_search_value),
+	KUNIT_CASE(test_search_value_in_subfolder),
+	KUNIT_CASE(test_search_value_in_empty_folder),
+	KUNIT_CASE(test_add_aggregate),
+	KUNIT_CASE(test_add_aggregate_in_subfolder),
+	KUNIT_CASE(test_search_aggregate),
+	KUNIT_CASE(test_search_aggregate_in_subfolder),
+	KUNIT_CASE(test_search_same),
+	KUNIT_CASE(test_add_mixed),
+	KUNIT_CASE(test_search_mixed),
+	KUNIT_CASE(test_all_aggregations_agg_val_val),
+	KUNIT_CASE(test_all_aggregations_val_agg_val),
+	KUNIT_CASE(test_all_aggregations_agg_val_val_sub),
+	KUNIT_CASE(test_all_aggregations_agg_no_val_sub),
+	KUNIT_CASE(test_all_aggregations_agg_agg_val_sub),
+	{}
+};
+
+static struct kunit_suite stats_fs_test_suite = {
+	.name = "stats_fs",
+	.test_cases = stats_fs_test_cases,
+};
+
+kunit_test_suite(stats_fs_test_suite);
-- 
2.25.2

