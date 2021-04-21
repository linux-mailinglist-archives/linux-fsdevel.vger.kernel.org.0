Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B357C366823
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 11:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbhDUJgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 05:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238398AbhDUJgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618997731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7qvhkAj80F0f8sUzXVK2VmCO6sZ1NBwAvOrU2zYZZ20=;
        b=Et5WzwNolKCQKj/PxTpgvJ13qfhigHOR3eob+Kl3zXPz6bZj3GUW8ag2GU0txEkXnuT/XK
        HZrAMLe4EBLVa+Odakb109RWLxgpbWXQxYnC8g52f8PFtSxUTHsW+HxHmJVSu1UogHrHbz
        zHWfErflDM5+98H2gbJ98EkrS0nsfZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-7SA-dhntPrOeJQy9WxNSdw-1; Wed, 21 Apr 2021 05:35:29 -0400
X-MC-Unique: 7SA-dhntPrOeJQy9WxNSdw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97CCA106BC7E;
        Wed, 21 Apr 2021 09:35:26 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-224.ams2.redhat.com [10.36.113.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D03E45DAA5;
        Wed, 21 Apr 2021 09:35:15 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Feng Tang <feng.tang@intel.com>,
        Don Zickus <dzickus@redhat.com>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v1 2/3] binfmt: remove in-tree usage of MAP_EXECUTABLE
Date:   Wed, 21 Apr 2021 11:34:52 +0200
Message-Id: <20210421093453.6904-3-david@redhat.com>
In-Reply-To: <20210421093453.6904-1-david@redhat.com>
References: <20210421093453.6904-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ever since commit e9714acf8c43 ("mm: kill vma flag VM_EXECUTABLE and
mm->num_exe_file_vmas"), VM_EXECUTABLE is gone and MAP_EXECUTABLE is
essentially completely ignored. Let's remove all usage of
MAP_EXECUTABLE.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/ia32/ia32_aout.c |  4 ++--
 fs/binfmt_aout.c          |  4 ++--
 fs/binfmt_elf.c           |  2 +-
 fs/binfmt_elf_fdpic.c     | 11 ++---------
 fs/binfmt_flat.c          |  2 +-
 5 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
index a09fc37ead9d..5e5b9fc2747f 100644
--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -203,7 +203,7 @@ static int load_aout_binary(struct linux_binprm *bprm)
 		error = vm_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
 				PROT_READ | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE |
-				MAP_EXECUTABLE | MAP_32BIT,
+				MAP_32BIT,
 				fd_offset);
 
 		if (error != N_TXTADDR(ex))
@@ -212,7 +212,7 @@ static int load_aout_binary(struct linux_binprm *bprm)
 		error = vm_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
 				PROT_READ | PROT_WRITE | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE |
-				MAP_EXECUTABLE | MAP_32BIT,
+				MAP_32BIT,
 				fd_offset + ex.a_text);
 		if (error != N_DATADDR(ex))
 			return error;
diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index 3e84e9bb9084..12461f3ed04f 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -222,7 +222,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
 
 		error = vm_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
 			PROT_READ | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
+			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE;
 			fd_offset);
 
 		if (error != N_TXTADDR(ex))
@@ -230,7 +230,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
 
 		error = vm_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
 				PROT_READ | PROT_WRITE | PROT_EXEC,
-				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
+				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE;
 				fd_offset + ex.a_text);
 		if (error != N_DATADDR(ex))
 			return error;
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index b12ba98ae9f5..e0427b817425 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1070,7 +1070,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		elf_prot = make_prot(elf_ppnt->p_flags, &arch_state,
 				     !!interpreter, false);
 
-		elf_flags = MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE;
+		elf_flags = MAP_PRIVATE | MAP_DENYWRITE;
 
 		vaddr = elf_ppnt->p_vaddr;
 		/*
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 3cfd6cd46f26..8723b6686b66 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -928,7 +928,7 @@ static int elf_fdpic_map_file_constdisp_on_uclinux(
 {
 	struct elf32_fdpic_loadseg *seg;
 	struct elf32_phdr *phdr;
-	unsigned long load_addr, base = ULONG_MAX, top = 0, maddr = 0, mflags;
+	unsigned long load_addr, base = ULONG_MAX, top = 0, maddr = 0;
 	int loop, ret;
 
 	load_addr = params->load_addr;
@@ -948,12 +948,8 @@ static int elf_fdpic_map_file_constdisp_on_uclinux(
 	}
 
 	/* allocate one big anon block for everything */
-	mflags = MAP_PRIVATE;
-	if (params->flags & ELF_FDPIC_FLAG_EXECUTABLE)
-		mflags |= MAP_EXECUTABLE;
-
 	maddr = vm_mmap(NULL, load_addr, top - base,
-			PROT_READ | PROT_WRITE | PROT_EXEC, mflags, 0);
+			PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE, 0);
 	if (IS_ERR_VALUE(maddr))
 		return (int) maddr;
 
@@ -1046,9 +1042,6 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
 		if (phdr->p_flags & PF_X) prot |= PROT_EXEC;
 
 		flags = MAP_PRIVATE | MAP_DENYWRITE;
-		if (params->flags & ELF_FDPIC_FLAG_EXECUTABLE)
-			flags |= MAP_EXECUTABLE;
-
 		maddr = 0;
 
 		switch (params->flags & ELF_FDPIC_FLAG_ARRANGEMENT) {
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index b9c658e0548e..98c2329d23d7 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -567,7 +567,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 		pr_debug("ROM mapping of file (we hope)\n");
 
 		textpos = vm_mmap(bprm->file, 0, text_len, PROT_READ|PROT_EXEC,
-				  MAP_PRIVATE|MAP_EXECUTABLE, 0);
+				  MAP_PRIVATE, 0);
 		if (!textpos || IS_ERR_VALUE(textpos)) {
 			ret = textpos;
 			if (!textpos)
-- 
2.30.2

