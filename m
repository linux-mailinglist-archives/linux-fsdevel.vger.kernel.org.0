Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C37243944
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 13:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHMLVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 07:21:18 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59229 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgHMLVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:21:17 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 07DBKk4b096355;
        Thu, 13 Aug 2020 20:20:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Thu, 13 Aug 2020 20:20:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 07DBKjgx096342
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 13 Aug 2020 20:20:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in pipe_read (2)
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+96cc7aba7e969b1d305c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <00000000000045b3fe05abcced2f@google.com>
 <fc097a54-0384-9d21-323f-c3ca52cdb956@I-love.SAKURA.ne.jp>
 <CAHk-=wj15SDiHjP2wPiC=Ru-RrUjOuT4AoULj6N_9pVvSXaWiw@mail.gmail.com>
 <20200807053148.GA10409@redhat.com>
 <e673cccb-1b67-802a-84e3-6aeea4513a09@i-love.sakura.ne.jp>
 <20200810192941.GA16925@redhat.com>
 <d1e83b55-eb09-45e0-95f1-ece41251b036@i-love.sakura.ne.jp>
Message-ID: <dc9b2681-3b84-eb74-8c88-3815beaff7f8@i-love.sakura.ne.jp>
Date:   Thu, 13 Aug 2020 20:20:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d1e83b55-eb09-45e0-95f1-ece41251b036@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/08/13 16:00, Tetsuo Handa wrote:
> On 2020/08/11 4:29, Andrea Arcangeli wrote:
>> However once the mutex is killable there's no concern anymore and the
>> hangcheck timer is correct also not reporting any misbehavior anymore.
> 
> Do you mean something like below untested patch? I think that the difficult
> part is that mutex for close() operation can't become killable. And I worry
> that syzbot soon reports a hung task at pipe_release() instead of pipe_read()
> or pipe_write(). If pagefault with locks held can be avoided, there will be no
> such worry.

Hmm, the difficult part is not limited to close() operation. While some of them
are low hanging fruits, the rest seems to be subtle or complicated. Al, do you
think that we can make all pipe mutex killable?

 fs/pipe.c                 | 104 +++++++++++++++++++++++++++++++-------
 fs/splice.c               |  60 +++++++++++++++-------
 include/linux/pipe_fs_i.h |   5 +-
 3 files changed, 134 insertions(+), 35 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 60dbee457143..f21c420dc7c7 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -66,6 +66,13 @@ static void pipe_lock_nested(struct pipe_inode_info *pipe, int subclass)
 		mutex_lock_nested(&pipe->mutex, subclass);
 }
 
+static int __must_check pipe_lock_killable_nested(struct pipe_inode_info *pipe, int subclass)
+{
+	if (pipe->files)
+		return mutex_lock_killable_nested(&pipe->mutex, subclass);
+	return 0;
+}
+
 void pipe_lock(struct pipe_inode_info *pipe)
 {
 	/*
@@ -75,6 +82,14 @@ void pipe_lock(struct pipe_inode_info *pipe)
 }
 EXPORT_SYMBOL(pipe_lock);
 
+int pipe_lock_killable(struct pipe_inode_info *pipe)
+{
+	/*
+	 * pipe_lock() nests non-pipe inode locks (for writing to a file)
+	 */
+	return pipe_lock_killable_nested(pipe, I_MUTEX_PARENT);
+}
+
 void pipe_unlock(struct pipe_inode_info *pipe)
 {
 	if (pipe->files)
@@ -87,23 +102,37 @@ static inline void __pipe_lock(struct pipe_inode_info *pipe)
 	mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
 }
 
+static inline int __must_check __pipe_lock_killable(struct pipe_inode_info *pipe)
+{
+	return mutex_lock_killable_nested(&pipe->mutex, I_MUTEX_PARENT);
+}
+
 static inline void __pipe_unlock(struct pipe_inode_info *pipe)
 {
 	mutex_unlock(&pipe->mutex);
 }
 
