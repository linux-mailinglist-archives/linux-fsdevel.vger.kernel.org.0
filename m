Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCF024EA8D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Aug 2020 02:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgHWAV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 20:21:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58520 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgHWAV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 20:21:57 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 07N0LLXm014978;
        Sun, 23 Aug 2020 09:21:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Sun, 23 Aug 2020 09:21:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 07N0LK3T014964
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 23 Aug 2020 09:21:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] pipe: make pipe_release() deferrable.
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
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
 <dc9b2681-3b84-eb74-8c88-3815beaff7f8@i-love.sakura.ne.jp>
 <7ba35ca4-13c1-caa3-0655-50d328304462@i-love.sakura.ne.jp>
 <CAADWXX-wpVR5Y1Z=BH5QnMjbsGbkQT__r4D2zCFFVycMDELxOQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <29dd8637-5e44-db4a-9aea-305b079941fb@i-love.sakura.ne.jp>
Date:   Sun, 23 Aug 2020 09:21:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAADWXX-wpVR5Y1Z=BH5QnMjbsGbkQT__r4D2zCFFVycMDELxOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/08/23 1:30, Linus Torvalds wrote:
> On Fri, Aug 21, 2020 at 9:35 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Therefore, this patch tries to convert __pipe_lock() in pipe_release() to
>> killable, by deferring to a workqueue context when __pipe_lock_killable()
>> failed.
> 
> I don't think this is an improvement.
> 
> If somebody can delay the pipe unlock arbitrarily, you've now turned a
> user-visible blocking operation into blocking a workqueue instead. So
> it's still there, and now it possibly is much worse and blocks
> system_wq instead.

We can use a dedicated WQ_MEM_RECLAIM workqueue (like mm_percpu_wq)
if blocking system_wq is a concern.

Moving a user-visible blocking operation into blocking a workqueue helps
avoiding AB-BA deadlocks in some situations. This hung task report says that
a task can't close file descriptor of userfaultfd unless pipe_release()
completes while pipe_write() (which is blocking pipe_release()) can abort
if file descriptor of userfaultfd is closed. A different report [1] says that
a task can't close file descriptor of /dev/raw-gadget unless wdm_flush()
completes while wdm_flush() can abort if file descriptor of /dev/raw-gadget
is closed.

handle_userfault() is a method for delaying for arbitrarily period (and this
report says the period is forever due to AB-BA deadlock condition). But if each
copy_page_to_iter()/copy_page_from_iter() takes 10 seconds for whatever reason,
it is sufficient for triggering khungtaskd warning (demonstrated by patch below).

We can't use too short pagefault timeout for "do not break e.g. live migration"
but we need to use short pagefault timeout for "do not trigger khungtaskd warning"
and we can't use long khungtaskd timeout for "detect really hanging tasks".
I think these are incompatible as long as uninterruptible wait is used.

[1] https://lkml.kernel.org/r/1597188375-4787-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp

----------------------------------------
diff --git a/fs/pipe.c b/fs/pipe.c
index 60dbee457143..2510c6a330b8 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -82,9 +82,13 @@ void pipe_unlock(struct pipe_inode_info *pipe)
 }
 EXPORT_SYMBOL(pipe_unlock);
 
-static inline void __pipe_lock(struct pipe_inode_info *pipe)
+static inline void __pipe_lock(struct pipe_inode_info *pipe, const char *func)
 {
+	if (!strcmp(current->comm, "a.out"))
+		printk("%s started __pipe_lock()\n", func);
 	mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
+	if (!strcmp(current->comm, "a.out"))
+		printk("%s completed __pipe_lock()\n", func);
 }
 
 static inline void __pipe_unlock(struct pipe_inode_info *pipe)
@@ -244,7 +248,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		return 0;
 
 	ret = 0;
