Return-Path: <linux-fsdevel+bounces-3833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2AD7F90DA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 03:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6CEDB20FD6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 02:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A01F138F;
	Sun, 26 Nov 2023 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qhoy87/4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A5EE5
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 18:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ftN88PXidcN21kSfUc7dd9TnwaCUXRj+oIeXYSHBZJ0=; b=qhoy87/4G/27ynCAEk3tPeqzO3
	qLGBNxZXLn8ebkilTGE4e2Mc41+csTwqVqd9EQHXknr+BeHrhTEHb9PtceHRkSdZLWg+fMR6MbhmJ
	scR7GGQwtVbpn3bfJKQDvppeiqpQkDwmoLJ7nvDR8qyFmZrIkmz0lBuO1g5+SK1qTSRxhfxy6l7ui
	PjygDc3jfCP+9W5I095t3xTmHB+3vVw6wKT3LYlfmJCxSLaGLQsH+BQNrTzJ4aPXTRDcWQf/YhgUF
	uFGiaScN/mGhGS6TDMI1GcAuLGbcnT/U0JOggR0nIXfZeiS3un3gOI3AiNCYlXVadrC35NZ6GwpiO
	yZw4iSOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r74ZW-003HoO-2S;
	Sun, 26 Nov 2023 02:08:34 +0000
Date: Sun, 26 Nov 2023 02:08:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [RFC][PATCH] simpler way to get benefits of "vfs: shave work on
 failed file open"
Message-ID: <20231126020834.GC38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

IMO 93faf426e3cc "vfs: shave work on failed file open" had gone overboard -
avoiding an RCU delay in that particular case is fine, but it's done on
the wrong level.  A file that has never gotten FMODE_OPENED will never
have RCU-accessed references, its final fput() is equivalent to file_free()
and if it doesn't have FMODE_BACKING either, it can be done from any context
and won't need task_work treatment.

However, all of that can be achieved easier - all it takes is fput()
recognizing that case and calling file_free() directly.
No need to introduce a special primitive for that - and things like
failing dentry_open() could benefit from that as well.

Objections?

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/file_table.c b/fs/file_table.c
index de4a2915bfd4..7bcfa169dd45 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -75,18 +75,6 @@ static inline void file_free(struct file *f)
 	}
 }
 
-void release_empty_file(struct file *f)
-{
-	WARN_ON_ONCE(f->f_mode & (FMODE_BACKING | FMODE_OPENED));
-	if (atomic_long_dec_and_test(&f->f_count)) {
-		security_file_free(f);
-		put_cred(f->f_cred);
-		if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
-			percpu_counter_dec(&nr_files);
-		kmem_cache_free(filp_cachep, f);
-	}
-}
-
 /*
  * Return the total number of open files in the system
  */
@@ -445,6 +433,10 @@ void fput(struct file *file)
 	if (atomic_long_dec_and_test(&file->f_count)) {
 		struct task_struct *task = current;
 
+		if (unlikely(!(f->f_mode & (FMODE_BACKING | FMODE_OPENED)))) {
+			file_free(f);
+			return;
+		}
 		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
 			init_task_work(&file->f_rcuhead, ____fput);
 			if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
diff --git a/fs/internal.h b/fs/internal.h
index 58e43341aebf..273e6fd40d1b 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -94,7 +94,6 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
 struct file *alloc_empty_file(int flags, const struct cred *cred);
 struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
 struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
-void release_empty_file(struct file *f);
 
 static inline void file_put_write_access(struct file *file)
 {
diff --git a/fs/namei.c b/fs/namei.c
index 22915c40e2bd..e7f641d3115f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3787,10 +3787,7 @@ static struct file *path_openat(struct nameidata *nd,
 		WARN_ON(1);
 		error = -EINVAL;
 	}
-	if (unlikely(file->f_mode & FMODE_OPENED))
-		fput(file);
-	else
-		release_empty_file(file);
+	fput(file);
 	if (error == -EOPENSTALE) {
 		if (flags & LOOKUP_RCU)
 			error = -ECHILD;

