Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD2CB1E10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 15:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfIMNAp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 09:00:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729766AbfIMNAo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:00:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2978D3084025;
        Fri, 13 Sep 2019 13:00:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6CEF1001944;
        Fri, 13 Sep 2019 13:00:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linuxfoundation.org
cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH] pipe: Convert ring to head/tail
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25288.1568379639.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 13 Sep 2019 14:00:39 +0100
Message-ID: <25289.1568379639@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 13 Sep 2019 13:00:44 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's my first patch to the pipe ring, with an eye to piggybacking
notifications on it.  Other than whatever booting does, I haven't managed to
explicitly test splice and iov_iter-to-pipe yet.  Other than that, lmbench
seems to show about a 1% improvement on pipe performance and my own
just-shovel-data-through-for-X-amount-of-time test shows about .5%
improvement.  The difference in seeming improvements is possibly because my
test is using 511-byte writes and lmbench is using 512-byte writes.

David
---
pipe: Use head and tail pointers for the ring, not cursor and length

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

 (4) The ring is empty if head == tail.

 (5) The occupancy of the ring is head - tail.

 (6) The amount of space in the ring is (tail + pipe->buffers) - head.

 (7) The ring is full if head == (tail + pipe->buffers) or
     head - tail == pipe->buffers.

Barriers are also inserted, wrapped in inline functions:

 (1) unsigned int tail = pipe_get_tail_for_write(pipe);

     Read the tail pointer from the write-side.  This acts as a barrier to
     order the tail read before the data in the ring is overwritten.  It
     also prevents the compiler from re-reading the pointer.

 (2) unsigned int head = pipe_get_head_for_read(pipe);

     Read the head pointer from the read-side.  This acts as a barrier to
     order the head read before the data read.  It also prevents the
     compiler from re-reading the pointer.

 (3) pipe_post_read_barrier(pipe, unsigned int tail);

     Update the tail pointer from the read-side.  This acts as a barrier to
     order the pointer update after the data read.  The consumed data slot
     must not be touched after this function.

 (4) pipe_post_write_barrier(pipe, unsigned int head);

     Update the head pointer from the write-side.  This acts as a barrier
     to order the pointer update after the data write.  The produced data
     slot should not normally be touched after this function[*].

     [*] Unless pipe->mutex is held.
---
 fs/fuse/dev.c             |   23 ++-
 fs/pipe.c                 |  154 ++++++++++++++++----------
 fs/splice.c               |  161 +++++++++++++++++----------
 include/linux/pipe_fs_i.h |   76 ++++++++++++-
 include/linux/uio.h       |    4 
 lib/iov_iter.c            |  268 ++++++++++++++++++++++++++--------------------
 6 files changed, 438 insertions(+), 248 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ea8237513dfa..c857675e054e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1466,7 +1466,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 	if (ret < 0)
 		goto out;
 
