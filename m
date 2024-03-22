Return-Path: <linux-fsdevel+bounces-15123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D330788740B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 20:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39239B21C99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 19:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5087EF12;
	Fri, 22 Mar 2024 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i42+tOI/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77767A151;
	Fri, 22 Mar 2024 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711137374; cv=none; b=cZsGX7LZamT52MeVFcc1WP+zAaLzUfdFhTl/uXik6u1/R0Zuz/F/UPb7l10nnXPFmUq/be/yaelPCqi4OyZ7klIZE5gukZL77JmxG+RBPOv+D1FKm7BhsCJNUe8r7DTxqhI++DAwngaAK4L0YJFY70ZwL2a0ufpUtVcMYOw/hYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711137374; c=relaxed/simple;
	bh=XG/8nAA84yrNDqtezrZQs0GeGmlIyHC5ccr2D7I5Psg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BsY4UDxNcGmLfLUhNPJR8c/xAwwnJuobaNNSO+8HKrz5LfApSGfnXUb6JW9EJTM1q+Ngc2ocy9S6a5UVx9+gLra4bn2fnKkToz+Ierzxtfmiemev8yY0G/kXr/YYOn2RFM/W0Jhb8vSdHmLey6dk398UMdjpRoMiGjOHgY01blo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i42+tOI/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e08512cd8dso12890325ad.2;
        Fri, 22 Mar 2024 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711137372; x=1711742172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lkyJkArLDERo9g91DtAYBhws6AL+vDlqpRplXqxob5c=;
        b=i42+tOI/T+pOcAaO4SqQ7EGbD4T6OjVpGEQDj+nAOH7u3i65QKSijZpNvOK1BF87vj
         FWCj5djWBgDbOxGMFRU9lzH0Tc+IQoTOTJQV1M7g//Sl+rJdT3ibyciv3a20eG29Ut6L
         oxraGhQyBHKCqLd2NtwSoeey6qlghbH5noCyfwFLs23g2zeFRAnKO94pQQ5rKUajQ5fv
         klpun2YtCcxfmfxCXh8b4GeX/ZwaaSHTliE+IIhJNFoPeqO252BRd1a/3ENE673F88Dd
         uX5hb/cD/vd1eFGZyA0fmMEuImRB0+o12bC1wtZYpVdqHYNevIip5w9NX0u3C1RjQxMb
         LqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711137372; x=1711742172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkyJkArLDERo9g91DtAYBhws6AL+vDlqpRplXqxob5c=;
        b=iNZBpv8O3cNM8NClQyL0Xk/9CHJW7uSu3Cj8Mmw76G6pELlb7e0ySlLZ5GcBkk6wju
         Xc0vRW3vCQtbkH53QtF69UNfY+smzpy9qNUqpybpaw6nOhfHv5sOOQOgYjbcifPpkS0G
         zc55nKWyqNyPCz45U6x+HqLrGxkxpx5YY7Cw8O3K8gIuA67Ym3BlvlsC+3TQ8ER245Vs
         NIKQCUEDd1zok/nEl/G+9p/LoVg9gJPiJiLPESyqhk6rsSF3dHqXEwMMpssNm4lV1zB4
         bDpuohJZO10VtoPkEZjv5lcGoWArJy3FnK3mb0OQ3WHkm6w0tDTCTG/QPP3eWq51UYP5
         bQFg==
X-Forwarded-Encrypted: i=1; AJvYcCXPlTQILLCmCJSwdgVKU0j4UWS31K6wwf5IDO+oe4XB7vZd2HwSfGOnwpPzkaht7ARe7n9NHQj9aBVhSkLCM2eQUH2A+CvY0eVkWq3uCA==
X-Gm-Message-State: AOJu0YynuJGasRm7J1RaLCFAoLH88qmHclEBmV0GFSoSEDXX+FgAQQy4
	UWfNRY+jfEuA4zV3/b+KdcuzPpqwlCsCuqWFUzWop/KssSvAfIfAA6oIn5nM
X-Google-Smtp-Source: AGHT+IF6ob1NPeuDZPbaHWZhsuj5S+pJqN8Jp54xrN2M5U36hty3pL3eFm8RTKBnSj4PZ0J/zhBa9A==
X-Received: by 2002:a17:902:a513:b0:1e0:4aac:e547 with SMTP id s19-20020a170902a51300b001e04aace547mr616154plq.58.1711137371807;
        Fri, 22 Mar 2024 12:56:11 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a200:bbd0:710e:e701:408c:9832])
        by smtp.gmail.com with ESMTPSA id jo6-20020a170903054600b001dcc2951c02sm112628plb.286.2024.03.22.12.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 12:56:11 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] binfmt_elf_fdpic: fix /proc/<pid>/auxv
Date: Fri, 22 Mar 2024 12:54:18 -0700
Message-Id: <20240322195418.2160164-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Althought FDPIC linux kernel provides /proc/<pid>/auxv files they are
empty because there's no code that initializes mm->saved_auxv in the
FDPIC ELF loader.

