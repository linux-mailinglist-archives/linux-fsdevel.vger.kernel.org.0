Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AAA3692E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 15:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242689AbhDWNSz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 09:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242545AbhDWNSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619183898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cOYhLs+FgLhM1I4gRAbRRNPrki3rXJzkHvMjiso+gl4=;
        b=RTYzGu05ZYw0z+UkhdpGOf/mUofncJ0DftZoT4mGXi2jHrsxQlOOyKE8WkYbK7h34IdBka
        8w3Yps5I83mYx0ACxpFs4+zJ7DIPIDcRl61wRCyO4/8pMr8evoxQ9AR1AEsjg6VtzzmFif
        PJaCYb+rxpUySRtlRib8hV8IS/0CcnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-MLCTH_bZNLGn8vAztFDHlA-1; Fri, 23 Apr 2021 09:18:16 -0400
X-MC-Unique: MLCTH_bZNLGn8vAztFDHlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA71581746B;
        Fri, 23 Apr 2021 13:18:10 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DBCF60BE5;
        Fri, 23 Apr 2021 13:17:55 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-api@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH RFC 4/7] binfmt: remove in-tree usage of MAP_DENYWRITE
Date:   Fri, 23 Apr 2021 15:16:37 +0200
Message-Id: <20210423131640.20080-5-david@redhat.com>
In-Reply-To: <20210423131640.20080-1-david@redhat.com>
References: <20210423131640.20080-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At exec time when we mmap the new executable via MAP_DENYWRITE we have it
opened via do_open_execat() and already deny_write_access()'ed the file
successfully. Once exec completes, we allow_write_acces(); however,
we set mm->exe_file in begin_new_exec() via set_mm_exe_file() and
also deny_write_access() as long as mm->exe_file remains set. We'll
effectively deny write access to our executable via mm->exe_file
until mm->exe_file is changed -- when the process is removed, on new
exec, or via sys_prctl(PR_SET_MM_EXE_FILE).

Let's remove all usage of MAP_DENYWRITE, it's no longer necessary for
mm->exe_file.

In case of an elf interpreter, we'll now only deny write access to the file
during exec. This is somewhat okay, because the interpreter behaves
(and sometime is) a shared library; all shared libraries, especially the
ones loaded directly in user space like via dlopen() won't ever be mapped
via MAP_DENYWRITE, because we ignore that from user space completely;
these shared libraries can always be modified while mapped and executed.
Let's only special-case the main executable, denying write access while
being executed by a process. This can be considered a minor user space
visible change.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/ia32/ia32_aout.c | 6 ++----
 fs/binfmt_aout.c          | 5 ++---
 fs/binfmt_elf.c           | 4 ++--
 fs/binfmt_elf_fdpic.c     | 2 +-
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
index 321d7b22ad2d..9bd15241fadb 100644
--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -202,8 +202,7 @@ static int load_aout_binary(struct linux_binprm *bprm)
 
 		error = vm_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
 				PROT_READ | PROT_EXEC,
-				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE |
-				MAP_32BIT,
+				MAP_FIXED | MAP_PRIVATE | MAP_32BIT,
 				fd_offset);
 
 		if (error != N_TXTADDR(ex))
@@ -211,8 +210,7 @@ static int load_aout_binary(struct linux_binprm *bprm)
 
 		error = vm_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
 				PROT_READ | PROT_WRITE | PROT_EXEC,
-				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE |
-				MAP_32BIT,
+				MAP_FIXED | MAP_PRIVATE | MAP_32BIT,
 				fd_offset + ex.a_text);
 		if (error != N_DATADDR(ex))
 			return error;
diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
index 37df8fee63d7..9c44892d6469 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -221,8 +221,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
 		}
 
 		error = vm_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
-			PROT_READ | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE;
+			PROT_READ | PROT_EXEC, MAP_FIXED | MAP_PRIVATE;
 			fd_offset);
 
 		if (error != N_TXTADDR(ex))
@@ -230,7 +229,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
 
 		error = vm_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
 				PROT_READ | PROT_WRITE | PROT_EXEC,
-				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE;
+				MAP_FIXED | MAP_PRIVATE;
 				fd_offset + ex.a_text);
 		if (error != N_DATADDR(ex))
 			return error;
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 763188ac398e..76bb342e9c9b 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -622,7 +622,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	eppnt = interp_elf_phdata;
 	for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
 		if (eppnt->p_type == PT_LOAD) {
-			int elf_type = MAP_PRIVATE | MAP_DENYWRITE;
+			int elf_type = MAP_PRIVATE;
 			int elf_prot = make_prot(eppnt->p_flags, arch_state,
 						 true, true);
 			unsigned long vaddr = 0;
@@ -1070,7 +1070,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		elf_prot = make_prot(elf_ppnt->p_flags, &arch_state,
 				     !!interpreter, false);
 
-		elf_flags = MAP_PRIVATE | MAP_DENYWRITE;
+		elf_flags = MAP_PRIVATE;
 
 		vaddr = elf_ppnt->p_vaddr;
 		/*
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 8723b6686b66..18a9e42e41d1 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1041,7 +1041,7 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
 		if (phdr->p_flags & PF_W) prot |= PROT_WRITE;
 		if (phdr->p_flags & PF_X) prot |= PROT_EXEC;
 
-		flags = MAP_PRIVATE | MAP_DENYWRITE;
+		flags = MAP_PRIVATE;
 		maddr = 0;
 
 		switch (params->flags & ELF_FDPIC_FLAG_ARRANGEMENT) {
-- 
2.30.2

