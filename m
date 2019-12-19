Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABB8125831
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 01:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfLSADZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 19:03:25 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:55029 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSADZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 19:03:25 -0500
X-Originating-IP: 92.243.9.8
Received: from localhost (joshtriplett.org [92.243.9.8])
        (Authenticated sender: josh@joshtriplett.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1F4B11BF208;
        Thu, 19 Dec 2019 00:03:19 +0000 (UTC)
Date:   Wed, 18 Dec 2019 16:03:19 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Akemi Yagi <toracat@elrepo.org>, DJ Delorie <dj@redhat.com>,
        David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
Message-ID: <20191219000013.GB13065@localhost>
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz>
 <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
 <b2ae78da-1c29-8ef7-d0bb-376c52af37c3@yandex-team.ru>
 <CAHk-=wgTisLQ9k-hsQeyrT5qBS0xuQPYsueFWNT3RxbkkVmbjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgTisLQ9k-hsQeyrT5qBS0xuQPYsueFWNT3RxbkkVmbjw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2019 at 02:51:27PM -0800, Linus Torvalds wrote:
> On Wed, Dec 18, 2019 at 12:59 PM Josh Triplett <josh@joshtriplett.org> wrote:
> > Debian and Ubuntu have make 4.2.1-1.2, which includes "[SV 51159] Use a
> > non-blocking read with pselect to avoid hangs." and various other fixes.
> > https://metadata.ftp-master.debian.org/changelogs/main/m/make-dfsg/make-dfsg_4.2.1-1.2_changelog
> > So, both Debian and Ubuntu should be fine with the pipe improvements.
> > (I'm testing that now.)

I've now tested this, and 4.2.1-1.2 doesn't seem to have the same
problem that affects upstream 4.2.1. With Debian and Ubuntu already
fixed, and Fedora now in the process of getting fixed, that should cover
many users who would have the buggy make.

> > Is the version of your non-thundering-herd pipe wakeup patch attached to
> > https://lore.kernel.org/lkml/CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com/
> > still the best version to test performance with?
> 
> That's my latest version, but you'll have to tweak it a tiny bit
> because of d1c6a2aa02af ("pipe: simplify signal handling in
> pipe_read() and add comments") which I did after that patch.

That's what I encountered, and I ended up manually fixing it up,
resulting in the attached patch. Does that look reasonable?

> The easiest way to resolve it is likely to revert that d1c6a2aa02af,
> then apply the non-thundering-herd patch and then apply d1c6a2aa02af
> again by hand - it's fairly straightforward (and you can return
> -ERESTARTSYS directly if wait_event_interruptible_exclusive() fails,
> because of all the same reasons why it coul dhappen without the
> thundering-herd patch.

I can try adding that additional return -ERESTARTSYS. Does that seem
likely to have a noticeable additional performance impact?

- Josh Triplett

--mYCpIKhGyMATD0i+
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="linux-pipe-fix.patch"

 fs/coredump.c             |  4 +--
 fs/pipe.c                 | 67 +++++++++++++++++++++++++++++++----------------
 fs/splice.c               |  8 +++---
 include/linux/pipe_fs_i.h |  2 +-
 4 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index b1ea7dfbd149..f8296a82d01d 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -517,7 +517,7 @@ static void wait_for_dump_helpers(struct file *file)
 	pipe_lock(pipe);
 	pipe->readers++;
 	pipe->writers--;
-	wake_up_interruptible_sync(&pipe->wait);
+	wake_up_interruptible_sync(&pipe->rd_wait);
 	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 	pipe_unlock(pipe);
 
@@ -525,7 +525,7 @@ static void wait_for_dump_helpers(struct file *file)
 	 * We actually want wait_event_freezable() but then we need
 	 * to clear TIF_SIGPENDING and improve dump_interrupted().
 	 */
-	wait_event_interruptible(pipe->wait, pipe->readers == 1);
+	wait_event_interruptible(pipe->rd_wait, pipe->readers == 1);
 
 	pipe_lock(pipe);
 	pipe->readers--;
diff --git a/fs/pipe.c b/fs/pipe.c
index 87109e761fa5..1eb64cab63b5 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -108,16 +108,19 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
 /* Drop the inode semaphore and wait for a pipe event, atomically */
 void pipe_wait(struct pipe_inode_info *pipe)
 {
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT(rdwait);
+	DEFINE_WAIT(wrwait);
 
 	/*
 	 * Pipes are system-local resources, so sleeping on them
 	 * is considered a noninteractive wait:
 	 */
-	prepare_to_wait(&pipe->wait, &wait, TASK_INTERRUPTIBLE);
+	prepare_to_wait(&pipe->rd_wait, &rdwait, TASK_INTERRUPTIBLE);
+	prepare_to_wait(&pipe->wr_wait, &wrwait, TASK_INTERRUPTIBLE);
 	pipe_unlock(pipe);
 	schedule();
-	finish_wait(&pipe->wait, &wait);
+	finish_wait(&pipe->rd_wait, &rdwait);
+	finish_wait(&pipe->wr_wait, &wrwait);
 	pipe_lock(pipe);
 }
 
@@ -286,7 +289,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	size_t total_len = iov_iter_count(to);
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
-	bool was_full;
+	bool was_full, wake_next_reader = false;
 	ssize_t ret;
 
 	/* Null read succeeds. */
@@ -344,10 +347,10 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 
 			if (!buf->len) {
 				pipe_buf_release(pipe, buf);
-				spin_lock_irq(&pipe->wait.lock);
+				spin_lock_irq(&pipe->rd_wait.lock);
 				tail++;
 				pipe->tail = tail;
-				spin_unlock_irq(&pipe->wait.lock);
+				spin_unlock_irq(&pipe->rd_wait.lock);
 			}
 			total_len -= chars;
 			if (!total_len)
@@ -371,19 +374,24 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		}
 		__pipe_unlock(pipe);
 		if (was_full) {
-			wake_up_interruptible_sync_poll(&pipe->wait, EPOLLOUT | EPOLLWRNORM);
+			wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
 			kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 		}
-		wait_event_interruptible(pipe->wait, pipe_readable(pipe));
+		wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe));
 		__pipe_lock(pipe);
 		was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
