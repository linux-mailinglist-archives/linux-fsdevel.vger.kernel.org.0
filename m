Return-Path: <linux-fsdevel+bounces-50194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2823CAC8B22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30F31898F83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA1723236D;
	Fri, 30 May 2025 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d4wJuq1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE6222DA1F
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597709; cv=none; b=l4CWt1bWrcA959PFgBlbYefVawybQxIyGMISc9fQ20Q4pCD/QjkaUkiQGQY9eCoUPJKnqz8r93c91BZNKVB4Gekqpu8lHMGcD/+6gomumOOVAqRhZ4jqBVH05mrUVihp+qBAHWhyDnX1+E/S+P+v55TZ3/oGQtIB3ay+oJf1+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597709; c=relaxed/simple;
	bh=CSBcJAAaPu1EwMn2t/TMYKgMYiCUawOQ8pC1PZaoOVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GIEysaoR+BYfjezTy58Bg4Y043RKdt22FHBpBhAH/eBp8E9XPOMawhz/LyRdwg2IJbUXUiajP8WY1ORwNerq/jxqW2UJFIIJNSGUbBAXBZL7jwF2pSFmeqty58xKWB4JNAMc/dtiAWDCbuWbsJDuaR23o3/bCM4I5pUK7NS9jHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d4wJuq1F; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2349f096605so22014075ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597706; x=1749202506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5lpZBJN8KO9Wi2JkiZbNrbX1Mk+tAQNdIUoCRiUIVY=;
        b=d4wJuq1FXHu4nTQhd567rVBNLwpQu/vPTHTSMzJELXe8r8QMRyWPKI6UHMdfwJXOvr
         C1GoXVRbTVaRSYD0nmNXphDcvSH//5te5HB1lEE0EvlBtG1sssy6fSGhqZUTMLkzrpK+
         LSGOGzc5RSFiXfbt4+oXm4yIvJYYWyoItXd/4IPDDMlPFoABm0JQji3CRu0pNwGLiMdg
         G2+GO3t1l7vwd3WtPSIONakx6NnCy6LaQYQbPc1urPCtwWSXG1dSCAvdYQIXjoffdKoe
         8eAsBL9+hETeapwiFw5ycojUfAKNjsZiLmf0P6KQfEKFnzs4Wp2+rE9ANwE6A9Gl0gLg
         UGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597706; x=1749202506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5lpZBJN8KO9Wi2JkiZbNrbX1Mk+tAQNdIUoCRiUIVY=;
        b=H+O9EiCOAW3jfkJP7d5f/DEnmJNC0+YlRxoAUQ8v0cWEGoA0jwRJjLeRoW6vZdG0MD
         vC0EWACYyCUCmtUMKbU2bc0+TH2QCh6BYxqRhY/MSgE3SKUfSngIQx4BgShaRvFMTRDW
         2R27o2ztFBXZIBhhkJY2rDj162suse5rgjLZZDCey+/CmPgTkT7fVbX9muOk1/OBt559
         fPf7wGZu35k5i/wW/BeT/ru2wzgOwG25q3kp150dnkF+dfLldXZkN2zm2zECZ0uRdojp
         aYqY8fUu1K6OIbTO6v3Dhr2Fc2EoAt5QZW8H0OGJvFyIIFI1LapB9QY3ZhPeAXceaMkI
         Z0kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPirIvHD7D2oBeeq+CY4p6U3X0finP3o3SpuhatnlkVUQfvKL+Jc5jNFOR9dADI8QrDMUlXzERruI1jVo2@vger.kernel.org
X-Gm-Message-State: AOJu0YwuuOP/bKOl8mNUIEshGaHX+tMEzwA76fUqRoUIwzbO0Rkid/Rh
	2ycPfH0sWwaTvwPh8HmclHip1Hm8FF1CCOjAKN60BHkrVLUIwF5RkhVQX5WuOY3vMXE=
