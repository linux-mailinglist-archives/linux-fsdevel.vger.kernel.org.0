Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 385BFE2469
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 22:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407453AbfJWUS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 16:18:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54318 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407447AbfJWUS2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571861907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mwljw2NG5FNU7TKvMqy9lThobSeo2IGdh0QPYxJP5hQ=;
        b=Y9wbyAv//0PYLRmhz/hionO8k7Q+tsCc+a3hvKkowncxmsxX1RCjaJEFgmoqz0Avc+WJrL
        l6coyN+mRImOJc747HTnUPVyYnQxPhPfOTpSiPAf/St9vSpnuWdBJgjF/CSgQY47DMtjo8
        NwiGy3QSX0f4hqiU62oV/Za4BTjV2vM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-hYpi1Gq-PSWpwHxFAVr66A-1; Wed, 23 Oct 2019 16:18:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6C44100551A;
        Wed, 23 Oct 2019 20:18:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-40.rdu2.redhat.com [10.10.121.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 202516012D;
        Wed, 23 Oct 2019 20:18:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 08/10] pipe: Rearrange sequence in pipe_write() to
 preallocate slot [ver #2]
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
Date:   Wed, 23 Oct 2019 21:18:19 +0100
Message-ID: <157186189940.3995.3273332042636743290.stgit@warthog.procyon.org.uk>
In-Reply-To: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: hYpi1Gq-PSWpwHxFAVr66A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rearrange the sequence in pipe_write() so that the allocation of the new
buffer, the allocation of a ring slot and the attachment to the ring is
done under the pipe wait spinlock and then the lock is dropped and the
buffer can be filled.

The data copy needs to be done with the spinlock unheld and irqs enabled,
so the lock needs to be dropped first.  However, the reader can't progress
as we're holding pipe->mutex.

We also need to drop the lock as that would impact others looking at the
pipe waitqueue, such as poll(), the consumer and a future kernel message
writer.

We just abandon the preallocated slot if we get a copy error.  Future
writes may continue it and a future read will eventually recycle it.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c |   51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index e3a8f10750c9..1bfad2212b95 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -386,7 +386,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 {
 =09struct file *filp =3D iocb->ki_filp;
 =09struct pipe_inode_info *pipe =3D filp->private_data;
-=09unsigned int head, tail, max_usage, mask;
+=09unsigned int head, max_usage, mask;
 =09ssize_t ret =3D 0;
 =09int do_wakeup =3D 0;
 =09size_t total_len =3D iov_iter_count(from);
@@ -404,14 +404,13 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 =09=09goto out;
 =09}
=20
-=09tail =3D pipe->tail;
 =09head =3D pipe->head;
 =09max_usage =3D pipe->max_usage;
 =09mask =3D pipe->ring_size - 1;
=20
 =09/* We try to merge small writes */
 =09chars =3D total_len & (PAGE_SIZE-1); /* size of the last buffer */
-=09if (!pipe_empty(head, tail) && chars !=3D 0) {
+=09if (!pipe_empty(head, pipe->tail) && chars !=3D 0) {
 =09=09struct pipe_buffer *buf =3D &pipe->bufs[(head - 1) & mask];
 =09=09int offset =3D buf->offset + buf->len;
=20
@@ -440,8 +439,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 =09=09=09break;
 =09=09}
=20
-=09=09tail =3D pipe->tail;
-=09=09if (!pipe_full(head, tail, max_usage)) {
+=09=09head =3D pipe->head;
+=09=09if (!pipe_full(head, pipe->tail, max_usage)) {
 =09=09=09struct pipe_buffer *buf =3D &pipe->bufs[head & mask];
 =09=09=09struct page *page =3D pipe->tmp_page;
 =09=09=09int copied;
@@ -454,40 +453,56 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 =09=09=09=09}
 =09=09=09=09pipe->tmp_page =3D page;
 =09=09=09}
+
+=09=09=09/* Allocate a slot in the ring in advance and attach an
+=09=09=09 * empty buffer.  If we fault or otherwise fail to use
+=09=09=09 * it, either the reader will consume it or it'll still
+=09=09=09 * be there for the next write.
+=09=09=09 */
+=09=09=09spin_lock_irq(&pipe->wait.lock);
+
+=09=09=09head =3D pipe->head;
+=09=09=09pipe_commit_write(pipe, head + 1);
+
 =09=09=09/* Always wake up, even if the copy fails. Otherwise
 =09=09=09 * we lock up (O_NONBLOCK-)readers that sleep due to
 =09=09=09 * syscall merging.
 =09=09=09 * FIXME! Is this really true?
 =09=09=09 */
-=09=09=09do_wakeup =3D 1;
-=09=09=09copied =3D copy_page_from_iter(page, 0, PAGE_SIZE, from);
-=09=09=09if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {
-=09=09=09=09if (!ret)
-=09=09=09=09=09ret =3D -EFAULT;
-=09=09=09=09break;
-=09=09=09}
-=09=09=09ret +=3D copied;
+=09=09=09wake_up_interruptible_sync_poll_locked(
+=09=09=09=09&pipe->wait, EPOLLIN | EPOLLRDNORM);
+
+=09=09=09spin_unlock_irq(&pipe->wait.lock);
+=09=09=09kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
=20
 =09=09=09/* Insert it into the buffer array */
+=09=09=09buf =3D &pipe->bufs[head & mask];
 =09=09=09buf->page =3D page;
 =09=09=09buf->ops =3D &anon_pipe_buf_ops;
 =09=09=09buf->offset =3D 0;
-=09=09=09buf->len =3D copied;
+=09=09=09buf->len =3D 0;
 =09=09=09buf->flags =3D 0;
 =09=09=09if (is_packetized(filp)) {
 =09=09=09=09buf->ops =3D &packet_pipe_buf_ops;
 =09=09=09=09buf->flags =3D PIPE_BUF_FLAG_PACKET;
 =09=09=09}
-
-=09=09=09head++;
-=09=09=09pipe_commit_write(pipe, head);
 =09=09=09pipe->tmp_page =3D NULL;
=20
+=09=09=09copied =3D copy_page_from_iter(page, 0, PAGE_SIZE, from);
+=09=09=09if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {
+=09=09=09=09if (!ret)
+=09=09=09=09=09ret =3D -EFAULT;
+=09=09=09=09break;
+=09=09=09}
+=09=09=09ret +=3D copied;
+=09=09=09buf->offset =3D 0;
+=09=09=09buf->len =3D copied;
+
 =09=09=09if (!iov_iter_count(from))
 =09=09=09=09break;
 =09=09}
=20
-=09=09if (!pipe_full(head, tail, max_usage))
+=09=09if (!pipe_full(head, pipe->tail, max_usage))
 =09=09=09continue;
=20
 =09=09/* Wait for buffer space to become available. */

