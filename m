Return-Path: <linux-fsdevel+bounces-34188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4409C3854
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 07:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CDB1F21FFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 06:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39B3155391;
	Mon, 11 Nov 2024 06:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WNjwaGw4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788215539F;
	Mon, 11 Nov 2024 06:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306372; cv=none; b=tl18eRLyD/84CHTReSTqwpTupRzpReZjXlvBJvYcJAZgeSQZFREZxpE3HGiXuOGji4N0wkiGb01v/l4w95iMgzpv9lOAVjhtbi85y6BdURtBCIXTsuiy+FSFZ2KjkeMLIPNn1YahdZM+GPmGxQUwN1GkJ9kf24Xp2x8Q4QJEnwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306372; c=relaxed/simple;
	bh=FBMEXsB2qzeZlTQOmTKM5Xf8X7yqy8bE7p2PQNX/XG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WGTOZBXkBVgfywiCAcJ64/lyIJGkp8D/jZHp+VkzRFVfn/8V2nt5g70A8VnQTZReFbv4jzWOLJ1P5VaxaOOHrTO1g9TFxHpoQ+Zmm2uXUeXJ/PbQ/ywPr99VNarZcYNUQbnYmXo2pQjWLgGAugJPeqrt7jG9v4T1up4PHt+TJ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WNjwaGw4; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1731306317;
	bh=a3700QODi51nDA2tPcEBFNTNF0pUu84KZh3aJFSeGFs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=WNjwaGw496W1Tmz3MzitEomESuoROk8PuwoP8ScrXQgBqrtMUFjADYBQwuaiKb/Xq
	 Wk+HvMzWG5zLBjsNcYAnukyGcXcI1ryjIZzCcb0QQlb8e6qIedIXHI0XmDFTyLTEnF
	 0smtBgFqeJ55tzbb0Gg+0uc77BFv2la63QKT7EmY=
X-QQ-mid: bizesmtpsz5t1731306271tlmo0ie
X-QQ-Originating-IP: Z3Ti45RRs53q3ix/SoJshZSIToGnISkhvGeBrKBsiFg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Nov 2024 14:24:29 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12643988938903092547
From: WangYuli <wangyuli@uniontech.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yushengjin@uniontech.com,
	zhangdandan@uniontech.com,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com,
	oliver.sang@intel.com,
	ebiederm@xmission.com,
	colin.king@canonical.com,
	josh@joshtriplett.org,
	WangYuli <wangyuli@uniontech.com>
