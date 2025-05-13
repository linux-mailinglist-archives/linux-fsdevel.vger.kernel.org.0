Return-Path: <linux-fsdevel+bounces-48876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA1AAB528D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C155198515C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4752949FE;
	Tue, 13 May 2025 10:08:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CC528BA86;
	Tue, 13 May 2025 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130898; cv=none; b=INAhoK6RXEuh79uGpqtxhCG//4RGc6XkGGLqMIzihosPLjSz03pOyvfdZIW4YrtQO31LdiycpSgLCi2xG+pCD37Nfr7hlqrt54Mx5qrTYPA1GLrpljmyHTDIzWZ4HQAL6gq35DYQEJtG00tdjMpON6Co16SZZNIo0JjjvhgXyeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130898; c=relaxed/simple;
	bh=s958f0RG0z2GBnnNwp7CQVbHsfxq66tZewU+8+MIME8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=G3hq6IS3ECkIjabM/XOuf504U2eMYh593okw/7C6ZHJbBRa8u6sMGmJZdq7jHrOe2e8vA+2iZg5+lrS2lOqvX6bE3dDQpsoPGZLKzscNc30mVqUgn4t1qj77RxxKB8XPGCIkjTOZtfpNUXFJvbkdlht+0MbkV+AnWlaftQm02eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-5e-682319f38f86
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yskelg@gmail.com,
	yunseong.kim@ericsson.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com
Subject: [PATCH v15 42/43] dept: implement a basic unit test for dept
Date: Tue, 13 May 2025 19:07:29 +0900
Message-Id: <20250513100730.12664-43-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/x46zn2P8PMzDmbWFFLHP8jAzD7+ZPIz5gxlHv7mbLrke
	FLPd6UouJVk1eboru1pd5PIQuiQ60kr0nAqNSKUpd+tUuKv557PX3p/35/3+58MSsgpqFqsK
	jRA1oYoQOS0hJX2TTEsHZy5U+mXqvMHxK4GEa3csNNTezkdguafD0F2xBZqcvQiGq98QkJFW
	i8D0qZ2Ae/YOBLbcszTUfZ4M9Y5+GirTEmmIzb5Dw9ueEQxt6akY8q1B8MHcRUJVShaGjG4a
	rmbEYvf4hsFlzmPArF0EnbmZDIx88ofKjkYKbK2L4cqNNhpKbJUk2Is7MdQ9vkZDh+UvBVX2
	VyQ4k2dD7aUkCgp+ZNHQ4zQTYHb0M/CuzIjBbpwOhXp3YPzgHwpeJpVhiL91F0N9yxMEpQkf
	MVgtjTQ8d/RiKLKmEfA7pwJBZ3IfA3EXXAxc1SUjSIxLJ0HfthKGh9zN13/5g+5mIQkFo41o
	/VrBcsOChOe9/YSgLzop/HY00ILNaSSF11m88CiznRH0pa2MYLRGCkW5PkJ2STcWTAMOSrDm
	nacF60AqIxj66rHwo6aG2Tlnn2RNsBiiihI1y9Ydkii/Zptw2M/N0U1fLjBaZFptQCzLcwH8
	g/glBuQ1hp32QuRhmvPmm5tdhIencfP5oqQuyoAkLME1TuSbrrcgz+1UbhP/rfi0x0Nyi/hz
	scOkh6XcKt5lN9DjmfP4/MKysRwvtz6aUzPmkXEr+RRjPjnuuezFn29dM84z+We5zWQKkhrR
	hDwkU4VGqRWqkABfZUyoKtr3yHG1Fbmfy3xmZH8xGqjdXY44FsknSV91L1DKKEVUeIy6HPEs
	IZ8m1T10S9JgRcwpUXP8oCYyRAwvR7NZUj5Dutx5MljGHVVEiMdEMUzU/N9i1muWFm03O05X
	ldweqj5TP0rsG9Srn2ovlnjviva9e27PksOfL7WceEEc7fWPDlwx1FB238d7w/wXXffnlp5I
	bT84URE/A+ms2+Kyb0llgWqjX8KBFUwkVZDzMKIpKJ3yw9UN3wPFmyZJD6ENWhWQvPFR3t6d
	g1vfT0mcvtXmetm+I+jQ9vVyMlyp8PchNOGKf/fDXXFYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yScRSH/b93KOidWb3lutF1tS62rLN1/WK+a2V+616yegumUgM1sdo0
	rczSUZvZRQ20kQkWYVtU4pwuylhmoXiZWlJZTNNlQnmhwlpfzp79zrPf+XIYPPQuOYNRqpIE
	tUqeIKPEhDhmXeay79PnKVb2uqXgG8omoPC+mYLGeyYE5ocZGHifRUOLvw/B6KvXOBTkNyIw
	dHfi8NDRhcBedoYC10cpNPkGKKjPv0hBZul9Ct70jmHQcfUKBibrdnhn7CHAqSvBoMBLwc2C
	TCw4vmAwbCynwZi+ADxlN2gY646A+i43CXVF9STY25fC9eIOCqrs9QQ4bB4MXE8KKegy/ybB
	6XhBgD8vHBov55JQ0V9CQa/fiIPRN0DD2xo9Bg79VLBkBVvPff9FwvPcGgzO3X6AQVPbUwTV
	2e8xsJrdFNT5+jCotObjMHLnGQJP3lcazl4apuFmRh6Ci2evEpDVEQmjP4OXi4YiIOOWhYCK
	gBtt3sibi82Ir+sbwPmsyhP8iK+Z4u1+PcG/LOH4xzc6aT6rup3m9dZkvrJsCV9a5cV4w6CP
	5K3lFyjeOniF5nO+NmF8f0MDHTtzj3j9YSFBmSKoV2yMEys+lxqw49+2pLZ8ukSnI8O6HCRi
	OHY153FY0DhT7CKutXUYH+cwdg5XmdtD5iAxg7PuCVxLUVtQYpjJbBT3xXZy3CHYBdz5zFFi
	nCXsGm7YkUP965zNmSw1f3tEwTxwp+GvE8pGcjq9idAhsR6FlKMwpSolUa5MiFyuiVdoVcrU
	5YeOJVpR8IGMp8cu29CQK7oWsQySTZS88M5VhJLyFI02sRZxDC4Lk2Q8CkaSw3JtmqA+dlCd
	nCBoalE4Q8imSbbuFOJC2aPyJCFeEI4L6v9bjBHNSEcWbXVU1KTy2IBo9/7YkFXZuvZZaRXz
	1Rqvs+PINVvq3vCR5tbegFR10B+3I37t4p6FgeiQ7jSp1/mzUJe97cPRux7zNOeFna7FkpX4
	ppilVZ25tzyfB60bdsU0Ndv2iX5M7G+jkqIOSItN11I6l7UoFmkr8qecsocZ2FUuX3LaLhmh
	UcgjluBqjfwPYpXPqTwDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Implement CONFIG_DEPT_UNIT_TEST introducing a kernel module that runs
