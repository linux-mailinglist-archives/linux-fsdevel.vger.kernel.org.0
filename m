Return-Path: <linux-fsdevel+bounces-19344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B78C36B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 15:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647461C2095C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 13:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E7B2556E;
	Sun, 12 May 2024 13:46:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ADF17F3;
	Sun, 12 May 2024 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715521572; cv=none; b=u2Yp77GIPzJqO2TQx4FX/N4b2+ap4fDzaRjOUsqQ2PmZh+enT5AQIchqkGJsRVD2HiWJVbieGfGfC/ryzxpmcrP6x6VdGllIiOuyp5uJykbY0p0Mpaf4LAnW/+nK5Y/13bIUIpD5Dz+QdECfizvDlaGoHMvtSGavA/VNXT5UytY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715521572; c=relaxed/simple;
	bh=FJD0Krw+OCM6lmu/gFtLC4n26kTN+Ci25jvOIpx8y+s=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=AZCj9ozvk6kTiqqgiMsWOy9KUWP8uuuZie+vVExi2r9OiWo8lvFIr9qzBM54TrRKYDilxevCTUCjKIwYGZY2/8FGitXi6aAVJvy5lfmCQON1Ex1KLtP3bIMy7W5IZnoyCF0Q1tgK8QsmtTa8R1/O/VRSxdDxYRmhRYG5qI6yaGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44CDjmL1030377;
	Sun, 12 May 2024 22:45:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Sun, 12 May 2024 22:45:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44CDjmfI030374
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 12 May 2024 22:45:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b221d2cf-7dc0-4624-a040-85c131ed72a1@I-love.SAKURA.ne.jp>
Date: Sun, 12 May 2024 22:45:46 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [fs] Are you OK with updating "struct file"->f_op value dynamically?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello.

This is a broadcast for making sure that nobody (especially filesystems
including out-of-tree proprietary modules) gets trouble with this change.



syzbot is reporting data race between __tty_hangup() and __fput() [1], and
Dmitry Vyukov mentioned that this race has possibility of NULL pointer
dereference, for tty_fops implements e.g. splice_read callback whereas
hung_up_tty_fops does not.

  CPU0                                  CPU1
  ----                                  ----
  do_splice_read() {
                                        __tty_hangup() {
    // f_op->splice_read was copy_splice_read
    if (unlikely(!in->f_op->splice_read))
      return warn_unsupported(in, "read");
                                          filp->f_op = &hung_up_tty_fops;
    // f_op->splice_read is now NULL
    return in->f_op->splice_read(in, ppos, pipe, len, flags);
                                        }
  }

Therefore, I was proposing a patch that avoids updating
"struct file"->f_op after "struct file" became visible to others.

 drivers/tty/tty_io.c | 46 +++++++++++++++++++++-----------------------
 include/linux/tty.h  |  1 +
 2 files changed, 23 insertions(+), 24 deletions(-)

 (patch body is shown bottom of this post)

During the discussion, Linus Torvalds commented that we don't want to add
data_race() annotation for reading "struct file"->f_op value [2], and
Marco Elver proposed __data_racy qualifier [3] so that we don't need to
scatter data_race() annotation to "struct file"->f_op readers/updaters.

And now, Linus is expecting a patch that updates "struct file"->f_op
value dynamically [4].

 drivers/tty/tty_io.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/fs.h   |  2 +-
 2 files changed, 35 insertions(+), 1 deletion(-)

 (patch body is shown bottom of this post)

But I want a confirmation before going that way. If someone is assuming that
"struct file"->f_op does not change as long as "struct file" is visible to
others, going that way can break that someone's code. Therefore, if you have
an assumption that "struct file"->f_op does not change, please be sure to
respond.


Link: https://syzkaller.appspot.com/bug?extid=b7c3ba8cdc2f6cf83c21 [1]
Link: https://lkml.kernel.org/r/CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com [2]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=31f605a308e627f06e4e6ab77254473f1c90f0bf [3]
Link: https://lkml.kernel.org/r/CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com [4]



A patch that avoids updating "struct file"->f_op after "struct file"
became visible to others:

------------------------------------------------------------
 drivers/tty/tty_io.c | 46 +++++++++++++++++++++-----------------------
 include/linux/tty.h  |  1 +
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 407b0d87b7c10..aeea5eb13f48c 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -187,6 +187,7 @@ int tty_alloc_file(struct file *file)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->hung = false;
 	file->private_data = priv;
 
 	return 0;
