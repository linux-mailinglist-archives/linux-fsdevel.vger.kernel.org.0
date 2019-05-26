Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99AA2AA4E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 16:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfEZOgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 10:36:38 -0400
Received: from mail.virtlab.unibo.it ([130.136.161.50]:56014 "EHLO
        mail.virtlab.unibo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfEZOgi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 10:36:38 -0400
X-Greylist: delayed 656 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 May 2019 10:36:35 EDT
Received: from cs.unibo.it (host0.studiodavoli.it [109.234.61.1])
        by mail.virtlab.unibo.it (Postfix) with ESMTPSA id 94DBE1FF56;
        Sun, 26 May 2019 16:25:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
        s=virtlab; t=1558880738;
        bh=C+N35ZzXj0U6TNHCXxgyJtcRMzkF1WAh1wwcXUynMic=;
        h=Date:From:To:Cc:Subject:From;
        b=BJaFV42a2QEk7d9YIb2049DqKUj1/iwlBGt2h5i/mPZ3mu/pVtQtvqIUsYItyK6vy
         iJWGaOI7DRpNhuxRIR3EEvyVP5wU4b5nRy+xzknCPLUtArlz+ReG3/UBNCSwwSXkQc
         HWhXZwyBjrnXd+NtEmBp4LroVv59xkDY0eYWjoco=
Date:   Sun, 26 May 2019 16:25:21 +0200
From:   Renzo Davoli <renzo@cs.unibo.it>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org
Subject: [PATCH 1/1] eventfd new tag EFD_VPOLL: generate epoll events
Message-ID: <20190526142521.GA21842@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch implements an extension of eventfd to define file descriptors 
whose I/O events can be generated at user level. These file descriptors
trigger notifications for [p]select/[p]poll/epoll.

This feature is useful for user-level implementations of network stacks
or virtual device drivers as libraries.

Development and porting of code often requires to find the way to wait for I/O
events both coming from file descriptors and generated by user-level code (e.g.
user-implemented net stacks or drivers).  While it is possible to provide a
partial support (e.g. using pipes or socketpairs), a clean and complete
solution is still missing (as far as I have seen); e.g. I have not seen any
clean way to generate EPOLLPRI, EPOLLERR, etc.

This proposal is based on a new tag for eventfd2(2): EFD_VPOLL.

This statement:
	fd = eventfd(EPOLLOUT, EFD_VPOLL | EFD_CLOEXEC);
creates a file descriptor for I/O event generation. In this case EPOLLOUT is
initially true.

Likewise all the other eventfs services, read(2) and write(2) use a 8-byte 
integer argument.

read(2) returns the current state of the pending events.

The argument of write(2) is an or-composition of a control command
(EFD_VPOLL_ADDEVENTS, EFD_VPOLL_DELEVENTS or EFD_VPOLL_MODEVENTS) and the
bitmap of events to be added, deleted to the current set of pending events.
EFD_VPOLL_MODEVENTS completely redefines the set of pending events.

e.g.:
	uint64_t request = EFD_VPOLL_ADDEVENTS | EPOLLIN | EPOLLPRI;
	write(fd, &request, sizeof(request);
adds EPOLLIN and EPOLLPRI to the set of pending events.

These are examples of messages asking for a feature like EFD_VPOLL:
https://stackoverflow.com/questions/909189/simulating-file-descriptor-in-user-space
https://stackoverflow.com/questions/1648147/running-a-simple-tcp-server-with-poll-how-do-i-trigger-events-artificially
... and I need it to write networking and device modules for vuos:
https://github.com/virtualsquare/vuos
(it is the new codebase of ViewOS, see www.virtualsquare.org).

EXAMPLE:
The following program creates an eventfd/EFD_VPOLL file descriptor and then forks
a child process.  While the parent waits for events using epoll_wait the child
generates a sequence of events. When the parent receives an event (or a set of events)
it prints it and disarm it.
The following shell session shows a sample run of the program:
	timeout...
	timeout...
	GOT event 1
	timeout...
	GOT event 1
	timeout...
	GOT event 3
	timeout...
	GOT event 2
	timeout...
	GOT event 4
	timeout...
	GOT event 10

Program source:
#include <sys/eventfd.h>
#include <sys/epoll.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>             /* Definition of uint64_t */

#ifndef EFD_VPOLL
#define EFD_VPOLL (1 << 1)
#define EFD_VPOLL_ADDEVENTS (1UL << 32)
#define EFD_VPOLL_DELEVENTS (2UL << 32)
#define EFD_VPOLL_MODEVENTS (3UL << 32)
#endif

#define handle_error(msg) \
	do { perror(msg); exit(EXIT_FAILURE); } while (0)

static void vpoll_ctl(int fd, uint64_t request) {
	ssize_t s;
	s = write(fd, &request, sizeof(request));
	if (s != sizeof(uint64_t))
		handle_error("write");
}

int
main(int argc, char *argv[])
{
	int efd, epollfd; 
	struct epoll_event ev;
	ev.events = EPOLLIN | EPOLLRDHUP | EPOLLERR | EPOLLOUT | EPOLLHUP | EPOLLPRI;
	ev.data.u64 = 0;

	efd = eventfd(0, EFD_VPOLL | EFD_CLOEXEC);
	if (efd == -1)
		handle_error("eventfd");
	epollfd = epoll_create1(EPOLL_CLOEXEC);
	if (efd == -1)
		handle_error("epoll_create1");
	if (epoll_ctl(epollfd, EPOLL_CTL_ADD, efd, &ev) == -1) 
		handle_error("epoll_ctl");

	switch (fork()) {
		case 0:
			sleep(3);
			vpoll_ctl(efd, EFD_VPOLL_ADDEVENTS | EPOLLIN);
			sleep(2);
			vpoll_ctl(efd, EFD_VPOLL_ADDEVENTS | EPOLLIN);
			sleep(2);
			vpoll_ctl(efd, EFD_VPOLL_ADDEVENTS | EPOLLIN | EPOLLPRI);
			sleep(2);
			vpoll_ctl(efd, EFD_VPOLL_ADDEVENTS | EPOLLPRI);
			sleep(2);
			vpoll_ctl(efd, EFD_VPOLL_ADDEVENTS | EPOLLOUT);
			sleep(2);
			vpoll_ctl(efd, EFD_VPOLL_ADDEVENTS | EPOLLHUP);
			exit(EXIT_SUCCESS);
		default:
			while (1) {
				int nfds;
				nfds = epoll_wait(epollfd, &ev, 1, 1000);
				if (nfds < 0)
					handle_error("epoll_wait");
				else if (nfds == 0)
					printf("timeout...\n");
				else {
					printf("GOT event %x\n", ev.events);
					vpoll_ctl(efd, EFD_VPOLL_DELEVENTS | ev.events);
					if (ev.events & EPOLLHUP)
						break;
				}
			}
		case -1:
			handle_error("fork");
	}
	close(epollfd);
	close(efd);
	return 0;
}

Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
---
 fs/eventfd.c                   | 115 +++++++++++++++++++++++++++++++--
 include/linux/eventfd.h        |   7 +-
 include/uapi/linux/eventpoll.h |   2 +
 3 files changed, 116 insertions(+), 8 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 8aa0ea8c55e8..f83b7d02307e 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -3,6 +3,7 @@
  *  fs/eventfd.c
  *
  *  Copyright (C) 2007  Davide Libenzi <davidel@xmailserver.org>
+ *  EFD_VPOLL support: 2019 Renzo Davoli <renzo@cs.unibo.it>
  *
  */
 
@@ -30,12 +31,24 @@ struct eventfd_ctx {
 	struct kref kref;
 	wait_queue_head_t wqh;
 	/*
-	 * Every time that a write(2) is performed on an eventfd, the
-	 * value of the __u64 being written is added to "count" and a
-	 * wakeup is performed on "wqh". A read(2) will return the "count"
-	 * value to userspace, and will reset "count" to zero. The kernel
-	 * side eventfd_signal() also, adds to the "count" counter and
-	 * issue a wakeup.
+	 * If the EFD_VPOLL flag was NOT set at eventfd creation:
+	 *   Every time that a write(2) is performed on an eventfd, the
+	 *   value of the __u64 being written is added to "count" and a
+	 *   wakeup is performed on "wqh". A read(2) will return the "count"
+	 *   value to userspace, and will reset "count" to zero (or decrement
+	 *   "count" by 1 if the flag EFD_SEMAPHORE has been set). The kernel
+	 *   side eventfd_signal() also, adds to the "count" counter and
+	 *   issue a wakeup.
+	 *
+	 * If the EFD_VPOLL flag was set at eventfd creation:
+	 *   count is the set of pending EPOLL events.
+	 *   read(2) returns the current value of count.
+	 *   The argument of write(2) is an 8-byte integer:
+	 *   it is an or-composition of a control command (EFD_VPOLL_ADDEVENTS,
+	 *   EFD_VPOLL_DELEVENTS or EFD_VPOLL_MODEVENTS) and the bitmap of
+	 *   events to be added, deleted to the current set of pending events.
+	 *   (i.e. which bits of "count" must be set or reset).
+	 *   EFD_VPOLL_MODEVENTS redefines the set of pending events.
 	 */
 	__u64 count;
 	unsigned int flags;
@@ -295,6 +308,78 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	return res;
 }
 
+static __poll_t eventfd_vpoll_poll(struct file *file, poll_table *wait)
+{
+	struct eventfd_ctx *ctx = file->private_data;
+	__poll_t events = 0;
+	u64 count;
+
+	poll_wait(file, &ctx->wqh, wait);
+
+	count = READ_ONCE(ctx->count);
+
+	events = (count & EPOLLALLMASK);
+
+	return events;
+}
+
+static ssize_t eventfd_vpoll_read(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct eventfd_ctx *ctx = file->private_data;
+	ssize_t res;
+	__u64 ucnt = 0;
+
+	if (count < sizeof(ucnt))
+		return -EINVAL;
+	res = sizeof(ucnt);
+	ucnt = READ_ONCE(ctx->count);
+	if (put_user(ucnt, (__u64 __user *)buf))
+		return -EFAULT;
+
+	return res;
+}
+
+static ssize_t eventfd_vpoll_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	struct eventfd_ctx *ctx = file->private_data;
+	ssize_t res;
+	__u64 ucnt;
+	__u32 events;
+
+	if (count < sizeof(ucnt))
+		return -EINVAL;
+	if (copy_from_user(&ucnt, buf, sizeof(ucnt)))
+		return -EFAULT;
+	spin_lock_irq(&ctx->wqh.lock);
+
+	events = ucnt & EPOLLALLMASK;
+	res = sizeof(ucnt);
+	switch (ucnt & ~((__u64)EPOLLALLMASK)) {
+	case EFD_VPOLL_ADDEVENTS:
+		ctx->count |= events;
+		break;
+	case EFD_VPOLL_DELEVENTS:
+		ctx->count &= ~(events);
+		break;
+	case EFD_VPOLL_MODEVENTS:
+		ctx->count = (ctx->count & ~EPOLLALLMASK) | events;
+		break;
+	default:
+		res = -EINVAL;
+	}
+
+	/* wake up waiting threads */
+	if (res >= 0 && waitqueue_active(&ctx->wqh))
+		wake_up_locked_poll(&ctx->wqh, res);
+
+	spin_unlock_irq(&ctx->wqh.lock);
+
+	return res;
+
+}
+
 #ifdef CONFIG_PROC_FS
 static void eventfd_show_fdinfo(struct seq_file *m, struct file *f)
 {
@@ -319,6 +404,17 @@ static const struct file_operations eventfd_fops = {
 	.llseek		= noop_llseek,
 };
 
+static const struct file_operations eventfd_vpoll_fops = {
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo	= eventfd_show_fdinfo,
+#endif
+	.release	= eventfd_release,
+	.poll		= eventfd_vpoll_poll,
+	.read		= eventfd_vpoll_read,
+	.write		= eventfd_vpoll_write,
+	.llseek		= noop_llseek,
+};
+
 /**
  * eventfd_fget - Acquire a reference of an eventfd file descriptor.
  * @fd: [in] Eventfd file descriptor.
@@ -391,6 +487,7 @@ EXPORT_SYMBOL_GPL(eventfd_ctx_fileget);
 static int do_eventfd(unsigned int count, int flags)
 {
 	struct eventfd_ctx *ctx;
+	const struct file_operations *fops = &eventfd_fops;
 	int fd;
 
 	/* Check the EFD_* constants for consistency.  */
@@ -410,7 +507,11 @@ static int do_eventfd(unsigned int count, int flags)
 	ctx->flags = flags;
 	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
 
-	fd = anon_inode_getfd("[eventfd]", &eventfd_fops, ctx,
+	if (flags & EFD_VPOLL) {
+		fops = &eventfd_vpoll_fops;
+		ctx->count &= EPOLLALLMASK;
+	}
+	fd = anon_inode_getfd("[eventfd]", fops, ctx,
 			      O_RDWR | (flags & EFD_SHARED_FCNTL_FLAGS));
 	if (fd < 0)
 		eventfd_free_ctx(ctx);
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index ffcc7724ca21..63258cf29344 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -21,11 +21,16 @@
  * shared O_* flags.
  */
 #define EFD_SEMAPHORE (1 << 0)
+#define EFD_VPOLL (1 << 1)
 #define EFD_CLOEXEC O_CLOEXEC
 #define EFD_NONBLOCK O_NONBLOCK
 
 #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
-#define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
+#define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE | EFD_VPOLL)
+
+#define EFD_VPOLL_ADDEVENTS (1UL << 32)
+#define EFD_VPOLL_DELEVENTS (2UL << 32)
+#define EFD_VPOLL_MODEVENTS (3UL << 32)
 
 struct eventfd_ctx;
 struct file;
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index 8a3432d0f0dc..814de6d869c7 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -41,6 +41,8 @@
 #define EPOLLMSG	(__force __poll_t)0x00000400
 #define EPOLLRDHUP	(__force __poll_t)0x00002000
 
+#define EPOLLALLMASK	((__force __poll_t)0x0fffffff)
+
 /* Set exclusive wakeup mode for the target file descriptor */
 #define EPOLLEXCLUSIVE	((__force __poll_t)(1U << 28))
 
-- 
2.20.1

