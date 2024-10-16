Return-Path: <linux-fsdevel+bounces-32149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2879A1556
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 23:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1031F25AB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 21:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F641D54CD;
	Wed, 16 Oct 2024 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="L5E+G1+h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0B1D4329
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115861; cv=none; b=OCQbOrlv6PZ2BBcmfqunBiOcFDzyzH40IbE/KV3MoSWLk1ltXH0m3SNrN8SgCpXU8q97xxMKjS/1I/Nvry2t3tCMMu4RGgdreJINPJmzLO63f2q2zrTU0Owj4UIAcyB6nnsaVmGjLgRnjrOYfQXPsZWbQU3qUJA1iT5qTyDGuGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115861; c=relaxed/simple;
	bh=KER36AhrhNilmC6ZzGGj+tV3onqJdyNmitNCJK0gljQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UoKdYhICU9BKc1pzuHQk4TIFeLWmyFOH5e/lKkgVEE+pGTGkxdj/v7/1iknZVSUPnS/2CrL1n5ILbTtUFASa+5iuVInaFZ6R+4X0DppNskTgAf+x2vupkrCbNf63q9uZu9cKgZA6+XcMmidqc6jZpRKg3wDHv7ntFlbjDykE8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=L5E+G1+h; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cf6eea3c0so2709375ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729115859; x=1729720659; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XdsLfzbeIJUmffXDRsTtiOytmZQkMd2fCbnSq93GpGM=;
        b=L5E+G1+hr7XiB3DaoANhN7oBMB2xqCDfBnhaudMLGimff698w/87gU1b3Is8Re8/io
         gC1QEfyGN8G0vTw7DqLhze5o1dnojb9qmXU9PPhCIT+gVEw/uBFV1IzKZ3szMrHil1iQ
         twXecinEybtvcnHaitzWtReMBIyiXJn7yTRnazxCbn5ZnestPgG3TjR5UNbVJ9cHWS0Y
         +mZNT+oSl5tjWvFW0sFRLkzzRrd5qITKnBAbL79EhKoH8aTHcpBnsMcn3FzMUFsiHfk+
         91xowfZSlsiSdHFEnCdizFeS1ItB9j0tq7G/w27RJj7wtt9yX3Mz49A4alWd/SEi0enf
         tGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115859; x=1729720659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdsLfzbeIJUmffXDRsTtiOytmZQkMd2fCbnSq93GpGM=;
        b=CE397TzyCHADH0g4yctyjwQVzrw7NrT1zw1x9/4sHP22POHslibKmPNT/NZS17RAKQ
         jiRNQj7eYdn6IsInlx+0tV+ud47t0lA0uXYPmRn94w2Yq8gnTxNHh/SV6Bmkp6Yv0fLF
         5VaPokPtQ63dUbIWjFFE1oI2qOkVxbzSTVFWxHqItUDPYJ5+lSeebQ2hT/h5uFDKBFxe
         rjpixtjWqfTwFbQQ+cAAEq75iSXcxXDKIozQgnd7hhq2afdgR/T/aLexKLg+YrxDH33D
         XHQ49bkNld/TPyLyJ1qJQatIJFWbi1bTzGoed5DGM2wx522C5xch9K+nNPPwGN1FAnxg
         D1Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWFrq14HA2LXrAQrdb5wp+xJATOuZxR9P+FrK/SIlhsQbad2MvZpQdx36v0uJv3fg4gZmFom8/PIKG5vEZn@vger.kernel.org
X-Gm-Message-State: AOJu0YwvrGi0E/tEZ9FzK5VKUuxAwe0QVYbAjL/gW25auftinXfRaB6b
	LWAIBBTnf5x4NMldOLjreZPbRa+uTTf/4m2uhQOebc/WWRReaMd5r4XE7zYBP8w=
X-Google-Smtp-Source: AGHT+IFluSxzlxpD9Tp1FCJcZbgYHrumOfhgLbhKxxdpf7sn2E/e71vVpkROxUYqoklPv+KqnK6MeQ==
X-Received: by 2002:a17:902:ea10:b0:20c:c704:629e with SMTP id d9443c01a7336-20d27f2f5eemr63371415ad.56.1729115858946;
        Wed, 16 Oct 2024 14:57:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f87ccasm32973295ad.62.2024.10.16.14.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:57:38 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 16 Oct 2024 14:57:33 -0700
Subject: [PATCH RFC/RFT v2 1/2] mm: helper `is_shadow_stack_vma` to check
 shadow stack vma
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-shstk_converge-v2-1-c41536eb5c3b@rivosinc.com>
References: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
In-Reply-To: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-arch@vger.kernel.org, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Mark Brown <broonie@kernel.org>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow
stack). In case architecture doesn't implement shadow stack, it's VM_NONE
Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
or not.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
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


