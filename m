Return-Path: <linux-fsdevel+bounces-64277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B81ABE01B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 20:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B5A584FF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 18:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F58346A1F;
	Wed, 15 Oct 2025 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="FrN4qXDT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EDC345752
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552064; cv=none; b=erGkCdMIGEFaiwq5VxysgZTTuK4AxW/nvtdoJE+hxtFEDZG14vx6vPcUy6oV2PwYrVQr9n8I+iVX4L5HOYxZbi1L2O+X/mHFCcxGsOXSG9d8uraO3/L8U5NM3KABNnTjnLHplij62/ajFGngqGF0afgBcS4DSH1LQ/eX48bc1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552064; c=relaxed/simple;
	bh=qtzfTIDLQudHuwJbPQKZOmfk4VQHfbiISADd/7PYHv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mTug709vx65mYO1E63sCH2Y9HQhhk+vx09i3xyUGl/dRKqACUoA1sxGSmF5B8xZr2eH3hcbZXBSaeqAoCm72glH6olQhkZ3mtnV7gjkxtQGHCy4mKdIkfa9JpZuUNsJuZoDVDgPRT82+oKEjIaqBn0+o1OBoEtZ+7ERRlRaY6PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=FrN4qXDT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-26c209802c0so69187465ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552060; x=1761156860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7mqmvp4qHGKQdbAY5xXRef4U1rroaCrQF5ZBjvUPr8=;
        b=FrN4qXDTdWG2LfSVcEcKfMhDF7daazzl3/g8wL40M+NEWNzx4bJ0B5k8tuJzvnviIp
         8WCyYu7N7oNIvDrPb73jvVZ9e1Yj6UQiMtrnwjVxKRf1tSiHg7qg1a/t5plr1E8DfBPC
         rKPhew2xEaBBNxXLN7ja7QrwSY0lAqHJHUz+5DvbzoDrYMiIe5bdMfjYBx5H1h5ypB/4
         QgkYiK/DbOEM7InCVEMX6cD3pm9CSjl5YUsa3cBK7Y2dkoMTD1EbVsnII7k0LZiZqX26
         B6dMFgdYAdn4UI6dFEyDhzkjGKWyI9JyAyx7aWlo/qgcbG2hpiOJU8vE3i4kGTfsXTkp
         680w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552060; x=1761156860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7mqmvp4qHGKQdbAY5xXRef4U1rroaCrQF5ZBjvUPr8=;
        b=lyJhP/hI0XBHZ0LcMJ4Pkpnpt/Y3cnZHXrBF8CvdZl6X6j8g37eAlIhUbJxwVqavo1
         2Lg3VhyCvTxu9jFjXRLXttYGwkknQBReFCqOhGGsuDIFLfaCD0PoqMgQR5xVMfGTrLtY
         CCOjupKcRKACcZBUz0HPJYS3J8yTwAKHTgnKPyJU+JW3M5t2MIKPSZPBwX4W2fzlUHhK
         F7yAk0Riiartvf3S1DiARBsByW4p5Fp9r7Y/XUgD5f8UBAgfGW4lptY8VU1ueWWpp3bA
         8zeNKvew7kz3qVM5LoETuCaeselUoStDS5liT+QL/qnUTusDI+yz/sPJ9WN5aum/j9qE
         BAdw==
X-Forwarded-Encrypted: i=1; AJvYcCVg3mx7P4DBAjc3Dn3Rev0QBmWj0D+Cq587wBy7gozgyNuMqKX/uHhhtw9yfGde4zkRyb8cuvP52REXYt63@vger.kernel.org
X-Gm-Message-State: AOJu0YwEg0NEyXRBRYpNlGIXcdMaRCNEuOiY8wQOUFn6b+VkG5bL4pXX
	F7RKPZiAn11A6gq47A1NcdVkuMuEpN4mYJJlm5IGLOnDlY9Z8mDn8AHE5KOUWlXOkuQ=
