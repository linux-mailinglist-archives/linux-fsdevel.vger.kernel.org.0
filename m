Return-Path: <linux-fsdevel+bounces-19723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F70F8C9511
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 16:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EA91C212C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 14:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B894CE1F;
	Sun, 19 May 2024 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VDSlK/20"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929B487BE
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 May 2024 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716129735; cv=none; b=rjJiab+88sA1IPyHS3phhSZuDNCzRMHRPZQL+zhjtlQzVHe53qAm5f0fJ8D4nIju/6ZdOGrChse0zILxT48ePEciD4y95w6mLtMD9D+KLv1ZB+f4+/Ue5em5dPZfai3+5ZeZ4pcThhi27cwLXS1dAt+qkbOQnz9gmurD9HYn4Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716129735; c=relaxed/simple;
	bh=E75jFge/GzqhVsGi7jPxeT/w8jQuLY5NF9aWJFFxy74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o0z52tO/OVae6N2Lq6lWlpPg2NvTOxbDP0A38XTJGiJ+hZbynd1bgZuvPfR/oLKEfEuz/jkeF8RSN0yPHsEsf0IxWf0JMWlHUn12tUfizgi2iJGL3xkeQmUhNUsfFw8kENoccMUwddwypRfECNkErQjQQJOUb5zlyRt+GUIkpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VDSlK/20; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: brauner@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716129729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EtgtQfktrQLAaJG+xJoihlDHzI6jBIATNPCsqNmNMrw=;
	b=VDSlK/20z29VkP4LHFRSuDbW0FF8IBPs5P330iBRgIp2gmmONxmg5OMp8SRLLvUEHD5k7T
	D8mKrveIU+boobVLI9Ig6yTnuBFslPEGmuTNfnG9k+z71WedYleMBAOdqiPGPMPm7fy+IN
	3lrczVfemNNA90ue26lq/83V60u429A=
X-Envelope-To: jack@suse.cz
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: wen.yang@linux.dev
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: hch@lst.de
X-Envelope-To: dylany@fb.com
X-Envelope-To: dwmw@amazon.co.uk
X-Envelope-To: pbonzini@redhat.com
X-Envelope-To: dyoung@redhat.com
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Wen Yang <wen.yang@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Dylan Yudaken <dylany@fb.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] eventfd: introduce ratelimited wakeup for non-semaphore eventfd
Date: Sun, 19 May 2024 22:41:24 +0800
Message-Id: <20240519144124.4429-1-wen.yang@linux.dev>
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
Therefore, the accumulated counter values of multiple eventfd_write can be
read out by a single eventfd_read. Therefore, the accumulated value of
multiple writes can be retrieved by a single read.

However, the current code immediately wakes up the read thread after
writing a NON-SEMAPHORE eventfd, thus increasing unnecessary CPU overhead.

By introducing a configurable ratelimit mechanism in eventfd_write, these
unnecessary wakeup operations are reduced, thereby reducing CPU overhead.

We may the following test code:
	#define _GNU_SOURCE
	#include <assert.h>
	#include <err.h>
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

	struct eventfd_qos {
		__u32 token_capacity;
		__u32 token_rate;
	};

	#define EFD_IOC_SET_QOS        _IOW('E', 0, struct eventfd_qos)
	#define EFD_IOC_GET_QOS        _IOR('E', 0, struct eventfd_qos)

	struct pub_param {
		int fd;
		int cpu;
		struct eventfd_qos *qos;
	};

	struct sub_param {
		int fd;
		int cpu;
	};

	static void publish(void *data)
	{
		struct pub_param * param = (struct pub_param *)data;
		unsigned long long value = 1;
		cpu_set_t cpuset;
		int ret;

		prctl(PR_SET_NAME,"publish");

		CPU_ZERO(&cpuset);
		CPU_SET(param->cpu, &cpuset);
		sched_setaffinity(0, sizeof(cpuset), &cpuset);

		if (param->qos) {
			ret = ioctl(param->fd, EFD_IOC_SET_QOS, param->qos);
			if (ret == -1) {
				printf("ioctl failed, error=%s\n",
					strerror(errno));
				return;
			}
		}

		while (1) {
			ret = eventfd_write(param->fd, value);
			if (ret < 0)
				printf("XXX: write failed, %s\n",
				       	strerror(errno));
		}
	}

	static void subscribe(void *data)
	{
		struct sub_param *param = (struct sub_param *)data;
		unsigned long long value = 0;
		struct pollfd pfds[1];
		cpu_set_t cpuset;

		prctl(PR_SET_NAME,"subscribe");
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
		printf("<-p cpuid> <-s cpuid > [ -r rate ] [ -c capacity ] \n");
	}

	int main(int argc, char *argv[])
	{
		char *optstr = "p:s:r::c::";
		struct sub_param sub_param = {0};
		struct pub_param pub_param = {0};
		struct eventfd_qos qos = {0};
		pid_t pid;
		int fd;
		int opt;

		if (argc < 3) {
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
				case 'r':
					qos.token_rate = atoi(optarg);
					break;
				case 'c':
					qos.token_capacity = atoi(optarg);
					break;
				case '?':
					usage();
					return 1;
			}
		}

		fd = eventfd(0, EFD_CLOEXEC | EFD_NONBLOCK | EFD_NONBLOCK);
		assert(fd);

		sub_param.fd = fd;
		pub_param.fd = fd;
		pub_param.qos = (qos.token_capacity && qos.token_rate) ? &qos : NULL;

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

	# ./a.out  -p 2 -s 3
	The original cpu usage is as follows:
