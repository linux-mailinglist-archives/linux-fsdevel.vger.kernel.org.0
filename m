Return-Path: <linux-fsdevel+bounces-35254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5759D3249
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 03:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF6A1F23D49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 02:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5842E482DD;
	Wed, 20 Nov 2024 02:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="dHsBbPzh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079FA28EC;
	Wed, 20 Nov 2024 02:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732070612; cv=none; b=iVNTTfEVMcn0gzJAv03+FNfVgxYzbKH4T10TzrWzAi4ooFdK1xncJ3L/U9X56sDIyFwg9qr/VY4AQClowHWGSV+AJXDcGo0c0ORLhXx/gq4Tan03IYww2/nwv7GcuFIy4cQRNpp1TCPCaiqbs9pJyB1AoCrv9Gt0NvXd9rgn/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732070612; c=relaxed/simple;
	bh=kug5e4YVcBsOeL8k3WJ3PVcn//no2KP5KTmlZU0Mxs4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IRK8USFA4mV0CGkAHeQxK+vXuj2Z4yTC+ntNwKkV+UKk3OqhSxzq2ONM9h0uOYZnlwN8mfY7zFmPzMELidY4E9XbX4kzi6iNhTDO5uUr6wDzsXBPtjY3ECYuChTpCe3wbOHfdUv6dk7CBHlw0VJE5TV47R2GSGmHxpScYUChl6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=dHsBbPzh reason="key not found in DNS"; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=/f5rV51Y71
	bWLjLNrW7c0zCiDw0koDXp1ViWezt9iPM=; b=dHsBbPzhF4lk9qLTyKaGxIeua2
	z1FKZ5jPfZ7TqChrO5slCWzdg3lpSuOPHSkIEX+lMNequRDcLNX/nsX+gmXs2Egw
	3V0Xq6oZkheiw1m5g56xVzk4DesmxnmESvu8XkKmjcs8FFMiHHy0BindFFgHWO2S
	0VqyUKP4k4pgatZag=
Received: from s1eepy-QiTianM540-A739.. (unknown [10.130.145.81])
	by coremail-app1 (Coremail) with SMTP id OCz+CgC34w28TD1n6Ek4AQ--.10964S2;
	Wed, 20 Nov 2024 10:43:11 +0800 (CST)
From: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: baijiaju1990@gmail.com,
	zhenghaoran@buaa.edu.cn,
	21371365@buaa.edu.cn
Subject: [PATCH] fs: Fix data race in inode_set_ctime_to_ts
Date: Wed, 20 Nov 2024 10:43:06 +0800
Message-Id: <20241120024306.156920-1-zhenghaoran@buaa.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:OCz+CgC34w28TD1n6Ek4AQ--.10964S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy7Zr4kKry5AFy7JFW3trb_yoW5GFWrpF
	Z0ka4fJr1UJrZ7CrZ7Kw48Xrn5Kanxta1UJrZ3Wr4fZwnxtr18KFyYvrWjyrWUCrWkCFy0
	qa48CrW5Gwn0kr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgE1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kE
	wVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x
	0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4
	AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Aw1UJr1UMxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIY
	CTnIWIevJa73UjIFyTuYvjfUouWlDUUUU
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

Signed-off-by: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
---
 include/linux/fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..d11b257a35e1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
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