@@ -420,35 +421,35 @@ struct tty_driver *tty_find_polling_driver(char *name, int *line)
 EXPORT_SYMBOL_GPL(tty_find_polling_driver);
 #endif
 
-static ssize_t hung_up_tty_read(struct kiocb *iocb, struct iov_iter *to)
+static inline ssize_t hung_up_tty_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
 }
 
-static ssize_t hung_up_tty_write(struct kiocb *iocb, struct iov_iter *from)
+static inline ssize_t hung_up_tty_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return -EIO;
 }
 
 /* No kernel lock held - none needed ;) */
-static __poll_t hung_up_tty_poll(struct file *filp, poll_table *wait)
+static inline __poll_t hung_up_tty_poll(struct file *filp, poll_table *wait)
 {
 	return EPOLLIN | EPOLLOUT | EPOLLERR | EPOLLHUP | EPOLLRDNORM | EPOLLWRNORM;
 }
 
-static long hung_up_tty_ioctl(struct file *file, unsigned int cmd,
+static inline long hung_up_tty_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
 	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
 }
 
-static long hung_up_tty_compat_ioctl(struct file *file,
+static inline long hung_up_tty_compat_ioctl(struct file *file,
 				     unsigned int cmd, unsigned long arg)
 {
 	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
 }
 
-static int hung_up_tty_fasync(int fd, struct file *file, int on)
+static inline int hung_up_tty_fasync(int fd, struct file *file, int on)
 {
 	return -ENOTTY;
 }
@@ -490,17 +491,6 @@ static const struct file_operations console_fops = {
 	.fasync		= tty_fasync,
 };
 
-static const struct file_operations hung_up_tty_fops = {
-	.llseek		= no_llseek,
-	.read_iter	= hung_up_tty_read,
-	.write_iter	= hung_up_tty_write,
-	.poll		= hung_up_tty_poll,
-	.unlocked_ioctl	= hung_up_tty_ioctl,
-	.compat_ioctl	= hung_up_tty_compat_ioctl,
-	.release	= tty_release,
-	.fasync		= hung_up_tty_fasync,
-};
-
 static DEFINE_SPINLOCK(redirect_lock);
 static struct file *redirect;
 
@@ -618,7 +608,7 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 			continue;
 		closecount++;
 		__tty_fasync(-1, filp, 0);	/* can't block */
-		filp->f_op = &hung_up_tty_fops;
+		priv->hung = true;
 	}
 	spin_unlock(&tty->files_lock);
 
@@ -742,7 +732,8 @@ void tty_vhangup_session(struct tty_struct *tty)
  */
 int tty_hung_up_p(struct file *filp)
 {
-	return (filp && filp->f_op == &hung_up_tty_fops);
+	return filp && filp->f_op == &tty_fops &&
+		((struct tty_file_private *) filp->private_data)->hung;
 }
 EXPORT_SYMBOL(tty_hung_up_p);
 
@@ -921,6 +912,8 @@ static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
 	struct tty_ldisc *ld;
 	ssize_t ret;
 
+	if (tty_hung_up_p(file))
+		return hung_up_tty_read(iocb, to);
 	if (tty_paranoia_check(tty, inode, "tty_read"))
 		return -EIO;
 	if (!tty || tty_io_error(tty))
@@ -1080,6 +1073,8 @@ static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_
 	struct tty_ldisc *ld;
 	ssize_t ret;
 
+	if (tty_hung_up_p(file))
+		return hung_up_tty_write(iocb, from);
 	if (tty_paranoia_check(tty, file_inode(file), "tty_write"))
 		return -EIO;
 	if (!tty || !tty->ops->write ||	tty_io_error(tty))
@@ -2166,11 +2161,6 @@ static int tty_open(struct inode *inode, struct file *filp)
 			return retval;
 
 		schedule();
-		/*
-		 * Need to reset f_op in case a hangup happened.
-		 */
-		if (tty_hung_up_p(filp))
-			filp->f_op = &tty_fops;
 		goto retry_open;
 	}
 	clear_bit(TTY_HUPPED, &tty->flags);
@@ -2204,6 +2194,8 @@ static __poll_t tty_poll(struct file *filp, poll_table *wait)
 	struct tty_ldisc *ld;
 	__poll_t ret = 0;
 
+	if (tty_hung_up_p(filp))
+		return hung_up_tty_poll(filp, wait);
 	if (tty_paranoia_check(tty, file_inode(filp), "tty_poll"))
 		return 0;
 
