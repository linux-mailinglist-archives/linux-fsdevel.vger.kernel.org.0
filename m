Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27756D82E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 23:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbfJOVuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 17:50:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfJOVuS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:50:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7AEC73090FC3;
        Tue, 15 Oct 2019 21:50:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C23419C69;
        Tue, 15 Oct 2019 21:50:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 16/21] pipe: Add notification lossage handling
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
Date:   Tue, 15 Oct 2019 22:50:13 +0100
Message-ID: <157117621377.15019.972929561165477583.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 15 Oct 2019 21:50:17 +0000 (UTC)
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

 fs/pipe.c                        |   26 ++++++++++++++++++++++++++
 include/linux/pipe_fs_i.h        |    5 +++++
 kernel/watch_queue.c             |    2 ++
 samples/watch_queue/watch_test.c |    3 +++
 4 files changed, 36 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index f4c9d5480636..4685fa6d6c56 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -291,6 +291,30 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
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
 		if (tail != head) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
 			size_t chars = buf->len;
@@ -332,6 +356,8 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			if (!buf->len) {
 				pipe_buf_release(pipe, buf);
 				spin_lock_irq(&pipe->wait.lock);
+				if (buf->flags & PIPE_BUF_FLAG_LOSS)
+					pipe->note_loss = true;
 				tail++;
 				pipe_commit_read(pipe, tail);
 				do_wakeup = 1;
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 58583ba056e8..66822b39626e 100644
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
@@ -33,6 +36,7 @@ struct pipe_buffer {
  *	@wait: reader/writer wait point in case of empty/full pipe
  *	@head: The point of buffer production
  *	@tail: The point of buffer consumption
+ *	@note_loss: The next read() should insert a data-lost message
  *	@max_usage: The maximum number of slots that may be used in the ring
  *	@ring_size: total number of buffers (should be a power of 2)
  *	@nr_accounted: The amount this pipe accounts for in user->pipe_bufs
@@ -56,6 +60,7 @@ struct pipe_inode_info {
 	unsigned int tail;
 	unsigned int max_usage;
 	unsigned int ring_size;
+	bool note_loss;
 	unsigned int nr_accounted;
 	unsigned int readers;
 	unsigned int writers;
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index f1d78da5309d..c7a3d8cef378 100644
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
index 363f1d77386f..1ffed42bfece 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -121,6 +121,9 @@ static void consumer(int fd)
 					       (n.n.info & WATCH_INFO_ID) >>
 					       WATCH_INFO_ID__SHIFT);
 					break;
+				case WATCH_META_LOSS_NOTIFICATION:
+					printf("-- LOSS --\n");
+					break;
 				default:
 					printf("other meta record\n");
 					break;

