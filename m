Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FA53EDE30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 21:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhHPTvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 15:51:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39015 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231646AbhHPTvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629143473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hJpZHLDKvzGPtPhMPjr76EVS+xDwvDkriAy1eTHJ9n4=;
        b=JABHp3osTGE2qVhTKf1rR2tZpzN70PAcI7QDEeAwbIrYKkC/J2HbqAliE/6YuOOVYaA4hC
        MUcbYQx/52pCitfj2VPs3PuzDlD2B0NBv9N1gndaAp1z3g0Z6FdP84pshxfIDS3oXX52sk
        nMFkW6CfwIAshlmzvWeu6vFhKTdLIFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-HOo_TwmXOV2DyJXtQCaRxw-1; Mon, 16 Aug 2021 15:51:11 -0400
X-MC-Unique: HOo_TwmXOV2DyJXtQCaRxw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 658AB107ACF5;
        Mon, 16 Aug 2021 19:51:06 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C44C51803B;
        Mon, 16 Aug 2021 19:50:45 +0000 (UTC)
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
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-unionfs@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 5/7] mm: remove VM_DENYWRITE
Date:   Mon, 16 Aug 2021 21:48:38 +0200
Message-Id: <20210816194840.42769-6-david@redhat.com>
In-Reply-To: <20210816194840.42769-1-david@redhat.com>
References: <20210816194840.42769-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All in-tree users of MAP_DENYWRITE are gone. MAP_DENYWRITE cannot be
set from user space, so all users are gone; let's remove it.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/task_mmu.c             |  1 -
 include/linux/mm.h             |  1 -
 include/linux/mman.h           |  1 -
 include/trace/events/mmflags.h |  1 -
 kernel/events/core.c           |  2 --
 kernel/fork.c                  |  3 ---
 lib/test_printf.c              |  5 ++---
 mm/mmap.c                      | 27 +++------------------------
 8 files changed, 5 insertions(+), 36 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index eb97468dfe4c..cf25be3e0321 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -619,7 +619,6 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_MAYSHARE)]	= "ms",
 		[ilog2(VM_GROWSDOWN)]	= "gd",
 		[ilog2(VM_PFNMAP)]	= "pf",
-		[ilog2(VM_DENYWRITE)]	= "dw",
 		[ilog2(VM_LOCKED)]	= "lo",
 		[ilog2(VM_IO)]		= "io",
 		[ilog2(VM_SEQ_READ)]	= "sr",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 56b1cd41db61..257995f62e83 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -281,7 +281,6 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_GROWSDOWN	0x00000100	/* general info on the segment */
 #define VM_UFFD_MISSING	0x00000200	/* missing pages tracking */
 #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
-#define VM_DENYWRITE	0x00000800	/* ETXTBSY on write attempts.. */
 #define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
 
 #define VM_LOCKED	0x00002000
diff --git a/include/linux/mman.h b/include/linux/mman.h
index ebb09a964272..bd9aadda047b 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -153,7 +153,6 @@ static inline unsigned long
 calc_vm_flag_bits(unsigned long flags)
 {
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
-	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
 	       arch_calc_vm_flag_bits(flags);
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 390270e00a1d..f44c3fb8da1a 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -163,7 +163,6 @@ IF_HAVE_PG_SKIP_KASAN_POISON(PG_skip_kasan_poison, "skip_kasan_poison")
 	{VM_UFFD_MISSING,		"uffd_missing"	},		\
 IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,	"uffd_minor"	)		\
 	{VM_PFNMAP,			"pfnmap"	},		\
-	{VM_DENYWRITE,			"denywrite"	},		\
 	{VM_UFFD_WP,			"uffd_wp"	},		\
 	{VM_LOCKED,			"locked"	},		\
 	{VM_IO,				"io"		},		\
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1cb1f9b8392e..19767bb9933c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8307,8 +8307,6 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	else
 		flags = MAP_PRIVATE;
 
-	if (vma->vm_flags & VM_DENYWRITE)
-		flags |= MAP_DENYWRITE;
 	if (vma->vm_flags & VM_LOCKED)
 		flags |= MAP_LOCKED;
 	if (is_vm_hugetlb_page(vma))
diff --git a/kernel/fork.c b/kernel/fork.c
index 543541764865..34d21642c44f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -570,12 +570,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
 		file = tmp->vm_file;
 		if (file) {
-			struct inode *inode = file_inode(file);
 			struct address_space *mapping = file->f_mapping;
 
 			get_file(file);
-			if (tmp->vm_flags & VM_DENYWRITE)
-				put_write_access(inode);
 			i_mmap_lock_write(mapping);
 			if (tmp->vm_flags & VM_SHARED)
 				mapping_allow_writable(mapping);
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 8ac71aee46af..8a48b61c3763 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -675,9 +675,8 @@ flags(void)
 			"uptodate|dirty|lru|active|swapbacked",
 			cmp_buffer);
 
-	flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC
-			| VM_DENYWRITE;
-	test("read|exec|mayread|maywrite|mayexec|denywrite", "%pGv", &flags);
+	flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
+	test("read|exec|mayread|maywrite|mayexec", "%pGv", &flags);
 
 	gfp = GFP_TRANSHUGE;
 	test("GFP_TRANSHUGE", "%pGg", &gfp);
diff --git a/mm/mmap.c b/mm/mmap.c
index ca54d36d203a..589dc1dc13db 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -148,8 +148,6 @@ void vma_set_page_prot(struct vm_area_struct *vma)
 static void __remove_shared_vm_struct(struct vm_area_struct *vma,
 		struct file *file, struct address_space *mapping)
 {
-	if (vma->vm_flags & VM_DENYWRITE)
-		allow_write_access(file);
 	if (vma->vm_flags & VM_SHARED)
 		mapping_unmap_writable(mapping);
 
@@ -666,8 +664,6 @@ static void __vma_link_file(struct vm_area_struct *vma)
 	if (file) {
 		struct address_space *mapping = file->f_mapping;
 
-		if (vma->vm_flags & VM_DENYWRITE)
-			put_write_access(file_inode(file));
 		if (vma->vm_flags & VM_SHARED)
 			mapping_allow_writable(mapping);
 
@@ -1788,22 +1784,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
-		if (vm_flags & VM_DENYWRITE) {
-			error = deny_write_access(file);
-			if (error)
-				goto free_vma;
-		}
 		if (vm_flags & VM_SHARED) {
 			error = mapping_map_writable(file->f_mapping);
 			if (error)
-				goto allow_write_and_free_vma;
+				goto free_vma;
 		}
 
-		/* ->mmap() can change vma->vm_file, but must guarantee that
-		 * vma_link() below can deny write-access if VM_DENYWRITE is set
-		 * and map writably if VM_SHARED is set. This usually means the
-		 * new file must not have been exposed to user-space, yet.
-		 */
 		vma->vm_file = get_file(file);
 		error = call_mmap(file, vma);
 		if (error)
@@ -1860,13 +1846,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 	/* Once vma denies write, undo our temporary denial count */
-	if (file) {
 unmap_writable:
-		if (vm_flags & VM_SHARED)
-			mapping_unmap_writable(file->f_mapping);
-		if (vm_flags & VM_DENYWRITE)
-			allow_write_access(file);
-	}
+	if (file && vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
 	file = vma->vm_file;
 out:
 	perf_event_mmap(vma);
@@ -1906,9 +1888,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	charged = 0;
 	if (vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
-allow_write_and_free_vma:
-	if (vm_flags & VM_DENYWRITE)
-		allow_write_access(file);
 free_vma:
 	vm_area_free(vma);
 unacct_error:
-- 
2.31.1

