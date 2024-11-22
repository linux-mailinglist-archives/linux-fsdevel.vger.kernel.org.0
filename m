Return-Path: <linux-fsdevel+bounces-35540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4A69D58B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 04:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2896B22A8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 03:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE357154454;
	Fri, 22 Nov 2024 03:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="p4hrFIoh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704702582;
	Fri, 22 Nov 2024 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732247544; cv=none; b=AY1usQ/r5t7CGU1f7jo2tktZ73YkiF1pnLJdVI3xoYcquiFoGjSc5nzWeAidjvvdSnoUf0qkjvetTy0LjDXLujUHEqVIacqJTsMY9Yi898xNaeTUVsUL9WA+hqd69f1ZDx+CWV8uu7lVyg/xw/ypGrPToxGpPZ7rSanHhxRs928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732247544; c=relaxed/simple;
	bh=V34Au27fs4cZLV58O5DmcrXCKBSUAAqJh3Gt38QvG/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ks5XSyTJ2KCFYvdSIP23Ku3uVH62QgDsBigBnWo71KBIpfphGTnvfPaNUKuD2CONHQYOzQeMdUwvDoBT+JTVlMGcNppmSHOfuCksUPOLt4FtTYwM6tFhRq5zQTf/ks3YGd0H89XSFDuXsue67Dog4WWszpZEC/igqDiROgihzwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=p4hrFIoh reason="key not found in DNS"; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=MPVIVjkI+MMPkOmuX3f54VoncTmxlJ2Oaf
	8xDRhd8c4=; b=p4hrFIohRrMT5PCLRNeima4yqMoafxLMwjdA1VxMJjW3BoAxOW
	4ctfZFbf18Ii1CsLbsMRnXy3+RjFXZUHHGmYy20XwSTIxMSxthQn//6BSXA3r8rJ
	f3cHpSEOqWFSwFLMHT5lXxYEIJ9yL8fXBwE+wb3Gbb+VbpgYIXoXUEOQI=
Received: from s1eepy-QiTianM540-A739.. (unknown [10.130.145.81])
	by coremail-app1 (Coremail) with SMTP id OCz+CgC35A7g_z9nIOdAAQ--.19002S2;
	Fri, 22 Nov 2024 11:52:03 +0800 (CST)
From: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: baijiaju1990@gmail.com,
	zhenghaoran@buaa.edu.cn,
	21371365@buaa.edu.cn
Subject: [PATCH v2] fs: Fix data race in inode_set_ctime_to_ts
Date: Fri, 22 Nov 2024 11:51:59 +0800
Message-Id: <20241122035159.441944-1-zhenghaoran@buaa.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241121113546.apvyb43pnuceae3g@quack3>
References: <20241121113546.apvyb43pnuceae3g@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:OCz+CgC35A7g_z9nIOdAAQ--.19002S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur1Duw1rCFWxtw47Aw18Krg_yoW5uryxpF
	ZxKa4fJr1UJrZ7GrZ7tr4UXr1Fgan8ta1UJr4kWr4fArnIyr18KFyjyry0yrWUCrWkAFy0
	qa48Cr15Gwn0yrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUy01IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kE
	wVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x
	0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF
	7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
	0Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
	6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIec
	xEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F1DJr1UJwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 1v1sjjazstiqpexdthxhgxhubq/

V2:
Thanks for Honza's reply and suggestions. READ_ONCE should indeed
be added to the reading position. I added READ_ONCE to
`inode_get_ctime_sec()`. The new patch is as follows.
-----------------------------------------------------------------
V1:
A data race may occur when the function `inode_set_ctime_to_ts()` and
the function `inode_get_ctime_sec()` are executed concurrently. When
two threads call `aio_read` and `aio_write` respectively, they will
be distributed to the read and write functions of the corresponding
file system respectively. Taking the btrfs file system as an example,
the `btrfs_file_read_iter` and `btrfs_file_write_iter` functions are
finally called. These two functions created a data race when they
finally called `inode_get_ctime_sec()` and `inode_set_ctime_to_ns()`.
The specific call stack that appears during testing is as follows:

```
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
```

The call chain after traceability is as follows:

```
Thread1:
btrfs_delayed_update_inode() ->
fill_stack_inode_item() ->
inode_get_ctime_sec()

Thread2:
btrfs_write_check() ->
update_time_for_write() ->
inode_set_ctime_to_ts()
```

To address this issue, it is recommended to
add WRITE_ONCE when writing the `inode->i_ctime_sec` variable.
--------------------------------------------------------------
Signed-off-by: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
---
 include/linux/fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..869ccfc9a787 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1655,7 +1655,7 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
 
 static inline time64_t inode_get_ctime_sec(const struct inode *inode)
 {
-	return inode->i_ctime_sec;
+	return READ_ONCE(inode->i_ctime_sec);
 }
 
 static inline long inode_get_ctime_nsec(const struct inode *inode)
@@ -1674,8 +1674,8 @@ static inline struct timespec64 inode_get_ctime(const struct inode *inode)
 static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
-	inode->i_ctime_sec = ts.tv_sec;
-	inode->i_ctime_nsec = ts.tv_nsec;
+	WRITE_ONCE(inode->i_ctime_sec, ts.tv_sec);
+	WRITE_ONCE(inode->i_ctime_nsec, ts.tv_nsec);
 	return ts;
 }
 
-- 
2.34.1


