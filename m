Return-Path: <linux-fsdevel+bounces-50197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3297BAC8B27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C74B3BF6C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0A622CBFE;
	Fri, 30 May 2025 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NYaqh2v8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A421CC52
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597754; cv=none; b=VviM/yu1ScaN0HngdTIrx0s+s6MarEdT3s562/7uPfpleYvg9DC7lF/At5Sfp2zxhmUD2mdLhha7BelgBZrW4spfPXgOkrBSbtpdPDJwylqc/6wNDAuWhdcANrQyZR2StSz8SX3wBwHrIQjm/cC2RQHPQ7J0K3smqNrvallr24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597754; c=relaxed/simple;
	bh=f9zzXMNbxFfZbGJyBMa0POHUK33Y39jv+mYtKpjEoMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bv/BmIzhN12arfeTvrI6wMpIq0oblK5O9cTEYjXElbVGnifBPn4qRpAFvDsaxfvugBPqRWvGwRWuh1+FPmdxr7AVkVbu8CYhRS3IeXWFzp4OBPuaG0Iwye+qIcYZG2y+mZ+JUuwkYlHCEHxCUVGGac9Pg6FlZ9TRZFulM7VLi0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NYaqh2v8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3109f106867so2166604a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597751; x=1749202551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruJXCVL33HlYZ/8pvuQkFgYyPjMywOaCJ6OilWvGVoA=;
        b=NYaqh2v8WiwtvUtfIP8l6dheuVdr6/jF6arATD9keqVx+WpYUV6fkYXqodO9Y3hnNt
         rp7zHfBulLlNbMg5TFKvqILTzBrh8S7gSK355JgXCx7jRGp8bVvbWVSBDLdDz2Xu6PBM
         qoFsq2qQUrsZ1rxPQNKydFbrEtgoRQATlkiKjVrENN2/PbqNyD3poYKgHtajBX1ODIRg
         5NdnvZqH0mhneUPWc25UHe+YHcC1UOw+SsV7Yl0dEyR0TgwurP7VFTDhJ+zsRWpo5O6T
         4bX1uRVDdGXzxk+WixQYEpaeoXe+/QWQ9OzwB+NrpunIFQLx1IDnHcBWAheFU0OcGmSP
         26bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597751; x=1749202551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruJXCVL33HlYZ/8pvuQkFgYyPjMywOaCJ6OilWvGVoA=;
        b=E5LtE9kBhFu9Y2Mzt2u8fUkcqykU1SDW9OpNMkAk/0xdfKvelh5G1N1hTDsfOfckj/
         80D6daxZQzThluVnevXYJGFdM5V5RkKe27AsyWlNubSkHfNhmN+g0ZNsdqghLL6PAa4b
         yC2n4immGd7xOpB5ygpzN7KHDEkhWl0wqxZ1p7iJQmdQS+GNZk+wngBF9qVDvNrx8mmq
         7LyK5P/R4QXab8w8VzzE970FWJhV8X1F+uAQ5RkTdEeVouMFtiVaJeGG8gKM53MiTqK5
         ndL2FE+AtfIvfd3crANOc/9TiMEVe9jPiiA00DZgQJK7t9tnFRucN07N1Q7vVk4DfdmY
         cKRw==
X-Forwarded-Encrypted: i=1; AJvYcCXLb8C3CvmwYrJuZOQXxWgHoJiVWpc9rfOqt26VErGcV6eQqKdp8u4Yb+OeJvfEGhDz0FMhDdZidYFUM3pO@vger.kernel.org
X-Gm-Message-State: AOJu0YwAtS9DV3psH0LgtLnGuAm51ZCrX4yfgLbiLEUNpYghBO52m3gV
	lV6DlQ57MZbJ0f44vfyj/nxmz/7uKAQhOmDQKBmPmEO9fLkxKlF6LYMal5Mh5uuDvvs=
X-Gm-Gg: ASbGncv6Jxoeac60JjrhgXSlBwyvZ/nok0cZhi/cu12RD1b+L5SMojdOzU4r6yMBxmL
	k8uBEXPums1C5Ko+kwJ8GxOB1Qar3R+OsVAYq0XOB1B+p5p3ryYwDRWT62VHnK128QEpHZ13mN1
	WNFjtDjxfVGsyjsRNygM3YA6ic2e8LvIUAd/6RzLtKvmnym7VKNMEpUQvpwCco46piKNnWYmdNU
	VyDdfakZjxQNoxk5nmbdmq1ebRkhtMjOCI/+PEW8N3tKSmrJvduNAULYBnDZcx8ltA9CjJGn2b2
	Vy+XEZU8Dkcgf20lS+d2ENtHyAd8g+/YMF47XZPqnDNEPe8oJT53ul6vJvvPvgwibm9HUGLFOSu
	8entjaEhAkw==
