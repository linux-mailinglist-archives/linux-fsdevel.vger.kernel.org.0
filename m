Return-Path: <linux-fsdevel+bounces-35579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF129D5F80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 14:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61529B22FF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 13:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA911DEFE0;
	Fri, 22 Nov 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="N7I7W+2Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BFE1D86C4;
	Fri, 22 Nov 2024 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280827; cv=none; b=CY7UPyxSeag2k89wlH2R/gqDWw/Ly0xc5qf7DQYE1wrWTCNIkp7t4BW58IMc+1G3d9uQj6FvQeqAThrFV4SYdDeiElJnAjcwRl4kBcwaKMuKQebK+aWzir+dQWg71WIoQD9+2hI16dwBSqtEG61XmER3ws2vtxal4Q5y1d1DtcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280827; c=relaxed/simple;
	bh=x7tFZcZy7XSEazP6YWhgtnVxbuaNUGiVwGGms/rTpw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DNebq8wE8fKUi9s7Lr3e62VyLW0qw8amm08PcrLBk7TQdIuM3zFjsaPWH7dzkY7NmtH0W1pC7AIcQu4KfGzj6UD0oumEB3A3IkZGD/cGao21FQj6z7uqxb7tZxzHY6Uw+WVfvZ0gRlt5Myk9Wfx64Xebn+4LkY1wiYeGUs/p+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=N7I7W+2Y reason="key not found in DNS"; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=cO962UiYVYKGBhx79KwrZuQCf+O4p104xI
	fPYBbWRu8=; b=N7I7W+2YqAh5NK+NHX5HUx+vGfPFccrTW6y+yv3rBbLmwF0JUJ
	fYAAg51QzOqhoaDG8ASDE81MdQCOsmn6QyR244WF/waZwNe7t0uH+EViHZwKaj8K
	oEsLQYGx/b/Mc1gF2VwG0ltAhwuSEOZ3jOGCI57SktDTEXI+/gX2isd5A=
Received: from s1eepy-QiTianM540-A739.. (unknown [10.130.145.81])
	by coremail-app1 (Coremail) with SMTP id OCz+CgDXBRDjgUBng+1CAQ--.19878S2;
	Fri, 22 Nov 2024 21:06:46 +0800 (CST)
From: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: baijiaju1990@gmail.com,
	zhenghaoran@buaa.edu.cn,
	21371365@buaa.edu.cn
Subject: [PATCH v3] fs: Fix data race in inode_set_ctime_to_ts
Date: Fri, 22 Nov 2024 21:06:42 +0800
Message-Id: <20241122130642.460929-1-zhenghaoran@buaa.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122112228.6him45jdtibue26s@quack3>
References: <20241122112228.6him45jdtibue26s@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:OCz+CgDXBRDjgUBng+1CAQ--.19878S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1UKF18Zr48Xw47Xw17trb_yoW5CFW5pF
	Z0ka4fJr1UJrZ7GrZ7tr4UWrnYganxta1UJrZ7Wr4fuFnrtw18KFyjvry2yr4UCrWkAFy0
	qay8CF15GwnIkw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyj1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kE
	wVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x
	0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4
	AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Aw1UJr1UMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
	cSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
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
when writing the `inode->i_ctime_sec` variable.and add
READ_ONCE when reading in function `inode_get_ctime_sec()`
and `inode_get_ctime_nsec()`.

Signed-off-by: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
---
V2 -> V3: Added READ_ONCE in inode_get_ctime_nsec() and addressed review comments
V1 -> V2: Added READ_ONCE in inode_get_ctime_sec()
---
 include/linux/fs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..c18f9a9ee5e7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1655,12 +1655,12 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
 
 static inline time64_t inode_get_ctime_sec(const struct inode *inode)
 {
-	return inode->i_ctime_sec;
+	return READ_ONCE(inode->i_ctime_sec);
 }
 
 static inline long inode_get_ctime_nsec(const struct inode *inode)
 {
-	return inode->i_ctime_nsec;
+	return READ_ONCE(inode->i_ctime_nsec);
 }
 
 static inline struct timespec64 inode_get_ctime(const struct inode *inode)
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


