Return-Path: <linux-fsdevel+bounces-38115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6B09FC497
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 10:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FB416297D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA5015667D;
	Wed, 25 Dec 2024 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="DfWW69Qg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EA84A1C;
	Wed, 25 Dec 2024 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735119962; cv=none; b=uo2W+GSuqbTViWXHoL/k+gxiH8mgb0flNqlnvjV5wYY+h1+GkHxWVq6jrrCQHfvtij1i4r3u0MBTpeq8DWT1uF54NqFx3Jvg7bHG7DBI6gfHMoOCDc7WmcIer2a0S2Z+DVgT12q+qQBOmRz89joyi8HF+/XtpM+A79jNwG8DExA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735119962; c=relaxed/simple;
	bh=XOyeA2qCsbl8owjizR3k6zBMKTsBaI6ib1gj84tho6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AT6uzKr6Kn56P1W7JI6KDZ3+PEFiX8ANv7DxkU7jCPbS4xKgJwxxD/VSgG4H+XvQdoZ+e+6Ks95zljSwh6evo52dM366wZF1t0qRLoAI31/VrEVoaHiZ2unAuM0MhVQkU+2ptoUbeZcCxvRSU/iZ6Qhp3xb/zoAK2nhkdkUhjcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=DfWW69Qg; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1735119923;
	bh=gmCYr5BKbZ9hj2Gs5PAilpqOnRWh3Og4qdxbsv+eWrM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=DfWW69QgBrDtxfUrFpannYqnG7ytF8UKCE/GCaPutaaJFMLKJpPJEGOdyArAsDXYo
	 XniOoA9Tijaw9/nbqxEA7cV1QYv/7o/pEekQOEVVM8AjKePWxEVnBu4jBWFjX1xXV7
	 Rit3VGsw5mAqUXlL9KcYoxouRbO6f/bbcXSrcivk=
X-QQ-mid: bizesmtpip4t1735119753tnfjmzn
X-QQ-Originating-IP: SJkN+1/+GLjIlAkJY6kOJqwpXc4sHP82qJzIxbbkFoY=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Dec 2024 17:42:18 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9999658241429170118
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
	penberg@cs.helsinki.fi,
	manfred@colorfullife.com,
	mingo@elte.hu,
	jes@sgi.com,
	hch@lst.de,
	aia21@cantab.net,
	arjan@infradead.org,
	jgarzik@pobox.com,
	neukum@fachschaft.cup.uni-muenchen.de,
	oliver@neukum.name,
	dada1@cosmosbay.com,
	axboe@kernel.dk,
	axboe@suse.de,
	nickpiggin@yahoo.com.au,
	dhowells@redhat.com,
	nathans@sgi.com,
	rolandd@cisco.com,
	tytso@mit.edu,
	bunk@stusta.de,
	pbadari@us.ibm.com,
	ak@linux.intel.com,
	ak@suse.de,
	davem@davemloft.net,
	jsipek@cs.sunysb.edu,
	jens.axboe@oracle.com,
	ramsdell@mitre.org,
	hch@infradead.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	randy.dunlap@oracle.com,
	efault@gmx.de,
	rdunlap@infradead.org,
	haveblue@us.ibm.com,
	drepper@redhat.com,
	dm.n9107@gmail.com,
	jblunck@suse.de,
	davidel@xmailserver.org,
	mtk.manpages@googlemail.com,
	linux-arch@vger.kernel.org,
	vda.linux@googlemail.com,
	jmorris@namei.org,
	serue@us.ibm.com,
	hca@linux.ibm.com,
	rth@twiddle.net,
	lethal@linux-sh.org,
	tony.luck@intel.com,
	heiko.carstens@de.ibm.com,
	oleg@redhat.com,
	andi@firstfloor.org,
	corbet@lwn.net,
	crquan@gmail.com,
	mszeredi@suse.cz,
	miklos@szeredi.hu,
	peterz@infradead.org,
	a.p.zijlstra@chello.nl,
	earl_chew@agilent.com,
	npiggin@gmail.com,
	npiggin@suse.de,
	julia@diku.dk,
	jaxboe@fusionio.com,
	nikai@nikai.net,
	dchinner@redhat.com,
	davej@redhat.com,
	npiggin@kernel.dk,
	eric.dumazet@gmail.com,
	tim.c.chen@linux.intel.com,
	xemul@parallels.com,
	tj@kernel.org,
	serge.hallyn@canonical.com,
	gorcunov@openvz.org,
	levinsasha928@gmail.com,
	penberg@kernel.org,
	amwang@redhat.com,
	bcrl@kvack.org,
	muthu.lkml@gmail.com,
	muthur@gmail.com,
	mjt@tls.msk.ru,
	alan@lxorguk.ukuu.org.uk,
	raven@themaw.net,
	thomas@m3y3r.de,
	will.deacon@arm.com,
	will@kernel.org,
	josef@redhat.com,
	anatol.pomozov@gmail.com,
	koverstreet@google.com,
	zab@redhat.com,
	balbi@ti.com,
	gregkh@linuxfoundation.org,
	mfasheh@suse.com,
	jlbec@evilplan.org,
	rusty@rustcorp.com.au,
	asamymuthupa@micron.com,
	smani@micron.com,
	sbradshaw@micron.com,
	jmoyer@redhat.com,
	sim@hostway.ca,
	ia@cloudflare.com,
	dmonakhov@openvz.org,
	ebiggers3@gmail.com,
	socketpair@gmail.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	w@1wt.eu,
	kirill.shutemov@linux.intel.com,
	mhocko@suse.com,
	vdavydov.dev@gmail.com,
	vdavydov@virtuozzo.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	deepa.kernel@gmail.com,
	arnd@arndb.de,
	balbi@kernel.org,
	swhiteho@redhat.com,
	konishi.ryusuke@lab.ntt.co.jp,
	dsterba@suse.com,
	vegard.nossum@oracle.com,
	axboe@fb.com,
	pombredanne@nexb.com,
	tglx@linutronix.de,
	joe.lawrence@redhat.com,
	mpatocka@redhat.com,
	mcgrof@kernel.org,
	keescook@chromium.org,
	linux@dominikbrodowski.net,
	jannh@google.com,
	shakeelb@google.com,
	guro@fb.com,
	willy@infradead.org,
	khlebnikov@yandex-team.ru,
	kirr@nexedi.com,
	stern@rowland.harvard.edu,
	elver@google.com,
	parri.andrea@gmail.com,
	paulmck@kernel.org,
	rasibley@redhat.com,
	jstancek@redhat.com,
	avagin@gmail.com,
	cai@redhat.com,
	josef@toxicpanda.com,
	hare@suse.de,
	colyli@suse.de,
	johannes@sipsolutions.net,
	sspatil@android.com,
	alex_y_xu@yahoo.ca,
	mgorman@techsingularity.net,
	gor@linux.ibm.com,
	jhubbard@nvidia.com,
	andriy.shevchenko@linux.intel.com,
	crope@iki.fi,
	yzaikin@google.com,
	bfields@fieldses.org,
	jlayton@kernel.org,
	kernel@tuxforce.de,
	steve@sk2.org,
	nixiaoming@huawei.com,
	0x7f454c46@gmail.com,
	kuniyu@amazon.co.jp,
	alexander.h.duyck@intel.com,
	kuni1840@gmail.com,
	soheil@google.com,
	sridhar.samudrala@intel.com,
	Vincenzo.Frascino@arm.com,
	chuck.lever@oracle.com,
	Kevin.Brodsky@arm.com,
	Szabolcs.Nagy@arm.com,
	David.Laight@ACULAB.com,
	Mark.Rutland@arm.com,
	linux-morello@op-lists.linaro.org,
	Luca.Vizzarro@arm.com,
	max.kellermann@ionos.com,
	adobriyan@gmail.com,
	lukas@schauer.dev,
	j.granados@samsung.com,
	djwong@kernel.org,
	kent.overstreet@linux.dev,
	linux@weissschuh.net,
	kstewart@efficios.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping processes during pipe read/write