X-Google-Smtp-Source: AGHT+IEvXrgn/ooMRW35qDhy0ngiIGcMy7za8V80iv/SemfT2y7R5n/KmWGhxdI6JxqwxTCjuIZGRA==
X-Received: by 2002:a17:90b:1dc4:b0:311:afaa:5e25 with SMTP id 98e67ed59e1d1-31241865ecdmr4397369a91.24.1748597751453;
        Fri, 30 May 2025 02:35:51 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.35.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:35:51 -0700 (PDT)
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
Subject: [RFC v2 29/35] RPAL: fix race condition in pkru update
Date: Fri, 30 May 2025 17:27:57 +0800
Message-Id: <7fbb84a57fc8046738c7196031a3fd97ea8334e2.1748594841.git.libo.gcs85@bytedance.com>
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

When setting up MPK, RPAL uses IPIs to notify tasks running on each core
in the thread group to modify their PKRU values and update the PKEY fields
in all VMA page tables. A race condition exists here: when updating PKRU,
the page table updates may not yet be complete. In such cases, writing
PKRU permissions at locations that require calling pkru_write_default()
(e.g., during signal handling) must not be restricted to a single PKEY,
as this would cause PKRU permissions to fail to accommodate both old and
new page table PKEY settings.

This patch introduces a pku_on state with values PKU_ON_FALSE, PKU_ON_INIT,
and PKU_ON_FINISH, representing the states before, during, and after page
table PKEY updates, respectively. For RPAL services, all calls to
pkru_write_default() are replaced with rpal_pkru_write_default().

- Before page table setup (PKU_ON_FALSE), rpal_pkru_write_default()
  directly calls pkru_write_default().
- During page table setup (PKU_ON_INIT), rpal_pkru_write_default() enables
  permissions for all PKEYs, ensuring the task can access both old and new
  page tables simultaneously.
- After page table setup completes (PKU_ON_FINISH),
  rpal_pkru_write_default() tightens permissions to match the updated page
  tables.

For newly allocated page tables, the new PKEY is only used when pku_on is
PKU_ON_FINISH. The mmap lock is used to ensure no race conditions occur
during this process.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/kernel/cpu/common.c |  4 ++--
 arch/x86/kernel/fpu/core.c   |  4 ++--
 arch/x86/kernel/process.c    |  4 ++--
 arch/x86/rpal/pku.c          | 14 +++++++++++++-
 arch/x86/rpal/service.c      |  2 +-
 include/linux/rpal.h         |  9 ++++++++-
 mm/mmap.c                    |  2 +-
 mm/mprotect.c                |  1 +
 mm/vma.c                     |  2 +-
 9 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2678453cdf76..d21f44873b86 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -534,8 +534,8 @@ static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 	cr4_set_bits(X86_CR4_PKE);
 	/* Load the default PKRU value */
 #ifdef CONFIG_RPAL_PKU
-	if (rpal_current_service() && rpal_current_service()->pku_on)
-		write_pkru(rpal_pkey_to_pkru(rpal_current_service()->pkey));
+	if (rpal_current_service())
+		rpal_pkru_write_default();
 	else
 #endif
 		pkru_write_default();
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 251b1ddee726..4b413af0b179 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -748,8 +748,8 @@ static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 		frstor(&init_fpstate.regs.fsave);
 
 #ifdef CONFIG_RPAL_PKU
-	if (rpal_current_service() && rpal_current_service()->pku_on)
-		write_pkru(rpal_pkey_to_pkru(rpal_current_service()->pkey));
+	if (rpal_current_service())
+		rpal_pkru_write_default();
 	else
 #endif
 		pkru_write_default();
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b74de35218f9..898a9e0b23e7 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -286,8 +286,8 @@ static void pkru_flush_thread(void)
 	 * the hardware right here (similar to context switch).
 	 */
 #ifdef CONFIG_RPAL_PKU
-	if (rpal_current_service() && rpal_current_service()->pku_on)
-		write_pkru(rpal_pkey_to_pkru(rpal_current_service()->pkey));
+	if (rpal_current_service())
+		rpal_pkru_write_default();
 	else
 #endif
 		pkru_write_default();
