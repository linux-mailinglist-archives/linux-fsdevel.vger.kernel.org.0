Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1215F3EDE23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 21:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhHPTuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 15:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231544AbhHPTul (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629143409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OaQssic/mSdAfbGEFpAxDDR1LNO8rKXcgan69fY/97k=;
        b=UiTpUNARHLV92D7i8XI6opQ/5r9lBBWs/A97WMilxfks6EbqxueNRThlApox5gmIcacxSP
        QbYdmOnQDvHQi44joaN1ryDItPJ/2Ps8YlVmO9mdeIMa3PuP6sUULPpeJoxU1FR+sTseL2
        wVL0zhnXw0wlhTJK1oNvvqutDvrpFno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-LVUpcUlEOZmpnKyAYdPJHA-1; Mon, 16 Aug 2021 15:50:08 -0400
X-MC-Unique: LVUpcUlEOZmpnKyAYdPJHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE341760C0;
        Mon, 16 Aug 2021 19:50:00 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1536118017;
        Mon, 16 Aug 2021 19:49:40 +0000 (UTC)
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
Subject: [PATCH v2 2/7] kernel/fork: factor out replacing the current MM exe_file
Date:   Mon, 16 Aug 2021 21:48:35 +0200
Message-Id: <20210816194840.42769-3-david@redhat.com>
In-Reply-To: <20210816194840.42769-1-david@redhat.com>
References: <20210816194840.42769-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's factor the main logic out into replace_mm_exe_file(), such that
all mm->exe_file logic is contained in kernel/fork.c.

While at it, perform some simple cleanups that are possible now that
we're simplifying the individual functions.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  1 +
 kernel/fork.c      | 44 +++++++++++++++++++++++++++++++++++++++++---
 kernel/sys.c       | 33 +--------------------------------
 3 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..48c6fa9ab792 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2581,6 +2581,7 @@ extern int mm_take_all_locks(struct mm_struct *mm);
 extern void mm_drop_all_locks(struct mm_struct *mm);
 
 extern void set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file);
+extern int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file);
 extern struct file *get_mm_exe_file(struct mm_struct *mm);
 extern struct file *get_task_exe_file(struct task_struct *task);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index bc94b2cc5995..eedce5c77041 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1148,9 +1148,7 @@ void mmput_async(struct mm_struct *mm)
  *
  * Main users are mmput() and sys_execve(). Callers prevent concurrent
  * invocations: in mmput() nobody alive left, in execve task is single
- * threaded. sys_prctl(PR_SET_MM_MAP/EXE_FILE) also needs to set the
- * mm->exe_file, but does so without using set_mm_exe_file() in order
- * to avoid the need for any locks.
+ * threaded.
  */
 void set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 {
@@ -1170,6 +1168,46 @@ void set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 		fput(old_exe_file);
 }
 
+/**
+ * replace_mm_exe_file - replace a reference to the mm's executable file
+ *
+ * This changes mm's executable file (shown as symlink /proc/[pid]/exe),
+ * dealing with concurrent invocation and without grabbing the mmap lock in
+ * write mode.
+ *
+ * Main user is sys_prctl(PR_SET_MM_MAP/EXE_FILE).
+ */
+int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
+{
+	struct vm_area_struct *vma;
+	struct file *old_exe_file;
+	int ret = 0;
+
+	/* Forbid mm->exe_file change if old file still mapped. */
+	old_exe_file = get_mm_exe_file(mm);
+	if (old_exe_file) {
+		mmap_read_lock(mm);
+		for (vma = mm->mmap; vma && !ret; vma = vma->vm_next) {
+			if (!vma->vm_file)
+				continue;
+			if (path_equal(&vma->vm_file->f_path,
+				       &old_exe_file->f_path))
+				ret = -EBUSY;
+		}
+		mmap_read_unlock(mm);
+		fput(old_exe_file);
+		if (ret)
+			return ret;
+	}
+
+	/* set the new file, lockless */
+	get_file(new_exe_file);
+	old_exe_file = xchg(&mm->exe_file, new_exe_file);
+	if (old_exe_file)
+		fput(old_exe_file);
+	return 0;
+}
+
 /**
  * get_mm_exe_file - acquire a reference to the mm's executable file
  *
diff --git a/kernel/sys.c b/kernel/sys.c
index ef1a78f5d71c..30c12e54585a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1846,7 +1846,6 @@ SYSCALL_DEFINE1(umask, int, mask)
 static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
 {
 	struct fd exe;
-	struct file *old_exe, *exe_file;
 	struct inode *inode;
 	int err;
 
@@ -1869,40 +1868,10 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
 	if (err)
 		goto exit;
 
-	/*
-	 * Forbid mm->exe_file change if old file still mapped.
-	 */
-	exe_file = get_mm_exe_file(mm);
-	err = -EBUSY;
-	if (exe_file) {
-		struct vm_area_struct *vma;
-
-		mmap_read_lock(mm);
-		for (vma = mm->mmap; vma; vma = vma->vm_next) {
-			if (!vma->vm_file)
-				continue;
-			if (path_equal(&vma->vm_file->f_path,
-				       &exe_file->f_path))
-				goto exit_err;
-		}
-
-		mmap_read_unlock(mm);
-		fput(exe_file);
-	}
-
-	err = 0;
-	/* set the new file, lockless */
-	get_file(exe.file);
-	old_exe = xchg(&mm->exe_file, exe.file);
-	if (old_exe)
-		fput(old_exe);
+	err = replace_mm_exe_file(mm, exe.file);
 exit:
 	fdput(exe);
 	return err;
-exit_err:
-	mmap_read_unlock(mm);
-	fput(exe_file);
-	goto exit;
 }
 
 /*
-- 
2.31.1

