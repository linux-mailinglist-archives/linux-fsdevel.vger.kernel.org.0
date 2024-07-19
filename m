Return-Path: <linux-fsdevel+bounces-24001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA809937897
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 15:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 772D9B20F4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6E613EFEE;
	Fri, 19 Jul 2024 13:38:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA721E489;
	Fri, 19 Jul 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721396303; cv=none; b=BPDvp8CD8hUnEnmGWEn95MLD0dqRlA4s16x1JW6mIDKjjkRhmwdgnvXWjIrHIM2FjeHfLm+bcqPgZwv5m752dxoLuPqaDTgZ14ME5JWEwOIQ7sZY2LTpapMRvE56Yyfvv6KB35z1ZRERWaKkfphxnR8PyS8nk+oeadc2O+CyBa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721396303; c=relaxed/simple;
	bh=bq/Aaeq5qWGCzxVVlQSS2IYQdraah38J4uDOEBoV858=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=opt2We44LRBGSaLzJcX2sc/NhrkQJb0Vli0ucz3noxhBUz3ql8oNfaRxkULp5Mali8THAC6bFkeK3Tt3IIuoGIoZK8ZzFdCdIC4iMvrS9gv63Pyy3TMNGNAMBrYQvo4B2q047frutOtcTidWMmLZJ00eHjHmDtYqkes96670r34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46JDbmgg087373;
	Fri, 19 Jul 2024 22:37:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Fri, 19 Jul 2024 22:37:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46JDbll1087368
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 19 Jul 2024 22:37:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a11e31ab-6ffc-453f-ba6a-b7f6e512c55e@I-love.SAKURA.ne.jp>
Date: Fri, 19 Jul 2024 22:37:47 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] tty: tty_io: fix race between tty_fops and hung_up_tty_fops
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

syzbot is reporting data race between __tty_hangup() and __fput(), and
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

Fix possibility of NULL pointer dereference by implementing missing
callbacks, and suppress KCSAN messages by adding __data_racy qualifier
to "struct file"->f_op .

Reported-by: syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=b7c3ba8cdc2f6cf83c21
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
This patch has been tested using linux-next tree via my tomoyo tree since 20240611,
and there was no response on
  [fs] Are you OK with updating "struct file"->f_op value dynamically?
at https://lkml.kernel.org/r/b221d2cf-7dc0-4624-a040-85c131ed72a1@I-love.SAKURA.ne.jp .
Thus, I guess we can go with this approach.

 drivers/tty/tty_io.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/fs.h   |  2 +-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 407b0d87b7c1..bc9aebcb873f 100644
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
index 0283cf366c2a..636bcc59a3f5 100644
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
-- 
2.43.5


