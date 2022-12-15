Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F5C64D71B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 08:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiLOHPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 02:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiLOHOm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:14:42 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6090329351;
        Wed, 14 Dec 2022 23:14:36 -0800 (PST)
Received: from kwepemm600015.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NXk3f2GrTzmWbP;
        Thu, 15 Dec 2022 15:13:34 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 15:14:33 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <bvanassche@acm.org>, <slava@dubeyko.com>,
        <akpm@linux-foundation.org>, <gargaditya08@live.com>,
        <axboe@kernel.dk>, <chenxiaosong2@huawei.com>,
        <willy@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <jlayton@kernel.org>, <hannes@cmpxchg.org>, <tytso@mit.edu>,
        <muchun.song@linux.dev>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] hfsplus: fix uninit-value in hfsplus_delete_cat()
Date:   Thu, 15 Dec 2022 16:18:20 +0800
Message-ID: <20221215081820.948990-3-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221215081820.948990-1-chenxiaosong2@huawei.com>
References: <20221215081820.948990-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Syzkaller reported BUG as follows:

  =====================================================
  BUG: KMSAN: uninit-value in hfsplus_subfolders_dec
                              fs/hfsplus/catalog.c:248 [inline]
  BUG: KMSAN: uninit-value in hfsplus_delete_cat+0x1207/0x14d0
                              fs/hfsplus/catalog.c:419
   hfsplus_subfolders_dec fs/hfsplus/catalog.c:248 [inline]
   hfsplus_delete_cat+0x1207/0x14d0 fs/hfsplus/catalog.c:419
   hfsplus_rmdir+0x141/0x3d0 fs/hfsplus/dir.c:425
   hfsplus_rename+0x102/0x2e0 fs/hfsplus/dir.c:545
   vfs_rename+0x1e4c/0x2800 fs/namei.c:4779
   do_renameat2+0x173d/0x1dc0 fs/namei.c:4930
   __do_sys_renameat2 fs/namei.c:4963 [inline]
   __se_sys_renameat2 fs/namei.c:4960 [inline]
   __ia32_sys_renameat2+0x14b/0x1f0 fs/namei.c:4960
   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
   __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
   do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
   do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
   entry_SYSENTER_compat_after_hwframe+0x70/0x82

  Uninit was stored to memory at:
   hfsplus_subfolders_inc fs/hfsplus/catalog.c:232 [inline]
   hfsplus_create_cat+0x19e3/0x19f0 fs/hfsplus/catalog.c:314
   hfsplus_mknod+0x1fd/0x560 fs/hfsplus/dir.c:494
   hfsplus_mkdir+0x54/0x60 fs/hfsplus/dir.c:529
   vfs_mkdir+0x62a/0x870 fs/namei.c:4036
   do_mkdirat+0x466/0x7b0 fs/namei.c:4061
   __do_sys_mkdirat fs/namei.c:4076 [inline]
   __se_sys_mkdirat fs/namei.c:4074 [inline]
   __ia32_sys_mkdirat+0xc4/0x120 fs/namei.c:4074
   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
   __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
   do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
   do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
   entry_SYSENTER_compat_after_hwframe+0x70/0x82

  Uninit was created at:
   __alloc_pages+0x9f1/0xe80 mm/page_alloc.c:5581
   alloc_pages+0xaae/0xd80 mm/mempolicy.c:2285
   alloc_slab_page mm/slub.c:1794 [inline]
   allocate_slab+0x1b5/0x1010 mm/slub.c:1939
   new_slab mm/slub.c:1992 [inline]
   ___slab_alloc+0x10c3/0x2d60 mm/slub.c:3180
   __slab_alloc mm/slub.c:3279 [inline]
   slab_alloc_node mm/slub.c:3364 [inline]
   slab_alloc mm/slub.c:3406 [inline]
   __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
   kmem_cache_alloc_lru+0x6f3/0xb30 mm/slub.c:3429
   alloc_inode_sb include/linux/fs.h:3125 [inline]
   hfsplus_alloc_inode+0x56/0xc0 fs/hfsplus/super.c:627
   alloc_inode+0x83/0x440 fs/inode.c:259
   iget_locked+0x2a1/0xe20 fs/inode.c:1286
   hfsplus_iget+0x5f/0xb60 fs/hfsplus/super.c:64
   hfsplus_btree_open+0x13b/0x1cf0 fs/hfsplus/btree.c:150
   hfsplus_fill_super+0x12b0/0x2a80 fs/hfsplus/super.c:473
   mount_bdev+0x508/0x840 fs/super.c:1401
   hfsplus_mount+0x49/0x60 fs/hfsplus/super.c:641
   legacy_get_tree+0x10c/0x280 fs/fs_context.c:610
   vfs_get_tree+0xa1/0x500 fs/super.c:1531
   do_new_mount+0x694/0x1580 fs/namespace.c:3040
   path_mount+0x71a/0x1eb0 fs/namespace.c:3370
   do_mount fs/namespace.c:3383 [inline]
   __do_sys_mount fs/namespace.c:3591 [inline]
   __se_sys_mount+0x734/0x840 fs/namespace.c:3568
   __ia32_sys_mount+0xdf/0x140 fs/namespace.c:3568
   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
   __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
   do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
   do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
   entry_SYSENTER_compat_after_hwframe+0x70/0x82
  =====================================================

Fix this by initializing 'subfolders' of 'struct hfsplus_inode_info'
in hfsplus_iget().

Link: https://syzkaller.appspot.com/bug?id=981f82f21b973f2f5663dfea581ff8cee1ddfef2
Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/hfsplus/super.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 122ed89ebf9f..5812818759dd 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -67,13 +67,7 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 	if (!(inode->i_state & I_NEW))
 		return inode;
 
-	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
-	spin_lock_init(&HFSPLUS_I(inode)->open_dir_lock);
-	mutex_init(&HFSPLUS_I(inode)->extents_lock);
-	HFSPLUS_I(inode)->flags = 0;
-	HFSPLUS_I(inode)->extent_state = 0;
-	HFSPLUS_I(inode)->rsrc_inode = NULL;
-	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
+	hfsplus_init_inode(HFSPLUS_I(inode));
 
 	if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID ||
 	    inode->i_ino == HFSPLUS_ROOT_CNID) {
-- 
2.31.1

