Return-Path: <linux-fsdevel+bounces-32452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2269A5939
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 05:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC091C20C64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 03:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B8F1CF289;
	Mon, 21 Oct 2024 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WBfaHN2N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB8F450EE;
	Mon, 21 Oct 2024 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729481000; cv=none; b=sLFAruepbdT0et9NhT2xW53NdV7GrpxJUGk/Ix7MbLd5MFKRE2QjsFG97fTuuVD/PKt/vlwQVKpjqjsu7MmbY51hfnhsyP9QUdqFQidrvQxHSFCmgP0pvRxRwjB65qGMBBLf+b732sCIV5xt3asem4rGoBwzAXJ30rBsHOKmx/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729481000; c=relaxed/simple;
	bh=FBMEXsB2qzeZlTQOmTKM5Xf8X7yqy8bE7p2PQNX/XG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kD5DeWPSKs3dN7GwJ2XNQmOsEBfaDgZWwqROud6wXkXp8vPKJVKq3xOe56VIMaVyrphLpoTqs/ioo8mYiANHDFYJ9JkkOFw1FKntoh5ZPF1R6JApt2Ko5Q2lQtFa1GCFpTlM3db516ChRTVypcKYxocotEmgUk8riQrIGJmz9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WBfaHN2N; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729480954;
	bh=a3700QODi51nDA2tPcEBFNTNF0pUu84KZh3aJFSeGFs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=WBfaHN2N9eRX1y2pwscRFW1lgtNvjxdiWVTHdf35wdf8GqKKaWoXUpg6VOmCmFgVQ
	 B8/s1SFshM9ilPqysCFXfrfbtN+fONuGluvKIVh96WUOIYCHQnGDFhvQiyuHZzLDQh
	 IcW4TgPXqtRpYG0JypFCYsO6FNS+N2mKgjcpfBcA=
X-QQ-mid: bizesmtp80t1729480909t12cb70e
X-QQ-Originating-IP: l/rpe0HqxzmODTO5fBNlat18nEut6xgckmAPugpHy7Q=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Oct 2024 11:21:47 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3419970537500328848
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
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] fs/pipe: Introduce a check to skip sleeping processes during pipe read/write
Date: Mon, 21 Oct 2024 11:21:45 +0800
Message-ID: <C984DC21381D181A+20241021032145.23328-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OBUGnm9pFasAA903kNgODajRPmlwrHOCP20qB2SRsSc0NlzWC3JaZSni
	JIdS5qRuaeiC7vbCryWdQQu+tfKw2BveSdDlRsOz9PQKD9/bYXiCAfBYd4vvopW9G2KxUdr
	p5hJd9IEWQFtSSHm8uMMUwVLaLvphrHE6/SsNrbPJHi2JtmrEf/e+3YewfOmRQURHqgtc9F
	IYvXxWqcXuddTR8A7Ma0TucjYNOb8HC5Gzrlgs2Gpnoj0qTPBiKa4DHU4SW8VNqtwOHLgHV
	DxByxi1ZF8my4+KSQyW6etPOcwOM+MxZMnCD/cX4Q0QsX/JGPqoHSsJkZTLWLNyvT0r/gEc
	v3O5HFNbu1TENmTbAr6e/Rpr304wZPLmCnBPiVTdVDep+GVoJrS+rTLJkKdAOtXelbvcmxm
	hGWpMWcOc7eOWtrAFohRsVRkan6OLLsIskLmOs9S63t1L0DPVQsuzRmldu6r4gm04uNgaLC
	pR5fDftxqno5EJs1715e5zdRY7zsSmDVaEx5hBlsT4O8db7S5F+XiRHt44lvElNtJla4DwK
	ewDEWYDnBuahxVTFBUCa1PsDfybtMpEFC1nHzLhiYlPM4zFd5JxPF2xQM53CDXcWHKdzSua
	dnc8sA1/tIao7D3sxGaoisC8Xfc9N07yLXFOPZpTcvA/WBeRmInebn1UdW6oTUWBHnRKHgC
	ilodygZxP6yn/m529W0z+ncTAmdNzJtq5v0fw05E61Lq+MNguRLeTtQ1q+OgJmudvihSZWK
	KJwPs346grhZTmyXoK4PzXYuRJCRkjsf6Kt3o43gEFgOW5s59mO8VcV+GNaG9QKjbiEBiNK
	tTtR4YDFQeLcVQGMehROJIZRm3eesEiD3s3Ieq0BBzmGkVDCJf92tMy/cd2EXzftOk9DY/4
	N29qx9EQAWpOdyXAQ7Yor2mf98kiaMrRYyxB+wiqVKGMzxa7+8azueCbdLgR3m1BVpQ0XYr
	A8g7ScYS8ustAhbYHD5SNAKlxrQY5oYXJldFh60TRmSpwU4nkBRdpgu4fT92CgFaXRBVGEZ
	fuKYARUy8IKTQcYhzfFT1BmP9ijhw=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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


