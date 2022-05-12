Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E2B5256FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 23:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350109AbiELVVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 17:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358431AbiELVUz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 17:20:55 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47110289A6
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 14:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9oLxOzlFyrPXqmcJoBRttq0jjzSHXhyCNTKULNXsPoI=; b=o5dMTEqKmI4Vh0spDGdyp2MX6j
        JCzqvuU/IAghFnkXVu5+7geFKO2szF1Q7MYU10J1jPX8TNOxsKm2yyx9gSuGUF6GsMWxMdtjo6BIV
        13SzsYiltYMDSpDOsNDvbyzPYeGYptxAENUKIU0mFHz4ybYa3+rG/l12fhSfUIyPWE2q6hHLOwhAD
        QxX5QMZQ6vWSliKG4FUtWbRKtwBz0+LC2mSDOQN+70T9B7ATRg34+lH9lkEiPD81we1d32WzP8mLv
        xOcjnLk40WCuOUvvM7pqPgyj9lLAc5aKa4E5X7EuLi0vXp+E06I+LWb48ZgkDl31icJzkhXBg0878
        lnVl9cFQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npGEt-00EPMT-AI; Thu, 12 May 2022 21:20:51 +0000
Date:   Thu, 12 May 2022 21:20:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>, Todd Kjos <tkjos@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: [RFC] unify the file-closing stuff in fs/file.c
Message-ID: <Yn16M/fayt6tK/Gp@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Right now we have two places that do such removals - pick_file()
and {__,}close_fd_get_file().

	They are almost identical - the only difference is in calling
conventions (well, and the fact that __... is called with descriptor
table locked).

	Calling conventions are... interesting.

1) pick_file() - returns file or ERR_PTR(-EBADF) or ERR_PTR(-EINVAL).
The latter is for "descriptor is greater than size of descriptor table".
One of the callers treats all ERR_PTR(...) as "return -EBADF"; another
uses ERR_PTR(-EINVAL) as "end the loop now" indicator.

2) {__,}close_fd_get_file() returns 0 or -ENOENT (huh?), with file (or NULL)
passed to caller by way of struct file ** argument.  One of the callers
(binder) ignores the return value completely and checks if the file is NULL.
Another (io_uring) checks for return value being negative, then maps
-ENOENT to -EBADF, not that any other value would be possible.

ERR_PTR(-EINVAL) magic in case of pick_file() is borderline defensible;
{__,}close_fd_get_file() conventions are insane.  The older caller
(in binder) had never even looked at return value; the newer one
patches the bogus -ENOENT to what it wants to report, with strange
"defensive" BS logics just in case __close_fd_get_file() would somehow
find a different error to report.

At the very least, {__,}close_fd_get_file() callers would've been happier
if it just returned file or NULL.  What's more, I'm seriously tempted
to make pick_file() do the same thing.  close_fd() won't care (checking
for NULL is just as easy as for IS_ERR) and __range_close() could just
as well cap the max_fd argument with last_fd(files_fdtable(current->files)).

Does anybody see problems with the following?

commit 8819510a641800a63ab10d6b5ab283cada1cbd50
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu May 12 17:08:03 2022 -0400

    Unify the primitives for file descriptor closing
    
    Currently we have 3 primitives for removing an opened file from descriptor
    table - pick_file(), __close_fd_get_file() and close_fd_get_file().  Their
    calling conventions are rather odd and there's a code duplication for no
    good reason.  They can be unified -
    
    1) have __range_close() cap max_fd in the very beginning; that way
    we don't need separate way for pick_file() to report being past the end
    of descriptor table.
    
    2) make {__,}close_fd_get_file() return file (or NULL) directly, rather
    than returning it via struct file ** argument.  Don't bother with
    (bogus) return value - nobody wants that -ENOENT.
    
    3) make pick_file() return NULL on unopened descriptor - the only caller
    that used to care about the distinction between descriptor past the end
    of descriptor table and finding NULL in descriptor table doesn't give
    a damn after (1).
    
    4) lift ->files_lock out of pick_file()
    
    That actually simplifies the callers, as well as the primitives themselves.
    Code duplication is also gone...
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8351c5638880..27c9b004823a 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1855,7 +1855,7 @@ static void binder_deferred_fd_close(int fd)
 	if (!twcb)
 		return;
 	init_task_work(&twcb->twork, binder_do_fd_close);
