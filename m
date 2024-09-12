Return-Path: <linux-fsdevel+bounces-29255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D00F1977558
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92273280298
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6081D2793;
	Thu, 12 Sep 2024 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="R2vgo/FN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881ED1D2230
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183129; cv=none; b=pPTqzmR1PDAe5Yhx0gftF/+oJCXOdPAExCaD+A70vcl9tU3SXGjEHLizmgpUhGkfqkDH9ByObIdl1aClzHLh7u+0jgYhGFgVbct+nMeH/Cl3TM7SrPwCiEyW+xR+xhLweT5LT2o2UGF1mGGV4UPe5GNSXZlUVEZ2qJoPpNwZINs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183129; c=relaxed/simple;
	bh=bfhppaBR3upTNHLOABVJ+Q6DMkB5F4gvkLrttpbTC6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6bIa9EIayA6pDCst9TGWcAMdalRJCbNHDBT3x2m+bd+xqHLuCEtnL2I8EeKN5D6GPcjHZ1jUH4tvs6Rfz9sDN81JljwTmvHw7d9Nt3Mi2Q6anzn9vjQacsvjTjkskq6XelELVhtzZc3RhgwYVllqcXp7z17/adlgvA+a8U0FH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=R2vgo/FN; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso1285311a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 16:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183127; x=1726787927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuNLZoEwAoxFOzNtpFEIpmCklLXVvlyHizGcnsawnko=;
        b=R2vgo/FNqAxlRoBKXg5ptZjwr3GKO0d9z+8lgIs6TaRLC2xYtS4bUo5aG1AwbW0I28
         7a3w1NKF3Kp+RLs+DkUL76EPoo10GKJPGeu6hfE3jyPPursJ6db8SFJKl3T53FgDKQh6
         Oqx4nWv54t32HkCTHorBFbAEmpppUmykSyTzMq7Ti54piqDGCoVjy6C7t8Mc4EYET6kj
         k2vcg1ODp0cZifyBJCKOOKVndJA5m4kiFW2Nqhl98oJNOIactw1+76R1mGapUvZ++VtC
         njCbwo7/gSbm6BI5Je7q2n+FI4WHG/5YslHZGr2sYHZbIqCxzKZsUNNEOY89Gwznw9Ep
         4M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183127; x=1726787927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuNLZoEwAoxFOzNtpFEIpmCklLXVvlyHizGcnsawnko=;
        b=YtYn/glUfllDRAqcs/jjRe7kvCvA0CU+bqYSTO3X1S4NWHZ4ERBc4BKyjdX9DjfnGs
         N20NAekSIKoJP+eJrpRn3hs0IqG8mx0PlERu1puvk9sT1aEoJp49C4NL0EF19Vrg5E9h
         cg4D/E6geUHm4z8mkujFlePOla0UtE/IO8BzODNY7rLzHHxfirYrwOtPd7dk8+YJimX3
         tylLeErbE0LY/EoeSJlj1OV7vISODp65lpYgRi+RbQ9nSBJ2Z6RnQ63MB5qubkIAYXxW
         YCDzr3pgw4n2QIFJ5HPotNqE8MQ91Daufio8pXZUiHW11/h1+usdnYSNByv91oZeFRRX
         1vVw==
X-Forwarded-Encrypted: i=1; AJvYcCXQavyRl0Bl/KmLJ5e70frucI6Fh/yDlKSydHDZeWzOgY8e83u9+E+1jVeIcDWgOth2LMOzdHpM0MRIzcvZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyFOHRMlx0zogM1H6dVg/OFRjx46JH4DELrRbxNcdKYYuULnkka
	yKdJONN6ZdrdFlpkfpwHPIUqfEiRnFhogeR/py8L278NcB3vsHYnkzNE9kEJvDA=
