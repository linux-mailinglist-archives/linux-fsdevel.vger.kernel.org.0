Return-Path: <linux-fsdevel+bounces-50178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFDCAC8AF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1075A18907D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D1522D9FA;
	Fri, 30 May 2025 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UIhFXuhK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A722D799
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597508; cv=none; b=R8BgkrbAzMTe02FJmyOlOO+n/0KQBXxTcbytwZZLKeYbcvrAOflrgPXFcGZyOJ+p5Wf4ts8ROKiNH4v49pRBXruf75MVwoT64cx7nPM0eeIVI94/yndNmtbKrRHdNdra58kb1NwWDqyytfRZt/Ac9tZ3xqMCFCPVvrqpK/XUBJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597508; c=relaxed/simple;
	bh=x42OvKF8cu3SGLWZonaQOFG1mLKzqSw7oCqoTulLIhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RnyYX6BhRrqJjsUPgCdp3Cp7NgmeRhZe+UZXmUctQyN0EW1lZGQjc+KxhON7z2iA1fMCpOwMCrZ0dyzIuUSWyWll7oiOLylCNOd7rIqjPHsBVYUtnislMmL1m2LJEEQ9e5aD7KwahPXkIUrFIW50dTd4yaI6s6nY6McS6Lcv+Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UIhFXuhK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb2so1583417a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597506; x=1749202306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqEqFVUYhIQ6uCyFMSKyc3XjCtHWAqaCcpg8jFQsxWM=;
        b=UIhFXuhKkT4Y96MhzklPzS+CDHR0Hw8VJ3D0QgE5uV/f0ZucyRKOfLHwT9vxTiLErV
         j/R1Ct0aZGJOi9mfTNDGtDO/U7JHgHzd0D/7f3Z02wZCMehFDya7ysKmcdrLPqfa+Kgq
         jdeAef2VgY6bSAmZeYcaxI75LLX8O8+ImWRe5C6OQmjNP64UgseKPtNB8/sBDld/OO7E
         gBRLKl/EAGe2+e3mvcMrEiNKYFfPhqBslo/LfYZt0in/HfDVApFPGY4Fsbwe7TO0Ojl4
         7tswhefuv5qkD9ggG7FBUkyGDBpgw0LY3WDOgW40Ng7qocSI1ce1YHVfSPN9ASiwORY7
         nRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597506; x=1749202306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqEqFVUYhIQ6uCyFMSKyc3XjCtHWAqaCcpg8jFQsxWM=;
        b=AjOCCsUK8yq6q0ED9cUN6+h+t3GbiI5frnRGq6Rj9z9C/gxJnVRt1YJDFO9AZw82OL
         YZ5L7FBXUhDo7qYvTNKDPdHbdOJxzzgT9WYZOgXiAbfRuMBplYNYfSgE/GCM+mXAR6/C
         Gd03omOpBQclYYdCfmQYUe8nieZk5oOzyJDVDC9aF5f45dpv2KYLQ97uDoxzWz+r2bvN
         RH98NAnR1bCcrfSQXcAaK2jg2sGmuAiCtu5AGCnrjtvYBjKexC4ygPqdlZeMCBHsjPWk
         k9GuDhtLMwGQWPkijLuldh9yj93/8pPMgj0RwtlWleBhnr7yzwYcMMmqqXEPFQu7LwEq
         E+pg==
X-Forwarded-Encrypted: i=1; AJvYcCVm5GQqH4cPVvJ1LbsWufopb1D5RoAp/y/O7vw1ws/QKhZNmjI7Psy2eg5iCT94f/A4J6QeknJ0Vm/UgKqi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9WHeptNL3mpRflU4bB5mQQImu9iF6NX0c6miQFoaM02ByUV7k
	UbvlI0eBQkB1J0/G+mdC3H7urFlglXzczKlDPVp9lxOIol4ib9WAsU7UuYLk1kCmp1s=