-	close_fd_get_file(fd, &twcb->file);
+	twcb->file = close_fd_get_file(fd);
 	if (twcb->file) {
 		filp_close(twcb->file, current->files);
 		task_work_add(current, &twcb->twork, TWA_RESUME);
diff --git a/fs/file.c b/fs/file.c
index ee9317346702..9780888fa2da 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -630,32 +630,21 @@ EXPORT_SYMBOL(fd_install);
  * @files: file struct to retrieve file from
  * @fd: file descriptor to retrieve file for
  *
- * If this functions returns an EINVAL error pointer the fd was beyond the
- * current maximum number of file descriptors for that fdtable.
- *
- * Returns: The file associated with @fd, on error returns an error pointer.
+ * Returns: The file associated with @fd (NULL if @fd is not open)
  */
 static struct file *pick_file(struct files_struct *files, unsigned fd)
 {
+	struct fdtable *fdt = files_fdtable(files);
 	struct file *file;
-	struct fdtable *fdt;
 
-	spin_lock(&files->file_lock);
-	fdt = files_fdtable(files);
-	if (fd >= fdt->max_fds) {
-		file = ERR_PTR(-EINVAL);
-		goto out_unlock;
-	}
+	if (fd >= fdt->max_fds)
+		return NULL;
+
 	file = fdt->fd[fd];
-	if (!file) {
-		file = ERR_PTR(-EBADF);
-		goto out_unlock;
+	if (file) {
+		rcu_assign_pointer(fdt->fd[fd], NULL);
+		__put_unused_fd(files, fd);
 	}
-	rcu_assign_pointer(fdt->fd[fd], NULL);
-	__put_unused_fd(files, fd);
-
-out_unlock:
-	spin_unlock(&files->file_lock);
 	return file;
 }
 
@@ -664,8 +653,10 @@ int close_fd(unsigned fd)
 	struct files_struct *files = current->files;
 	struct file *file;
 
+	spin_lock(&files->file_lock);
 	file = pick_file(files, fd);
-	if (IS_ERR(file))
+	spin_unlock(&files->file_lock);
+	if (!file)
 		return -EBADF;
 
 	return filp_close(file, files);
@@ -702,20 +693,25 @@ static inline void __range_cloexec(struct files_struct *cur_fds,
 static inline void __range_close(struct files_struct *cur_fds, unsigned int fd,
 				 unsigned int max_fd)
 {
+	unsigned n;
+
+	rcu_read_lock();
+	n = last_fd(files_fdtable(cur_fds));
+	rcu_read_unlock();
+	max_fd = min(max_fd, n);
+
 	while (fd <= max_fd) {
 		struct file *file;
 
+		spin_lock(&cur_fds->file_lock);
 		file = pick_file(cur_fds, fd++);
-		if (!IS_ERR(file)) {
+		spin_unlock(&cur_fds->file_lock);
+
+		if (file) {
 			/* found a valid file to close */
 			filp_close(file, cur_fds);
 			cond_resched();
-			continue;
 		}
-
-		/* beyond the last fd in that table */
-		if (PTR_ERR(file) == -EINVAL)
-			return;
 	}
 }
 
@@ -795,26 +791,9 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
  * See close_fd_get_file() below, this variant assumes current->files->file_lock
  * is held.
  */
-int __close_fd_get_file(unsigned int fd, struct file **res)
+struct file *__close_fd_get_file(unsigned int fd)
 {
-	struct files_struct *files = current->files;
-	struct file *file;
-	struct fdtable *fdt;
-
-	fdt = files_fdtable(files);
-	if (fd >= fdt->max_fds)
-		goto out_err;
-	file = fdt->fd[fd];
-	if (!file)
-		goto out_err;
-	rcu_assign_pointer(fdt->fd[fd], NULL);
-	__put_unused_fd(files, fd);
-	get_file(file);
-	*res = file;
-	return 0;
-out_err:
-	*res = NULL;
-	return -ENOENT;
+	return pick_file(current->files, fd);
 }
 
 /*
@@ -822,16 +801,16 @@ int __close_fd_get_file(unsigned int fd, struct file **res)
  * The caller must ensure that filp_close() called on the file, and then
  * an fput().
  */
-int close_fd_get_file(unsigned int fd, struct file **res)
+struct file *close_fd_get_file(unsigned int fd)
 {
 	struct files_struct *files = current->files;
-	int ret;
+	struct file *file;
 
 	spin_lock(&files->file_lock);
-	ret = __close_fd_get_file(fd, res);
+	file = pick_file(files, fd);
 	spin_unlock(&files->file_lock);
 
-	return ret;
+	return file;
 }
 
 void do_close_on_exec(struct files_struct *files)
diff --git a/fs/internal.h b/fs/internal.h
index 08503dc68d2b..4065e2679103 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -125,7 +125,7 @@ extern struct file *do_file_open_root(const struct path *,
 		const char *, const struct open_flags *);
 extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
-extern int __close_fd_get_file(unsigned int fd, struct file **res);
+extern struct file *__close_fd_get_file(unsigned int fd);
 
 long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 int chmod_common(const struct path *path, umode_t mode);
diff --git a/fs/io_uring.c b/fs/io_uring.c
index dc580a30723d..7257b0870353 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5137,13 +5137,10 @@ static int io_close(struct io_kiocb *req, unsigned int issue_flags)
 		return -EAGAIN;
 	}
 
-	ret = __close_fd_get_file(close->fd, &file);
+	file = __close_fd_get_file(close->fd);
 	spin_unlock(&files->file_lock);
-	if (ret < 0) {
-		if (ret == -ENOENT)
-			ret = -EBADF;
+	if (!file)
 		goto err;
-	}
 
 	/* No ->flush() or already async, safely close from here */
 	ret = filp_close(file, current->files);
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index d0e78174874a..e066816f3519 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -125,7 +125,7 @@ int iterate_fd(struct files_struct *, unsigned,
 
 extern int close_fd(unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
-extern int close_fd_get_file(unsigned int fd, struct file **res);
+extern struct file *close_fd_get_file(unsigned int fd);
 extern int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
 		      struct files_struct **new_fdp);
 
