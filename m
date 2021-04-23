Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046EF3692E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 15:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbhDWNTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 09:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242731AbhDWNTL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619183914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=to3jmwMXXFbhc7/LVzTZ18LjP83fsxZIox1HwqIBnjY=;
        b=VCQ20nG+1r/zeV22JeDKZjNzgzE4LpgJRM4zrXOym+BhhZ01VIdfBoolZUFMCM6NySPKRL
        dJXyUq2fy/jYbq8DyGUFYeJp0scPrEs3zBuIwvQyvJJG3Ra9rFyj40VL5C7HgzN9TlMsck
        wLldlUBWiUnB4FU6ImSORXgcf/hD2S8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-RnIVNeHfNt6x64Pr4MSbLA-1; Fri, 23 Apr 2021 09:18:31 -0400
X-MC-Unique: RnIVNeHfNt6x64Pr4MSbLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F04CA107ACCA;
        Fri, 23 Apr 2021 13:18:25 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A6A960BE5;
        Fri, 23 Apr 2021 13:18:10 +0000 (UTC)
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
Subject: [PATCH RFC 5/7] mm: remove VM_DENYWRITE
Date:   Fri, 23 Apr 2021 15:16:38 +0200
Message-Id: <20210423131640.20080-6-david@redhat.com>
In-Reply-To: <20210423131640.20080-1-david@redhat.com>
References: <20210423131640.20080-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All in-tree users of MAP_DENYWRITE are gone. MAP_DENYWRITE cannot be
set from user space, so all users are gone; let's remove it.

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
index e862cab69583..2710703c39b0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -621,7 +621,6 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_MAYSHARE)]	= "ms",
 		[ilog2(VM_GROWSDOWN)]	= "gd",
 		[ilog2(VM_PFNMAP)]	= "pf",
-		[ilog2(VM_DENYWRITE)]	= "dw",
 		[ilog2(VM_LOCKED)]	= "lo",
 		[ilog2(VM_IO)]		= "io",
 		[ilog2(VM_SEQ_READ)]	= "sr",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 043702972e5f..cdad125af9fa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -274,7 +274,6 @@ extern unsigned int kobjsize(const void *objp);
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
index 67018d367b9f..e1721ce6381d 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -149,7 +149,6 @@ IF_HAVE_PG_ARCH_2(PG_arch_2,		"arch_2"	)
 	{VM_GROWSDOWN,			"growsdown"	},		\
 	{VM_UFFD_MISSING,		"uffd_missing"	},		\
 	{VM_PFNMAP,			"pfnmap"	},		\
-	{VM_DENYWRITE,			"denywrite"	},		\
 	{VM_UFFD_WP,			"uffd_wp"	},		\
 	{VM_LOCKED,			"locked"	},		\
 	{VM_IO,				"io"		},		\
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3dfd463f1831..1ed3eb7aa4c9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8184,8 +8184,6 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	else
 		flags = MAP_PRIVATE;
 
-	if (vma->vm_flags & VM_DENYWRITE)
-		flags |= MAP_DENYWRITE;
 	if (vma->vm_flags & VM_LOCKED)
 		flags |= MAP_LOCKED;
 	if (is_vm_hugetlb_page(vma))
diff --git a/kernel/fork.c b/kernel/fork.c
index 0681f2973667..fda43ba05d91 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -556,12 +556,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
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
index 95a2f82427c7..54f0583dc45d 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -596,9 +596,8 @@ flags(void)
 	test("uptodate|dirty|lru|active|swapbacked", "%pGp", &flags);
 
 
-	flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC
-			| VM_DENYWRITE;
-	test("read|exec|mayread|maywrite|mayexec|denywrite", "%pGv", &flags);
+	flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
+	test("read|exec|mayread|maywrite|mayexec", "%pGv", &flags);
 
 	gfp = GFP_TRANSHUGE;
 	test("GFP_TRANSHUGE", "%pGg", &gfp);
diff --git a/mm/mmap.c b/mm/mmap.c
index 882f8ee4af1f..b335f8907568 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -142,8 +142,6 @@ void vma_set_page_prot(struct vm_area_struct *vma)
 static void __remove_shared_vm_struct(struct vm_area_struct *vma,
 		struct file *file, struct address_space *mapping)
 {
-	if (vma->vm_flags & VM_DENYWRITE)
-		allow_write_access(file);
 	if (vma->vm_flags & VM_SHARED)
 		mapping_unmap_writable(mapping);
 
@@ -660,8 +658,6 @@ static void __vma_link_file(struct vm_area_struct *vma)
 	if (file) {
 		struct address_space *mapping = file->f_mapping;
 
-		if (vma->vm_flags & VM_DENYWRITE)
-			put_write_access(file_inode(file));
 		if (vma->vm_flags & VM_SHARED)
 			mapping_allow_writable(mapping);
 
@@ -1785,22 +1781,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
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
@@ -1857,13 +1843,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
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
@@ -1903,9 +1885,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
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
2.30.2

