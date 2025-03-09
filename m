Return-Path: <linux-fsdevel+bounces-43538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67185A580E2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 06:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041E77A2624
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 05:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32FA13C908;
	Sun,  9 Mar 2025 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tvZ6mTkF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D07E1
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Mar 2025 05:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741499441; cv=none; b=cV9U9MB+t5fikvo+20MeEAVsN2KfUKowIh0ssp9l8uj4Um/0RVYrLoW2eTkXh/FyNKRrYw3f4OAoX/f4MqkIqQ4ZRHr8afRyEes9t+EvErWFefJJH4Yw/CScTgG4W0VRAXryoIKAXkhSki+ssMXJ67ZmKNqBj6JJxu7R7cdtX4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741499441; c=relaxed/simple;
	bh=1lY5nIB2MgyHuOjA2d63l4+aiCpFm/bmOgp7kpNGmcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TZUWsERp+RypfuHmT4jKabZr2bjPI3q/LczQ6izww+YbaMD87bAMXscyiioHnF+TPUeJePQ4k/qNmfxe6KdT4NzXGnPW+wkNHRB4+oJP30LwlTfgEIgTeWcSlv2r+9TeSsbo7v8PoGUrwGpi88cR9MP2vlCFwBN6K8U6qyDrSKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tvZ6mTkF; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741499425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WPTHGH5cc2nw0Xi+BBFhxPbBypT69Y37X694zXELdgc=;
	b=tvZ6mTkFZ+aU2f2K3I+FdHOrtDUkFZ1LZDs8lsnYbQPGmjgG2cgSFyQzykUiBfx+SdGD/j
	4rLcmGIvyLvmq2k0J0trZQNR8SynLjcxrmSIYOisLUvh/MhMBxjPs3xZTtTh+KUdfld9Js
	ac81LbNQLWfwtrSCJi88hJVjZS2lo4k=
From: Wen Yang <wen.yang@linux.dev>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Wen Yang <wen.yang@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Dylan Yudaken <dylany@fb.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] eventfd: introduce configurable maximum value for eventfd
Date: Sun,  9 Mar 2025 13:50:03 +0800
Message-Id: <20250309055003.32194-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

For the NON-SEMAPHORE eventfd, a write (2) call adds the 8-byte integer
value provided in its buffer to the counter, while a read (2) returns the
8-byte value containing the value and resetting the counter value to 0.
Therefore, the accumulated value of multiple writes can be retrieved by a
single read.

Currently, the reading thread is waked up immediately after the writing
thread writes eventfd, and the maximum value of the counter is ULLONG_MAX,
therefore, in the ping pong scene with frequent reading and writing,
the CPU will be exhausted.

By introducing the configurable maximum counter, we could achieve flow
control and reduce unnecessary CPU overhead.

We may use the following test code:
	#define _GNU_SOURCE
	#include <assert.h>
	#include <errno.h>
	#include <getopt.h>
	#include <pthread.h>
	#include <poll.h>
	#include <stdlib.h>
	#include <stdio.h>
	#include <unistd.h>
	#include <string.h>
	#include <sys/eventfd.h>
	#include <sys/prctl.h>
	#include <sys/ioctl.h>

	#define EFD_IOC_SET_MAXIMUM     _IOW('E', 0, __u64)
	#define EFD_IOC_GET_MAXIMUM     _IOR('E', 0, __u64)

	struct param {
		int fd;
		int cpu;
	};

	static void publish(void *data)
	{
		struct param * param = (struct param *)data;
		unsigned long long value = 1;
		cpu_set_t cpuset;

		prctl(PR_SET_NAME, "publish");
		CPU_ZERO(&cpuset);
		CPU_SET(param->cpu, &cpuset);
		sched_setaffinity(0, sizeof(cpuset), &cpuset);

		while (1)
			eventfd_write(param->fd, value);
	}

	static void subscribe(void *data)
	{
		struct param *param = (struct param *)data;
		unsigned long long value = 0;
		struct pollfd pfds[1];
		cpu_set_t cpuset;

		prctl(PR_SET_NAME, "subscribe");
		CPU_ZERO(&cpuset);
		CPU_SET(param->cpu, &cpuset);
		sched_setaffinity(0, sizeof(cpuset), &cpuset);

		pfds[0].fd = param->fd;
		pfds[0].events = POLLIN;

		while(1) {
			poll(pfds, 1, -1);
			if(pfds[0].revents & POLLIN) {
				read(param->fd, &value, sizeof(value));
			}
		}
	}

	static void usage(void)
	{
		printf("Usage: \n");
		printf("\t");
		printf("<-p cpuid> <-s cpuid> <-m maximum> \n");
	}

	int main(int argc, char *argv[])
	{
		struct param sub_param = {0};
		struct param pub_param = {0};
		char *optstr = "p:s:m:";
		int opt, ret, fd;
		__u64 maximum;
		pid_t pid;

		if (argc < 2) {
			usage();
			return 1;
		}

		while((opt = getopt(argc, argv, optstr)) != -1){
			switch(opt) {
				case 'p':
					pub_param.cpu = atoi(optarg);
					break;
				case 's':
					sub_param.cpu = atoi(optarg);
					break;
				case 'm':
					maximum = atoi(optarg);
					break;
				case '?':
					usage();
					return -1;
			}
		}

		fd = eventfd(0, EFD_CLOEXEC);
		assert(fd);

		ret = ioctl(fd, EFD_IOC_SET_MAXIMUM, &maximum);
		if (ret) {
			printf("error=%s\n", strerror(errno));
			return -1;
		}

		sub_param.fd = fd;
		pub_param.fd = fd;

		pid = fork();
		if (pid == 0)
			subscribe(&sub_param);
		else if (pid > 0)
			publish(&pub_param);
		else {
			printf("XXX: fork error!\n");
			return -1;
		}

		return 0;
	}

