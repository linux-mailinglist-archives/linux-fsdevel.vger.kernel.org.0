Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DB63618AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 06:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhDPEQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 00:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbhDPEQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 00:16:10 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B49EC061574;
        Thu, 15 Apr 2021 21:15:46 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXFtP-005fj1-Hl; Fri, 16 Apr 2021 04:15:43 +0000
Date:   Fri, 16 Apr 2021 04:15:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH] fs: split receive_fd_replace from __receive_fd
Message-ID: <YHkPb7LSzadhpG6H@zeniv-ca.linux.org.uk>
References: <20210325082209.1067987-1-hch@lst.de>
 <20210325082209.1067987-2-hch@lst.de>
 <202104021157.7B388D1B2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104021157.7B388D1B2@keescook>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 02, 2021 at 12:01:05PM -0700, Kees Cook wrote:
> On Thu, Mar 25, 2021 at 09:22:09AM +0100, Christoph Hellwig wrote:
> > receive_fd_replace shares almost no code with the general case, so split
> > it out.  Also remove the "Bump the sock usage counts" comment from
> > both copies, as that is now what __receive_sock actually does.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> I'm okay with repeating code in fs/file.c. What I wanted to avoid was
> open coded combinations in various callers.

... and that got you a lovely userland ABI, where you have

	(1) newfd >= 0, SECCOMP_ADDFD_FLAG_SETFD is present => replace
	(2) newfd < 0, SECCOMP_ADDFD_FLAG_SETFD is present => insert
	(3) newfd == 0, SECCOMP_ADDFD_FLAG_SETFD not present => insert
	(4) newfd != 0, SECCOMP_ADDFD_FLAG_SETFD not present => -EINVAL

IMO (2) is a bug.  Whether we still can fix it or not... no idea, depends
on whether the actual userland has come to depend upon it.

I suggest turning (2) into an error (-EBADF is what you'd get from
attempt to set something at such descriptor) and seeing if anything
breaks.  And having SECCOMP_ADDFD_FLAG_SETFD status passed into kaddfd
explicitly, with explicit check in seccomp_handle_addfd().  As in

commit 42eb0d54c08a0331d6d295420f602237968d792b
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Mar 25 09:22:09 2021 +0100

    fs: split receive_fd_replace from __receive_fd
    
    receive_fd_replace shares almost no code with the general case, so split
    it out.  Also remove the "Bump the sock usage counts" comment from
    both copies, as that is now what __receive_sock actually does.
    
    [AV: ... and make the only user of receive_fd_replace() choose between
    it and receive_fd() according to what userland had passed to it in
    flags]
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/file.c b/fs/file.c
index f3a4bac2cbe9..d8ccb95a7f41 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1068,8 +1068,6 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 
 /**
  * __receive_fd() - Install received file into file descriptor table
- *
- * @fd: fd to install into (if negative, a new fd will be allocated)
  * @file: struct file that was received from another process
  * @ufd: __user pointer to write new fd number to
  * @o_flags: the O_* flags to apply to the new fd entry
@@ -1083,7 +1081,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
  *
  * Returns newly install fd or -ve on error.
  */
-int __receive_fd(int fd, struct file *file, int __user *ufd, unsigned int o_flags)
+int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
 {
 	int new_fd;
 	int error;
@@ -1092,32 +1090,33 @@ int __receive_fd(int fd, struct file *file, int __user *ufd, unsigned int o_flag
 	if (error)
 		return error;
 
-	if (fd < 0) {
-		new_fd = get_unused_fd_flags(o_flags);
-		if (new_fd < 0)
-			return new_fd;
-	} else {
-		new_fd = fd;
-	}
+	new_fd = get_unused_fd_flags(o_flags);
+	if (new_fd < 0)
+		return new_fd;
 
 	if (ufd) {
 		error = put_user(new_fd, ufd);
 		if (error) {
-			if (fd < 0)
-				put_unused_fd(new_fd);
+			put_unused_fd(new_fd);
 			return error;
 		}
 	}
 
-	if (fd < 0) {
-		fd_install(new_fd, get_file(file));
-	} else {
-		error = replace_fd(new_fd, file, o_flags);
-		if (error)
-			return error;
-	}
+	fd_install(new_fd, get_file(file));
+	__receive_sock(file);
+	return new_fd;
+}
 
-	/* Bump the sock usage counts, if any. */
+int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
+{
+	int error;
+
+	error = security_file_receive(file);
+	if (error)
+		return error;
+	error = replace_fd(new_fd, file, o_flags);
+	if (error)
+		return error;
 	__receive_sock(file);
 	return new_fd;
 }
diff --git a/include/linux/file.h b/include/linux/file.h
index 225982792fa2..2de2e4613d7b 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -92,23 +92,20 @@ extern void put_unused_fd(unsigned int fd);
 
 extern void fd_install(unsigned int fd, struct file *file);
 
-extern int __receive_fd(int fd, struct file *file, int __user *ufd,
+extern int __receive_fd(struct file *file, int __user *ufd,
 			unsigned int o_flags);
 static inline int receive_fd_user(struct file *file, int __user *ufd,
 				  unsigned int o_flags)
 {
 	if (ufd == NULL)
 		return -EFAULT;
-	return __receive_fd(-1, file, ufd, o_flags);
+	return __receive_fd(file, ufd, o_flags);
 }
 static inline int receive_fd(struct file *file, unsigned int o_flags)
 {
-	return __receive_fd(-1, file, NULL, o_flags);
-}
-static inline int receive_fd_replace(int fd, struct file *file, unsigned int o_flags)
-{
-	return __receive_fd(fd, file, NULL, o_flags);
+	return __receive_fd(file, NULL, o_flags);
 }
+int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
 
 extern void flush_delayed_fput(void);
 extern void __fput_sync(struct file *);
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 1d60fc2c9987..4fe19cecaa94 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -119,8 +119,11 @@ struct seccomp_kaddfd {
 	int fd;
 	unsigned int flags;
 
-	/* To only be set on reply */
-	int ret;
+	union {
+		bool setfd;
+		/* To only be set on reply */
+		int ret;
+	};
 	struct completion completion;
 	struct list_head list;
 };
@@ -1069,7 +1072,11 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
 	 * that it has been handled.
 	 */
 	list_del_init(&addfd->list);
-	addfd->ret = receive_fd_replace(addfd->fd, addfd->file, addfd->flags);
+	if (!addfd->setfd)
+		addfd->ret = receive_fd(addfd->file, addfd->flags);
+	else
+		addfd->ret = receive_fd_replace(addfd->fd, addfd->file,
+						addfd->flags);
 	complete(&addfd->completion);
 }
 
@@ -1583,8 +1590,8 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
 		return -EBADF;
 
 	kaddfd.flags = addfd.newfd_flags;
-	kaddfd.fd = (addfd.flags & SECCOMP_ADDFD_FLAG_SETFD) ?
-		    addfd.newfd : -1;
+	kaddfd.setfd = addfd.flags & SECCOMP_ADDFD_FLAG_SETFD;
+	kaddfd.fd = addfd.newfd;
 	init_completion(&kaddfd.completion);
 
 	ret = mutex_lock_interruptible(&filter->notify_lock);
