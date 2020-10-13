Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03C728D609
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 22:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgJMUyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 16:54:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36941 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgJMUyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 16:54:31 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kSRJU-0004qU-Ip; Tue, 13 Oct 2020 20:54:28 +0000
Date:   Tue, 13 Oct 2020 22:54:27 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] fs, close_range: add flag CLOSE_RANGE_CLOEXEC
Message-ID: <20201013205427.clvqno24ctwxbuyv@wittgenstein>
References: <20201013140609.2269319-1-gscrivan@redhat.com>
 <20201013140609.2269319-2-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201013140609.2269319-2-gscrivan@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 04:06:08PM +0200, Giuseppe Scrivano wrote:

Hey Guiseppe,

Thanks for the patch!

> When the flag CLOSE_RANGE_CLOEXEC is set, close_range doesn't
> immediately close the files but it sets the close-on-exec bit.

Hm, please expand on the use-cases a little here so people know where
and how this is useful. Keeping the rationale for a change in the commit
log is really important.

> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---

>  fs/file.c                        | 56 ++++++++++++++++++++++----------
>  include/uapi/linux/close_range.h |  3 ++
>  2 files changed, 42 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 21c0893f2f1d..ad4ebee41e09 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -672,6 +672,17 @@ int __close_fd(struct files_struct *files, unsigned fd)
>  }
>  EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
>  
> +static unsigned int __get_max_fds(struct files_struct *cur_fds)
> +{
> +	unsigned int max_fds;
> +
> +	rcu_read_lock();
> +	/* cap to last valid index into fdtable */
> +	max_fds = files_fdtable(cur_fds)->max_fds;
> +	rcu_read_unlock();
> +	return max_fds;
> +}
> +
>  /**
>   * __close_range() - Close all file descriptors in a given range.
>   *
> @@ -683,27 +694,23 @@ EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
>   */
>  int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
>  {
> -	unsigned int cur_max;
> +	unsigned int cur_max = UINT_MAX;
>  	struct task_struct *me = current;
>  	struct files_struct *cur_fds = me->files, *fds = NULL;
>  
> -	if (flags & ~CLOSE_RANGE_UNSHARE)
> +	if (flags & ~(CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC))
>  		return -EINVAL;
>  
>  	if (fd > max_fd)
>  		return -EINVAL;
>  
> -	rcu_read_lock();
> -	cur_max = files_fdtable(cur_fds)->max_fds;
> -	rcu_read_unlock();
> -
> -	/* cap to last valid index into fdtable */
> -	cur_max--;
> -
>  	if (flags & CLOSE_RANGE_UNSHARE) {
>  		int ret;
>  		unsigned int max_unshare_fds = NR_OPEN_MAX;
>  
> +		/* cap to last valid index into fdtable */
> +		cur_max = __get_max_fds(cur_fds) - 1;
> +
>  		/*
>  		 * If the requested range is greater than the current maximum,
>  		 * we're closing everything so only copy all file descriptors
> @@ -724,16 +731,31 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
>  			swap(cur_fds, fds);
>  	}
>  
> -	max_fd = min(max_fd, cur_max);
> -	while (fd <= max_fd) {
> -		struct file *file;
> +	if (flags & CLOSE_RANGE_CLOEXEC) {
> +		struct fdtable *fdt;
>  
> -		file = pick_file(cur_fds, fd++);
> -		if (!file)
> -			continue;
> +		spin_lock(&cur_fds->file_lock);
> +		fdt = files_fdtable(cur_fds);
> +		cur_max = fdt->max_fds - 1;
> +		max_fd = min(max_fd, cur_max);
> +		while (fd <= max_fd)
> +			__set_close_on_exec(fd++, fdt);
> +		spin_unlock(&cur_fds->file_lock);
> +	} else {
> +		/* Initialize cur_max if needed.  */
> +		if (cur_max == UINT_MAX)
> +			cur_max = __get_max_fds(cur_fds) - 1;

The separation between how cur_fd is retrieved in the two branches makes
the code more difficult to follow imho. Unless there's a clear reason
why you've done it that way I would think that something like the patch
I appended below might be a little clearer and easier to maintain(?).

> +		max_fd = min(max_fd, cur_max);
> +		while (fd <= max_fd) {
> +			struct file *file;
>  
> -		filp_close(file, cur_fds);
> -		cond_resched();
> +			file = pick_file(cur_fds, fd++);
> +			if (!file)
> +				continue;
> +
> +			filp_close(file, cur_fds);
> +			cond_resched();
> +		}
>  	}

I think I don't have quarrels with this patch in principle but I wonder
if something like the following wouldn't be easier to follow:

diff --git a/fs/file.c b/fs/file.c
index 21c0893f2f1d..872a4098c3be 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -672,6 +672,32 @@ int __close_fd(struct files_struct *files, unsigned fd)
 }
 EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
 
+static inline void __range_cloexec(struct files_struct *cur_fds,
+				   unsigned int fd, unsigned max_fd)
+{
+	struct fdtable *fdt;
+	spin_lock(&cur_fds->file_lock);
+	fdt = files_fdtable(cur_fds);
+	while (fd <= max_fd)
+		__set_close_on_exec(fd++, fdt);
+	spin_unlock(&cur_fds->file_lock);
+}
+
+static inline void __range_close(struct files_struct *cur_fds, unsigned int fd,
+				 unsigned max_fd)
+{
+	while (fd <= max_fd) {
+		struct file *file;
+
+		file = pick_file(cur_fds, fd++);
+		if (!file)
+			continue;
+
+		filp_close(file, cur_fds);
+		cond_resched();
+	}
+}
+
 /**
  * __close_range() - Close all file descriptors in a given range.
  *
@@ -687,7 +713,7 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 	struct task_struct *me = current;
 	struct files_struct *cur_fds = me->files, *fds = NULL;
 
-	if (flags & ~CLOSE_RANGE_UNSHARE)
+	if (flags & ~(CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC))
 		return -EINVAL;
 
 	if (fd > max_fd)
@@ -725,16 +751,10 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 	}
 
 	max_fd = min(max_fd, cur_max);
-	while (fd <= max_fd) {
-		struct file *file;
-
-		file = pick_file(cur_fds, fd++);
-		if (!file)
-			continue;
-
-		filp_close(file, cur_fds);
-		cond_resched();
-	}
+	if (flags & CLOSE_RANGE_CLOEXEC)
+		__range_cloexec(cur_fds, fd, max_fd);
+	else
+		__range_close(cur_fds, fd, max_fd);
 
 	if (fds) {
 		/*
diff --git a/include/uapi/linux/close_range.h b/include/uapi/linux/close_range.h
index 6928a9fdee3c..2d804281554c 100644
--- a/include/uapi/linux/close_range.h
+++ b/include/uapi/linux/close_range.h
@@ -5,5 +5,8 @@
 /* Unshare the file descriptor table before closing file descriptors. */
 #define CLOSE_RANGE_UNSHARE	(1U << 1)
 
+/* Set the FD_CLOEXEC bit instead of closing the file descriptor. */
+#define CLOSE_RANGE_CLOEXEC	(1U << 2)
+
 #endif /* _UAPI_LINUX_CLOSE_RANGE_H */
 
