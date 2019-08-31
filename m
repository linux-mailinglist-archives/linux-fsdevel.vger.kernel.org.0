Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 218F3A43DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 11:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfHaJ7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 05:59:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46504 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726679AbfHaJ7t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 05:59:49 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0D4B4AD86143BB26683F;
        Sat, 31 Aug 2019 17:59:47 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Sat, 31 Aug 2019 17:59:37 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <adobriyan@gmail.com>, <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <houtao1@huawei.com>
Subject: [PATCH] proc: fix ubsan waring in mem_lseek
Date:   Sat, 31 Aug 2019 18:06:15 +0800
Message-ID: <20190831100615.41132-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

UBSAN has reported a overflow with mem_lseek. And it's fine with
mem_open set file mode with FMODE_UNSIGNED_OFFSET(memory_lseek).
However, another file use mem_lseek do lseek can have not
FMODE_UNSIGNED_OFFSET(proc_kpagecount_operations/proc_pagemap_operations),
fix it by checking overflow and FMODE_UNSIGNED_OFFSET.

==================================================================
UBSAN: Undefined behaviour in ../fs/proc/base.c:941:15
signed integer overflow:
4611686018427387904 + 4611686018427387904 cannot be represented in type 'long long int'
CPU: 4 PID: 4762 Comm: syz-executor.1 Not tainted 4.4.189 #3
Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
Call trace:
[<ffffff90080a5f28>] dump_backtrace+0x0/0x590 arch/arm64/kernel/traps.c:91
[<ffffff90080a64f0>] show_stack+0x38/0x60 arch/arm64/kernel/traps.c:234
[<ffffff9008986a34>] __dump_stack lib/dump_stack.c:15 [inline]
[<ffffff9008986a34>] dump_stack+0x128/0x184 lib/dump_stack.c:51
[<ffffff9008a2d120>] ubsan_epilogue+0x34/0x9c lib/ubsan.c:166
[<ffffff9008a2d8b8>] handle_overflow+0x228/0x280 lib/ubsan.c:197
[<ffffff9008a2da2c>] __ubsan_handle_add_overflow+0x4c/0x68 lib/ubsan.c:204
[<ffffff900862b9f4>] mem_lseek+0x12c/0x130 fs/proc/base.c:941
[<ffffff90084ef78c>] vfs_llseek fs/read_write.c:260 [inline]
[<ffffff90084ef78c>] SYSC_lseek fs/read_write.c:285 [inline]
[<ffffff90084ef78c>] SyS_lseek+0x164/0x1f0 fs/read_write.c:276
[<ffffff9008093c80>] el0_svc_naked+0x30/0x34
==================================================================

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/proc/base.c     | 20 +++++++++++++++-----
 fs/read_write.c    |  5 -----
 include/linux/fs.h |  5 +++++
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea950..61c9a0a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -882,16 +882,26 @@ static ssize_t mem_write(struct file *file, const char __user *buf,
 
 loff_t mem_lseek(struct file *file, loff_t offset, int orig)
 {
+	spin_lock(&file->f_lock);
 	switch (orig) {
-	case 0:
-		file->f_pos = offset;
-		break;
-	case 1:
-		file->f_pos += offset;
+	case SEEK_CUR:
+		offset += file->f_pos;
+		/* fall through */
+	case SEEK_SET:
+		/* to avoid userland mistaking f_pos=-9 as -EBADF=-9 */
+		if ((unsigned long long)offset >= -MAX_ERRNO)
+			return -EOVERFLOW;
+
 		break;
 	default:
 		return -EINVAL;
 	}
+
+	if (offset < 0 && !(unsigned_offsets(file)))
+		return -EINVAL;
+
+	file->f_pos = offset;
+	spin_unlock(&file->f_lock);
 	force_successful_syscall_return();
 	return file->f_pos;
 }
diff --git a/fs/read_write.c b/fs/read_write.c
index 5bbf587..961966e 100644
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
index 997a530..e5edbc9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3074,6 +3074,11 @@ extern void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
 extern loff_t noop_llseek(struct file *file, loff_t offset, int whence);
 extern loff_t no_llseek(struct file *file, loff_t offset, int whence);
+static inline bool unsigned_offsets(struct file *file)
+{
+	return file->f_mode & FMODE_UNSIGNED_OFFSET;
+}
+
 extern loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize);
 extern loff_t generic_file_llseek(struct file *file, loff_t offset, int whence);
 extern loff_t generic_file_llseek_size(struct file *file, loff_t offset,
-- 
2.9.5

