Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24C0630C02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 11:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfEaJsF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 05:48:05 -0400
Received: from mail.virtlab.unibo.it ([130.136.161.50]:42972 "EHLO
        mail.virtlab.unibo.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfEaJsE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 05:48:04 -0400
Received: from cs.unibo.it (host5.studiodavoli.it [109.234.61.227])
        by mail.virtlab.unibo.it (Postfix) with ESMTPSA id 33BAD1FF56;
        Fri, 31 May 2019 11:47:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
        s=virtlab; t=1559296079;
        bh=IIsxNivYCR+g1K+9Mx0YftEx/xgln4B+4vf5YV5BcXg=;
        h=Date:From:To:Cc:Subject:From;
        b=XvybcBMGV6ZawYPoxi6Z7EYDXyFItm4R71lgqQLS2V8LwfVv2cKkPJjvUBt6RPfLO
         R4t7iBEgY206HDcHXMO+hItUQr455SQOHq3XZkE8nv4rKHQJKE/7t52Pk4Z52Rekmz
         BNWRHeTtFstlSUVQQV48ocBvnHWmAbAaKcZewvo8=
Date:   Fri, 31 May 2019 11:47:56 +0200
From:   Renzo Davoli <renzo@cs.unibo.it>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org
Subject: [PATCH v3 1/1] eventfd new tag EFD_VPOLL: generate epoll events
Message-ID: <20190531094756.GD3661@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch implements an extension of eventfd (EFD_VPOLL) to define file descriptors
whose I/O events can be generated at user level. These file descriptors
trigger notifications for [p]select/[p]poll/epoll.

This feature is useful for user-level implementations of network stacks
or virtual device drivers as libraries.

Networking programs use system calls implementing the Berkeley sockets API:
socket, accept, connect, listen, recv*, send* etc.  Programs dealing with a
device use system calls like open, read, write, ioctl etc.

When somebody wants to write a library able to behave like a network stack (say
lwipv6, picotcp) or a device, they can implement functions like my_socket,
my_accept, my_open or my_ioctl, as drop-in replacement of their system
call counterpart.  (It is also possible to use dynamic library magic to
rename/divert the system call requests to use their 'virtual'
implementation provided by the library: socket maps to my_socket, recv
to my_recv etc).

In this way portability and compatibility is easier, using a well known API
instead of inventing new ones.

Unfortunately this approach cannot be applied to
poll/select/ppoll/pselect/epoll.  These system calls can refer at the same time
to file descriptors created by 'real' system calls like socket, open, signalfd...
and to file descriptors returned by my_open, your_socket.

While it is possible to provide a partial support (e.g. using pipes or
socketpairs), a clean and complete solution is still missing (as far as I
have seen); e.g. I have not seen any clean way to generate EPOLLPRI,
EPOLLERR, etc.

Example:
Let us suppose there is an application waiting for a TCP OOB message. It uses poll to wait
for POLLPRI and then reads the message (e.g. by 'recv').
If I want to port that application to use a network stack implemented as a library
I have to rewrite the code about 'poll' as it is not possible to receive a POLLPRI.
From a pipe I can just receive a POLLIN, I have to encode in an external data structure
any further information.
Using EFD_VPOLL the solution is straightforward: the function mysocket (used in place
of socket to create a file descripor behaving as a 'real'socket) returns a file
descriptor created by eventfd/EFD_VPOLL, so the poll system call can be left
unmodified in the code. When the OOB message is available the library can trigger
an EPOLLPRI and the message can be received using my_recv.

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

There can be other approaches than EFD_VPOLL: e.g. add two specific new system
calls like "vpollfd_create" and "vpollfd_ctl".
Their signature could be:
  int vpollfd_create(unsigned int init_events, int flags);
  where flags are the usual NONBLOCK/CLOEXEC
  int vpollfd_ctl(int fd, int op, unsigned int events);
  where op can be VPOLL_ADDEVENTS, VPOLL_DELEVENTS, VPOLL_MODEVENTS

It possible to reimplement the patch this way. It needs the definition of the new system calls.
I am proposing just a new tag for eventfd as eventfd purpose is conceptually close to the new feature.
Eventfd creates a file descriptor which generates events. The default eventfd mode uses counters while
EFD_VPOLL uses event flags.  The new feature can be implemented on eventfd with a very limited
impact on the kernel core code.
Instead of syscalls, the vpollfd_create/vpollfd_ctl API could be provided by the glibc as (very simple)
library functions, as it is the case for eventfd_read/eventfd_write in /usr/include/sys/eventfd.h

These are examples of messages asking for a feature like EFD_VPOLL:
https://stackoverflow.com/questions/909189/simulating-file-descriptor-in-user-space
https://stackoverflow.com/questions/1648147/running-a-simple-tcp-server-with-poll-how-do-i-trigger-events-artificially
... and I need it to write networking and device modules for vuos:
https://github.com/virtualsquare/vuos
(it is the new codebase of ViewOS, see www.virtualsquare.org).

EXAMPLE of program using EFD_VPOLL:
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
#define EFD_VPOLL_ADDEVENTS (1ULL << 32)
#define EFD_VPOLL_DELEVENTS (2ULL << 32)
#define EFD_VPOLL_MODEVENTS (3ULL << 32)
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
Reported-by: kbuild test robot <lkp@intel.com>

---
 fs/eventfd.c                   | 116 +++++++++++++++++++++++++++++++--
 include/linux/eventfd.h        |   7 +-
 include/uapi/linux/eventpoll.h |   2 +
 3 files changed, 117 insertions(+), 8 deletions(-)

Changes in v2:
 - Fix size of EFD_VPOLL_*EVENTS constants for 32 bit architectures

Changes in v3:
 - Fix sparse warnings and wrong arg of wake_up_locked_poll in eventfd_vpoll_write

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 8aa0ea8c55e8..6cdb1b854341 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -24,18 +24,32 @@
 #include <linux/seq_file.h>
 #include <linux/idr.h>
 
+#define EPOLLALLMASK64 ((__force __u64)EPOLLALLMASK)
+
 static DEFINE_IDA(eventfd_ida);
 
 struct eventfd_ctx {
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
@@ -295,6 +309,78 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
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
+	events = (((__force __poll_t)count) & EPOLLALLMASK);
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
+	events = ucnt & EPOLLALLMASK64;
+	res = sizeof(ucnt);
+	switch (ucnt & ~EPOLLALLMASK64) {
+	case EFD_VPOLL_ADDEVENTS:
+		ctx->count |= events;
+		break;
+	case EFD_VPOLL_DELEVENTS:
+		ctx->count &= ~(events);
+		break;
+	case EFD_VPOLL_MODEVENTS:
+		ctx->count = (ctx->count & ~EPOLLALLMASK64) | events;
+		break;
+	default:
+		res = -EINVAL;
+	}
+
+	/* wake up waiting threads */
+	if (res >= 0 && waitqueue_active(&ctx->wqh))
+		wake_up_locked_poll(&ctx->wqh, ((__force __poll_t)ctx->count) & EPOLLALLMASK);
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
@@ -319,6 +405,17 @@ static const struct file_operations eventfd_fops = {
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
@@ -391,6 +488,7 @@ EXPORT_SYMBOL_GPL(eventfd_ctx_fileget);
 static int do_eventfd(unsigned int count, int flags)
 {
 	struct eventfd_ctx *ctx;
+	const struct file_operations *fops = &eventfd_fops;
 	int fd;
 
 	/* Check the EFD_* constants for consistency.  */
@@ -410,7 +508,11 @@ static int do_eventfd(unsigned int count, int flags)
 	ctx->flags = flags;
 	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
 
-	fd = anon_inode_getfd("[eventfd]", &eventfd_fops, ctx,
+	if (flags & EFD_VPOLL) {
+		fops = &eventfd_vpoll_fops;
+		ctx->count &= EPOLLALLMASK64;
+	}
+	fd = anon_inode_getfd("[eventfd]", fops, ctx,
 			      O_RDWR | (flags & EFD_SHARED_FCNTL_FLAGS));
 	if (fd < 0)
 		eventfd_free_ctx(ctx);
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index ffcc7724ca21..5b1e6ef56651 100644
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
+#define EFD_VPOLL_ADDEVENTS (1ULL << 32)
+#define EFD_VPOLL_DELEVENTS (2ULL << 32)
+#define EFD_VPOLL_MODEVENTS (3ULL << 32)
 
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


diff --git a/fs/eventfd.c b/fs/eventfd.c
index 8aa0ea8c55e8..6cdb1b854341 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -24,18 +24,32 @@
 #include <linux/seq_file.h>
 #include <linux/idr.h>
 
+#define EPOLLALLMASK64 ((__force __u64)EPOLLALLMASK)
+
 static DEFINE_IDA(eventfd_ida);
 
 struct eventfd_ctx {
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
@@ -295,6 +309,78 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
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
+	events = (((__force __poll_t)count) & EPOLLALLMASK);
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
+	events = ucnt & EPOLLALLMASK64;
+	res = sizeof(ucnt);
+	switch (ucnt & ~EPOLLALLMASK64) {
+	case EFD_VPOLL_ADDEVENTS:
+		ctx->count |= events;
+		break;
+	case EFD_VPOLL_DELEVENTS:
+		ctx->count &= ~(events);
+		break;
+	case EFD_VPOLL_MODEVENTS:
+		ctx->count = (ctx->count & ~EPOLLALLMASK64) | events;
+		break;
+	default:
+		res = -EINVAL;
+	}
+
+	/* wake up waiting threads */
+	if (res >= 0 && waitqueue_active(&ctx->wqh))
+		wake_up_locked_poll(&ctx->wqh, ((__force __poll_t)ctx->count) & EPOLLALLMASK);
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
@@ -319,6 +405,17 @@ static const struct file_operations eventfd_fops = {
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
@@ -391,6 +488,7 @@ EXPORT_SYMBOL_GPL(eventfd_ctx_fileget);
 static int do_eventfd(unsigned int count, int flags)
 {
 	struct eventfd_ctx *ctx;
+	const struct file_operations *fops = &eventfd_fops;
 	int fd;
 
 	/* Check the EFD_* constants for consistency.  */
@@ -410,7 +508,11 @@ static int do_eventfd(unsigned int count, int flags)
 	ctx->flags = flags;
 	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
 
-	fd = anon_inode_getfd("[eventfd]", &eventfd_fops, ctx,
+	if (flags & EFD_VPOLL) {
+		fops = &eventfd_vpoll_fops;
+		ctx->count &= EPOLLALLMASK64;
+	}
+	fd = anon_inode_getfd("[eventfd]", fops, ctx,
 			      O_RDWR | (flags & EFD_SHARED_FCNTL_FLAGS));
 	if (fd < 0)
 		eventfd_free_ctx(ctx);
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index ffcc7724ca21..5b1e6ef56651 100644
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
+#define EFD_VPOLL_ADDEVENTS (1ULL << 32)
+#define EFD_VPOLL_DELEVENTS (2ULL << 32)
+#define EFD_VPOLL_MODEVENTS (3ULL << 32)
 
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

