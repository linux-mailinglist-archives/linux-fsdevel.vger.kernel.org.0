Return-Path: <linux-fsdevel+bounces-47695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCFEAA41D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 06:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1031BA5DAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 04:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837311DE884;
	Wed, 30 Apr 2025 04:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD8lCl8+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1641DDC0B;
	Wed, 30 Apr 2025 04:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987259; cv=none; b=FTgi2xiytNWNKmq1u8aCsSDYBS8tmZaU4MGWz20dqDAqs0+8vqW8vpJBEtNyRgBXGUSlnHNSrikXE5GF8XBpvhkX38jPsqEviR4bXJIINymstLu2CPmVCvDzwgYN3zmI9al9a4hCWzT2YtOBuWhzt7W/yS2FR2NVh8BHiEQLmkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987259; c=relaxed/simple;
	bh=Xn2RaNaReEp4HS2lM2B2ydz2zvsDs19KOeICSn68auQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIAowwA+y875W3mMoTeVldVF0drFja49vkSbT8gnXKeEAW3huXNkxS+/Wk/42Xncemutko7/9TlGBu3IKnwou00kspJqX8+VyfBABrEV9nCmAd0SS6QBpmvsqYEjWIKKzIL7mf8wq7ggOkkmcp0lmaGN7t02hH3O5HxNH9RPtrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD8lCl8+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736b350a22cso5935730b3a.1;
        Tue, 29 Apr 2025 21:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745987256; x=1746592056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukyNfs65nuvgTdhSkdJYZ2Y9345NLuFCWN/gVQv/aLg=;
        b=TD8lCl8+4G0M0WrTETIkaFHmAy7rEYq3lHZh2OQkn56OD5IwcFi1OHdpDOV/rNabRG
         2BqLGz6hPsiTIrYFhyv1RNkkneRCouJRYn+Cf+O5ZpGOolQaLRRysZnzMGyv8Bp5rsTo
         4Nsx7KE399i1n6vyTSHUJ1N8XeIMtf7rqCDlK0BiS7FG5DytFMx81Xs9ZJnS4Ffe2xix
         dcTzFyGJ8AQbg8NguVw3urySkJopvZ+m3qoALOUg3vpOtOQ9c1//kds/CC3uuG2BsUEk
         oTqmWY2l8N0gDe4YMLvpV20PTv38nsN6aiAESJqequeFbzO6268/hVBoTHGBmykE8mBM
         VFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745987256; x=1746592056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukyNfs65nuvgTdhSkdJYZ2Y9345NLuFCWN/gVQv/aLg=;
        b=T+ebLpiyAdPQTWaMjVCc+l0u35GDxROJg5GZGIDsj0sLQXrsncKVNAe2CT2DWGXKYa
         z/ASZizTXfCKCFYh8PQ0GenlovshhciPXB64Zii0w0DUZMuTi8lx5HqbYULIEU3TEMaa
         XT493hdtUvcQ4407s0zKqx7Csz8IFQIJFrdyt61adl1npWVnhkYIc0W94xiu9jwv0Y3D
         +jgtEhgv7Xo6I05+H/3teeWWMWyJCepcyija4nB6iojirPQ3GDlFRyGH3doPMLN6OAeZ
         w/2dH3Bc9jlGBKbWN7LnA0ohmGckfLuBODozyLqt7+7XAgQkNuwOQLJgY42lre80S68V
         0uLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUur8/CfQ4/zfl+tyDSSTD9KkP6jyBAsrfNC9qS18iA1b65e1FdyevgsW/zQR4u7gtXMxgXIpWiRYbhrA5@vger.kernel.org, AJvYcCXgYpwquD9TGplZK/WD9qA9piQ/UJW8zQFJXYZaqBFmvbnzANzXMXtUSrY01UaXTLzQLY8ztCpQSSPM685H@vger.kernel.org
X-Gm-Message-State: AOJu0YwBeKR2R6GIXVmz+no9FiAeYxnJg/f7z1TTtwjBiTuW0APu0J9h
	0hSN1tYFhMOdAf9q90oWHI7RxnDFgsi3AwJeic0HKGNiJEuJfSC56afMhZFomD4=