Subject: [RESEND. PATCH] fs/pipe: Introduce a check to skip sleeping processes during pipe read/write
Date: Mon, 11 Nov 2024 14:24:25 +0800
Message-ID: <1E5B985ECFF2CAD9+20241111062425.939027-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NzmZMORfs0iDlhMaCu2cgTLVT8mklCXReEPNhFGas4Sga6IbrKRehSBM
	8dxiTRF0TYJjwdQvu3xSOOP2RyCzjaRhh8Xs6efN66jwOS71cDQPqUaC9veWckYFYT+F+uH
	yoncFXiSfLgSwZyh0DBiWSgMAWZ5++LSfbj7IousSNX1dH6ECxiqdw6lbEhli2W/jS2h5Zs
	vVphAuhD7p8IntO9a3arEKqRZfx48u2mnZjDV1N8sSmX0RPBPS6JCHHWve39TxgK4ef37KI
	XreI5cxpxL0PRksz7WrZOZfx3yNz0VaNCqUJyr9SQqSvXnjRt/remCUe/JSLHhnF8A6aerA
	gcgtj5BnSM3iacGuSlNL4YzYr24bBvrwluhKZIn7AI6qHgi1IEw9J3zbKvE+NH1Rv0PZS7m
	2CtgpFxjVA0ik6X0QLdvB4k3xUdNvLpYXmQ+wncl3urhMX65gu9+8k933HXOmPjYGhC4NyW
	Xo4wxcLjx4XBbXCnPnTOf315ov/pNgYoJ13n/gAPDGmJtZEPe0wsaFu3juWzFsGYW5SGlK8
	jx2y66G5hmK7J8YqQ0ySMm+DYwf2/EjUytJlg7JDWkEgG0O891Ju0cmdEYZ++zwE13ZmC+q
	fmvXQ2urms59EOgXck47sBucx8QJYokDwQy8OCN0rmG7xXGvtShGKLg1x5RTD/JR8MdbSqj
	CASMhtUf/yEPkr80SdnsKx3ZgQX5Bcjz2/S6515iiMdFuI8+jI5JF5uQQXoyOhvc5m1m+K1
	XRsIwlw3WXNcwukZnXtxnifa5TK/nYqSXdFaxa4OBXjNTX0UQGt3J12PVAGpebDkMugrpb5
	yM0AC6KPG3MBLSnfBUNscHKk22HVFkC0vY3/YSc7NtOHxvFlXWY7TRhhtw+9O1rtH5gkdJA
	zHOfUr1B5i17Sk7dwa9mw7j+gJWmq/gjR0/BacGewpANpYamDjk7n2Ee30C4gEvHXNJFVnb
	OLLTCwW5bQqwWxygD3ZKT/hXIDx/l1WN4eJk16NUbu48j6kcxxRvPJfL/1308jlo1j0/Ftk
	q2uDfWqkWZnimqvdWy1S3A6WgCD4toGIt0joOP3Kqz0g6D8YzKV6cBUzGB5uyykr1P68FoU
	W3hz6M+fcOiA5hr6/VC5W6dvb4xktwdWJa/4cNRgE7G
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

When a user calls the read/write system call and passes a pipe
descriptor, the pipe_read/pipe_write functions are invoked:

1. pipe_read():
  1). Checks if the pipe is valid and if there is any data in the
pipe buffer.
  2). Waits for data:
    *If there is no data in the pipe and the write end is still open,
the current process enters a sleep state (wait_event()) until data
is written.
    *If the write end is closed, return 0.
  3). Reads data:
    *Wakes up the process and copies data from the pipe's memory
buffer to user space.
    *When the buffer is full, the writing process will go to sleep,
waiting for the pipe state to change to be awakened (using the
wake_up_interruptible_sync_poll() mechanism). Once data is read
from the buffer, the writing process can continue writing, and the
reading process can continue reading new data.
  4). Returns the number of bytes read upon successful read.

2. pipe_write():
  1). Checks if the pipe is valid and if there is any available
space in the pipe buffer.
  2). Waits for buffer space:
    *If the pipe buffer is full and the reading process has not
read any data, pipe_write() may put the current process to sleep
until there is space in the buffer.
    *If the read end of the pipe is closed (no process is waiting
to read), an error code -EPIPE is returned, and a SIGPIPE signal may
be sent to the process.
  3). Writes data:
    *If there is enough space in the pipe buffer, pipe_write() copies
data from the user space buffer to the kernel buffer of the pipe
(using copy_from_user()).
    *If the amount of data the user requests to write is larger than
the available space in the buffer, multiple writes may be required,
or the process may wait for new space to be freed.
  4). Wakes up waiting reading processes:
    *After the data is successfully written, pipe_write() wakes up
any processes that may be waiting to read data (using the
wake_up_interruptible_sync_poll() mechanism).
  5). Returns the number of bytes successfully written.

Check if there are any waiting processes in the process wait queue
by introducing wq_has_sleeper() when waking up processes for pipe
read/write operations.

If no processes are waiting, there's no need to execute
wake_up_interruptible_sync_poll(), thus avoiding unnecessary wake-ups.

Unnecessary wake-ups can lead to context switches, where a process
is woken up to handle I/O events even when there is no immediate
need.

Only wake up processes when there are actually waiting processes to
reduce context switches and system overhead by checking
with wq_has_sleeper().

