Return-Path: <linux-fsdevel+bounces-50191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B21AC8B15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733FC1890C4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8486922DA0C;
	Fri, 30 May 2025 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lIRmN2ee"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354A222598
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597693; cv=none; b=NJsGdE3EcN3Y5c1KFnh4BMioxEplHS4dM8x0mkUwLQkIQPsu9ce/l599fyYbkQ0fJog5alBH796qFW9Plc6TDqVIdWLK+qEYKuEZEqSwnUDoykxz5w9BaqV/HR9NuZGBRCP6MOpC7mXkyJb5lvEzmy37UOrB5ZXHOoZ9QTYB16E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597693; c=relaxed/simple;
	bh=huOWwdeBYR2ktVOxaLw5MQ08zC/qZOEF1LgzmHEU8B4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u62v5N+w69asgxVlUdNYR3I5z+wuNws1KFbAGMutssNSbCTjvdjfbdTt+nNryHytimFJhXmhufk7czZ7ZtHfEsLMD7GHFblXCfaIUogBvKT/nW7J7kwwj4xLYLkoUuqHhkney8yzrnDsO4bxrMfpgdb1BHzRSQAcv1R6Z4GWs4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lIRmN2ee; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3121aed2435so1491503a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597691; x=1749202491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r9koD1NPFSh7WkJOunYhnXV7czMJGlSW2YfbvvIqZo=;
        b=lIRmN2eeZ8hSHOyD39mDvrocaoB8bYLso4269wCfjXQI0Z8JKAB6gX6E1JAqesqZ/l
         zaiBhXOow9Usxm0YRWoacFzS88MYj527OdXbqSVqJ1/1BO+xLI32fpqghiDeoKeOCtCU
         u8iM/Bfx+qO4chcVapQLofBcqDwsjrgzxfXdYb676HxXu+4OoSAEtNhOwekhobMWxe5b
         VrmEQwZP8W8pjANYe8ZNtzAHPMNLXeC1Sv3tW4hu7PDctYmDkiIKsRP0vycUImdyIOns
         w/0C7zy0BB/CD1W6apOtKJLlYzXpQ1a6enbXVSMYtpU7Um7GyF2uvmS9ZZMjLd3ah+Uw
         zd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597691; x=1749202491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4r9koD1NPFSh7WkJOunYhnXV7czMJGlSW2YfbvvIqZo=;
        b=qcSpSm8Dgai6ELH3q5zN59uNdxrssXkdmLxVhBKBqmk0ofTwJO9m4zzNWF31MN7dc4
         haMfuAKkCDI4KJqLxVqCORp0P0uqCmnW4Q6bTajQGZbE3EXIzyaO3qviH2Ub0Y+W3ePh
         qjfZ+7TpVMJjQ582LEoTIfJuLPXstBLcfFapUY5rLmE4bDYHK4/KzBuVV2MfUTm5EFME
         X+2KGuoG99BS1157dWZGTLVAnP5nFi6+5cKJOMX4TABR9x+pgV0ePONhg7VfnncuWb2g
         /1wMbijMOFJvDmwU8XtaZ7uuyoaHDgcYBTG0t8w3n4OIAOh0dXF7gyq5irCdL8GST2Zv
         6nnw==
X-Forwarded-Encrypted: i=1; AJvYcCUh5poSRntjQoy//cHOXKbHv3+IjXhH3FwlRROWQNAgEOe4onsm4hU+EKHNdnoAr0slK7EYOJYtiEsKP6vG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8lc0ubhvVNF7372ODEGrv/YtZFUNOprjFJvFCB9G4D4C+OSnH
	MRgNfwY1NHeFJrm2qYa0/xZTdwTYxrFd1UIuX5nvHRp6dfM7DhqheIBEpRmcUl1rbhI=
