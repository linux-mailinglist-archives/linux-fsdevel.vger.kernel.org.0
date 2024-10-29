Return-Path: <linux-fsdevel+bounces-33179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC93A9B573E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 00:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784BE1F2136B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 23:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B51820C49D;
	Tue, 29 Oct 2024 23:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XGHUuXWS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9B20C302
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245464; cv=none; b=nmehMhv+5P5R7HnDAOJ6/SzYaO25j0iwyaP0WhbbiXXqCH+Bs31VQMujX01Lp1qTJGfkOgNARYXN9yZnM5k9BlMEa4pMijktmYNqGzsoQNLn5vp7qCVE8nFCidMUu2TAR48S1qNVjHEAFVpdveLFMBdiu8lgbDZM4j+xeQmxY3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245464; c=relaxed/simple;
	bh=taB6zPBIQMkGZpaolhVAh5cbajPWClwgP0LivE4GGks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HaZ0KOR2sN4EzOp4pbSaccj/i/EfOVDW3VVfLEBdHug015rwYPXrDXqbcQsFIZ5dJoe2EAwZ30fjodQWWHLDecy06lraq74piAwoMaATCaia/fiRZGoeASnZPdI6Ucdd7GxlOWrMyEiPICZ3M/RBTg2Y3jWaNn2Uq6TF0W0frLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XGHUuXWS; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ed9f1bcb6bso4111168a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 16:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730245461; x=1730850261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+Jub7HVMuRDhaa+pd538ONaRqIx67oBmBuHa5UsgJY=;
        b=XGHUuXWSWzT7Pr146OHL2UFXI3x0/Pm0HZ2Ag1e1cjXOsgsX8WCLAFTbDMDFcGol07
         4S75UnnkE8DOzOKDdTBoF5MeuTxu+yBw0xRTx6TVrUDmO7E18BoMoUvvUILXL5nJ816u
         CtrmqrXjhVEtti8NOAhqpAfB38cLCfnmDGtdsKmIG3O0jatBeiQdf0t+3Zg/oQSfaF0X
         pEOd6S32M0QXzMPdMjKrPEBuyFSM6sMbvbBYGS1MMYZMRNEJ+koUAdbilW97UAWv5b9I
         pIOe+DzT69u8MOq/qltLZArg336qKOaT+cu5MNsbHLIudM4R7E7Pbg4JluLEWAZM8qHO
         zS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245461; x=1730850261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+Jub7HVMuRDhaa+pd538ONaRqIx67oBmBuHa5UsgJY=;
        b=LilZDu4KOY8nPEWQxsgIKTBmEHMYfzAJw/tVaYmGKmfDH4dIqL68PhWk9tCx500XdG
         XOemUj59WTYGBNzgj7EXu+3w/C76BJpTxFv+pQcgF9k7x+KP+RAXqMcn47mp2OK1JJlz
         BEedQf6V+7H0wFrpY490COnTo1636aSGNlMGsn49QwWTgIkCgkkkPt3Ypm32ZAOIq3NK
         1XRlLog8boMu5jKAk6gCYujDhYzkSQq3WCl1wpB7mrNPvQmu3gELG6fNRd6ArccpNmx2
         Z0qJUKZo5YQWeKHtCOtyRgVMDdkuLeoIni8meOzRrLyw+v4FEpejPcG43+V2A+JxdVfK
         Vlew==
X-Forwarded-Encrypted: i=1; AJvYcCWE38zCuyObMMestSZgz7t4SLm/TdhjPKDmwPwf9l3u5c88wpLIwVn98xKzMV4rdGGK4koq/DbBdFSfng+5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz40LFnMQ0710VnUVq4zTy0G32K5qAEGTLUN5XrCccp2ku9/dZM
	a/as3ondwxEXnU53t5FMeCWef7h48CH1zAY+GNvy0b4TGxMsLw+1U3gE3xeOXG0=
X-Google-Smtp-Source: AGHT+IHoPlZyTKRFIXDxqY1vxKZ9N2lRuciBVtR3dVasMoQZpZgRn99fcKxS5v1VlmJJEo1cy5cChA==
X-Received: by 2002:a05:6a20:2d0a:b0:1d8:ac0b:2f63 with SMTP id adf61e73a8af0-1d9a853aa7amr16243300637.47.1730245460885;
        Tue, 29 Oct 2024 16:44:20 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm8157643b3a.33.2024.10.29.16.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:44:20 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Oct 2024 16:44:02 -0700
Subject: [PATCH v7 02/32] mm: helper `is_shadow_stack_vma` to check shadow
 stack vma
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-v5_user_cfi_series-v7-2-2727ce9936cb@rivosinc.com>
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

VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow
stack). In case architecture doesn't implement shadow stack, it's VM_NONE
Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
or not.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 mm/gup.c  |  2 +-
 mm/mmap.c |  2 +-
 mm/vma.h  | 10 +++++++---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a82890b46a36..8e6e14179f6c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1282,7 +1282,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		    !writable_file_mapping_allowed(vma, gup_flags))
 			return -EFAULT;
 
-		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
+		if (!(vm_flags & VM_WRITE) || is_shadow_stack_vma(vm_flags)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..0853e6784069 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -708,7 +708,7 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
  */
 static inline unsigned long stack_guard_placement(vm_flags_t vm_flags)
 {
-	if (vm_flags & VM_SHADOW_STACK)
+	if (is_shadow_stack_vma(vm_flags))
 		return PAGE_SIZE;
 
 	return 0;
diff --git a/mm/vma.h b/mm/vma.h
index 819f994cf727..0f238dc37231 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -357,7 +357,7 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
 }
 
 /*
- * These three helpers classifies VMAs for virtual memory accounting.
+ * These four helpers classifies VMAs for virtual memory accounting.
  */
 
 /*
@@ -368,6 +368,11 @@ static inline bool is_exec_mapping(vm_flags_t flags)
 	return (flags & (VM_EXEC | VM_WRITE | VM_STACK)) == VM_EXEC;
 }
 
+static inline bool is_shadow_stack_vma(vm_flags_t vm_flags)
+{
+	return !!(vm_flags & VM_SHADOW_STACK);
+}
+
 /*
  * Stack area (including shadow stacks)
  *
@@ -376,7 +381,7 @@ static inline bool is_exec_mapping(vm_flags_t flags)
  */
 static inline bool is_stack_mapping(vm_flags_t flags)
 {
-	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
+	return ((flags & VM_STACK) == VM_STACK) || is_shadow_stack_vma(flags);
 }
 
 /*
@@ -387,7 +392,6 @@ static inline bool is_data_mapping(vm_flags_t flags)
 	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE;
 }
 
-
 static inline void vma_iter_config(struct vma_iterator *vmi,
 		unsigned long index, unsigned long last)
 {

-- 
2.34.1


