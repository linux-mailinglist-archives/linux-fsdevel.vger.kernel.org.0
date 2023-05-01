Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B87E6F3406
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 18:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjEAQ4p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 12:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjEAQ4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 12:56:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A74C1FD8
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:55:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a8023ccf1so5355337276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960124; x=1685552124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O9K7OqGn67XevhyLqxW8/t3YPJ+QYtYh9lmzl+bkJrg=;
        b=uyQWn2HtrGHHQPYjCaEXS71WFvIKKSc7//EwH6w5zT7RuLTJsJvg4Siy51jlaOTMsf
         DmzxgGzQqK6buMAxRdIZF5co25tsVldyDbaF7rOabJEbLpi4XheA+l5VWP2IJDBlEIui
         J3jFl+rVymLiKhaaXfPqFSO8pBqa31LbX5CWrS5Wner2pA7Sqr1hkvfcI6t4MxiQZt9K
         qhkEpMVbiHPNZp9IQ6O2D9+a8gKMVQ/1Gtf9GajnR6izUu8XnftHHBs+v4IcA0SDdYNk
         NO/g09kaGZENLPill52iLrjrZMs4uUM92aRcipfW+xL+/5JdYb7kKitjTzDH4s2JKlli
         slTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960124; x=1685552124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9K7OqGn67XevhyLqxW8/t3YPJ+QYtYh9lmzl+bkJrg=;
        b=OFzmLw4rsM3ahxttJuqT+PatXDOZYbCKhRWHO2MRsNX3F2UeGOgRxFYt8sYVy9ATXz
         L8Xthczl4gONlGrVhKqlnfefPZDQX/qACc/7VEvTDCgqIqo4Ntpyrt3onZjzmqauat9A
         OUkboD/Kbb7fWnbjMbvGc6/5FHNqJx8z9SRn/aJaCTITa3mDhvD8xd/lwSZXht7gdzFo
         E6FAO8pd2J84Yxeo9//RHIR9AV1Mzxw2syyF1mbkA8EjHOWB9rBfopP5EnyXqiFKT84b
         RXcylKPSiZlcufjldp7kxqlae7RclxpJ+DDubm7mLteQGHsFqV9Bs9eyw59aPVuUEj19
         AqjA==
X-Gm-Message-State: AC+VfDzex7+FkYpvODfowBRKA7cdcNdl9+cjBSzkU1YXSLiwbwq3VETG
        1RIMh96+q8Lxx3kjgYYdpzmM8ZJwaGE=
X-Google-Smtp-Source: ACHHUZ6licAmCYMGFmFEgxRhjJBE3vK82JOqHF+xQXe/hB6jcq2RRjEzB8Dg4J2EO+jXUyt83MZ91zsgyn0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a05:6902:100e:b0:b8f:47c4:58ed with SMTP id
 w14-20020a056902100e00b00b8f47c458edmr8682966ybt.9.1682960124020; Mon, 01 May
 2023 09:55:24 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:17 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-8-surenb@google.com>
Subject: [PATCH 07/40] Lazy percpu counters
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@linux.dev>

This patch adds lib/lazy-percpu-counter.c, which implements counters
that start out as atomics, but lazily switch to percpu mode if the
update rate crosses some threshold (arbitrarily set at 256 per second).

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/lazy-percpu-counter.h | 102 ++++++++++++++++++++++
 lib/Kconfig                         |   3 +
 lib/Makefile                        |   2 +
 lib/lazy-percpu-counter.c           | 127 ++++++++++++++++++++++++++++
 4 files changed, 234 insertions(+)
 create mode 100644 include/linux/lazy-percpu-counter.h
 create mode 100644 lib/lazy-percpu-counter.c

