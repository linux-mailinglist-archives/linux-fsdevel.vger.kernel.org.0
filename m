Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFE2D8284
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 23:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfJOVsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 17:48:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729725AbfJOVsW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:48:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0152830860DB;
        Tue, 15 Oct 2019 21:48:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3915F5C28F;
        Tue, 15 Oct 2019 21:48:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 03/21] pipe: Use head and tail pointers for the ring,
 not cursor and length
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Oct 2019 22:48:15 +0100
Message-ID: <157117609543.15019.17103851546424902507.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 15 Oct 2019 21:48:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert pipes to use head and tail pointers for the buffer ring rather than
pointer and length as the latter requires two atomic ops to update (or a
combined op) whereas the former only requires one.

 (1) The head pointer is the point at which production occurs and points to
     the slot in which the next buffer will be placed.  This is equivalent
     to pipe->curbuf + pipe->nrbufs.

     The head pointer belongs to the write-side.

 (2) The tail pointer is the point at which consumption occurs.  It points
     to the next slot to be consumed.  This is equivalent to pipe->curbuf.

     The tail pointer belongs to the read-side.

 (3) head and tail are allowed to run to UINT_MAX and wrap naturally.  They
     are only masked off when the array is being accessed, e.g.:

	pipe->bufs[head & mask]

     This means that it is not necessary to have a dead slot in the ring as
     head == tail isn't ambiguous.

 (4) The ring is empty if "head == tail".

 (5) The occupancy of the ring is "head - tail".

 (6) The number of free slots in the ring is "(tail + pipe->ring_size) -
     head".

 (7) The ring is full if "head >= (tail + pipe->ring_size)", which can also
     be written as "head - tail >= pipe->ring_size".