X-Gm-Gg: ASbGncu8GTt6SZc0WyFzPgHb0qvf1+gHDy3qQQszrKxyvC/mc0iDE3xP1FzkMPno9V3
	Ua/0NIq4v0/9plZ0Je81yoM/TG6/U+22rK/ArVtLIwMPjyhWZo111hmxcFczUKeS8USzle8OpYE
	XgrOas1ht5QdJdm1kgdxginn7xkdejskIDARRgbRGyQXGhYZ4/Qf9SQw4wCpjQylV6IyDn/188a
	dWHsChVMvg70QE41RMcghp1om2SAhPFoLS6Y3Tby/MuddaJknrlQO90oW/kkEMyM4vEDsGdawZz
	p9d4u88yu8N1cvriMfSi50jKNKef8Yu9NBfjm8JjgH78iE5N+bBwEXP8Gl/c/zUP33uRbZQ6EtD
	Rc7YWzCu0JbM=
X-Google-Smtp-Source: AGHT+IHaI2hva/XO5UNyBlcemnxgGJqm96jqA3suKBcAYtlVKSOpmAkCAY78xziMTfLiN3rWee/VXA==
X-Received: by 2002:a05:6a00:2e24:b0:736:39d4:ccf6 with SMTP id d2e1a72fcca58-74038989daemr2827463b3a.8.1745987256524;
        Tue, 29 Apr 2025 21:27:36 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740398f9ac3sm621129b3a.23.2025.04.29.21.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 21:27:35 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id DC01FE94814; Wed, 30 Apr 2025 13:27:33 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v8 01/12] x86/um: nommu: elf loader for fdpic
Date: Wed, 30 Apr 2025 13:27:07 +0900
Message-ID: <1f0ec32dbc49f8784995a29a2e87063507eb9838.1745980082.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745980082.git.thehajime@gmail.com>
References: <cover.1745980082.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As UML supports CONFIG_MMU=n case, it has to use an alternate ELF
loader, FDPIC ELF loader.  In this commit, we added necessary
definitions in the arch, as UML has not been used so far.  It also
updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Acked-by: Kees Cook <kees@kernel.org>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/include/asm/mmu.h            | 5 +++++
 arch/um/include/asm/ptrace-generic.h | 6 ++++++
 arch/x86/um/asm/elf.h                | 8 ++++++--
 fs/Kconfig.binfmt                    | 2 +-
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index a3eaca41ff61..01422b761aa0 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -14,6 +14,11 @@ typedef struct mm_context {
 	/* Address range in need of a TLB sync */
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
+
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	unsigned long   exec_fdpic_loadmap;
+	unsigned long   interp_fdpic_loadmap;
+#endif
 } mm_context_t;
 
 #endif
diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 4696f24d1492..4ff844bcb1cd 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -29,6 +29,12 @@ struct pt_regs {
 
 #define PTRACE_OLDSETOPTIONS 21
 
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+#define PTRACE_GETFDPIC		31
+#define PTRACE_GETFDPIC_EXEC	0
+#define PTRACE_GETFDPIC_INTERP	1
+#endif
+
 struct task_struct;
 
 extern long subarch_ptrace(struct task_struct *child, long request,
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 62ed5d68a978..33f69f1eac10 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -9,6 +9,7 @@
 #include <skas.h>
 
 #define CORE_DUMP_USE_REGSET
+#define ELF_FDPIC_CORE_EFLAGS  0
 
 #ifdef CONFIG_X86_32
 
@@ -190,8 +191,11 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 extern unsigned long um_vdso_addr;
 #define AT_SYSINFO_EHDR 33
-#define ARCH_DLINFO	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr)
-
+#define ARCH_DLINFO						\
+do {								\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr);		\
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, 0);			\
+} while (0)
 #endif
 
 typedef unsigned long elf_greg_t;
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index bd2f530e5740..419ba0282806 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
-	depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
+	depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && !MMU)
 	select ELFCORE
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load
-- 
2.43.0