diff --git a/include/linux/lazy-percpu-counter.h b/include/linux/lazy-percpu-counter.h
new file mode 100644
index 000000000000..45ca9e2ce58b
--- /dev/null
+++ b/include/linux/lazy-percpu-counter.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lazy percpu counters:
+ * (C) 2022 Kent Overstreet
+ *
+ * Lazy percpu counters start out in atomic mode, then switch to percpu mode if
+ * the update rate crosses some threshold.
+ *
+ * This means we don't have to decide between low memory overhead atomic
+ * counters and higher performance percpu counters - we can have our cake and
+ * eat it, too!
+ *
+ * Internally we use an atomic64_t, where the low bit indicates whether we're in
+ * percpu mode, and the high 8 bits are a secondary counter that's incremented
+ * when the counter is modified - meaning 55 bits of precision are available for
+ * the counter itself.
+ */
+
+#ifndef _LINUX_LAZY_PERCPU_COUNTER_H
+#define _LINUX_LAZY_PERCPU_COUNTER_H
+
+#include <linux/atomic.h>
+#include <asm/percpu.h>
+
+struct lazy_percpu_counter {
+	atomic64_t			v;
+	unsigned long			last_wrap;
+};
+
+void lazy_percpu_counter_exit(struct lazy_percpu_counter *c);
+void lazy_percpu_counter_add_slowpath(struct lazy_percpu_counter *c, s64 i);
+void lazy_percpu_counter_add_slowpath_noupgrade(struct lazy_percpu_counter *c, s64 i);
+s64 lazy_percpu_counter_read(struct lazy_percpu_counter *c);
+
+/*
+ * We use the high bits of the atomic counter for a secondary counter, which is
+ * incremented every time the counter is touched. When the secondary counter
+ * wraps, we check the time the counter last wrapped, and if it was recent
+ * enough that means the update frequency has crossed our threshold and we
+ * switch to percpu mode:
+ */
+#define COUNTER_MOD_BITS		8
+#define COUNTER_MOD_MASK		~(~0ULL >> COUNTER_MOD_BITS)
+#define COUNTER_MOD_BITS_START		(64 - COUNTER_MOD_BITS)
+
+/*
+ * We use the low bit of the counter to indicate whether we're in atomic mode
+ * (low bit clear), or percpu mode (low bit set, counter is a pointer to actual
+ * percpu counters:
+ */
+#define COUNTER_IS_PCPU_BIT		1
+
+static inline u64 __percpu *lazy_percpu_counter_is_pcpu(u64 v)
+{
+	if (!(v & COUNTER_IS_PCPU_BIT))
+		return NULL;
+
+	v ^= COUNTER_IS_PCPU_BIT;
+	return (u64 __percpu *)(unsigned long)v;
+}
+
+/**
+ * lazy_percpu_counter_add: Add a value to a lazy_percpu_counter
+ *
+ * @c: counter to modify
+ * @i: value to add
+ */
+static inline void lazy_percpu_counter_add(struct lazy_percpu_counter *c, s64 i)
+{
+	u64 v = atomic64_read(&c->v);
+	u64 __percpu *pcpu_v = lazy_percpu_counter_is_pcpu(v);
+
+	if (likely(pcpu_v))
+		this_cpu_add(*pcpu_v, i);
+	else
+		lazy_percpu_counter_add_slowpath(c, i);
+}
+
+/**
+ * lazy_percpu_counter_add_noupgrade: Add a value to a lazy_percpu_counter,
+ * without upgrading to percpu mode
+ *
+ * @c: counter to modify
+ * @i: value to add
+ */
+static inline void lazy_percpu_counter_add_noupgrade(struct lazy_percpu_counter *c, s64 i)
+{
+	u64 v = atomic64_read(&c->v);
+	u64 __percpu *pcpu_v = lazy_percpu_counter_is_pcpu(v);
+
+	if (likely(pcpu_v))
+		this_cpu_add(*pcpu_v, i);
+	else
+		lazy_percpu_counter_add_slowpath_noupgrade(c, i);
+}
+
+static inline void lazy_percpu_counter_sub(struct lazy_percpu_counter *c, s64 i)
+{
+	lazy_percpu_counter_add(c, -i);
+}
+
+#endif /* _LINUX_LAZY_PERCPU_COUNTER_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 5c2da561c516..7380292a8fcd 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -505,6 +505,9 @@ config ASSOCIATIVE_ARRAY
 
 	  for more information.
 
+config LAZY_PERCPU_COUNTER
+	bool
+
 config HAS_IOMEM
 	bool
 	depends on !NO_IOMEM
diff --git a/lib/Makefile b/lib/Makefile
index 876fcdeae34e..293a0858a3f8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -164,6 +164,8 @@ obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 obj-$(CONFIG_DEBUG_LIST) += list_debug.o
 obj-$(CONFIG_DEBUG_OBJECTS) += debugobjects.o
 
+obj-$(CONFIG_LAZY_PERCPU_COUNTER) += lazy-percpu-counter.o
+
 obj-$(CONFIG_BITREVERSE) += bitrev.o
 obj-$(CONFIG_LINEAR_RANGES) += linear_ranges.o
 obj-$(CONFIG_PACKING)	+= packing.o