X-Gm-Gg: ASbGncsIhLM7dTp3uiU/VgMiadvoxI1/bzfb5xBv/6Ylk+eVk9DYOYpXCJlngM42DHP
	V3L7+uJMQrWsj/zmXPE8kKMNchZ9uqg76COYm2GqXWXt8imF5B0F6JAe6GS0/VZxTsGP5gJNl9o
	JSFqqLAarTuyZ27LCYr08MSuUBGhfwOE1yuaXx6XPVlwZbvF++fZM5ETTL9w0QRvrHLqlZHiPx8
	82+bR16SXaXKR8gDyoeq3ObGTqJGAyqQCEnLaRlDfuyTNULfLzO/AYQlbU1NmIscqrF60nicqSo
	9mwtKwXheZiSHXGLzfbzgKMDciXh7JFBk26QoMxYOdUqYxGLu9kpE8GCu8r97v4nBWunBTBNT0F
	pGkBzS98guRJLg/XjA0CE
X-Google-Smtp-Source: AGHT+IHAptJ8gzy+riOF1QxfTIK2HHrgqPaaAtuaRZ0rpmj0urvpGAIWcEQ578w6XYLBnp/Jp17aLw==
X-Received: by 2002:a17:902:ccce:b0:234:bca7:2940 with SMTP id d9443c01a7336-23529a2c094mr43718025ad.38.1748597706235;
        Fri, 30 May 2025 02:35:06 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.34.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:35:05 -0700 (PDT)
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
Subject: [RFC v2 26/35] RPAL: enable MPK support
Date: Fri, 30 May 2025 17:27:54 +0800
Message-Id: <a7da7fe131b0ce6582dbb77903745673d83a6195.1748594841.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

RPAL leverages Memory Protection Keys (MPK) to safeguard shared memory
from illegal access and corruption by other processes. MPK-based memory
protection involves two key mechanisms: First, for already allocated
memory, when RPAL is enabled, the protection key fields in all page tables
must be set to the process’s corresponding pkey value. Second, for newly
allocated memory, when the kernel detects that the process is an RPAL
service, it sets the corresponding pkey flag in the relevant memory data
structures. Together, these measures ensure that all memory belonging to
the current process is protected by its own pkey.

For MPK initialization, RPAL needs to set the pkeys of all allocated page
table pages to the pkeys assigned by RPAL to the service. This is
completed in three steps: First, enable permissions for all pkeys of the
service, allowing it to access memory protected by any pkey. Then, update
the pkeys in the page tables. Since permissions for all pkeys are already
enabled at this stage, even if old and new pkeys coexist during the page
table update, the service's memory access remains unaffected. Finally,
after the page table update is complete, set the service's pkey permissions
to the corresponding values, thereby achieving memory protection.

Additionally, RPAL must manage the values of the PKRU register during
lazy switch operations and signal handling. This ensures the process
avoids coredumps causing by MPK.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/kernel/cpu/common.c |   8 +-
 arch/x86/kernel/fpu/core.c   |   8 +-
 arch/x86/kernel/process.c    |   7 +-
 arch/x86/rpal/core.c         |  14 +++-
 arch/x86/rpal/internal.h     |   1 +
 arch/x86/rpal/pku.c          | 139 ++++++++++++++++++++++++++++++++++-
 arch/x86/rpal/service.c      |   1 +
 arch/x86/rpal/thread.c       |   5 ++
 include/linux/rpal.h         |   3 +
 kernel/sched/core.c          |   3 +
 mm/mmap.c                    |  12 +++
 mm/mprotect.c                |  96 ++++++++++++++++++++++++
 mm/vma.c                     |  18 +++++
 13 files changed, 310 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8feb8fd2957a..2678453cdf76 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -26,6 +26,7 @@
 #include <linux/pgtable.h>
 #include <linux/stackprotector.h>
 #include <linux/utsname.h>
+#include <linux/rpal.h>
 
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
@@ -532,7 +533,12 @@ static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 
 	cr4_set_bits(X86_CR4_PKE);
 	/* Load the default PKRU value */