-void pipe_double_lock(struct pipe_inode_info *pipe1,
-		      struct pipe_inode_info *pipe2)
+int pipe_double_lock_killable(struct pipe_inode_info *pipe1,
+			      struct pipe_inode_info *pipe2)
 {
 	BUG_ON(pipe1 == pipe2);
 
 	if (pipe1 < pipe2) {
-		pipe_lock_nested(pipe1, I_MUTEX_PARENT);
-		pipe_lock_nested(pipe2, I_MUTEX_CHILD);
+		if (pipe_lock_killable_nested(pipe1, I_MUTEX_PARENT))
+			return -ERESTARTSYS;
+		if (pipe_lock_killable_nested(pipe2, I_MUTEX_CHILD)) {
+			pipe_unlock(pipe1);
+			return -ERESTARTSYS;
+		}
 	} else {
-		pipe_lock_nested(pipe2, I_MUTEX_PARENT);
-		pipe_lock_nested(pipe1, I_MUTEX_CHILD);
+		if (pipe_lock_killable_nested(pipe2, I_MUTEX_PARENT))
+			return -ERESTARTSYS;
+		if (pipe_lock_killable_nested(pipe1, I_MUTEX_CHILD)) {
+			pipe_unlock(pipe2);
+			return -ERESTARTSYS;
+		}
 	}
+	return 0;
 }
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
@@ -125,6 +154,24 @@ void pipe_wait(struct pipe_inode_info *pipe)
 	pipe_lock(pipe);
 }
 
+int pipe_wait_killable(struct pipe_inode_info *pipe)
+{
+	DEFINE_WAIT(rdwait);
+	DEFINE_WAIT(wrwait);
+
+	/*
+	 * Pipes are system-local resources, so sleeping on them
+	 * is considered a noninteractive wait:
+	 */
+	prepare_to_wait(&pipe->rd_wait, &rdwait, TASK_INTERRUPTIBLE);
+	prepare_to_wait(&pipe->wr_wait, &wrwait, TASK_INTERRUPTIBLE);
+	pipe_unlock(pipe);
+	schedule();
+	finish_wait(&pipe->rd_wait, &rdwait);
+	finish_wait(&pipe->wr_wait, &wrwait);
+	return pipe_lock_killable(pipe);
+}
+
 static void anon_pipe_buf_release(struct pipe_inode_info *pipe,
 				  struct pipe_buffer *buf)
 {
@@ -244,7 +291,8 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		return 0;
 
 	ret = 0;
-	__pipe_lock(pipe);
+	if (__pipe_lock_killable(pipe))
+		return -ERESTARTSYS;
 
 	/*
 	 * We only wake up writers if the pipe was full when we started
@@ -381,7 +429,8 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
 			return -ERESTARTSYS;
 
-		__pipe_lock(pipe);
+		if (__pipe_lock_killable(pipe))
+			return -ERESTARTSYS;
 		was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
 		wake_next_reader = true;
 	}
@@ -432,7 +481,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	if (unlikely(total_len == 0))
 		return 0;
 
-	__pipe_lock(pipe);
+	if (__pipe_lock_killable(pipe))
+		return -ERESTARTSYS;
 
 	if (!pipe->readers) {
 		send_sig(SIGPIPE, current, 0);
@@ -577,7 +627,14 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 		}
 		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
-		__pipe_lock(pipe);
+		if (__pipe_lock_killable(pipe)) {
+			if (!ret)
+				ret = -ERESTARTSYS;
+			/* Extra notification is better than missing notification? */
+			was_empty = true;
+			wake_next_writer = true;
+			goto out_unlocked;
+		}
 		was_empty = pipe_empty(pipe->head, pipe->tail);
 		wake_next_writer = true;
 	}
@@ -586,6 +643,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		wake_next_writer = false;
 	__pipe_unlock(pipe);
 
+out_unlocked:
 	/*
 	 * If we do do a wakeup event, we do a 'sync' wakeup, because we
 	 * want the reader to start processing things asap, rather than
@@ -617,7 +675,8 @@ static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	switch (cmd) {
 	case FIONREAD:
-		__pipe_lock(pipe);
+		if (__pipe_lock_killable(pipe))
+			return -ERESTARTSYS;
 		count = 0;
 		head = pipe->head;
 		tail = pipe->tail;
@@ -634,7 +693,8 @@ static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 #ifdef CONFIG_WATCH_QUEUE
 	case IOC_WATCH_QUEUE_SET_SIZE: {
 		int ret;
-		__pipe_lock(pipe);
+		if (__pipe_lock_killable(pipe))
+			return -ERESTARTSYS;
 		ret = watch_queue_set_size(pipe, arg);
 		__pipe_unlock(pipe);
 		return ret;
@@ -719,6 +779,10 @@ pipe_release(struct inode *inode, struct file *file)
 {
 	struct pipe_inode_info *pipe = file->private_data;
 
+	/*
+	 * This lock can't be killable. How to avoid deadlock if page fault
+	 * with pipe mutex held does not finish quickly?
+	 */
 	__pipe_lock(pipe);
 	if (file->f_mode & FMODE_READ)
 		pipe->readers--;
@@ -744,7 +808,8 @@ pipe_fasync(int fd, struct file *filp, int on)
 	struct pipe_inode_info *pipe = filp->private_data;
 	int retval = 0;
 