X-Gm-Gg: ASbGncuFqV4wTSW2pN5uvh1GyUbuQhvDHiJ0UAudgupd8ZglBnuk3dI/2UKFnN8SBXi
	Q8z2n9kph/MO3hBdzHDtoQQT7OB7DanLcWwJSoWnx7GOK9cZFaY6ZpLf/LUmI2VEJWtHI6R4amX
	pkrUr/h2ulPk0tUCDz4FnmpktlZGuGSxQCvnAFGz1fbSLpvZWI81axF7spGeTTmONx9KpM/IPcM
	4HlacdSBZhLcluQ7rT7WaJQX/TirxMuOqpFZx5Biw7oq82JZd1DDF5B4Ouv3JG8Vf/Xul0NyvEe
	xBUwOJsOPYZq48BLXoqtXAbAcPk8NewpMVacMy3I08hvAflxpZdcvwRwNUDjlprDwja0yGKhLNQ
	WWHbprHPxaw==
X-Google-Smtp-Source: AGHT+IEYFSuwVcZ5gMKEd63K0LSZFm1at7KJSWQADYXZzWbymIXeS5JhogJZ9S4360x8945TmkY35w==
X-Received: by 2002:a17:90b:2e8b:b0:311:e637:287b with SMTP id 98e67ed59e1d1-3124198a8e2mr3896259a91.29.1748597690878;
        Fri, 30 May 2025 02:34:50 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.34.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:34:50 -0700 (PDT)
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
Subject: [RFC v2 25/35] RPAL: add MPK initialization and interface
Date: Fri, 30 May 2025 17:27:53 +0800
Message-Id: <569387db40571a03a71506cbec12813c1e5dde62.1748594841.git.libo.gcs85@bytedance.com>
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

RPAL uses MPK (Memory Protection Keys) to protect memory. Therefore, RPAL
needs to perform MPK initialization, allocation, and other related tasks,
while providing corresponding user-mode interfaces.

This patch executes MPK initialization operations, including feature
detection, implementation of user mode interfaces for setting and
retrieving pkeys, and development of utility functions. For pkey
allocation, RPAL prioritizes using pkeys provided by user mode, with user
mode responsible for preventing pkey collisions between different services.
If user mode does not provide a valid pkey, RPAL generates a pkey via
id % arch_max_pkey() to maximize the avoidance of pkey collisions.
Additionally, RPAL does not permit services to manipulate pkeys
independently; thus, all pkeys are marked as allocated, and services are
prohibited from releasing pkeys.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/Kconfig    | 12 +++++++-
 arch/x86/rpal/Makefile   |  1 +
 arch/x86/rpal/core.c     | 13 ++++++++
 arch/x86/rpal/internal.h |  5 +++
 arch/x86/rpal/pku.c      | 47 ++++++++++++++++++++++++++++
 arch/x86/rpal/proc.c     |  5 +++
 arch/x86/rpal/service.c  | 24 +++++++++++++++
 include/linux/rpal.h     | 66 ++++++++++++++++++++++++++++++++++++++++
 mm/mprotect.c            |  9 ++++++
 9 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/rpal/pku.c

diff --git a/arch/x86/rpal/Kconfig b/arch/x86/rpal/Kconfig
index e5e6996553ea..5434fdb2940d 100644
--- a/arch/x86/rpal/Kconfig
+++ b/arch/x86/rpal/Kconfig
@@ -8,4 +8,14 @@ config RPAL
 	depends on X86_64
 	help
 		This option enables system support for Run Process As
-		library (RPAL).
\ No newline at end of file
+		library (RPAL).
+
+config RPAL_PKU
+	bool "mpk protection for RPAL"
+	default y
+	depends on RPAL
+	help
+		Memory protection key (MPK) can achieve intra-process
+		memory separation which is broken by RPAL, Always keep
+		it on when use RPAL. CPU feature will be detected at
+		boot time as some CPUs do not support it.
\ No newline at end of file
diff --git a/arch/x86/rpal/Makefile b/arch/x86/rpal/Makefile
index 89f745382c51..42a42b0393be 100644
--- a/arch/x86/rpal/Makefile
+++ b/arch/x86/rpal/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_RPAL)		+= rpal.o
 
 rpal-y := service.o core.o mm.o proc.o thread.o