-	pkru_write_default();
+#ifdef CONFIG_RPAL_PKU
+	if (rpal_current_service() && rpal_current_service()->pku_on)
+		write_pkru(rpal_pkey_to_pkru(rpal_current_service()->pkey));
+	else
+#endif
+		pkru_write_default();
 }
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index ea138583dd92..251b1ddee726 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -20,6 +20,7 @@
 #include <linux/hardirq.h>
 #include <linux/pkeys.h>
 #include <linux/vmalloc.h>
+#include <linux/rpal.h>
 
 #include "context.h"
 #include "internal.h"
@@ -746,7 +747,12 @@ static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 	else
 		frstor(&init_fpstate.regs.fsave);
 
-	pkru_write_default();
+#ifdef CONFIG_RPAL_PKU
+	if (rpal_current_service() && rpal_current_service()->pku_on)
+		write_pkru(rpal_pkey_to_pkru(rpal_current_service()->pkey));
+	else
+#endif
+		pkru_write_default();
 }
 
 /*
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index be8845e2ca4d..b74de35218f9 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -285,7 +285,12 @@ static void pkru_flush_thread(void)
 	 * If PKRU is enabled the default PKRU value has to be loaded into
 	 * the hardware right here (similar to context switch).
 	 */
-	pkru_write_default();
+#ifdef CONFIG_RPAL_PKU
+	if (rpal_current_service() && rpal_current_service()->pku_on)
+		write_pkru(rpal_pkey_to_pkru(rpal_current_service()->pkey));
+	else
+#endif
+		pkru_write_default();
 }
 
 void flush_thread(void)
diff --git a/arch/x86/rpal/core.c b/arch/x86/rpal/core.c
index 41111d693994..47c9e551344e 100644
--- a/arch/x86/rpal/core.c
+++ b/arch/x86/rpal/core.c
@@ -275,6 +275,13 @@ rpal_skip_lazy_switch(struct task_struct *next, struct pt_regs *regs)
 	tgt = next->rpal_rs;
 	if (in_ret_section(tgt, regs->ip)) {
 		wrfsbase(current->thread.fsbase);
+#ifdef CONFIG_RPAL_PKU
+		rpal_set_current_pkru(
+			rpal_pkru_union(
+				rpal_pkey_to_pkru(rpal_current_service()->pkey),
+				rpal_pkey_to_pkru(next->rpal_rs->pkey)),
+			RPAL_PKRU_SET);
+#endif
 		rebuild_sender_stack(current->rpal_sd, regs);
 		rpal_clear_task_thread_flag(next, RPAL_LAZY_SWITCHED_BIT);
 		next->rpal_rd->sender = NULL;
@@ -292,8 +299,13 @@ static struct task_struct *rpal_fix_critical_section(struct task_struct *next,
 	if (rpal_test_task_thread_flag(next, RPAL_LAZY_SWITCHED_BIT))
 		next = rpal_skip_lazy_switch(next, regs);
 	/* receiver->sender */
-	else if (rpal_is_correct_address(cur, regs->ip))
+	else if (rpal_is_correct_address(cur, regs->ip)) {
 		rpal_skip_receiver_code(next, regs);
+#ifdef CONFIG_RPAL_PKU
+		write_pkru(rpal_pkru_union(
+			rpal_pkey_to_pkru(next->rpal_rs->pkey), rdpkru()));
+#endif
+	}
 
 	return next;
 }
diff --git a/arch/x86/rpal/internal.h b/arch/x86/rpal/internal.h
index 71afa8225450..e49febce8645 100644
--- a/arch/x86/rpal/internal.h
+++ b/arch/x86/rpal/internal.h
@@ -58,4 +58,5 @@ rpal_build_call_state(const struct rpal_sender_data *rsd)
 /* pkey.c */
 int rpal_alloc_pkey(struct rpal_service *rs, int pkey);
 int rpal_pkey_setup(struct rpal_service *rs, int pkey);
+void rpal_set_current_pkru(u32 val, int mode);
 void rpal_service_pku_init(void);
diff --git a/arch/x86/rpal/pku.c b/arch/x86/rpal/pku.c
index 4c5151ca5b8b..26cef324f41f 100644
--- a/arch/x86/rpal/pku.c
+++ b/arch/x86/rpal/pku.c
@@ -25,12 +25,149 @@ void rpal_service_pku_init(void)
 	mmap_write_unlock(mm);
 }
 