Also split pipe->buffers into pipe->ring_size (which indicates the size of the
ring) and pipe->max_usage (which restricts the amount of ring that write() is
allowed to fill).  This allows for a pipe that is both writable by the kernel
notification facility and by userspace, allowing plenty of ring space for
notifications to be added whilst preventing userspace from being able to use
up too much buffer space.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fuse/dev.c             |   31 +++--
 fs/pipe.c                 |  168 ++++++++++++++++------------
 fs/splice.c               |  183 ++++++++++++++++++------------
 include/linux/pipe_fs_i.h |   38 ++++++
 include/linux/uio.h       |    4 -
 lib/iov_iter.c            |  274 ++++++++++++++++++++++++++-------------------
 6 files changed, 421 insertions(+), 277 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index dadd617d826c..8bbe5ec6c336 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -703,7 +703,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 			cs->pipebufs++;
 			cs->nr_segs--;
 		} else {
-			if (cs->nr_segs == cs->pipe->buffers)
+			if (cs->nr_segs >= cs->pipe->max_usage)
 				return -EIO;
 
 			page = alloc_page(GFP_HIGHUSER);
@@ -879,7 +879,7 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
 	struct pipe_buffer *buf;
 	int err;
 
-	if (cs->nr_segs == cs->pipe->buffers)
+	if (cs->nr_segs >= cs->pipe->max_usage)
 		return -EIO;
 
 	err = unlock_request(cs->req);
@@ -1341,7 +1341,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 	if (!fud)
 		return -EPERM;
 
-	bufs = kvmalloc_array(pipe->buffers, sizeof(struct pipe_buffer),
+	bufs = kvmalloc_array(pipe->max_usage, sizeof(struct pipe_buffer),
 			      GFP_KERNEL);
 	if (!bufs)
 		return -ENOMEM;
@@ -1353,7 +1353,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 	if (ret < 0)
 		goto out;
 
-	if (pipe->nrbufs + cs.nr_segs > pipe->buffers) {
+	if (pipe->head - pipe->tail + cs.nr_segs > pipe->max_usage) {
 		ret = -EIO;
 		goto out;
 	}
@@ -1935,6 +1935,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 				     struct file *out, loff_t *ppos,
 				     size_t len, unsigned int flags)
 {
+	unsigned int head, tail, mask, count;
 	unsigned nbuf;
 	unsigned idx;
 	struct pipe_buffer *bufs;
@@ -1949,8 +1950,12 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 
 	pipe_lock(pipe);
 
-	bufs = kvmalloc_array(pipe->nrbufs, sizeof(struct pipe_buffer),
-			      GFP_KERNEL);
+	head = pipe->head;
+	tail = pipe->tail;
+	mask = pipe->ring_size - 1;
+	count = head - tail;
+
+	bufs = kvmalloc_array(count, sizeof(struct pipe_buffer), GFP_KERNEL);
 	if (!bufs) {
 		pipe_unlock(pipe);
 		return -ENOMEM;
@@ -1958,8 +1963,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 
 	nbuf = 0;
 	rem = 0;
-	for (idx = 0; idx < pipe->nrbufs && rem < len; idx++)
-		rem += pipe->bufs[(pipe->curbuf + idx) & (pipe->buffers - 1)].len;
+	for (idx = tail; idx < head && rem < len; idx++)
+		rem += pipe->bufs[idx & mask].len;
 
 	ret = -EINVAL;
 	if (rem < len)
@@ -1970,16 +1975,16 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 		struct pipe_buffer *ibuf;
 		struct pipe_buffer *obuf;
 
-		BUG_ON(nbuf >= pipe->buffers);
-		BUG_ON(!pipe->nrbufs);
-		ibuf = &pipe->bufs[pipe->curbuf];
+		BUG_ON(nbuf >= pipe->ring_size);
+		BUG_ON(tail == head);
+		ibuf = &pipe->bufs[tail];
 		obuf = &bufs[nbuf];
 
 		if (rem >= ibuf->len) {
 			*obuf = *ibuf;
 			ibuf->ops = NULL;
-			pipe->curbuf = (pipe->curbuf + 1) & (pipe->buffers - 1);
-			pipe->nrbufs--;
+			tail++;
+			pipe_commit_read(pipe, tail);
 		} else {
 			if (!pipe_buf_get(pipe, ibuf))
 				goto out_free;
diff --git a/fs/pipe.c b/fs/pipe.c
index 8a2ab2f974bd..0574277bad18 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -43,10 +43,11 @@ unsigned long pipe_user_pages_hard;
 unsigned long pipe_user_pages_soft = PIPE_DEF_BUFFERS * INR_OPEN_CUR;
 
 /*
- * We use a start+len construction, which provides full use of the 
- * allocated memory.
- * -- Florian Coosmann (FGC)
- * 
+ * We use head and tail indices that aren't masked off, except at the point of
+ * dereference, but rather they're allowed to wrap naturally.  This means there
+ * isn't a dead spot in the buffer, provided the ring size < INT_MAX.
+ * -- David Howells 2019-09-23.
+ *
  * Reads with count = 0 should always return 0.
  * -- Julian Bradfield 1999-06-07.
  *
@@ -285,10 +286,12 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	ret = 0;
 	__pipe_lock(pipe);
 	for (;;) {
-		int bufs = pipe->nrbufs;
-		if (bufs) {
-			int curbuf = pipe->curbuf;
-			struct pipe_buffer *buf = pipe->bufs + curbuf;
+		unsigned int head = pipe->head;
+		unsigned int tail = pipe->tail;
+		unsigned int mask = pipe->ring_size - 1;
+
+		if (tail != head) {
+			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
 			size_t chars = buf->len;
 			size_t written;
 			int error;
@@ -321,17 +324,17 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 
 			if (!buf->len) {
 				pipe_buf_release(pipe, buf);
-				curbuf = (curbuf + 1) & (pipe->buffers - 1);
-				pipe->curbuf = curbuf;
-				pipe->nrbufs = --bufs;
+				tail++;
+				pipe_commit_read(pipe, tail);
 				do_wakeup = 1;
 			}
 			total_len -= chars;
 			if (!total_len)
 				break;	/* common path: read succeeded */
+			if (tail != head)	/* More to do? */
+				continue;
 		}
-		if (bufs)	/* More to do? */
-			continue;
+
 		if (!pipe->writers)
 			break;
 		if (!pipe->waiting_writers) {
@@ -380,6 +383,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
+	unsigned int head, tail, buffers, mask;
 	ssize_t ret = 0;
 	int do_wakeup = 0;
 	size_t total_len = iov_iter_count(from);
@@ -397,12 +401,15 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
+	tail = pipe->tail;
+	head = pipe->head;
+	buffers = pipe->max_usage;
+	mask = pipe->ring_size - 1;
+
 	/* We try to merge small writes */
 	chars = total_len & (PAGE_SIZE-1); /* size of the last buffer */
-	if (pipe->nrbufs && chars != 0) {
-		int lastbuf = (pipe->curbuf + pipe->nrbufs - 1) &
-							(pipe->buffers - 1);
-		struct pipe_buffer *buf = pipe->bufs + lastbuf;
+	if (head != tail && chars != 0) {
+		struct pipe_buffer *buf = &pipe->bufs[(head - 1) & mask];
 		int offset = buf->offset + buf->len;
 
 		if (pipe_buf_can_merge(buf) && offset + chars <= PAGE_SIZE) {
@@ -423,18 +430,16 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	for (;;) {
-		int bufs;
-
 		if (!pipe->readers) {
 			send_sig(SIGPIPE, current, 0);
 			if (!ret)
 				ret = -EPIPE;
 			break;
 		}
-		bufs = pipe->nrbufs;
-		if (bufs < pipe->buffers) {
-			int newbuf = (pipe->curbuf + bufs) & (pipe->buffers-1);
-			struct pipe_buffer *buf = pipe->bufs + newbuf;
+
+		tail = pipe->tail;
+		if (head - tail < buffers) {
+			struct pipe_buffer *buf = &pipe->bufs[head & mask];
 			struct page *page = pipe->tmp_page;
 			int copied;
 
@@ -470,14 +475,19 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				buf->ops = &packet_pipe_buf_ops;
 				buf->flags = PIPE_BUF_FLAG_PACKET;
 			}
-			pipe->nrbufs = ++bufs;
+
+			head++;
+			pipe_commit_write(pipe, head);
 			pipe->tmp_page = NULL;
 
 			if (!iov_iter_count(from))
 				break;
 		}
-		if (bufs < pipe->buffers)
+
+		if (head - tail < buffers)
 			continue;
+
+		/* Wait for buffer space to become available. */
 		if (filp->f_flags & O_NONBLOCK) {
 			if (!ret)
 				ret = -EAGAIN;
@@ -515,17 +525,19 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct pipe_inode_info *pipe = filp->private_data;
-	int count, buf, nrbufs;
+	int count, head, tail, mask;
 
 	switch (cmd) {
 		case FIONREAD:
 			__pipe_lock(pipe);
 			count = 0;
-			buf = pipe->curbuf;
-			nrbufs = pipe->nrbufs;
-			while (--nrbufs >= 0) {
-				count += pipe->bufs[buf].len;
-				buf = (buf+1) & (pipe->buffers - 1);
+			head = pipe->head;
+			tail = pipe->tail;
+			mask = pipe->ring_size - 1;
+
+			while (tail < head) {
+				count += pipe->bufs[tail & mask].len;
+				tail++;
 			}
 			__pipe_unlock(pipe);
 
@@ -541,21 +553,26 @@ pipe_poll(struct file *filp, poll_table *wait)
 {
 	__poll_t mask;
 	struct pipe_inode_info *pipe = filp->private_data;
-	int nrbufs;
+	unsigned int head = READ_ONCE(pipe->head);
+	unsigned int tail = READ_ONCE(pipe->tail);
+	unsigned int occupancy = head - tail;
 
 	poll_wait(filp, &pipe->wait, wait);
 
+	BUG_ON(occupancy > pipe->ring_size);
+
 	/* Reading only -- no need for acquiring the semaphore.  */
-	nrbufs = pipe->nrbufs;
 	mask = 0;
 	if (filp->f_mode & FMODE_READ) {
-		mask = (nrbufs > 0) ? EPOLLIN | EPOLLRDNORM : 0;
+		if (occupancy > 0)
+			mask |= EPOLLIN | EPOLLRDNORM;
 		if (!pipe->writers && filp->f_version != pipe->w_counter)
 			mask |= EPOLLHUP;
 	}
 
 	if (filp->f_mode & FMODE_WRITE) {
-		mask |= (nrbufs < pipe->buffers) ? EPOLLOUT | EPOLLWRNORM : 0;
+		if (occupancy < pipe->max_usage)
+			mask |= EPOLLOUT | EPOLLWRNORM;
 		/*
 		 * Most Unices do not set EPOLLERR for FIFOs but on Linux they
 		 * behave exactly like pipes for poll().
@@ -679,7 +696,8 @@ struct pipe_inode_info *alloc_pipe_info(void)
 	if (pipe->bufs) {
 		init_waitqueue_head(&pipe->wait);
 		pipe->r_counter = pipe->w_counter = 1;
-		pipe->buffers = pipe_bufs;
+		pipe->max_usage = pipe_bufs;
+		pipe->ring_size = pipe_bufs;
 		pipe->user = user;
 		mutex_init(&pipe->mutex);
 		return pipe;
@@ -697,9 +715,9 @@ void free_pipe_info(struct pipe_inode_info *pipe)
 {
 	int i;
 
-	(void) account_pipe_buffers(pipe->user, pipe->buffers, 0);
+	(void) account_pipe_buffers(pipe->user, pipe->ring_size, 0);
 	free_uid(pipe->user);
-	for (i = 0; i < pipe->buffers; i++) {
+	for (i = 0; i < pipe->ring_size; i++) {
 		struct pipe_buffer *buf = pipe->bufs + i;
 		if (buf->ops)
 			pipe_buf_release(pipe, buf);
@@ -880,7 +898,7 @@ SYSCALL_DEFINE1(pipe, int __user *, fildes)
 
 static int wait_for_partner(struct pipe_inode_info *pipe, unsigned int *cnt)
 {
-	int cur = *cnt;	
+	int cur = *cnt;
 
 	while (cur == *cnt) {
 		pipe_wait(pipe);
@@ -955,7 +973,7 @@ static int fifo_open(struct inode *inode, struct file *filp)
 			}
 		}
 		break;
-	
+
 	case FMODE_WRITE:
 	/*
 	 *  O_WRONLY
@@ -975,7 +993,7 @@ static int fifo_open(struct inode *inode, struct file *filp)
 				goto err_wr;
 		}
 		break;
-	
+
 	case FMODE_READ | FMODE_WRITE:
 	/*
 	 *  O_RDWR
@@ -1054,14 +1072,14 @@ unsigned int round_pipe_size(unsigned long size)
 static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 {
 	struct pipe_buffer *bufs;
-	unsigned int size, nr_pages;
+	unsigned int size, nr_slots, head, tail, mask, n;
 	unsigned long user_bufs;
 	long ret = 0;
 
 	size = round_pipe_size(arg);
-	nr_pages = size >> PAGE_SHIFT;
+	nr_slots = size >> PAGE_SHIFT;
 
-	if (!nr_pages)
+	if (!nr_slots)
 		return -EINVAL;
 
 	/*
@@ -1071,13 +1089,13 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	 * Decreasing the pipe capacity is always permitted, even
 	 * if the user is currently over a limit.
 	 */
-	if (nr_pages > pipe->buffers &&
+	if (nr_slots > pipe->ring_size &&
 			size > pipe_max_size && !capable(CAP_SYS_RESOURCE))
 		return -EPERM;
 
-	user_bufs = account_pipe_buffers(pipe->user, pipe->buffers, nr_pages);
+	user_bufs = account_pipe_buffers(pipe->user, pipe->ring_size, nr_slots);
 
-	if (nr_pages > pipe->buffers &&
+	if (nr_slots > pipe->ring_size &&
 			(too_many_pipe_buffers_hard(user_bufs) ||
 			 too_many_pipe_buffers_soft(user_bufs)) &&
 			is_unprivileged_user()) {
@@ -1086,17 +1104,21 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	}
 
 	/*
-	 * We can shrink the pipe, if arg >= pipe->nrbufs. Since we don't
-	 * expect a lot of shrink+grow operations, just free and allocate
-	 * again like we would do for growing. If the pipe currently
+	 * We can shrink the pipe, if arg is greater than the ring occupancy.
+	 * Since we don't expect a lot of shrink+grow operations, just free and
+	 * allocate again like we would do for growing.  If the pipe currently
 	 * contains more buffers than arg, then return busy.
 	 */
-	if (nr_pages < pipe->nrbufs) {
+	mask = pipe->ring_size - 1;
+	head = pipe->head & mask;
+	tail = pipe->tail & mask;
+	n = pipe->head - pipe->tail;
+	if (nr_slots < n) {
 		ret = -EBUSY;
 		goto out_revert_acct;
 	}
 
-	bufs = kcalloc(nr_pages, sizeof(*bufs),
+	bufs = kcalloc(nr_slots, sizeof(*bufs),
 		       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (unlikely(!bufs)) {
 		ret = -ENOMEM;
@@ -1105,33 +1127,33 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 
 	/*
 	 * The pipe array wraps around, so just start the new one at zero
-	 * and adjust the indexes.
+	 * and adjust the indices.
 	 */
-	if (pipe->nrbufs) {
-		unsigned int tail;
-		unsigned int head;
-
-		tail = pipe->curbuf + pipe->nrbufs;
-		if (tail < pipe->buffers)
-			tail = 0;
-		else
-			tail &= (pipe->buffers - 1);
-
-		head = pipe->nrbufs - tail;
-		if (head)
-			memcpy(bufs, pipe->bufs + pipe->curbuf, head * sizeof(struct pipe_buffer));
-		if (tail)
-			memcpy(bufs + head, pipe->bufs, tail * sizeof(struct pipe_buffer));
+	if (n > 0) {
+		if (head > tail) {
+			memcpy(bufs, &pipe->bufs[tail], n * sizeof(struct pipe_buffer));
+		} else {
+			unsigned int s = pipe->ring_size - tail;
+			if (n - s > 0)
+				memcpy(bufs + s, &pipe->bufs[0],
+				       (n - s) * sizeof(struct pipe_buffer));
+			memcpy(bufs, &pipe->bufs[tail], s * sizeof(struct pipe_buffer));
+		}
 	}
 
-	pipe->curbuf = 0;
+	head = n;
+	tail = 0;
+
 	kfree(pipe->bufs);
 	pipe->bufs = bufs;
-	pipe->buffers = nr_pages;
-	return nr_pages * PAGE_SIZE;
+	pipe->ring_size = nr_slots;
+	pipe->max_usage = nr_slots;
+	pipe->tail = tail;
+	pipe->head = head;
+	return pipe->max_usage * PAGE_SIZE;
 
 out_revert_acct:
-	(void) account_pipe_buffers(pipe->user, nr_pages, pipe->buffers);
+	(void) account_pipe_buffers(pipe->user, nr_slots, pipe->ring_size);
 	return ret;
 }
 
@@ -1161,7 +1183,7 @@ long pipe_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 		ret = pipe_set_size(pipe, arg);
 		break;
 	case F_GETPIPE_SZ:
-		ret = pipe->buffers * PAGE_SIZE;
+		ret = pipe->max_usage * PAGE_SIZE;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/fs/splice.c b/fs/splice.c
index 98412721f056..7f5f59e2967b 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -185,6 +185,9 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 		       struct splice_pipe_desc *spd)
 {
 	unsigned int spd_pages = spd->nr_pages;
+	unsigned int tail = pipe->tail;
+	unsigned int head = pipe->head;
+	unsigned int mask = pipe->ring_size - 1;
 	int ret = 0, page_nr = 0;
 
 	if (!spd_pages)
@@ -196,9 +199,8 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 		goto out;
 	}
 
-	while (pipe->nrbufs < pipe->buffers) {
-		int newbuf = (pipe->curbuf + pipe->nrbufs) & (pipe->buffers - 1);
-		struct pipe_buffer *buf = pipe->bufs + newbuf;
+	while (head - tail < pipe->max_usage) {
+		struct pipe_buffer *buf = &pipe->bufs[head & mask];
 
 		buf->page = spd->pages[page_nr];
 		buf->offset = spd->partial[page_nr].offset;
@@ -207,7 +209,8 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 		buf->ops = spd->ops;
 		buf->flags = 0;
 
-		pipe->nrbufs++;
+		head++;
+		pipe_commit_write(pipe, head);
 		page_nr++;
 		ret += buf->len;
 
@@ -228,17 +231,19 @@ EXPORT_SYMBOL_GPL(splice_to_pipe);
 
 ssize_t add_to_pipe(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
 {
+	unsigned int head = pipe->head;
+	unsigned int tail = pipe->tail;
+	unsigned int mask = pipe->ring_size - 1;
 	int ret;
 
 	if (unlikely(!pipe->readers)) {
 		send_sig(SIGPIPE, current, 0);
 		ret = -EPIPE;
-	} else if (pipe->nrbufs == pipe->buffers) {
+	} else if (head - tail >= pipe->max_usage) {
 		ret = -EAGAIN;
 	} else {
-		int newbuf = (pipe->curbuf + pipe->nrbufs) & (pipe->buffers - 1);
-		pipe->bufs[newbuf] = *buf;
-		pipe->nrbufs++;
+		pipe->bufs[head & mask] = *buf;
+		pipe_commit_write(pipe, head + 1);
 		return buf->len;
 	}
 	pipe_buf_release(pipe, buf);
@@ -252,14 +257,14 @@ EXPORT_SYMBOL(add_to_pipe);
  */
 int splice_grow_spd(const struct pipe_inode_info *pipe, struct splice_pipe_desc *spd)
 {
-	unsigned int buffers = READ_ONCE(pipe->buffers);
+	unsigned int max_usage = READ_ONCE(pipe->max_usage);
 
-	spd->nr_pages_max = buffers;
-	if (buffers <= PIPE_DEF_BUFFERS)
+	spd->nr_pages_max = max_usage;
+	if (max_usage <= PIPE_DEF_BUFFERS)
 		return 0;
 
-	spd->pages = kmalloc_array(buffers, sizeof(struct page *), GFP_KERNEL);
-	spd->partial = kmalloc_array(buffers, sizeof(struct partial_page),
+	spd->pages = kmalloc_array(max_usage, sizeof(struct page *), GFP_KERNEL);
+	spd->partial = kmalloc_array(max_usage, sizeof(struct partial_page),
 				     GFP_KERNEL);
 
 	if (spd->pages && spd->partial)
@@ -298,10 +303,11 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 {
 	struct iov_iter to;
 	struct kiocb kiocb;
-	int idx, ret;
+	unsigned int i_head;
+	int ret;
 
 	iov_iter_pipe(&to, READ, pipe, len);
-	idx = to.idx;
+	i_head = to.head;
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos = *ppos;
 	ret = call_read_iter(in, &kiocb, &to);
@@ -309,7 +315,7 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 		*ppos = kiocb.ki_pos;
 		file_accessed(in);
 	} else if (ret < 0) {
-		to.idx = idx;
+		to.head = i_head;
 		to.iov_offset = 0;
 		iov_iter_advance(&to, 0); /* to free what was emitted */
 		/*
@@ -370,11 +376,12 @@ static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
 	struct iov_iter to;
 	struct page **pages;
 	unsigned int nr_pages;
+	unsigned int mask;
 	size_t offset, base, copied = 0;
 	ssize_t res;
 	int i;
 
-	if (pipe->nrbufs == pipe->buffers)
+	if (pipe->head - pipe->tail == pipe->max_usage)
 		return -EAGAIN;
 
 	/*
@@ -400,8 +407,9 @@ static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
 		}
 	}
 
-	pipe->bufs[to.idx].offset = offset;
-	pipe->bufs[to.idx].len -= offset;
+	mask = pipe->ring_size - 1;
+	pipe->bufs[to.head & mask].offset = offset;
+	pipe->bufs[to.head & mask].len -= offset;
 
 	for (i = 0; i < nr_pages; i++) {
 		size_t this_len = min_t(size_t, len, PAGE_SIZE - offset);
@@ -443,7 +451,7 @@ static int pipe_to_sendpage(struct pipe_inode_info *pipe,
 
 	more = (sd->flags & SPLICE_F_MORE) ? MSG_MORE : 0;
 
-	if (sd->len < sd->total_len && pipe->nrbufs > 1)
+	if (sd->len < sd->total_len && pipe->head - pipe->tail > 1)
 		more |= MSG_SENDPAGE_NOTLAST;
 
 	return file->f_op->sendpage(file, buf->page, buf->offset,
@@ -481,10 +489,13 @@ static void wakeup_pipe_writers(struct pipe_inode_info *pipe)
 static int splice_from_pipe_feed(struct pipe_inode_info *pipe, struct splice_desc *sd,
 			  splice_actor *actor)
 {
+	unsigned int head = pipe->head;
+	unsigned int tail = pipe->tail;
+	unsigned int mask = pipe->ring_size - 1;
 	int ret;
 
-	while (pipe->nrbufs) {
-		struct pipe_buffer *buf = pipe->bufs + pipe->curbuf;
+	while (tail != head) {
+		struct pipe_buffer *buf = &pipe->bufs[tail & mask];
 
 		sd->len = buf->len;
 		if (sd->len > sd->total_len)
@@ -511,8 +522,8 @@ static int splice_from_pipe_feed(struct pipe_inode_info *pipe, struct splice_des
 
 		if (!buf->len) {
 			pipe_buf_release(pipe, buf);
-			pipe->curbuf = (pipe->curbuf + 1) & (pipe->buffers - 1);
-			pipe->nrbufs--;
+			tail++;
+			pipe_commit_read(pipe, tail);
 			if (pipe->files)
 				sd->need_wakeup = true;
 		}
@@ -543,7 +554,7 @@ static int splice_from_pipe_next(struct pipe_inode_info *pipe, struct splice_des
 	if (signal_pending(current))
 		return -ERESTARTSYS;
 
-	while (!pipe->nrbufs) {
+	while (pipe->tail == pipe->head) {
 		if (!pipe->writers)
 			return 0;
 
@@ -686,7 +697,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		.pos = *ppos,
 		.u.file = out,
 	};
-	int nbufs = pipe->buffers;
+	int nbufs = pipe->max_usage;
 	struct bio_vec *array = kcalloc(nbufs, sizeof(struct bio_vec),
 					GFP_KERNEL);
 	ssize_t ret;
@@ -699,16 +710,19 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	splice_from_pipe_begin(&sd);
 	while (sd.total_len) {
 		struct iov_iter from;
+		unsigned int head = pipe->head;
+		unsigned int tail = pipe->tail;
+		unsigned int mask = pipe->ring_size - 1;
 		size_t left;
-		int n, idx;
+		int n;
 
 		ret = splice_from_pipe_next(pipe, &sd);
 		if (ret <= 0)
 			break;
 
-		if (unlikely(nbufs < pipe->buffers)) {
+		if (unlikely(nbufs < pipe->max_usage)) {
 			kfree(array);
-			nbufs = pipe->buffers;
+			nbufs = pipe->max_usage;
 			array = kcalloc(nbufs, sizeof(struct bio_vec),
 					GFP_KERNEL);
 			if (!array) {
@@ -719,16 +733,13 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 		/* build the vector */
 		left = sd.total_len;
-		for (n = 0, idx = pipe->curbuf; left && n < pipe->nrbufs; n++, idx++) {
-			struct pipe_buffer *buf = pipe->bufs + idx;
+		for (n = 0; head - tail > 0 && left && n < nbufs; tail++, n++) {
+			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
 			size_t this_len = buf->len;
 
 			if (this_len > left)
 				this_len = left;
 
-			if (idx == pipe->buffers - 1)
-				idx = -1;
-
 			ret = pipe_buf_confirm(pipe, buf);
 			if (unlikely(ret)) {
 				if (ret == -ENODATA)
@@ -752,14 +763,15 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		*ppos = sd.pos;
 
 		/* dismiss the fully eaten buffers, adjust the partial one */
+		tail = pipe->tail;
 		while (ret) {
-			struct pipe_buffer *buf = pipe->bufs + pipe->curbuf;
+			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
 			if (ret >= buf->len) {
 				ret -= buf->len;
 				buf->len = 0;
 				pipe_buf_release(pipe, buf);
-				pipe->curbuf = (pipe->curbuf + 1) & (pipe->buffers - 1);
-				pipe->nrbufs--;
+				tail++;
+				pipe_commit_read(pipe, tail);
 				if (pipe->files)
 					sd.need_wakeup = true;
 			} else {
@@ -942,15 +954,17 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 	sd->flags &= ~SPLICE_F_NONBLOCK;
 	more = sd->flags & SPLICE_F_MORE;
 
-	WARN_ON_ONCE(pipe->nrbufs != 0);
+	WARN_ON_ONCE(pipe->head != pipe->tail);
 
 	while (len) {
+		unsigned int p_occupancy, p_space;
 		size_t read_len;
 		loff_t pos = sd->pos, prev_pos = pos;
 
 		/* Don't try to read more the pipe has space for. */
-		read_len = min_t(size_t, len,
-				 (pipe->buffers - pipe->nrbufs) << PAGE_SHIFT);
+		p_occupancy = READ_ONCE(pipe->head) - READ_ONCE(pipe->tail);
+		p_space = pipe->max_usage - p_occupancy;
+		read_len = min_t(size_t, len, p_space << PAGE_SHIFT);
 		ret = do_splice_to(in, &pos, pipe, read_len, flags);
 		if (unlikely(ret <= 0))
 			goto out_release;
@@ -989,7 +1003,7 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 	}
 
 done:
-	pipe->nrbufs = pipe->curbuf = 0;
+	pipe->tail = pipe->head = 0;
 	file_accessed(in);
 	return bytes;
 
@@ -998,8 +1012,8 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 	 * If we did an incomplete transfer we must release
 	 * the pipe buffers in question:
 	 */
-	for (i = 0; i < pipe->buffers; i++) {
-		struct pipe_buffer *buf = pipe->bufs + i;
+	for (i = 0; i < pipe->ring_size; i++) {
+		struct pipe_buffer *buf = &pipe->bufs[i];
 
 		if (buf->ops)
 			pipe_buf_release(pipe, buf);
@@ -1075,7 +1089,7 @@ static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
 			send_sig(SIGPIPE, current, 0);
 			return -EPIPE;
 		}
-		if (pipe->nrbufs != pipe->buffers)
+		if (pipe->head - pipe->tail < pipe->max_usage)
 			return 0;
 		if (flags & SPLICE_F_NONBLOCK)
 			return -EAGAIN;
@@ -1442,16 +1456,16 @@ static int ipipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
 	int ret;
 
 	/*
-	 * Check ->nrbufs without the inode lock first. This function
+	 * Check the pipe occupancy without the inode lock first. This function
 	 * is speculative anyways, so missing one is ok.
 	 */
-	if (pipe->nrbufs)
+	if (pipe->head != pipe->tail)
 		return 0;
 
 	ret = 0;
 	pipe_lock(pipe);
 
-	while (!pipe->nrbufs) {
+	while (pipe->head == pipe->tail) {
 		if (signal_pending(current)) {
 			ret = -ERESTARTSYS;
 			break;
@@ -1483,13 +1497,13 @@ static int opipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
 	 * Check ->nrbufs without the inode lock first. This function
 	 * is speculative anyways, so missing one is ok.
 	 */
-	if (pipe->nrbufs < pipe->buffers)
+	if (pipe->head - pipe->tail >= pipe->max_usage)
 		return 0;
 
 	ret = 0;
 	pipe_lock(pipe);
 
-	while (pipe->nrbufs >= pipe->buffers) {
+	while (pipe->head - pipe->tail >= pipe->max_usage) {
 		if (!pipe->readers) {
 			send_sig(SIGPIPE, current, 0);
 			ret = -EPIPE;
@@ -1520,7 +1534,10 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			       size_t len, unsigned int flags)
 {
 	struct pipe_buffer *ibuf, *obuf;
-	int ret = 0, nbuf;
+	unsigned int i_head, o_head;
+	unsigned int i_tail, o_tail;
+	unsigned int i_mask, o_mask;
+	int ret = 0;
 	bool input_wakeup = false;
 
 
@@ -1540,7 +1557,14 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 	 */
 	pipe_double_lock(ipipe, opipe);
 
+	i_tail = ipipe->tail;
+	i_mask = ipipe->ring_size - 1;
+	o_head = opipe->head;
+	o_mask = opipe->ring_size - 1;
+
 	do {
+		size_t o_len;
+
 		if (!opipe->readers) {
 			send_sig(SIGPIPE, current, 0);
 			if (!ret)
@@ -1548,14 +1572,17 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			break;
 		}
 
-		if (!ipipe->nrbufs && !ipipe->writers)
+		i_head = ipipe->head;
+		o_tail = opipe->tail;
+
+		if (i_head == i_tail && !ipipe->writers)
 			break;
 
 		/*
 		 * Cannot make any progress, because either the input
 		 * pipe is empty or the output pipe is full.
 		 */
-		if (!ipipe->nrbufs || opipe->nrbufs >= opipe->buffers) {
+		if (i_head == i_tail || o_head - o_tail >= opipe->max_usage) {
 			/* Already processed some buffers, break */
 			if (ret)
 				break;
@@ -1575,9 +1602,8 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			goto retry;
 		}
 
-		ibuf = ipipe->bufs + ipipe->curbuf;
-		nbuf = (opipe->curbuf + opipe->nrbufs) & (opipe->buffers - 1);
-		obuf = opipe->bufs + nbuf;
+		ibuf = &ipipe->bufs[i_tail & i_mask];
+		obuf = &opipe->bufs[o_head & o_mask];
 
 		if (len >= ibuf->len) {
 			/*
@@ -1585,10 +1611,12 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			 */
 			*obuf = *ibuf;
 			ibuf->ops = NULL;
-			opipe->nrbufs++;
-			ipipe->curbuf = (ipipe->curbuf + 1) & (ipipe->buffers - 1);
-			ipipe->nrbufs--;
+			i_tail++;
+			pipe_commit_read(ipipe, i_tail);
 			input_wakeup = true;
+			o_len = obuf->len;
+			o_head++;
+			pipe_commit_write(opipe, o_head);
 		} else {
 			/*
 			 * Get a reference to this pipe buffer,
@@ -1610,12 +1638,14 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			pipe_buf_mark_unmergeable(obuf);
 
 			obuf->len = len;
-			opipe->nrbufs++;
-			ibuf->offset += obuf->len;
-			ibuf->len -= obuf->len;
+			ibuf->offset += len;
+			ibuf->len -= len;
+			o_len = len;
+			o_head++;
+			pipe_commit_write(opipe, o_head);
 		}
-		ret += obuf->len;
-		len -= obuf->len;
+		ret += o_len;
+		len -= o_len;
 	} while (len);
 
 	pipe_unlock(ipipe);
@@ -1641,7 +1671,10 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 		     size_t len, unsigned int flags)
 {
 	struct pipe_buffer *ibuf, *obuf;
-	int ret = 0, i = 0, nbuf;
+	unsigned int i_head, o_head;
+	unsigned int i_tail, o_tail;
+	unsigned int i_mask, o_mask;
+	int ret = 0, i = 0;
 
 	/*
 	 * Potential ABBA deadlock, work around it by ordering lock
@@ -1650,6 +1683,11 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 	 */
 	pipe_double_lock(ipipe, opipe);
 
+	i_tail = ipipe->tail;
+	i_mask = ipipe->ring_size - 1;
+	o_head = opipe->head;
+	o_mask = opipe->ring_size - 1;
+
 	do {
 		if (!opipe->readers) {
 			send_sig(SIGPIPE, current, 0);
@@ -1658,15 +1696,18 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 			break;
 		}
 
+		i_head = ipipe->head;
+		o_tail = opipe->tail;
+
 		/*
-		 * If we have iterated all input buffers or ran out of
+		 * If we have iterated all input buffers or run out of
 		 * output room, break.
 		 */
-		if (i >= ipipe->nrbufs || opipe->nrbufs >= opipe->buffers)
+		if (i_head != i_tail || o_head - o_tail >= opipe->max_usage)
 			break;
 
-		ibuf = ipipe->bufs + ((ipipe->curbuf + i) & (ipipe->buffers-1));
-		nbuf = (opipe->curbuf + opipe->nrbufs) & (opipe->buffers - 1);
+		ibuf = &ipipe->bufs[i_tail & i_mask];
+		obuf = &opipe->bufs[o_head & o_mask];
 
 		/*
 		 * Get a reference to this pipe buffer,
@@ -1678,7 +1719,6 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 			break;
 		}
 
-		obuf = opipe->bufs + nbuf;
 		*obuf = *ibuf;
 
 		/*
@@ -1691,10 +1731,11 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 
 		if (obuf->len > len)
 			obuf->len = len;
-
-		opipe->nrbufs++;
 		ret += obuf->len;
 		len -= obuf->len;
+
+		o_head++;
+		pipe_commit_write(opipe, o_head);
 		i++;
 	} while (len);
 
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 5c626fdc10db..ec82c5374410 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -30,9 +30,10 @@ struct pipe_buffer {
  *	struct pipe_inode_info - a linux kernel pipe
  *	@mutex: mutex protecting the whole thing
  *	@wait: reader/writer wait point in case of empty/full pipe
- *	@nrbufs: the number of non-empty pipe buffers in this pipe
- *	@buffers: total number of buffers (should be a power of 2)
- *	@curbuf: the current pipe buffer entry
+ *	@head: The point of buffer production
+ *	@tail: The point of buffer consumption
+ *	@max_usage: The maximum number of slots that may be used in the ring
+ *	@ring_size: total number of buffers (should be a power of 2)
  *	@tmp_page: cached released page
  *	@readers: number of current readers of this pipe
  *	@writers: number of current writers of this pipe
@@ -48,7 +49,10 @@ struct pipe_buffer {
 struct pipe_inode_info {
 	struct mutex mutex;
 	wait_queue_head_t wait;
-	unsigned int nrbufs, curbuf, buffers;
+	unsigned int head;
+	unsigned int tail;
+	unsigned int max_usage;
+	unsigned int ring_size;
 	unsigned int readers;
 	unsigned int writers;
 	unsigned int files;
@@ -104,6 +108,32 @@ struct pipe_buf_operations {
 	bool (*get)(struct pipe_inode_info *, struct pipe_buffer *);
 };
 
+/**
+ * pipe_commit_read - Set pipe buffer tail pointer in the read-side
+ * @pipe: The pipe in question
+ * @tail: The new tail pointer
+ *
+ * Update the tail pointer in the read-side code after a read has taken place.
+ */
+static inline void pipe_commit_read(struct pipe_inode_info *pipe,
+				    unsigned int tail)
+{
+	pipe->tail = tail;
+}
+
+/**
+ * pipe_commit_write - Set pipe buffer head pointer in the write-side
+ * @pipe: The pipe in question
+ * @head: The new head pointer
+ *
+ * Update the head pointer in the write-side code after a write has taken place.
+ */
+static inline void pipe_commit_write(struct pipe_inode_info *pipe,
+				     unsigned int head)
+{
+	pipe->head = head;
+}
+
 /**
  * pipe_buf_get - get a reference to a pipe_buffer
  * @pipe:	the pipe that the buffer belongs to
diff --git a/include/linux/uio.h b/include/linux/uio.h
index ab5f523bc0df..9576fd8158d7 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -45,8 +45,8 @@ struct iov_iter {
 	union {
 		unsigned long nr_segs;
 		struct {
-			int idx;
-			int start_idx;
+			unsigned int head;
+			unsigned int start_head;
 		};
 	};
 };
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 639d5e7014c1..c8a046c87e3f 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -325,28 +325,33 @@ static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t
 static bool sanity(const struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-	int idx = i->idx;
-	int next = pipe->curbuf + pipe->nrbufs;
+	unsigned int p_head = pipe->head;
+	unsigned int p_tail = pipe->tail;
+	unsigned int p_mask = pipe->ring_size - 1;
+	unsigned int p_occupancy = p_head - p_tail;
+	unsigned int i_head = i->head;
+	unsigned int idx;
+
 	if (i->iov_offset) {
 		struct pipe_buffer *p;
-		if (unlikely(!pipe->nrbufs))
+		if (unlikely(p_occupancy == 0))
 			goto Bad;	// pipe must be non-empty
-		if (unlikely(idx != ((next - 1) & (pipe->buffers - 1))))
+		if (unlikely(i_head != p_head - 1))
 			goto Bad;	// must be at the last buffer...
 
-		p = &pipe->bufs[idx];
+		p = &pipe->bufs[i_head & p_mask];
 		if (unlikely(p->offset + p->len != i->iov_offset))
 			goto Bad;	// ... at the end of segment
 	} else {
-		if (idx != (next & (pipe->buffers - 1)))
+		if (i_head != p_head)
 			goto Bad;	// must be right after the last buffer
 	}
 	return true;
 Bad:
-	printk(KERN_ERR "idx = %d, offset = %zd\n", i->idx, i->iov_offset);
-	printk(KERN_ERR "curbuf = %d, nrbufs = %d, buffers = %d\n",
-			pipe->curbuf, pipe->nrbufs, pipe->buffers);
-	for (idx = 0; idx < pipe->buffers; idx++)
+	printk(KERN_ERR "idx = %d, offset = %zd\n", i_head, i->iov_offset);
+	printk(KERN_ERR "head = %d, tail = %d, buffers = %d\n",
+			p_head, p_tail, pipe->ring_size);
+	for (idx = 0; idx < pipe->ring_size; idx++)
 		printk(KERN_ERR "[%p %p %d %d]\n",
 			pipe->bufs[idx].ops,
 			pipe->bufs[idx].page,
@@ -359,18 +364,15 @@ static bool sanity(const struct iov_iter *i)
 #define sanity(i) true
 #endif
 
-static inline int next_idx(int idx, struct pipe_inode_info *pipe)
-{
-	return (idx + 1) & (pipe->buffers - 1);
-}
-
 static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
 	struct pipe_buffer *buf;
+	unsigned int p_tail = pipe->tail;
+	unsigned int p_mask = pipe->ring_size - 1;
+	unsigned int i_head = i->head;
 	size_t off;
-	int idx;
 
 	if (unlikely(bytes > i->count))
 		bytes = i->count;
@@ -382,8 +384,7 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
 		return 0;
 
 	off = i->iov_offset;
-	idx = i->idx;
-	buf = &pipe->bufs[idx];
+	buf = &pipe->bufs[i_head & p_mask];
 	if (off) {
 		if (offset == off && buf->page == page) {
 			/* merge with the last one */
@@ -391,18 +392,21 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
 			i->iov_offset += bytes;
 			goto out;
 		}
-		idx = next_idx(idx, pipe);
-		buf = &pipe->bufs[idx];
+		i_head++;
+		buf = &pipe->bufs[i_head & p_mask];
 	}
-	if (idx == pipe->curbuf && pipe->nrbufs)
+	if (i_head - p_tail >= pipe->max_usage)
 		return 0;
-	pipe->nrbufs++;
+
 	buf->ops = &page_cache_pipe_buf_ops;
-	get_page(buf->page = page);
+	get_page(page);
+	buf->page = page;
 	buf->offset = offset;
 	buf->len = bytes;
+
+	pipe_commit_read(pipe, i_head);
 	i->iov_offset = offset + bytes;
-	i->idx = idx;
+	i->head = i_head;
 out:
 	i->count -= bytes;
 	return bytes;
@@ -480,24 +484,30 @@ static inline bool allocated(struct pipe_buffer *buf)
 	return buf->ops == &default_pipe_buf_ops;
 }
 
-static inline void data_start(const struct iov_iter *i, int *idxp, size_t *offp)
+static inline void data_start(const struct iov_iter *i, unsigned int *i_headp,
+			      size_t *offp)
 {
+	unsigned int p_mask = i->pipe->ring_size - 1;
+	unsigned int i_head = i->head;
 	size_t off = i->iov_offset;
-	int idx = i->idx;
-	if (off && (!allocated(&i->pipe->bufs[idx]) || off == PAGE_SIZE)) {
-		idx = next_idx(idx, i->pipe);
+
+	if (off && (!allocated(&i->pipe->bufs[i_head & p_mask]) ||
+		    off == PAGE_SIZE)) {
+		i_head++;
 		off = 0;
 	}
-	*idxp = idx;
+	*i_headp = i_head;
 	*offp = off;
 }
 
 static size_t push_pipe(struct iov_iter *i, size_t size,
-			int *idxp, size_t *offp)
+			int *i_headp, size_t *offp)
 {
 	struct pipe_inode_info *pipe = i->pipe;
+	unsigned int p_tail = pipe->tail;
+	unsigned int p_mask = pipe->ring_size - 1;
+	unsigned int i_head;
 	size_t off;
-	int idx;
 	ssize_t left;
 
 	if (unlikely(size > i->count))
@@ -506,33 +516,34 @@ static size_t push_pipe(struct iov_iter *i, size_t size,
 		return 0;
 
 	left = size;
-	data_start(i, &idx, &off);
-	*idxp = idx;
+	data_start(i, &i_head, &off);
+	*i_headp = i_head;
 	*offp = off;
 	if (off) {
 		left -= PAGE_SIZE - off;
 		if (left <= 0) {
-			pipe->bufs[idx].len += size;
+			pipe->bufs[i_head & p_mask].len += size;
 			return size;
 		}
-		pipe->bufs[idx].len = PAGE_SIZE;
-		idx = next_idx(idx, pipe);
+		pipe->bufs[i_head & p_mask].len = PAGE_SIZE;
+		i_head++;
 	}
-	while (idx != pipe->curbuf || !pipe->nrbufs) {
+	while (i_head <= p_tail + pipe->max_usage) {
+		struct pipe_buffer *buf = &pipe->bufs[i_head & p_mask];
 		struct page *page = alloc_page(GFP_USER);
 		if (!page)
 			break;
-		pipe->nrbufs++;
-		pipe->bufs[idx].ops = &default_pipe_buf_ops;
-		pipe->bufs[idx].page = page;
-		pipe->bufs[idx].offset = 0;
-		if (left <= PAGE_SIZE) {
-			pipe->bufs[idx].len = left;
+
+		buf->ops = &default_pipe_buf_ops;
+		buf->page = page;
+		buf->offset = 0;
+		buf->len = max_t(ssize_t, left, PAGE_SIZE);
+		left -= buf->len;
+		i_head++;
+		pipe_commit_write(pipe, i_head);
+
+		if (left == 0)
 			return size;
-		}
-		pipe->bufs[idx].len = PAGE_SIZE;
-		left -= PAGE_SIZE;
-		idx = next_idx(idx, pipe);
 	}
 	return size - left;
 }
@@ -541,23 +552,26 @@ static size_t copy_pipe_to_iter(const void *addr, size_t bytes,
 				struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
+	unsigned int p_mask = pipe->ring_size - 1;
+	unsigned int i_head;
 	size_t n, off;
-	int idx;
 
 	if (!sanity(i))
 		return 0;
 
-	bytes = n = push_pipe(i, bytes, &idx, &off);
+	bytes = n = push_pipe(i, bytes, &i_head, &off);
 	if (unlikely(!n))
 		return 0;
-	for ( ; n; idx = next_idx(idx, pipe), off = 0) {
+	do {
 		size_t chunk = min_t(size_t, n, PAGE_SIZE - off);
-		memcpy_to_page(pipe->bufs[idx].page, off, addr, chunk);
-		i->idx = idx;
+		memcpy_to_page(pipe->bufs[i_head & p_mask].page, off, addr, chunk);
+		i->head = i_head;
 		i->iov_offset = off + chunk;
 		n -= chunk;
 		addr += chunk;
-	}
+		off = 0;
+		i_head++;
+	} while (n);
 	i->count -= bytes;
 	return bytes;
 }
@@ -573,28 +587,31 @@ static size_t csum_and_copy_to_pipe_iter(const void *addr, size_t bytes,
 				__wsum *csum, struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
+	unsigned int p_mask = pipe->ring_size - 1;
+	unsigned int i_head;
 	size_t n, r;
 	size_t off = 0;
 	__wsum sum = *csum;
-	int idx;
 
 	if (!sanity(i))
 		return 0;
 
-	bytes = n = push_pipe(i, bytes, &idx, &r);
+	bytes = n = push_pipe(i, bytes, &i_head, &r);
 	if (unlikely(!n))
 		return 0;
-	for ( ; n; idx = next_idx(idx, pipe), r = 0) {
+	do {
 		size_t chunk = min_t(size_t, n, PAGE_SIZE - r);
-		char *p = kmap_atomic(pipe->bufs[idx].page);
+		char *p = kmap_atomic(pipe->bufs[i_head & p_mask].page);
 		sum = csum_and_memcpy(p + r, addr, chunk, sum, off);
 		kunmap_atomic(p);
-		i->idx = idx;
+		i->head = i_head;
 		i->iov_offset = r + chunk;
 		n -= chunk;
 		off += chunk;
 		addr += chunk;
-	}
+		r = 0;
+		i_head++;
+	} while (n);
 	i->count -= bytes;
 	*csum = sum;
 	return bytes;
@@ -645,29 +662,32 @@ static size_t copy_pipe_to_iter_mcsafe(const void *addr, size_t bytes,
 				struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
+	unsigned int p_mask = pipe->ring_size - 1;
+	unsigned int i_head;
 	size_t n, off, xfer = 0;
-	int idx;
 
 	if (!sanity(i))
 		return 0;
 
-	bytes = n = push_pipe(i, bytes, &idx, &off);
+	bytes = n = push_pipe(i, bytes, &i_head, &off);
 	if (unlikely(!n))
 		return 0;
-	for ( ; n; idx = next_idx(idx, pipe), off = 0) {
+	do {
 		size_t chunk = min_t(size_t, n, PAGE_SIZE - off);
 		unsigned long rem;
 
-		rem = memcpy_mcsafe_to_page(pipe->bufs[idx].page, off, addr,
-				chunk);
-		i->idx = idx;
+		rem = memcpy_mcsafe_to_page(pipe->bufs[i_head & p_mask].page,
+					    off, addr, chunk);
+		i->head = i_head;
 		i->iov_offset = off + chunk - rem;
 		xfer += chunk - rem;
 		if (rem)
 			break;
 		n -= chunk;
 		addr += chunk;
-	}
+		off = 0;
+		i_head++;
+	} while (n);
 	i->count -= xfer;
 	return xfer;
 }
@@ -925,6 +945,8 @@ EXPORT_SYMBOL(copy_page_from_iter);
 static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
+	unsigned int p_mask = pipe->ring_size - 1;
+	unsigned int i_head;
 	size_t n, off;
 	int idx;
 
@@ -935,13 +957,15 @@ static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 	if (unlikely(!n))
 		return 0;
 
-	for ( ; n; idx = next_idx(idx, pipe), off = 0) {
+	do {
 		size_t chunk = min_t(size_t, n, PAGE_SIZE - off);
-		memzero_page(pipe->bufs[idx].page, off, chunk);
-		i->idx = idx;
+		memzero_page(pipe->bufs[i_head & p_mask].page, off, chunk);
+		i->head = i_head;
 		i->iov_offset = off + chunk;
 		n -= chunk;
-	}
+		off = 0;
+		i_head++;
+	} while (n);
 	i->count -= bytes;
 	return bytes;
 }
@@ -987,20 +1011,26 @@ EXPORT_SYMBOL(iov_iter_copy_from_user_atomic);
 static inline void pipe_truncate(struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-	if (pipe->nrbufs) {
+	unsigned int p_tail = pipe->tail;
+	unsigned int p_head = pipe->head;
+	unsigned int p_mask = pipe->ring_size - 1;
+
+	if (p_head != p_tail) {
+		struct pipe_buffer *buf;
+		unsigned int i_head = i->head;
 		size_t off = i->iov_offset;
-		int idx = i->idx;
-		int nrbufs = (idx - pipe->curbuf) & (pipe->buffers - 1);
+
 		if (off) {
-			pipe->bufs[idx].len = off - pipe->bufs[idx].offset;
-			idx = next_idx(idx, pipe);
-			nrbufs++;
+			buf = &pipe->bufs[i_head & p_mask];
+			buf->len = off - buf->offset;
+			i_head++;
 		}
-		while (pipe->nrbufs > nrbufs) {
-			pipe_buf_release(pipe, &pipe->bufs[idx]);
-			idx = next_idx(idx, pipe);
-			pipe->nrbufs--;
+		while (p_head != i_head) {
+			p_head--;
+			pipe_buf_release(pipe, &pipe->bufs[p_head & p_mask]);
 		}
+
+		pipe_commit_write(pipe, p_head);
 	}
 }
 
@@ -1011,18 +1041,20 @@ static void pipe_advance(struct iov_iter *i, size_t size)
 		size = i->count;
 	if (size) {
 		struct pipe_buffer *buf;
+		unsigned int p_mask = pipe->ring_size - 1;
+		unsigned int i_head = i->head;
 		size_t off = i->iov_offset, left = size;
-		int idx = i->idx;
+
 		if (off) /* make it relative to the beginning of buffer */
-			left += off - pipe->bufs[idx].offset;
+			left += off - pipe->bufs[i_head & p_mask].offset;
 		while (1) {
-			buf = &pipe->bufs[idx];
+			buf = &pipe->bufs[i_head & p_mask];
 			if (left <= buf->len)
 				break;
 			left -= buf->len;
-			idx = next_idx(idx, pipe);
+			i_head++;
 		}
-		i->idx = idx;
+		i->head = i_head;
 		i->iov_offset = buf->offset + left;
 	}
 	i->count -= size;
@@ -1053,25 +1085,27 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 	i->count += unroll;
 	if (unlikely(iov_iter_is_pipe(i))) {
 		struct pipe_inode_info *pipe = i->pipe;
-		int idx = i->idx;
+		unsigned int p_mask = pipe->ring_size - 1;
+		unsigned int i_head = i->head;
 		size_t off = i->iov_offset;
 		while (1) {
-			size_t n = off - pipe->bufs[idx].offset;
+			struct pipe_buffer *b = &pipe->bufs[i_head & p_mask];
+			size_t n = off - b->offset;
 			if (unroll < n) {
 				off -= unroll;
 				break;
 			}
 			unroll -= n;
-			if (!unroll && idx == i->start_idx) {
+			if (!unroll && i_head == i->start_head) {
 				off = 0;
 				break;
 			}
-			if (!idx--)
-				idx = pipe->buffers - 1;
-			off = pipe->bufs[idx].offset + pipe->bufs[idx].len;
+			i_head--;
+			b = &pipe->bufs[i_head & p_mask];
+			off = b->offset + b->len;
 		}
 		i->iov_offset = off;
-		i->idx = idx;
+		i->head = i_head;
 		pipe_truncate(i);
 		return;
 	}
@@ -1159,13 +1193,13 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
 			size_t count)
 {
 	BUG_ON(direction != READ);
-	WARN_ON(pipe->nrbufs == pipe->buffers);
+	WARN_ON(pipe->head - pipe->tail >= pipe->ring_size);
 	i->type = ITER_PIPE | READ;
 	i->pipe = pipe;
-	i->idx = (pipe->curbuf + pipe->nrbufs) & (pipe->buffers - 1);
+	i->head = pipe->head;
 	i->iov_offset = 0;
 	i->count = count;
-	i->start_idx = i->idx;
+	i->start_head = i->head;
 }
 EXPORT_SYMBOL(iov_iter_pipe);
 
@@ -1189,11 +1223,12 @@ EXPORT_SYMBOL(iov_iter_discard);
 
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
+	unsigned int p_mask = i->pipe->ring_size - 1;
 	unsigned long res = 0;
 	size_t size = i->count;
 
 	if (unlikely(iov_iter_is_pipe(i))) {
-		if (size && i->iov_offset && allocated(&i->pipe->bufs[i->idx]))
+		if (size && i->iov_offset && allocated(&i->pipe->bufs[i->head & p_mask]))
 			return size | i->iov_offset;
 		return size;
 	}
@@ -1231,19 +1266,20 @@ EXPORT_SYMBOL(iov_iter_gap_alignment);
 static inline ssize_t __pipe_get_pages(struct iov_iter *i,
 				size_t maxsize,
 				struct page **pages,
-				int idx,
+				int i_head,
 				size_t *start)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-	ssize_t n = push_pipe(i, maxsize, &idx, start);
+	unsigned int p_mask = pipe->ring_size - 1;
+	ssize_t n = push_pipe(i, maxsize, &i_head, start);
 	if (!n)
 		return -EFAULT;
 
 	maxsize = n;
 	n += *start;
 	while (n > 0) {
-		get_page(*pages++ = pipe->bufs[idx].page);
-		idx = next_idx(idx, pipe);
+		get_page(*pages++ = pipe->bufs[i_head & p_mask].page);
+		i_head++;
 		n -= PAGE_SIZE;
 	}
 
@@ -1254,9 +1290,10 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
 {
+	unsigned int p_tail;
+	unsigned int i_head;
 	unsigned npages;
 	size_t capacity;
-	int idx;
 
 	if (!maxsize)
 		return 0;
@@ -1264,12 +1301,15 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	if (!sanity(i))
 		return -EFAULT;
 
-	data_start(i, &idx, start);
-	/* some of this one + all after this one */
-	npages = ((i->pipe->curbuf - idx - 1) & (i->pipe->buffers - 1)) + 1;
-	capacity = min(npages,maxpages) * PAGE_SIZE - *start;
+	data_start(i, &i_head, start);
+	p_tail = i->pipe->tail;
+	/* Amount of free space: some of this one + all after this one */
+	npages = (p_tail + i->pipe->ring_size) - i_head;
+	if (npages > i->pipe->max_usage)
+		npages = i->pipe->max_usage;
+	capacity = min(npages, maxpages) * PAGE_SIZE - *start;
 
-	return __pipe_get_pages(i, min(maxsize, capacity), pages, idx, start);
+	return __pipe_get_pages(i, min(maxsize, capacity), pages, i_head, start);
 }
 
 ssize_t iov_iter_get_pages(struct iov_iter *i,
@@ -1323,8 +1363,9 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 		   size_t *start)
 {
 	struct page **p;
+	unsigned int p_tail;
+	unsigned int i_head;
 	ssize_t n;
-	int idx;
 	int npages;
 
 	if (!maxsize)
@@ -1333,9 +1374,11 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 	if (!sanity(i))
 		return -EFAULT;
 
-	data_start(i, &idx, start);
-	/* some of this one + all after this one */
-	npages = ((i->pipe->curbuf - idx - 1) & (i->pipe->buffers - 1)) + 1;
+	data_start(i, &i_head, start);
+	/* Amount of free space: some of this one + all after this one */
+	npages = (p_tail + i->pipe->ring_size) - i_head;
+	if (npages > i->pipe->max_usage)
+		npages = i->pipe->max_usage;
 	n = npages * PAGE_SIZE - *start;
 	if (maxsize > n)
 		maxsize = n;
@@ -1344,7 +1387,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 	p = get_pages_array(npages);
 	if (!p)
 		return -ENOMEM;
-	n = __pipe_get_pages(i, maxsize, p, idx, start);
+	n = __pipe_get_pages(i, maxsize, p, i_head, start);
 	if (n > 0)
 		*pages = p;
 	else
@@ -1560,15 +1603,18 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 
 	if (unlikely(iov_iter_is_pipe(i))) {
 		struct pipe_inode_info *pipe = i->pipe;
+		unsigned int p_tail = pipe->tail;
+		unsigned int i_head;
 		size_t off;
-		int idx;
 
 		if (!sanity(i))
 			return 0;
 
-		data_start(i, &idx, &off);
+		data_start(i, &i_head, &off);
 		/* some of this one + all after this one */
-		npages = ((pipe->curbuf - idx - 1) & (pipe->buffers - 1)) + 1;
+		npages = (p_tail + pipe->ring_size) - i_head;
+		if (npages > i->pipe->max_usage)
+			npages = i->pipe->max_usage;
 		if (npages >= maxpages)
 			return maxpages;
 	} else iterate_all_kinds(i, size, v, ({