X-Google-Smtp-Source: AGHT+IFe2b+wfH4HddVQdWnBa2Cv1PojGiau8/JID+xbbETXDST/X3AAL06qD2zWAK34gSRESgSPDg==
X-Received: by 2002:a17:90a:4b82:b0:2c9:8105:483 with SMTP id 98e67ed59e1d1-2db9ffca8a1mr4592061a91.14.1726183126845;
        Thu, 12 Sep 2024 16:18:46 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:18:46 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	krzk+dt@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	brauner@kernel.org,
	samuel.holland@sifive.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	greentime.hu@sifive.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	xiao.w.wang@intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mchitale@ventanamicro.com,
	atishp@rivosinc.com,
	sameo@rivosinc.com,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	david@redhat.com,
	libang.li@antgroup.com,
	jszhang@kernel.org,
	leobras@redhat.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	costa.shul@redhat.com,
	bhe@redhat.com,
	zong.li@sifive.com,
	puranjay@kernel.org,
	namcaov@gmail.com,
	antonb@tenstorrent.com,
	sorear@fastmail.com,
	quic_bjorande@quicinc.com,
	ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk,
	quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com,
	yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn,
	sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com,
	schwab@suse.de,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	willy@infradead.org,
	usama.anjum@collabora.com,
	osalvador@suse.de,
	ryan.roberts@arm.com,
	andrii@kernel.org,
	alx@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	revest@chromium.org,
	bgray@linux.ibm.com,
	deller@gmx.de,
	zev@bewilderbeest.net
Subject: [PATCH v4 23/30] riscv signal: save and restore of shadow stack for signal
Date: Thu, 12 Sep 2024 16:16:42 -0700
Message-ID: <20240912231650.3740732-24-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912231650.3740732-1-debug@rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save shadow stack pointer in sigcontext structure while delivering signal.
Restore shadow stack pointer from sigcontext on sigreturn.

As part of save operation, kernel uses `ssamoswap` to save snapshot of
current shadow stack on shadow stack itself (can be called as a save
token). During restore on sigreturn, kernel retrieves token from top of
shadow stack and validates it. This allows that user mode can't arbitrary
pivot to any shadow stack address without having a token and thus provide
strong security assurance between signaly delivery and sigreturn window.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Suggested-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/include/asm/usercfi.h | 19 ++++++++++
 arch/riscv/kernel/signal.c       | 62 +++++++++++++++++++++++++++++++-
 arch/riscv/kernel/usercfi.c      | 57 +++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index 20a9102cce51..d5050a5df26c 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -8,6 +8,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 #include <linux/prctl.h>
+#include <linux/errno.h>
 
 struct task_struct;
 struct kernel_clone_args;
@@ -35,6 +36,9 @@ bool is_shstk_locked(struct task_struct *task);
 bool is_shstk_allocated(struct task_struct *task);
 void set_shstk_lock(struct task_struct *task);
 void set_shstk_status(struct task_struct *task, bool enable);
+unsigned long get_active_shstk(struct task_struct *task);
+int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr);
+int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_ptr);
 bool is_indir_lp_enabled(struct task_struct *task);
 bool is_indir_lp_locked(struct task_struct *task);
 void set_indir_lp_status(struct task_struct *task, bool enable);
@@ -96,6 +100,21 @@ static inline void set_shstk_status(struct task_struct *task, bool enable)
 
 }
 