X-Gm-Gg: ASbGncvc6JisuY7oxh3zNd5U+62xqV69dJzUZRpAWzZ8L1W7jrkVS34va2EZhJ6+Jw+
	a4sTztCg6/2YOMjn0LvvV8I6TduCXNg37PMEBpXePJ0KTym+qT3uy7/PhKX2EiIDd2upoqJC1rs
	sl7yeUCEQqgjBJhQ3EXR+tUykHN/07I6WIs4qtcpz7vWbnbIcBpfuJCncWiMPPBc6Y1EjOgoTJs
	mLCGb1qU2aJnW9GmtNBg6MK/5x2GbimnEI6PciYi3DuQjbIlXktiLnE/ISG9QBa9ZnohuYq2nJL
	KYHerO0ydpjXpGpHMlQW2UlD6mUKXSrwL+RHbcmvJzgUJybqvun4ZhWVPGkxd/DvK4dop00MR5K
	5vCn9BilFEkTJzjkA3Xa3Busdlx5M67gT+ycZTJn92M7Ak8Ya347Y6Q9ApqfhQA==
X-Google-Smtp-Source: AGHT+IGYHawen/DIH/6zDXsEucLMJ4nT2ZH73QD1ilWz2b4sp/DIn4gSAkeANmmS7z8UPAcMNV4bZg==
X-Received: by 2002:a17:902:da8e:b0:26a:589b:cf11 with SMTP id d9443c01a7336-29027402d24mr426479065ad.43.1760552060287;
        Wed, 15 Oct 2025 11:14:20 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:14:19 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:48 -0700
Subject: [PATCH v21 16/28] riscv: signal: abstract header saving for
 setup_sigcontext
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-16-6a07856e90e7@rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
In-Reply-To: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org
X-Mailer: b4 0.13.0

From: Andy Chiu <andybnac@gmail.com>

The function save_v_state() served two purposes. First, it saved
extension context into the signal stack. Then, it constructed the
extension header if there was no fault. The second part is independent
of the extension itself. As a result, we can pull that part out, so
future extensions may reuse it. This patch adds arch_ext_list and makes
setup_sigcontext() go through all possible extensions' save() callback.
The callback returns a positive value indicating the size of the
successfully saved extension. Then the kernel proceeds to construct the
header for that extension. The kernel skips an extension if it does
not exist, or if the saving fails for some reasons. The error code is
propagated out on the later case.

This patch does not introduce any functional changes.

Signed-off-by: Andy Chiu <andybnac@gmail.com>
---
 arch/riscv/include/asm/vector.h |  3 ++
 arch/riscv/kernel/signal.c      | 62 +++++++++++++++++++++++++++--------------
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index b61786d43c20..75d8bd417797 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -423,6 +423,9 @@ static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return false; }
 #define riscv_v_thread_free(tsk)		do {} while (0)
 #define  riscv_v_setup_ctx_cache()		do {} while (0)
 #define riscv_v_thread_alloc(tsk)		do {} while (0)
+#define get_cpu_vector_context()		do {} while (0)
+#define put_cpu_vector_context()		do {} while (0)
+#define riscv_v_vstate_set_restore(task, regs)	do {} while (0)
 
 #endif /* CONFIG_RISCV_ISA_V */
 
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 08378fea3a11..a5e3d54fe54b 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -68,18 +68,19 @@ static long save_fp_state(struct pt_regs *regs,
 #define restore_fp_state(task, regs) (0)
 #endif
 
-#ifdef CONFIG_RISCV_ISA_V
-
-static long save_v_state(struct pt_regs *regs, void __user **sc_vec)
+static long save_v_state(struct pt_regs *regs, void __user *sc_vec)
 {
-	struct __riscv_ctx_hdr __user *hdr;
 	struct __sc_riscv_v_state __user *state;
 	void __user *datap;
 	long err;
 
-	hdr = *sc_vec;
-	/* Place state to the user's signal context space after the hdr */
-	state = (struct __sc_riscv_v_state __user *)(hdr + 1);
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_V) ||
+	    !((has_vector() || has_xtheadvector()) &&
+	    riscv_v_vstate_query(regs)))
+		return 0;
+
+	/* Place state to the user's signal context spac */
+	state = (struct __sc_riscv_v_state __user *)sc_vec;
 	/* Point datap right after the end of __sc_riscv_v_state */
 	datap = state + 1;
 