-	__pipe_lock(pipe);
+	__pipe_lock(pipe, __func__);
 
 	/*
 	 * We only wake up writers if the pipe was full when we started
@@ -306,6 +310,12 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 				break;
 			}
 
+			if (!strcmp(current->comm, "a.out")) {
+				int i;
+
+				for (i = 0; i < 10; i++)
+					schedule_timeout_uninterruptible(HZ);
+			}
 			written = copy_page_to_iter(buf->page, buf->offset, chars, to);
 			if (unlikely(written < chars)) {
 				if (!ret)
@@ -381,7 +391,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
 			return -ERESTARTSYS;
 
-		__pipe_lock(pipe);
+		__pipe_lock(pipe, __func__);
 		was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
 		wake_next_reader = true;
 	}
@@ -432,7 +442,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	if (unlikely(total_len == 0))
 		return 0;
 
-	__pipe_lock(pipe);
+	__pipe_lock(pipe, __func__);
 
 	if (!pipe->readers) {
 		send_sig(SIGPIPE, current, 0);
@@ -472,6 +482,12 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			if (ret)
 				goto out;
 
+			if (!strcmp(current->comm, "a.out")) {
+				int i;
+
+				for (i = 0; i < 10; i++)
+					schedule_timeout_uninterruptible(HZ);
+			}
 			ret = copy_page_from_iter(buf->page, offset, chars, from);
 			if (unlikely(ret < chars)) {
 				ret = -EFAULT;
@@ -536,6 +552,12 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				buf->flags = PIPE_BUF_FLAG_CAN_MERGE;
 			pipe->tmp_page = NULL;
 
+			if (!strcmp(current->comm, "a.out")) {
+				int i;
+
+				for (i = 0; i < 10; i++)
+					schedule_timeout_uninterruptible(HZ);
+			}
 			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
 			if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {
 				if (!ret)
@@ -577,7 +599,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 		}
 		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
-		__pipe_lock(pipe);
+		__pipe_lock(pipe, __func__);
 		was_empty = pipe_empty(pipe->head, pipe->tail);
 		wake_next_writer = true;
 	}
@@ -617,7 +639,7 @@ static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	switch (cmd) {
 	case FIONREAD:
-		__pipe_lock(pipe);
+		__pipe_lock(pipe, __func__);
 		count = 0;
 		head = pipe->head;
 		tail = pipe->tail;
@@ -634,7 +656,7 @@ static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 #ifdef CONFIG_WATCH_QUEUE
 	case IOC_WATCH_QUEUE_SET_SIZE: {
 		int ret;
-		__pipe_lock(pipe);
+		__pipe_lock(pipe, __func__);
 		ret = watch_queue_set_size(pipe, arg);
 		__pipe_unlock(pipe);
 		return ret;
@@ -719,7 +741,7 @@ pipe_release(struct inode *inode, struct file *file)
 {
 	struct pipe_inode_info *pipe = file->private_data;
 
-	__pipe_lock(pipe);
+	__pipe_lock(pipe, __func__);
 	if (file->f_mode & FMODE_READ)
 		pipe->readers--;
 	if (file->f_mode & FMODE_WRITE)
@@ -744,7 +766,7 @@ pipe_fasync(int fd, struct file *filp, int on)
 	struct pipe_inode_info *pipe = filp->private_data;
 	int retval = 0;
 
-	__pipe_lock(pipe);
+	__pipe_lock(pipe, __func__);
 	if (filp->f_mode & FMODE_READ)
 		retval = fasync_helper(fd, filp, on, &pipe->fasync_readers);
 	if ((filp->f_mode & FMODE_WRITE) && retval >= 0) {
@@ -1086,7 +1108,7 @@ static int fifo_open(struct inode *inode, struct file *filp)
 	filp->private_data = pipe;
 	/* OK, we have a pipe and it's pinned down */
 
-	__pipe_lock(pipe);
+	__pipe_lock(pipe, __func__);
 
 	/* We can only do regular read/write on fifos */
 	stream_open(inode, filp);
@@ -1349,7 +1371,7 @@ long pipe_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (!pipe)
 		return -EBADF;
 
