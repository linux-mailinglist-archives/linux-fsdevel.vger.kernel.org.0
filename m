Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C022E244F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 22:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405902AbfJWUR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 16:17:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26973 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405831AbfJWURx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571861870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uyXUP0BHQMJuz45Ak3uslkSalNYJewLHtyWEXntxNU=;
        b=CcZd/xN3gfju/ebwC2t0kApitmENCp7wzwF3Qrw2pQNU7NT8CcnH1Kk4KGerU5qTrPl1xv
        m5wm4tacX9jzYghKdgdL4FXVddN1xP9Kfvk6NxrAOP43SIYzr4t8XnrZYfWZ4ghbBLWIEM
        Z8fi8fAImmgGtAiXNrvv2NBLVfFXJ/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-9INAwdCuNoOt2NnkpOkkHQ-1; Wed, 23 Oct 2019 16:17:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8279A1800E06;
        Wed, 23 Oct 2019 20:17:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6ABBA3DE0;
        Wed, 23 Oct 2019 20:17:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 23 Oct 2019 21:17:41 +0100
Message-ID: <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
In-Reply-To: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 9INAwdCuNoOt2NnkpOkkHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

=09pipe->bufs[head & mask]

     This means that it is not necessary to have a dead slot in the ring as
     head =3D=3D tail isn't ambiguous.

 (4) The ring is empty if "head =3D=3D tail".

     A helper, pipe_empty(), is provided for this.

 (5) The occupancy of the ring is "head - tail".

     A helper, pipe_occupancy(), is provided for this.

 (6) The number of free slots in the ring is "pipe->ring_size - occupancy".

     A helper, pipe_space_for_user() is provided to indicate how many slots
     userspace may use.

 (7) The ring is full if "head - tail >=3D pipe->ring_size".

     A helper, pipe_full(), is provided for this.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fuse/dev.c             |   31 +++--
 fs/pipe.c                 |  169 ++++++++++++++++-------------
 fs/splice.c               |  188 ++++++++++++++++++++------------
 include/linux/pipe_fs_i.h |   86 ++++++++++++++-
 include/linux/uio.h       |    4 -
 lib/iov_iter.c            |  266 +++++++++++++++++++++++++----------------=
