Return-Path: <linux-fsdevel+bounces-20766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2628D795D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 02:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDE62814C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 00:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68980DF62;
	Mon,  3 Jun 2024 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h9/irGBP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D56FB2
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717374805; cv=none; b=D4dIa91QEujNLjK10en6FpuBWG6b0D5Ml6oVX6nyTooAm2busbRayh5I0dOKFg7YypPmwnvqS1hOo+noJ3rgf2NeFmCYApy8laJQvsYpxa3x9PFGGMn5wJPsJPt+3gnW7Ad5GFdrJ+0KW6GqWQLD4prKTNmn1F4FUKGXK20fdPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717374805; c=relaxed/simple;
	bh=MbreANTvOFsf+HoMZMv881QbCHhV7LHQF9AJXemvdRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofpSJxJZBTZnQKXj4goBmTo96BKYvxATGafvS/J7MTulUReLsHiAoy5P5ZOhA4y/GfK3JiicyzR3STSztULorOFtbMnr3AqAMvfuazdqDH/CledTomaz/8KC1OZzAIso+T4+pHgzKexTX+7CslEp+DCBtOCx0btazFazDe5IdZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h9/irGBP; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717374801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtDVS9A12/FhM6gLI1GwHXngLSArqAMBUGSjtT60l7Y=;
	b=h9/irGBPZpS9RHEtUgiTJNJaSvRPgN6nJTrpu0j6bdb35L0d1exKDknSJ8k4wJbNc2SO/S
	d4jzM7YVLiQa1bS20ok3j4tjM0kEsbo2oWdezuBzLqXltHouvdgqN82Pjvqo6orf1MOT+1
	37IexeJNG/zfZ4kQykqf74E8mRdY+bw=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: kent.overstreet@linux.dev
X-Envelope-To: brauner@kernel.org
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: bernd.schubert@fastmail.fm
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: josef@toxicpanda.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-mm@kvack.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 4/5] ringbuffer: Test device
Date: Sun,  2 Jun 2024 20:33:01 -0400
Message-ID: <20240603003306.2030491-5-kent.overstreet@linux.dev>
In-Reply-To: <20240603003306.2030491-1-kent.overstreet@linux.dev>
References: <20240603003306.2030491-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This adds /dev/ringbuffer-test, which supports reading and writing a
sequence of integers, to test performance and correctness.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/Makefile          |   1 +
 fs/ringbuffer_test.c | 209 +++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug    |   5 ++
 3 files changed, 215 insertions(+)
 create mode 100644 fs/ringbuffer_test.c

diff --git a/fs/Makefile b/fs/Makefile
index 48e54ac01fb1..91061f281f0a 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_EVENTFD)		+= eventfd.o
 obj-$(CONFIG_USERFAULTFD)	+= userfaultfd.o
 obj-$(CONFIG_AIO)               += aio.o
 obj-$(CONFIG_RINGBUFFER)        += ringbuffer.o
+obj-$(CONFIG_RINGBUFFER_TEST)   += ringbuffer_test.o
 obj-$(CONFIG_FS_DAX)		+= dax.o
 obj-$(CONFIG_FS_ENCRYPTION)	+= crypto/
 obj-$(CONFIG_FS_VERITY)		+= verity/