09:53:38 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
09:53:40 PM    2   47.26    0.00   52.74    0.00    0.00    0.00    0.00    0.00    0.00    0.00
09:53:40 PM    3   44.72    0.00   55.28    0.00    0.00    0.00    0.00    0.00    0.00    0.00

09:53:40 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
09:53:42 PM    2   45.73    0.00   54.27    0.00    0.00    0.00    0.00    0.00    0.00    0.00
09:53:42 PM    3   46.00    0.00   54.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00

09:53:42 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
09:53:44 PM    2   48.00    0.00   52.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
09:53:44 PM    3   45.50    0.00   54.50    0.00    0.00    0.00    0.00    0.00    0.00    0.00

Then enable the ratelimited wakeup, eg:
	# ./a.out  -p 2 -s 3  -r1000 -c2

Observing a decrease of over 20% in CPU utilization (CPU # 3, 54% ->30%), as shown below:
10:02:32 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
10:02:34 PM    2   53.00    0.00   47.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
10:02:34 PM    3   30.81    0.00   30.81    0.00    0.00    0.00    0.00    0.00    0.00   38.38

10:02:34 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
10:02:36 PM    2   48.50    0.00   51.50    0.00    0.00    0.00    0.00    0.00    0.00    0.00
10:02:36 PM    3   30.20    0.00   30.69    0.00    0.00    0.00    0.00    0.00    0.00   39.11

10:02:36 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
10:02:38 PM    2   45.00    0.00   55.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00
10:02:38 PM    3   27.08    0.00   30.21    0.00    0.00    0.00    0.00    0.00    0.00   42.71

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>
Cc: Dylan Yudaken <dylany@fb.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventfd.c                 | 188 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/eventfd.h |   8 ++
 init/Kconfig                 |  18 ++++
 3 files changed, 213 insertions(+), 1 deletion(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 9afdb722fa92..28754d9952a7 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -27,6 +27,15 @@
 
 static DEFINE_IDA(eventfd_ida);
 
+#ifdef CONFIG_EVENTFD_RATELIMITED_WAKEUP
+struct eventfd_bucket {
+	struct eventfd_qos qos;
+	struct hrtimer timer;
+	u64 timestamp;
+	u64 tokens;
+};
+#endif
+
 struct eventfd_ctx {
 	struct kref kref;
 	wait_queue_head_t wqh;
@@ -41,8 +50,97 @@ struct eventfd_ctx {
 	__u64 count;
 	unsigned int flags;
 	int id;
+#ifdef CONFIG_EVENTFD_RATELIMITED_WAKEUP
+	struct eventfd_bucket bucket;
+#endif
 };
 
+#ifdef CONFIG_EVENTFD_RATELIMITED_WAKEUP
+
+static void eventfd_refill_tokens(struct eventfd_bucket *bucket)
+{
+	unsigned int rate = bucket->qos.token_rate;
+	u64 now = ktime_get_ns();
+	u64 tokens;
+
+	tokens = ktime_sub(now, bucket->timestamp) * rate;
+	tokens /= NSEC_PER_SEC;
+	if (tokens > 0) {
+		tokens += bucket->tokens;
+		bucket->tokens = (tokens > bucket->qos.token_capacity) ?
+				 tokens : bucket->qos.token_capacity;
+	}
+	bucket->timestamp = now;
+}
+
+static int eventfd_consume_tokens(struct eventfd_bucket *bucket)
+{
+	if (bucket->tokens > 0) {
+		bucket->tokens--;
+		return 1;
+	} else
+		return 0;
+}
+
+static bool eventfd_detect_storm(struct eventfd_ctx *ctx)
+{
+	u32 rate = ctx->bucket.qos.token_rate;
+
+	if (rate == 0)
+		return false;
+
+	eventfd_refill_tokens(&ctx->bucket);
+	return !eventfd_consume_tokens(&ctx->bucket);
+}
+
+static enum hrtimer_restart eventfd_timer_handler(struct hrtimer *timer)
+{
+	struct eventfd_ctx *ctx;
+	unsigned long flags;
+
+	ctx = container_of(timer, struct eventfd_ctx, bucket.timer);
+	spin_lock_irqsave(&ctx->wqh.lock, flags);
+
+	/*
+	 * Checking for locked entry and wake_up_locked_poll() happens
+	 * under the ctx->wqh.lock lock spinlock
+	 */
+	if (waitqueue_active(&ctx->wqh))
+		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+
+	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
+	eventfd_ctx_put(ctx);
+
+	return HRTIMER_NORESTART;
+}
+
+static void eventfd_ratelimited_wake_up(struct eventfd_ctx *ctx)
+{
+	u32 rate = ctx->bucket.qos.token_rate;
+	u64 now = ktime_get_ns();
+	u64 slack_ns;
+	u64 expires;
+
+	if (likely(rate)) {
+		slack_ns = NSEC_PER_SEC/rate;
+	} else {
+		WARN_ON_ONCE("fallback to the default NSEC_PER_SEC.");
+		slack_ns = NSEC_PER_MSEC;
+	}
+
+	/* if already queued, don't bother */
+	if (hrtimer_is_queued(&ctx->bucket.timer))
+		return;
+
+	/* determine next wakeup, add a timer margin */
+	expires = now + slack_ns;
+
+	kref_get(&ctx->kref);
+	hrtimer_start(&ctx->bucket.timer, expires, HRTIMER_MODE_ABS);
+}
+
+#endif
+
 /**
  * eventfd_signal_mask - Increment the event counter
  * @ctx: [in] Pointer to the eventfd context.
@@ -270,8 +368,23 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	if (likely(res > 0)) {
 		ctx->count += ucnt;
 		current->in_eventfd = 1;
-		if (waitqueue_active(&ctx->wqh))
+
+		/*
+		 * Checking for locked entry and wake_up_locked_poll() happens
+		 * under the ctx->wqh.lock spinlock
+		 */
+		if (waitqueue_active(&ctx->wqh)) {
+#ifdef CONFIG_EVENTFD_RATELIMITED_WAKEUP
+			if ((ctx->flags & EFD_SEMAPHORE) || !eventfd_detect_storm(ctx))
+				wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+			else
+				eventfd_ratelimited_wake_up(ctx);
+
+#else
 			wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+#endif
+		}
+
 		current->in_eventfd = 0;
 	}
 	spin_unlock_irq(&ctx->wqh.lock);
@@ -299,6 +412,66 @@ static void eventfd_show_fdinfo(struct seq_file *m, struct file *f)
 }
 #endif
 
+#ifdef CONFIG_EVENTFD_RATELIMITED_WAKEUP
+static long eventfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct eventfd_ctx *ctx = file->private_data;
+	void __user *uaddr = (void __user *)arg;
+	struct eventfd_qos qos;
+
+	if (ctx->flags & EFD_SEMAPHORE)
+		return -EINVAL;
+	if (!uaddr)
+		return -EINVAL;
+
+	switch (cmd) {
+	case EFD_IOC_SET_QOS:
+		if (copy_from_user(&qos, uaddr, sizeof(qos)))
+			return -EFAULT;
+		if (qos.token_rate > NSEC_PER_SEC)
+			return -EINVAL;
+
+		for (;;) {
+			spin_lock_irq(&ctx->wqh.lock);
+			if (hrtimer_try_to_cancel(&ctx->bucket.timer) >= 0) {
+				spin_unlock_irq(&ctx->wqh.lock);
+				break;
+			}
+			spin_unlock_irq(&ctx->wqh.lock);
+			hrtimer_cancel_wait_running(&ctx->bucket.timer);
+		}
+
+		spin_lock_irq(&ctx->wqh.lock);
+		ctx->bucket.timestamp = ktime_get_ns();
+		ctx->bucket.qos = qos;
+		ctx->bucket.tokens = qos.token_capacity;
+
+		current->in_eventfd = 1;
+		/*
+		 * Checking for locked entry and wake_up_locked_poll() happens
+		 * under the ctx->wqh.lock lock spinlock
+		 */
+		if ((!ctx->count) && (waitqueue_active(&ctx->wqh)))
+			wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+		current->in_eventfd = 0;
+
+		spin_unlock_irq(&ctx->wqh.lock);
+		return 0;
+
+	case EFD_IOC_GET_QOS:
+		qos = READ_ONCE(ctx->bucket.qos);
+		if (copy_to_user(uaddr, &qos, sizeof(qos)))
+			return -EFAULT;
+		return 0;
+
+	default:
+		return -ENOENT;
+	}
+
+	return -EINVAL;
+}
+#endif
+
 static const struct file_operations eventfd_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= eventfd_show_fdinfo,