$ ./a.out  -p 2 -s 3 -m 6553500
-----cpu2-usage----------cpu3-usage----
usr sys idl wai stl:usr sys idl wai stl
 47  53   0   0   0: 46  54   0   0   0
 53  47   0   0   0: 45  54   1   0   0
 56  44   0   0   0: 48  52   0   0   0
 53  47   0   0   0: 45  55   0   0   0

$ ./a.out  -p 2 -s 3 -m 100
-----cpu2-usage----------cpu3-usage----
usr sys idl wai stl:usr sys idl wai stl
 41  59   0   0   0: 33  65   2   0   0
 46  54   0   0   0: 30  67   2   0   0
 38  62   0   0   0: 33  65   2   0   0
 37  63   0   0   0: 31  66   3   0   0

$ ./a.out  -p 2 -s 3 -m 10
-----cpu2-usage----------cpu3-usage----
usr sys idl wai stl:usr sys idl wai stl
 37  43  20   0   0: 21  42  37   0   0
 30  47  23   0   0: 20  42  38   0   0
 39  39  23   0   0: 24  37  39   0   0
 39  40  22   0   0: 23  41  36   0   0

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Dylan Yudaken <dylany@fb.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
v3: simply achieve flow control by configuring the maximum value of counter
v2: fix compilation errors 
https://lore.kernel.org/all/20240811085954.17162-1-wen.yang@linux.dev/
v1: https://lore.kernel.org/all/20240519144124.4429-1-wen.yang@linux.dev/

 fs/eventfd.c                 | 63 ++++++++++++++++++++++++++++++++----
 include/uapi/linux/eventfd.h |  3 ++
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index af42b2c7d235..cb004aded4df 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -39,6 +39,7 @@ struct eventfd_ctx {
 	 * also, adds to the "count" counter and issue a wakeup.
 	 */
 	__u64 count;
+	__u64 maximum;
 	unsigned int flags;
 	int id;
 };
@@ -49,7 +50,7 @@ struct eventfd_ctx {
  * @mask: [in] poll mask
  *
  * This function is supposed to be called by the kernel in paths that do not
- * allow sleeping. In this function we allow the counter to reach the ULLONG_MAX
+ * allow sleeping. In this function we allow the counter to reach the maximum
  * value, and we signal this as overflow condition by returning a EPOLLERR
  * to poll(2).
  */
@@ -70,7 +71,7 @@ void eventfd_signal_mask(struct eventfd_ctx *ctx, __poll_t mask)
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
 	current->in_eventfd = 1;
-	if (ctx->count < ULLONG_MAX)
+	if (ctx->count < ctx->maximum)
 		ctx->count++;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLIN | mask);
