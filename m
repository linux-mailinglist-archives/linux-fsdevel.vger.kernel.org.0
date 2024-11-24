Return-Path: <linux-fsdevel+bounces-35663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FBB9D6D4A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 10:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AE37B21231
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223E9186295;
	Sun, 24 Nov 2024 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="Nvj/U7da"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825E48837;
	Sun, 24 Nov 2024 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732441392; cv=none; b=GA4wJwY9yLPpyUhnPbX8gML5RqjzlLI/OFMadAF3EMCLoL30g+AEiD+7vYfyiLwCOmok88EfYp0YgPAnBrlPhQH+3/XYbjoeWPWojWhYqucVzaitPaMKtmvrl0nbQfyj/ymP53NN29wN9hlragnf3MLeq/rnVqDGukPKaBE28Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732441392; c=relaxed/simple;
	bh=7TXrT/YIvGFUas+Vhdc4qxiauuoJFaZK/vtGnuidlNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSk8CQsg6aCiohuC44wiS46lnK3typrxlqPpyt7ENrt23EJww7LvFn5BT9hDHqyuZyYtBZ7o8/fWIe4eO1t6kEqDAIyWgLEj83hIOlF1weQSk5QYsY0tbFcEMqZRvCi7CHYFWoaGvzfoRGqONhQasG1N9WPuk6LqesOrTeEsCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=Nvj/U7da reason="key not found in DNS"; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=JbV+Q8dcL9PtWIxVmtXG/VoDrDCWDm5rp7
	REW9NDn34=; b=Nvj/U7damqFOPs8pv1tGqzPSRNuefFT9oLC/Ih7dhPVsNILU9t
	hGm9VjuaF4oD39tSW7woplndqAJG7VxvrY+JQnKwv/UWmoPFTp1Nh3sf0+b9wuBC
	eV3Ox1L1vUfZjWzPP1bldcfBh9wbo3siBLVW6Yfd1QVpSihSDXrtE/cuk=
Received: from s1eepy-QiTianM540-A739.. (unknown [10.130.145.81])
	by coremail-app1 (Coremail) with SMTP id OCz+CgBnlQ8g9UJnlgxNAQ--.24070S2;
	Sun, 24 Nov 2024 17:43:00 +0800 (CST)
From: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: baijiaju1990@gmail.com,
	zhenghaoran@buaa.edu.cn,
	21371365@buaa.edu.cn
Subject: [PATCH v4] fs: Fix data race in inode_set_ctime_to_ts
Date: Sun, 24 Nov 2024 17:42:53 +0800
Message-Id: <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:OCz+CgBnlQ8g9UJnlgxNAQ--.24070S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF17uFy8XF18Jr1xJryUGFg_yoW7Aw45pF
	ZrKa4fX3y5JFZ7Crs7tw4DWrnYganYqa1UJrZ7Wr4F9rn3tw18Kr1jy3yayF4UCrWkAryF
	qay8Kr15XrnIkr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgE1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kE
	wVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4
	vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW7tr1UJr1l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
	CTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 1v1sjjazstiqpexdthxhgxhubq/

A data race may occur when the function `inode_set_ctime_to_ts()` and
the function `inode_get_ctime_sec()` are executed concurrently. When
two threads call `aio_read` and `aio_write` respectively, they will
be distributed to the read and write functions of the corresponding
file system respectively. Taking the btrfs file system as an example,
the `btrfs_file_read_iter` and `btrfs_file_write_iter` functions are
finally called. These two functions created a data race when they
finally called `inode_get_ctime_sec()` and `inode_set_ctime_to_ns()`.
The specific call stack that appears during testing is as follows:

============DATA_RACE============
btrfs_delayed_update_inode+0x1f61/0x7ce0 [btrfs]
btrfs_update_inode+0x45e/0xbb0 [btrfs]
btrfs_dirty_inode+0x2b8/0x530 [btrfs]
btrfs_update_time+0x1ad/0x230 [btrfs]
touch_atime+0x211/0x440
filemap_read+0x90f/0xa20
btrfs_file_read_iter+0xeb/0x580 [btrfs]
aio_read+0x275/0x3a0
io_submit_one+0xd22/0x1ce0
__se_sys_io_submit+0xb3/0x250
do_syscall_64+0xc1/0x190
entry_SYSCALL_64_after_hwframe+0x77/0x7f
============OTHER_INFO============
btrfs_write_check+0xa15/0x1390 [btrfs]
btrfs_buffered_write+0x52f/0x29d0 [btrfs]
btrfs_do_write_iter+0x53d/0x1590 [btrfs]
btrfs_file_write_iter+0x41/0x60 [btrfs]
aio_write+0x41e/0x5f0
io_submit_one+0xd42/0x1ce0
__se_sys_io_submit+0xb3/0x250
do_syscall_64+0xc1/0x190
entry_SYSCALL_64_after_hwframe+0x77/0x7f