+void rpal_set_pku_schedule_tail(struct task_struct *prev)
+{
+	if (rpal_test_current_thread_flag(RPAL_RECEIVER_BIT)) {
+		struct rpal_service *cur = rpal_current_service();
+		u32 val = rpal_pkey_to_pkru(cur->pkey);
+
+		rpal_set_current_pkru(val, RPAL_PKRU_SET);
+	} else {
+		struct rpal_service *cur = rpal_current_service();
+		u32 val = rpal_pkey_to_pkru(cur->pkey);
+
+		val = rpal_pkru_union(
+			val,
+			rpal_pkey_to_pkru(
+				current->rpal_sd->receiver->rpal_rs->pkey));
+		rpal_set_current_pkru(val, RPAL_PKRU_SET);
+	}
+}
+
+static inline u32 rpal_get_new_val(u32 old_val, u32 new_val, int mode)
+{
+	switch (mode) {
+	case RPAL_PKRU_SET:
+		return new_val;
+	case RPAL_PKRU_UNION:
+		return rpal_pkru_union(old_val, new_val);
+	case RPAL_PKRU_INTERSECT:
+		return rpal_pkru_intersect(old_val, new_val);
+	default:
+		rpal_err("%s: invalid mode: %d\n", __func__, mode);
+		return old_val;
+	}
+}
+
+static int rpal_set_task_fpu_pkru(struct task_struct *task, u32 val, int mode)
+{
+	struct thread_struct *t = &task->thread;
+
+	val = rpal_get_new_val(t->pkru, val, mode);
+	t->pkru = val;
+
+	return 0;
+}
+
+void rpal_set_current_pkru(u32 val, int mode)
+{
+	u32 new_val;
+
+	new_val = rpal_get_new_val(rdpkru(), val, mode);
+	write_pkru(new_val);
+}
+
+struct task_function_data {
+	struct task_struct *task;
+	u32 val;
+	int mode;
+	int ret;
+};
+
+static void rpal_set_remote_pkru(void *data)
+{
+	struct task_function_data *tfd = data;
+	struct task_struct *task = tfd->task;
+
+	if (task) {
+		/* -EAGAIN */
+		if (task_cpu(task) != smp_processor_id())
+			return;
+
+		tfd->ret = -ESRCH;
+		if (task == current) {
+			rpal_set_current_pkru(tfd->val, tfd->mode);
+			tfd->ret = 0;
+		} else {
+			tfd->ret = rpal_set_task_fpu_pkru(task, tfd->val,
+							  tfd->mode);
+		}
+		return;
+	}
+}
+
+static int rpal_task_function_call(struct task_struct *task, u32 val, int mode)
+{
+	struct task_function_data data = {
+		.task = task,
+		.val = val,
+		.mode = mode,
+		.ret = -EAGAIN,
+	};
+	int ret;
+
+	for (;;) {
+		smp_call_function_single(task_cpu(task), rpal_set_remote_pkru,
+					 &data, 1);
+		ret = data.ret;
+
+		if (ret != -EAGAIN)
+			break;
+
+		cond_resched();
+	}
+
+	return ret;
+}
+
+static void rpal_set_task_pkru(struct task_struct *task, u32 val, int mode)
+{
+	if (task == current)
+		rpal_set_current_pkru(val, mode);
+	else
+		rpal_task_function_call(task, val, mode);
+}
+
+static void rpal_set_group_pkru(u32 val, int mode)
+{
+	struct task_struct *p;
+
+	for_each_thread(current, p) {
+		rpal_set_task_pkru(p, val, mode);
+	}
+}
+
 int rpal_pkey_setup(struct rpal_service *rs, int pkey)
 {
-	int val;
+	int err, val;
 
 	val = rpal_pkey_to_pkru(pkey);
+
+	mmap_write_lock(current->mm);
+	if (rs->pku_on) {
+		mmap_write_unlock(current->mm);
+		return 0;
+	}
 	rs->pkey = pkey;
+	/* others must see rs->pkey before rs->pku_on */
+	barrier();
+	rs->pku_on = true;
+	mmap_write_unlock(current->mm);
+	rpal_set_group_pkru(val, RPAL_PKRU_UNION);
+	err = do_rpal_mprotect_pkey(rs->base, RPAL_ADDR_SPACE_SIZE, pkey);
+	if (unlikely(err))
+		rpal_err("do_rpal_mprotect_key error: %d\n", err);
+	rpal_set_group_pkru(val, RPAL_PKRU_SET);
 	return 0;
 }
 
diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
index ca795dacc90d..7a83e85cf096 100644
--- a/arch/x86/rpal/service.c
+++ b/arch/x86/rpal/service.c
@@ -210,6 +210,7 @@ struct rpal_service *rpal_register_service(void)
 	init_waitqueue_head(&rs->rpd.rpal_waitqueue);
 #ifdef CONFIG_RPAL_PKU
 	rs->pkey = -1;
+	rs->pku_on = false;
 	rpal_service_pku_init();
 #endif
 
diff --git a/arch/x86/rpal/thread.c b/arch/x86/rpal/thread.c
index 02c1a9c22dd7..fcc592baaac0 100644
--- a/arch/x86/rpal/thread.c
+++ b/arch/x86/rpal/thread.c
@@ -281,6 +281,11 @@ int rpal_rebuild_sender_context_on_fault(struct pt_regs *regs,
 			regs->sp = ersp;
 			/* avoid rebuild again */
 			scc->ec.magic = 0;
+#ifdef CONFIG_RPAL_PKU
+			rpal_set_current_pkru(
+				rpal_pkey_to_pkru(rpal_current_service()->pkey),
+				RPAL_PKRU_SET);
+#endif
 			return 0;
 		}
 	}
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 2f2982d281cc..f2474cb53abe 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -239,6 +239,7 @@ struct rpal_service {
 
 #ifdef CONFIG_RPAL_PKU
 	/* pkey */
+	bool pku_on;
 	int pkey;
 #endif
 
@@ -571,4 +572,6 @@ void rpal_schedule(struct task_struct *next);
 asmlinkage struct task_struct *
 __rpal_switch_to(struct task_struct *prev_p, struct task_struct *next_p);
 asmlinkage __visible void rpal_schedule_tail(struct task_struct *prev);
+int do_rpal_mprotect_pkey(unsigned long start, size_t len, int pkey);
+void rpal_set_pku_schedule_tail(struct task_struct *prev);
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0f9343698198..eb5d5bd51597 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11029,6 +11029,9 @@ asmlinkage __visible void rpal_schedule_tail(struct task_struct *prev)
 
 	finish_task_switch(prev);
 	trace_sched_exit_tp(true, CALLER_ADDR0);
+#ifdef CONFIG_RPAL_PKU
+	rpal_set_pku_schedule_tail(prev);
+#endif
 	preempt_enable();
 
 	calculate_sigpending();
diff --git a/mm/mmap.c b/mm/mmap.c
index 98bb33d2091e..d36ea4ea2bd0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -396,6 +396,18 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		if (pkey < 0)
 			pkey = 0;
 	}