@@ -119,7 +120,7 @@ static __poll_t eventfd_poll(struct file *file, poll_table *wait)
 {
 	struct eventfd_ctx *ctx = file->private_data;
 	__poll_t events = 0;
-	u64 count;
+	u64 count, max;
 
 	poll_wait(file, &ctx->wqh, wait);
 
@@ -162,12 +163,13 @@ static __poll_t eventfd_poll(struct file *file, poll_table *wait)
 	 *     eventfd_poll returns 0
 	 */
 	count = READ_ONCE(ctx->count);
+	max = READ_ONCE(ctx->maximum);
 
 	if (count > 0)
 		events |= EPOLLIN;
-	if (count == ULLONG_MAX)
+	if (count == max)
 		events |= EPOLLERR;
-	if (ULLONG_MAX - 1 > count)
+	if (max - 1 > count)
 		events |= EPOLLOUT;
 
 	return events;
@@ -244,6 +246,11 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 	return sizeof(ucnt);
 }
 
+static inline bool eventfd_is_writable(const struct eventfd_ctx *ctx)
+{
+	return (ctx->maximum > ctx->count) && (ctx->maximum - ctx->count > ucnt);
+}
+
 static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t count,
 			     loff_t *ppos)
 {
@@ -259,11 +266,11 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 		return -EINVAL;
 	spin_lock_irq(&ctx->wqh.lock);
 	res = -EAGAIN;
-	if (ULLONG_MAX - ctx->count > ucnt)
+	if (eventfd_is_writable(ctx))
 		res = sizeof(ucnt);
 	else if (!(file->f_flags & O_NONBLOCK)) {
 		res = wait_event_interruptible_locked_irq(ctx->wqh,
-				ULLONG_MAX - ctx->count > ucnt);
+				eventfd_is_writable(ctx));
 		if (!res)
 			res = sizeof(ucnt);
 	}
@@ -299,6 +306,46 @@ static void eventfd_show_fdinfo(struct seq_file *m, struct file *f)
 }
 #endif
 
+static long eventfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct eventfd_ctx *ctx = file->private_data;
+	void __user *argp = (void __user *)arg;
+	int ret = 0;
+	__u64 max;
+
+	if (!argp)
+		return -EINVAL;
+
+	switch (cmd) {
+	case EFD_IOC_SET_MAXIMUM: {
+		if (copy_from_user(&max, argp, sizeof(max)))
+			return -EFAULT;
+
+		spin_lock_irq(&ctx->wqh.lock);
+		if (ctx->count >= max)
+			ret = -EINVAL;
+		else
+			ctx->maximum = max;
+		spin_unlock_irq(&ctx->wqh.lock);
+		break;
+	}
+	case EFD_IOC_GET_MAXIMUM: {
+		spin_lock_irq(&ctx->wqh.lock);
+		max = ctx->maximum;
+		spin_unlock_irq(&ctx->wqh.lock);
+
+		if (copy_to_user(argp, &max, sizeof(max)))
+			ret = -EFAULT;
+		break;
+	}
+	default:
+		ret = -ENOENT;
+		break;
+	}
+
+	return ret;
+}
+
 static const struct file_operations eventfd_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= eventfd_show_fdinfo,
@@ -308,6 +355,7 @@ static const struct file_operations eventfd_fops = {
 	.read_iter	= eventfd_read,
 	.write		= eventfd_write,
 	.llseek		= noop_llseek,
+	.unlocked_ioctl	= eventfd_ioctl,
 };
 
 /**
@@ -398,6 +446,7 @@ static int do_eventfd(unsigned int count, int flags)
 	init_waitqueue_head(&ctx->wqh);
 	ctx->count = count;
 	ctx->flags = flags;
+	ctx->maximum = ULLONG_MAX;
 	ctx->id = ida_alloc(&eventfd_ida, GFP_KERNEL);
 
 	flags &= EFD_SHARED_FCNTL_FLAGS;
diff --git a/include/uapi/linux/eventfd.h b/include/uapi/linux/eventfd.h
index 2eb9ab6c32f3..96e6430a3d12 100644
--- a/include/uapi/linux/eventfd.h
+++ b/include/uapi/linux/eventfd.h
@@ -8,4 +8,7 @@
 #define EFD_CLOEXEC O_CLOEXEC
 #define EFD_NONBLOCK O_NONBLOCK
 
+#define EFD_IOC_SET_MAXIMUM	_IOW('E', 0, __u64)
+#define EFD_IOC_GET_MAXIMUM	_IOR('E', 0, __u64)
+
 #endif /* _UAPI_LINUX_EVENTFD_H */
-- 
2.25.1