@@ -97,15 +98,11 @@ static long save_v_state(struct pt_regs *regs, void __user **sc_vec)
 	err |= __put_user((__force void *)datap, &state->v_state.datap);
 	/* Copy the whole vector content to user space datap. */
 	err |= __copy_to_user(datap, current->thread.vstate.datap, riscv_v_vsize);
-	/* Copy magic to the user space after saving  all vector conetext */
-	err |= __put_user(RISCV_V_MAGIC, &hdr->magic);
-	err |= __put_user(riscv_v_sc_size, &hdr->size);
 	if (unlikely(err))
-		return err;
+		return -EFAULT;
 
-	/* Only progress the sv_vec if everything has done successfully  */
-	*sc_vec += riscv_v_sc_size;
-	return 0;
+	/* Only return the size if everything has done successfully  */
+	return riscv_v_sc_size;
 }
 
 /*
@@ -142,10 +139,20 @@ static long __restore_v_state(struct pt_regs *regs, void __user *sc_vec)
 	 */
 	return copy_from_user(current->thread.vstate.datap, datap, riscv_v_vsize);
 }
-#else
-#define save_v_state(task, regs) (0)
-#define __restore_v_state(task, regs) (0)
-#endif
+
+struct arch_ext_priv {
+	__u32 magic;
+	long (*save)(struct pt_regs *regs, void __user *sc_vec);
+};
+
+struct arch_ext_priv arch_ext_list[] = {
+	{
+		.magic = RISCV_V_MAGIC,
+		.save = &save_v_state,
+	},
+};
+
+const size_t nr_arch_exts = ARRAY_SIZE(arch_ext_list);
 
 static long restore_sigcontext(struct pt_regs *regs,
 	struct sigcontext __user *sc)
@@ -270,7 +277,8 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
 {
 	struct sigcontext __user *sc = &frame->uc.uc_mcontext;
 	struct __riscv_ctx_hdr __user *sc_ext_ptr = &sc->sc_extdesc.hdr;
-	long err;
+	struct arch_ext_priv *arch_ext;
+	long err, i, ext_size;
 
 	/* sc_regs is structured the same as the start of pt_regs */
 	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
@@ -278,8 +286,20 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
 	if (has_fpu())
 		err |= save_fp_state(regs, &sc->sc_fpregs);
 	/* Save the vector state. */
-	if ((has_vector() || has_xtheadvector()) && riscv_v_vstate_query(regs))
-		err |= save_v_state(regs, (void __user **)&sc_ext_ptr);
+	for (i = 0; i < nr_arch_exts; i++) {
+		arch_ext = &arch_ext_list[i];
+		if (!arch_ext->save)
+			continue;
+
+		ext_size = arch_ext->save(regs, sc_ext_ptr + 1);
+		if (ext_size <= 0) {
+			err |= ext_size;
+		} else {
+			err |= __put_user(arch_ext->magic, &sc_ext_ptr->magic);
+			err |= __put_user(ext_size, &sc_ext_ptr->size);
+			sc_ext_ptr = (void *)sc_ext_ptr + ext_size;
+		}
+	}
 	/* Write zero to fp-reserved space and check it on restore_sigcontext */
 	err |= __put_user(0, &sc->sc_extdesc.reserved);
 	/* And put END __riscv_ctx_hdr at the end. */

-- 
2.43.0


