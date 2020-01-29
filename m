Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95DC914CF88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 18:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgA2RUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 12:20:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29234 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726906AbgA2RUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580318440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CDEy69IL/eMYtpmDS3XjUwKwXrl7W0ck1hqzenez+2c=;
        b=B8DOQEUqgE5NJfzMXVxHnolU/rS3ZnL1ATmNfO9WlsTmzTKWO3xVsTyfli63O9QxtHLH89
        4ixSxcToLxnNHd79HUDcugyczPI48qMJwq4i6MybsV6PqgZavvBp2r/E1+g5T8z8Hnoc82
        A/imV/6Hbj31cceSDuE13TP9kzaz4Ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-IuDla0bKOH2KmPPH79RJLw-1; Wed, 29 Jan 2020 12:20:20 -0500
X-MC-Unique: IuDla0bKOH2KmPPH79RJLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46763477;
        Wed, 29 Jan 2020 17:20:19 +0000 (UTC)
Received: from localhost (ovpn-117-180.ams2.redhat.com [10.36.117.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7B5F5DE53;
        Wed, 29 Jan 2020 17:20:11 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avi Kivity <avi@scylladb.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC] eventfd: add EFD_AUTORESET flag
Date:   Wed, 29 Jan 2020 17:20:10 +0000
Message-Id: <20200129172010.162215-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some applications simply use eventfd for inter-thread notifications
without requiring counter or semaphore semantics.  They wait for the
eventfd to become readable using poll(2)/select(2) and then call read(2)
to reset the counter.

This patch adds the EFD_AUTORESET flag to reset the counter when
f_ops->poll() finds the eventfd is readable, eliminating the need to
call read(2) to reset the counter.

This results in a small but measurable 1% performance improvement with
QEMU virtio-blk emulation.  Each read(2) takes 1 microsecond execution
time in the event loop according to perf.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Does this look like a reasonable thing to do?  I'm not very familiar
with f_ops->poll() or the eventfd internals, so maybe I'm overlooking a
design flaw.

I've tested this with QEMU and it works fine:
https://github.com/stefanha/qemu/commits/eventfd-autoreset
---
 fs/eventfd.c            | 99 +++++++++++++++++++++++++----------------
 include/linux/eventfd.h |  3 +-
 2 files changed, 62 insertions(+), 40 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 8aa0ea8c55e8..208f6b9e2234 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -116,45 +116,62 @@ static __poll_t eventfd_poll(struct file *file, pol=
l_table *wait)
=20
 	poll_wait(file, &ctx->wqh, wait);
=20
-	/*
-	 * All writes to ctx->count occur within ctx->wqh.lock.  This read
-	 * can be done outside ctx->wqh.lock because we know that poll_wait
-	 * takes that lock (through add_wait_queue) if our caller will sleep.
-	 *
-	 * The read _can_ therefore seep into add_wait_queue's critical
-	 * section, but cannot move above it!  add_wait_queue's spin_lock acts
-	 * as an acquire barrier and ensures that the read be ordered properly
-	 * against the writes.  The following CAN happen and is safe:
-	 *
-	 *     poll                               write
-	 *     -----------------                  ------------
-	 *     lock ctx->wqh.lock (in poll_wait)
-	 *     count =3D ctx->count
-	 *     __add_wait_queue
-	 *     unlock ctx->wqh.lock
-	 *                                        lock ctx->qwh.lock
-	 *                                        ctx->count +=3D n
-	 *                                        if (waitqueue_active)
-	 *                                          wake_up_locked_poll
-	 *                                        unlock ctx->qwh.lock
-	 *     eventfd_poll returns 0
-	 *
-	 * but the following, which would miss a wakeup, cannot happen:
-	 *
-	 *     poll                               write
-	 *     -----------------                  ------------
-	 *     count =3D ctx->count (INVALID!)
-	 *                                        lock ctx->qwh.lock
-	 *                                        ctx->count +=3D n
-	 *                                        **waitqueue_active is false**
-	 *                                        **no wake_up_locked_poll!**
-	 *                                        unlock ctx->qwh.lock
-	 *     lock ctx->wqh.lock (in poll_wait)
-	 *     __add_wait_queue
-	 *     unlock ctx->wqh.lock
-	 *     eventfd_poll returns 0
-	 */
-	count =3D READ_ONCE(ctx->count);
+	if (ctx->flags & EFD_AUTORESET) {
+		unsigned long flags;
+		__poll_t requested =3D poll_requested_events(wait);
+
+		spin_lock_irqsave(&ctx->wqh.lock, flags);
+		count =3D ctx->count;
+
+		/* Reset counter if caller is polling for read */
+		if (count !=3D 0 && (requested & EPOLLIN)) {
+			ctx->count =3D 0;
+			events |=3D EPOLLOUT;
+			/* TODO is a EPOLLOUT wakeup necessary here? */
+		}
+
+		spin_unlock_irqrestore(&ctx->wqh.lock, flags);
+	} else {
+		/*
+		 * All writes to ctx->count occur within ctx->wqh.lock.  This read
+		 * can be done outside ctx->wqh.lock because we know that poll_wait
+		 * takes that lock (through add_wait_queue) if our caller will sleep.
+		 *
+		 * The read _can_ therefore seep into add_wait_queue's critical
+		 * section, but cannot move above it!  add_wait_queue's spin_lock acts
+		 * as an acquire barrier and ensures that the read be ordered properly
+		 * against the writes.  The following CAN happen and is safe:
+		 *
+		 *     poll                               write
+		 *     -----------------                  ------------
+		 *     lock ctx->wqh.lock (in poll_wait)
+		 *     count =3D ctx->count
+		 *     __add_wait_queue
+		 *     unlock ctx->wqh.lock
+		 *                                        lock ctx->qwh.lock
+		 *                                        ctx->count +=3D n
+		 *                                        if (waitqueue_active)
+		 *                                          wake_up_locked_poll
+		 *                                        unlock ctx->qwh.lock
+		 *     eventfd_poll returns 0
+		 *
+		 * but the following, which would miss a wakeup, cannot happen:
+		 *
+		 *     poll                               write
+		 *     -----------------                  ------------
+		 *     count =3D ctx->count (INVALID!)
+		 *                                        lock ctx->qwh.lock
+		 *                                        ctx->count +=3D n
+		 *                                        **waitqueue_active is false*=
*
+		 *                                        **no wake_up_locked_poll!**
+		 *                                        unlock ctx->qwh.lock
+		 *     lock ctx->wqh.lock (in poll_wait)
+		 *     __add_wait_queue
+		 *     unlock ctx->wqh.lock
+		 *     eventfd_poll returns 0
+		 */
+		count =3D READ_ONCE(ctx->count);
+	}
=20
 	if (count > 0)
 		events |=3D EPOLLIN;
@@ -400,6 +417,10 @@ static int do_eventfd(unsigned int count, int flags)
 	if (flags & ~EFD_FLAGS_SET)
 		return -EINVAL;
=20
+	/* Semaphore semantics don't make sense when autoreset is enabled */
+	if ((flags & EFD_SEMAPHORE) && (flags & EFD_AUTORESET))
+		return -EINVAL;
+
 	ctx =3D kmalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index ffcc7724ca21..27577fafc553 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -21,11 +21,12 @@
  * shared O_* flags.
  */
 #define EFD_SEMAPHORE (1 << 0)
+#define EFD_AUTORESET (1 << 6) /* aliases O_CREAT */
 #define EFD_CLOEXEC O_CLOEXEC
 #define EFD_NONBLOCK O_NONBLOCK
=20
 #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
-#define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
+#define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE | EFD_AUTO=
RESET)
=20
 struct eventfd_ctx;
 struct file;
--=20
2.24.1