+#ifdef CONFIG_RPAL_PKU
+	/*
+	 * For RPAL process, if pku is enabled, we always use
+	 * its service pkey for new vma.
+	 */
+	do {
+		struct rpal_service *cur = rpal_current_service();
+
+		if (cur && cur->pku_on)
+			pkey = cur->pkey;
+	} while (0);
+#endif
 
 	/* Do simple checking here so the lower-level routines won't have
 	 * to. we assume access permissions have been handled by the open
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 982f911ffaba..e9ae828e377d 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -713,6 +713,18 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	struct mmu_gather tlb;
 	struct vma_iterator vmi;
 
+#ifdef CONFIG_RPAL_PKU
+	if (pkey != -1) {
+		struct rpal_service *cur = rpal_current_service();
+
+		if (unlikely(cur) && cur->pku_on) {
+			rpal_err("%s, pid: %d, try to change pkey\n",
+				 current->comm, current->pid);
+			return -EINVAL;
+		}
+	}
+#endif
+
 	start = untagged_addr(start);
 
 	prot &= ~(PROT_GROWSDOWN|PROT_GROWSUP);
@@ -848,6 +860,90 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	return error;
 }
 
+#ifdef CONFIG_RPAL_PKU
+int do_rpal_mprotect_pkey(unsigned long start, size_t len, int pkey)
+{
+	unsigned long nstart, end, tmp;
+	struct vm_area_struct *vma, *prev;
+	struct rpal_service *cur = rpal_current_service();
+	int error = -EINVAL;
+	struct mmu_gather tlb;
+	struct vma_iterator vmi;
+
+	start = untagged_addr(start);
+
+	if (start & ~PAGE_MASK)
+		return -EINVAL;
+	if (!len)
+		return 0;
+	len = PAGE_ALIGN(len);
+	end = start + len;
+	if (end <= start)
+		return -ENOMEM;
+
+	if (mmap_write_lock_killable(current->mm))
+		return -EINTR;
+
+	/*
+	 * If userspace did not allocate the pkey, do not let
+	 * them use it here.
+	 */
+	error = -EINVAL;
+	if ((pkey != -1) && !mm_pkey_is_allocated(current->mm, pkey))
+		goto out;
+
+	vma_iter_init(&vmi, current->mm, start);
+	vma = vma_find(&vmi, end);
+	error = -ENOMEM;
+	if (!vma)
+		goto out;
+
+	prev = vma_prev(&vmi);
+	if (vma->vm_start > start)
+		start = vma->vm_start;
+
+	if (start > vma->vm_start)
+		prev = vma;
+
+	tlb_gather_mmu(&tlb, current->mm);
+	nstart = start;
+	tmp = vma->vm_start;
+	for_each_vma_range(vmi, vma, end) {
+		unsigned long vma_pkey_mask;
+		unsigned long newflags;
+
+		tmp = vma->vm_start;
+		nstart = tmp;
+
+		/* Here we know that vma->vm_start <= nstart < vma->vm_end. */
+		vma_pkey_mask = VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 |
+				VM_PKEY_BIT3;
+		newflags = vma->vm_flags;
+		newflags &= ~vma_pkey_mask;
+		newflags |= ((unsigned long)cur->pkey) << VM_PKEY_SHIFT;
+
+		tmp = vma->vm_end;
+		if (tmp > end)
+			tmp = end;
+
+		if (vma->vm_ops && vma->vm_ops->mprotect) {
+			error = vma->vm_ops->mprotect(vma, nstart, tmp, newflags);
+			if (error)
+				break;
+		}
+
+		error = mprotect_fixup(&vmi, &tlb, vma, &prev, nstart, tmp, newflags);
+		if (error)
+			break;
+	}
+	tlb_finish_mmu(&tlb);
+
+out:
+	mmap_write_unlock(current->mm);
+	return error;
+}
+#endif
+
 SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot)
 {
diff --git a/mm/vma.c b/mm/vma.c
index a468d4c29c0c..fa9d8f694e6e 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -4,6 +4,8 @@
  * VMA-specific functions.
  */
 
+#include <linux/rpal.h>
+
 #include "vma_internal.h"
 #include "vma.h"
 
@@ -2622,6 +2624,22 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = current->mm;
 
+#ifdef CONFIG_RPAL_PKU
+	/*
+	 * Any memory need to use RPAL service pkey
+	 * once service is enabled.
+	 */
+	struct rpal_service *cur = rpal_current_service();
+	unsigned long vma_pkey_mask;
+
+	if (cur && cur->pku_on) {
+		vma_pkey_mask = VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 |
+				VM_PKEY_BIT3;
+		flags &= ~vma_pkey_mask;
+		flags |= ((unsigned long)cur->pkey) << VM_PKEY_SHIFT;
+	}
+#endif
+
 	/*
 	 * Check against address space limits by the changed size
 	 * Note: This happens *after* clearing old mappings in some code paths.
-- 
2.20.1