Date: Wed, 25 Dec 2024 17:42:02 +0800
Message-ID: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MmlYUjJe0ptcPMR7/P6f7jV09o+gNSH1qxJOxzqKL+VvIFJxLcBVzKBV
	U6yDNNgX9bPbglUzqj/q9MDFbzZ0O3Xm0Tz92WA/NsK2BhcwYVLwBAXW+TrmDUq/dODdu8Z
	bHy8ApyWcueXcNcd70DQxd6r8+8U70m0NIj5ZENsM1L6swo61939B53kVqq59UQNxKsHvKc
	8jVDXhydM3EMuP4ahjlI0bZOca/+3+NSuEm713Bf23DCRBtCIErf/HyKqj6/QbuCzp4T+Vz
	cj2THTU8bl9goRRdvY9ObNXHV5CgjW9UI//aZ3ISthF6/EgMwtxj1mSIsMh5dN4R7defHbS
	wC7rRB0IdpRcAcUVMU5M7ki1PSl1Lzdy+/lZscR+qWrYwdCx5Nfc5RvNAKS9KvxRPnRAdO5
	ai0VEcXQOG63YwYhLV2JgDoQc+74fGfzI2TvRmS1iFBVeU5ZF6/wUQHAMhxbZs0E1/hqjnQ
	tgDXImHtdH7q10tCksBok8enW6Y0xjOs1EiZZMihByt0QYHku16BYfTkp+J4+eSVA8c1tz7
	ITPZW/yXDyXH7SQCuTMQGOn/XclajrVp1d9J5e5rKfmLUshvbWa7lplsgEyZTC3Gr8sQpR+
	Qbh5L9ViqvskF0dbuaF+tmOhsps2IDVlbdXQGuyW39NPVnr+n80Q/oFsc6lbnJ2ezSR0fv1
	6NgTCSVGK60nC0jPIPTV5QUsFx4hNPbdSYEMREsHIoyD5AHmekCU2xOL6fEZwNPs7SQoXch
	TnsKBf7scuY+U61gKkgWVB7WAfsp5bVmFs/HahxH/yaZSYRtUSbIzmrHVVHedBy0m0Qar5f
	GsbZeLlCk8w6DlRRM4JVlChzI4GvRTgbzW+pIIpRt2FDIgg2xWt35EdDGEuaaIk39L6VZit
	ZSBYPAoozzel77F3raQkgLzuZQpRQMF/k0bI87SETwoYqf3lleJggy1pnOd84AtP9cDWLGk
	6IJpebZLK51aD7zy5d2pPJUovdQ0aQDfbn63ot8liVUU9Q44OVnmEZgIgCGNBLM866BYrxf
	hPCWn+1DRxSK887eRTwNsvpnvb6LuZ53gsWil+O5PuUTjRp1N5snDPFTU8T1/Hu5KMdsn4h
	6ClvOjTVELe
X-QQ-XMRINFO: M8wFrcb6n6Ii4I6kYxweyY8=
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
index 64d420e3c475..0dacc46a73fe 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -429,4 +429,17 @@ source "fs/unicode/Kconfig"
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