+		wake_next_reader = true;
 	}
+	if (pipe_empty(pipe->head, pipe->tail))
+		wake_next_reader = false;
 	__pipe_unlock(pipe);
 
 	if (was_full) {
-		wake_up_interruptible_sync_poll(&pipe->wait, EPOLLOUT | EPOLLWRNORM);
+		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
 		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 	}
+	if (wake_next_reader)
+		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 	if (ret > 0)
 		file_accessed(filp);
 	return ret;
@@ -415,6 +423,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	size_t total_len = iov_iter_count(from);
 	ssize_t chars;
 	bool was_empty = false;
+	bool wake_next_writer = false;
 
 	/* Null write succeeds. */
 	if (unlikely(total_len == 0))
@@ -493,16 +502,16 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			 * it, either the reader will consume it or it'll still
 			 * be there for the next write.
 			 */
-			spin_lock_irq(&pipe->wait.lock);
+			spin_lock_irq(&pipe->rd_wait.lock);
 
 			head = pipe->head;
 			if (pipe_full(head, pipe->tail, pipe->max_usage)) {
-				spin_unlock_irq(&pipe->wait.lock);
+				spin_unlock_irq(&pipe->rd_wait.lock);
 				continue;
 			}
 
 			pipe->head = head + 1;
-			spin_unlock_irq(&pipe->wait.lock);
+			spin_unlock_irq(&pipe->rd_wait.lock);
 
 			/* Insert it into the buffer array */
 			buf = &pipe->bufs[head & mask];
@@ -554,14 +563,17 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		 */
 		__pipe_unlock(pipe);
 		if (was_empty) {
-			wake_up_interruptible_sync_poll(&pipe->wait, EPOLLIN | EPOLLRDNORM);
+			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 			kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 		}
-		wait_event_interruptible(pipe->wait, pipe_writable(pipe));
+		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
 		__pipe_lock(pipe);
 		was_empty = pipe_empty(head, pipe->tail);
+		wake_next_writer = true;
 	}
 out:
+	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
+		wake_next_writer = false;
 	__pipe_unlock(pipe);
 
 	/*
@@ -574,9 +586,11 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	 * wake up pending jobs
 	 */
 	if (was_empty) {
-		wake_up_interruptible_sync_poll(&pipe->wait, EPOLLIN | EPOLLRDNORM);
+		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 	}
+	if (wake_next_writer)
+		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
 	if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb)) {
 		int err = file_update_time(filp);
 		if (err)
@@ -620,12 +634,15 @@ pipe_poll(struct file *filp, poll_table *wait)
 	unsigned int head, tail;
 
 	/*
-	 * Reading only -- no need for acquiring the semaphore.
+	 * Reading pipe state only -- no need for acquiring the semaphore.
 	 *
 	 * But because this is racy, the code has to add the
 	 * entry to the poll table _first_ ..
 	 */
-	poll_wait(filp, &pipe->wait, wait);
+	if (filp->f_mode & FMODE_READ)
+		poll_wait(filp, &pipe->rd_wait, wait);
+	if (filp->f_mode & FMODE_WRITE)
+		poll_wait(filp, &pipe->wr_wait, wait);
 
 	/*
 	 * .. and only then can you do the racy tests. That way,
@@ -684,7 +701,8 @@ pipe_release(struct inode *inode, struct file *file)
 		pipe->writers--;
 
 	if (pipe->readers || pipe->writers) {
-		wake_up_interruptible_sync_poll(&pipe->wait, EPOLLIN | EPOLLOUT | EPOLLRDNORM | EPOLLWRNORM | EPOLLERR | EPOLLHUP);
+		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM | EPOLLERR | EPOLLHUP);
+		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM | EPOLLERR | EPOLLHUP);
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 	}
@@ -767,7 +785,8 @@ struct pipe_inode_info *alloc_pipe_info(void)
 			     GFP_KERNEL_ACCOUNT);
 
 	if (pipe->bufs) {
-		init_waitqueue_head(&pipe->wait);
+		init_waitqueue_head(&pipe->rd_wait);
+		init_waitqueue_head(&pipe->wr_wait);
 		pipe->r_counter = pipe->w_counter = 1;
 		pipe->max_usage = pipe_bufs;
 		pipe->ring_size = pipe_bufs;
@@ -985,7 +1004,8 @@ static int wait_for_partner(struct pipe_inode_info *pipe, unsigned int *cnt)
 
 static void wake_up_partner(struct pipe_inode_info *pipe)
 {
-	wake_up_interruptible(&pipe->wait);
+	wake_up_interruptible(&pipe->rd_wait);
+	wake_up_interruptible(&pipe->wr_wait);
 }
 
 static int fifo_open(struct inode *inode, struct file *filp)
@@ -1096,13 +1116,13 @@ static int fifo_open(struct inode *inode, struct file *filp)
 
 err_rd:
 	if (!--pipe->readers)
-		wake_up_interruptible(&pipe->wait);
+		wake_up_interruptible(&pipe->wr_wait);
 	ret = -ERESTARTSYS;
 	goto err;
 
 err_wr:
 	if (!--pipe->writers)
-		wake_up_interruptible(&pipe->wait);
+		wake_up_interruptible(&pipe->rd_wait);
 	ret = -ERESTARTSYS;
 	goto err;
 
@@ -1229,7 +1249,8 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	pipe->max_usage = nr_slots;
 	pipe->tail = tail;
 	pipe->head = head;
-	wake_up_interruptible_all(&pipe->wait);
+	wake_up_interruptible_all(&pipe->rd_wait);
+	wake_up_interruptible_all(&pipe->wr_wait);
 	return pipe->max_usage * PAGE_SIZE;
 
 out_revert_acct:
diff --git a/fs/splice.c b/fs/splice.c
index 3009652a41c8..d671936d0aad 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -165,8 +165,8 @@ static const struct pipe_buf_operations user_page_pipe_buf_ops = {
 static void wakeup_pipe_readers(struct pipe_inode_info *pipe)
 {
 	smp_mb();
-	if (waitqueue_active(&pipe->wait))
-		wake_up_interruptible(&pipe->wait);
+	if (waitqueue_active(&pipe->rd_wait))
+		wake_up_interruptible(&pipe->rd_wait);
 	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 }
 
@@ -462,8 +462,8 @@ static int pipe_to_sendpage(struct pipe_inode_info *pipe,
 static void wakeup_pipe_writers(struct pipe_inode_info *pipe)
 {
 	smp_mb();
-	if (waitqueue_active(&pipe->wait))
-		wake_up_interruptible(&pipe->wait);
+	if (waitqueue_active(&pipe->wr_wait))
+		wake_up_interruptible(&pipe->wr_wait);
 	kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 }
 
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index dbcfa6892384..d5765039652a 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -47,7 +47,7 @@ struct pipe_buffer {
  **/
 struct pipe_inode_info {
 	struct mutex mutex;
-	wait_queue_head_t wait;
+	wait_queue_head_t rd_wait, wr_wait;
 	unsigned int head;
 	unsigned int tail;
 	unsigned int max_usage;

--mYCpIKhGyMATD0i+--