@@ -308,6 +481,10 @@ static const struct file_operations eventfd_fops = {
 	.read_iter	= eventfd_read,
 	.write		= eventfd_write,
 	.llseek		= noop_llseek,
+#ifdef CONFIG_EVENTFD_RATELIMITED_WAKEUP
+	.unlocked_ioctl	= eventfd_ioctl,
+	.compat_ioctl	= eventfd_ioctl,
+#endif
 };
 
 /**
@@ -403,6 +580,15 @@ static int do_eventfd(unsigned int count, int flags)
 	ctx->flags = flags;
 	ctx->id = ida_alloc(&eventfd_ida, GFP_KERNEL);
 
+#ifdef CONFIG_EVENTFD_RATELIMITED_WAKEUP
+	ctx->bucket.qos.token_rate = 0;
+	ctx->bucket.qos.token_capacity = 0;
+	ctx->bucket.tokens = 0;
+	ctx->bucket.timestamp = ktime_get_ns();
+	hrtimer_init(&ctx->bucket.timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	ctx->bucket.timer.function = eventfd_timer_handler;
+#endif
+
 	flags &= EFD_SHARED_FCNTL_FLAGS;
 	flags |= O_RDWR;
 	fd = get_unused_fd_flags(flags);
diff --git a/include/uapi/linux/eventfd.h b/include/uapi/linux/eventfd.h
index 2eb9ab6c32f3..8e9d5361ec6a 100644
--- a/include/uapi/linux/eventfd.h
+++ b/include/uapi/linux/eventfd.h
@@ -8,4 +8,12 @@
 #define EFD_CLOEXEC O_CLOEXEC
 #define EFD_NONBLOCK O_NONBLOCK
 
+struct eventfd_qos {
+	__u32 token_capacity;
+	__u32 token_rate;
+};
+
+#define EFD_IOC_SET_QOS	_IOW('E', 0, struct eventfd_qos)
+#define EFD_IOC_GET_QOS	_IOR('E', 0, struct eventfd_qos)
+
 #endif /* _UAPI_LINUX_EVENTFD_H */
diff --git a/init/Kconfig b/init/Kconfig
index 0a021d6b4939..ebfc79ff34ca 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1646,6 +1646,24 @@ config EVENTFD
 
 	  If unsure, say Y.
 
+config EVENTFD_RATELIMITED_WAKEUP
+	bool "support ratelimited wakeups for the NON-SEMAPHORE eventfd" if EXPERT
+	default n
+	depends on EVENTFD
+	help
+	  This option enables the ratelimited wakeups for the non-semaphore
+	  eventfd. Frequent writing to an eventfd can lead to frequent wakeup
+	  of processes waiting for reading on this eventfd, resulting in
+	  significant overhead. However, for the NON-SEMAPHORE eventfd, if its
+	  counter has a non-zero value, read (2) returns 8 bytes containing
+	  that value, and the counter value is reset to zero. This means that
+	  a read operation can retrieve the accumulated value caused by
+	  multiple write operations.
+	  By introducing the ratelimited wakeups for the NON-SEMAPHORE eventfd,
+	  these CPU overhead can be reduced.
+
+	  If unsure, say N.
+
 config SHMEM
 	bool "Use full shmem filesystem" if EXPERT
 	default y
-- 
2.25.1