Additionally, by reducing unnecessary synchronization and wake-up
operations, wq_has_sleeper() can decrease system resource waste and
lock contention, improving overall system performance.

For pipe read/write operations, this eliminates ineffective scheduling
and enhances concurrency.

It's important to note that enabling this option means invoking
wq_has_sleeper() to check for sleeping processes in the wait queue
for every read or write operation.

While this is a lightweight operation, it still incurs some overhead.

In low-load or single-task scenarios, this overhead may not yield
significant benefits and could even introduce minor performance
degradation.

UnixBench Pipe benchmark results on Zhaoxin KX-U6780A processor:

With the option disabled: Single-core: 841.8, Multi-core (8): 4621.6
With the option enabled:  Single-core: 877.8, Multi-core (8): 4854.7

Single-core performance improved by 4.1%, multi-core performance
improved by 4.8%.

Co-developed-by: Shengjin Yu <yushengjin@uniontech.com>
Signed-off-by: Shengjin Yu <yushengjin@uniontech.com>
Co-developed-by: Dandan Zhang <zhangdandan@uniontech.com>
Signed-off-by: Dandan Zhang <zhangdandan@uniontech.com>
Tested-by: Dandan Zhang <zhangdandan@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 fs/Kconfig | 13 +++++++++++++
 fs/pipe.c  | 21 +++++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 949895cff872..068f4f886a58 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -430,4 +430,17 @@ source "fs/unicode/Kconfig"
 config IO_WQ
 	bool
 
+config PIPE_SKIP_SLEEPER
+	bool "Skip sleeping processes during pipe read/write"
+	default n
+	help
+	  This option introduces a check whether the sleep queue will
+	  be awakened during pipe read/write.
+
+	  It often leads to a performance improvement. However, in
+	  low-load or single-task scenarios, it may introduce minor
+	  performance overhead.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/fs/pipe.c b/fs/pipe.c
index 12b22c2723b7..c085333ae72c 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -247,6 +247,15 @@ static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
 	return tail;
 }
 
+static inline bool
+pipe_check_wq_has_sleeper(struct wait_queue_head *wq_head)
+{
+	if (IS_ENABLED(CONFIG_PIPE_SKIP_SLEEPER))
+		return wq_has_sleeper(wq_head);
+	else
+		return true;
+}
+
 static ssize_t
 pipe_read(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -377,7 +386,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		 * _very_ unlikely case that the pipe was full, but we got
 		 * no data.
 		 */
-		if (unlikely(was_full))
+		if (unlikely(was_full) && pipe_check_wq_has_sleeper(&pipe->wr_wait))
 			wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
 		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 
@@ -398,9 +407,9 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		wake_next_reader = false;
 	mutex_unlock(&pipe->mutex);
 
-	if (was_full)
+	if (was_full && pipe_check_wq_has_sleeper(&pipe->wr_wait))
 		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
-	if (wake_next_reader)
+	if (wake_next_reader && pipe_check_wq_has_sleeper(&pipe->rd_wait))
 		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 	kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 	if (ret > 0)
@@ -573,7 +582,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		 * become empty while we dropped the lock.
 		 */
 		mutex_unlock(&pipe->mutex);
-		if (was_empty)
+		if (was_empty && pipe_check_wq_has_sleeper(&pipe->rd_wait))
 			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
@@ -598,10 +607,10 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	 * Epoll nonsensically wants a wakeup whether the pipe
 	 * was already empty or not.
 	 */
-	if (was_empty || pipe->poll_usage)
+	if ((was_empty || pipe->poll_usage) && pipe_check_wq_has_sleeper(&pipe->rd_wait))
 		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
-	if (wake_next_writer)
+	if (wake_next_writer && pipe_check_wq_has_sleeper(&pipe->wr_wait))
 		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
 	if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb)) {
 		int err = file_update_time(filp);
-- 
2.45.2