Synchronize FDPIC ELF aux vector setup with ELF. Replace entry-by-entry
aux vector copying to userspace with initialization of mm->saved_auxv
first and then copying it to userspace as a whole.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 fs/binfmt_elf_fdpic.c | 88 +++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 46 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index fefc642541cb..7b4542a0cbe3 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -505,8 +505,9 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	char *k_platform, *k_base_platform;
 	char __user *u_platform, *u_base_platform, *p;
 	int loop;
-	int nr;	/* reset for each csp adjustment */
 	unsigned long flags = 0;
+	int ei_index;
+	elf_addr_t *elf_info;
 
 #ifdef CONFIG_MMU
 	/* In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
@@ -601,44 +602,24 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	csp -= sp & 15UL;
 	sp -= sp & 15UL;
 
-	/* put the ELF interpreter info on the stack */
-#define NEW_AUX_ENT(id, val)						\
-	do {								\
-		struct { unsigned long _id, _val; } __user *ent, v;	\
-									\
-		ent = (void __user *) csp;				\
-		v._id = (id);						\
-		v._val = (val);						\
-		if (copy_to_user(ent + nr, &v, sizeof(v)))		\
-			return -EFAULT;					\
-		nr++;							\
+	/* Create the ELF interpreter info */
+	elf_info = (elf_addr_t *)mm->saved_auxv;
+	/* update AT_VECTOR_SIZE_BASE if the number of NEW_AUX_ENT() changes */
+#define NEW_AUX_ENT(id, val) \
+	do { \
+		*elf_info++ = id; \
+		*elf_info++ = val; \
 	} while (0)
 
-	nr = 0;
-	csp -= 2 * sizeof(unsigned long);
-	NEW_AUX_ENT(AT_NULL, 0);
-	if (k_platform) {
-		nr = 0;
-		csp -= 2 * sizeof(unsigned long);
-		NEW_AUX_ENT(AT_PLATFORM,
-			    (elf_addr_t) (unsigned long) u_platform);
-	}
-
-	if (k_base_platform) {
-		nr = 0;
-		csp -= 2 * sizeof(unsigned long);
-		NEW_AUX_ENT(AT_BASE_PLATFORM,
-			    (elf_addr_t) (unsigned long) u_base_platform);
-	}
-
-	if (bprm->have_execfd) {
-		nr = 0;
-		csp -= 2 * sizeof(unsigned long);
-		NEW_AUX_ENT(AT_EXECFD, bprm->execfd);
-	}
-
-	nr = 0;
-	csp -= DLINFO_ITEMS * 2 * sizeof(unsigned long);
+#ifdef ARCH_DLINFO
+	/*
+	 * ARCH_DLINFO must come first so PPC can do its special alignment of
+	 * AUXV.
+	 * update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT() in
+	 * ARCH_DLINFO changes
+	 */
+	ARCH_DLINFO;
+#endif
 	NEW_AUX_ENT(AT_HWCAP,	ELF_HWCAP);
 #ifdef ELF_HWCAP2
 	NEW_AUX_ENT(AT_HWCAP2,	ELF_HWCAP2);
@@ -659,17 +640,32 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_EGID,	(elf_addr_t) from_kgid_munged(cred->user_ns, cred->egid));
 	NEW_AUX_ENT(AT_SECURE,	bprm->secureexec);
 	NEW_AUX_ENT(AT_EXECFN,	bprm->exec);
+	if (k_platform) {
+		NEW_AUX_ENT(AT_PLATFORM,
+			    (elf_addr_t)(unsigned long)u_platform);
+	}
+	if (k_base_platform) {
+		NEW_AUX_ENT(AT_BASE_PLATFORM,
+			    (elf_addr_t)(unsigned long)u_base_platform);
+	}
+	if (bprm->have_execfd) {
+		NEW_AUX_ENT(AT_EXECFD, bprm->execfd);
+	}
+#undef NEW_AUX_ENT
+	/* AT_NULL is zero; clear the rest too */
+	memset(elf_info, 0, (char *)mm->saved_auxv +
+	       sizeof(mm->saved_auxv) - (char *)elf_info);
 
-#ifdef ARCH_DLINFO
-	nr = 0;
-	csp -= AT_VECTOR_SIZE_ARCH * 2 * sizeof(unsigned long);
+	/* And advance past the AT_NULL entry.  */
+	elf_info += 2;
 
-	/* ARCH_DLINFO must come last so platform specific code can enforce
-	 * special alignment requirements on the AUXV if necessary (eg. PPC).
-	 */
-	ARCH_DLINFO;
-#endif
-#undef NEW_AUX_ENT
+	ei_index = elf_info - (elf_addr_t *)mm->saved_auxv;
+	csp -= ei_index * sizeof(elf_addr_t);
+
+	/* Put the elf_info on the stack in the right place.  */
+	if (copy_to_user((void __user *)csp, mm->saved_auxv,
+			 ei_index * sizeof(elf_addr_t)))
+		return -EFAULT;
 
 	/* allocate room for argv[] and envv[] */
 	csp -= (bprm->envc + 1) * sizeof(elf_caddr_t);
-- 
2.39.2