diff --git a/lib/lazy-percpu-counter.c b/lib/lazy-percpu-counter.c
new file mode 100644
index 000000000000..4f4e32c2dc09
--- /dev/null
+++ b/lib/lazy-percpu-counter.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/atomic.h>
+#include <linux/gfp.h>
+#include <linux/jiffies.h>
+#include <linux/lazy-percpu-counter.h>
+#include <linux/percpu.h>
+
+static inline s64 lazy_percpu_counter_atomic_val(s64 v)
+{
+	/* Ensure output is sign extended properly: */
+	return (v << COUNTER_MOD_BITS) >>
+		(COUNTER_MOD_BITS + COUNTER_IS_PCPU_BIT);
+}
+
+static void lazy_percpu_counter_switch_to_pcpu(struct lazy_percpu_counter *c)
+{
+	u64 __percpu *pcpu_v = alloc_percpu_gfp(u64, GFP_ATOMIC|__GFP_NOWARN);
+	u64 old, new, v;
+
+	if (!pcpu_v)
+		return;
+
+	preempt_disable();
+	v = atomic64_read(&c->v);
+	do {
+		if (lazy_percpu_counter_is_pcpu(v)) {
+			free_percpu(pcpu_v);
+			return;
+		}
+
+		old = v;
+		new = (unsigned long)pcpu_v | 1;
+
+		*this_cpu_ptr(pcpu_v) = lazy_percpu_counter_atomic_val(v);
+	} while ((v = atomic64_cmpxchg(&c->v, old, new)) != old);
+	preempt_enable();
+}
+
+/**
+ * lazy_percpu_counter_exit: Free resources associated with a
+ * lazy_percpu_counter
+ *
+ * @c: counter to exit
+ */
+void lazy_percpu_counter_exit(struct lazy_percpu_counter *c)
+{
+	free_percpu(lazy_percpu_counter_is_pcpu(atomic64_read(&c->v)));
+}
+EXPORT_SYMBOL_GPL(lazy_percpu_counter_exit);
+
+/**
+ * lazy_percpu_counter_read: Read current value of a lazy_percpu_counter
+ *
+ * @c: counter to read
+ */
+s64 lazy_percpu_counter_read(struct lazy_percpu_counter *c)
+{
+	s64 v = atomic64_read(&c->v);
+	u64 __percpu *pcpu_v = lazy_percpu_counter_is_pcpu(v);
+
+	if (pcpu_v) {
+		int cpu;
+
+		v = 0;
+		for_each_possible_cpu(cpu)
+			v += *per_cpu_ptr(pcpu_v, cpu);
+	} else {
+		v = lazy_percpu_counter_atomic_val(v);
+	}
+
+	return v;
+}
+EXPORT_SYMBOL_GPL(lazy_percpu_counter_read);
+
+void lazy_percpu_counter_add_slowpath(struct lazy_percpu_counter *c, s64 i)
+{
+	u64 atomic_i;
+	u64 old, v = atomic64_read(&c->v);
+	u64 __percpu *pcpu_v;
+
+	atomic_i  = i << COUNTER_IS_PCPU_BIT;
+	atomic_i &= ~COUNTER_MOD_MASK;
+	atomic_i |= 1ULL << COUNTER_MOD_BITS_START;
+
+	do {
+		pcpu_v = lazy_percpu_counter_is_pcpu(v);
+		if (pcpu_v) {
+			this_cpu_add(*pcpu_v, i);
+			return;
+		}
+
+		old = v;
+	} while ((v = atomic64_cmpxchg(&c->v, old, old + atomic_i)) != old);
+
+	if (unlikely(!(v & COUNTER_MOD_MASK))) {
+		unsigned long now = jiffies;
+
+		if (c->last_wrap &&
+		    unlikely(time_after(c->last_wrap + HZ, now)))
+			lazy_percpu_counter_switch_to_pcpu(c);
+		else
+			c->last_wrap = now;
+	}
+}
+EXPORT_SYMBOL(lazy_percpu_counter_add_slowpath);
+
+void lazy_percpu_counter_add_slowpath_noupgrade(struct lazy_percpu_counter *c, s64 i)
+{
+	u64 atomic_i;
+	u64 old, v = atomic64_read(&c->v);
+	u64 __percpu *pcpu_v;
+
+	atomic_i  = i << COUNTER_IS_PCPU_BIT;
+	atomic_i &= ~COUNTER_MOD_MASK;
+
+	do {
+		pcpu_v = lazy_percpu_counter_is_pcpu(v);
+		if (pcpu_v) {
+			this_cpu_add(*pcpu_v, i);
+			return;
+		}
+
+		old = v;
+	} while ((v = atomic64_cmpxchg(&c->v, old, old + atomic_i)) != old);
+}
+EXPORT_SYMBOL(lazy_percpu_counter_add_slowpath_noupgrade);
-- 
2.40.1.495.gc816e09b53d-goog