+rpal-$(CONFIG_RPAL_PKU) += pku.o
\ No newline at end of file
diff --git a/arch/x86/rpal/core.c b/arch/x86/rpal/core.c
index 406d54788bac..41111d693994 100644
--- a/arch/x86/rpal/core.c
+++ b/arch/x86/rpal/core.c
@@ -8,6 +8,7 @@
 
 #include <linux/rpal.h>
 #include <linux/sched/task_stack.h>
+#include <linux/pkeys.h>
 #include <asm/fsgsbase.h>
 
 #include "internal.h"
@@ -374,6 +375,14 @@ static bool check_hardware_features(void)
 		rpal_err("no fsgsbase feature\n");
 		return false;
 	}
+
+#ifdef CONFIG_RPAL_PKU
+	if (!arch_pkeys_enabled()) {
+		rpal_err("MPK is not enabled\n");
+		return false;
+	}
+#endif
+
 	return true;
 }
 
@@ -390,6 +399,10 @@ int __init rpal_init(void)
 	if (ret)
 		goto fail;
 
+#ifdef CONFIG_RPAL_PKU
+	rpal_set_cap(RPAL_CAP_PKU);
+#endif
+
 	rpal_inited = true;
 	return 0;
 
diff --git a/arch/x86/rpal/internal.h b/arch/x86/rpal/internal.h
index 6256172bb79e..71afa8225450 100644
--- a/arch/x86/rpal/internal.h
+++ b/arch/x86/rpal/internal.h
@@ -54,3 +54,8 @@ rpal_build_call_state(const struct rpal_sender_data *rsd)
 	return ((rsd->rcd.service_id << RPAL_SID_SHIFT) |
 		(rsd->scc->sender_id << RPAL_ID_SHIFT) | RPAL_RECEIVER_STATE_CALL);
 }
+
+/* pkey.c */
+int rpal_alloc_pkey(struct rpal_service *rs, int pkey);
+int rpal_pkey_setup(struct rpal_service *rs, int pkey);
+void rpal_service_pku_init(void);
diff --git a/arch/x86/rpal/pku.c b/arch/x86/rpal/pku.c
new file mode 100644
index 000000000000..4c5151ca5b8b
--- /dev/null
+++ b/arch/x86/rpal/pku.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RPAL service level operations
+ * Copyright (c) 2025, ByteDance. All rights reserved.
+ *
+ *     Author: Jiadong Sun <sunjiadong.lff@bytedance.com>
+ */
+
+#include <linux/rpal.h>
+#include <linux/pkeys.h>
+
+#include "internal.h"
+
+void rpal_service_pku_init(void)
+{
+	u16 all_pkeys_mask = ((1U << arch_max_pkey()) - 1);
+	struct mm_struct *mm = current->mm;
+
+	/* We consume all pkeys so that no pkeys will be allocated by others */
+	mmap_write_lock(mm);
+	if (mm->context.pkey_allocation_map != 0x1)
+		rpal_err("pkey has been allocated: %u\n",
+			 mm->context.pkey_allocation_map);
+	mm->context.pkey_allocation_map = all_pkeys_mask;
+	mmap_write_unlock(mm);
+}
+
+int rpal_pkey_setup(struct rpal_service *rs, int pkey)
+{
+	int val;
+
+	val = rpal_pkey_to_pkru(pkey);
+	rs->pkey = pkey;
+	return 0;
+}
+
+int rpal_alloc_pkey(struct rpal_service *rs, int pkey)
+{
+	int ret;
+
+	if (pkey >= 0 && pkey < arch_max_pkey())
+		return pkey;
+
+	ret = rs->id % arch_max_pkey();
+
+	return ret;
+}
diff --git a/arch/x86/rpal/proc.c b/arch/x86/rpal/proc.c
index 16ac9612bfc5..2f9cceec4992 100644
--- a/arch/x86/rpal/proc.c
+++ b/arch/x86/rpal/proc.c
@@ -76,6 +76,11 @@ static long rpal_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case RPAL_IOCTL_RELEASE_SERVICE:
 		ret = rpal_release_service(arg);
 		break;
