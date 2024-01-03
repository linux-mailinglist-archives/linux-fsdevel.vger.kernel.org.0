Return-Path: <linux-fsdevel+bounces-7264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF5782374B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478A92867C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 21:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1F21DA2A;
	Wed,  3 Jan 2024 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mELwoRf8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387B1DA23
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704318795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z/reOEVj60kt63+t17d945cr5tY0nN8d19PQUu/8Tvg=;
	b=mELwoRf8mEgHvSwF8qcQCEOfHyG1eJEthLdpVtBJ02M+Tzz3RYnIX096Zj6FeGv7aB/DGY
	Qk9/dYhFUjktGAbAisVnw6lvtW6OZ5zJ5sxhAnaK78hy1NajmrZsuEoPctytPAzX9ArTmt
	o4PZD6scsaDtXsn0DtOYb+udWDl72B4=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH] bcachefs: factor out thread_with_file, thread_with_stdio
Date: Wed,  3 Jan 2024 16:53:07 -0500
Message-ID: <20240103215307.3328500-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all,

this is some utility code I wrote in bcachefs that might be more widely
useful - it's used in bcachefs for online fsck, and I was talking to
Darrick about possibly using it for XFS as well so that we could
potentially standardize our interfaces for online fsck.

Plus, it's nifty.

This isn't the full patch - I cut it down to just the parts that would
be more broadly interesting. To see how this hooks up to the rest of the
bcachefs code, go here:
https://evilpiepirate.org/git/bcachefs.git/commit/?id=7aa38b1be9fc9d409e5c3fb8fcbc51d4a3e25097

--->8---

New helpers for conecting a kthread to a file descriptor; this nicely
ties the kthread lifetime to the file descriptor lifetime and gives us a
communications channel for interacting with the kthread.

The file descriptor will typically be returned by an ioctl.

bare bones version, user provides read and write
methods via file_operations.

In bcachefs this is used for data jobs, where userspace will
periodically call the read method to get the status of the data job and
print a progress indicator.

This provides an object the kthread can read or write to, connected to
the read and write side channels of the file descriptor.

This is used in bcachefs for online fsck: we redirect messages from fsck
that would otherwise go to the kernel log buffer to the file descriptor,
and we can prompt the user for whether to fix errors exactly like
userspace fsck would.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/thread_with_file.c       | 296 +++++++++++++++++++++++++++
 fs/bcachefs/thread_with_file.h       |  41 ++++
 fs/bcachefs/thread_with_file_types.h |  16 ++
 3 files changed, 353 insertions(+)
 create mode 100644 fs/bcachefs/thread_with_file.c
 create mode 100644 fs/bcachefs/thread_with_file.h
 create mode 100644 fs/bcachefs/thread_with_file_types.h