To address this issue, it is recommended to add WRITE_ONCE
and READ_ONCE when reading or writing the `inode->i_ctime_sec`
and `inode->i_ctime_nsec` variable.

Signed-off-by: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
---
V3 -> V4: Fixed patch for latest code
V2 -> V3: Added READ_ONCE in inode_get_ctime_nsec() and addressed review comments
V1 -> V2: Added READ_ONCE in inode_get_ctime_sec()
---
 fs/inode.c | 16 ++++++++--------
 fs/stat.c  |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index b13b778257ae..bfab370c8622 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2713,8 +2713,8 @@ struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 t
 {
 	trace_inode_set_ctime_to_ts(inode, &ts);
 	set_normalized_timespec64(&ts, ts.tv_sec, ts.tv_nsec);
-	inode->i_ctime_sec = ts.tv_sec;
-	inode->i_ctime_nsec = ts.tv_nsec;
+	WRITE_ONCE(inode->i_ctime_sec, ts.tv_sec);
+	WRITE_ONCE(inode->i_ctime_nsec, ts.tv_nsec);
 	return ts;
 }
 EXPORT_SYMBOL(inode_set_ctime_to_ts);
@@ -2788,7 +2788,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 	 */
 	cns = smp_load_acquire(&inode->i_ctime_nsec);
 	if (cns & I_CTIME_QUERIED) {
-		struct timespec64 ctime = { .tv_sec = inode->i_ctime_sec,
+		struct timespec64 ctime = { .tv_sec = READ_ONCE(inode->i_ctime_sec),
 					    .tv_nsec = cns & ~I_CTIME_QUERIED };
 
 		if (timespec64_compare(&now, &ctime) <= 0) {
@@ -2809,7 +2809,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 	/* Try to swap the nsec value into place. */
 	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now.tv_nsec)) {
 		/* If swap occurred, then we're (mostly) done */
-		inode->i_ctime_sec = now.tv_sec;
+		WRITE_ONCE(inode->i_ctime_sec, now.tv_sec);
 		trace_ctime_ns_xchg(inode, cns, now.tv_nsec, cur);
 		mgtime_counter_inc(mg_ctime_swaps);
 	} else {
@@ -2824,7 +2824,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 			goto retry;
 		}
 		/* Otherwise, keep the existing ctime */
-		now.tv_sec = inode->i_ctime_sec;
+		now.tv_sec = READ_ONCE(inode->i_ctime_sec);
 		now.tv_nsec = cur & ~I_CTIME_QUERIED;
 	}
 out:
@@ -2857,7 +2857,7 @@ struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 u
 	/* pairs with try_cmpxchg below */
 	cur = smp_load_acquire(&inode->i_ctime_nsec);
 	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
-	cur_ts.tv_sec = inode->i_ctime_sec;
+	cur_ts.tv_sec = READ_ONCE(inode->i_ctime_sec);
 
 	/* If the update is older than the existing value, skip it. */
 	if (timespec64_compare(&update, &cur_ts) <= 0)
@@ -2883,7 +2883,7 @@ struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 u
 retry:
 	old = cur;
 	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, update.tv_nsec)) {
-		inode->i_ctime_sec = update.tv_sec;
+		WRITE_ONCE(inode->i_ctime_sec, update.tv_sec);
 		mgtime_counter_inc(mg_ctime_swaps);
 		return update;
 	}
@@ -2899,7 +2899,7 @@ struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 u
 		goto retry;
 
 	/* Otherwise, it was a new timestamp. */
-	cur_ts.tv_sec = inode->i_ctime_sec;
+	cur_ts.tv_sec = READ_ONCE(inode->i_ctime_sec);
 	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
 	return cur_ts;
 }
diff --git a/fs/stat.c b/fs/stat.c
index 0870e969a8a0..e39c78cd62f3 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -53,7 +53,7 @@ void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
 	}
 
 	stat->mtime = inode_get_mtime(inode);
-	stat->ctime.tv_sec = inode->i_ctime_sec;
+	stat->ctime.tv_sec = READ_ONCE(inode->i_ctime_sec);
 	stat->ctime.tv_nsec = (u32)atomic_read(pcn);
 	if (!(stat->ctime.tv_nsec & I_CTIME_QUERIED))
 		stat->ctime.tv_nsec = ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn));
-- 
2.34.1