+#ifdef CONFIG_RPAL_PKU
+	case RPAL_IOCTL_GET_SERVICE_PKEY:
+		ret = put_user(cur->pkey, (int __user *)arg);
+		break;
+#endif
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
index 16e94d710445..ca795dacc90d 100644
--- a/arch/x86/rpal/service.c
+++ b/arch/x86/rpal/service.c
@@ -208,6 +208,10 @@ struct rpal_service *rpal_register_service(void)
 	spin_lock_init(&rs->rpd.poll_lock);
 	bitmap_zero(rs->rpd.dead_key_bitmap, RPAL_NR_ID);
 	init_waitqueue_head(&rs->rpd.rpal_waitqueue);
+#ifdef CONFIG_RPAL_PKU
+	rs->pkey = -1;
+	rpal_service_pku_init();
+#endif
 
 	rs->bad_service = false;
 	rs->base = calculate_base_address(rs->id);
@@ -288,6 +292,9 @@ static int add_mapped_service(struct rpal_service *rs, struct rpal_service *tgt,
 	if (node->rs == NULL) {
 		node->rs = rpal_get_service(tgt);
 		set_bit(type_bit, &node->type);
+#ifdef CONFIG_RPAL_PKU
+		node->pkey = tgt->pkey;
+#endif
 	} else {
 		if (node->rs != tgt) {
 			ret = -EINVAL;
@@ -397,6 +404,19 @@ int rpal_request_service(unsigned long arg)
 		goto put_service;
 	}
 
+#ifdef CONFIG_RPAL_PKU
+	if (cur->pkey == tgt->pkey) {
+		ret = -EINVAL;
+		goto put_service;
+	}
+
+	ret = put_user(tgt->pkey, rra.pkey);
+	if (ret) {
+		ret = -EFAULT;
+		goto put_service;
+	}
+#endif
+
 	ret = put_user((unsigned long)(tgt->rsm.user_meta), rra.user_metap);
 	if (ret) {
 		ret = -EFAULT;
@@ -577,6 +597,10 @@ int rpal_enable_service(unsigned long arg)
 	mutex_lock(&cur->mutex);
 	if (!cur->enabled) {
 		cur->rsm = rsm;
+#ifdef CONFIG_RPAL_PKU
+		rsm.pkey = rpal_alloc_pkey(cur, rsm.pkey);
+		rpal_pkey_setup(cur, rsm.pkey);
+#endif
 		cur->enabled = true;
 	}
 	mutex_unlock(&cur->mutex);
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 4f1d92053818..2f2982d281cc 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -97,6 +97,12 @@ enum {
 #define RPAL_ID_MASK (~(0 | RPAL_RECEIVER_STATE_MASK | RPAL_SID_MASK))
 #define RPAL_MAX_ID ((1 << (RPAL_SID_SHIFT - RPAL_ID_SHIFT)) - 1)
 
+#define RPAL_PKRU_BASE_CODE_READ 0xAAAAAAAA
+#define RPAL_PKRU_BASE_CODE 0xFFFFFFFF
+#define RPAL_PKRU_SET 0
+#define RPAL_PKRU_UNION 1
+#define RPAL_PKRU_INTERSECT 2
+
 extern unsigned long rpal_cap;
 
 enum rpal_task_flag_bits {
@@ -122,6 +128,10 @@ enum rpal_sender_state {
 	RPAL_SENDER_STATE_KERNEL_RET,
 };
 
+enum rpal_capability {
+	RPAL_CAP_PKU
+};
+
 struct rpal_critical_section {
 	unsigned long ret_begin;
 	unsigned long ret_end;
@@ -134,6 +144,7 @@ struct rpal_service_metadata {
 	unsigned long version;
 	void __user *user_meta;
 	struct rpal_critical_section rcs;
+	int pkey;
 };
 
 struct rpal_request_arg {
@@ -141,11 +152,17 @@ struct rpal_request_arg {
 	u64 key;
 	unsigned long __user *user_metap;
 	int __user *id;
+#ifdef CONFIG_RPAL_PKU
+	int __user *pkey;
+#endif
 };
 
 struct rpal_mapped_service {
 	unsigned long type;
 	struct rpal_service *rs;
+#ifdef CONFIG_RPAL_PKU
+	int pkey;
+#endif
 };
 
 struct rpal_poll_data {
@@ -220,6 +237,11 @@ struct rpal_service {
 	/* fsbase / pid map */
 	struct rpal_fsbase_tsk_map fs_tsk_map[RPAL_MAX_RECEIVER_NUM];
 
+#ifdef CONFIG_RPAL_PKU
+	/* pkey */
+	int pkey;
+#endif
+
 	/* delayed service put work */
 	struct delayed_work delayed_put_work;
 
@@ -323,6 +345,7 @@ enum rpal_command_type {
 	RPAL_CMD_DISABLE_SERVICE,
 	RPAL_CMD_REQUEST_SERVICE,
 	RPAL_CMD_RELEASE_SERVICE,
+	RPAL_CMD_GET_SERVICE_PKEY,
 	RPAL_NR_CMD,
 };
 
@@ -351,6 +374,8 @@ enum rpal_command_type {
 	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_REQUEST_SERVICE, unsigned long)
 #define RPAL_IOCTL_RELEASE_SERVICE \
 	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_RELEASE_SERVICE, unsigned long)
+#define RPAL_IOCTL_GET_SERVICE_PKEY \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_GET_SERVICE_PKEY, int *)
 
 #define rpal_for_each_requested_service(rs, idx)                             \
 	for (idx = find_first_bit(rs->requested_service_bitmap, RPAL_NR_ID); \
@@ -420,6 +445,47 @@ static inline bool rpal_is_correct_address(struct rpal_service *rs, unsigned lon
 	return true;
 }
 
+static inline void rpal_set_cap(unsigned long cap)
+{
+	set_bit(cap, &rpal_cap);
+}
+
+static inline void rpal_clear_cap(unsigned long cap)
+{
+	clear_bit(cap, &rpal_cap);
+}
+
+static inline bool rpal_has_cap(unsigned long cap)
+{
+	return test_bit(cap, &rpal_cap);
+}
+
+static inline u32 rpal_pkey_to_pkru(int pkey)
+{
+	int offset = pkey * 2;
+	u32 mask = 0x3 << offset;
+
+	return RPAL_PKRU_BASE_CODE & ~mask;
+}
+
+static inline u32 rpal_pkey_to_pkru_read(int pkey)
+{
+	int offset = pkey * 2;
+	u32 mask = 0x3 << offset;
+
+	return RPAL_PKRU_BASE_CODE_READ & ~mask;
+}
+
+static inline u32 rpal_pkru_union(u32 pkru0, u32 pkru1)
+{
+	return pkru0 & pkru1;
+}
+
+static inline u32 rpal_pkru_intersect(u32 pkru0, u32 pkru1)
+{
+	return pkru0 | pkru1;
+}
+
 #ifdef CONFIG_RPAL
 static inline struct rpal_service *rpal_current_service(void)
 {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 62c1f7945741..982f911ffaba 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -33,6 +33,7 @@
 #include <linux/userfaultfd_k.h>
 #include <linux/memory-tiers.h>
 #include <uapi/linux/mman.h>
+#include <linux/rpal.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -895,6 +896,14 @@ SYSCALL_DEFINE1(pkey_free, int, pkey)
 {
 	int ret;
 
+#ifdef CONFIG_RPAL_PKU
+	if (rpal_current_service()) {
+		rpal_err("try_to_free pkey: %d %s\n", current->pid,
+			 current->comm);
+		return -EINVAL;
+	}
+#endif
+
 	mmap_write_lock(current->mm);
 	ret = mm_pkey_free(current->mm, pkey);
 	mmap_write_unlock(current->mm);
-- 
2.20.1


