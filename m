Return-Path: <linux-fsdevel+bounces-40867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67348A280AF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 02:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE8C3A6254
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 01:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42EE22839A;
	Wed,  5 Feb 2025 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wyo03tkN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B1D21421E
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718518; cv=none; b=co/xdq/6U3q8TrTqXogSj9hADc9DvThJs1KA49q27lTu0PfeVQRmRyIGOljuaDiPLssawXFqXhuA8SowV1icfGDfBl7KaHNILPAgcnWo5/4nUrZktc7mFVjTwaRfa8qanRwU0UylW41Gjt8kUYBPDiGOZdIVN4EqLexq8XgSAHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718518; c=relaxed/simple;
	bh=4+rkxFDMRzeCaj67Ory62bJbPr1iEDQyQ7MtltlWZ10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iaeVhXqo3B5j39kxXHqZsyA6TQLG1wlWe9gXKbNmMGpaWYEcj/p7jGzkCuVrgTe1rRtPaA4T2fvijQqrdmNAC3o6oj/iYUGSurFrWuR+it80ReGotsipJvph8m7yG5vT0f2vHmItQMNmUbd+5Jg2uCUgr4BaN15lrDizlUnL8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wyo03tkN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21ddb406f32so20405615ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 17:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718516; x=1739323316; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZsmyzkl0ZY8OELLzFzrWZpLBbmgmsnkcCCgL90vWsc=;
        b=wyo03tkNsozIpN2wsPGkEGQIBE75Ic+tf5Fs50ie7PG/a/vP7aUgBRCKrhYUfq0uLp
         m9T1Ind/ejtZKjGePt4GAJu9x0eQu2XcFTd5jTzCzhpj1/a/UEppMI8xhw7mN0QowABB
         VhmGDbpgEBcNHAsPzzE0W6r+pmI4BbIlHl9msSO9ZtYldRwnsc+1NvfH4mDK6hCgzWOt
         +autw50ag2Oa8yE6JbYgqWje0+qWCUSnY/8EIjc5YgTeB07xSKm7NjVhjNCC0axErLQC
         XZCK5i6DY3zsAUpRjYZ6SDm+gLq3mEnMqyvZJd+UakAOdHNNDLppSxzSmzGf4QiqcLWw
         gG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718516; x=1739323316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZsmyzkl0ZY8OELLzFzrWZpLBbmgmsnkcCCgL90vWsc=;
        b=s1ij0H/ltDEB0/uV3rZ1NLYChZtI57njS2Zrf5Gquf3r+WVcYwP9LOzGQzXIHOiWhM
         Ezd9cagWRlnKvKgLOmEgE408edssHb8/tFXwMTNnXkAZy97HZ6WWrJH/uTLDH2Psi2F3
         qkza1x6nnBk8I3fiOrIWl/PuXGpDOA3MUCX/zB0i3R8yfW2KdSgdcpeJkzkMQ/5YJfvR
         NchH+HiL5udTkvA8VDfWoHgBxDw0ZOag0yqy/PmUU6MdntWNGTA41Zb5uk4ThCpM+KVa
         36RcI+2JQFrUIFW52ehWD937/HFSWTw82GKwlOFBnTR/Z2zCNmhLrvCzfXDltUk1tNum
         7Unw==
X-Forwarded-Encrypted: i=1; AJvYcCXMv5DtfUmFIkUi5GWqx79Q4kdGAN316qfXCC4911PACxO2gvtS/2CIRiLE9NE5v+gnV4tj2h7FtD6ZEh6I@vger.kernel.org
X-Gm-Message-State: AOJu0YyzFwZ+m0q7r2ZY5LF985Ouv1JejZkdlSYbARcNcrEXtqg8pKTa
	MrVOl9alYEYmmsvFKk5Gs5+r9OFEvjHjvWf9eC78UJtukxgIICHCozIouMRH2ko=
X-Gm-Gg: ASbGncsJ/T8RkX9tHSOxGiZZp25itwv0yaCjkP2nEAscG0IncYqNjeTu7/VoNUnY9oZ
	5P0N8kUIg/2V7y1i18b/vQ9xburWdXKT0XPj40DoVGwVpY+cwfaF6nLIhFictMH69pS+8sD2810
	+vs+4ykjXyI5bwFNVr9PBz28FWVrk5CZy5Chzhm7vqLa2KEYuVkUuGyqiwm6FhQk0oOKjpLIDjV
	5udidDjHVuwbtUapvvME0V1KJ77Wf7SB+WZOw1P7D/rRlR2cMsh7iogTxwaJe/IFDeEQfXtDkzg
	96RGivrK7PS48LGwCTjpZqWQvg==
X-Google-Smtp-Source: AGHT+IEGfToRmeKwtJLwJvQfR9G8FomtSd4VlGvn3V3djANNYRSyP8PCgL91KTN4ECR+cbbbSTicog==
X-Received: by 2002:a05:6a21:9007:b0:1ed:9e58:5195 with SMTP id adf61e73a8af0-1ede8834f7cmr1948485637.13.1738718515327;
        Tue, 04 Feb 2025 17:21:55 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:21:55 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 04 Feb 2025 17:21:48 -0800
Subject: [PATCH v9 01/26] mm: helper `is_shadow_stack_vma` to check shadow
 stack vma
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-v5_user_cfi_series-v9-1-b37a49c5205c@rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
In-Reply-To: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
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
index 3883b307780e..8c64f3ff34ab 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1291,7 +1291,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		    !writable_file_mapping_allowed(vma, gup_flags))
 			return -EFAULT;
 
-		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
+		if (!(vm_flags & VM_WRITE) || is_shadow_stack_vma(vm_flags)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/*
diff --git a/mm/mmap.c b/mm/mmap.c
index cda01071c7b1..7b6be4eec35d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -648,7 +648,7 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
  */
 static inline unsigned long stack_guard_placement(vm_flags_t vm_flags)
 {
-	if (vm_flags & VM_SHADOW_STACK)
+	if (is_shadow_stack_vma(vm_flags))
 		return PAGE_SIZE;
 
 	return 0;
diff --git a/mm/vma.h b/mm/vma.h
index a2e8710b8c47..47482a25f5c3 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -278,7 +278,7 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
 }
 
 /*
- * These three helpers classifies VMAs for virtual memory accounting.
+ * These four helpers classifies VMAs for virtual memory accounting.
  */
 
 /*
@@ -289,6 +289,11 @@ static inline bool is_exec_mapping(vm_flags_t flags)
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
@@ -297,7 +302,7 @@ static inline bool is_exec_mapping(vm_flags_t flags)
  */
 static inline bool is_stack_mapping(vm_flags_t flags)
 {
-	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
+	return ((flags & VM_STACK) == VM_STACK) || is_shadow_stack_vma(flags);
 }
 
 /*
@@ -308,7 +313,6 @@ static inline bool is_data_mapping(vm_flags_t flags)
 	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE;
 }
 
-
 static inline void vma_iter_config(struct vma_iterator *vmi,
 		unsigned long index, unsigned long last)
 {

-- 
2.34.1