----
 6 files changed, 464 insertions(+), 280 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index dadd617d826c..1e4bc27573cc 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -703,7 +703,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 =09=09=09cs->pipebufs++;
 =09=09=09cs->nr_segs--;
 =09=09} else {
-=09=09=09if (cs->nr_segs =3D=3D cs->pipe->buffers)
+=09=09=09if (cs->nr_segs >=3D cs->pipe->ring_size)
 =09=09=09=09return -EIO;
=20
 =09=09=09page =3D alloc_page(GFP_HIGHUSER);
@@ -879,7 +879,7 @@ static int fuse_ref_page(struct fuse_copy_state *cs, st=
ruct page *page,
 =09struct pipe_buffer *buf;
 =09int err;
=20
-=09if (cs->nr_segs =3D=3D cs->pipe->buffers)
+=09if (cs->nr_segs >=3D cs->pipe->ring_size)
 =09=09return -EIO;
=20
 =09err =3D unlock_request(cs->req);
@@ -1341,7 +1341,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, =
loff_t *ppos,
 =09if (!fud)
 =09=09return -EPERM;
=20
-=09bufs =3D kvmalloc_array(pipe->buffers, sizeof(struct pipe_buffer),
+=09bufs =3D kvmalloc_array(pipe->ring_size, sizeof(struct pipe_buffer),
 =09=09=09      GFP_KERNEL);
 =09if (!bufs)
 =09=09return -ENOMEM;
@@ -1353,7 +1353,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, =
loff_t *ppos,
 =09if (ret < 0)
 =09=09goto out;
=20
-=09if (pipe->nrbufs + cs.nr_segs > pipe->buffers) {
+=09if (pipe_occupancy(pipe->head, pipe->tail) + cs.nr_segs > pipe->ring_si=
ze) {
 =09=09ret =3D -EIO;
 =09=09goto out;
 =09}
@@ -1935,6 +1935,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inod=
e_info *pipe,
 =09=09=09=09     struct file *out, loff_t *ppos,
 =09=09=09=09     size_t len, unsigned int flags)
 {
+=09unsigned int head, tail, mask, count;
 =09unsigned nbuf;
 =09unsigned idx;
 =09struct pipe_buffer *bufs;
@@ -1949,8 +1950,12 @@ static ssize_t fuse_dev_splice_write(struct pipe_ino=
de_info *pipe,
=20
 =09pipe_lock(pipe);
=20
-=09bufs =3D kvmalloc_array(pipe->nrbufs, sizeof(struct pipe_buffer),
-=09=09=09      GFP_KERNEL);
+=09head =3D pipe->head;
+=09tail =3D pipe->tail;
+=09mask =3D pipe->ring_size - 1;
+=09count =3D head - tail;
+
+=09bufs =3D kvmalloc_array(count, sizeof(struct pipe_buffer), GFP_KERNEL);
 =09if (!bufs) {
 =09=09pipe_unlock(pipe);
 =09=09return -ENOMEM;
@@ -1958,8 +1963,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_inod=
e_info *pipe,
=20
 =09nbuf =3D 0;
 =09rem =3D 0;
-=09for (idx =3D 0; idx < pipe->nrbufs && rem < len; idx++)
-=09=09rem +=3D pipe->bufs[(pipe->curbuf + idx) & (pipe->buffers - 1)].len;
+=09for (idx =3D tail; idx < head && rem < len; idx++)
+=09=09rem +=3D pipe->bufs[idx & mask].len;
=20
 =09ret =3D -EINVAL;
 =09if (rem < len)
@@ -1970,16 +1975,16 @@ static ssize_t fuse_dev_splice_write(struct pipe_in=
ode_info *pipe,
 =09=09struct pipe_buffer *ibuf;
 =09=09struct pipe_buffer *obuf;
=20
-=09=09BUG_ON(nbuf >=3D pipe->buffers);
-=09=09BUG_ON(!pipe->nrbufs);
-=09=09ibuf =3D &pipe->bufs[pipe->curbuf];
+=09=09BUG_ON(nbuf >=3D pipe->ring_size);
+=09=09BUG_ON(tail =3D=3D head);
+=09=09ibuf =3D &pipe->bufs[tail & mask];
 =09=09obuf =3D &bufs[nbuf];
=20
 =09=09if (rem >=3D ibuf->len) {
 =09=09=09*obuf =3D *ibuf;
 =09=09=09ibuf->ops =3D NULL;
-=09=09=09pipe->curbuf =3D (pipe->curbuf + 1) & (pipe->buffers - 1);
-=09=09=09pipe->nrbufs--;
+=09=09=09tail++;
+=09=09=09pipe_commit_read(pipe, tail);
 =09=09} else {
 =09=09=09if (!pipe_buf_get(pipe, ibuf))
 =09=09=09=09goto out_free;
diff --git a/fs/pipe.c b/fs/pipe.c
index 8a2ab2f974bd..8a0806fe12d3 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -43,10 +43,11 @@ unsigned long pipe_user_pages_hard;
 unsigned long pipe_user_pages_soft =3D PIPE_DEF_BUFFERS * INR_OPEN_CUR;
=20
 /*
- * We use a start+len construction, which provides full use of the=20
- * allocated memory.
- * -- Florian Coosmann (FGC)
- *=20
+ * We use head and tail indices that aren't masked off, except at the poin=
t of
+ * dereference, but rather they're allowed to wrap naturally.  This means =
there
+ * isn't a dead spot in the buffer, provided the ring size < INT_MAX.
+ * -- David Howells 2019-09-23.
+ *
  * Reads with count =3D 0 should always return 0.
  * -- Julian Bradfield 1999-06-07.
  *
@@ -285,10 +286,12 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 =09ret =3D 0;
 =09__pipe_lock(pipe);
 =09for (;;) {
-=09=09int bufs =3D pipe->nrbufs;
-=09=09if (bufs) {
-=09=09=09int curbuf =3D pipe->curbuf;
-=09=09=09struct pipe_buffer *buf =3D pipe->bufs + curbuf;
+=09=09unsigned int head =3D pipe->head;
+=09=09unsigned int tail =3D pipe->tail;
+=09=09unsigned int mask =3D pipe->ring_size - 1;
+
+=09=09if (!pipe_empty(head, tail)) {
+=09=09=09struct pipe_buffer *buf =3D &pipe->bufs[tail & mask];
 =09=09=09size_t chars =3D buf->len;
 =09=09=09size_t written;
 =09=09=09int error;
@@ -321,17 +324,17 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
=20
 =09=09=09if (!buf->len) {
 =09=09=09=09pipe_buf_release(pipe, buf);
-=09=09=09=09curbuf =3D (curbuf + 1) & (pipe->buffers - 1);
-=09=09=09=09pipe->curbuf =3D curbuf;
-=09=09=09=09pipe->nrbufs =3D --bufs;
+=09=09=09=09tail++;
+=09=09=09=09pipe_commit_read(pipe, tail);
 =09=09=09=09do_wakeup =3D 1;
 =09=09=09}
 =09=09=09total_len -=3D chars;
 =09=09=09if (!total_len)
 =09=09=09=09break;=09/* common path: read succeeded */
+=09=09=09if (!pipe_empty(head, tail))=09/* More to do? */
+=09=09=09=09continue;
 =09=09}
-=09=09if (bufs)=09/* More to do? */
-=09=09=09continue;
+
 =09=09if (!pipe->writers)
 =09=09=09break;
 =09=09if (!pipe->waiting_writers) {
@@ -380,6 +383,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 {
 =09struct file *filp =3D iocb->ki_filp;
 =09struct pipe_inode_info *pipe =3D filp->private_data;
+=09unsigned int head, tail, max_usage, mask;
 =09ssize_t ret =3D 0;
 =09int do_wakeup =3D 0;
 =09size_t total_len =3D iov_iter_count(from);
@@ -397,12 +401,15 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 =09=09goto out;
 =09}
=20
+=09tail =3D pipe->tail;
+=09head =3D pipe->head;
+=09max_usage =3D pipe->ring_size;
+=09mask =3D pipe->ring_size - 1;
+
 =09/* We try to merge small writes */
 =09chars =3D total_len & (PAGE_SIZE-1); /* size of the last buffer */
-=09if (pipe->nrbufs && chars !=3D 0) {
-=09=09int lastbuf =3D (pipe->curbuf + pipe->nrbufs - 1) &
-=09=09=09=09=09=09=09(pipe->buffers - 1);
-=09=09struct pipe_buffer *buf =3D pipe->bufs + lastbuf;
+=09if (!pipe_empty(head, tail) && chars !=3D 0) {
+=09=09struct pipe_buffer *buf =3D &pipe->bufs[(head - 1) & mask];
 =09=09int offset =3D buf->offset + buf->len;
=20
 =09=09if (pipe_buf_can_merge(buf) && offset + chars <=3D PAGE_SIZE) {
@@ -423,18 +430,16 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 =09}
=20
 =09for (;;) {
-=09=09int bufs;
-
 =09=09if (!pipe->readers) {
 =09=09=09send_sig(SIGPIPE, current, 0);
 =09=09=09if (!ret)
 =09=09=09=09ret =3D -EPIPE;
 =09=09=09break;
 =09=09}
-=09=09bufs =3D pipe->nrbufs;
-=09=09if (bufs < pipe->buffers) {
-=09=09=09int newbuf =3D (pipe->curbuf + bufs) & (pipe->buffers-1);
-=09=09=09struct pipe_buffer *buf =3D pipe->bufs + newbuf;
+
+=09=09tail =3D pipe->tail;
+=09=09if (!pipe_full(head, tail, max_usage)) {
+=09=09=09struct pipe_buffer *buf =3D &pipe->bufs[head & mask];
 =09=09=09struct page *page =3D pipe->tmp_page;
 =09=09=09int copied;
=20
@@ -470,14 +475,19 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 =09=09=09=09buf->ops =3D &packet_pipe_buf_ops;
 =09=09=09=09buf->flags =3D PIPE_BUF_FLAG_PACKET;
 =09=09=09}
-=09=09=09pipe->nrbufs =3D ++bufs;
+
+=09=09=09head++;
+=09=09=09pipe_commit_write(pipe, head);
 =09=09=09pipe->tmp_page =3D NULL;
=20
 =09=09=09if (!iov_iter_count(from))
 =09=09=09=09break;
 =09=09}
-=09=09if (bufs < pipe->buffers)
+
+=09=09if (!pipe_full(head, tail, max_usage))
 =09=09=09continue;
+
+=09=09/* Wait for buffer space to become available. */
 =09=09if (filp->f_flags & O_NONBLOCK) {
 =09=09=09if (!ret)
 =09=09=09=09ret =3D -EAGAIN;
@@ -515,17 +525,19 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long =
arg)
 {
 =09struct pipe_inode_info *pipe =3D filp->private_data;
-=09int count, buf, nrbufs;
+=09int count, head, tail, mask;
=20
 =09switch (cmd) {
 =09=09case FIONREAD:
 =09=09=09__pipe_lock(pipe);
 =09=09=09count =3D 0;
-=09=09=09buf =3D pipe->curbuf;
-=09=09=09nrbufs =3D pipe->nrbufs;
-=09=09=09while (--nrbufs >=3D 0) {
-=09=09=09=09count +=3D pipe->bufs[buf].len;
-=09=09=09=09buf =3D (buf+1) & (pipe->buffers - 1);
+=09=09=09head =3D pipe->head;
+=09=09=09tail =3D pipe->tail;
+=09=09=09mask =3D pipe->ring_size - 1;
+
+=09=09=09while (tail !=3D head) {
+=09=09=09=09count +=3D pipe->bufs[tail & mask].len;
+=09=09=09=09tail++;
 =09=09=09}
 =09=09=09__pipe_unlock(pipe);
=20
@@ -541,21 +553,25 @@ pipe_poll(struct file *filp, poll_table *wait)
 {
 =09__poll_t mask;
 =09struct pipe_inode_info *pipe =3D filp->private_data;
-=09int nrbufs;
+=09unsigned int head =3D READ_ONCE(pipe->head);
+=09unsigned int tail =3D READ_ONCE(pipe->tail);
=20
 =09poll_wait(filp, &pipe->wait, wait);
=20
+=09BUG_ON(pipe_occupancy(head, tail) > pipe->ring_size);
+
 =09/* Reading only -- no need for acquiring the semaphore.  */
-=09nrbufs =3D pipe->nrbufs;
 =09mask =3D 0;
 =09if (filp->f_mode & FMODE_READ) {
-=09=09mask =3D (nrbufs > 0) ? EPOLLIN | EPOLLRDNORM : 0;
+=09=09if (!pipe_empty(head, tail))
+=09=09=09mask |=3D EPOLLIN | EPOLLRDNORM;
 =09=09if (!pipe->writers && filp->f_version !=3D pipe->w_counter)
 =09=09=09mask |=3D EPOLLHUP;
 =09}
=20
 =09if (filp->f_mode & FMODE_WRITE) {
-=09=09mask |=3D (nrbufs < pipe->buffers) ? EPOLLOUT | EPOLLWRNORM : 0;
+=09=09if (!pipe_full(head, tail, pipe->ring_size))
+=09=09=09mask |=3D EPOLLOUT | EPOLLWRNORM;
 =09=09/*
 =09=09 * Most Unices do not set EPOLLERR for FIFOs but on Linux they
 =09=09 * behave exactly like pipes for poll().
@@ -679,7 +695,7 @@ struct pipe_inode_info *alloc_pipe_info(void)
 =09if (pipe->bufs) {
 =09=09init_waitqueue_head(&pipe->wait);
 =09=09pipe->r_counter =3D pipe->w_counter =3D 1;
-=09=09pipe->buffers =3D pipe_bufs;
+=09=09pipe->ring_size =3D pipe_bufs;
 =09=09pipe->user =3D user;
 =09=09mutex_init(&pipe->mutex);
 =09=09return pipe;
@@ -697,9 +713,9 @@ void free_pipe_info(struct pipe_inode_info *pipe)
 {
 =09int i;
=20
-=09(void) account_pipe_buffers(pipe->user, pipe->buffers, 0);
+=09(void) account_pipe_buffers(pipe->user, pipe->ring_size, 0);
 =09free_uid(pipe->user);
-=09for (i =3D 0; i < pipe->buffers; i++) {
+=09for (i =3D 0; i < pipe->ring_size; i++) {
 =09=09struct pipe_buffer *buf =3D pipe->bufs + i;
 =09=09if (buf->ops)
 =09=09=09pipe_buf_release(pipe, buf);
@@ -880,7 +896,7 @@ SYSCALL_DEFINE1(pipe, int __user *, fildes)
=20
 static int wait_for_partner(struct pipe_inode_info *pipe, unsigned int *cn=
t)
 {
-=09int cur =3D *cnt;=09
+=09int cur =3D *cnt;
=20
 =09while (cur =3D=3D *cnt) {
 =09=09pipe_wait(pipe);
@@ -955,7 +971,7 @@ static int fifo_open(struct inode *inode, struct file *=
filp)
 =09=09=09}
 =09=09}
 =09=09break;
-=09
+
 =09case FMODE_WRITE:
 =09/*
 =09 *  O_WRONLY
@@ -975,7 +991,7 @@ static int fifo_open(struct inode *inode, struct file *=
filp)
 =09=09=09=09goto err_wr;
 =09=09}
 =09=09break;
-=09
+
 =09case FMODE_READ | FMODE_WRITE:
 =09/*
 =09 *  O_RDWR
@@ -1054,14 +1070,14 @@ unsigned int round_pipe_size(unsigned long size)
 static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 {
 =09struct pipe_buffer *bufs;
-=09unsigned int size, nr_pages;
+=09unsigned int size, nr_slots, head, tail, mask, n;
 =09unsigned long user_bufs;
 =09long ret =3D 0;
=20
 =09size =3D round_pipe_size(arg);
-=09nr_pages =3D size >> PAGE_SHIFT;
+=09nr_slots =3D size >> PAGE_SHIFT;
=20
-=09if (!nr_pages)
+=09if (!nr_slots)
 =09=09return -EINVAL;
=20
 =09/*
@@ -1071,13 +1087,13 @@ static long pipe_set_size(struct pipe_inode_info *p=
ipe, unsigned long arg)
 =09 * Decreasing the pipe capacity is always permitted, even
 =09 * if the user is currently over a limit.
 =09 */
-=09if (nr_pages > pipe->buffers &&
+=09if (nr_slots > pipe->ring_size &&
 =09=09=09size > pipe_max_size && !capable(CAP_SYS_RESOURCE))
 =09=09return -EPERM;
=20
-=09user_bufs =3D account_pipe_buffers(pipe->user, pipe->buffers, nr_pages)=
;
+=09user_bufs =3D account_pipe_buffers(pipe->user, pipe->ring_size, nr_slot=
s);
=20
-=09if (nr_pages > pipe->buffers &&
+=09if (nr_slots > pipe->ring_size &&
 =09=09=09(too_many_pipe_buffers_hard(user_bufs) ||
 =09=09=09 too_many_pipe_buffers_soft(user_bufs)) &&
 =09=09=09is_unprivileged_user()) {
@@ -1086,17 +1102,21 @@ static long pipe_set_size(struct pipe_inode_info *p=
ipe, unsigned long arg)
 =09}
=20
 =09/*
-=09 * We can shrink the pipe, if arg >=3D pipe->nrbufs. Since we don't
-=09 * expect a lot of shrink+grow operations, just free and allocate
-=09 * again like we would do for growing. If the pipe currently
+=09 * We can shrink the pipe, if arg is greater than the ring occupancy.
+=09 * Since we don't expect a lot of shrink+grow operations, just free and
+=09 * allocate again like we would do for growing.  If the pipe currently
 =09 * contains more buffers than arg, then return busy.
 =09 */
-=09if (nr_pages < pipe->nrbufs) {
+=09mask =3D pipe->ring_size - 1;
+=09head =3D pipe->head;
+=09tail =3D pipe->tail;
+=09n =3D pipe_occupancy(pipe->head, pipe->tail);
+=09if (nr_slots < n) {
 =09=09ret =3D -EBUSY;
 =09=09goto out_revert_acct;
 =09}
=20
-=09bufs =3D kcalloc(nr_pages, sizeof(*bufs),
+=09bufs =3D kcalloc(nr_slots, sizeof(*bufs),
 =09=09       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 =09if (unlikely(!bufs)) {
 =09=09ret =3D -ENOMEM;
@@ -1105,33 +1125,36 @@ static long pipe_set_size(struct pipe_inode_info *p=
ipe, unsigned long arg)
=20
 =09/*
 =09 * The pipe array wraps around, so just start the new one at zero
-=09 * and adjust the indexes.
+=09 * and adjust the indices.
 =09 */
-=09if (pipe->nrbufs) {
-=09=09unsigned int tail;
-=09=09unsigned int head;
-
-=09=09tail =3D pipe->curbuf + pipe->nrbufs;
-=09=09if (tail < pipe->buffers)
-=09=09=09tail =3D 0;
-=09=09else
-=09=09=09tail &=3D (pipe->buffers - 1);
-
-=09=09head =3D pipe->nrbufs - tail;
-=09=09if (head)
-=09=09=09memcpy(bufs, pipe->bufs + pipe->curbuf, head * sizeof(struct pipe=
_buffer));
-=09=09if (tail)
-=09=09=09memcpy(bufs + head, pipe->bufs, tail * sizeof(struct pipe_buffer)=
);
+=09if (n > 0) {
+=09=09unsigned int h =3D head & mask;
+=09=09unsigned int t =3D tail & mask;
+=09=09if (h > t) {
+=09=09=09memcpy(bufs, pipe->bufs + t,
+=09=09=09       n * sizeof(struct pipe_buffer));
+=09=09} else {
+=09=09=09unsigned int tsize =3D pipe->ring_size - t;
+=09=09=09if (h > 0)
+=09=09=09=09memcpy(bufs + tsize, pipe->bufs,
+=09=09=09=09       h * sizeof(struct pipe_buffer));
+=09=09=09memcpy(bufs, pipe->bufs + t,
+=09=09=09       tsize * sizeof(struct pipe_buffer));
+=09=09}
 =09}
=20
-=09pipe->curbuf =3D 0;
+=09head =3D n;
+=09tail =3D 0;
+
 =09kfree(pipe->bufs);
 =09pipe->bufs =3D bufs;
-=09pipe->buffers =3D nr_pages;
-=09return nr_pages * PAGE_SIZE;
+=09pipe->ring_size =3D nr_slots;
+=09pipe->tail =3D tail;
+=09pipe->head =3D head;
+=09return pipe->ring_size * PAGE_SIZE;
=20
 out_revert_acct:
-=09(void) account_pipe_buffers(pipe->user, nr_pages, pipe->buffers);
+=09(void) account_pipe_buffers(pipe->user, nr_slots, pipe->ring_size);
 =09return ret;
 }
=20
@@ -1161,7 +1184,7 @@ long pipe_fcntl(struct file *file, unsigned int cmd, =
unsigned long arg)
 =09=09ret =3D pipe_set_size(pipe, arg);
 =09=09break;
 =09case F_GETPIPE_SZ:
-=09=09ret =3D pipe->buffers * PAGE_SIZE;
+=09=09ret =3D pipe->ring_size * PAGE_SIZE;
 =09=09break;
 =09default:
 =09=09ret =3D -EINVAL;
diff --git a/fs/splice.c b/fs/splice.c
index 98412721f056..bbc025236ff9 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -185,6 +185,9 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 =09=09       struct splice_pipe_desc *spd)
 {
 =09unsigned int spd_pages =3D spd->nr_pages;
+=09unsigned int tail =3D pipe->tail;
+=09unsigned int head =3D pipe->head;
+=09unsigned int mask =3D pipe->ring_size - 1;
 =09int ret =3D 0, page_nr =3D 0;
=20
 =09if (!spd_pages)
@@ -196,9 +199,8 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 =09=09goto out;
 =09}
=20
-=09while (pipe->nrbufs < pipe->buffers) {
-=09=09int newbuf =3D (pipe->curbuf + pipe->nrbufs) & (pipe->buffers - 1);
-=09=09struct pipe_buffer *buf =3D pipe->bufs + newbuf;
+=09while (!pipe_full(head, tail, pipe->ring_size)) {
+=09=09struct pipe_buffer *buf =3D &pipe->bufs[head & mask];
=20
 =09=09buf->page =3D spd->pages[page_nr];
 =09=09buf->offset =3D spd->partial[page_nr].offset;
@@ -207,7 +209,8 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 =09=09buf->ops =3D spd->ops;
 =09=09buf->flags =3D 0;
=20
-=09=09pipe->nrbufs++;
+=09=09head++;
+=09=09pipe_commit_write(pipe, head);
 =09=09page_nr++;
 =09=09ret +=3D buf->len;
=20
@@ -228,17 +231,19 @@ EXPORT_SYMBOL_GPL(splice_to_pipe);
=20
 ssize_t add_to_pipe(struct pipe_inode_info *pipe, struct pipe_buffer *buf)
 {
+=09unsigned int head =3D pipe->head;
+=09unsigned int tail =3D pipe->tail;
+=09unsigned int mask =3D pipe->ring_size - 1;
 =09int ret;
=20
 =09if (unlikely(!pipe->readers)) {
 =09=09send_sig(SIGPIPE, current, 0);
 =09=09ret =3D -EPIPE;
-=09} else if (pipe->nrbufs =3D=3D pipe->buffers) {
+=09} else if (pipe_full(head, tail, pipe->ring_size)) {
 =09=09ret =3D -EAGAIN;
 =09} else {
-=09=09int newbuf =3D (pipe->curbuf + pipe->nrbufs) & (pipe->buffers - 1);
-=09=09pipe->bufs[newbuf] =3D *buf;
-=09=09pipe->nrbufs++;
+=09=09pipe->bufs[head & mask] =3D *buf;
+=09=09pipe_commit_write(pipe, head + 1);
 =09=09return buf->len;
 =09}
 =09pipe_buf_release(pipe, buf);
@@ -252,14 +257,14 @@ EXPORT_SYMBOL(add_to_pipe);
  */
 int splice_grow_spd(const struct pipe_inode_info *pipe, struct splice_pipe=
_desc *spd)
 {
-=09unsigned int buffers =3D READ_ONCE(pipe->buffers);
+=09unsigned int max_usage =3D READ_ONCE(pipe->ring_size);
=20
-=09spd->nr_pages_max =3D buffers;
-=09if (buffers <=3D PIPE_DEF_BUFFERS)
+=09spd->nr_pages_max =3D max_usage;
+=09if (max_usage <=3D PIPE_DEF_BUFFERS)
 =09=09return 0;
=20
-=09spd->pages =3D kmalloc_array(buffers, sizeof(struct page *), GFP_KERNEL=
);
-=09spd->partial =3D kmalloc_array(buffers, sizeof(struct partial_page),
+=09spd->pages =3D kmalloc_array(max_usage, sizeof(struct page *), GFP_KERN=
EL);
+=09spd->partial =3D kmalloc_array(max_usage, sizeof(struct partial_page),
 =09=09=09=09     GFP_KERNEL);
=20
 =09if (spd->pages && spd->partial)
@@ -298,10 +303,11 @@ ssize_t generic_file_splice_read(struct file *in, lof=
f_t *ppos,
 {
 =09struct iov_iter to;
 =09struct kiocb kiocb;
-=09int idx, ret;
+=09unsigned int i_head;
+=09int ret;
=20
 =09iov_iter_pipe(&to, READ, pipe, len);
-=09idx =3D to.idx;
+=09i_head =3D to.head;
 =09init_sync_kiocb(&kiocb, in);
 =09kiocb.ki_pos =3D *ppos;
 =09ret =3D call_read_iter(in, &kiocb, &to);
@@ -309,7 +315,7 @@ ssize_t generic_file_splice_read(struct file *in, loff_=
t *ppos,
 =09=09*ppos =3D kiocb.ki_pos;
 =09=09file_accessed(in);
 =09} else if (ret < 0) {
-=09=09to.idx =3D idx;
+=09=09to.head =3D i_head;
 =09=09to.iov_offset =3D 0;
 =09=09iov_iter_advance(&to, 0); /* to free what was emitted */
 =09=09/*
@@ -370,11 +376,12 @@ static ssize_t default_file_splice_read(struct file *=
in, loff_t *ppos,
 =09struct iov_iter to;
 =09struct page **pages;
 =09unsigned int nr_pages;
+=09unsigned int mask;
 =09size_t offset, base, copied =3D 0;
 =09ssize_t res;
 =09int i;
=20
-=09if (pipe->nrbufs =3D=3D pipe->buffers)
+=09if (pipe_full(pipe->head, pipe->tail, pipe->ring_size))
 =09=09return -EAGAIN;
=20
 =09/*
@@ -400,8 +407,9 @@ static ssize_t default_file_splice_read(struct file *in=
, loff_t *ppos,
 =09=09}
 =09}
=20
-=09pipe->bufs[to.idx].offset =3D offset;
-=09pipe->bufs[to.idx].len -=3D offset;
+=09mask =3D pipe->ring_size - 1;
+=09pipe->bufs[to.head & mask].offset =3D offset;
+=09pipe->bufs[to.head & mask].len -=3D offset;
=20
 =09for (i =3D 0; i < nr_pages; i++) {
 =09=09size_t this_len =3D min_t(size_t, len, PAGE_SIZE - offset);
@@ -443,7 +451,8 @@ static int pipe_to_sendpage(struct pipe_inode_info *pip=
e,
=20
 =09more =3D (sd->flags & SPLICE_F_MORE) ? MSG_MORE : 0;
=20
-=09if (sd->len < sd->total_len && pipe->nrbufs > 1)
+=09if (sd->len < sd->total_len &&
+=09    pipe_occupancy(pipe->head, pipe->tail) > 1)
 =09=09more |=3D MSG_SENDPAGE_NOTLAST;
=20
 =09return file->f_op->sendpage(file, buf->page, buf->offset,
@@ -481,10 +490,13 @@ static void wakeup_pipe_writers(struct pipe_inode_inf=
o *pipe)
 static int splice_from_pipe_feed(struct pipe_inode_info *pipe, struct spli=
ce_desc *sd,
 =09=09=09  splice_actor *actor)
 {
+=09unsigned int head =3D pipe->head;
+=09unsigned int tail =3D pipe->tail;
+=09unsigned int mask =3D pipe->ring_size - 1;
 =09int ret;
=20
-=09while (pipe->nrbufs) {
-=09=09struct pipe_buffer *buf =3D pipe->bufs + pipe->curbuf;
+=09while (!pipe_empty(tail, head)) {
+=09=09struct pipe_buffer *buf =3D &pipe->bufs[tail & mask];
=20
 =09=09sd->len =3D buf->len;
 =09=09if (sd->len > sd->total_len)
@@ -511,8 +523,8 @@ static int splice_from_pipe_feed(struct pipe_inode_info=
 *pipe, struct splice_des
=20
 =09=09if (!buf->len) {
 =09=09=09pipe_buf_release(pipe, buf);
-=09=09=09pipe->curbuf =3D (pipe->curbuf + 1) & (pipe->buffers - 1);
-=09=09=09pipe->nrbufs--;
+=09=09=09tail++;
+=09=09=09pipe_commit_read(pipe, tail);
 =09=09=09if (pipe->files)
 =09=09=09=09sd->need_wakeup =3D true;
 =09=09}
@@ -543,7 +555,7 @@ static int splice_from_pipe_next(struct pipe_inode_info=
 *pipe, struct splice_des
 =09if (signal_pending(current))
 =09=09return -ERESTARTSYS;
=20
-=09while (!pipe->nrbufs) {
+=09while (pipe_empty(pipe->head, pipe->tail)) {
 =09=09if (!pipe->writers)
 =09=09=09return 0;
=20
@@ -686,7 +698,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, st=
ruct file *out,
 =09=09.pos =3D *ppos,
 =09=09.u.file =3D out,
 =09};
-=09int nbufs =3D pipe->buffers;
+=09int nbufs =3D pipe->ring_size;
 =09struct bio_vec *array =3D kcalloc(nbufs, sizeof(struct bio_vec),
 =09=09=09=09=09GFP_KERNEL);
 =09ssize_t ret;
@@ -699,16 +711,19 @@ iter_file_splice_write(struct pipe_inode_info *pipe, =
struct file *out,
 =09splice_from_pipe_begin(&sd);
 =09while (sd.total_len) {
 =09=09struct iov_iter from;
+=09=09unsigned int head =3D pipe->head;
+=09=09unsigned int tail =3D pipe->tail;
+=09=09unsigned int mask =3D pipe->ring_size - 1;
 =09=09size_t left;
-=09=09int n, idx;
+=09=09int n;
=20
 =09=09ret =3D splice_from_pipe_next(pipe, &sd);
 =09=09if (ret <=3D 0)
 =09=09=09break;
=20
-=09=09if (unlikely(nbufs < pipe->buffers)) {
+=09=09if (unlikely(nbufs < pipe->ring_size)) {
 =09=09=09kfree(array);
-=09=09=09nbufs =3D pipe->buffers;
+=09=09=09nbufs =3D pipe->ring_size;
 =09=09=09array =3D kcalloc(nbufs, sizeof(struct bio_vec),
 =09=09=09=09=09GFP_KERNEL);
 =09=09=09if (!array) {
@@ -719,16 +734,13 @@ iter_file_splice_write(struct pipe_inode_info *pipe, =
struct file *out,
=20
 =09=09/* build the vector */
 =09=09left =3D sd.total_len;
-=09=09for (n =3D 0, idx =3D pipe->curbuf; left && n < pipe->nrbufs; n++, i=
dx++) {
-=09=09=09struct pipe_buffer *buf =3D pipe->bufs + idx;
+=09=09for (n =3D 0; !pipe_empty(head, tail) && left && n < nbufs; tail++, =
n++) {
+=09=09=09struct pipe_buffer *buf =3D &pipe->bufs[tail & mask];
 =09=09=09size_t this_len =3D buf->len;
=20
 =09=09=09if (this_len > left)
 =09=09=09=09this_len =3D left;
=20
-=09=09=09if (idx =3D=3D pipe->buffers - 1)
-=09=09=09=09idx =3D -1;
-
 =09=09=09ret =3D pipe_buf_confirm(pipe, buf);
 =09=09=09if (unlikely(ret)) {
 =09=09=09=09if (ret =3D=3D -ENODATA)
@@ -752,14 +764,15 @@ iter_file_splice_write(struct pipe_inode_info *pipe, =
struct file *out,
 =09=09*ppos =3D sd.pos;
=20
 =09=09/* dismiss the fully eaten buffers, adjust the partial one */
+=09=09tail =3D pipe->tail;
 =09=09while (ret) {
-=09=09=09struct pipe_buffer *buf =3D pipe->bufs + pipe->curbuf;
+=09=09=09struct pipe_buffer *buf =3D &pipe->bufs[tail & mask];
 =09=09=09if (ret >=3D buf->len) {
 =09=09=09=09ret -=3D buf->len;
 =09=09=09=09buf->len =3D 0;
 =09=09=09=09pipe_buf_release(pipe, buf);
-=09=09=09=09pipe->curbuf =3D (pipe->curbuf + 1) & (pipe->buffers - 1);
-=09=09=09=09pipe->nrbufs--;
+=09=09=09=09tail++;
+=09=09=09=09pipe_commit_read(pipe, tail);
 =09=09=09=09if (pipe->files)
 =09=09=09=09=09sd.need_wakeup =3D true;
 =09=09=09} else {
@@ -942,15 +955,17 @@ ssize_t splice_direct_to_actor(struct file *in, struc=
t splice_desc *sd,
 =09sd->flags &=3D ~SPLICE_F_NONBLOCK;
 =09more =3D sd->flags & SPLICE_F_MORE;
=20
-=09WARN_ON_ONCE(pipe->nrbufs !=3D 0);
+=09WARN_ON_ONCE(!pipe_empty(pipe->head, pipe->tail));
=20
 =09while (len) {
+=09=09unsigned int p_space;
 =09=09size_t read_len;
 =09=09loff_t pos =3D sd->pos, prev_pos =3D pos;
=20
 =09=09/* Don't try to read more the pipe has space for. */
-=09=09read_len =3D min_t(size_t, len,
-=09=09=09=09 (pipe->buffers - pipe->nrbufs) << PAGE_SHIFT);
+=09=09p_space =3D pipe->ring_size -
+=09=09=09pipe_occupancy(pipe->head, pipe->tail);
+=09=09read_len =3D min_t(size_t, len, p_space << PAGE_SHIFT);
 =09=09ret =3D do_splice_to(in, &pos, pipe, read_len, flags);
 =09=09if (unlikely(ret <=3D 0))
 =09=09=09goto out_release;
@@ -989,7 +1004,7 @@ ssize_t splice_direct_to_actor(struct file *in, struct=
 splice_desc *sd,
 =09}
=20
 done:
-=09pipe->nrbufs =3D pipe->curbuf =3D 0;
+=09pipe->tail =3D pipe->head =3D 0;
 =09file_accessed(in);
 =09return bytes;
=20
@@ -998,8 +1013,8 @@ ssize_t splice_direct_to_actor(struct file *in, struct=
 splice_desc *sd,
 =09 * If we did an incomplete transfer we must release
 =09 * the pipe buffers in question:
 =09 */
-=09for (i =3D 0; i < pipe->buffers; i++) {
-=09=09struct pipe_buffer *buf =3D pipe->bufs + i;
+=09for (i =3D 0; i < pipe->ring_size; i++) {
+=09=09struct pipe_buffer *buf =3D &pipe->bufs[i];
=20
 =09=09if (buf->ops)
 =09=09=09pipe_buf_release(pipe, buf);
@@ -1075,7 +1090,7 @@ static int wait_for_space(struct pipe_inode_info *pip=
e, unsigned flags)
 =09=09=09send_sig(SIGPIPE, current, 0);
 =09=09=09return -EPIPE;
 =09=09}
-=09=09if (pipe->nrbufs !=3D pipe->buffers)
+=09=09if (!pipe_full(pipe->head, pipe->tail, pipe->ring_size))
 =09=09=09return 0;
 =09=09if (flags & SPLICE_F_NONBLOCK)
 =09=09=09return -EAGAIN;
@@ -1442,16 +1457,16 @@ static int ipipe_prep(struct pipe_inode_info *pipe,=
 unsigned int flags)
 =09int ret;
=20
 =09/*
-=09 * Check ->nrbufs without the inode lock first. This function
+=09 * Check the pipe occupancy without the inode lock first. This function
 =09 * is speculative anyways, so missing one is ok.
 =09 */
-=09if (pipe->nrbufs)
+=09if (!pipe_empty(pipe->head, pipe->tail))
 =09=09return 0;
=20
 =09ret =3D 0;
 =09pipe_lock(pipe);
=20
-=09while (!pipe->nrbufs) {
+=09while (pipe_empty(pipe->head, pipe->tail)) {
 =09=09if (signal_pending(current)) {
 =09=09=09ret =3D -ERESTARTSYS;
 =09=09=09break;
@@ -1483,13 +1498,13 @@ static int opipe_prep(struct pipe_inode_info *pipe,=
 unsigned int flags)
 =09 * Check ->nrbufs without the inode lock first. This function
 =09 * is speculative anyways, so missing one is ok.
 =09 */
-=09if (pipe->nrbufs < pipe->buffers)
+=09if (pipe_full(pipe->head, pipe->tail, pipe->ring_size))
 =09=09return 0;
=20
 =09ret =3D 0;
 =09pipe_lock(pipe);
=20
-=09while (pipe->nrbufs >=3D pipe->buffers) {
+=09while (pipe_full(pipe->head, pipe->tail, pipe->ring_size)) {
 =09=09if (!pipe->readers) {
 =09=09=09send_sig(SIGPIPE, current, 0);
 =09=09=09ret =3D -EPIPE;
@@ -1520,7 +1535,10 @@ static int splice_pipe_to_pipe(struct pipe_inode_inf=
o *ipipe,
 =09=09=09       size_t len, unsigned int flags)
 {
 =09struct pipe_buffer *ibuf, *obuf;
-=09int ret =3D 0, nbuf;
+=09unsigned int i_head, o_head;
+=09unsigned int i_tail, o_tail;
+=09unsigned int i_mask, o_mask;
+=09int ret =3D 0;
 =09bool input_wakeup =3D false;
=20
=20
@@ -1540,7 +1558,14 @@ static int splice_pipe_to_pipe(struct pipe_inode_inf=
o *ipipe,
 =09 */
 =09pipe_double_lock(ipipe, opipe);
=20
+=09i_tail =3D ipipe->tail;
+=09i_mask =3D ipipe->ring_size - 1;
+=09o_head =3D opipe->head;
+=09o_mask =3D opipe->ring_size - 1;
+
 =09do {
+=09=09size_t o_len;
+
 =09=09if (!opipe->readers) {
 =09=09=09send_sig(SIGPIPE, current, 0);
 =09=09=09if (!ret)
@@ -1548,14 +1573,18 @@ static int splice_pipe_to_pipe(struct pipe_inode_in=
fo *ipipe,
 =09=09=09break;
 =09=09}
=20
-=09=09if (!ipipe->nrbufs && !ipipe->writers)
+=09=09i_head =3D ipipe->head;
+=09=09o_tail =3D opipe->tail;
+
+=09=09if (pipe_empty(i_head, i_tail) && !ipipe->writers)
 =09=09=09break;
=20
 =09=09/*
 =09=09 * Cannot make any progress, because either the input
 =09=09 * pipe is empty or the output pipe is full.
 =09=09 */
-=09=09if (!ipipe->nrbufs || opipe->nrbufs >=3D opipe->buffers) {
+=09=09if (pipe_empty(i_head, i_tail) ||
+=09=09    pipe_full(o_head, o_tail, opipe->ring_size)) {
 =09=09=09/* Already processed some buffers, break */
 =09=09=09if (ret)
 =09=09=09=09break;
@@ -1575,9 +1604,8 @@ static int splice_pipe_to_pipe(struct pipe_inode_info=
 *ipipe,
 =09=09=09goto retry;
 =09=09}
=20
-=09=09ibuf =3D ipipe->bufs + ipipe->curbuf;
-=09=09nbuf =3D (opipe->curbuf + opipe->nrbufs) & (opipe->buffers - 1);
-=09=09obuf =3D opipe->bufs + nbuf;
+=09=09ibuf =3D &ipipe->bufs[i_tail & i_mask];
+=09=09obuf =3D &opipe->bufs[o_head & o_mask];
=20
 =09=09if (len >=3D ibuf->len) {
 =09=09=09/*
@@ -1585,10 +1613,12 @@ static int splice_pipe_to_pipe(struct pipe_inode_in=
fo *ipipe,
 =09=09=09 */
 =09=09=09*obuf =3D *ibuf;
 =09=09=09ibuf->ops =3D NULL;
-=09=09=09opipe->nrbufs++;
-=09=09=09ipipe->curbuf =3D (ipipe->curbuf + 1) & (ipipe->buffers - 1);
-=09=09=09ipipe->nrbufs--;
+=09=09=09i_tail++;
+=09=09=09pipe_commit_read(ipipe, i_tail);
 =09=09=09input_wakeup =3D true;
+=09=09=09o_len =3D obuf->len;
+=09=09=09o_head++;
+=09=09=09pipe_commit_write(opipe, o_head);
 =09=09} else {
 =09=09=09/*
 =09=09=09 * Get a reference to this pipe buffer,
@@ -1610,12 +1640,14 @@ static int splice_pipe_to_pipe(struct pipe_inode_in=
fo *ipipe,
 =09=09=09pipe_buf_mark_unmergeable(obuf);
=20
 =09=09=09obuf->len =3D len;
-=09=09=09opipe->nrbufs++;
-=09=09=09ibuf->offset +=3D obuf->len;
-=09=09=09ibuf->len -=3D obuf->len;
+=09=09=09ibuf->offset +=3D len;
+=09=09=09ibuf->len -=3D len;
+=09=09=09o_len =3D len;
+=09=09=09o_head++;
+=09=09=09pipe_commit_write(opipe, o_head);
 =09=09}
-=09=09ret +=3D obuf->len;
-=09=09len -=3D obuf->len;
+=09=09ret +=3D o_len;
+=09=09len -=3D o_len;
 =09} while (len);
=20
 =09pipe_unlock(ipipe);
@@ -1641,7 +1673,10 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 =09=09     size_t len, unsigned int flags)
 {
 =09struct pipe_buffer *ibuf, *obuf;
-=09int ret =3D 0, i =3D 0, nbuf;
+=09unsigned int i_head, o_head;
+=09unsigned int i_tail, o_tail;
+=09unsigned int i_mask, o_mask;
+=09int ret =3D 0;
=20
 =09/*
 =09 * Potential ABBA deadlock, work around it by ordering lock
@@ -1650,6 +1685,11 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 =09 */
 =09pipe_double_lock(ipipe, opipe);
=20
+=09i_tail =3D ipipe->tail;
+=09i_mask =3D ipipe->ring_size - 1;
+=09o_head =3D opipe->head;
+=09o_mask =3D opipe->ring_size - 1;
+
 =09do {
 =09=09if (!opipe->readers) {
 =09=09=09send_sig(SIGPIPE, current, 0);
@@ -1658,15 +1698,19 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 =09=09=09break;
 =09=09}
=20
+=09=09i_head =3D ipipe->head;
+=09=09o_tail =3D opipe->tail;
+
 =09=09/*
-=09=09 * If we have iterated all input buffers or ran out of
+=09=09 * If we have iterated all input buffers or run out of
 =09=09 * output room, break.
 =09=09 */
-=09=09if (i >=3D ipipe->nrbufs || opipe->nrbufs >=3D opipe->buffers)
+=09=09if (pipe_empty(i_head, i_tail) ||
+=09=09    pipe_full(o_head, o_tail, opipe->ring_size))
 =09=09=09break;
=20
-=09=09ibuf =3D ipipe->bufs + ((ipipe->curbuf + i) & (ipipe->buffers-1));
-=09=09nbuf =3D (opipe->curbuf + opipe->nrbufs) & (opipe->buffers - 1);
+=09=09ibuf =3D &ipipe->bufs[i_tail & i_mask];
+=09=09obuf =3D &opipe->bufs[o_head & o_mask];
=20
 =09=09/*
 =09=09 * Get a reference to this pipe buffer,
@@ -1678,7 +1722,6 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 =09=09=09break;
 =09=09}
=20
-=09=09obuf =3D opipe->bufs + nbuf;
 =09=09*obuf =3D *ibuf;
=20
 =09=09/*
@@ -1691,11 +1734,12 @@ static int link_pipe(struct pipe_inode_info *ipipe,
=20
 =09=09if (obuf->len > len)
 =09=09=09obuf->len =3D len;
-
-=09=09opipe->nrbufs++;
 =09=09ret +=3D obuf->len;
 =09=09len -=3D obuf->len;
-=09=09i++;
+
+=09=09o_head++;
+=09=09pipe_commit_write(opipe, o_head);
+=09=09i_tail++;
 =09} while (len);
=20
 =09/*
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 5c626fdc10db..fad096697ff5 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -30,9 +30,9 @@ struct pipe_buffer {
  *=09struct pipe_inode_info - a linux kernel pipe
  *=09@mutex: mutex protecting the whole thing
  *=09@wait: reader/writer wait point in case of empty/full pipe
- *=09@nrbufs: the number of non-empty pipe buffers in this pipe
- *=09@buffers: total number of buffers (should be a power of 2)
- *=09@curbuf: the current pipe buffer entry
+ *=09@head: The point of buffer production
+ *=09@tail: The point of buffer consumption
+ *=09@ring_size: total number of buffers (should be a power of 2)
  *=09@tmp_page: cached released page
  *=09@readers: number of current readers of this pipe
  *=09@writers: number of current writers of this pipe
@@ -48,7 +48,9 @@ struct pipe_buffer {
 struct pipe_inode_info {
 =09struct mutex mutex;
 =09wait_queue_head_t wait;
-=09unsigned int nrbufs, curbuf, buffers;
+=09unsigned int head;
+=09unsigned int tail;
+=09unsigned int ring_size;
 =09unsigned int readers;
 =09unsigned int writers;
 =09unsigned int files;
@@ -104,6 +106,82 @@ struct pipe_buf_operations {
 =09bool (*get)(struct pipe_inode_info *, struct pipe_buffer *);
 };
=20
+/**
+ * pipe_commit_read - Set pipe buffer tail pointer in the read-side
+ * @pipe: The pipe in question
+ * @tail: The new tail pointer
+ *
+ * Update the tail pointer in the read-side code after a read has taken pl=
ace.
+ */
+static inline void pipe_commit_read(struct pipe_inode_info *pipe,
+=09=09=09=09    unsigned int tail)
+{
+=09pipe->tail =3D tail;
+}
+
+/**
+ * pipe_commit_write - Set pipe buffer head pointer in the write-side
+ * @pipe: The pipe in question
+ * @head: The new head pointer
+ *
+ * Update the head pointer in the write-side code after a write has taken =
place.
+ */
+static inline void pipe_commit_write(struct pipe_inode_info *pipe,
+=09=09=09=09     unsigned int head)
+{
+=09pipe->head =3D head;
+}
+
+/**
+ * pipe_empty - Return true if the pipe is empty
+ * @head: The pipe ring head pointer
+ * @tail: The pipe ring tail pointer
+ */
+static inline bool pipe_empty(unsigned int head, unsigned int tail)
+{
+=09return head =3D=3D tail;
+}
+
+/**
+ * pipe_occupancy - Return number of slots used in the pipe
+ * @head: The pipe ring head pointer
+ * @tail: The pipe ring tail pointer
+ */
+static inline unsigned int pipe_occupancy(unsigned int head, unsigned int =
tail)
+{
+=09return head - tail;
+}
+
+/**
+ * pipe_full - Return true if the pipe is full
+ * @head: The pipe ring head pointer
+ * @tail: The pipe ring tail pointer
+ * @limit: The maximum amount of slots available.
+ */
+static inline bool pipe_full(unsigned int head, unsigned int tail,
+=09=09=09     unsigned int limit)
+{
+=09return pipe_occupancy(head, tail) >=3D limit;
+}
+
+/**
+ * pipe_space_for_user - Return number of slots available to userspace
+ * @head: The pipe ring head pointer
+ * @tail: The pipe ring tail pointer
+ * @pipe: The pipe info structure
+ */
+static inline unsigned int pipe_space_for_user(unsigned int head, unsigned=
 int tail,
+=09=09=09=09=09       struct pipe_inode_info *pipe)
+{
+=09unsigned int p_occupancy, p_space;
+
+=09p_occupancy =3D pipe_occupancy(head, tail);
+=09if (p_occupancy >=3D pipe->ring_size)
+=09=09return 0;
+=09p_space =3D pipe->ring_size - p_occupancy;
+=09return p_space;
+}
+
 /**
  * pipe_buf_get - get a reference to a pipe_buffer
  * @pipe:=09the pipe that the buffer belongs to
diff --git a/include/linux/uio.h b/include/linux/uio.h
index ab5f523bc0df..9576fd8158d7 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -45,8 +45,8 @@ struct iov_iter {
 =09union {
 =09=09unsigned long nr_segs;
 =09=09struct {
-=09=09=09int idx;
-=09=09=09int start_idx;
+=09=09=09unsigned int head;
+=09=09=09unsigned int start_head;
 =09=09};
 =09};
 };
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 639d5e7014c1..150a40bdb21a 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -325,28 +325,33 @@ static size_t copy_page_from_iter_iovec(struct page *=
page, size_t offset, size_t
 static bool sanity(const struct iov_iter *i)
 {
 =09struct pipe_inode_info *pipe =3D i->pipe;
-=09int idx =3D i->idx;
-=09int next =3D pipe->curbuf + pipe->nrbufs;
+=09unsigned int p_head =3D pipe->head;
+=09unsigned int p_tail =3D pipe->tail;
+=09unsigned int p_mask =3D pipe->ring_size - 1;
+=09unsigned int p_occupancy =3D pipe_occupancy(p_head, p_tail);
+=09unsigned int i_head =3D i->head;
+=09unsigned int idx;
+
 =09if (i->iov_offset) {
 =09=09struct pipe_buffer *p;
-=09=09if (unlikely(!pipe->nrbufs))
+=09=09if (unlikely(p_occupancy =3D=3D 0))
 =09=09=09goto Bad;=09// pipe must be non-empty
-=09=09if (unlikely(idx !=3D ((next - 1) & (pipe->buffers - 1))))
+=09=09if (unlikely(i_head !=3D p_head - 1))
 =09=09=09goto Bad;=09// must be at the last buffer...
=20
-=09=09p =3D &pipe->bufs[idx];
+=09=09p =3D &pipe->bufs[i_head & p_mask];
 =09=09if (unlikely(p->offset + p->len !=3D i->iov_offset))
 =09=09=09goto Bad;=09// ... at the end of segment
 =09} else {
-=09=09if (idx !=3D (next & (pipe->buffers - 1)))
+=09=09if (i_head !=3D p_head)
 =09=09=09goto Bad;=09// must be right after the last buffer
 =09}
 =09return true;
 Bad:
-=09printk(KERN_ERR "idx =3D %d, offset =3D %zd\n", i->idx, i->iov_offset);
-=09printk(KERN_ERR "curbuf =3D %d, nrbufs =3D %d, buffers =3D %d\n",
-=09=09=09pipe->curbuf, pipe->nrbufs, pipe->buffers);
-=09for (idx =3D 0; idx < pipe->buffers; idx++)
+=09printk(KERN_ERR "idx =3D %d, offset =3D %zd\n", i_head, i->iov_offset);
+=09printk(KERN_ERR "head =3D %d, tail =3D %d, buffers =3D %d\n",
+=09=09=09p_head, p_tail, pipe->ring_size);
+=09for (idx =3D 0; idx < pipe->ring_size; idx++)
 =09=09printk(KERN_ERR "[%p %p %d %d]\n",
 =09=09=09pipe->bufs[idx].ops,
 =09=09=09pipe->bufs[idx].page,
@@ -359,18 +364,15 @@ static bool sanity(const struct iov_iter *i)
 #define sanity(i) true
 #endif
=20
-static inline int next_idx(int idx, struct pipe_inode_info *pipe)
-{
-=09return (idx + 1) & (pipe->buffers - 1);
-}
-
 static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, siz=
e_t bytes,
 =09=09=09 struct iov_iter *i)
 {
 =09struct pipe_inode_info *pipe =3D i->pipe;
 =09struct pipe_buffer *buf;
+=09unsigned int p_tail =3D pipe->tail;
+=09unsigned int p_mask =3D pipe->ring_size - 1;
+=09unsigned int i_head =3D i->head;
 =09size_t off;
-=09int idx;
=20
 =09if (unlikely(bytes > i->count))
 =09=09bytes =3D i->count;
@@ -382,8 +384,7 @@ static size_t copy_page_to_iter_pipe(struct page *page,=
 size_t offset, size_t by
 =09=09return 0;
=20
 =09off =3D i->iov_offset;
-=09idx =3D i->idx;
-=09buf =3D &pipe->bufs[idx];
+=09buf =3D &pipe->bufs[i_head & p_mask];
 =09if (off) {
 =09=09if (offset =3D=3D off && buf->page =3D=3D page) {
 =09=09=09/* merge with the last one */
@@ -391,18 +392,21 @@ static size_t copy_page_to_iter_pipe(struct page *pag=
e, size_t offset, size_t by
 =09=09=09i->iov_offset +=3D bytes;
 =09=09=09goto out;
 =09=09}
-=09=09idx =3D next_idx(idx, pipe);
-=09=09buf =3D &pipe->bufs[idx];
+=09=09i_head++;
+=09=09buf =3D &pipe->bufs[i_head & p_mask];
 =09}
-=09if (idx =3D=3D pipe->curbuf && pipe->nrbufs)
+=09if (pipe_full(i_head, p_tail, pipe->ring_size))
 =09=09return 0;
-=09pipe->nrbufs++;
+
 =09buf->ops =3D &page_cache_pipe_buf_ops;
-=09get_page(buf->page =3D page);
+=09get_page(page);
+=09buf->page =3D page;
 =09buf->offset =3D offset;
 =09buf->len =3D bytes;
+
+=09pipe_commit_read(pipe, i_head);
 =09i->iov_offset =3D offset + bytes;
-=09i->idx =3D idx;
+=09i->head =3D i_head;
 out:
 =09i->count -=3D bytes;
 =09return bytes;
@@ -480,24 +484,30 @@ static inline bool allocated(struct pipe_buffer *buf)
 =09return buf->ops =3D=3D &default_pipe_buf_ops;
 }
=20
-static inline void data_start(const struct iov_iter *i, int *idxp, size_t =
*offp)
+static inline void data_start(const struct iov_iter *i,
+=09=09=09      unsigned int *iter_headp, size_t *offp)
 {
+=09unsigned int p_mask =3D i->pipe->ring_size - 1;
+=09unsigned int iter_head =3D i->head;
 =09size_t off =3D i->iov_offset;
-=09int idx =3D i->idx;
-=09if (off && (!allocated(&i->pipe->bufs[idx]) || off =3D=3D PAGE_SIZE)) {
-=09=09idx =3D next_idx(idx, i->pipe);
+
+=09if (off && (!allocated(&i->pipe->bufs[iter_head & p_mask]) ||
+=09=09    off =3D=3D PAGE_SIZE)) {
+=09=09iter_head++;
 =09=09off =3D 0;
 =09}
-=09*idxp =3D idx;
+=09*iter_headp =3D iter_head;
 =09*offp =3D off;
 }
=20
 static size_t push_pipe(struct iov_iter *i, size_t size,
-=09=09=09int *idxp, size_t *offp)
+=09=09=09int *iter_headp, size_t *offp)
 {
 =09struct pipe_inode_info *pipe =3D i->pipe;
+=09unsigned int p_tail =3D pipe->tail;
+=09unsigned int p_mask =3D pipe->ring_size - 1;
+=09unsigned int iter_head;
 =09size_t off;
-=09int idx;
 =09ssize_t left;
=20
 =09if (unlikely(size > i->count))
@@ -506,33 +516,34 @@ static size_t push_pipe(struct iov_iter *i, size_t si=
ze,
 =09=09return 0;
=20
 =09left =3D size;
-=09data_start(i, &idx, &off);
-=09*idxp =3D idx;
+=09data_start(i, &iter_head, &off);
+=09*iter_headp =3D iter_head;
 =09*offp =3D off;
 =09if (off) {
 =09=09left -=3D PAGE_SIZE - off;
 =09=09if (left <=3D 0) {
-=09=09=09pipe->bufs[idx].len +=3D size;
+=09=09=09pipe->bufs[iter_head & p_mask].len +=3D size;
 =09=09=09return size;
 =09=09}
-=09=09pipe->bufs[idx].len =3D PAGE_SIZE;
-=09=09idx =3D next_idx(idx, pipe);
+=09=09pipe->bufs[iter_head & p_mask].len =3D PAGE_SIZE;
+=09=09iter_head++;
 =09}
-=09while (idx !=3D pipe->curbuf || !pipe->nrbufs) {
+=09while (!pipe_full(iter_head, p_tail, pipe->ring_size)) {
+=09=09struct pipe_buffer *buf =3D &pipe->bufs[iter_head & p_mask];
 =09=09struct page *page =3D alloc_page(GFP_USER);
 =09=09if (!page)
 =09=09=09break;
-=09=09pipe->nrbufs++;
-=09=09pipe->bufs[idx].ops =3D &default_pipe_buf_ops;
-=09=09pipe->bufs[idx].page =3D page;
-=09=09pipe->bufs[idx].offset =3D 0;
-=09=09if (left <=3D PAGE_SIZE) {
-=09=09=09pipe->bufs[idx].len =3D left;
+
+=09=09buf->ops =3D &default_pipe_buf_ops;
+=09=09buf->page =3D page;
+=09=09buf->offset =3D 0;
+=09=09buf->len =3D max_t(ssize_t, left, PAGE_SIZE);
+=09=09left -=3D buf->len;
+=09=09iter_head++;
+=09=09pipe_commit_write(pipe, iter_head);
+
+=09=09if (left =3D=3D 0)
 =09=09=09return size;
-=09=09}
-=09=09pipe->bufs[idx].len =3D PAGE_SIZE;
-=09=09left -=3D PAGE_SIZE;
-=09=09idx =3D next_idx(idx, pipe);
 =09}
 =09return size - left;
 }
@@ -541,23 +552,26 @@ static size_t copy_pipe_to_iter(const void *addr, siz=
e_t bytes,
 =09=09=09=09struct iov_iter *i)
 {
 =09struct pipe_inode_info *pipe =3D i->pipe;
+=09unsigned int p_mask =3D pipe->ring_size - 1;
+=09unsigned int i_head;
 =09size_t n, off;
-=09int idx;
=20
 =09if (!sanity(i))
 =09=09return 0;
=20
-=09bytes =3D n =3D push_pipe(i, bytes, &idx, &off);
+=09bytes =3D n =3D push_pipe(i, bytes, &i_head, &off);
 =09if (unlikely(!n))
 =09=09return 0;
-=09for ( ; n; idx =3D next_idx(idx, pipe), off =3D 0) {
+=09do {
 =09=09size_t chunk =3D min_t(size_t, n, PAGE_SIZE - off);
-=09=09memcpy_to_page(pipe->bufs[idx].page, off, addr, chunk);
-=09=09i->idx =3D idx;
+=09=09memcpy_to_page(pipe->bufs[i_head & p_mask].page, off, addr, chunk);
+=09=09i->head =3D i_head;
 =09=09i->iov_offset =3D off + chunk;
 =09=09n -=3D chunk;
 =09=09addr +=3D chunk;
-=09}
+=09=09off =3D 0;
+=09=09i_head++;
+=09} while (n);
 =09i->count -=3D bytes;
 =09return bytes;
 }
@@ -573,28 +587,31 @@ static size_t csum_and_copy_to_pipe_iter(const void *=
addr, size_t bytes,
 =09=09=09=09__wsum *csum, struct iov_iter *i)
 {
 =09struct pipe_inode_info *pipe =3D i->pipe;
+=09unsigned int p_mask =3D pipe->ring_size - 1;
+=09unsigned int i_head;
 =09size_t n, r;
 =09size_t off =3D 0;
 =09__wsum sum =3D *csum;
-=09int idx;
=20
 =09if (!sanity(i))
 =09=09return 0;
=20
-=09bytes =3D n =3D push_pipe(i, bytes, &idx, &r);
+=09bytes =3D n =3D push_pipe(i, bytes, &i_head, &r);
 =09if (unlikely(!n))
 =09=09return 0;
-=09for ( ; n; idx =3D next_idx(idx, pipe), r =3D 0) {
+=09do {
 =09=09size_t chunk =3D min_t(size_t, n, PAGE_SIZE - r);
-=09=09char *p =3D kmap_atomic(pipe->bufs[idx].page);
+=09=09char *p =3D kmap_atomic(pipe->bufs[i_head & p_mask].page);
 =09=09sum =3D csum_and_memcpy(p + r, addr, chunk, sum, off);
 =09=09kunmap_atomic(p);
-=09=09i->idx =3D idx;
+=09=09i->head =3D i_head;
 =09=09i->iov_offset =3D r + chunk;
 =09=09n -=3D chunk;
 =09=09off +=3D chunk;
 =09=09addr +=3D chunk;
-=09}
+=09=09r =3D 0;
+=09=09i_head++;
+=09} while (n);
 =09i->count -=3D bytes;
 =09*csum =3D sum;
 =09return bytes;
@@ -645,29 +662,32 @@ static size_t copy_pipe_to_iter_mcsafe(const void *ad=
dr, size_t bytes,
 =09=09=09=09struct iov_iter *i)
 {
 =09struct pipe_inode_info *pipe =3D i->pipe;
+=09unsigned int p_mask =3D pipe->ring_size - 1;
+=09unsigned int i_head;
 =09size_t n, off, xfer =3D 0;
-=09int idx;
=20
 =09if (!sanity(i))
 =09=09return 0;
=20
-=09bytes =3D n =3D push_pipe(i, bytes, &idx, &off);
+=09bytes =3D n =3D push_pipe(i, bytes, &i_head, &off);
 =09if (unlikely(!n))
 =09=09return 0;
-=09for ( ; n; idx =3D next_idx(idx, pipe), off =3D 0) {
+=09do {
 =09=09size_t chunk =3D min_t(size_t, n, PAGE_SIZE - off);
 =09=09unsigned long rem;
=20
-=09=09rem =3D memcpy_mcsafe_to_page(pipe->bufs[idx].page, off, addr,
-=09=09=09=09chunk);
-=09=09i->idx =3D idx;
+=09=09rem =3D memcpy_mcsafe_to_page(pipe->bufs[i_head & p_mask].page,
+=09=09=09=09=09    off, addr, chunk);
+=09=09i->head =3D i_head;
 =09=09i->iov_offset =3D off + chunk - rem;
 =09=09xfer +=3D chunk - rem;
 =09=09if (rem)
 =09=09=09break;
 =09=09n -=3D chunk;
 =09=09addr +=3D chunk;
-=09}
+=09=09off =3D 0;
+=09=09i_head++;
+=09} while (n);
 =09i->count -=3D xfer;
 =09return xfer;
 }
@@ -925,6 +945,8 @@ EXPORT_SYMBOL(copy_page_from_iter);
 static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 {
 =09struct pipe_inode_info *pipe =3D i->pipe;
+=09unsigned int p_mask =3D pipe->ring_size - 1;
+=09unsigned int i_head;
 =09size_t n, off;
 =09int idx;
=20
@@ -935,13 +957,15 @@ static size_t pipe_zero(size_t bytes, struct iov_iter=
 *i)
 =09if (unlikely(!n))
 =09=09return 0;
=20
-=09for ( ; n; idx =3D next_idx(idx, pipe), off =3D 0) {
+=09do {
 =09=09size_t chunk =3D min_t(size_t, n, PAGE_SIZE - off);
-=09=09memzero_page(pipe->bufs[idx].page, off, chunk);
-=09=09i->idx =3D idx;
+=09=09memzero_page(pipe->bufs[i_head & p_mask].page, off, chunk);
+=09=09i->head =3D i_head;
 =09=09i->iov_offset =3D off + chunk;
 =09=09n -=3D chunk;
-=09}
+=09=09off =3D 0;
+=09=09i_head++;
+=09} while (n);
 =09i->count -=3D bytes;
 =09return bytes;
 }
@@ -987,20 +1011,26 @@ EXPORT_SYMBOL(iov_iter_copy_from_user_atomic);
 static inline void pipe_truncate(struct iov_iter *i)
 {
 =09struct pipe_inode_info *pipe =3D i->pipe;
-=09if (pipe->nrbufs) {
+=09unsigned int p_tail =3D pipe->tail;
+=09unsigned int p_head =3D pipe->head;
+=09unsigned int p_mask =3D pipe->ring_size - 1;
+
+=09if (!pipe_empty(p_head, p_tail)) {
+=09=09struct pipe_buffer *buf;
+=09=09unsigned int i_head =3D i->head;
 =09=09size_t off =3D i->iov_offset;
-=09=09int idx =3D i->idx;
-=09=09int nrbufs =3D (idx - pipe->curbuf) & (pipe->buffers - 1);
+
 =09=09if (off) {
-=09=09=09pipe->bufs[idx].len =3D off - pipe->bufs[idx].offset;
-=09=09=09idx =3D next_idx(idx, pipe);
-=09=09=09nrbufs++;
+=09=09=09buf =3D &pipe->bufs[i_head & p_mask];
+=09=09=09buf->len =3D off - buf->offset;
+=09=09=09i_head++;
 =09=09}
-=09=09while (pipe->nrbufs > nrbufs) {
-=09=09=09pipe_buf_release(pipe, &pipe->bufs[idx]);
-=09=09=09idx =3D next_idx(idx, pipe);
-=09=09=09pipe->nrbufs--;
+=09=09while (p_head !=3D i_head) {
+=09=09=09p_head--;
+=09=09=09pipe_buf_release(pipe, &pipe->bufs[p_head & p_mask]);
 =09=09}
+
+=09=09pipe_commit_write(pipe, p_head);
 =09}
 }
=20
@@ -1011,18 +1041,20 @@ static void pipe_advance(struct iov_iter *i, size_t=
 size)
 =09=09size =3D i->count;
 =09if (size) {
 =09=09struct pipe_buffer *buf;
+=09=09unsigned int p_mask =3D pipe->ring_size - 1;
+=09=09unsigned int i_head =3D i->head;
 =09=09size_t off =3D i->iov_offset, left =3D size;
-=09=09int idx =3D i->idx;
+
 =09=09if (off) /* make it relative to the beginning of buffer */
-=09=09=09left +=3D off - pipe->bufs[idx].offset;
+=09=09=09left +=3D off - pipe->bufs[i_head & p_mask].offset;
 =09=09while (1) {
-=09=09=09buf =3D &pipe->bufs[idx];
+=09=09=09buf =3D &pipe->bufs[i_head & p_mask];
 =09=09=09if (left <=3D buf->len)
 =09=09=09=09break;
 =09=09=09left -=3D buf->len;
-=09=09=09idx =3D next_idx(idx, pipe);
+=09=09=09i_head++;
 =09=09}
-=09=09i->idx =3D idx;
+=09=09i->head =3D i_head;
 =09=09i->iov_offset =3D buf->offset + left;
 =09}
 =09i->count -=3D size;
@@ -1053,25 +1085,27 @@ void iov_iter_revert(struct iov_iter *i, size_t unr=
oll)
 =09i->count +=3D unroll;
 =09if (unlikely(iov_iter_is_pipe(i))) {
 =09=09struct pipe_inode_info *pipe =3D i->pipe;
-=09=09int idx =3D i->idx;
+=09=09unsigned int p_mask =3D pipe->ring_size - 1;
+=09=09unsigned int i_head =3D i->head;
 =09=09size_t off =3D i->iov_offset;
 =09=09while (1) {
-=09=09=09size_t n =3D off - pipe->bufs[idx].offset;
+=09=09=09struct pipe_buffer *b =3D &pipe->bufs[i_head & p_mask];
+=09=09=09size_t n =3D off - b->offset;
 =09=09=09if (unroll < n) {
 =09=09=09=09off -=3D unroll;
 =09=09=09=09break;
 =09=09=09}
 =09=09=09unroll -=3D n;
-=09=09=09if (!unroll && idx =3D=3D i->start_idx) {
+=09=09=09if (!unroll && i_head =3D=3D i->start_head) {
 =09=09=09=09off =3D 0;
 =09=09=09=09break;
 =09=09=09}
-=09=09=09if (!idx--)
-=09=09=09=09idx =3D pipe->buffers - 1;
-=09=09=09off =3D pipe->bufs[idx].offset + pipe->bufs[idx].len;
+=09=09=09i_head--;
+=09=09=09b =3D &pipe->bufs[i_head & p_mask];
+=09=09=09off =3D b->offset + b->len;
 =09=09}
 =09=09i->iov_offset =3D off;
-=09=09i->idx =3D idx;
+=09=09i->head =3D i_head;
 =09=09pipe_truncate(i);
 =09=09return;
 =09}
@@ -1159,13 +1193,13 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int=
 direction,
 =09=09=09size_t count)
 {
 =09BUG_ON(direction !=3D READ);
-=09WARN_ON(pipe->nrbufs =3D=3D pipe->buffers);
+=09WARN_ON(pipe_full(pipe->head, pipe->tail, pipe->ring_size));
 =09i->type =3D ITER_PIPE | READ;
 =09i->pipe =3D pipe;
-=09i->idx =3D (pipe->curbuf + pipe->nrbufs) & (pipe->buffers - 1);
+=09i->head =3D pipe->head;
 =09i->iov_offset =3D 0;
 =09i->count =3D count;
-=09i->start_idx =3D i->idx;
+=09i->start_head =3D i->head;
 }
 EXPORT_SYMBOL(iov_iter_pipe);
=20
@@ -1189,11 +1223,12 @@ EXPORT_SYMBOL(iov_iter_discard);
=20
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
+=09unsigned int p_mask =3D i->pipe->ring_size - 1;
 =09unsigned long res =3D 0;
 =09size_t size =3D i->count;
=20
 =09if (unlikely(iov_iter_is_pipe(i))) {
-=09=09if (size && i->iov_offset && allocated(&i->pipe->bufs[i->idx]))
+=09=09if (size && i->iov_offset && allocated(&i->pipe->bufs[i->head & p_ma=
sk]))
 =09=09=09return size | i->iov_offset;
 =09=09return size;
 =09}
@@ -1231,19 +1266,20 @@ EXPORT_SYMBOL(iov_iter_gap_alignment);
 static inline ssize_t __pipe_get_pages(struct iov_iter *i,
 =09=09=09=09size_t maxsize,
 =09=09=09=09struct page **pages,
-=09=09=09=09int idx,
+=09=09=09=09int iter_head,
 =09=09=09=09size_t *start)
 {
 =09struct pipe_inode_info *pipe =3D i->pipe;
-=09ssize_t n =3D push_pipe(i, maxsize, &idx, start);
+=09unsigned int p_mask =3D pipe->ring_size - 1;
+=09ssize_t n =3D push_pipe(i, maxsize, &iter_head, start);
 =09if (!n)
 =09=09return -EFAULT;
=20
 =09maxsize =3D n;
 =09n +=3D *start;
 =09while (n > 0) {
-=09=09get_page(*pages++ =3D pipe->bufs[idx].page);
-=09=09idx =3D next_idx(idx, pipe);
+=09=09get_page(*pages++ =3D pipe->bufs[iter_head & p_mask].page);
+=09=09iter_head++;
 =09=09n -=3D PAGE_SIZE;
 =09}
=20
@@ -1254,9 +1290,8 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 =09=09   struct page **pages, size_t maxsize, unsigned maxpages,
 =09=09   size_t *start)
 {
-=09unsigned npages;
+=09unsigned int iter_head, npages;
 =09size_t capacity;
-=09int idx;
=20
 =09if (!maxsize)
 =09=09return 0;
@@ -1264,12 +1299,12 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 =09if (!sanity(i))
 =09=09return -EFAULT;
=20
-=09data_start(i, &idx, start);
-=09/* some of this one + all after this one */
-=09npages =3D ((i->pipe->curbuf - idx - 1) & (i->pipe->buffers - 1)) + 1;
-=09capacity =3D min(npages,maxpages) * PAGE_SIZE - *start;
+=09data_start(i, &iter_head, start);
+=09/* Amount of free space: some of this one + all after this one */
+=09npages =3D pipe_space_for_user(iter_head, i->pipe->tail, i->pipe);
+=09capacity =3D min(npages, maxpages) * PAGE_SIZE - *start;
=20
-=09return __pipe_get_pages(i, min(maxsize, capacity), pages, idx, start);
+=09return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head, st=
art);
 }
=20
 ssize_t iov_iter_get_pages(struct iov_iter *i,
@@ -1323,9 +1358,8 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *=
i,
 =09=09   size_t *start)
 {
 =09struct page **p;
+=09unsigned int iter_head, npages;
 =09ssize_t n;
-=09int idx;
-=09int npages;
=20
 =09if (!maxsize)
 =09=09return 0;
@@ -1333,9 +1367,9 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *=
i,
 =09if (!sanity(i))
 =09=09return -EFAULT;
=20
-=09data_start(i, &idx, start);
-=09/* some of this one + all after this one */
-=09npages =3D ((i->pipe->curbuf - idx - 1) & (i->pipe->buffers - 1)) + 1;
+=09data_start(i, &iter_head, start);
+=09/* Amount of free space: some of this one + all after this one */
+=09npages =3D pipe_space_for_user(iter_head, i->pipe->tail, i->pipe);
 =09n =3D npages * PAGE_SIZE - *start;
 =09if (maxsize > n)
 =09=09maxsize =3D n;
@@ -1344,7 +1378,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *=
i,
 =09p =3D get_pages_array(npages);
 =09if (!p)
 =09=09return -ENOMEM;
-=09n =3D __pipe_get_pages(i, maxsize, p, idx, start);
+=09n =3D __pipe_get_pages(i, maxsize, p, iter_head, start);
 =09if (n > 0)
 =09=09*pages =3D p;
 =09else
@@ -1560,15 +1594,15 @@ int iov_iter_npages(const struct iov_iter *i, int m=
axpages)
=20
 =09if (unlikely(iov_iter_is_pipe(i))) {
 =09=09struct pipe_inode_info *pipe =3D i->pipe;
+=09=09unsigned int iter_head;
 =09=09size_t off;
-=09=09int idx;
=20
 =09=09if (!sanity(i))
 =09=09=09return 0;
=20
-=09=09data_start(i, &idx, &off);
+=09=09data_start(i, &iter_head, &off);
 =09=09/* some of this one + all after this one */
-=09=09npages =3D ((pipe->curbuf - idx - 1) & (pipe->buffers - 1)) + 1;
+=09=09npages =3D pipe_space_for_user(iter_head, pipe->tail, pipe);
 =09=09if (npages >=3D maxpages)
 =09=09=09return maxpages;
 =09} else iterate_all_kinds(i, size, v, ({

