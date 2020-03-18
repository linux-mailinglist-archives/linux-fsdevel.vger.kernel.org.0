Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD46189ECF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 16:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgCRPEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 11:04:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24584 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726872AbgCRPEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584543886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dmGi/WSMBwzcH1Ul/RzDUyM8ryZZb4CgDwOvasNmXQw=;
        b=AjeAWwt0l8f9KTeymu0omSif6IH8IVHxsacZyqyGA8KnI/Is0P/jNxnNGNnNY92cDVEJQO
        N2Zgl0VTZLlSrg62MUWSRAhdsAvcNL9+aFR8Bicx0QqlwDJmKxBL7DPhpOlyfTmAZFj14w
        0IE5igU1RLwf3ocR1uk1SyuDmrE2RkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-PDbPO3HyMbaOixgTPyqiiQ-1; Wed, 18 Mar 2020 11:04:43 -0400
X-MC-Unique: PDbPO3HyMbaOixgTPyqiiQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17E78477;
        Wed, 18 Mar 2020 15:04:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A02F5C1D8;
        Wed, 18 Mar 2020 15:04:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/17] pipe: Add notification lossage handling [ver #5]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, casey@schaufler-ca.com, sds@tycho.nsa.gov,
        nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io,
        andres@anarazel.de, jlayton@redhat.com, dray@redhat.com,
        kzak@redhat.com, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Mar 2020 15:04:34 +0000
Message-ID: <158454387473.2863966.17743293093883875696.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add handling for loss of notifications by having read() insert a
loss-notification message after it has read the pipe buffer that was last
in the ring when the loss occurred.

Lossage can come about either by running out of notification descriptors or
by running out of space in the pipe ring.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pipe.c                        |   28 ++++++++++++++++++++++++++++
 include/linux/pipe_fs_i.h        |    7 +++++++
 kernel/watch_queue.c             |    2 ++
 samples/watch_queue/watch_test.c |    3 +++
 4 files changed, 40 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index 79cb0b5d83e1..deeab6c051a0 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -314,6 +314,30 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		unsigned int tail = pipe->tail;
 		unsigned int mask = pipe->ring_size - 1;
 
+#ifdef CONFIG_WATCH_QUEUE
+		if (pipe->note_loss) {
+			struct watch_notification n;
+
+			if (total_len < 8) {
+				if (ret == 0)
+					ret = -ENOBUFS;
+				break;
+			}
+
+			n.type = WATCH_TYPE_META;
+			n.subtype = WATCH_META_LOSS_NOTIFICATION;
+			n.info = watch_sizeof(n);
+			if (copy_to_iter(&n, sizeof(n), to) != sizeof(n)) {
+				if (ret == 0)
+					ret = -EFAULT;
+				break;
+			}
+			ret += sizeof(n);
+			total_len -= sizeof(n);
+			pipe->note_loss = false;
+		}
+#endif
+
 		if (!pipe_empty(head, tail)) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
 			size_t chars = buf->len;
@@ -355,6 +379,10 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			if (!buf->len) {
 				pipe_buf_release(pipe, buf);
 				spin_lock_irq(&pipe->rd_wait.lock);
+#ifdef CONFIG_WATCH_QUEUE
+				if (buf->flags & PIPE_BUF_FLAG_LOSS)
+					pipe->note_loss = true;
+#endif
 				tail++;
 				pipe->tail = tail;
 				spin_unlock_irq(&pipe->rd_wait.lock);
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index eaff59a2f074..6626f511de6f 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -9,6 +9,9 @@
 #define PIPE_BUF_FLAG_GIFT	0x04	/* page is a gift */
 #define PIPE_BUF_FLAG_PACKET	0x08	/* read() as a packet */
 #define PIPE_BUF_FLAG_WHOLE	0x10	/* read() must return entire buffer or error */
+#ifdef CONFIG_WATCH_QUEUE
+#define PIPE_BUF_FLAG_LOSS	0x20	/* Message loss happened after this buffer */
+#endif
 
 /**
  *	struct pipe_buffer - a linux kernel pipe buffer
@@ -34,6 +37,7 @@ struct pipe_buffer {
  *	@wr_wait: writer wait point in case of full pipe
  *	@head: The point of buffer production
  *	@tail: The point of buffer consumption
+ *	@note_loss: The next read() should insert a data-lost message
  *	@max_usage: The maximum number of slots that may be used in the ring
  *	@ring_size: total number of buffers (should be a power of 2)
  *	@nr_accounted: The amount this pipe accounts for in user->pipe_bufs
@@ -56,6 +60,9 @@ struct pipe_inode_info {
 	unsigned int tail;
 	unsigned int max_usage;
 	unsigned int ring_size;
+#ifdef CONFIG_WATCH_QUEUE
+	bool note_loss;
+#endif
 	unsigned int nr_accounted;
 	unsigned int readers;
 	unsigned int writers;
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index ad64ea300f6d..9a9699c06709 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -132,6 +132,8 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	return done;
 
 lost:
+	buf = &pipe->bufs[(head - 1) & mask];
+	buf->flags |= PIPE_BUF_FLAG_LOSS;
 	goto out;
 }
 
diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
index 8628b4c5d567..46e618a897fe 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -120,6 +120,9 @@ static void consumer(int fd)
 					       (n.n.info & WATCH_INFO_ID) >>
 					       WATCH_INFO_ID__SHIFT);
 					break;
+				case WATCH_META_LOSS_NOTIFICATION:
+					printf("-- LOSS --\n");
+					break;
 				default:
 					printf("other meta record\n");
 					break;