diff --git a/arch/x86/rpal/pku.c b/arch/x86/rpal/pku.c
index 26cef324f41f..8e530931fb23 100644
--- a/arch/x86/rpal/pku.c
+++ b/arch/x86/rpal/pku.c
@@ -161,7 +161,7 @@ int rpal_pkey_setup(struct rpal_service *rs, int pkey)
 	rs->pkey = pkey;
 	/* others must see rs->pkey before rs->pku_on */
 	barrier();
-	rs->pku_on = true;
+	rs->pku_on = PKU_ON_INIT;
 	mmap_write_unlock(current->mm);
 	rpal_set_group_pkru(val, RPAL_PKRU_UNION);
 	err = do_rpal_mprotect_pkey(rs->base, RPAL_ADDR_SPACE_SIZE, pkey);
@@ -182,3 +182,15 @@ int rpal_alloc_pkey(struct rpal_service *rs, int pkey)
 
 	return ret;
 }
+
+void rpal_pkru_write_default(void)
+{
+	struct rpal_service *cur = rpal_current_service();
+
+	if (cur->pku_on == PKU_ON_INIT)
+		write_pkru(0);
+	else if (cur->pku_on == PKU_ON_FINISH)
+		write_pkru(rpal_pkey_to_pkru(rpal_current_service()->pkey));
+	else
+		pkru_write_default();
+}
diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
index 7a83e85cf096..9fd568fa9a29 100644
--- a/arch/x86/rpal/service.c
+++ b/arch/x86/rpal/service.c
@@ -210,7 +210,7 @@ struct rpal_service *rpal_register_service(void)
 	init_waitqueue_head(&rs->rpd.rpal_waitqueue);
 #ifdef CONFIG_RPAL_PKU
 	rs->pkey = -1;
-	rs->pku_on = false;
+	rs->pku_on = PKU_ON_FALSE;
 	rpal_service_pku_init();
 #endif
 
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 7657e6c6393b..16a3c80383f7 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -138,6 +138,12 @@ enum rpal_capability {
 	RPAL_CAP_PKU
 };
 
+enum {
+	PKU_ON_FALSE,
+	PKU_ON_INIT,
+	PKU_ON_FINISH,
+};
+
 struct rpal_critical_section {
 	unsigned long ret_begin;
 	unsigned long ret_end;
@@ -245,7 +251,7 @@ struct rpal_service {
 
 #ifdef CONFIG_RPAL_PKU
 	/* pkey */
-	bool pku_on;
+	int pku_on;
 	int pkey;
 #endif
 
@@ -599,6 +605,7 @@ __rpal_switch_to(struct task_struct *prev_p, struct task_struct *next_p);
 asmlinkage __visible void rpal_schedule_tail(struct task_struct *prev);
 int do_rpal_mprotect_pkey(unsigned long start, size_t len, int pkey);
 void rpal_set_pku_schedule_tail(struct task_struct *prev);
+void rpal_pkru_write_default(void);
 int rpal_ep_autoremove_wake_function(wait_queue_entry_t *curr,
 	unsigned int mode, int wake_flags,
 	void *key);
diff --git a/mm/mmap.c b/mm/mmap.c
index d36ea4ea2bd0..85a4a33491ab 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -404,7 +404,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	do {
 		struct rpal_service *cur = rpal_current_service();
 
-		if (cur && cur->pku_on)
+		if (cur && cur->pku_on == PKU_ON_FINISH)
 			pkey = cur->pkey;
 	} while (0);
 #endif
diff --git a/mm/mprotect.c b/mm/mprotect.c
index e9ae828e377d..ac162180553e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -938,6 +938,7 @@ int do_rpal_mprotect_pkey(unsigned long start, size_t len, int pkey)
 	}
 	tlb_finish_mmu(&tlb);
 
+	rpal_current_service()->pku_on = PKU_ON_FINISH;
 out:
 	mmap_write_unlock(current->mm);
 	return error;
diff --git a/mm/vma.c b/mm/vma.c
index fa9d8f694e6e..57ec99a5969d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2632,7 +2632,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct rpal_service *cur = rpal_current_service();
 	unsigned long vma_pkey_mask;
 
-	if (cur && cur->pku_on) {
+	if (cur && cur->pku_on == PKU_ON_FINISH) {
 		vma_pkey_mask = VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 |
 				VM_PKEY_BIT3;
 		flags &= ~vma_pkey_mask;
-- 
2.20.1


