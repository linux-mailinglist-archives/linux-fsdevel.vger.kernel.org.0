Return-Path: <linux-fsdevel+bounces-50167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C96AC8ABC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873813BE5B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A0221F30;
	Fri, 30 May 2025 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HZy7M2u+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A18721E0AA
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597339; cv=none; b=UM5MGuOStr1k7PUU+Mh21maRR/O6n9vn2YxEvG0+xn5EPQWL0uy8LOjYBlcUMgVsG50C//KryTttiFLomUyf+OWOzkopifF4DT9cV6ccjZqstlbFJ3wZG3cwCuAl8jF5w21EjS9Rn1fyocmge4PhwwMnrCIave1q9436wxP+6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597339; c=relaxed/simple;
	bh=Vc7NbMjHAO2dZd+RVkA7mhRl8eTmZhbc/UEd+aji6oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=taRaqeYszlQhGZE3TLY0u4MzWsezlGOPSQfiammPK6QtIyXvolAc4jLjlvCtYUX9SRtdaHOOuX9bnJFUUSClA0W0G+eFSP5hTzMbRGACuJWJucFR2ViHaShdRVunE8WMCfK36eswiWmnPD3esqkVJqOC8qOvhx8dAtVGNKooFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HZy7M2u+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-311ef4fb549so1553682a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597337; x=1749202137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHtdmIKid/axHIhLP0cCYOHEJ6hr+IyJWWADeBRNQ/E=;
        b=HZy7M2u+7GpR0jjgD3VvbuWXLAZzxDhZ8MFb1aLnTzO/OdeLksVR4Sp4RcuDwi1+uV
         J8ZKCyEPW6zPmzQtYc0CBUyZG41mWqwWNMPcjBinHleStwkLACO2cXrXusHc5q4kwBQD
         wciRQn7IEeNK+1xJkLX/PTIq3NVK4yOddbKkR/kw+Hx7gbzEo0rEe6+tNOidiU1DmfkK
         xAw2isnYIzbo4J1ZCCK2TBSLIdiwDXTDjTE+ZN7fGPKU6yqNek+wg51KzWEdfn6xY9hh
         gNqWdIXaNdt5XXNDbtOGrJJe8yWtI/eqFBNTr3/MKjcJdUrn8ErZbH9hCYgQm8wQCh6t
         W3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597337; x=1749202137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHtdmIKid/axHIhLP0cCYOHEJ6hr+IyJWWADeBRNQ/E=;
        b=Jo/dOlYC7mULFAQ7kGuZsCk39SgoeYBC0quMtrTrRu49qPZjv/szyUHkgalC5PsgBn
         QwCnRNh5o06hSTSyge2cFOkuZf7t4UCvc9rS1+VmfzLkhycOQ7fGEszZfcoG6beibNks
         hjThWOvWolqeRyADW12rm/MV6XoSAZF7tlmdDDtJFLllkRUIGAev805ICXFnrwIDVTC6
         Bjf5cDxAVP3pu6DVqDTDPdM1EvHvCDMglOdKc7Q3wMrMV1UD3wgzx9+dWBh1IHdjgIMB
         spahMg9oRHNS+gyixRxawaJ0piVeqogveUTi3bgnr17dTew22rKuJNcaQ1F9bnmPIZ4n
         dY6w==
X-Forwarded-Encrypted: i=1; AJvYcCUVNR7NTlvxXvzVha7H0s9ZT7xqYhgMjdO2IscR/QNXBUWSnOZFkmj0ncbmQtXP+prRHIsF/F2AGrXmxZBt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp6gkVhqBufNfp6/JOnlypff2LBF/DwxvFMA/uxquoLNn+DHpj
	qGguCWDIA9G6iUXZLageLrWTcfflzdNVWY8yxV8ito4EmFn5jgHi/gp/N9AH84NTm3c=
X-Gm-Gg: ASbGncuRbwmJgsXfk97mbU8hqb/EZaEBfYdYS4pNWRDWaa8wuKdMgosXssJ+zEJd1D0
	YnSU9jq+Pg6tdmX8y+PNXFlPEqUv86FqBMUfGUeMX+AI0QUFDLbDzz7M9khZmwlqrLxWufk8A+s
	fZrqwGnt/7z/fc73xFCijpgbA6lw8mx1mtR6hxjh/1PhkGc+lrLhdp7YV/IgPRxC8/q5BRPE9ci
	JJX0RDTE4ZTYQ81FzrPeOd4DlZFWHHHdJ+yjNY4eGd/SDpY3V1c6McXJvb1XVesMjlT+90TdnX5
	QUptM74Ln6dhsOzSKhB6bjTNoD8+dUVmOzNuEv9tPoDswtg/wFKweaBJynUH4/S95iW0io7F9Av
	Gt/GXickmub5/RBTEz0f5
X-Google-Smtp-Source: AGHT+IF0jYnDB+2g7ZGuSYnYueYT47NoQiuIJK3WP4+gDWcAJJRqzT7RDm6Iq/1/p9n6sv5YTlCMUg==
X-Received: by 2002:a17:90b:2f8c:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-31241735b7fmr4743727a91.17.1748597336731;
        Fri, 30 May 2025 02:28:56 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.28.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:28:56 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 02/35] RPAL: add struct rpal_service
Date: Fri, 30 May 2025 17:27:30 +0800
Message-Id: <58ca31eb0711ad773c19a167e6888173a64ff890.1748594840.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each process that uses RPAL features is called an RPAL service.

