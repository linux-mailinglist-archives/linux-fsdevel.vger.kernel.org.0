Return-Path: <linux-fsdevel+bounces-9181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B81083E997
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 03:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FA11F2AC9D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 02:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C376C14A8C;
	Sat, 27 Jan 2024 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aJfiHuzw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454AC125B0
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706321325; cv=none; b=oEZSUD0NM+5swQTmr5uIq2dMxiT58iRsGHvF3RdvTyilPmyqO5gYIqHYtUZznQKYcTBdl58x6BAqGZ3mOcCwnctR6ZeZ1ZceSIsez5ZI7/g91aSVLHSNVNU1cx+1R5HGtL/rMcIVxEhQOMGkVEFKUUAZOkqYgJr/VZCAFIlOO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706321325; c=relaxed/simple;
	bh=NB0BzrAcaq2ykZlOjZmEopevoBwZpfcanoIfs3aB2/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+D/jPic8WiKMNenWvv29PdwMai6WtQdhrctfnPvhaTLxi7S+dQwq8oE07ldEvu2uaHV1Esujr09mg9HmOr+J9EFJOOoeTPCekBp2bDxAXf0PNcZkAvq0Psjg440lfjydm9rEDg9OftK8bgmWHiPemGdo98lp1N60XQAbPco2zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aJfiHuzw; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706321321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v89WId/z8nf+HOLrRAkJwMVVVvufG9aM/NTrDQ9Z3LE=;
	b=aJfiHuzw/yGaPvnLXQoSJd1AsdnzZh26zTD0SLbAqo014SIZzF1k4FJAMYGEZ8npYeJGV1
	gSfm3vA02aI82CIFXujYe7N6U7jz42etZmXog81znbsO2lnYrEbAYjhU2ywaWIWdN4Cz2q
	1pvCLAjfpFMWmtDr9lqkKMO4RbJI5Xg=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/4] fs/pipe: Convert to lockdep_cmp_fn
Date: Fri, 26 Jan 2024 21:08:28 -0500
Message-ID: <20240127020833.487907-2-kent.overstreet@linux.dev>
In-Reply-To: <20240127020833.487907-1-kent.overstreet@linux.dev>
References: <20240127020833.487907-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

*_lock_nested() is fundamentally broken; lockdep needs to check lock
ordering, but we cannot device a total ordering on an unbounded number
of elements with only a few subclasses.

the replacement is to define lock ordering with a proper comparison
function.

fs/pipe.c was already doing everything correctly otherwise, nothing
much changes here.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/pipe.c | 81 +++++++++++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 45 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index f1adbfe743d4..50c8a8596b52 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -76,18 +76,20 @@ static unsigned long pipe_user_pages_soft = PIPE_DEF_BUFFERS * INR_OPEN_CUR;
  * -- Manfred Spraul <manfred@colorfullife.com> 2002-05-09
  */
 
-static void pipe_lock_nested(struct pipe_inode_info *pipe, int subclass)
+#define cmp_int(l, r)		((l > r) - (l < r))
+
+#ifdef CONFIG_PROVE_LOCKING
+static int pipe_lock_cmp_fn(const struct lockdep_map *a,
+			    const struct lockdep_map *b)
 {
-	if (pipe->files)
-		mutex_lock_nested(&pipe->mutex, subclass);
+	return cmp_int((unsigned long) a, (unsigned long) b);
 }
+#endif
 
 void pipe_lock(struct pipe_inode_info *pipe)
 {
-	/*
-	 * pipe_lock() nests non-pipe inode locks (for writing to a file)
-	 */
-	pipe_lock_nested(pipe, I_MUTEX_PARENT);
+	if (pipe->files)
+		mutex_lock(&pipe->mutex);
 }
 EXPORT_SYMBOL(pipe_lock);
 
@@ -98,28 +100,16 @@ void pipe_unlock(struct pipe_inode_info *pipe)
 }
 EXPORT_SYMBOL(pipe_unlock);
 
-static inline void __pipe_lock(struct pipe_inode_info *pipe)
-{
-	mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
-}
-
-static inline void __pipe_unlock(struct pipe_inode_info *pipe)
-{
-	mutex_unlock(&pipe->mutex);
-}
-
 void pipe_double_lock(struct pipe_inode_info *pipe1,
 		      struct pipe_inode_info *pipe2)
 {
 	BUG_ON(pipe1 == pipe2);
 
-	if (pipe1 < pipe2) {
-		pipe_lock_nested(pipe1, I_MUTEX_PARENT);
-		pipe_lock_nested(pipe2, I_MUTEX_CHILD);
-	} else {
-		pipe_lock_nested(pipe2, I_MUTEX_PARENT);
-		pipe_lock_nested(pipe1, I_MUTEX_CHILD);
-	}
+	if (pipe1 > pipe2)
+		swap(pipe1, pipe2);
+
+	pipe_lock(pipe1);
+	pipe_lock(pipe2);
 }
 
 static void anon_pipe_buf_release(struct pipe_inode_info *pipe,
@@ -271,7 +261,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		return 0;
 
 	ret = 0;
-	__pipe_lock(pipe);
+	mutex_lock(&pipe->mutex);
 
 	/*
 	 * We only wake up writers if the pipe was full when we started
@@ -368,7 +358,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			ret = -EAGAIN;
 			break;
 		}
-		__pipe_unlock(pipe);
+		mutex_unlock(&pipe->mutex);
 
 		/*
 		 * We only get here if we didn't actually read anything.
@@ -400,13 +390,13 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
 			return -ERESTARTSYS;
 
-		__pipe_lock(pipe);
+		mutex_lock(&pipe->mutex);
 		was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
 		wake_next_reader = true;
 	}
 	if (pipe_empty(pipe->head, pipe->tail))
 		wake_next_reader = false;
-	__pipe_unlock(pipe);
+	mutex_unlock(&pipe->mutex);
 
 	if (was_full)
 		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
@@ -462,7 +452,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	if (unlikely(total_len == 0))
 		return 0;
 
-	__pipe_lock(pipe);
+	mutex_lock(&pipe->mutex);
 
 	if (!pipe->readers) {
 		send_sig(SIGPIPE, current, 0);
@@ -582,19 +572,19 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		 * after waiting we need to re-check whether the pipe
 		 * become empty while we dropped the lock.
 		 */
-		__pipe_unlock(pipe);
+		mutex_unlock(&pipe->mutex);
 		if (was_empty)
 			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
-		__pipe_lock(pipe);
+		mutex_lock(&pipe->mutex);
 		was_empty = pipe_empty(pipe->head, pipe->tail);
 		wake_next_writer = true;
 	}
 out:
 	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
 		wake_next_writer = false;
