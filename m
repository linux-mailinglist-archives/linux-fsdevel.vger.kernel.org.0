Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703177480E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 11:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjGEJeI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 5 Jul 2023 05:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEJeH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:34:07 -0400
X-Greylist: delayed 1089 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Jul 2023 02:34:04 PDT
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD691711
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jul 2023 02:34:04 -0700 (PDT)
Received: from w012.hihonor.com (unknown [10.68.27.189])
        by mta22.hihonor.com (SkyGuard) with ESMTPS id 4QwvCS4ycXzYl0V5;
        Wed,  5 Jul 2023 17:15:48 +0800 (CST)
Received: from a004.hihonor.com (10.68.27.131) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 5 Jul
 2023 17:15:52 +0800
Received: from a001.hihonor.com (10.68.28.182) by a004.hihonor.com
 (10.68.27.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 5 Jul
 2023 17:15:52 +0800
Received: from a001.hihonor.com ([fe80::d540:a176:80f8:5fcf]) by
 a001.hihonor.com ([fe80::d540:a176:80f8:5fcf%8]) with mapi id 15.02.1118.021;
 Wed, 5 Jul 2023 17:15:52 +0800
From:   gaoming <gaoming20@hihonor.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC:     "open list:EXFAT FILE SYSTEM" <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        fengbaopeng <fengbaopeng@hihonor.com>,
        gaoxu <gaoxu2@hihonor.com>,
        wangfei 00014658 <wangfei66@hihonor.com>,
        "shenchen 00013118" <harry.shen@hihonor.com>
Subject: [PATCH] exfat: use kvmalloc_array/kvfree instead of
 kmalloc_array/kfree
Thread-Topic: [PATCH] exfat: use kvmalloc_array/kvfree instead of
 kmalloc_array/kfree
Thread-Index: AdmvHl4gs76xLNH6Sd+soB17KujxsA==
Date:   Wed, 5 Jul 2023 09:15:52 +0000
Message-ID: <4cec63dcd3c0443c928800ffeec9118c@hihonor.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.164.15.53]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The call stack shown below is a scenario in the Linux 4.19 kernel.
Allocating memory failed where exfat fs use kmalloc_array due 
to system memory fragmentation, while the u-disk was inserted
without recognition.
Devices such as u-disk using the exfat file system are pluggable and may be
insert into the system at any time.
However, long-term running systems cannot guarantee the continuity of 
physical memory. Therefore, it's necessary to address this issue.

Binder:2632_6: page allocation failure: order:4,
mode:0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
Call trace:
[242178.097582]  dump_backtrace+0x0/0x4
[242178.097589]  dump_stack+0xf4/0x134
[242178.097598]  warn_alloc+0xd8/0x144
[242178.097603]  __alloc_pages_nodemask+0x1364/0x1384
[242178.097608]  kmalloc_order+0x2c/0x510
[242178.097612]  kmalloc_order_trace+0x40/0x16c
[242178.097618]  __kmalloc+0x360/0x408
[242178.097624]  load_alloc_bitmap+0x160/0x284
[242178.097628]  exfat_fill_super+0xa3c/0xe7c
[242178.097635]  mount_bdev+0x2e8/0x3a0
[242178.097638]  exfat_fs_mount+0x40/0x50
[242178.097643]  mount_fs+0x138/0x2e8
[242178.097649]  vfs_kern_mount+0x90/0x270
[242178.097655]  do_mount+0x798/0x173c
[242178.097659]  ksys_mount+0x114/0x1ac
[242178.097665]  __arm64_sys_mount+0x24/0x34
[242178.097671]  el0_svc_common+0xb8/0x1b8
[242178.097676]  el0_svc_handler+0x74/0x90
[242178.097681]  el0_svc+0x8/0x340

By analyzing the exfat code,we found that continuous physical memory is
not required here,so kvmalloc_array is used can solve this problem.

Signed-off-by: gaoming <gaoming20@hihonor.com>
---
 fs/exfat/balloc.c | 4 ++--
 fs/exfat/dir.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 9f42f25fab92..a183558cb7a0 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -69,7 +69,7 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 	}
 	sbi->map_sectors = ((need_map_size - 1) >>
 			(sb->s_blocksize_bits)) + 1;
-	sbi->vol_amap = kmalloc_array(sbi->map_sectors,
+	sbi->vol_amap = kvmalloc_array(sbi->map_sectors,
 				sizeof(struct buffer_head *), GFP_KERNEL);
 	if (!sbi->vol_amap)
 		return -ENOMEM;
@@ -84,7 +84,7 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 			while (j < i)
 				brelse(sbi->vol_amap[j++]);
 
-			kfree(sbi->vol_amap);
+			kvfree(sbi->vol_amap);
 			sbi->vol_amap = NULL;
 			return -EIO;
 		}
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 957574180a5e..5cbb78d0a2a2 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -649,7 +649,7 @@ int exfat_put_dentry_set(struct exfat_entry_set_cache *es, int sync)
 			brelse(es->bh[i]);
 
 	if (IS_DYNAMIC_ES(es))
-		kfree(es->bh);
+		kvfree(es->bh);
 
 	return err;
 }
@@ -888,7 +888,7 @@ int exfat_get_dentry_set(struct exfat_entry_set_cache *es,
 
 	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
 	if (num_bh > ARRAY_SIZE(es->__bh)) {
-		es->bh = kmalloc_array(num_bh, sizeof(*es->bh), GFP_KERNEL);
+		es->bh = kvmalloc_array(num_bh, sizeof(*es->bh), GFP_KERNEL);
 		if (!es->bh) {
 			brelse(bh);
 			return -ENOMEM;
-- 
2.17.1