diff --git a/fs/ringbuffer_test.c b/fs/ringbuffer_test.c
new file mode 100644
index 000000000000..01aa9c55120d
--- /dev/null
+++ b/fs/ringbuffer_test.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "%s() " fmt "\n", __func__
+
+#include <linux/device.h>
+#include <linux/errname.h>
+#include <linux/fs.h>
+#include <linux/kthread.h>
+#include <linux/ringbuffer_sys.h>
+#include <linux/uio.h>
+
+struct ringbuffer_test_file {
+	struct ringbuffer_test_rw {
+		struct mutex		lock;
+		struct ringbuffer	*rb;
+		struct task_struct	*thr;
+	} rw[2];
+};
+
+#define BUF_NR	4
+
+static int ringbuffer_test_writer(void *p)
+{
+	struct file *file = p;
+	struct ringbuffer_test_file *f = file->private_data;
+	struct ringbuffer *rb = f->rw[READ].rb;
+	u32 idx = 0;
+	u32 buf[BUF_NR];
+
+	while (!kthread_should_stop()) {
+		cond_resched();
+
+		struct kvec vec = { buf, sizeof(buf) };
+		struct iov_iter iter;
+		iov_iter_kvec(&iter, ITER_SOURCE, &vec, 1, sizeof(buf));
+
+		for (unsigned i = 0; i < ARRAY_SIZE(buf); i++)
+			buf[i] = idx + i;
+
+		ssize_t ret = ringbuffer_write_iter(rb, &iter, false);
+		if (ret < 0)
+			continue;
+		idx += ret / sizeof(buf[0]);
+	}
+
+	return 0;
+}
+
+static int ringbuffer_test_reader(void *p)
+{
+	struct file *file = p;
+	struct ringbuffer_test_file *f = file->private_data;
+	struct ringbuffer *rb = f->rw[WRITE].rb;
+	u32 idx = 0;
+	u32 buf[BUF_NR];
+
+	while (!kthread_should_stop()) {
+		cond_resched();
+
+		struct kvec vec = { buf, sizeof(buf) };
+		struct iov_iter iter;
+		iov_iter_kvec(&iter, ITER_DEST, &vec, 1, sizeof(buf));
+
+		ssize_t ret = ringbuffer_read_iter(rb, &iter, false);
+		if (ret < 0)
+			continue;
+
+		unsigned nr = ret / sizeof(buf[0]);
+		for (unsigned i = 0; i < nr; i++)
+			if (buf[i] != idx + i)
+				pr_err("read wrong data");
+		idx += ret / sizeof(buf[0]);
+	}
+
+	return 0;
+}
+
+static void ringbuffer_test_free(struct ringbuffer_test_file *f)
+{
+	for (unsigned i = 0; i < ARRAY_SIZE(f->rw); i++)
+		if (!IS_ERR_OR_NULL(f->rw[i].thr))
+			kthread_stop_put(f->rw[i].thr);
+	for (unsigned i = 0; i < ARRAY_SIZE(f->rw); i++)
+		if (!IS_ERR_OR_NULL(f->rw[i].rb))
+			ringbuffer_free(f->rw[i].rb);
+	kfree(f);
+}
+
+static int ringbuffer_test_open(struct inode *inode, struct file *file)
+{
+	static const char * const rw_str[] = { "reader", "writer" };
+	int ret = 0;
+
+	struct ringbuffer_test_file *f = kzalloc(sizeof(*f), GFP_KERNEL);
+	if (!f)
+		return -ENOMEM;
+
+	for (struct ringbuffer_test_rw *i = f->rw;
+	     i < f->rw + ARRAY_SIZE(f->rw);
+	     i++) {
+		unsigned idx = i - f->rw;
+
+		mutex_init(&i->lock);
+
+		i->rb = ringbuffer_alloc(PAGE_SIZE * 4);
+		ret = PTR_ERR_OR_ZERO(i->rb);
+		if (ret)
+			goto err;
+
+		i->thr = kthread_create(idx == READ
+					? ringbuffer_test_reader
+					: ringbuffer_test_writer,
+					file, "ringbuffer_%s", rw_str[idx]);
+		ret = PTR_ERR_OR_ZERO(i->thr);
+		if (ret)
+			goto err;
+		get_task_struct(i->thr);
+	}
+
+	file->private_data = f;
+	wake_up_process(f->rw[0].thr);
+	wake_up_process(f->rw[1].thr);
+	return 0;
+err:
+	ringbuffer_test_free(f);
+	return ret;
+}
+
+static int ringbuffer_test_release(struct inode *inode, struct file *file)
+{
+	ringbuffer_test_free(file->private_data);
+	return 0;
+}
+
+static ssize_t ringbuffer_test_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	struct ringbuffer_test_file *f = file->private_data;
+	struct ringbuffer_test_rw *i = &f->rw[READ];
+
+	ssize_t ret = mutex_lock_interruptible(&i->lock);
+	if (ret)
+		return ret;
+
+	ret = ringbuffer_read_iter(i->rb, iter, file->f_flags & O_NONBLOCK);
+	mutex_unlock(&i->lock);
+	return ret;
+}
+
+static ssize_t ringbuffer_test_write_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	struct ringbuffer_test_file *f = file->private_data;
+	struct ringbuffer_test_rw *i = &f->rw[WRITE];
+
+	ssize_t ret = mutex_lock_interruptible(&i->lock);
+	if (ret)
+		return ret;
+
+	ret = ringbuffer_write_iter(i->rb, iter, file->f_flags & O_NONBLOCK);
+	mutex_unlock(&i->lock);
+	return ret;
+}
+
+static struct ringbuffer *ringbuffer_test_ringbuffer(struct file *file, int rw)
+{
+	struct ringbuffer_test_file *i = file->private_data;
+
+	BUG_ON(rw > WRITE);
+
+	return i->rw[rw].rb;
+}
+
+static const struct file_operations ringbuffer_fops = {
+	.owner		= THIS_MODULE,
+	.read_iter	= ringbuffer_test_read_iter,
+	.write_iter	= ringbuffer_test_write_iter,
+	.ringbuffer	= ringbuffer_test_ringbuffer,
+	.open		= ringbuffer_test_open,
+	.release	= ringbuffer_test_release,
+};
+
+static int __init ringbuffer_test_init(void)
+{
+	int ringbuffer_major = register_chrdev(0, "ringbuffer-test", &ringbuffer_fops);
+	if (ringbuffer_major < 0)
+		return ringbuffer_major;
+
+	static const struct class ringbuffer_class = { .name = "ringbuffer_test" };
+	int ret = class_register(&ringbuffer_class);
+	if (ret)
+		goto major_out;
+
+	struct device *ringbuffer_device = device_create(&ringbuffer_class, NULL,
+				    MKDEV(ringbuffer_major, 0),
+				    NULL, "ringbuffer-test");
+	ret = PTR_ERR_OR_ZERO(ringbuffer_device);
+	if (ret)
+		goto class_out;
+
+	return 0;
+
+class_out:
+	class_unregister(&ringbuffer_class);
+major_out:
+	unregister_chrdev(ringbuffer_major, "ringbuffer-test");
+	return ret;
+}
+__initcall(ringbuffer_test_init);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 59b6765d86b8..bb16762af575 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2957,6 +2957,11 @@ config TEST_OBJPOOL
 
 	  If unsure, say N.
 
+config RINGBUFFER_TEST
+	bool "Test driver for sys_ringbuffer"
+	default n
+	depends on RINGBUFFER
+
 endif # RUNTIME_TESTING_MENU
 
 config ARCH_USE_MEMTEST
-- 
2.45.1