basic unit test for dept.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept_unit_test.h     |  67 +++++++++++
 kernel/dependency/Makefile         |   1 +
 kernel/dependency/dept.c           |  12 ++
 kernel/dependency/dept_unit_test.c | 173 +++++++++++++++++++++++++++++
 lib/Kconfig.debug                  |  12 ++
 5 files changed, 265 insertions(+)
 create mode 100644 include/linux/dept_unit_test.h
 create mode 100644 kernel/dependency/dept_unit_test.c

diff --git a/include/linux/dept_unit_test.h b/include/linux/dept_unit_test.h
new file mode 100644
index 000000000000..51660f534104
--- /dev/null
+++ b/include/linux/dept_unit_test.h
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DEPT unit test
+ *
+ * Copyright (C) SK hynix, 2025
+ *
+ * Authors: Byungchul Park <max.byungchul.park@gmail.com>
+ */
+
+#ifndef __LINUX_DEPT_UNIT_TEST_H
+#define __LINUX_DEPT_UNIT_TEST_H
+
+#if defined(CONFIG_DEPT_UNIT_TEST) || defined(CONFIG_DEPT_UNIT_TEST_MODULE)
+struct dept_ut {
+	bool circle_detected;
+	bool recover_circle_detected;
+
+	int ecxt_stack_total_cnt;
+	int wait_stack_total_cnt;
+	int evnt_stack_total_cnt;
+	int ecxt_stack_valid_cnt;
+	int wait_stack_valid_cnt;
+	int evnt_stack_valid_cnt;
+};
+
+extern struct dept_ut dept_ut_results;
+
+static inline void dept_ut_circle_detect(void)
+{
+	dept_ut_results.circle_detected = true;
+}
+static inline void dept_ut_recover_circle_detect(void)
+{
+	dept_ut_results.recover_circle_detected = true;
+}
+static inline void dept_ut_ecxt_stack_account(bool valid)
+{
+	dept_ut_results.ecxt_stack_total_cnt++;
+
+	if (valid)
+		dept_ut_results.ecxt_stack_valid_cnt++;
+}
+static inline void dept_ut_wait_stack_account(bool valid)
+{
+	dept_ut_results.wait_stack_total_cnt++;
+
+	if (valid)
+		dept_ut_results.wait_stack_valid_cnt++;
+}
+static inline void dept_ut_evnt_stack_account(bool valid)
+{
+	dept_ut_results.evnt_stack_total_cnt++;
+
+	if (valid)
+		dept_ut_results.evnt_stack_valid_cnt++;
+}
+#else
+struct dept_ut {};
+
+#define dept_ut_circle_detect() do { } while (0)
+#define dept_ut_recover_circle_detect() do { } while (0)
+#define dept_ut_ecxt_stack_account(v) do { } while (0)
+#define dept_ut_wait_stack_account(v) do { } while (0)
+#define dept_ut_evnt_stack_account(v) do { } while (0)
+
+#endif
+#endif /* __LINUX_DEPT_UNIT_TEST_H */
diff --git a/kernel/dependency/Makefile b/kernel/dependency/Makefile
index 92f165400187..fc584ca87124 100644
--- a/kernel/dependency/Makefile
+++ b/kernel/dependency/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_DEPT) += dept.o
 obj-$(CONFIG_DEPT) += dept_proc.o