+static inline int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr)
+{
+	return -EINVAL;
+}
+
+static inline int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_ptr)
+{
+	return -EINVAL;
+}
+
+static inline unsigned long get_active_shstk(struct task_struct *task)
+{
+	return 0;
+}
+
 static inline bool is_indir_lp_enabled(struct task_struct *task)
 {
 	return false;
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index dcd282419456..7d5c1825650f 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -22,6 +22,7 @@
 #include <asm/vector.h>
 #include <asm/csr.h>
 #include <asm/cacheflush.h>
+#include <asm/usercfi.h>
 
 unsigned long signal_minsigstksz __ro_after_init;
 
@@ -153,6 +154,16 @@ static long restore_sigcontext(struct pt_regs *regs,
 	void __user *sc_ext_ptr = &sc->sc_extdesc.hdr;
 	__u32 rsvd;
 	long err;
+	unsigned long ss_ptr = 0;
+	struct __sc_riscv_cfi_state __user *sc_cfi = NULL;
+
+	sc_cfi = (struct __sc_riscv_cfi_state *)
+		 ((unsigned long) sc_ext_ptr + sizeof(struct __riscv_ctx_hdr));
+
+	if (has_vector() && riscv_v_vstate_query(regs))
+		sc_cfi = (struct __sc_riscv_cfi_state *)
+			 ((unsigned long) sc_cfi + riscv_v_sc_size);
+
 	/* sc_regs is structured the same as the start of pt_regs */
 	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
 	if (unlikely(err))
@@ -172,6 +183,24 @@ static long restore_sigcontext(struct pt_regs *regs,
 	if (unlikely(rsvd))
 		return -EINVAL;
 
+	/*
+	 * Restore shadow stack as a form of token stored on shadow stack itself as a safe
+	 * way to restore.
+	 * A token on shadow gives following properties
+	 *	- Safe save and restore for shadow stack switching. Any save of shadow stack
+	 *	  must have had saved a token on shadow stack. Similarly any restore of shadow
+	 *	  stack must check the token before restore. Since writing to shadow stack with
+	 *	  address of shadow stack itself is not easily allowed. A restore without a save
+	 *	  is quite difficult for an attacker to perform.
+	 *	- A natural break. A token in shadow stack provides a natural break in shadow stack
+	 *	  So a single linear range can be bucketed into different shadow stack segments.
+	 *	  sspopchk will detect the condition and fault to kernel as sw check exception.
+	 */
+	if (is_shstk_enabled(current)) {
+		err |= __copy_from_user(&ss_ptr, &sc_cfi->ss_ptr, sizeof(unsigned long));
+		err |= restore_user_shstk(current, ss_ptr);
+	}
+
 	while (!err) {
 		__u32 magic, size;
 		struct __riscv_ctx_hdr __user *head = sc_ext_ptr;
@@ -215,6 +244,10 @@ static size_t get_rt_frame_size(bool cal_all)
 		if (cal_all || riscv_v_vstate_query(task_pt_regs(current)))
 			total_context_size += riscv_v_sc_size;
 	}
+
+	if (is_shstk_enabled(current))
+		total_context_size += sizeof(struct __sc_riscv_cfi_state);
+
 	/*
 	 * Preserved a __riscv_ctx_hdr for END signal context header if an
 	 * extension uses __riscv_extra_ext_header
@@ -276,18 +309,40 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
 {
 	struct sigcontext __user *sc = &frame->uc.uc_mcontext;
 	struct __riscv_ctx_hdr __user *sc_ext_ptr = &sc->sc_extdesc.hdr;
+	unsigned long ss_ptr = 0;
+	struct __sc_riscv_cfi_state __user *sc_cfi = NULL;
 	long err;
 
+	sc_cfi = (struct __sc_riscv_cfi_state *) (sc_ext_ptr + 1);
+
 	/* sc_regs is structured the same as the start of pt_regs */
 	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
 	/* Save the floating-point state. */
 	if (has_fpu())
 		err |= save_fp_state(regs, &sc->sc_fpregs);
 	/* Save the vector state. */
-	if (has_vector() && riscv_v_vstate_query(regs))
+	if (has_vector() && riscv_v_vstate_query(regs)) {
 		err |= save_v_state(regs, (void __user **)&sc_ext_ptr);
+		sc_cfi = (struct __sc_riscv_cfi_state *) ((unsigned long) sc_cfi + riscv_v_sc_size);
+	}
 	/* Write zero to fp-reserved space and check it on restore_sigcontext */
 	err |= __put_user(0, &sc->sc_extdesc.reserved);
+	/*
+	 * Save a pointer to shadow stack itself on shadow stack as a form of token.
+	 * A token on shadow gives following properties
+	 *	- Safe save and restore for shadow stack switching. Any save of shadow stack
+	 *	  must have had saved a token on shadow stack. Similarly any restore of shadow
+	 *	  stack must check the token before restore. Since writing to shadow stack with
+	 *	  address of shadow stack itself is not easily allowed. A restore without a save
+	 *	  is quite difficult for an attacker to perform.
+	 *	- A natural break. A token in shadow stack provides a natural break in shadow stack
+	 *	  So a single linear range can be bucketed into different shadow stack segments. Any
+	 *	  sspopchk will detect the condition and fault to kernel as sw check exception.
+	 */
+	if (is_shstk_enabled(current)) {
+		err |= save_user_shstk(current, &ss_ptr);
+		err |= __put_user(ss_ptr, &sc_cfi->ss_ptr);
+	}
 	/* And put END __riscv_ctx_hdr at the end. */
 	err |= __put_user(END_MAGIC, &sc_ext_ptr->magic);
 	err |= __put_user(END_HDR_SIZE, &sc_ext_ptr->size);
@@ -345,6 +400,11 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 #ifdef CONFIG_MMU
 	regs->ra = (unsigned long)VDSO_SYMBOL(
 		current->mm->context.vdso, rt_sigreturn);
+
+	/* if bcfi is enabled x1 (ra) and x5 (t0) must match. not sure if we need this? */
+	if (is_shstk_enabled(current))
+		regs->t0 = regs->ra;
+
 #else
 	/*
 	 * For the nommu case we don't have a VDSO.  Instead we push two
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 8da509afdbe9..40c32258b6ec 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -52,6 +52,11 @@ void set_active_shstk(struct task_struct *task, unsigned long shstk_addr)
 	task->thread_info.user_cfi_state.user_shdw_stk = shstk_addr;
 }
 
+unsigned long get_active_shstk(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.user_shdw_stk;
+}
+
 void set_shstk_status(struct task_struct *task, bool enable)
 {
 	task->thread_info.user_cfi_state.ubcfi_en = enable ? 1 : 0;
@@ -164,6 +169,58 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
 	return 0;
 }
 
+/*
+ * Save user shadow stack pointer on shadow stack itself and return pointer to saved location
+ * returns -EFAULT if operation was unsuccessful
+ */
+int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_ptr)
+{
+	unsigned long ss_ptr = 0;
+	unsigned long token_loc = 0;
+	int ret = 0;
+
+	if (saved_shstk_ptr == NULL)
+		return -EINVAL;
+
+	ss_ptr = get_active_shstk(tsk);
+	ret = create_rstor_token(ss_ptr, &token_loc);
+
+	if (!ret) {
+		*saved_shstk_ptr = token_loc;
+		set_active_shstk(tsk, token_loc);
+	}
+
+	return ret;
+}
+
+/*
+ * Restores user shadow stack pointer from token on shadow stack for task `tsk`
+ * returns -EFAULT if operation was unsuccessful
+ */
+int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr)
+{
+	unsigned long token = 0;
+
+	token = amo_user_shstk((unsigned long __user *)shstk_ptr, 0);
+
+	if (token == -1)
+		return -EFAULT;
+
+	/* invalid token, return EINVAL */
+	if ((token - shstk_ptr) != SHSTK_ENTRY_SIZE) {
+		pr_info_ratelimited(
+				"%s[%d]: bad restore token in %s: pc=%p sp=%p, token=%p, shstk_ptr=%p\n",
+				tsk->comm, task_pid_nr(tsk), __func__,
+				(void *)(task_pt_regs(tsk)->epc), (void *)(task_pt_regs(tsk)->sp),
+				(void *)token, (void *)shstk_ptr);
+		return -EINVAL;
+	}
+
+	/* all checks passed, set active shstk and return success */
+	set_active_shstk(tsk, token);
+	return 0;
+}
+
 static unsigned long allocate_shadow_stack(unsigned long addr, unsigned long size,
 				unsigned long token_offset,
 				bool set_tok)
-- 
2.45.0