-	__pipe_lock(pipe);
+	if (__pipe_lock_killable(pipe)) /* Can this be safely killable? */
+		return -ERESTARTSYS;
 	if (filp->f_mode & FMODE_READ)
 		retval = fasync_helper(fd, filp, on, &pipe->fasync_readers);
 	if ((filp->f_mode & FMODE_WRITE) && retval >= 0) {
@@ -1040,6 +1105,7 @@ static int wait_for_partner(struct pipe_inode_info *pipe, unsigned int *cnt)
 	int cur = *cnt;
 
 	while (cur == *cnt) {
+		/* Can't become killable, for need to lock before return. */
 		pipe_wait(pipe);
 		if (signal_pending(current))
 			break;
@@ -1083,10 +1149,13 @@ static int fifo_open(struct inode *inode, struct file *filp)
 			spin_unlock(&inode->i_lock);
 		}
 	}
-	filp->private_data = pipe;
-	/* OK, we have a pipe and it's pinned down */
 
-	__pipe_lock(pipe);
+	/* OK, we have a pipe and it's pinned down */
+	if (__pipe_lock_killable(pipe)) {
+		put_pipe_info(inode, pipe);
+		return -ERESTARTSYS;
+	}
+	filp->private_data = pipe;
 
 	/* We can only do regular read/write on fifos */
 	stream_open(inode, filp);
@@ -1349,7 +1418,8 @@ long pipe_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (!pipe)
 		return -EBADF;
 
-	__pipe_lock(pipe);
+	if (__pipe_lock_killable(pipe))
+		return -ERESTARTSYS;
 
 	switch (cmd) {
 	case F_SETPIPE_SZ:
diff --git a/fs/splice.c b/fs/splice.c
index d7c8a7c4db07..30069937b063 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -563,6 +563,10 @@ static int splice_from_pipe_next(struct pipe_inode_info *pipe, struct splice_des
 			sd->need_wakeup = false;
 		}
 
+		/*
+		 * Can't become killable for now, for call dependency is
+		 * complicated.
+		 */
 		pipe_wait(pipe);
 	}
 
@@ -657,7 +661,8 @@ ssize_t splice_from_pipe(struct pipe_inode_info *pipe, struct file *out,
 		.u.file = out,
 	};
 
-	pipe_lock(pipe);
+	if (pipe_lock_killable(pipe))
+		return -ERESTARTSYS;
 	ret = __splice_from_pipe(pipe, &sd, actor);
 	pipe_unlock(pipe);
 
@@ -696,7 +701,10 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	if (unlikely(!array))
 		return -ENOMEM;
 
-	pipe_lock(pipe);
+	if (pipe_lock_killable(pipe)) {
+		kfree(array);
+		return -ERESTARTSYS;
+	}
 
 	splice_from_pipe_begin(&sd);
 	while (sd.total_len) {
@@ -1064,8 +1072,9 @@ long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
 }
 EXPORT_SYMBOL(do_splice_direct);
 
