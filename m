Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C873EC7C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 18:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfKARe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 13:34:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51627 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729703AbfKARe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572629697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3+Jnro9bGTxUGjNWG4PT+hlbnJz5YjGU3Jvtd/eEGU=;
        b=MlXF9ChZN0TZhV7JNeLsWBws7TXBx4CBkoU5xaYRG1T5/q5q5ppBBnEkFdfXymgEQvxWBZ
        KMfBYj0k677IDw0oW3aZkyKda34B58P4mEyCGiOt7Crv8GQ9hE8Fnfp4rhsxSuuG/bnwgh
        gCQ+0BVoRZiXK1auS48JAUTulqVcR7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-p6rvO6F6NI2v9viUzMq_WQ-1; Fri, 01 Nov 2019 13:34:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F40AF2EDC;
        Fri,  1 Nov 2019 17:34:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95A685C28E;
        Fri,  1 Nov 2019 17:34:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 05/11] pipe: Allow pipes to have kernel-reserved slots
 [ver #3]
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
Date:   Fri, 01 Nov 2019 17:34:46 +0000
Message-ID: <157262968684.13142.910827322486465736.stgit@warthog.procyon.org.uk>
In-Reply-To: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
References: <157262963995.13142.5568934007158044624.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: p6rvO6F6NI2v9viUzMq_WQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split pipe->ring_size into two numbers:

 (1) pipe->ring_size - indicates the hard size of the pipe ring.

 (2) pipe->max_usage - indicates the maximum number of pipe ring slots that
     userspace orchestrated events can fill.

This allows for a pipe that is both writable by the general kernel
notification facility and by userspace, allowing plenty of ring space for
notifications to be added whilst preventing userspace from being able to
pin too much unswappable kernel space.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fuse/dev.c             |    8 ++++----
 fs/pipe.c                 |   10 ++++++----
 fs/splice.c               |   26 +++++++++++++-------------
 include/linux/pipe_fs_i.h |    6 +++++-
 lib/iov_iter.c            |    4 ++--
 5 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c56011f95a87..423b6c657bf0 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -703,7 +703,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 =09=09=09cs->pipebufs++;
 =09=09=09cs->nr_segs--;
 =09=09} else {
-=09=09=09if (cs->nr_segs >=3D cs->pipe->ring_size)
+=09=09=09if (cs->nr_segs >=3D cs->pipe->max_usage)
 =09=09=09=09return -EIO;
=20
 =09=09=09page =3D alloc_page(GFP_HIGHUSER);
@@ -879,7 +879,7 @@ static int fuse_ref_page(struct fuse_copy_state *cs, st=
ruct page *page,
 =09struct pipe_buffer *buf;
 =09int err;
=20
-=09if (cs->nr_segs >=3D cs->pipe->ring_size)
+=09if (cs->nr_segs >=3D cs->pipe->max_usage)
 =09=09return -EIO;
=20
 =09err =3D unlock_request(cs->req);
@@ -1341,7 +1341,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, =
loff_t *ppos,
 =09if (!fud)
 =09=09return -EPERM;
=20
-=09bufs =3D kvmalloc_array(pipe->ring_size, sizeof(struct pipe_buffer),
+=09bufs =3D kvmalloc_array(pipe->max_usage, sizeof(struct pipe_buffer),
 =09=09=09      GFP_KERNEL);
 =09if (!bufs)
 =09=09return -ENOMEM;
@@ -1353,7 +1353,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, =
loff_t *ppos,
 =09if (ret < 0)
 =09=09goto out;
=20
-=09if (pipe_occupancy(pipe->head, pipe->tail) + cs.nr_segs > pipe->ring_si=
ze) {
+=09if (pipe_occupancy(pipe->head, pipe->tail) + cs.nr_segs > pipe->max_usa=
ge) {
 =09=09ret =3D -EIO;
 =09=09goto out;
 =09}
diff --git a/fs/pipe.c b/fs/pipe.c
index e9b361cb093e..69afeab8a73a 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -404,7 +404,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
=20
 =09tail =3D pipe->tail;
 =09head =3D pipe->head;
-=09max_usage =3D pipe->ring_size;
+=09max_usage =3D pipe->max_usage;
 =09mask =3D pipe->ring_size - 1;
=20
 =09/* We try to merge small writes */
@@ -571,7 +571,7 @@ pipe_poll(struct file *filp, poll_table *wait)
 =09}
=20
 =09if (filp->f_mode & FMODE_WRITE) {
-=09=09if (!pipe_full(head, tail, pipe->ring_size))
+=09=09if (!pipe_full(head, tail, pipe->max_usage))
 =09=09=09mask |=3D EPOLLOUT | EPOLLWRNORM;
 =09=09/*
 =09=09 * Most Unices do not set EPOLLERR for FIFOs but on Linux they
@@ -696,6 +696,7 @@ struct pipe_inode_info *alloc_pipe_info(void)
 =09if (pipe->bufs) {
 =09=09init_waitqueue_head(&pipe->wait);
 =09=09pipe->r_counter =3D pipe->w_counter =3D 1;
+=09=09pipe->max_usage =3D pipe_bufs;
 =09=09pipe->ring_size =3D pipe_bufs;
 =09=09pipe->user =3D user;
 =09=09mutex_init(&pipe->mutex);
@@ -1150,9 +1151,10 @@ static long pipe_set_size(struct pipe_inode_info *pi=
pe, unsigned long arg)
 =09kfree(pipe->bufs);
 =09pipe->bufs =3D bufs;
 =09pipe->ring_size =3D nr_slots;
+=09pipe->max_usage =3D nr_slots;
 =09pipe->tail =3D tail;
 =09pipe->head =3D head;
-=09return pipe->ring_size * PAGE_SIZE;
+=09return pipe->max_usage * PAGE_SIZE;
=20
 out_revert_acct:
 =09(void) account_pipe_buffers(pipe->user, nr_slots, pipe->ring_size);
@@ -1185,7 +1187,7 @@ long pipe_fcntl(struct file *file, unsigned int cmd, =
unsigned long arg)
 =09=09ret =3D pipe_set_size(pipe, arg);
 =09=09break;
 =09case F_GETPIPE_SZ:
-=09=09ret =3D pipe->ring_size * PAGE_SIZE;
+=09=09ret =3D pipe->max_usage * PAGE_SIZE;
 =09=09break;
 =09default:
 =09=09ret =3D -EINVAL;
diff --git a/fs/splice.c b/fs/splice.c
index 22b0a47a35c0..c521090a0469 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -199,7 +199,7 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 =09=09goto out;
 =09}
=20
-=09while (!pipe_full(head, tail, pipe->ring_size)) {
+=09while (!pipe_full(head, tail, pipe->max_usage)) {
 =09=09struct pipe_buffer *buf =3D &pipe->bufs[head & mask];
=20
 =09=09buf->page =3D spd->pages[page_nr];
@@ -239,7 +239,7 @@ ssize_t add_to_pipe(struct pipe_inode_info *pipe, struc=
t pipe_buffer *buf)
 =09if (unlikely(!pipe->readers)) {
 =09=09send_sig(SIGPIPE, current, 0);
 =09=09ret =3D -EPIPE;
-=09} else if (pipe_full(head, tail, pipe->ring_size)) {
+=09} else if (pipe_full(head, tail, pipe->max_usage)) {
 =09=09ret =3D -EAGAIN;
 =09} else {
 =09=09pipe->bufs[head & mask] =3D *buf;
@@ -257,7 +257,7 @@ EXPORT_SYMBOL(add_to_pipe);
  */
 int splice_grow_spd(const struct pipe_inode_info *pipe, struct splice_pipe=
_desc *spd)
 {
-=09unsigned int max_usage =3D READ_ONCE(pipe->ring_size);
+=09unsigned int max_usage =3D READ_ONCE(pipe->max_usage);
=20
 =09spd->nr_pages_max =3D max_usage;
 =09if (max_usage <=3D PIPE_DEF_BUFFERS)
@@ -381,7 +381,7 @@ static ssize_t default_file_splice_read(struct file *in=
, loff_t *ppos,
 =09ssize_t res;
 =09int i;
=20
-=09if (pipe_full(pipe->head, pipe->tail, pipe->ring_size))
+=09if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
 =09=09return -EAGAIN;
=20
 =09/*
@@ -698,7 +698,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, st=
ruct file *out,
 =09=09.pos =3D *ppos,
 =09=09.u.file =3D out,
 =09};
-=09int nbufs =3D pipe->ring_size;
+=09int nbufs =3D pipe->max_usage;
 =09struct bio_vec *array =3D kcalloc(nbufs, sizeof(struct bio_vec),
 =09=09=09=09=09GFP_KERNEL);
 =09ssize_t ret;
@@ -721,9 +721,9 @@ iter_file_splice_write(struct pipe_inode_info *pipe, st=
ruct file *out,
 =09=09if (ret <=3D 0)
 =09=09=09break;
=20
-=09=09if (unlikely(nbufs < pipe->ring_size)) {
+=09=09if (unlikely(nbufs < pipe->max_usage)) {
 =09=09=09kfree(array);
-=09=09=09nbufs =3D pipe->ring_size;
+=09=09=09nbufs =3D pipe->max_usage;
 =09=09=09array =3D kcalloc(nbufs, sizeof(struct bio_vec),
 =09=09=09=09=09GFP_KERNEL);
 =09=09=09if (!array) {
@@ -963,7 +963,7 @@ ssize_t splice_direct_to_actor(struct file *in, struct =
splice_desc *sd,
 =09=09loff_t pos =3D sd->pos, prev_pos =3D pos;
=20
 =09=09/* Don't try to read more the pipe has space for. */
-=09=09p_space =3D pipe->ring_size -
+=09=09p_space =3D pipe->max_usage -
 =09=09=09pipe_occupancy(pipe->head, pipe->tail);
 =09=09read_len =3D min_t(size_t, len, p_space << PAGE_SHIFT);
 =09=09ret =3D do_splice_to(in, &pos, pipe, read_len, flags);
@@ -1090,7 +1090,7 @@ static int wait_for_space(struct pipe_inode_info *pip=
e, unsigned flags)
 =09=09=09send_sig(SIGPIPE, current, 0);
 =09=09=09return -EPIPE;
 =09=09}
-=09=09if (!pipe_full(pipe->head, pipe->tail, pipe->ring_size))
+=09=09if (!pipe_full(pipe->head, pipe->tail, pipe->max_usage))
 =09=09=09return 0;
 =09=09if (flags & SPLICE_F_NONBLOCK)
 =09=09=09return -EAGAIN;
@@ -1498,13 +1498,13 @@ static int opipe_prep(struct pipe_inode_info *pipe,=
 unsigned int flags)
 =09 * Check pipe occupancy without the inode lock first. This function
 =09 * is speculative anyways, so missing one is ok.
 =09 */
-=09if (pipe_full(pipe->head, pipe->tail, pipe->ring_size))
+=09if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
 =09=09return 0;
=20
 =09ret =3D 0;
 =09pipe_lock(pipe);
=20
-=09while (pipe_full(pipe->head, pipe->tail, pipe->ring_size)) {
+=09while (pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
 =09=09if (!pipe->readers) {
 =09=09=09send_sig(SIGPIPE, current, 0);
 =09=09=09ret =3D -EPIPE;
@@ -1584,7 +1584,7 @@ static int splice_pipe_to_pipe(struct pipe_inode_info=
 *ipipe,
 =09=09 * pipe is empty or the output pipe is full.
 =09=09 */
 =09=09if (pipe_empty(i_head, i_tail) ||
-=09=09    pipe_full(o_head, o_tail, opipe->ring_size)) {
+=09=09    pipe_full(o_head, o_tail, opipe->max_usage)) {
 =09=09=09/* Already processed some buffers, break */
 =09=09=09if (ret)
 =09=09=09=09break;
@@ -1706,7 +1706,7 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 =09=09 * output room, break.
 =09=09 */
 =09=09if (pipe_empty(i_head, i_tail) ||
-=09=09    pipe_full(o_head, o_tail, opipe->ring_size))
+=09=09    pipe_full(o_head, o_tail, opipe->max_usage))
 =09=09=09break;
=20
 =09=09ibuf =3D &ipipe->bufs[i_tail & i_mask];
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 96158ca80456..44f2245debda 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -32,6 +32,7 @@ struct pipe_buffer {
  *=09@wait: reader/writer wait point in case of empty/full pipe
  *=09@head: The point of buffer production
  *=09@tail: The point of buffer consumption
+ *=09@max_usage: The maximum number of slots that may be used in the ring
  *=09@ring_size: total number of buffers (should be a power of 2)
  *=09@tmp_page: cached released page
  *=09@readers: number of current readers of this pipe
@@ -50,6 +51,7 @@ struct pipe_inode_info {
 =09wait_queue_head_t wait;
 =09unsigned int head;
 =09unsigned int tail;
+=09unsigned int max_usage;
 =09unsigned int ring_size;
 =09unsigned int readers;
 =09unsigned int writers;
@@ -150,9 +152,11 @@ static inline unsigned int pipe_space_for_user(unsigne=
d int head, unsigned int t
 =09unsigned int p_occupancy, p_space;
=20
 =09p_occupancy =3D pipe_occupancy(head, tail);
-=09if (p_occupancy >=3D pipe->ring_size)
+=09if (p_occupancy >=3D pipe->max_usage)
 =09=09return 0;
 =09p_space =3D pipe->ring_size - p_occupancy;
+=09if (p_space > pipe->max_usage)
+=09=09p_space =3D pipe->max_usage;
 =09return p_space;
 }
=20
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6607e9c875ce..8225279b96e3 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -395,7 +395,7 @@ static size_t copy_page_to_iter_pipe(struct page *page,=
 size_t offset, size_t by
 =09=09i_head++;
 =09=09buf =3D &pipe->bufs[i_head & p_mask];
 =09}
-=09if (pipe_full(i_head, p_tail, pipe->ring_size))
+=09if (pipe_full(i_head, p_tail, pipe->max_usage))
 =09=09return 0;
=20
 =09buf->ops =3D &page_cache_pipe_buf_ops;
@@ -528,7 +528,7 @@ static size_t push_pipe(struct iov_iter *i, size_t size=
,
 =09=09pipe->bufs[iter_head & p_mask].len =3D PAGE_SIZE;
 =09=09iter_head++;
 =09}
-=09while (!pipe_full(iter_head, p_tail, pipe->ring_size)) {
+=09while (!pipe_full(iter_head, p_tail, pipe->max_usage)) {
 =09=09struct pipe_buffer *buf =3D &pipe->bufs[iter_head & p_mask];
 =09=09struct page *page =3D alloc_page(GFP_USER);
 =09=09if (!page)

