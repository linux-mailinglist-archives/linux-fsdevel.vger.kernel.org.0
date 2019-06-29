Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF0AD5AADD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 14:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfF2MWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 08:22:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56414 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726892AbfF2MWj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 08:22:39 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 117EFD8CDE90E6732345;
        Sat, 29 Jun 2019 20:22:37 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sat, 29 Jun 2019
 20:22:30 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] fs: change last_ino type to unsigned long
Date:   Sat, 29 Jun 2019 20:28:13 +0800
Message-ID: <1561811293-75769-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tmpfs use get_next_ino to get inode number, if last_ino wraps,
there will be files share the same inode number. Change last_ino
type to unsigned long.

PS: Type of __old_kernel_stat->st_ino(cp_old_stat) is unsigned short
in x86 & arm, if we want to avoid an EOVERFLOW error on non LFS
stat() call, we need to change last_ino type to unsigned short

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/inode.c         | 16 +++++++---------
 include/linux/fs.h |  2 +-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index df6542e..84cf8e3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -870,22 +870,20 @@ static struct inode *find_inode_fast(struct super_block *sb,
  * 2^32 range, and is a worst-case. Even a 50% wastage would only increase
  * overflow rate by 2x, which does not seem too significant.
  *
- * On a 32bit, non LFS stat() call, glibc will generate an EOVERFLOW
- * error if st_ino won't fit in target struct field. Use 32bit counter
- * here to attempt to avoid that.
  */
 #define LAST_INO_BATCH 1024
-static DEFINE_PER_CPU(unsigned int, last_ino);
+static DEFINE_PER_CPU(unsigned long, last_ino);

-unsigned int get_next_ino(void)
+unsigned long get_next_ino(void)
 {
-	unsigned int *p = &get_cpu_var(last_ino);
-	unsigned int res = *p;
+	unsigned long *p = &get_cpu_var(last_ino);
+	unsigned long res = *p;

 #ifdef CONFIG_SMP
 	if (unlikely((res & (LAST_INO_BATCH-1)) == 0)) {
-		static atomic_t shared_last_ino;
-		int next = atomic_add_return(LAST_INO_BATCH, &shared_last_ino);
+		static atomic64_t shared_last_ino;
+		long next = atomic64_add_return(LAST_INO_BATCH,
+						&shared_last_ino);

 		res = next - LAST_INO_BATCH;
 	}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe9..51f153d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3005,7 +3005,7 @@ static inline void lockdep_annotate_inode_mutex_key(struct inode *inode) { };
 #endif
 extern void unlock_new_inode(struct inode *);
 extern void discard_new_inode(struct inode *);
-extern unsigned int get_next_ino(void);
+extern unsigned long get_next_ino(void);
 extern void evict_inodes(struct super_block *sb);

 extern void __iget(struct inode * inode);
--
2.7.4

