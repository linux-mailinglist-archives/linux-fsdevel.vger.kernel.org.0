Return-Path: <linux-fsdevel+bounces-33189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1603A9B577E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 00:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA101284921
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 23:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDD021019A;
	Tue, 29 Oct 2024 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="iaLI3T33"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F50D210191
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245489; cv=none; b=HK/baTyvKqUKXDFQwYSpXgyB+O5vUCLX5jtRsYeRjx3hyucA5zYmaUCbrytB5enrSKIe4sTcCgp2eVUyl9k4kMplP2wXH/mjZ7qrroXJaiUtH4cijPMjOgGjvh/4Ar+ShB6NIXakpma8PM+EOWbFcvlp3mFVjdGw9dr/aimDeIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245489; c=relaxed/simple;
	bh=B+3iQYWvTw7QqPfc+WGgFUELd6fVOk4EEyGboXeDSbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BqDZgD4wmX9D4gJhjzn/mA+CFj3GxwaI6YCoJumTapMxaRqtWu/ywqXnVGEmOJ2Bi6YfBSxRC60LftwVFWZgFLhM0+j5zSvVMy/AJM4eG8ownKNi/Vs+OoRrQH7Ug48cM6jjNlZEs0FkOUkD4VHoxvaV/YwiiU1pW8CjKXbsTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=iaLI3T33; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71ec12160f6so4359748b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 16:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730245487; x=1730850287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcvA1auSaL3VFQzS81Rs8lzkbF+oHOz6Si8rlZEwmTE=;
        b=iaLI3T33QhV49nx8U9Z27wlutM3RtJ2KijBeDVaVtWUADpmjI/5yX/3Vhw96fm9itN
         xe5SV2arf4slVKVGHcRGChc1cbjMHgS7rxtnduxxAn3mm8grGOIsCxHxRY7gvAtInB1h
         VhvPyn4CIuRMiJubIp7yrkKkIrusmxNvh4q+1zTSGBqPnFL2aPXjOTSfh1j2H5fWkJvS
         O1ump79d3BDvcxfyVLk49dAijb8yJd5luk+vl0P4GWjneHSK0BchDWNX761dNnaTeaXJ
         pM/FCvJeeOf88TcwQRSHrVHCMzy4EK+4jIJ5hZXWCnGexOVE/vEm5nx1Jcsv/zBw7lqc
         8caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245487; x=1730850287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcvA1auSaL3VFQzS81Rs8lzkbF+oHOz6Si8rlZEwmTE=;
        b=L/f9K0JWYlEeONGQac2ZJc8P5BYIGW6h5rAK5CkIlH1Jgxp0irAOF5W5yjO3Z4dHhZ
         ciLj+4OfJoSk8T/VJ3CBXXS8YWnQ3rg5vi79gOMOca8rTLE+u8mhAyoQRXffUah4LSM4
         N9lsMd83Y3Lwf+X3Zh+CLDuYrVqV/Ty1PoLkj6mQwWLHNU7hPq7WdxLuPIGFqIbuuvu0
         Cds0U05nFZ291Nsx+x1Fn4OAt+T32pwp3DlKqzMePenvv8aSYxq121lJMneNYTm43cOz
         gPvCExdiCVGrnyQ3veelTvAzioJoln9rKSYzC7vRyqiQKDcgjjKXMaSsQN7dGIxRpuJH
         R9mw==
X-Forwarded-Encrypted: i=1; AJvYcCXOz2ZUe103C3HzoCB/K1lcXkEjxsEdNrsL40Y98+c0SSqU0qBwhmxRuqElBmzQdIveRble7n+1LfhuOvpc@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8AY3gD+bc62tgN+BpV9my7cHGx7AaOVyBP8QZQfxwv0KNdiQ
	bERNrxdJjLTMqEJmeuztBSSpProFM4CJOr7+wq186OObnvzpXkl7RFuTAsSQTLg=
X-Google-Smtp-Source: AGHT+IGGMP4Pw+lp+LPCrok5EqwNoJFdizqNNUNEZiV3YZc6kA7wl06mzdMMPrxb/Znt26d5Smw70g==
X-Received: by 2002:a05:6a20:c797:b0:1d4:fcd0:5bea with SMTP id adf61e73a8af0-1d9a83ab7f2mr18393767637.6.1730245486894;
        Tue, 29 Oct 2024 16:44:46 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm8157643b3a.33.2024.10.29.16.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:44:46 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Oct 2024 16:44:12 -0700
Subject: [PATCH v7 12/32] riscv mmu: teach pte_mkwrite to manufacture
 shadow stack PTEs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-v5_user_cfi_series-v7-12-2727ce9936cb@rivosinc.com>
References: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
In-Reply-To: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

pte_mkwrite creates PTEs with WRITE encodings for underlying arch.
Underlying arch can have two types of writeable mappings. One that can be
written using regular store instructions. Another one that can only be
written using specialized store instructions (like shadow stack stores).
pte_mkwrite can select write PTE encoding based on VMA range (i.e.
VM_SHADOW_STACK)

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h |  7 +++++++
 arch/riscv/mm/pgtable.c          | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 2c6edc8d04a3..7963ab11d924 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -416,6 +416,10 @@ static inline pte_t pte_wrprotect(pte_t pte)
 
 /* static inline pte_t pte_mkread(pte_t pte) */
 
+struct vm_area_struct;
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
+#define pte_mkwrite pte_mkwrite
+
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_WRITE);
@@ -738,6 +742,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
 }
 
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+#define pmd_mkwrite pmd_mkwrite
+
 static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 {
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 4ae67324f992..be5d38546bb3 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -155,3 +155,20 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 	return pmd;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pte_mkwrite_shstk(pte);
+
+	return pte_mkwrite_novma(pte);
+}
+
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pmd_mkwrite_shstk(pmd);
+
+	return pmd_mkwrite_novma(pmd);
+}
+

-- 
2.34.1