diff --git a/fs/bcachefs/thread_with_file.c b/fs/bcachefs/thread_with_file.c
new file mode 100644
index 000000000000..b24baeabf998
--- /dev/null
+++ b/fs/bcachefs/thread_with_file.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "bcachefs.h"
+#include "printbuf.h"
+#include "thread_with_file.h"
+
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/kthread.h>
+#include <linux/pagemap.h>
+#include <linux/poll.h>
+
+void bch2_thread_with_file_exit(struct thread_with_file *thr)
+{
+	if (thr->task) {
+		kthread_stop(thr->task);
+		put_task_struct(thr->task);
+	}
+}
+
+int bch2_run_thread_with_file(struct thread_with_file *thr,
+			      const struct file_operations *fops,
+			      int (*fn)(void *))
+{
+	struct file *file = NULL;
+	int ret, fd = -1;
+	unsigned fd_flags = O_CLOEXEC;
+
+	if (fops->read && fops->write)
+		fd_flags |= O_RDWR;
+	else if (fops->read)
+		fd_flags |= O_RDONLY;
+	else if (fops->write)
+		fd_flags |= O_WRONLY;
+
+	char name[TASK_COMM_LEN];
+	get_task_comm(name, current);
+
+	thr->ret = 0;
+	thr->task = kthread_create(fn, thr, "%s", name);
+	ret = PTR_ERR_OR_ZERO(thr->task);
+	if (ret)
+		return ret;
+
+	ret = get_unused_fd_flags(fd_flags);
+	if (ret < 0)
+		goto err;
+	fd = ret;
+
+	file = anon_inode_getfile(name, fops, thr, fd_flags);
+	ret = PTR_ERR_OR_ZERO(file);
+	if (ret)
+		goto err;
+
+	fd_install(fd, file);
+	get_task_struct(thr->task);
+	wake_up_process(thr->task);
+	return fd;
+err:
+	if (fd >= 0)
+		put_unused_fd(fd);
+	if (thr->task)
+		kthread_stop(thr->task);
+	return ret;
+}
+
+static inline bool thread_with_stdio_has_output(struct thread_with_stdio *thr)
+{
+	return thr->stdio.output_buf.pos ||
+		thr->output2.nr ||
+		thr->thr.done;
+}
+
+static ssize_t thread_with_stdio_read(struct file *file, char __user *buf,
+				      size_t len, loff_t *ppos)
+{
+	struct thread_with_stdio *thr =
+		container_of(file->private_data, struct thread_with_stdio, thr);
+	size_t copied = 0, b;
+	int ret = 0;
+
+	if ((file->f_flags & O_NONBLOCK) &&
+	    !thread_with_stdio_has_output(thr))
+		return -EAGAIN;
+
+	ret = wait_event_interruptible(thr->stdio.output_wait,
+		thread_with_stdio_has_output(thr));
+	if (ret)
+		return ret;
+
+	if (thr->thr.done)
+		return 0;
+
+	while (len) {
+		ret = darray_make_room(&thr->output2, thr->stdio.output_buf.pos);
+		if (ret)
+			break;
+
+		spin_lock_irq(&thr->stdio.output_lock);
+		b = min_t(size_t, darray_room(thr->output2), thr->stdio.output_buf.pos);
+
+		memcpy(&darray_top(thr->output2), thr->stdio.output_buf.buf, b);
+		memmove(thr->stdio.output_buf.buf,
+			thr->stdio.output_buf.buf + b,
+			thr->stdio.output_buf.pos - b);
+
+		thr->output2.nr += b;
+		thr->stdio.output_buf.pos -= b;
+		spin_unlock_irq(&thr->stdio.output_lock);
+
+		b = min(len, thr->output2.nr);
+		if (!b)
+			break;
+
+		b -= copy_to_user(buf, thr->output2.data, b);
+		if (!b) {
+			ret = -EFAULT;
+			break;
+		}
+
+		copied	+= b;
+		buf	+= b;
+		len	-= b;
+
+		memmove(thr->output2.data,
+			thr->output2.data + b,
+			thr->output2.nr - b);
+		thr->output2.nr -= b;
+	}
+
+	return copied ?: ret;
+}
+
+static int thread_with_stdio_release(struct inode *inode, struct file *file)
+{
+	struct thread_with_stdio *thr =
+		container_of(file->private_data, struct thread_with_stdio, thr);
+
+	bch2_thread_with_file_exit(&thr->thr);
+	printbuf_exit(&thr->stdio.input_buf);
+	printbuf_exit(&thr->stdio.output_buf);
+	darray_exit(&thr->output2);
+	thr->exit(thr);
+	return 0;
+}
+
+#define WRITE_BUFFER		4096
+
+static inline bool thread_with_stdio_has_input_space(struct thread_with_stdio *thr)
+{
+	return thr->stdio.input_buf.pos < WRITE_BUFFER || thr->thr.done;
+}
+
+static ssize_t thread_with_stdio_write(struct file *file, const char __user *ubuf,
+				       size_t len, loff_t *ppos)
+{
+	struct thread_with_stdio *thr =
+		container_of(file->private_data, struct thread_with_stdio, thr);
+	struct printbuf *buf = &thr->stdio.input_buf;
+	size_t copied = 0;
+	ssize_t ret = 0;
+
+	while (len) {
+		if (thr->thr.done) {
+			ret = -EPIPE;
+			break;
+		}
+
+		size_t b = len - fault_in_readable(ubuf, len);
+		if (!b) {
+			ret = -EFAULT;
+			break;
+		}
+
+		spin_lock(&thr->stdio.input_lock);
+		if (buf->pos < WRITE_BUFFER)
+			bch2_printbuf_make_room(buf, min(b, WRITE_BUFFER - buf->pos));
+		b = min(len, printbuf_remaining_size(buf));
+
+		if (b && !copy_from_user_nofault(&buf->buf[buf->pos], ubuf, b)) {
+			ubuf += b;
+			len -= b;
+			copied += b;
+			buf->pos += b;
+		}
+		spin_unlock(&thr->stdio.input_lock);
+
+		if (b) {
+			wake_up(&thr->stdio.input_wait);
+		} else {
+			if ((file->f_flags & O_NONBLOCK)) {
+				ret = -EAGAIN;
+				break;
+			}
+
+			ret = wait_event_interruptible(thr->stdio.input_wait,
+					thread_with_stdio_has_input_space(thr));
+			if (ret)
+				break;
+		}
+	}
+
+	return copied ?: ret;
+}
+
+static __poll_t thread_with_stdio_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct thread_with_stdio *thr =
+		container_of(file->private_data, struct thread_with_stdio, thr);
+
+	poll_wait(file, &thr->stdio.output_wait, wait);
+	poll_wait(file, &thr->stdio.input_wait, wait);
+
+	__poll_t mask = 0;
+
+	if (thread_with_stdio_has_output(thr))
+		mask |= EPOLLIN;
+	if (thread_with_stdio_has_input_space(thr))
+		mask |= EPOLLOUT;
+	if (thr->thr.done)
+		mask |= EPOLLHUP|EPOLLERR;
+	return mask;
+}
+
+static const struct file_operations thread_with_stdio_fops = {
+	.release	= thread_with_stdio_release,
+	.read		= thread_with_stdio_read,
+	.write		= thread_with_stdio_write,
+	.poll		= thread_with_stdio_poll,
+	.llseek		= no_llseek,
+};
+
+int bch2_run_thread_with_stdio(struct thread_with_stdio *thr,
+			       void (*exit)(struct thread_with_stdio *),
+			       int (*fn)(void *))
+{
+	thr->stdio.input_buf = PRINTBUF;
+	thr->stdio.input_buf.atomic++;
+	spin_lock_init(&thr->stdio.input_lock);
+	init_waitqueue_head(&thr->stdio.input_wait);
+
+	thr->stdio.output_buf = PRINTBUF;
+	thr->stdio.output_buf.atomic++;
+	spin_lock_init(&thr->stdio.output_lock);
+	init_waitqueue_head(&thr->stdio.output_wait);
+
+	darray_init(&thr->output2);
+	thr->exit = exit;
+
+	return bch2_run_thread_with_file(&thr->thr, &thread_with_stdio_fops, fn);
+}
+
+int bch2_stdio_redirect_read(struct stdio_redirect *stdio, char *buf, size_t len)
+{
+	wait_event(stdio->input_wait,
+		   stdio->input_buf.pos || stdio->done);
+
+	if (stdio->done)
+		return -1;
+
+	spin_lock(&stdio->input_lock);
+	int ret = min(len, stdio->input_buf.pos);
+	stdio->input_buf.pos -= ret;
+	memcpy(buf, stdio->input_buf.buf, ret);
+	memmove(stdio->input_buf.buf,
+		stdio->input_buf.buf + ret,
+		stdio->input_buf.pos);
+	spin_unlock(&stdio->input_lock);
+
+	wake_up(&stdio->input_wait);
+	return ret;
+}
+
+int bch2_stdio_redirect_readline(struct stdio_redirect *stdio, char *buf, size_t len)
+{
+	wait_event(stdio->input_wait,
+		   stdio->input_buf.pos || stdio->done);
+
+	if (stdio->done)
+		return -1;
+
+	spin_lock(&stdio->input_lock);
+	int ret = min(len, stdio->input_buf.pos);
+	char *n = memchr(stdio->input_buf.buf, '\n', ret);
+	if (n)
+		ret = min(ret, n + 1 - stdio->input_buf.buf);
+	stdio->input_buf.pos -= ret;
+	memcpy(buf, stdio->input_buf.buf, ret);
+	memmove(stdio->input_buf.buf,
+		stdio->input_buf.buf + ret,
+		stdio->input_buf.pos);
+	spin_unlock(&stdio->input_lock);
+
+	wake_up(&stdio->input_wait);
+	return ret;
+}
diff --git a/fs/bcachefs/thread_with_file.h b/fs/bcachefs/thread_with_file.h
new file mode 100644
index 000000000000..05879c5048c8
--- /dev/null
+++ b/fs/bcachefs/thread_with_file.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BCACHEFS_THREAD_WITH_FILE_H
+#define _BCACHEFS_THREAD_WITH_FILE_H
+
+#include "thread_with_file_types.h"
+
+struct task_struct;
+
+struct thread_with_file {
+	struct task_struct	*task;
+	int			ret;
+	bool			done;
+};
+
+void bch2_thread_with_file_exit(struct thread_with_file *);
+int bch2_run_thread_with_file(struct thread_with_file *,
+			      const struct file_operations *,
+			      int (*fn)(void *));
+
+struct thread_with_stdio {
+	struct thread_with_file	thr;
+	struct stdio_redirect	stdio;
+	DARRAY(char)		output2;
+	void			(*exit)(struct thread_with_stdio *);
+};
+
+static inline void thread_with_stdio_done(struct thread_with_stdio *thr)
+{
+	thr->thr.done = true;
+	thr->stdio.done = true;
+	wake_up(&thr->stdio.input_wait);
+	wake_up(&thr->stdio.output_wait);
+}
+
+int bch2_run_thread_with_stdio(struct thread_with_stdio *,
+			       void (*exit)(struct thread_with_stdio *),
+			       int (*fn)(void *));
+int bch2_stdio_redirect_read(struct stdio_redirect *, char *, size_t);
+int bch2_stdio_redirect_readline(struct stdio_redirect *, char *, size_t);
+
+#endif /* _BCACHEFS_THREAD_WITH_FILE_H */
diff --git a/fs/bcachefs/thread_with_file_types.h b/fs/bcachefs/thread_with_file_types.h
new file mode 100644
index 000000000000..90b5e645e98c
--- /dev/null
+++ b/fs/bcachefs/thread_with_file_types.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BCACHEFS_THREAD_WITH_FILE_TYPES_H
+#define _BCACHEFS_THREAD_WITH_FILE_TYPES_H
+
+struct stdio_redirect {
+	spinlock_t		output_lock;
+	wait_queue_head_t	output_wait;
+	struct printbuf		output_buf;
+
+	spinlock_t		input_lock;
+	wait_queue_head_t	input_wait;
+	struct printbuf		input_buf;
+	bool			done;
+};
+
+#endif /* _BCACHEFS_THREAD_WITH_FILE_TYPES_H */
-- 
2.43.0