X-Gm-Gg: ASbGncvgUKRbN2Uwu3TD5SNQ1kb1z6EkbsYyshqZsAq+XVZYGne3BRCKcfcWaTaeDuI
	In75cYfrYeDuP+8B43K3ZvAScfaRGgZiif59SlSItnMwQ9jO5qeOWozRWFAPL4TdsPjM9aRqeFz
	J31fq0q6zqUQm/md0Ti3KsW2dvv7quWBsRck81o3s8+ofjYMcLJsLkxGFbuFHk9wwgYzlHanVfH
	shPbavx3AlsgL2PPxX0jVpb0x41MTt9S1vg7055yDKvYl4dzf0lgBHG0D7edsOVrRmIoMTK8nt5
	QoR7hrqNuKYL47UX0P2wC/zQ2MigtyuZio9wqrajmpaugEVtPpRJnV+ekiYfcNAlac4DfN6gGIk
	H+Cd4u22TQA==
X-Google-Smtp-Source: AGHT+IGF62FX0HQNv9LilxlCiViF0h8d1bY/G1W0X5Q0qQ2cdYg03wna6Pf30NCPziT41+dazZ7wew==
X-Received: by 2002:a17:90b:3b50:b0:312:1c83:58e9 with SMTP id 98e67ed59e1d1-3124150e464mr3530070a91.5.1748597505955;
        Fri, 30 May 2025 02:31:45 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.31.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:31:45 -0700 (PDT)
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
Subject: [RFC v2 13/35] RPAL: add tlb flushing support
Date: Fri, 30 May 2025 17:27:41 +0800
Message-Id: <c1eeca7e95433f2e51eeae63375f41d7fafd4c5b.1748594840.git.libo.gcs85@bytedance.com>
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

When a thread flushes the TLB, since the address space is shared,
not only other threads in the current process but also other processes
that share the address space may access the corresponding memory (related
to the TLB flush). Therefore, the cpuset used for TLB flushing should be
the union of the mm_cpumasks of all processes that share the address
space.

This patch extend flush_tlb_info to store other process's mm_struct,
and when a CPU in the union of the mm_cpumasks if invoked to handle
tlb flushing, it will check whether cpu_tlbstate.loaded_mm matches any
of mm_structs stored in flush_tlb_info. If match, the CPU will do local
tlb flushing for that mm_struct.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/include/asm/tlbflush.h |  10 ++
 arch/x86/mm/tlb.c               | 172 ++++++++++++++++++++++++++++++++
 arch/x86/rpal/internal.h        |   3 -
 include/linux/rpal.h            |  12 +++
 mm/rmap.c                       |   4 +
 5 files changed, 198 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index e9b81876ebe4..f57b745af75c 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -227,6 +227,11 @@ struct flush_tlb_info {
 	u8			stride_shift;
 	u8			freed_tables;
 	u8			trim_cpumask;
+#ifdef CONFIG_RPAL
+	struct mm_struct **mm_list;
+	u64 *tlb_gen_list;
+	int nr_mm;
+#endif
 };
 
 void flush_tlb_local(void);
@@ -356,6 +361,11 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
 	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
 }
 
+#ifdef CONFIG_RPAL
+void rpal_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+	struct mm_struct *mm);
+#endif
+
 static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 {
 	flush_tlb_mm(mm);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 39f80111e6f1..a0fe17b13887 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -12,6 +12,7 @@
 #include <linux/task_work.h>
 #include <linux/mmu_notifier.h>
 #include <linux/mmu_context.h>
+#include <linux/rpal.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -1361,6 +1362,169 @@ void flush_tlb_multi(const struct cpumask *cpumask,
 	__flush_tlb_multi(cpumask, info);
 }
 
