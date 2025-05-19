Return-Path: <linux-fsdevel+bounces-49382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF1BABB9A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33DB07AEECF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42060289E31;
	Mon, 19 May 2025 09:19:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620F1283FE4;
	Mon, 19 May 2025 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646350; cv=none; b=EChS7saL2CIsQKEQRZ4sYir1gpyrNO//4SQlBmYp3VBk8TJnHrhr3UqbUW5KVm753+EP/HHJKVvqWLz84NeHoW49AsfxQKF4uo4xP9m4pg7n3z+eZvRLw9Ueb29N3YoYTQWrojzQ/RBKaWvfMH7Nb7DM1oHl69NE2CPGRh6q0Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646350; c=relaxed/simple;
	bh=4S0kmmxNZl18R3dkj2pAd/m/S3hp3ORwuEcWWn/GYOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qynPph77LAml1ftCVTCEcgdGLPN8KJIkeUd8Q07oN2XI0RC3j2hLiFfWKMkA0SEps6XULKZoqGu4azTNQSbIjRks3G6j53t7zmmoHGGnD5DzGkfA2MCCyUcLbyOLGzBCua6S/M6fC2ZjXPyo1uXs9p7ivDiZR3euJWxm3ia5U0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-54-682af77101aa
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
Subject: [PATCH v16 41/42] dept: implement a basic unit test for dept
Date: Mon, 19 May 2025 18:18:25 +0900
Message-Id: <20250519091826.19752-42-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSeUiTcRzG+/3e09XqZV1vGRWDLrs0Or6d2P0WCEFEdNFWvrShLptpGQme
	YbMNs3QdZstirbnK3vVHpgtzzLLIrGwe6TKpSLzI2sqyYxr98+XheXg+338ellA8oiayWt1h
	Ua9TxyppGSnrHlE899C3ME142ePZ4P+aTULhbQcNdbdKEDjupmHo8GyEhkAXgp/PnhNgzq9D
	cOVdKwF3q30IXLZ0Gl69Hwn1/l4aavJzaMi4epuGF50DGFoK8jCUSFHw1vqRhKe5xRjMHTRc
	NGfg4PmEod9qZ8CaOg3abRcYGHgXATU+LwWu5tlwvqiFhgpXDQnV99oxvLpfSIPP8YeCp9WP
	SQiYQqHutJGCmz3FNHQGrARY/b0MvKy0YKi2jIPSzCDwxJffFDwyVmI4ce0OhvqmcgQPstsw
	SA4vDW5/FwanlE/Aj+seBO2mbgayTvUzcDHNhCAnq4CEzJZF8PN78POlrxGQdrmUhJu/vChy
	peAociDB3dVLCJnOI8IP/2tacAUspPCkmBfKLrQyQuaDZkawSImC0xYmXK3owMKVPj8lSPaT
	tCD15TGCobseCz21tcyWSTtlK6LFWG2SqJ+/SiXTGNoycPzZjUcDTiOVijzLDSiE5bmFfLnp
	DPFff//iGNI0N4NvbOwf0mO4qbzT+JEyIBlLcN7hfMOlJjQYjObW81JZA2NALEty0/g2++pB
	W84t5m9531D/mFP4ktLKIU5I0G/OcQ9VFdwivr6kiBxk8pw5hDe1euh/hQn8Q1sjmYvkFjTM
	jhRaXVKcWhu7cJ4mWac9Om//wTgJBedlTRnYdQ/11W2tQhyLlCPkpa5ZGgWlTkpIjqtCPEso
	x8jtzpkahTxanXxM1B/cq0+MFROqUChLKsfLFwSORCu4A+rDYowoxov6/ylmQyamoqzVk9fE
	fJiQXTCqJzG30Bd56Np2lW/6wFjP4vRNrTLtUpVZ9p5bVrE2fMON/VpWA0xPJ/N5j8RVhNb8
	On4jsq17n5iWcqz8uG73zvPjw4uww7QuMOP3uZTceHrOjgxDumrb8iXuvKxhtoh1qn29bqSe
	FFMbtWmznDd+jmpvWv9SSSZo1BFhhD5B/Rd3CCqzWgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfX/PHcdvp/FbabjNJPPQJj6Tp/6wfvO8GYYNt/zmjrq401W2
	pvSwuuqWh0TqOsWV6yJ32UJn53JHmkS5kko1okkZ3RGRK/PPe++93/u83v98GFxygwxgFMqT
	gkopi5ZSIkK0LTx1yYnvIfLl7WX+4BnJJKDolpmC5puVCMw1KRgMOCOhzTuI4Nez5zgU5Dcj
	uNrbhUONqxuBreIMBS3vpkOrZ5iChvxsClLLblHw4tMYBp0Xz2FQadkKb439BDTmlWJQMEDB
	lYJUzCcfMRg1mmgwJi+AvopCGsZ6Q6Gh201CfXEDCbaOxXBZ30lBna2BAFdtHwYt94oo6DaP
	k9DoekKAVxcIzWdzSagaKqXgk9eIg9EzTMNLuwEDl2EWVKf5qBnf/pDwONeOQca12xi0vr6P
	4EFmDwYWs5uCes8gBlZLPg4/y50I+nSfaUjPGaXhSooOQXb6RQLSOsPg1w/fcvFIKKSUVBNQ
	9duNNqzjzXoz4usHh3E+zRrP//S8onib10DwT0s5/m5hF82nPeigeYMljrdWhPBldQMYf/Wr
	h+QtpiyKt3w9R/Paz60YP9TURO8I2idac1iIVmgE1bJ1h0RybU8qdvxCZILXmksmI2e4Fvkx
	HLuC+/HNjE94il3ItbePTnp/dh5nze0ntUjE4Kx7KtdW/BpNFDPZjZzlbhutRQxDsAu4HlPE
	RCxmV3I33W/If8y5XGW1fZLj58s7susnTyVsGNdaqSfykMiAppiQv0KpiZEposOWqo/JE5WK
	hKVRsTEW5HsgY9LY2Vo00hLpQCyDpNPE1bZFcgkp06gTYxyIY3Cpv9hkDZZLxIdliacEVexB
	VVy0oHagQIaQzhZv2iMckrBHZCeFY4JwXFD9bzHGLyAZlfyeE9NlNiXMd2jWF735Mjvq+tic
	V0XSvfPJ3rWbL+k+DHX2z9j+4f3eoMZZ9w8UxqcEr76dszPPXvxwl/784qPx2xWu2NVRdUJm
	lpXT6cuDRp6XSac9YpSag/vD28dPl2RVRbSUrsFzHjubIvt3X7I7k+JWOe5s3SP+8vDMM2/W
	lkApoZbLQkNwlVr2F1s4Efg8AwAA
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
index 000000000000..7612b4e97e69
--- /dev/null
+++ b/include/linux/dept_unit_test.h
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DEPT unit test
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2025 SK hynix, Inc., Byungchul Park
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
index c65bb0c6dad2..a08d0e16978b 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -78,8 +78,12 @@
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
 
@@ -920,6 +928,8 @@ static void print_circle(struct dept_class *c)
 	dump_stack();
 
 	dept_outworld_exit();
+
+	dept_ut_circle_detect();
 }
 
 /*
@@ -1021,6 +1031,8 @@ static void print_recover_circle(struct dept_event_site *es)
 	dump_stack();
 
 	dept_outworld_exit();
+
+	dept_ut_recover_circle_detect();
 }
 
 static void bfs_init_recover(void *node, void *in, void **out)
diff --git a/kernel/dependency/dept_unit_test.c b/kernel/dependency/dept_unit_test.c
new file mode 100644
index 000000000000..88e846b9f876
--- /dev/null
+++ b/kernel/dependency/dept_unit_test.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DEPT unit test
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2025 SK hynix, Inc., Byungchul Park
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
index ec840c672846..8db2a8136418 100644
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


