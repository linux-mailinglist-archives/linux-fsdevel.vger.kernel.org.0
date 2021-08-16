Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA99C3EDE27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 21:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhHPTvI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 15:51:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231609AbhHPTvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629143432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kP9Ruk7HoVFrsIOE9R+legB98IpgGisc7R6rrwUCgRc=;
        b=KrafWbe74Z6kBMP4N1wq+I5FwjZSgNB2qAApxH8WsANrnp0jlC8zzt6bMaTjfUlUh//K9R
        B9NQdfDZb65Xw0Lj7LE93rpZeyAfndkkQRoiAJgw2W2dG1eaQW2vX3jxPl/pqumNkCezp1
        LrDma+p206ppc0RFmtzsZ8GLLBuILrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-VYoUJnKgNyGGcj_-48ogbw-1; Mon, 16 Aug 2021 15:50:31 -0400
X-MC-Unique: VYoUJnKgNyGGcj_-48ogbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59F97107ACF5;
        Mon, 16 Aug 2021 19:50:25 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 264AE5C1D5;
        Mon, 16 Aug 2021 19:50:00 +0000 (UTC)
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
Subject: [PATCH v2 3/7] kernel/fork: always deny write access to current MM exe_file
Date:   Mon, 16 Aug 2021 21:48:36 +0200
Message-Id: <20210816194840.42769-4-david@redhat.com>
In-Reply-To: <20210816194840.42769-1-david@redhat.com>
References: <20210816194840.42769-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We want to remove VM_DENYWRITE only currently only used when mapping the
executable during exec. During exec, we already deny_write_access() the
executable, however, after exec completes the VMAs mapped
with VM_DENYWRITE effectively keeps write access denied via
deny_write_access().

Let's deny write access when setting or replacing the MM exe_file. With
this change, we can remove VM_DENYWRITE for mapping executables.

Make set_mm_exe_file() return an error in case deny_write_access()
fails; note that this should never happen, because exec code does a
deny_write_access() early and keeps write access denied when calling
set_mm_exe_file. However, it makes the code easier to read and makes
set_mm_exe_file() and replace_mm_exe_file() look more similar.

This represents a minor user space visible change:
sys_prctl(PR_SET_MM_MAP/EXE_FILE) can now fail if the file is already
opened writable. Also, after sys_prctl(PR_SET_MM_MAP/EXE_FILE) the file
cannot be opened writable. Note that we can already fail with -EACCES if
the file doesn't have execute permissions.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/exec.c          |  4 +++-
 include/linux/mm.h |  2 +-
 kernel/fork.c      | 50 ++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 38f63451b928..9294049f5487 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1270,7 +1270,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * not visibile until then. This also enables the update
 	 * to be lockless.
 	 */
-	set_mm_exe_file(bprm->mm, bprm->file);
+	retval = set_mm_exe_file(bprm->mm, bprm->file);
+	if (retval)
+		goto out;
 
 	/* If the binary is not readable then enforce mm->dumpable=0 */
 	would_dump(bprm, bprm->file);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 48c6fa9ab792..56b1cd41db61 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2580,7 +2580,7 @@ static inline int check_data_rlimit(unsigned long rlim,
 extern int mm_take_all_locks(struct mm_struct *mm);
 extern void mm_drop_all_locks(struct mm_struct *mm);
 
-extern void set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file);
+extern int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file);
 extern int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file);
 extern struct file *get_mm_exe_file(struct mm_struct *mm);
 extern struct file *get_task_exe_file(struct task_struct *task);
diff --git a/kernel/fork.c b/kernel/fork.c
index eedce5c77041..543541764865 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -470,6 +470,20 @@ void free_task(struct task_struct *tsk)
 }
 EXPORT_SYMBOL(free_task);
 
+static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
+{
+	struct file *exe_file;
+
+	exe_file = get_mm_exe_file(oldmm);
+	RCU_INIT_POINTER(mm->exe_file, exe_file);
+	/*
+	 * We depend on the oldmm having properly denied write access to the
+	 * exe_file already.
+	 */
+	if (exe_file && deny_write_access(exe_file))
+		pr_warn_once("deny_write_access() failed in %s\n", __func__);
+}
+
 #ifdef CONFIG_MMU
 static __latent_entropy int dup_mmap(struct mm_struct *mm,
 					struct mm_struct *oldmm)
@@ -493,7 +507,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
 
 	/* No ordering required: file already has been exposed. */
-	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
+	dup_mm_exe_file(mm, oldmm);
 
 	mm->total_vm = oldmm->total_vm;
 	mm->data_vm = oldmm->data_vm;
@@ -639,7 +653,7 @@ static inline void mm_free_pgd(struct mm_struct *mm)
 static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	mmap_write_lock(oldmm);
-	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
+	dup_mm_exe_file(mm, oldmm);
 	mmap_write_unlock(oldmm);
 	return 0;
 }
@@ -1149,8 +1163,10 @@ void mmput_async(struct mm_struct *mm)
  * Main users are mmput() and sys_execve(). Callers prevent concurrent
  * invocations: in mmput() nobody alive left, in execve task is single
  * threaded.
+ *
+ * Can only fail if new_exe_file != NULL.
  */
-void set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
+int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 {
 	struct file *old_exe_file;
 
@@ -1161,11 +1177,21 @@ void set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 	 */
 	old_exe_file = rcu_dereference_raw(mm->exe_file);
 
-	if (new_exe_file)
+	if (new_exe_file) {
+		/*
+		 * We expect the caller (i.e., sys_execve) to already denied
+		 * write access, so this is unlikely to fail.
+		 */
+		if (unlikely(deny_write_access(new_exe_file)))
+			return -EACCES;
 		get_file(new_exe_file);
+	}
 	rcu_assign_pointer(mm->exe_file, new_exe_file);
-	if (old_exe_file)
+	if (old_exe_file) {
+		allow_write_access(old_exe_file);
 		fput(old_exe_file);
+	}
+	return 0;
 }
 
 /**
@@ -1201,10 +1227,22 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
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
2.31.1