-	__pipe_lock(pipe);
+	__pipe_lock(pipe, __func__);
 
 	switch (cmd) {
 	case F_SETPIPE_SZ:
----------------------------------------

----------------------------------------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
        static char buffer[4096 * 32];
        int pipe_fd[2] = { -1, -1 };
        pipe(pipe_fd);
        if (fork() == 0) {
                close(pipe_fd[1]);
                sleep(1);
                close(pipe_fd[0]); // blocked until write() releases pipe mutex.
                _exit(0);
        }
        close(pipe_fd[0]);
        write(pipe_fd[1], buffer, sizeof(buffer));
        close(pipe_fd[1]);
        return 0;
}
----------------------------------------

----------------------------------------
[   67.674493][ T2800] pipe_write started __pipe_lock()
[   67.676820][ T2800] pipe_write completed __pipe_lock()
[   68.675176][ T2801] pipe_release started __pipe_lock()
[  217.648842][   T33] INFO: task a.out:2801 blocked for more than 144 seconds.
[  217.656134][   T33]       Not tainted 5.9.0-rc1+ #808
[  217.660467][   T33] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  217.667303][   T33] task:a.out           state:D stack:    0 pid: 2801 ppid:  2800 flags:0x00000080
[  217.674941][   T33] Call Trace:
[  217.677903][   T33]  __schedule+0x1f0/0x5b0
[  217.681688][   T33]  ? irq_work_queue+0x21/0x30
[  217.685524][   T33]  schedule+0x3f/0xb0
[  217.689741][   T33]  schedule_preempt_disabled+0x9/0x10
[  217.694009][   T33]  __mutex_lock.isra.12+0x2b2/0x4a0
[  217.698635][   T33]  ? vprintk_default+0x1a/0x20
[  217.702470][   T33]  __mutex_lock_slowpath+0xe/0x10
[  217.706434][   T33]  mutex_lock+0x27/0x30
[  217.710167][   T33]  pipe_release+0x4e/0x120
[  217.713657][   T33]  __fput+0x92/0x240
[  217.715745][   T33]  ____fput+0x9/0x10
[  217.717756][   T33]  task_work_run+0x69/0xa0
[  217.719992][   T33]  exit_to_user_mode_prepare+0x125/0x130
[  217.722709][   T33]  syscall_exit_to_user_mode+0x27/0xf0
[  217.725345][   T33]  do_syscall_64+0x3d/0x40
[  217.727820][   T33]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  217.731030][   T33] RIP: 0033:0x7fb09f7ba050
[  217.733359][   T33] Code: Bad RIP value.
[  217.735458][   T33] RSP: 002b:00007ffc41c02828 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  217.739376][   T33] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fb09f7ba050
[  217.743027][   T33] RDX: 0000000000000000 RSI: 00007ffc41c02650 RDI: 0000000000000003
[  217.746360][   T33] RBP: 0000000000000000 R08: 00007ffc41c02760 R09: 00007ffc41c025a0
[  217.749835][   T33] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000400621
[  217.752847][   T33] R13: 00007ffc41c02920 R14: 0000000000000000 R15: 0000000000000000
[  222.768491][   T33] INFO: task a.out:2801 blocked for more than 149 seconds.
[  222.771191][   T33]       Not tainted 5.9.0-rc1+ #808
[  222.773277][   T33] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  222.776857][   T33] task:a.out           state:D stack:    0 pid: 2801 ppid:  2800 flags:0x00000080
[  222.780868][   T33] Call Trace:
[  222.782290][   T33]  __schedule+0x1f0/0x5b0
[  222.784255][   T33]  ? irq_work_queue+0x21/0x30
[  222.786433][   T33]  schedule+0x3f/0xb0
[  222.788449][   T33]  schedule_preempt_disabled+0x9/0x10
[  222.790697][   T33]  __mutex_lock.isra.12+0x2b2/0x4a0
[  222.792746][   T33]  ? vprintk_default+0x1a/0x20
[  222.794633][   T33]  __mutex_lock_slowpath+0xe/0x10
[  222.796631][   T33]  mutex_lock+0x27/0x30
[  222.798316][   T33]  pipe_release+0x4e/0x120
[  222.800085][   T33]  __fput+0x92/0x240
[  222.802046][   T33]  ____fput+0x9/0x10
[  222.803663][   T33]  task_work_run+0x69/0xa0
[  222.805386][   T33]  exit_to_user_mode_prepare+0x125/0x130
[  222.807582][   T33]  syscall_exit_to_user_mode+0x27/0xf0
[  222.809615][   T33]  do_syscall_64+0x3d/0x40
[  222.811299][   T33]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  222.813661][   T33] RIP: 0033:0x7fb09f7ba050
[  222.815357][   T33] Code: Bad RIP value.
[  222.817354][   T33] RSP: 002b:00007ffc41c02828 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  222.821300][   T33] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fb09f7ba050
[  222.824229][   T33] RDX: 0000000000000000 RSI: 00007ffc41c02650 RDI: 0000000000000003
[  222.827439][   T33] RBP: 0000000000000000 R08: 00007ffc41c02760 R09: 00007ffc41c025a0
[  222.830442][   T33] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000400621
[  222.833388][   T33] R13: 00007ffc41c02920 R14: 0000000000000000 R15: 0000000000000000
[  227.888517][   T33] INFO: task a.out:2801 blocked for more than 154 seconds.
[  227.893406][   T33]       Not tainted 5.9.0-rc1+ #808
[  227.896959][   T33] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  227.902882][   T33] task:a.out           state:D stack:    0 pid: 2801 ppid:  2800 flags:0x00000080
[  227.910517][   T33] Call Trace:
[  227.913261][   T33]  __schedule+0x1f0/0x5b0
[  227.916444][   T33]  ? irq_work_queue+0x21/0x30
[  227.919706][   T33]  schedule+0x3f/0xb0
[  227.922740][   T33]  schedule_preempt_disabled+0x9/0x10
[  227.926799][   T33]  __mutex_lock.isra.12+0x2b2/0x4a0
[  227.930554][   T33]  ? vprintk_default+0x1a/0x20
[  227.933855][   T33]  __mutex_lock_slowpath+0xe/0x10
[  227.937291][   T33]  mutex_lock+0x27/0x30
[  227.940365][   T33]  pipe_release+0x4e/0x120
[  227.943504][   T33]  __fput+0x92/0x240
[  227.945133][   T33]  ____fput+0x9/0x10
[  227.947085][   T33]  task_work_run+0x69/0xa0
[  227.949361][   T33]  exit_to_user_mode_prepare+0x125/0x130
[  227.951688][   T33]  syscall_exit_to_user_mode+0x27/0xf0
[  227.953809][   T33]  do_syscall_64+0x3d/0x40
[  227.955615][   T33]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  227.958389][   T33] RIP: 0033:0x7fb09f7ba050
[  227.960177][   T33] Code: Bad RIP value.
[  227.961964][   T33] RSP: 002b:00007ffc41c02828 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  227.965075][   T33] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fb09f7ba050
[  227.968559][   T33] RDX: 0000000000000000 RSI: 00007ffc41c02650 RDI: 0000000000000003
[  227.971582][   T33] RBP: 0000000000000000 R08: 00007ffc41c02760 R09: 00007ffc41c025a0
[  227.974721][   T33] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000400621
[  227.977725][   T33] R13: 00007ffc41c02920 R14: 0000000000000000 R15: 0000000000000000
[  231.537242][ T2801] pipe_release completed __pipe_lock()
[  231.551865][ T2800] pipe_write started __pipe_lock()
[  231.556124][ T2800] pipe_write completed __pipe_lock()
[  231.560827][ T2800] pipe_release started __pipe_lock()
[  231.565195][ T2800] pipe_release completed __pipe_lock()
----------------------------------------