-static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
+static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags, bool *locked)
 {
+	*locked = true;
 	for (;;) {
 		if (unlikely(!pipe->readers)) {
 			send_sig(SIGPIPE, current, 0);
@@ -1077,7 +1086,10 @@ static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
 			return -EAGAIN;
 		if (signal_pending(current))
 			return -ERESTARTSYS;
-		pipe_wait(pipe);
+		if (pipe_wait_killable(pipe)) {
+			*locked = false;
+			return -ERESTARTSYS;
+		}
 	}
 }
 
@@ -1153,6 +1165,8 @@ long do_splice(struct file *in, loff_t __user *off_in,
 	}
 
 	if (opipe) {
+		bool locked;
+
 		if (off_out)
 			return -ESPIPE;
 		if (off_in) {
@@ -1167,8 +1181,9 @@ long do_splice(struct file *in, loff_t __user *off_in,
 		if (out->f_flags & O_NONBLOCK)
 			flags |= SPLICE_F_NONBLOCK;
 
-		pipe_lock(opipe);
-		ret = wait_for_space(opipe, flags);
+		if (pipe_lock_killable(opipe))
+			return -ERESTARTSYS;
+		ret = wait_for_space(opipe, flags, &locked);
 		if (!ret) {
 			unsigned int p_space;
 
@@ -1178,7 +1193,8 @@ long do_splice(struct file *in, loff_t __user *off_in,
 
 			ret = do_splice_to(in, &offset, opipe, len, flags);
 		}
-		pipe_unlock(opipe);
+		if (locked)
+			pipe_unlock(opipe);
 		if (ret > 0)
 			wakeup_pipe_readers(opipe);
 		if (!off_in)
@@ -1264,7 +1280,8 @@ static long vmsplice_to_user(struct file *file, struct iov_iter *iter,
 		return -EBADF;
 
 	if (sd.total_len) {
-		pipe_lock(pipe);
+		if (pipe_lock_killable(pipe))
+			return -ERESTARTSYS;
 		ret = __splice_from_pipe(pipe, &sd, pipe_to_user);
 		pipe_unlock(pipe);
 	}
@@ -1283,6 +1300,7 @@ static long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
 	struct pipe_inode_info *pipe;
 	long ret = 0;
 	unsigned buf_flag = 0;
+	bool locked;
 
 	if (flags & SPLICE_F_GIFT)
 		buf_flag = PIPE_BUF_FLAG_GIFT;
@@ -1291,11 +1309,13 @@ static long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
 	if (!pipe)
 		return -EBADF;
 
-	pipe_lock(pipe);
-	ret = wait_for_space(pipe, flags);
+	if (pipe_lock_killable(pipe))
+		return -ERESTARTSYS;
+	ret = wait_for_space(pipe, flags, &locked);
 	if (!ret)
 		ret = iter_to_pipe(iter, pipe, buf_flag);
-	pipe_unlock(pipe);
+	if (locked)
+		pipe_unlock(pipe);
 	if (ret > 0)
 		wakeup_pipe_readers(pipe);
 	return ret;
@@ -1441,7 +1461,8 @@ static int ipipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
 		return 0;
 
 	ret = 0;
-	pipe_lock(pipe);
+	if (pipe_lock_killable(pipe))
+		return -ERESTARTSYS;
 
 	while (pipe_empty(pipe->head, pipe->tail)) {
 		if (signal_pending(current)) {
@@ -1454,7 +1475,8 @@ static int ipipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
 			ret = -EAGAIN;
 			break;
 		}
-		pipe_wait(pipe);
+		if (pipe_wait_killable(pipe))
+			return -ERESTARTSYS;
 	}
 
 	pipe_unlock(pipe);
@@ -1477,7 +1499,8 @@ static int opipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
 		return 0;
 
 	ret = 0;
-	pipe_lock(pipe);
+	if (pipe_lock_killable(pipe))
+		return -ERESTARTSYS;
 
 	while (pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
 		if (!pipe->readers) {
@@ -1493,7 +1516,8 @@ static int opipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
 			ret = -ERESTARTSYS;
 			break;
 		}
-		pipe_wait(pipe);
+		if (pipe_wait_killable(pipe))
+			return -ERESTARTSYS;
 	}
 
 	pipe_unlock(pipe);
@@ -1529,7 +1553,8 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 	 * grabbing by pipe info address. Otherwise two different processes
 	 * could deadlock (one doing tee from A -> B, the other from B -> A).
 	 */
-	pipe_double_lock(ipipe, opipe);
+	if (pipe_double_lock_killable(ipipe, opipe))
+		return -ERESTARTSYS;
 
 	i_tail = ipipe->tail;
 	i_mask = ipipe->ring_size - 1;
@@ -1655,7 +1680,8 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 	 * grabbing by pipe info address. Otherwise two different processes
 	 * could deadlock (one doing tee from A -> B, the other from B -> A).
 	 */
-	pipe_double_lock(ipipe, opipe);
+	if (pipe_double_lock_killable(ipipe, opipe))
+		return -ERESTARTSYS;
 
 	i_tail = ipipe->tail;
 	i_mask = ipipe->ring_size - 1;
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 50afd0d0084c..eb99c18fc12d 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -233,8 +233,10 @@ static inline bool pipe_buf_try_steal(struct pipe_inode_info *pipe,
 
 /* Pipe lock and unlock operations */
 void pipe_lock(struct pipe_inode_info *);
+int __must_check pipe_lock_killable(struct pipe_inode_info *pipe);
 void pipe_unlock(struct pipe_inode_info *);
-void pipe_double_lock(struct pipe_inode_info *, struct pipe_inode_info *);
+int __must_check pipe_double_lock_killable(struct pipe_inode_info *pipe1,
+					   struct pipe_inode_info *pipe2);
 
 extern unsigned int pipe_max_size;
 extern unsigned long pipe_user_pages_hard;
@@ -242,6 +244,7 @@ extern unsigned long pipe_user_pages_soft;
 
 /* Drop the inode semaphore and wait for a pipe event, atomically */
 void pipe_wait(struct pipe_inode_info *pipe);
+int __must_check pipe_wait_killable(struct pipe_inode_info *pipe);
 
 struct pipe_inode_info *alloc_pipe_info(void);
 void free_pipe_info(struct pipe_inode_info *);
-- 
2.18.4