-	__pipe_unlock(pipe);
+	mutex_unlock(&pipe->mutex);
 
 	/*
 	 * If we do do a wakeup event, we do a 'sync' wakeup, because we
@@ -629,7 +619,7 @@ static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	switch (cmd) {
 	case FIONREAD:
-		__pipe_lock(pipe);
+		mutex_lock(&pipe->mutex);
 		count = 0;
 		head = pipe->head;
 		tail = pipe->tail;
@@ -639,16 +629,16 @@ static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			count += pipe->bufs[tail & mask].len;
 			tail++;
 		}
-		__pipe_unlock(pipe);
+		mutex_unlock(&pipe->mutex);
 
 		return put_user(count, (int __user *)arg);
 
 #ifdef CONFIG_WATCH_QUEUE
 	case IOC_WATCH_QUEUE_SET_SIZE: {
 		int ret;
-		__pipe_lock(pipe);
+		mutex_lock(&pipe->mutex);
 		ret = watch_queue_set_size(pipe, arg);
-		__pipe_unlock(pipe);
+		mutex_unlock(&pipe->mutex);
 		return ret;
 	}
 
@@ -734,7 +724,7 @@ pipe_release(struct inode *inode, struct file *file)
 {
 	struct pipe_inode_info *pipe = file->private_data;
 
-	__pipe_lock(pipe);
+	mutex_lock(&pipe->mutex);
 	if (file->f_mode & FMODE_READ)
 		pipe->readers--;
 	if (file->f_mode & FMODE_WRITE)
@@ -747,7 +737,7 @@ pipe_release(struct inode *inode, struct file *file)
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 	}
-	__pipe_unlock(pipe);
+	mutex_unlock(&pipe->mutex);
 
 	put_pipe_info(inode, pipe);
 	return 0;
@@ -759,7 +749,7 @@ pipe_fasync(int fd, struct file *filp, int on)
 	struct pipe_inode_info *pipe = filp->private_data;
 	int retval = 0;
 
-	__pipe_lock(pipe);
+	mutex_lock(&pipe->mutex);
 	if (filp->f_mode & FMODE_READ)
 		retval = fasync_helper(fd, filp, on, &pipe->fasync_readers);
 	if ((filp->f_mode & FMODE_WRITE) && retval >= 0) {
@@ -768,7 +758,7 @@ pipe_fasync(int fd, struct file *filp, int on)
 			/* this can happen only if on == T */
 			fasync_helper(-1, filp, 0, &pipe->fasync_readers);
 	}
-	__pipe_unlock(pipe);
+	mutex_unlock(&pipe->mutex);
 	return retval;
 }
 
@@ -834,6 +824,7 @@ struct pipe_inode_info *alloc_pipe_info(void)
 		pipe->nr_accounted = pipe_bufs;
 		pipe->user = user;
 		mutex_init(&pipe->mutex);
+		lock_set_cmp_fn(&pipe->mutex, pipe_lock_cmp_fn, NULL);
 		return pipe;
 	}
 
@@ -1144,7 +1135,7 @@ static int fifo_open(struct inode *inode, struct file *filp)
 	filp->private_data = pipe;
 	/* OK, we have a pipe and it's pinned down */
 
-	__pipe_lock(pipe);
+	mutex_lock(&pipe->mutex);
 
 	/* We can only do regular read/write on fifos */
 	stream_open(inode, filp);
@@ -1214,7 +1205,7 @@ static int fifo_open(struct inode *inode, struct file *filp)
 	}
 
 	/* Ok! */
-	__pipe_unlock(pipe);
+	mutex_unlock(&pipe->mutex);
 	return 0;
 
 err_rd:
@@ -1230,7 +1221,7 @@ static int fifo_open(struct inode *inode, struct file *filp)
 	goto err;
 
 err:
-	__pipe_unlock(pipe);
+	mutex_unlock(&pipe->mutex);
 
 	put_pipe_info(inode, pipe);
 	return ret;
@@ -1411,7 +1402,7 @@ long pipe_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 	if (!pipe)
 		return -EBADF;
 
-	__pipe_lock(pipe);
+	mutex_lock(&pipe->mutex);
 
 	switch (cmd) {
 	case F_SETPIPE_SZ:
@@ -1425,7 +1416,7 @@ long pipe_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 		break;
 	}
 
-	__pipe_unlock(pipe);
+	mutex_unlock(&pipe->mutex);
 	return ret;
 }
 
-- 
2.43.0


