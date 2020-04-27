Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35111BA621
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 16:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgD0OSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 10:18:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48826 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726651AbgD0OSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587997112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wSLb7CBYXsrumhTkrilwNmcAAa0PtZH+2qDH65J05Hk=;
        b=GuUYO59EPwpuVbqjbqsP9WJWC6hgZUIfJc+dGu6KwyZAIRgRyWtkV0xLwRJB2L1VjUtUV8
        lHQmDd7z+hse/sf/a9kf8M4QFQL+mv5mbQ+wQO/716m69M372vOtzxZu2RW4rkVZUjktsf
        /5dQYxG/RSkwszS9MrgFNHoK673yylE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-8juHmS3sNaaERgcr-kRiGA-1; Mon, 27 Apr 2020 10:18:30 -0400
X-MC-Unique: 8juHmS3sNaaERgcr-kRiGA-1
Received: by mail-wm1-f71.google.com with SMTP id n17so8740538wmi.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 07:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSLb7CBYXsrumhTkrilwNmcAAa0PtZH+2qDH65J05Hk=;
        b=t+UstvpFVHz7pmwdmhRkwvwiJeD8uJL1Rep5rXuZLIqxn4LYsXP9b91s6NLaRKOW/m
         7/pFdq1etVWS5RqouLUndFuik5nP4fVG1/gIJM/XAL470Xfzx7Q0762WvdqcIN7gKnOj
         2Ntg/mvk3nrWFNgDWoIYgjHtrq9qNedndbOBBqWmMyBIJi9xqsXjbvMsW1sg1fP/BAYw
         gQtb1mrTWneDwVyxeGZUhqe1abrKAiJ1RgiTCwBvXPPfkzQVVXPadAGMymLivFcvd6kL
         oE+pFWJolbhNbG9vJqE1VOpGEAWykRGuTpOwwPyDclvta1nHX2f+EbM0Asb9kN17EPLK
         dlNA==
X-Gm-Message-State: AGi0Pub344b9AJAnVsUoEyPOToHjK9Is9HtZOo7xYNMOb2UKD3fxMFwA
        jngAorZqOktFXlixPXCfG+Us+I7upDdInjxsFyNwKatMq2WlvKaJH3wCeTx9nx94LbJgphVbEJu
        kxsNene92NFflheyz/gGF8MloZw==
X-Received: by 2002:adf:fe03:: with SMTP id n3mr26766973wrr.315.1587997108902;
        Mon, 27 Apr 2020 07:18:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypJJzOyye5ZwO11we4xfO1Q9DbGtIwqLK00LURLtlGTI63vYcO4gQD/8xMo3YcqtsjYrq1wd2w==
X-Received: by 2002:adf:fe03:: with SMTP id n3mr26766922wrr.315.1587997108170;
        Mon, 27 Apr 2020 07:18:28 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.207])
        by smtp.gmail.com with ESMTPSA id 1sm15914570wmz.13.2020.04.27.07.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:18:27 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mst@redhat.com,
        borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [RFC PATCH 3/5] kunit: tests for statsfs API
Date:   Mon, 27 Apr 2020 16:18:14 +0200
Message-Id: <20200427141816.16703-4-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200427141816.16703-1-eesposit@redhat.com>
References: <20200427141816.16703-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add kunit tests to extensively test the statsfs API functionality.

In order to run them, the kernel .config must set CONFIG_KUNIT=y
and a new .kunitconfig file must be created with CONFIG_STATS_FS=y
and CONFIG_STATS_FS_TEST=y

