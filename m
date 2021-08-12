Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112033EA0DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 10:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhHLIqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 04:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235155AbhHLIqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628757938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oGlOCkBYoC0XEBY+vyOkFgZAXDwE68Y66i/B8dT24gA=;
        b=KIN1/ShBSzmf8GbkyocAX6AXw5ccEFMnmLpoI5lBpAF/PoapFeqHL1LCAm3Ix040h3APpS
        S+ClQ+bjUzrSqUsWC94xBBf4lucfS6rHqyh7odgGuDmI7/J8ah4j8onf+KWw1bueBoy69v
        Cs9mJo+x6aZs64s9ob/4jwr7DgG7dlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-cEBDOImuP2GzXYhS9Fp4CQ-1; Thu, 12 Aug 2021 04:45:35 -0400
X-MC-Unique: cEBDOImuP2GzXYhS9Fp4CQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2941587D544;
        Thu, 12 Aug 2021 08:45:34 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEC1B5FC22;
        Thu, 12 Aug 2021 08:45:13 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, linux-unionfs@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v1 4/7] binfmt: remove in-tree usage of MAP_DENYWRITE
Date:   Thu, 12 Aug 2021 10:43:45 +0200
Message-Id: <20210812084348.6521-5-david@redhat.com>
In-Reply-To: <20210812084348.6521-1-david@redhat.com>
References: <20210812084348.6521-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

While this is a cleanup, it also fixes part of a problem reported with
VM_DENYWRITE on overlayfs, as VM_DENYWRITE is effectively unused with
this patch and will be removed next:
  "Overlayfs did not honor positive i_writecount on realfile for
   VM_DENYWRITE mappings." [1]

[1] https://lore.kernel.org/r/YNHXzBgzRrZu1MrD@miu.piliscsaba.redhat.com/

Reported-by: Chengguang Xu <cgxu519@mykernel.net>
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
index d29de971d3f3..a47496d0f123 100644
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -221,8 +221,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
 		}
 
 		error = vm_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
-			PROT_READ | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
+			PROT_READ | PROT_EXEC, MAP_FIXED | MAP_PRIVATE,
 			fd_offset);
 
 		if (error != N_TXTADDR(ex))
@@ -230,7 +229,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
 
 		error = vm_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
 				PROT_READ | PROT_WRITE | PROT_EXEC,
-				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
+				MAP_FIXED | MAP_PRIVATE,
 				fd_offset + ex.a_text);
 		if (error != N_DATADDR(ex))
 			return error;
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 6d2c79533631..69d900a8473d 100644
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
index cf4028487dcc..6d8fd6030cbb 100644
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
2.31.1