+obj-$(CONFIG_DEPT_UNIT_TEST) += dept_unit_test.o
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 03d6c057cdc5..50ba3e1c3fd5 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -77,8 +77,12 @@
 #include <linux/workqueue.h>
 #include <linux/irq_work.h>
 #include <linux/vmalloc.h>
+#include <linux/dept_unit_test.h>
 #include "dept_internal.h"
 
+struct dept_ut dept_ut_results;
+EXPORT_SYMBOL_GPL(dept_ut_results);
+
 static int dept_stop;
 static int dept_per_cpu_ready;
 
@@ -826,6 +830,10 @@ static void print_dep(struct dept_dep *d)
 			pr_warn("(wait to wake up)\n");
 			print_ip_stack(0, e->ewait_stack);
 		}
+
+		dept_ut_ecxt_stack_account(valid_stack(e->ecxt_stack));
+		dept_ut_wait_stack_account(valid_stack(w->wait_stack));
+		dept_ut_evnt_stack_account(valid_stack(e->event_stack));
 	}
 }
 
@@ -926,6 +934,8 @@ static void print_circle(struct dept_class *c)
 		tc = fc;
 		fc = fc->bfs_parent;
 	} while (tc != c);
+
+	dept_ut_circle_detect();
 }
 
 /*
@@ -1027,6 +1037,8 @@ static void print_recover_circle(struct dept_event_site *es)
 	dump_stack();
 
 	dept_outworld_exit();
+
+	dept_ut_recover_circle_detect();
 }
 
 static void bfs_init_recover(void *node, void *in, void **out)
diff --git a/kernel/dependency/dept_unit_test.c b/kernel/dependency/dept_unit_test.c
new file mode 100644
index 000000000000..489a7870f2c4
--- /dev/null
+++ b/kernel/dependency/dept_unit_test.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DEPT unit test
+ *
+ * Copyright (C) SK hynix, 2025
+ *
+ * Authors: Byungchul Park <max.byungchul.park@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/dept.h>
+#include <linux/dept_unit_test.h>
+
+MODULE_DESCRIPTION("DEPT unit test");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Byungchul Park <max.byungchul.park@sk.com>");
+
+struct unit {
+	const char *name;
+	bool (*func)(void);
+	bool result;
+};
+
+static DEFINE_SPINLOCK(s1);
+static DEFINE_SPINLOCK(s2);
+static bool test_spin_lock_deadlock(void)
+{
+	dept_ut_results.circle_detected = false;
+
+	spin_lock(&s1);
+	spin_lock(&s2);
+	spin_unlock(&s2);
+	spin_unlock(&s1);
+
+	spin_lock(&s2);
+	spin_lock(&s1);
+	spin_unlock(&s1);
+	spin_unlock(&s2);
+
+	return dept_ut_results.circle_detected;
+}
+
+static DEFINE_MUTEX(m1);
+static DEFINE_MUTEX(m2);
+static bool test_mutex_lock_deadlock(void)
+{
+	dept_ut_results.circle_detected = false;
+
+	mutex_lock(&m1);
+	mutex_lock(&m2);
+	mutex_unlock(&m2);
+	mutex_unlock(&m1);
+
+	mutex_lock(&m2);
+	mutex_lock(&m1);
+	mutex_unlock(&m1);
+	mutex_unlock(&m2);
+
+	return dept_ut_results.circle_detected;
+}
+
+static bool test_wait_event_deadlock(void)
+{
+	struct dept_map dmap1;
+	struct dept_map dmap2;
+
+	sdt_map_init(&dmap1);
+	sdt_map_init(&dmap2);
+
+	dept_ut_results.circle_detected = false;
+
+	sdt_request_event(&dmap1); /* [S] */
+	sdt_wait(&dmap2); /* [W] */
+	sdt_event(&dmap1); /* [E] */
+
+	sdt_request_event(&dmap2); /* [S] */
+	sdt_wait(&dmap1); /* [W] */
+	sdt_event(&dmap2); /* [E] */
+
+	return dept_ut_results.circle_detected;
+}
+
+static void dummy_event(void)
+{
+	/* Do nothing. */
+}
+
+static DEFINE_DEPT_EVENT_SITE(es1);
+static DEFINE_DEPT_EVENT_SITE(es2);
+static bool test_recover_deadlock(void)
+{
+	dept_ut_results.recover_circle_detected = false;
+
+	dept_recover_event(&es1, &es2);
+	dept_recover_event(&es2, &es1);
+
+	event_site(&es1, dummy_event);
+	event_site(&es2, dummy_event);
+
+	return dept_ut_results.recover_circle_detected;
+}
+
+static struct unit units[] = {
+	{
+		.name = "spin lock deadlock test",
+		.func = test_spin_lock_deadlock,
+	},
+	{
+		.name = "mutex lock deadlock test",
+		.func = test_mutex_lock_deadlock,
+	},
+	{
+		.name = "wait event deadlock test",
+		.func = test_wait_event_deadlock,
+	},
+	{
+		.name = "event recover deadlock test",
+		.func = test_recover_deadlock,
+	},
+};
+
+static int __init dept_ut_init(void)
+{
+	int i;
+
+	lockdep_off();
+
+	dept_ut_results.ecxt_stack_valid_cnt = 0;
+	dept_ut_results.ecxt_stack_total_cnt = 0;
+	dept_ut_results.wait_stack_valid_cnt = 0;
+	dept_ut_results.wait_stack_total_cnt = 0;
+	dept_ut_results.evnt_stack_valid_cnt = 0;
+	dept_ut_results.evnt_stack_total_cnt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(units); i++)
+		units[i].result = units[i].func();
+
+	pr_info("\n");
+	pr_info("******************************************\n");
+	pr_info("DEPT unit test results\n");
+	pr_info("******************************************\n");
+	for (i = 0; i < ARRAY_SIZE(units); i++) {
+		pr_info("(%s) %s\n", units[i].result ? "pass" : "fail",
+				units[i].name);
+	}
+	pr_info("ecxt stack valid count = %d/%d\n",
+			dept_ut_results.ecxt_stack_valid_cnt,
+			dept_ut_results.ecxt_stack_total_cnt);
+	pr_info("wait stack valid count = %d/%d\n",
+			dept_ut_results.wait_stack_valid_cnt,
+			dept_ut_results.wait_stack_total_cnt);
+	pr_info("event stack valid count = %d/%d\n",
+			dept_ut_results.evnt_stack_valid_cnt,
+			dept_ut_results.evnt_stack_total_cnt);
+	pr_info("******************************************\n");
+	pr_info("\n");
+
+	lockdep_on();
+
+	return 0;
+}
+
+static void dept_ut_cleanup(void)
+{
+	/*
+	 * Do nothing for now.
+	 */
+}
+
+module_init(dept_ut_init);
+module_exit(dept_ut_cleanup);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7c74f92e4cc2..65f867e35be8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1404,6 +1404,18 @@ config DEPT_AGGRESSIVE_TIMEOUT_WAIT
 	  that timeout is used to avoid a deadlock. Say N if you'd like
 	  to avoid verbose reports.
 
+config DEPT_UNIT_TEST
+	tristate "unit test for DEPT"
+	depends on DEBUG_KERNEL && DEPT
+	default n
+	help
+	  This option provides a kernel module that runs unit test for
+	  DEPT.
+
+	  Say Y if you want DEPT unit test to be built into the kernel.
+	  Say M if you want DEPT unit test to build as a module.
+	  Say N if you are unsure.
+
 config LOCK_DEBUGGING_SUPPORT
 	bool
 	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
-- 
2.17.1


