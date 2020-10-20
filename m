Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9B42934FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 08:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404290AbgJTGaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 02:30:16 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:57538 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404268AbgJTGaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 02:30:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=zoucao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UCcdLet_1603175410;
Received: from localhost(mailfrom:zoucao@linux.alibaba.com fp:SMTPD_---0UCcdLet_1603175410)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Oct 2020 14:30:11 +0800
From:   Zou Cao <zoucao@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fs:regfs: add panic notifier callback for saving regs
Date:   Tue, 20 Oct 2020 14:30:08 +0800
Message-Id: <1603175408-96164-2-git-send-email-zoucao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603175408-96164-1-git-send-email-zoucao@linux.alibaba.com>
References: <1603175408-96164-1-git-send-email-zoucao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

register panic notifier callback for saveing regs, add a module
param regfs_panic to enable the show reg info when panic.

Signed-off-by: Zou Cao <zoucao@linux.alibaba.com>
---
 fs/regfs/inode.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/regfs/inode.c b/fs/regfs/inode.c
index 1643fcd..6c79f73 100644
--- a/fs/regfs/inode.c
+++ b/fs/regfs/inode.c
@@ -46,10 +46,41 @@
 static LIST_HEAD(regfs_head);
 
 static const struct inode_operations regfs_dir_inode_operations;
-int regfs_debug;
+int regfs_debug = 1;
 module_param(regfs_debug, int, S_IRUGO);
 MODULE_PARM_DESC(regfs_debug, "enable regfs debug mode");
 
+static int regfs_panic = 1;
+module_param(regfs_panic, int, S_IRUGO);
+MODULE_PARM_DESC(regfs_debug, "printk the register when panic");
+
+//save all register val when panic
+static int regfs_panic_event(struct notifier_block *self,
+		 unsigned long val, void *data)
+{
+	struct regfs_fs_info *fsi;
+	struct inode *inode, *next;
+
+
+	list_for_each_entry(fsi, &regfs_head, regfs_head) {
+		list_for_each_entry_safe(inode, next, &fsi->sb->s_inodes, i_sb_list) {
+			struct regfs_inode_info *info =  REGFS_I(inode);;
+			//save the regs val
+			if (info->type == RES_TYPE_ITEM) {
+				info->val = readl_relaxed(info->base + info->offset);
+				if (regfs_panic)
+					printk("%llx:%llx\n", (u64)(info->base + info->offset), info->val);
+			}
+		}
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block regfs_panic_event_nb = {
+	.notifier_call   = regfs_panic_event,
+};
+
 struct inode *regfs_get_inode(struct super_block *sb, const struct inode *dir, umode_t mode, dev_t dev)
 {
 	struct inode *inode = new_inode(sb);
@@ -328,6 +359,7 @@ static void init_once(void *foo)
 
 static int __init init_regfs_fs(void)
 {
+	int ret;
 
 	regfs_inode_cachep = kmem_cache_create_usercopy("regfs_inode_cache",
 				sizeof(struct regfs_inode_info), 0,
@@ -337,11 +369,16 @@ static int __init init_regfs_fs(void)
 	if (!regfs_inode_cachep)
 		return -ENOMEM;
 
+	ret = atomic_notifier_chain_register(&panic_notifier_list, &regfs_panic_event_nb);
+	if (ret)
+		pr_warn("regfs regiter panic notifier failed\n");
+
 	return  register_filesystem(&regfs_fs_type);
 }
 
 static void __exit exit_regfs_fs(void)
 {
+	atomic_notifier_chain_unregister(&panic_notifier_list, &regfs_panic_event_nb);
 	unregister_filesystem(&regfs_fs_type);
 	rcu_barrier();
 	kmem_cache_destroy(regfs_inode_cachep);
-- 
1.8.3.1