@@ -2256,6 +2248,8 @@ static int tty_fasync(int fd, struct file *filp, int on)
 	struct tty_struct *tty = file_tty(filp);
 	int retval = -ENOTTY;
 
+	if (tty_hung_up_p(filp))
+		return hung_up_tty_fasync(fd, filp, on);
 	tty_lock(tty);
 	if (!tty_hung_up_p(filp))
 		retval = __tty_fasync(fd, filp, on);
@@ -2684,6 +2678,8 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	int retval;
 	struct tty_ldisc *ld;
 
+	if (tty_hung_up_p(file))
+		return hung_up_tty_ioctl(file, cmd, arg);
 	if (tty_paranoia_check(tty, file_inode(file), "tty_ioctl"))
 		return -EINVAL;
 
@@ -2969,6 +2965,8 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 		return tty_ioctl(file, cmd, arg);
 	}
 
+	if (tty_hung_up_p(file))
+		return hung_up_tty_compat_ioctl(file, cmd, arg);
 	if (tty_paranoia_check(tty, file_inode(file), "tty_ioctl"))
 		return -EINVAL;
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 2372f9357240d..56c250247df9b 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -248,6 +248,7 @@ struct tty_file_private {
 	struct tty_struct *tty;
 	struct file *file;
 	struct list_head list;
+	bool __data_racy hung; /* Whether __tty_hangup() was called or not. */
 };
 
 /**
------------------------------------------------------------

A patch that updates "struct file"->f_op value dynamically:

------------------------------------------------------------
 drivers/tty/tty_io.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/fs.h   |  2 +-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 407b0d87b7c10..16e135687226a 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -430,6 +430,24 @@ static ssize_t hung_up_tty_write(struct kiocb *iocb, struct iov_iter *from)
 	return -EIO;
 }
 
+static ssize_t hung_up_copy_splice_read(struct file *in, loff_t *ppos,
+					struct pipe_inode_info *pipe,
+					size_t len, unsigned int flags)
+{
+	return -EINVAL;
+}
+
+static ssize_t hung_up_iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
+					      loff_t *ppos, size_t len, unsigned int flags)
+{
+	return -EINVAL;
+}
+
+static int hung_up_no_open(struct inode *inode, struct file *file)
+{
+	return -ENXIO;
+}
+
 /* No kernel lock held - none needed ;) */
 static __poll_t hung_up_tty_poll(struct file *filp, poll_table *wait)
 {
@@ -462,6 +480,12 @@ static void tty_show_fdinfo(struct seq_file *m, struct file *file)
 }
 
 static const struct file_operations tty_fops = {
+	/*
+	 * WARNING: You must implement all callbacks defined in tty_fops in
+	 * hung_up_tty_fops, for tty_fops and hung_up_tty_fops are toggled
+	 * after "struct file" is published. Failure to synchronize has a risk
+	 * of NULL pointer dereference bug.
+	 */
 	.llseek		= no_llseek,
 	.read_iter	= tty_read,
 	.write_iter	= tty_write,
@@ -491,14 +515,24 @@ static const struct file_operations console_fops = {
 };
 
 static const struct file_operations hung_up_tty_fops = {
+	/*
+	 * WARNING: You must implement all callbacks defined in hung_up_tty_fops
+	 * in tty_fops, for tty_fops and hung_up_tty_fops are toggled after
+	 * "struct file" is published. Failure to synchronize has a risk of
+	 * NULL pointer dereference bug.
+	 */
 	.llseek		= no_llseek,
 	.read_iter	= hung_up_tty_read,
 	.write_iter	= hung_up_tty_write,
+	.splice_read    = hung_up_copy_splice_read,
+	.splice_write   = hung_up_iter_file_splice_write,
 	.poll		= hung_up_tty_poll,
 	.unlocked_ioctl	= hung_up_tty_ioctl,
 	.compat_ioctl	= hung_up_tty_compat_ioctl,
+	.open           = hung_up_no_open,
 	.release	= tty_release,
 	.fasync		= hung_up_tty_fasync,
+	.show_fdinfo    = tty_show_fdinfo,
 };
 
 static DEFINE_SPINLOCK(redirect_lock);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1394347b4fda5..2d14b26ace792 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1008,7 +1008,7 @@ struct file {
 	struct file_ra_state	f_ra;
 	struct path		f_path;
 	struct inode		*f_inode;	/* cached value */
-	const struct file_operations	*f_op;
+	const struct file_operations	*__data_racy f_op;
 
 	u64			f_version;
 #ifdef CONFIG_SECURITY
------------------------------------------------------------