This patch adds the RPAL header file rpal.h and defines the rpal_service
structure. The struct rpal_service uses a dedicated kmem_cache for
allocation and deallocation, and atomic variables to maintain references
to the struct rpal_service. Additionally, the patch introduces the
rpal_get_service() and rpal_put_service() interfaces to manage reference
counts.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/Makefile   |  5 ++++
 arch/x86/rpal/core.c     | 32 +++++++++++++++++++++++
 arch/x86/rpal/internal.h | 13 ++++++++++
 arch/x86/rpal/service.c  | 56 ++++++++++++++++++++++++++++++++++++++++
 include/linux/rpal.h     | 43 ++++++++++++++++++++++++++++++
 5 files changed, 149 insertions(+)
 create mode 100644 arch/x86/rpal/core.c
 create mode 100644 arch/x86/rpal/internal.h
 create mode 100644 arch/x86/rpal/service.c
 create mode 100644 include/linux/rpal.h

diff --git a/arch/x86/rpal/Makefile b/arch/x86/rpal/Makefile
index e69de29bb2d1..ee3698b5a9b3 100644
--- a/arch/x86/rpal/Makefile
+++ b/arch/x86/rpal/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_RPAL)		+= rpal.o
+
+rpal-y := service.o core.o
diff --git a/arch/x86/rpal/core.c b/arch/x86/rpal/core.c
new file mode 100644
index 000000000000..495dbc1b1536
--- /dev/null
+++ b/arch/x86/rpal/core.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RPAL service level operations
+ * Copyright (c) 2025, ByteDance. All rights reserved.
+ *
+ *     Author: Jiadong Sun <sunjiadong.lff@bytedance.com>
+ */
+
+#include <linux/rpal.h>
+
+#include "internal.h"
+
+int __init rpal_init(void);
+
+bool rpal_inited;
+
+int __init rpal_init(void)
+{
+	int ret = 0;
+
+	ret = rpal_service_init();
+	if (ret)
+		goto fail;
+
+	rpal_inited = true;
+	return 0;
+
+fail:
+	rpal_err("rpal init fail\n");
+	return -1;
+}
+subsys_initcall(rpal_init);
diff --git a/arch/x86/rpal/internal.h b/arch/x86/rpal/internal.h
new file mode 100644
index 000000000000..e44e6fc79677
--- /dev/null
+++ b/arch/x86/rpal/internal.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RPAL service level operations
+ * Copyright (c) 2025, ByteDance. All rights reserved.
+ *
+ *     Author: Jiadong Sun <sunjiadong.lff@bytedance.com>
+ */
+
+extern bool rpal_inited;
+
+/* service.c */
+int __init rpal_service_init(void);
+void __init rpal_service_exit(void);
diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
new file mode 100644
index 000000000000..c8e609798d4f
--- /dev/null
+++ b/arch/x86/rpal/service.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RPAL service level operations
+ * Copyright (c) 2025, ByteDance. All rights reserved.
+ *
+ *     Author: Jiadong Sun <sunjiadong.lff@bytedance.com>
+ */
+
+#include <linux/rpal.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/task.h>
+#include <linux/slab.h>
+
+#include "internal.h"
+
+static struct kmem_cache *service_cache;
+
+static void __rpal_put_service(struct rpal_service *rs)
+{
+	kmem_cache_free(service_cache, rs);
+}
+
+struct rpal_service *rpal_get_service(struct rpal_service *rs)
+{
+	if (!rs)
+		return NULL;
+	atomic_inc(&rs->refcnt);
+	return rs;
+}
+
+void rpal_put_service(struct rpal_service *rs)
+{
+	if (!rs)
+		return;
+
+	if (atomic_dec_and_test(&rs->refcnt))
+		__rpal_put_service(rs);
+}
+
+int __init rpal_service_init(void)
+{
+	service_cache = kmem_cache_create("rpal_service_cache",
+					  sizeof(struct rpal_service), 0,
+					  SLAB_PANIC, NULL);
+	if (!service_cache) {
+		rpal_err("service init fail\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+void __init rpal_service_exit(void)
+{
+	kmem_cache_destroy(service_cache);
+}
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
new file mode 100644
index 000000000000..73468884cc5d
--- /dev/null
+++ b/include/linux/rpal.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RPAL service level operations
+ * Copyright (c) 2025, ByteDance. All rights reserved.
+ *
+ *     Author: Jiadong Sun <sunjiadong.lff@bytedance.com>
+ */
+
+#ifndef _LINUX_RPAL_H
+#define _LINUX_RPAL_H
+
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/atomic.h>
+
+#define RPAL_ERROR_MSG "rpal error: "
+#define rpal_err(x...) pr_err(RPAL_ERROR_MSG x)
+#define rpal_err_ratelimited(x...) pr_err_ratelimited(RPAL_ERROR_MSG x)
+
+struct rpal_service {
+	/* reference count of this struct */
+	atomic_t refcnt;
+};
+
+/**
+ * @brief get new reference to a rpal service, a corresponding
+ *  rpal_put_service() should be called later by the caller.
+ *
+ * @param rs The struct rpal_service to get.
+ *
+ * @return new reference of struct rpal_service.
+ */
+struct rpal_service *rpal_get_service(struct rpal_service *rs);
+
+/**
+ * @brief put a reference to a rpal service. If the reference count of
+ *  the service turns to be 0, then release its struct rpal_service.
+ *  rpal_put_service() may be used in an atomic context.
+ *
+ * @param rs The struct rpal_service to put.
+ */
+void rpal_put_service(struct rpal_service *rs);
+#endif
-- 
2.20.1