+#ifdef CONFIG_RPAL
+static void rpal_flush_tlb_func_remote(void *info)
+{
+	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+	struct flush_tlb_info *f = info;
+	struct flush_tlb_info tf = *f;
+	int i;
+
+	/* As it comes from RPAL path, f->mm cannot be NULL */
+	if (f->mm == loaded_mm) {
+		flush_tlb_func(f);
+		return;
+	}
+
+	for (i = 0; i < f->nr_mm; i++) {
+		/* We always have f->mm_list[i] != NULL */
+		if (f->mm_list[i] == loaded_mm) {
+			tf.mm = f->mm_list[i];
+			tf.new_tlb_gen = f->tlb_gen_list[i];
+			flush_tlb_func(&tf);
+			return;
+		}
+	}
+}
+
+static void rpal_flush_tlb_func_multi(const struct cpumask *cpumask,
+			       const struct flush_tlb_info *info)
+{
+	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
+	if (info->end == TLB_FLUSH_ALL)
+		trace_tlb_flush(TLB_REMOTE_SEND_IPI, TLB_FLUSH_ALL);
+	else
+		trace_tlb_flush(TLB_REMOTE_SEND_IPI,
+				(info->end - info->start) >> PAGE_SHIFT);
+
+	if (info->freed_tables || mm_in_asid_transition(info->mm))
+		on_each_cpu_mask(cpumask, rpal_flush_tlb_func_remote,
+				 (void *)info, true);
+	else
+		on_each_cpu_cond_mask(should_flush_tlb,
+				      rpal_flush_tlb_func_remote, (void *)info,
+				      1, cpumask);
+}
+
+static void rpal_flush_tlb_func_local(struct mm_struct *mm, int cpu,
+				      struct flush_tlb_info *info,
+				      u64 new_tlb_gen)
+{
+	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+
+	if (loaded_mm == info->mm) {
+		lockdep_assert_irqs_enabled();
+		local_irq_disable();
+		flush_tlb_func(info);
+		local_irq_enable();
+	} else {
+		int i;
+
+		for (i = 0; i < info->nr_mm; i++) {
+			if (info->mm_list[i] == loaded_mm) {
+				lockdep_assert_irqs_enabled();
+				local_irq_disable();
+				info->mm = info->mm_list[i];
+				info->new_tlb_gen = info->tlb_gen_list[i];
+				flush_tlb_func(info);
+				info->mm = mm;
+				info->new_tlb_gen = new_tlb_gen;
+				local_irq_enable();
+			}
+		}
+	}
+}
+
+static void rpal_flush_tlb_mm_range(struct mm_struct *mm, int cpu,
+			     struct flush_tlb_info *info, u64 new_tlb_gen)
+{
+	struct rpal_service *cur = mm->rpal_rs;
+	cpumask_t merged_mask;
+	struct mm_struct *mm_list[MAX_REQUEST_SERVICE];
+	u64 tlb_gen_list[MAX_REQUEST_SERVICE];
+	int nr_mm = 0;
+	int i;
+
+	cpumask_copy(&merged_mask, mm_cpumask(mm));
+	if (cur) {
+		struct rpal_service *tgt;
+		struct mm_struct *tgt_mm;
+
+		rpal_for_each_requested_service(cur, i) {
+			struct rpal_mapped_service *node;
+
+			if (i == cur->id)
+				continue;
+			node = rpal_get_mapped_node(cur, i);
+			if (!rpal_service_mapped(node))
+				continue;
+
+			tgt = rpal_get_service(node->rs);
+			if (!tgt)
+				continue;
+			tgt_mm = tgt->mm;
+			if (!mmget_not_zero(tgt_mm)) {
+				rpal_put_service(tgt);
+				continue;
+			}
+			mm_list[nr_mm] = tgt_mm;
+			tlb_gen_list[nr_mm] = inc_mm_tlb_gen(tgt_mm);
+
+			nr_mm++;
+			cpumask_or(&merged_mask, &merged_mask,
+				   mm_cpumask(tgt_mm));
+			rpal_put_service(tgt);
+		}
+		info->mm_list = mm_list;
+		info->tlb_gen_list = tlb_gen_list;
+		info->nr_mm = nr_mm;
+	}
+
+	if (cpumask_any_but(&merged_mask, cpu) < nr_cpu_ids)
+		rpal_flush_tlb_func_multi(&merged_mask, info);
+	else
+		rpal_flush_tlb_func_local(mm, cpu, info, new_tlb_gen);
+
+	for (i = 0; i < nr_mm; i++)
+		mmput_async(mm_list[i]);
+}
+
+void rpal_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+			      struct mm_struct *mm)
+{
+	struct rpal_service *cur = mm->rpal_rs;
+	struct rpal_service *tgt;
+	struct mm_struct *tgt_mm;
+	int i;
+
+	rpal_for_each_requested_service(cur, i) {
+		struct rpal_mapped_service *node;
+
+		if (i == cur->id)
+			continue;
+
+		node = rpal_get_mapped_node(cur, i);
+		if (!rpal_service_mapped(node))
+			continue;
+
+		tgt = rpal_get_service(node->rs);
+		if (!tgt)
+			continue;
+		tgt_mm = tgt->mm;
+		if (!mmget_not_zero(tgt_mm)) {
+			rpal_put_service(tgt);
+			continue;
+		}
+		inc_mm_tlb_gen(tgt_mm);
+		cpumask_or(&batch->cpumask, &batch->cpumask,
+			   mm_cpumask(tgt_mm));
+		mmu_notifier_arch_invalidate_secondary_tlbs(tgt_mm, 0, -1UL);
+		rpal_put_service(tgt);
+		mmput_async(tgt_mm);
+	}
+}
+#endif
+
 /*
  * See Documentation/arch/x86/tlb.rst for details.  We choose 33
  * because it is large enough to cover the vast majority (at
@@ -1439,6 +1603,11 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	info = get_flush_tlb_info(mm, start, end, stride_shift, freed_tables,
 				  new_tlb_gen);
 
+#if IS_ENABLED(CONFIG_RPAL)
+	if (mm->rpal_rs)
+		rpal_flush_tlb_mm_range(mm, cpu, info, new_tlb_gen);
+	else {
+#endif
 	/*
 	 * flush_tlb_multi() is not optimized for the common case in which only
 	 * a local TLB flush is needed. Optimize this use-case by calling
@@ -1456,6 +1625,9 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 		flush_tlb_func(info);
 		local_irq_enable();
 	}
+#if IS_ENABLED(CONFIG_RPAL)
+	}
+#endif
 
 	put_flush_tlb_info();
 	put_cpu();
diff --git a/arch/x86/rpal/internal.h b/arch/x86/rpal/internal.h
index c504b6efff64..cf6d608a994a 100644
--- a/arch/x86/rpal/internal.h
+++ b/arch/x86/rpal/internal.h
@@ -12,9 +12,6 @@
 #include <linux/mm.h>
 #include <linux/file.h>
 
-#define RPAL_REQUEST_MAP 0x1
-#define RPAL_REVERSE_MAP 0x2
-
 extern bool rpal_inited;
 
 /* service.c */
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index b9622f0235bf..36be1ab6a9f3 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -80,6 +80,11 @@
 /* No more than 15 services can be requested due to limitation of MPK. */
 #define MAX_REQUEST_SERVICE 15
 
+enum {
+	RPAL_REQUEST_MAP,
+	RPAL_REVERSE_MAP,
+};
+
 extern unsigned long rpal_cap;
 
 enum rpal_task_flag_bits {
@@ -326,6 +331,13 @@ rpal_get_mapped_node(struct rpal_service *rs, int id)
 	return &rs->service_map[id];
 }
 
+static inline bool rpal_service_mapped(struct rpal_mapped_service *node)
+{
+	unsigned long type = (1 << RPAL_REQUEST_MAP) | (1 << RPAL_REVERSE_MAP);
+
+	return (node->type & type) == type;
+}
+
 #ifdef CONFIG_RPAL
 static inline struct rpal_service *rpal_current_service(void)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index 67bb273dfb80..e68384f97ab9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -682,6 +682,10 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 		return;
 
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, start, end);
+#ifdef CONFIG_RPAL
+	if (mm->rpal_rs)
+		rpal_tlbbatch_add_pending(&tlb_ubc->arch, mm);
+#endif
 	tlb_ubc->flush_required = true;
 
 	/*
-- 
2.20.1


