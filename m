Return-Path: <linux-fsdevel+bounces-2458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452DE7E6236
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 03:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D802CB20EC2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 02:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02F52FAE;
	Thu,  9 Nov 2023 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F94D27D
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 02:32:25 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBF0210E;
	Wed,  8 Nov 2023 18:32:25 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SQm8Y1vPYzPpBr;
	Thu,  9 Nov 2023 10:28:13 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 9 Nov 2023 10:32:16 +0800
From: WoZ1zh1 <wozizhi@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<akpm@linux-foundation.org>, <oleg@redhat.com>, <jlayton@kernel.org>,
	<dchinner@redhat.com>, <cyphar@cyphar.com>, <shr@devkernel.io>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<wozizhi@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH -next V2] proc: support file->f_pos checking in mem_lseek
Date: Thu, 9 Nov 2023 18:26:58 +0800
Message-ID: <20231109102658.2075547-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500020.china.huawei.com (7.185.36.49)
X-CFilter-Loop: Reflected

In mem_lseek, file->f_pos may overflow. And it's not a problem that
mem_open set file mode with FMODE_UNSIGNED_OFFSET(memory_lseek). However,
another file use mem_lseek do lseek can have not FMODE_UNSIGNED_OFFSET
(kpageflags_proc_ops/proc_pagemap_operations...), so in order to prevent
file->f_pos updated to an abnormal number, fix it by checking overflow and
FMODE_UNSIGNED_OFFSET.

Signed-off-by: WoZ1zh1 <wozizhi@huawei.com>
---
 fs/proc/base.c     | 30 ++++++++++++++++++++++--------
 fs/read_write.c    |  5 -----
 include/linux/fs.h |  5 ++++-
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index dd31e3b6bf77..0fd986e861d9 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -903,18 +903,32 @@ static ssize_t mem_write(struct file *file, const char __user *buf,
 
 loff_t mem_lseek(struct file *file, loff_t offset, int orig)
 {
+	loff_t ret = 0;
+
+	spin_lock(&file->f_lock);
 	switch (orig) {
-	case 0:
-		file->f_pos = offset;
-		break;
-	case 1:
-		file->f_pos += offset;
+	case SEEK_CUR:
+		offset += file->f_pos;
+	case SEEK_SET:
+		/* to avoid userland mistaking f_pos=-9 as -EBADF=-9 */
+		if ((unsigned long long)offset >= -MAX_ERRNO)
+			ret = -EOVERFLOW;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
-	force_successful_syscall_return();
-	return file->f_pos;
+	if (!ret) {
+		if (offset < 0 && !(unsigned_offsets(file))) {
+			ret = -EINVAL;
+		} else {
+			file->f_pos = offset;
+			ret = file->f_pos;
+			force_successful_syscall_return();
+		}
+	}
+
+	spin_unlock(&file->f_lock);
+	return ret;
 }
 
 static int mem_release(struct inode *inode, struct file *file)
diff --git a/fs/read_write.c b/fs/read_write.c
index 4771701c896b..2f456d5a1df5 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -34,11 +34,6 @@ const struct file_operations generic_ro_fops = {
 
 EXPORT_SYMBOL(generic_ro_fops);
 
-static inline bool unsigned_offsets(struct file *file)
-{
-	return file->f_mode & FMODE_UNSIGNED_OFFSET;
-}
-
 /**
  * vfs_setpos - update the file offset for lseek
  * @file:	file structure in question
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..dde0756d2350 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2994,7 +2994,10 @@ extern ssize_t iter_file_splice_write(struct pipe_inode_info *,
 extern long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
 		loff_t *opos, size_t len, unsigned int flags);
 
-
+static inline bool unsigned_offsets(struct file *file)
+{
+	return file->f_mode & FMODE_UNSIGNED_OFFSET;
+}
 extern void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
 extern loff_t noop_llseek(struct file *file, loff_t offset, int whence);
-- 
2.39.2