-	if (pipe->nrbufs + cs.nr_segs > pipe->buffers) {
+	if (pipe->head - pipe->tail + cs.nr_segs > pipe->buffers) {
 		ret = -EIO;
 		goto out;
 	}
@@ -2029,6 +2029,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 				     struct file *out, loff_t *ppos,
 				     size_t len, unsigned int flags)
 {
+	unsigned int head, tail, mask, count;
 	unsigned nbuf;
 	unsigned idx;
 	struct pipe_buffer *bufs;
@@ -2043,8 +2044,12 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 
 	pipe_lock(pipe);
 
-	bufs = kvmalloc_array(pipe->nrbufs, sizeof(struct pipe_buffer),
-			      GFP_KERNEL);
+	head = pipe_get_head_for_read(pipe);
+	tail = pipe->tail;
+	mask = pipe->buffers - 1;
+	count = head - tail;
+
+	bufs = kvmalloc_array(count, sizeof(struct pipe_buffer), GFP_KERNEL);
 	if (!bufs) {
 		pipe_unlock(pipe);
 		return -ENOMEM;
@@ -2052,8 +2057,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 
 	nbuf = 0;
 	rem = 0;
-	for (idx = 0; idx < pipe->nrbufs && rem < len; idx++)
-		rem += pipe->bufs[(pipe->curbuf + idx) & (pipe->buffers - 1)].len;
+	for (idx = tail; idx < head && rem < len; idx++)
+		rem += pipe->bufs[idx & mask].len;
 
 	ret = -EINVAL;
 	if (rem < len)
@@ -2065,15 +2070,15 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 		struct pipe_buffer *obuf;
 
 		BUG_ON(nbuf >= pipe->buffers);
-		BUG_ON(!pipe->nrbufs);
-		ibuf = &pipe->bufs[pipe->curbuf];
+		BUG_ON(tail == head);
+		ibuf = &pipe->bufs[tail];
 		obuf = &bufs[nbuf];
 
 		if (rem >= ibuf->len) {
 			*obuf = *ibuf;
 			ibuf->ops = NULL;
-			pipe->curbuf = (pipe->curbuf + 1) & (pipe->buffers - 1);
-			pipe->nrbufs--;
+			tail++;
+			pipe_post_read_barrier(pipe, tail);
 		} else {
 			if (!pipe_buf_get(pipe, ibuf))
 				goto out_free;
diff --git a/fs/pipe.c b/fs/pipe.c
index 8a2ab2f974bd..aa410ee0f423 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -43,10 +43,10 @@ unsigned long pipe_user_pages_hard;
 unsigned long pipe_user_pages_soft = PIPE_DEF_BUFFERS * INR_OPEN_CUR;
 
 /*
- * We use a start+len construction, which provides full use of the 
+ * We use a start+len construction, which provides full use of the
  * allocated memory.
  * -- Florian Coosmann (FGC)
- * 
+ *
  * Reads with count = 0 should always return 0.
  * -- Julian Bradfield 1999-06-07.
  *
@@ -285,10 +285,15 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	ret = 0;
 	__pipe_lock(pipe);
 	for (;;) {
-		int bufs = pipe->nrbufs;
-		if (bufs) {
-			int curbuf = pipe->curbuf;
-			struct pipe_buffer *buf = pipe->bufs + curbuf;
+		/* Barrier: head belongs to the write side, so order reading
+		 * the data after reading the head pointer.
+		 */
+		unsigned int head = READ_ONCE(pipe->head);
+		unsigned int tail = pipe->tail;
+		unsigned int mask = pipe->buffers - 1;
+
+		if (tail != head) {
+			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
 			size_t chars = buf->len;
 			size_t written;
 			int error;
@@ -321,17 +326,21 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 
 			if (!buf->len) {
 				pipe_buf_release(pipe, buf);
-				curbuf = (curbuf + 1) & (pipe->buffers - 1);
-				pipe->curbuf = curbuf;
-				pipe->nrbufs = --bufs;
+				tail++;
+				/* Barrier: order the reading of the data
+				 * before the update to the tail pointer as buf
+				 * thereafter belongs to the write side.
+				 */
+				smp_store_release(&pipe->tail, tail);
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
@@ -380,6 +389,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
+	unsigned int head, tail, buffers, mask;
 	ssize_t ret = 0;
 	int do_wakeup = 0;
 	size_t total_len = iov_iter_count(from);
@@ -397,12 +407,18 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
+	/* Barrier: tail belongs to the reader side, order access to the buffer
+	 * after reading the tail pointer.
+	 */
+	tail = READ_ONCE(pipe->tail);
+	head = pipe->head;
+	buffers = pipe->buffers;
+	mask = buffers - 1;
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
@@ -423,18 +439,19 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
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
+		/* Barrier: tail belongs to the reader side, order access to
+		 * the buffer after reading the tail pointer.
+		 */
+		tail = READ_ONCE(pipe->tail);
+		if ((int)head - (int)tail < buffers ) {
+			struct pipe_buffer *buf = &pipe->bufs[head & mask];
 			struct page *page = pipe->tmp_page;
 			int copied;
 
@@ -470,14 +487,20 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				buf->ops = &packet_pipe_buf_ops;
 				buf->flags = PIPE_BUF_FLAG_PACKET;
 			}
-			pipe->nrbufs = ++bufs;
+
+			/* Barrier: order head update after data write. */
+			head++;
+			smp_store_release(&pipe->head, head);
 			pipe->tmp_page = NULL;
 
 			if (!iov_iter_count(from))
 				break;
 		}
-		if (bufs < pipe->buffers)
+
+		if ((int)head - (int)tail < buffers)
 			continue;
+
+		/* Wait for buffer space to become available. */
 		if (filp->f_flags & O_NONBLOCK) {
 			if (!ret)
 				ret = -EAGAIN;
@@ -515,17 +538,22 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
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
+			/* Barrier: head belongs to the write side, so order
+			 * reading the data after reading the head pointer.
+			 */
+			head = READ_ONCE(pipe->head);
+			tail = pipe->tail;
+			mask = pipe->buffers - 1;
+
+			while (tail < head) {
+				count += pipe->bufs[tail & mask].len;
+				tail++;
 			}
 			__pipe_unlock(pipe);
 
@@ -541,21 +569,26 @@ pipe_poll(struct file *filp, poll_table *wait)
 {
 	__poll_t mask;
 	struct pipe_inode_info *pipe = filp->private_data;
-	int nrbufs;
+	unsigned int head = READ_ONCE(pipe->head);
+	unsigned int tail = READ_ONCE(pipe->tail);
+	int occupancy = (int)head - (int)tail;
 
 	poll_wait(filp, &pipe->wait, wait);
 
+	BUG_ON(occupancy > pipe->buffers);
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
+		if (occupancy < pipe->buffers)
+			mask |= EPOLLOUT | EPOLLWRNORM;
 		/*
 		 * Most Unices do not set EPOLLERR for FIFOs but on Linux they
 		 * behave exactly like pipes for poll().
@@ -880,7 +913,7 @@ SYSCALL_DEFINE1(pipe, int __user *, fildes)
 
 static int wait_for_partner(struct pipe_inode_info *pipe, unsigned int *cnt)
 {
-	int cur = *cnt;	
+	int cur = *cnt;
 
 	while (cur == *cnt) {
 		pipe_wait(pipe);
@@ -955,7 +988,7 @@ static int fifo_open(struct inode *inode, struct file *filp)
 			}
 		}
 		break;
-	
+
 	case FMODE_WRITE:
 	/*
 	 *  O_WRONLY
@@ -975,7 +1008,7 @@ static int fifo_open(struct inode *inode, struct file *filp)
 				goto err_wr;
 		}
 		break;
-	
+
 	case FMODE_READ | FMODE_WRITE:
 	/*
 	 *  O_RDWR
@@ -1054,7 +1087,7 @@ unsigned int round_pipe_size(unsigned long size)
 static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 {
 	struct pipe_buffer *bufs;
-	unsigned int size, nr_pages;
+	unsigned int size, nr_pages, head, tail, mask, n;
 	unsigned long user_bufs;
 	long ret = 0;
 
@@ -1086,12 +1119,16 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	}
 
 	/*
-	 * We can shrink the pipe, if arg >= pipe->nrbufs. Since we don't
-	 * expect a lot of shrink+grow operations, just free and allocate
-	 * again like we would do for growing. If the pipe currently
-	 * contains more buffers than arg, then return busy.
+	 * We can shrink the pipe, if arg is greater than the number of
+	 * buffers.  Since we don't expect a lot of shrink+grow operations,
+	 * just free and allocate again like we would do for growing.  If the
+	 * pipe currently contains more buffers than arg, then return busy.
 	 */
-	if (nr_pages < pipe->nrbufs) {
+	head = pipe->head & mask;
+	tail = pipe->tail & mask;
+	mask = pipe->buffers - 1;
+	n = head - tail;
+	if (nr_pages < n) {
 		ret = -EBUSY;
 		goto out_revert_acct;
 	}
@@ -1107,27 +1144,24 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	 * The pipe array wraps around, so just start the new one at zero
 	 * and adjust the indexes.
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
+			unsigned int s = pipe->buffers - tail;
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
-	pipe->bufs = bufs;
-	pipe->buffers = nr_pages;
+	pipe->tail = tail;
+	smp_store_release(&pipe->head, head);
 	return nr_pages * PAGE_SIZE;
 
 out_revert_acct:
diff --git a/fs/splice.c b/fs/splice.c
index 98412721f056..fbded7749bd0 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -185,6 +185,9 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 		       struct splice_pipe_desc *spd)
 {
 	unsigned int spd_pages = spd->nr_pages;
+	unsigned int tail = pipe_get_tail_for_write(pipe);
+	unsigned int head = pipe->head;
+	unsigned int mask = pipe->buffers - 1;
 	int ret = 0, page_nr = 0;
 
 	if (!spd_pages)
@@ -196,9 +199,8 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 		goto out;
 	}
 
-	while (pipe->nrbufs < pipe->buffers) {
-		int newbuf = (pipe->curbuf + pipe->nrbufs) & (pipe->buffers - 1);
-		struct pipe_buffer *buf = pipe->bufs + newbuf;
+	while (head - tail < pipe->buffers) {
+		struct pipe_buffer *buf = &pipe->bufs[head & mask];
 
 		buf->page = spd->pages[page_nr];
 		buf->offset = spd->partial[page_nr].offset;
@@ -207,7 +209,8 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 		buf->ops = spd->ops;
 		buf->flags = 0;
 
-		pipe->nrbufs++;
+		head++;
+		pipe_post_write_barrier(pipe, head);
 		page_nr++;
 		ret += buf->len;
 
@@ -228,17 +231,19 @@ EXPORT_SYMBOL_GPL(splice_to_pipe);
 
 ssize_t add_to_pipe(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
 {
+	unsigned int head = pipe->head;
+	unsigned int tail = pipe_get_tail_for_write(pipe);
+	unsigned int mask = pipe->buffers - 1;
 	int ret;
 
 	if (unlikely(!pipe->readers)) {
 		send_sig(SIGPIPE, current, 0);
 		ret = -EPIPE;
-	} else if (pipe->nrbufs == pipe->buffers) {
+	} else if (head - tail == pipe->buffers) {
 		ret = -EAGAIN;
 	} else {
-		int newbuf = (pipe->curbuf + pipe->nrbufs) & (pipe->buffers - 1);
-		pipe->bufs[newbuf] = *buf;
-		pipe->nrbufs++;
+		pipe->bufs[head & mask] = *buf;
+		pipe_post_write_barrier(pipe, head);
 		return buf->len;
 	}
 	pipe_buf_release(pipe, buf);
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
+	if (pipe->head - pipe->tail == pipe->buffers)
 		return -EAGAIN;
 
 	/*
@@ -400,8 +407,9 @@ static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
 		}
 	}
 
-	pipe->bufs[to.idx].offset = offset;
-	pipe->bufs[to.idx].len -= offset;
+	mask = pipe->buffers - 1;
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
+	unsigned int head = pipe_get_head_for_read(pipe);
+	unsigned int tail = pipe->tail;
+	unsigned int mask = pipe->buffers - 1;
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
+			pipe_post_read_barrier(pipe, tail);
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
 
@@ -699,8 +710,11 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	splice_from_pipe_begin(&sd);
 	while (sd.total_len) {
 		struct iov_iter from;
+		unsigned int head = pipe_get_head_for_read(pipe);
+		unsigned int tail = pipe->tail;
+		unsigned int mask = pipe->buffers - 1;
 		size_t left;
-		int n, idx;
+		int n;
 
 		ret = splice_from_pipe_next(pipe, &sd);
 		if (ret <= 0)
@@ -719,16 +733,13 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 		/* build the vector */
 		left = sd.total_len;
-		for (n = 0, idx = pipe->curbuf; left && n < pipe->nrbufs; n++, idx++) {
-			struct pipe_buffer *buf = pipe->bufs + idx;
+		for (n = 0; left && tail < head && n < nbufs; tail++, n++) {
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
+			struct pipe_buffer *buf = &pipe->bufs[tail];
 			if (ret >= buf->len) {
 				ret -= buf->len;
 				buf->len = 0;
 				pipe_buf_release(pipe, buf);
-				pipe->curbuf = (pipe->curbuf + 1) & (pipe->buffers - 1);
-				pipe->nrbufs--;
+				tail++;
+				pipe_post_read_barrier(pipe, tail);
 				if (pipe->files)
 					sd.need_wakeup = true;
 			} else {
@@ -942,15 +954,17 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 	sd->flags &= ~SPLICE_F_NONBLOCK;
 	more = sd->flags & SPLICE_F_MORE;
 
-	WARN_ON_ONCE(pipe->nrbufs != 0);
+	WARN_ON_ONCE(pipe->head != pipe->tail);
 
 	while (len) {
+		unsigned int p_nr;
 		size_t read_len;
 		loff_t pos = sd->pos, prev_pos = pos;
 
 		/* Don't try to read more the pipe has space for. */
+		p_nr = READ_ONCE(pipe->head) - READ_ONCE(pipe->tail);
 		read_len = min_t(size_t, len,
-				 (pipe->buffers - pipe->nrbufs) << PAGE_SHIFT);
+				 (pipe->buffers - p_nr) << PAGE_SHIFT);
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
 
@@ -999,7 +1013,7 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 	 * the pipe buffers in question:
 	 */
 	for (i = 0; i < pipe->buffers; i++) {
-		struct pipe_buffer *buf = pipe->bufs + i;
+		struct pipe_buffer *buf = &pipe->bufs[i];
 
 		if (buf->ops)
 			pipe_buf_release(pipe, buf);
@@ -1075,7 +1089,7 @@ static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
 			send_sig(SIGPIPE, current, 0);
 			return -EPIPE;
 		}
-		if (pipe->nrbufs != pipe->buffers)
+		if (pipe->head - READ_ONCE(pipe->tail) != pipe->buffers)
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
+	if (pipe->head == pipe->tail)
 		return 0;
 
 	ret = 0;
 	pipe_lock(pipe);
 
-	while (!pipe->nrbufs) {
+	while (READ_ONCE(pipe->head) == READ_ONCE(pipe->tail)) {
 		if (signal_pending(current)) {
 			ret = -ERESTARTSYS;
 			break;
@@ -1483,13 +1497,13 @@ static int opipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
 	 * Check ->nrbufs without the inode lock first. This function
 	 * is speculative anyways, so missing one is ok.
 	 */
-	if (pipe->nrbufs < pipe->buffers)
+	if (READ_ONCE(pipe->head) - READ_ONCE(pipe->tail) >= pipe->buffers)
 		return 0;
 
 	ret = 0;
 	pipe_lock(pipe);
 
-	while (pipe->nrbufs >= pipe->buffers) {
+	while (READ_ONCE(pipe->head) - READ_ONCE(pipe->tail) >= pipe->buffers) {
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
+	i_mask = ipipe->buffers - 1;
+	o_head = opipe->head;
+	o_mask = opipe->buffers - 1;
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
+		i_head = pipe_get_head_for_read(ipipe);
+		o_tail = pipe_get_tail_for_write(opipe);
+
+		if (i_head != i_tail && !ipipe->writers)
 			break;
 
 		/*
 		 * Cannot make any progress, because either the input
 		 * pipe is empty or the output pipe is full.
 		 */
-		if (!ipipe->nrbufs || opipe->nrbufs >= opipe->buffers) {
+		if (i_head != i_tail || o_head - o_tail >= opipe->buffers) {
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
+			pipe_post_read_barrier(ipipe, i_tail);
 			input_wakeup = true;
+			o_len = obuf->len;
+			o_head++;
+			pipe_post_write_barrier(opipe, o_head);
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
+			pipe_post_write_barrier(opipe, o_head);
 		}
-		ret += obuf->len;
-		len -= obuf->len;
+		ret += o_len;
+		len -= o_len;
 	} while (len);
 
 	pipe_unlock(ipipe);
@@ -1641,6 +1671,9 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 		     size_t len, unsigned int flags)
 {
 	struct pipe_buffer *ibuf, *obuf;
+	unsigned int i_head, o_head;
+	unsigned int i_tail, o_tail;
+	unsigned int i_mask, o_mask;
 	int ret = 0, i = 0, nbuf;
 
 	/*
@@ -1650,6 +1683,11 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 	 */
 	pipe_double_lock(ipipe, opipe);
 
+	i_tail = ipipe->tail;
+	i_mask = ipipe->buffers - 1;
+	o_head = opipe->head;
+	o_mask = opipe->buffers - 1;
+
 	do {
 		if (!opipe->readers) {
 			send_sig(SIGPIPE, current, 0);
@@ -1658,15 +1696,18 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 			break;
 		}
 
+		i_head = pipe_get_head_for_read(ipipe);
+		o_tail = pipe_get_tail_for_write(opipe);
+
 		/*
-		 * If we have iterated all input buffers or ran out of
+		 * If we have iterated all input buffers or run out of
 		 * output room, break.
 		 */
-		if (i >= ipipe->nrbufs || opipe->nrbufs >= opipe->buffers)
+		if (i_head != i_tail || o_head - o_tail >= opipe->buffers)
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
+		pipe_post_write_barrier(opipe, o_head);
 		i++;
 	} while (len);
 
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 5c626fdc10db..b0d74bcb54a1 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -30,9 +30,9 @@ struct pipe_buffer {
  *	struct pipe_inode_info - a linux kernel pipe
  *	@mutex: mutex protecting the whole thing
  *	@wait: reader/writer wait point in case of empty/full pipe
- *	@nrbufs: the number of non-empty pipe buffers in this pipe
+ *	@head: The point of buffer production
+ *	@tail: The point of buffer consumption
  *	@buffers: total number of buffers (should be a power of 2)
- *	@curbuf: the current pipe buffer entry
  *	@tmp_page: cached released page
  *	@readers: number of current readers of this pipe
  *	@writers: number of current writers of this pipe
@@ -48,7 +48,7 @@ struct pipe_buffer {
 struct pipe_inode_info {
 	struct mutex mutex;
 	wait_queue_head_t wait;
-	unsigned int nrbufs, curbuf, buffers;
+	unsigned int head, tail, buffers;
 	unsigned int readers;
 	unsigned int writers;
 	unsigned int files;
@@ -104,6 +104,76 @@ struct pipe_buf_operations {
 	bool (*get)(struct pipe_inode_info *, struct pipe_buffer *);
 };
 
+/**
+ * pipe_get_tail_for_write - Get pipe buffer tail pointer for write-side use
+ * @pipe: The pipe in question
+ *
+ * Get the tail pointer for use in the write-side code.  This may need to
+ * insert a barrier against the reader to order reading the tail pointer
+ * against the reader reading the buffer.
+ */
+static inline unsigned int pipe_get_tail_for_write(struct pipe_inode_info *pipe)
+{
+	return READ_ONCE(pipe->tail);
+}
+
+/**
+ * pipe_post_read_barrier - Set pipe buffer tail pointer in the read-side
+ * @pipe: The pipe in question
+ * @tail: The new tail pointer
+ *
+ * Update the tail pointer in the read-side code.  This inserts a barrier
+ * against the writer such that the data write is ordered before the tail
+ * pointer update.
+ */
+static inline void pipe_post_read_barrier(struct pipe_inode_info *pipe,
+					  unsigned int tail)
+{
+	smp_store_release(&pipe->tail, tail);
+}
+
+/**
+ * pipe_get_head_for_read - Get pipe buffer head pointer for read-side use
+ * @pipe: The pipe in question
+ *
+ * Get the head pointer for use in the read-side code.  This inserts a barrier
+ * against the reader such that the head pointer is read before the data it
+ * points to.
+ */
+static inline unsigned int pipe_get_head_for_read(struct pipe_inode_info *pipe)
+{
+	return READ_ONCE(pipe->head);
+}
+
+/**
+ * pipe_post_write_barrier - Set pipe buffer head pointer in the write-side
+ * @pipe: The pipe in question
+ * @head: The new head pointer
+ *
+ * Update the head pointer in the write-side code.  This inserts a barrier
+ * against the reader such that the data write is ordered before the head
+ * pointer update.
+ */
+static inline void pipe_post_write_barrier(struct pipe_inode_info *pipe,
+					   unsigned int head)
+{
+	smp_store_release(&pipe->head, head);
+}
+
+/**
+ * pipe_set_tail_for_read - Set pipe buffer tail pointer for read-side use
+ * @pipe: The pipe in question
+ * @tail: The new tail pointer
+ *
+ * Set the tail pointer for use in the read-side code.  This inserts a barrier
+ * against the writer such that the data write is ordered before the tail
+ * pointer update.
+ */
+static inline void pipe_get_tail_for_read(struct pipe_inode_info *pipe, unsigned int tail)
+{
+	smp_store_release(&pipe->tail, tail);
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
index f1e0569b4539..54c250d9370b 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -325,27 +325,32 @@ static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t
 static bool sanity(const struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-	int idx = i->idx;
-	int next = pipe->curbuf + pipe->nrbufs;
+	unsigned int p_head = pipe->head;
+	unsigned int p_tail = pipe_get_tail_for_write(pipe);
+	unsigned int p_mask = pipe->buffers - 1;
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
+	printk(KERN_ERR "idx = %d, offset = %zd\n", i_head, i->iov_offset);
+	printk(KERN_ERR "head = %d, tail = %d, buffers = %d\n",
+			p_head, p_tail, pipe->buffers);
 	for (idx = 0; idx < pipe->buffers; idx++)
 		printk(KERN_ERR "[%p %p %d %d]\n",
 			pipe->bufs[idx].ops,
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
+	unsigned int p_tail = pipe_get_tail_for_write(pipe);
+	unsigned int p_mask = pipe->buffers - 1;
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
+	if (i_head - p_tail == pipe->buffers)
 		return 0;
-	pipe->nrbufs++;
-	buf->ops = &page_cache_pipe_buf_ops;
-	get_page(buf->page = page);
+
+	get_page(page);
+	buf->page = page;
 	buf->offset = offset;
 	buf->len = bytes;
+	buf->ops = &page_cache_pipe_buf_ops;
+
+	pipe_post_read_barrier(pipe, i_head);
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
+	unsigned int p_mask = i->pipe->buffers - 1;
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
+	unsigned int p_tail = pipe_get_tail_for_write(pipe);
+	unsigned int p_mask = pipe->buffers - 1;
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
+	while (i_head != p_tail + pipe->buffers) {
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
+		pipe_post_write_barrier(pipe, i_head);
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
+	unsigned int p_mask = pipe->buffers - 1;
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
+	unsigned int p_mask = pipe->buffers - 1;
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
+	unsigned int p_mask = pipe->buffers - 1;
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
+	unsigned int p_mask = pipe->buffers - 1;
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
+	unsigned int p_tail = pipe_get_tail_for_write(pipe);
+	unsigned int p_head = pipe->head;
+	unsigned int p_mask = pipe->buffers - 1;
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
+		while (i_head < p_head) {
+			pipe_buf_release(pipe, &pipe->bufs[i_head & p_mask]);
+			i_head++;
 		}
+
+		pipe_post_write_barrier(pipe, i_head);
 	}
 }
 
@@ -1011,18 +1041,20 @@ static void pipe_advance(struct iov_iter *i, size_t size)
 		size = i->count;
 	if (size) {
 		struct pipe_buffer *buf;
+		unsigned int p_mask = pipe->buffers - 1;
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
+		unsigned int p_mask = pipe->buffers - 1;
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
+	WARN_ON(pipe->head - pipe->tail == pipe->buffers);
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
+	unsigned int p_mask = i->pipe->buffers - 1;
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
+	unsigned int p_mask = pipe->buffers - 1;
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
@@ -1264,12 +1301,13 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	if (!sanity(i))
 		return -EFAULT;
 
-	data_start(i, &idx, start);
-	/* some of this one + all after this one */
-	npages = ((i->pipe->curbuf - idx - 1) & (i->pipe->buffers - 1)) + 1;
-	capacity = min(npages,maxpages) * PAGE_SIZE - *start;
+	data_start(i, &i_head, start);
+	p_tail = pipe_get_tail_for_write(i->pipe);
+	/* Amount of free space: some of this one + all after this one */
+	npages = (p_tail + i->pipe->buffers) - i_head;
+	capacity = min(npages, maxpages) * PAGE_SIZE - *start;
 
-	return __pipe_get_pages(i, min(maxsize, capacity), pages, idx, start);
+	return __pipe_get_pages(i, min(maxsize, capacity), pages, i_head, start);
 }
 
 ssize_t iov_iter_get_pages(struct iov_iter *i,
@@ -1323,8 +1361,9 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 		   size_t *start)
 {
 	struct page **p;
+	unsigned int p_tail;
+	unsigned int i_head;
 	ssize_t n;
-	int idx;
 	int npages;
 
 	if (!maxsize)
@@ -1333,9 +1372,9 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 	if (!sanity(i))
 		return -EFAULT;
 
-	data_start(i, &idx, start);
-	/* some of this one + all after this one */
-	npages = ((i->pipe->curbuf - idx - 1) & (i->pipe->buffers - 1)) + 1;
+	data_start(i, &i_head, start);
+	/* Amount of free space: some of this one + all after this one */
+	npages = (p_tail + i->pipe->buffers) - i_head;
 	n = npages * PAGE_SIZE - *start;
 	if (maxsize > n)
 		maxsize = n;
@@ -1344,7 +1383,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 	p = get_pages_array(npages);
 	if (!p)
 		return -ENOMEM;
-	n = __pipe_get_pages(i, maxsize, p, idx, start);
+	n = __pipe_get_pages(i, maxsize, p, i_head, start);
 	if (n > 0)
 		*pages = p;
 	else
@@ -1560,15 +1599,16 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 
 	if (unlikely(iov_iter_is_pipe(i))) {
 		struct pipe_inode_info *pipe = i->pipe;
+		unsigned int p_tail = pipe_get_tail_for_write(pipe);
+		unsigned int i_head;
 		size_t off;
-		int idx;
 
 		if (!sanity(i))
 			return 0;
 
-		data_start(i, &idx, &off);
+		data_start(i, &i_head, &off);
 		/* some of this one + all after this one */
-		npages = ((pipe->curbuf - idx - 1) & (pipe->buffers - 1)) + 1;
+		npages = (p_tail + pipe->buffers) - i_head;
 		if (npages >= maxpages)
 			return maxpages;
 	} else iterate_all_kinds(i, size, v, ({