Tests can be then started by running the following command from the root
directory of the linux kernel source tree:
./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all`

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 fs/Kconfig                 |    6 +
 fs/statsfs/Makefile        |    2 +
 fs/statsfs/statsfs-tests.c | 1067 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1075 insertions(+)
 create mode 100644 fs/statsfs/statsfs-tests.c

diff --git a/fs/Kconfig b/fs/Kconfig
index 824fcf86d12b..6145b607e0bc 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -335,4 +335,10 @@ config STATS_FS
 	  statsfs is a virtual file system that provides counters and other
 	  statistics about the running kernel.
 
+config STATS_FS_TEST
+    bool "Tests for statsfs"
+    depends on STATS_FS && KUNIT
+	help
+	  statsfs tests for the statsfs API.
+
 endmenu
diff --git a/fs/statsfs/Makefile b/fs/statsfs/Makefile
index d494a3f30ba5..f546e3f03a12 100644
--- a/fs/statsfs/Makefile
+++ b/fs/statsfs/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 statsfs-objs	:= statsfs.o
+statsfs-tests-objs	:= statsfs-tests.o
 
 obj-$(CONFIG_STATS_FS)	+= statsfs.o
+obj-$(CONFIG_STATS_FS_TEST) += statsfs-tests.o
diff --git a/fs/statsfs/statsfs-tests.c b/fs/statsfs/statsfs-tests.c
new file mode 100644
index 000000000000..98d1da2c7544
--- /dev/null
+++ b/fs/statsfs/statsfs-tests.c
@@ -0,0 +1,1067 @@
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
+#include <linux/statsfs.h>
+#include <kunit/test.h>
+#include "internal.h"
+
+#define STATSFS_STAT(el, x, ...)                                               \
+	{                                                                      \
+		.name = #x, .offset = offsetof(struct container, el.x),        \
+		##__VA_ARGS__                                                  \
+	}
+
+#define ARR_SIZE(el) ((int)(sizeof(el) / sizeof(struct statsfs_value) - 1))
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
+struct statsfs_value test_values[6] = {
+	STATSFS_STAT(vals, u64, .type = STATSFS_U64, .aggr_kind = STATSFS_NONE,
+		     .mode = 0),
+	STATSFS_STAT(vals, s32, .type = STATSFS_S32, .aggr_kind = STATSFS_NONE,
+		     .mode = 0),
+	STATSFS_STAT(vals, bo, .type = STATSFS_BOOL, .aggr_kind = STATSFS_NONE,
+		     .mode = 0),
+	STATSFS_STAT(vals, u8, .type = STATSFS_U8, .aggr_kind = STATSFS_NONE,
+		     .mode = 0),
+	STATSFS_STAT(vals, s16, .type = STATSFS_S16, .aggr_kind = STATSFS_NONE,
+		     .mode = 0),
+	{ NULL },
+};
+
+struct statsfs_value test_aggr[4] = {
+	STATSFS_STAT(vals, s32, .type = STATSFS_S32, .aggr_kind = STATSFS_MIN,
+		     .mode = 0),
+	STATSFS_STAT(vals, bo, .type = STATSFS_BOOL, .aggr_kind = STATSFS_MAX,
+		     .mode = 0),
+	STATSFS_STAT(vals, u64, .type = STATSFS_U64, .aggr_kind = STATSFS_SUM,
+		     .mode = 0),
+	{ NULL },
+};
+
+struct statsfs_value test_same_name[3] = {
+	STATSFS_STAT(vals, s32, .type = STATSFS_S32, .aggr_kind = STATSFS_NONE,
+		     .mode = 0),
+	STATSFS_STAT(vals, s32, .type = STATSFS_S32, .aggr_kind = STATSFS_MIN,
+		     .mode = 0),
+	{ NULL },
+};
+
+struct statsfs_value test_all_aggr[6] = {
+	STATSFS_STAT(vals, s32, .type = STATSFS_S32, .aggr_kind = STATSFS_MIN,
+		     .mode = 0),
+	STATSFS_STAT(vals, bo, .type = STATSFS_BOOL,
+		     .aggr_kind = STATSFS_COUNT_ZERO, .mode = 0),
+	STATSFS_STAT(vals, u64, .type = STATSFS_U64, .aggr_kind = STATSFS_SUM,
+		     .mode = 0),
+	STATSFS_STAT(vals, u8, .type = STATSFS_U8, .aggr_kind = STATSFS_AVG,
+		     .mode = 0),
+	STATSFS_STAT(vals, s16, .type = STATSFS_S16, .aggr_kind = STATSFS_MAX,
+		     .mode = 0),
+	{ NULL },
+};
+
+#define def_u64 ((uint64_t) 64)
+
+#define def_val_s32 ((int32_t) S32_MIN)
+#define def_val_bool ((bool) true)
+#define def_val_u8 ((uint8_t) 127)
+#define def_val_s16 ((int16_t) 10000)
+
+#define def_val2_s32 ((int32_t) S16_MAX)
+#define def_val2_bool ((bool) false)
+#define def_val2_u8 ((uint8_t) 255)
+#define def_val2_s16 ((int16_t) -20000)
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
+static void get_stats_at_addr(struct statsfs_source *src, void *addr, int *aggr,
+			      int *val, int use_addr)
+{
+	struct statsfs_value *entry;
+	struct statsfs_value_source *src_entry;
+	int counter_val = 0, counter_aggr = 0;
+
+	list_for_each_entry(src_entry, &src->values_head, list_element) {
+		if (use_addr && src_entry->base_addr != addr)
+			continue;
+
+		for (entry = src_entry->values; entry->name; entry++) {
+			if (entry->aggr_kind == STATSFS_NONE)
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
+int source_has_subsource(struct statsfs_source *src, struct statsfs_source *sub)
+{
+	struct statsfs_source *entry;
+
+	list_for_each_entry(entry, &src->subordinates_head, list_element) {
+		if (entry == sub)
+			return 1;
+	}
+	return 0;
+}
+
+int get_number_subsources(struct statsfs_source *src)
+{
+	struct statsfs_source *entry;
+	int counter = 0;
+
+	list_for_each_entry(entry, &src->subordinates_head, list_element) {
+		counter++;
+	}
+	return counter;
+}
+
+int get_number_values(struct statsfs_source *src)
+{
+	int counter = 0;
+
+	get_stats_at_addr(src, NULL, NULL, &counter, 0);
+	return counter;
+}
+
+int get_total_number_values(struct statsfs_source *src)
+{
+	struct statsfs_source *sub_entry;
+	int counter = 0;
+
+	get_stats_at_addr(src, NULL, NULL, &counter, 0);
+
+	list_for_each_entry(sub_entry, &src->subordinates_head, list_element) {
+		counter += get_total_number_values(sub_entry);
+	}
+
+	return counter;
+}
+
+int get_number_aggregates(struct statsfs_source *src)
+{
+	int counter = 0;
+
+	get_stats_at_addr(src, NULL, &counter, NULL, 1);
+	return counter;
+}
+
+int get_number_values_with_base(struct statsfs_source *src, void *addr)
+{
+	int counter = 0;
+
+	get_stats_at_addr(src, addr, NULL, &counter, 1);
+	return counter;
+}
+
+int get_number_aggr_with_base(struct statsfs_source *src, void *addr)
+{
+	int counter = 0;
+
+	get_stats_at_addr(src, addr, &counter, NULL, 1);
+	return counter;
+}
+
+static void test_empty_folder(struct kunit *test)
+{
+	struct statsfs_source *src;
+
+	src = statsfs_source_create("kvm_%d", 123);
+	KUNIT_EXPECT_EQ(test, strcmp(src->name, "kvm_123"), 0);
+	KUNIT_EXPECT_EQ(test, get_number_subsources(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_values(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), 0);
+	statsfs_source_put(src);
+}
+
+static void test_add_subfolder(struct kunit *test)
+{
+	struct statsfs_source *src, *sub;
+
+	src = statsfs_source_create("parent");
+	sub = statsfs_source_create("child");
+	statsfs_source_add_subordinate(src, sub);
+	KUNIT_EXPECT_EQ(test, source_has_subsource(src, sub), true);
+	KUNIT_EXPECT_EQ(test, get_number_subsources(src), 1);
+	KUNIT_EXPECT_EQ(test, get_number_values(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_values(sub), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(sub), 0);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+
+	sub = statsfs_source_create("not a child");
+	KUNIT_EXPECT_EQ(test, source_has_subsource(src, sub), false);
+	KUNIT_EXPECT_EQ(test, get_number_subsources(src), 1);
+
+	statsfs_source_put(src);
+}
+
+static void test_add_value(struct kunit *test)
+{
+	struct statsfs_source *src;
+	int n;
+
+	src = statsfs_source_create("parent");
+
+	// add values
+	n = statsfs_source_add_values(src, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+
+	// add same values, nothing happens
+	n = statsfs_source_add_values(src, test_values, &cont);
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
+	statsfs_source_put(src);
+}
+
+static void test_add_value_in_subfolder(struct kunit *test)
+{
+	struct statsfs_source *src, *sub, *sub_not;
+	int n;
+
+	src = statsfs_source_create("parent");
+	sub = statsfs_source_create("child");
+
+	// src -> sub
+	statsfs_source_add_subordinate(src, sub);
+
+	// add values
+	n = statsfs_source_add_values(sub, test_values, &cont);
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
+	sub_not = statsfs_source_create("not a child");
+
+	// add values
+	n = statsfs_source_add_values(sub_not, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(sub_not, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+	KUNIT_EXPECT_EQ(test, get_number_values(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), 0);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src),
+			ARR_SIZE(test_values));
+
+	// remove sub, check values is 0
+	statsfs_source_remove_subordinate(src, sub);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+
+	// re-add sub, check value are added
+	statsfs_source_add_subordinate(src, sub);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src),
+			ARR_SIZE(test_values));
+
+	// add sub_not, check value are twice as many
+	statsfs_source_add_subordinate(src, sub_not);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src),
+			ARR_SIZE(test_values) * 2);
+
+	KUNIT_EXPECT_EQ(test, get_number_values(sub_not),
+			ARR_SIZE(test_values));
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(sub_not), 0);
+
+	statsfs_source_put(src);
+}
+
+static void test_search_value(struct kunit *test)
+{
+	struct statsfs_source *src;
+	uint64_t ret;
+	int n;
+
+	src = statsfs_source_create("parent");
+
+	// add values
+	n = statsfs_source_add_values(src, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+
+	// get u64
+	n = statsfs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, def_u64);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	n = statsfs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	n = statsfs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, ((bool)ret), def_val_bool);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	// get a non-added value
+	n = statsfs_source_get_value_by_name(src, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	statsfs_source_put(src);
+}
+
+static void test_search_value_in_subfolder(struct kunit *test)
+{
+	struct statsfs_source *src, *sub;
+	uint64_t ret;
+	int n;
+
+	src = statsfs_source_create("parent");
+	sub = statsfs_source_create("child");
+
+	// src -> sub
+	statsfs_source_add_subordinate(src, sub);
+
+	// add values to sub
+	n = statsfs_source_add_values(sub, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(sub, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+
+	n = statsfs_source_get_value_by_name(sub, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, def_u64);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = statsfs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = statsfs_source_get_value_by_name(sub, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = statsfs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = statsfs_source_get_value_by_name(sub, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, ((bool)ret), def_val_bool);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = statsfs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = statsfs_source_get_value_by_name(sub, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+	n = statsfs_source_get_value_by_name(src, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	statsfs_source_put(src);
+}
+
+static void test_search_value_in_empty_folder(struct kunit *test)
+{
+	struct statsfs_source *src;
+	uint64_t ret;
+	int n;
+
+	src = statsfs_source_create("empty folder");
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_subsources(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_values(src), 0);
+
+	n = statsfs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = statsfs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = statsfs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = statsfs_source_get_value_by_name(src, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	statsfs_source_put(src);
+}
+
+static void test_add_aggregate(struct kunit *test)
+{
+	struct statsfs_source *src;
+	int n;
+
+	src = statsfs_source_create("parent");
+
+	// add aggr to src, no values
+	n = statsfs_source_add_values(src, test_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	// count values
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+
+	// add same array again, should not be added
+	n = statsfs_source_add_values(src, test_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, -EEXIST);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+
+	KUNIT_EXPECT_EQ(test, get_number_values(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), ARR_SIZE(test_aggr));
+
+	statsfs_source_put(src);
+}
+
+static void test_add_aggregate_in_subfolder(struct kunit *test)
+{
+	struct statsfs_source *src, *sub, *sub_not;
+	int n;
+
+	src = statsfs_source_create("parent");
+	sub = statsfs_source_create("child");
+	// src->sub
+	statsfs_source_add_subordinate(src, sub);
+
+	// add aggr to sub
+	n = statsfs_source_add_values(sub, test_aggr, NULL);
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
+	sub_not = statsfs_source_create("not a child");
+
+	// add aggr to "not a child"
+	n = statsfs_source_add_values(sub_not, test_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub_not, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+	KUNIT_EXPECT_EQ(test, get_number_values(src), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), 0);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+
+	// remove sub
+	statsfs_source_remove_subordinate(src, sub);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+
+	// re-add both
+	statsfs_source_add_subordinate(src, sub);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+	statsfs_source_add_subordinate(src, sub_not);
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+
+	KUNIT_EXPECT_EQ(test, get_number_values(sub_not), 0);
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(sub_not),
+			ARR_SIZE(test_aggr));
+
+	statsfs_source_put(src);
+}
+
+static void test_search_aggregate(struct kunit *test)
+{
+	struct statsfs_source *src;
+	uint64_t ret;
+	int n;
+
+	src = statsfs_source_create("parent");
+	n = statsfs_source_add_values(src, test_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+	n = get_number_aggr_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = statsfs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	n = statsfs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, (int64_t)ret, S64_MAX);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	n = statsfs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	n = statsfs_source_get_value_by_name(src, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+	statsfs_source_put(src);
+}
+
+static void test_search_aggregate_in_subfolder(struct kunit *test)
+{
+	struct statsfs_source *src, *sub;
+	uint64_t ret;
+	int n;
+
+	src = statsfs_source_create("parent");
+	sub = statsfs_source_create("child");
+
+	statsfs_source_add_subordinate(src, sub);
+
+	n = statsfs_source_add_values(sub, test_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+	n = get_number_aggr_with_base(sub, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	// no u64 in test_aggr
+	n = statsfs_source_get_value_by_name(sub, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = statsfs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = statsfs_source_get_value_by_name(sub, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, (int64_t)ret, S64_MAX);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = statsfs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = statsfs_source_get_value_by_name(sub, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = statsfs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	n = statsfs_source_get_value_by_name(sub, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+	n = statsfs_source_get_value_by_name(src, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	statsfs_source_put(src);
+}
+
+void test_search_same(struct kunit *test)
+{
+	struct statsfs_source *src;
+	uint64_t ret;
+	int n;
+
+	src = statsfs_source_create("parent");
+	n = statsfs_source_add_values(src, test_same_name, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, 1);
+	n = get_number_aggr_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, 1);
+
+	n = statsfs_source_add_values(src, test_same_name, &cont);
+	KUNIT_EXPECT_EQ(test, n, -EEXIST);
+	n = get_number_values_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, 1);
+	n = get_number_aggr_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, 1);
+
+	// returns first the value
+	n = statsfs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	statsfs_source_put(src);
+}
+
+static void test_add_mixed(struct kunit *test)
+{
+	struct statsfs_source *src;
+	int n;
+
+	src = statsfs_source_create("parent");
+
+	n = statsfs_source_add_values(src, test_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = statsfs_source_add_values(src, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+
+	n = statsfs_source_add_values(src, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, -EEXIST);
+	n = get_number_values_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+	n = statsfs_source_add_values(src, test_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, -EEXIST);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+
+	KUNIT_EXPECT_EQ(test, get_number_values(src), ARR_SIZE(test_values));
+	KUNIT_EXPECT_EQ(test, get_number_aggregates(src), ARR_SIZE(test_aggr));
+	statsfs_source_put(src);
+}
+
+static void test_search_mixed(struct kunit *test)
+{
+	struct statsfs_source *src, *sub;
+	uint64_t ret;
+	int n;
+
+	src = statsfs_source_create("parent");
+	sub = statsfs_source_create("child");
+	statsfs_source_add_subordinate(src, sub);
+
+	// src has the aggregates, sub the values. Just search
+	n = statsfs_source_add_values(sub, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(sub, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+	n = statsfs_source_add_values(src, test_aggr, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_aggr));
+
+	// u64 is sum so again same value
+	n = statsfs_source_get_value_by_name(sub, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, def_u64);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = statsfs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, ret, def_u64);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	// s32 is min so return the value also in the aggregate
+	n = statsfs_source_get_value_by_name(sub, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = statsfs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	// bo is max
+	n = statsfs_source_get_value_by_name(sub, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, (bool)ret, def_val_bool);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = statsfs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, (bool)ret, def_val_bool);
+	KUNIT_EXPECT_EQ(test, n, 0);
+
+	n = statsfs_source_get_value_by_name(sub, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+	n = statsfs_source_get_value_by_name(src, "does not exist", &ret);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	KUNIT_EXPECT_EQ(test, n, -ENOENT);
+
+	statsfs_source_put(src);
+}
+
+static void test_all_aggregations_agg_val_val(struct kunit *test)
+{
+	struct statsfs_source *src, *sub1, *sub2;
+	uint64_t ret;
+	int n;
+
+	src = statsfs_source_create("parent");
+	sub1 = statsfs_source_create("child1");
+	sub2 = statsfs_source_create("child2");
+	statsfs_source_add_subordinate(src, sub1);
+	statsfs_source_add_subordinate(src, sub2);
+
+	n = statsfs_source_add_values(sub1, test_all_aggr, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub1, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+	n = statsfs_source_add_values(sub2, test_all_aggr, &cont2);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub2, &cont2);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	n = statsfs_source_add_values(src, test_all_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	// sum
+	n = statsfs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, def_u64 * 2);
+
+	// min
+	n = statsfs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+
+	// count_0
+	n = statsfs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 1ull);
+
+	// avg
+	n = statsfs_source_get_value_by_name(src, "u8", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 191ull);
+
+	// max
+	n = statsfs_source_get_value_by_name(src, "s16", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int16_t)ret, def_val_s16);
+
+	statsfs_source_put(src);
+}
+
+static void test_all_aggregations_val_agg_val(struct kunit *test)
+{
+	struct statsfs_source *src, *sub1, *sub2;
+	uint64_t ret;
+	int n;
+
+	src = statsfs_source_create("parent");
+	sub1 = statsfs_source_create("child1");
+	sub2 = statsfs_source_create("child2");
+	statsfs_source_add_subordinate(src, sub1);
+	statsfs_source_add_subordinate(src, sub2);
+
+	n = statsfs_source_add_values(src, test_all_aggr, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+	n = statsfs_source_add_values(sub2, test_all_aggr, &cont2);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub2, &cont2);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	n = statsfs_source_add_values(sub1, test_all_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub1, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	n = statsfs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, def_u64);
+	n = statsfs_source_get_value_by_name(sub1, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	n = statsfs_source_get_value_by_name(sub2, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, def_u64);
+
+	n = statsfs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+	n = statsfs_source_get_value_by_name(sub1, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int64_t)ret, S64_MAX); // MIN
+	n = statsfs_source_get_value_by_name(sub2, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val2_s32);
+
+	n = statsfs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (bool)ret, def_val_bool);
+	n = statsfs_source_get_value_by_name(sub1, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	n = statsfs_source_get_value_by_name(sub2, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (bool)ret, def_val2_bool);
+
+	n = statsfs_source_get_value_by_name(src, "u8", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (uint8_t)ret, def_val_u8);
+	n = statsfs_source_get_value_by_name(sub1, "u8", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 0ull);
+	n = statsfs_source_get_value_by_name(sub2, "u8", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (uint8_t)ret, def_val2_u8);
+
+	n = statsfs_source_get_value_by_name(src, "s16", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int16_t)ret, def_val_s16);
+	n = statsfs_source_get_value_by_name(sub1, "s16", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int64_t)ret, S64_MIN); // MAX
+	n = statsfs_source_get_value_by_name(sub2, "s16", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int16_t)ret, def_val2_s16);
+
+	statsfs_source_put(src);
+}
+
+static void test_all_aggregations_agg_val_val_sub(struct kunit *test)
+{
+	struct statsfs_source *src, *sub1, *sub11;
+	uint64_t ret;
+	int n;
+
+	src = statsfs_source_create("parent");
+	sub1 = statsfs_source_create("child1");
+	sub11 = statsfs_source_create("child11");
+	statsfs_source_add_subordinate(src, sub1);
+	statsfs_source_add_subordinate(sub1, sub11); // changes here!
+
+	n = statsfs_source_add_values(sub1, test_values, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(sub1, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+	n = statsfs_source_add_values(sub11, test_values, &cont2);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_values_with_base(sub11, &cont2);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_values));
+
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src),
+			ARR_SIZE(test_values) * 2);
+
+	n = statsfs_source_add_values(sub1, test_all_aggr, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub1, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+	n = statsfs_source_add_values(sub11, test_all_aggr, &cont2);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub11, &cont2);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	n = statsfs_source_add_values(src, test_all_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	// sum
+	n = statsfs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, def_u64 * 2);
+
+	// min
+	n = statsfs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+
+	// count_0
+	n = statsfs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 1ull);
+
+	// avg
+	n = statsfs_source_get_value_by_name(src, "u8", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 191ull);
+
+	// max
+	n = statsfs_source_get_value_by_name(src, "s16", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int16_t)ret, def_val_s16);
+
+	statsfs_source_put(src);
+}
+
+static void test_all_aggregations_agg_no_val_sub(struct kunit *test)
+{
+	struct statsfs_source *src, *sub1, *sub11;
+	uint64_t ret;
+	int n;
+
+	src = statsfs_source_create("parent");
+	sub1 = statsfs_source_create("child1");
+	sub11 = statsfs_source_create("child11");
+	statsfs_source_add_subordinate(src, sub1);
+	statsfs_source_add_subordinate(sub1, sub11);
+
+	n = statsfs_source_add_values(sub11, test_all_aggr, &cont2);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub11, &cont2);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+
+	n = statsfs_source_add_values(src, test_all_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	// sum
+	n = statsfs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, def_u64);
+
+	// min
+	n = statsfs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val2_s32);
+
+	// count_0
+	n = statsfs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 1ull);
+
+	// avg
+	n = statsfs_source_get_value_by_name(src, "u8", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (uint8_t)ret, def_val2_u8);
+
+	// max
+	n = statsfs_source_get_value_by_name(src, "s16", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int16_t)ret, def_val2_s16);
+
+	statsfs_source_put(src);
+}
+
+static void test_all_aggregations_agg_agg_val_sub(struct kunit *test)
+{
+	struct statsfs_source *src, *sub1, *sub11, *sub12;
+	uint64_t ret;
+	int n;
+
+	src = statsfs_source_create("parent");
+	sub1 = statsfs_source_create("child1");
+	sub11 = statsfs_source_create("child11");
+	sub12 = statsfs_source_create("child12");
+	statsfs_source_add_subordinate(src, sub1);
+	statsfs_source_add_subordinate(sub1, sub11);
+	statsfs_source_add_subordinate(sub1, sub12);
+
+	n = statsfs_source_add_values(sub11, test_all_aggr, &cont2);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub11, &cont2);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	n = statsfs_source_add_values(sub12, test_all_aggr, &cont);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub12, &cont);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	KUNIT_EXPECT_EQ(test, get_total_number_values(src), 0);
+
+	n = statsfs_source_add_values(src, test_all_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(src, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	n = statsfs_source_add_values(sub1, test_all_aggr, NULL);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	n = get_number_aggr_with_base(sub1, NULL);
+	KUNIT_EXPECT_EQ(test, n, ARR_SIZE(test_all_aggr));
+
+	// sum
+	n = statsfs_source_get_value_by_name(src, "u64", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, def_u64 * 2);
+
+	// min
+	n = statsfs_source_get_value_by_name(src, "s32", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ((int32_t)ret), def_val_s32);
+
+	// count_0
+	n = statsfs_source_get_value_by_name(src, "bo", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, ret, 1ull);
+
+	// avg
+	n = statsfs_source_get_value_by_name(src, "u8", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (uint8_t)ret,
+			(uint8_t)((def_val2_u8 + def_val_u8) / 2));
+
+	// max
+	n = statsfs_source_get_value_by_name(src, "s16", &ret);
+	KUNIT_EXPECT_EQ(test, n, 0);
+	KUNIT_EXPECT_EQ(test, (int16_t)ret, def_val_s16);
+
+	statsfs_source_put(src);
+}
+
+static struct kunit_case statsfs_test_cases[] = {
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
+static struct kunit_suite statsfs_test_suite = {
+	.name = "statsfs",
+	.test_cases = statsfs_test_cases,
+};
+
+kunit_test_suite(statsfs_test_suite);
-- 
2.25.2

