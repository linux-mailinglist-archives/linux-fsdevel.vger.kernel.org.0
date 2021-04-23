Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD473692DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 15:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242604AbhDWNSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 09:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231220AbhDWNSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619183883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ih5PcddgkKygbzS3OXVUA5ZjXGVsRuOHJshpqa5QHrs=;
        b=FMe8a8WlzGXN+cmiTFf2Vf+BY8LMSVF4ecf4eGg7yXiiS/AwQnMT2GyW6Mwpo9aKuejQ+e
        esoUh++pZgH4FE9NzttEB2CNOqUs0yDDpQBOJtbWCDwIMcl9mG8IsrvBkMcMR1nMvzTNp3
        qrOUYvoMmiCF+QPd5a9fSLMY9O6ErGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-uOFyxz9qMh2BrwhMGOevgw-1; Fri, 23 Apr 2021 09:18:01 -0400
X-MC-Unique: uOFyxz9qMh2BrwhMGOevgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B4E1817477;
        Fri, 23 Apr 2021 13:17:55 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 340BB60BE5;
        Fri, 23 Apr 2021 13:17:36 +0000 (UTC)
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
Subject: [PATCH RFC 3/7] kernel/fork: always deny write access to current MM exe_file
Date:   Fri, 23 Apr 2021 15:16:36 +0200
Message-Id: <20210423131640.20080-4-david@redhat.com>
In-Reply-To: <20210423131640.20080-1-david@redhat.com>
References: <20210423131640.20080-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We want to remove VM_DENYWRITE only currently only used when mapping the
executable during exec. During exec, we already deny_write_access() the
executable, however, after exec completes the VMAs mapped
with VM_DENYWRITE effectively keeps write access denied via
deny_write_access().

Let's deny write access when setting the MM exe_file. With this change, we
can remove VM_DENYWRITE for mapping executables.

This represents a minor user space visible change:
sys_prctl(PR_SET_MM_EXE_FILE) can now fail if the file is already
opened writable. Also, after sys_prctl(PR_SET_MM_EXE_FILE), the file
cannot be opened writable. Note that we can already fail with -EACCES if
the file doesn't have execute permissions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/fork.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 199463625adc..0681f2973667 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -472,6 +472,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 {
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
 	struct rb_node **rb_link, *rb_parent;
+	struct file *exe_file;
 	int retval;
 	unsigned long charge;
 	LIST_HEAD(uf);
@@ -489,7 +490,10 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
 
 	/* No ordering required: file already has been exposed. */
-	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
+	exe_file = get_mm_exe_file(oldmm);
+	RCU_INIT_POINTER(mm->exe_file, exe_file);
+	if (exe_file)
+		deny_write_access(exe_file);
 
 	mm->total_vm = oldmm->total_vm;
 	mm->data_vm = oldmm->data_vm;
@@ -634,8 +638,13 @@ static inline void mm_free_pgd(struct mm_struct *mm)
 #else
 static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 {
+	struct file *exe_file;
+
 	mmap_write_lock(oldmm);
-	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
+	exe_file = get_mm_exe_file(oldmm);
+	RCU_INIT_POINTER(mm->exe_file, exe_file);
+	if (exe_file)
+		deny_write_access(exe_file);
 	mmap_write_unlock(oldmm);
 	return 0;
 }
@@ -1152,11 +1161,19 @@ void set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 	 */
 	old_exe_file = rcu_dereference_raw(mm->exe_file);
 
-	if (new_exe_file)
+	if (new_exe_file) {
 		get_file(new_exe_file);
+		/*
+		 * exec code is required to deny_write_access() successfully,
+		 * so this cannot fail
+		 */
+		deny_write_access(new_exe_file);
+	}
 	rcu_assign_pointer(mm->exe_file, new_exe_file);
-	if (old_exe_file)
+	if (old_exe_file) {
+		allow_write_access(old_exe_file);
 		fput(old_exe_file);
+	}
 }
 
 int atomic_set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
@@ -1183,10 +1200,22 @@ int atomic_set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 	}
 
 	/* set the new file, lockless */
+	ret = deny_write_access(new_exe_file);
+	if (ret)
+		return -EACCES;
 	get_file(new_exe_file);
+
 	old_exe_file = xchg(&mm->exe_file, new_exe_file);
-	if (old_exe_file)
+	if (old_exe_file) {
+		/*
+		 * Don't race with dup_mmap() getting the file and disallowing
+		 * write access while someone might open the file writable.
+		 */
+		mmap_read_lock(mm);
+		allow_write_access(old_exe_file);
 		fput(old_exe_file);
+		mmap_read_unlock(mm);
+	}
 	return 0;
 }
 
-- 
2.30.2

