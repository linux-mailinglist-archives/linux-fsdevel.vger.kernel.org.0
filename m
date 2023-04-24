Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578396EC487
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 06:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjDXEvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 00:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjDXEvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 00:51:50 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D442D48;
        Sun, 23 Apr 2023 21:51:46 -0700 (PDT)
X-UUID: 886b32d10673477db2b5947a0d3fb511-20230424
X-CID-CACHE: Type:Local,Time:202304241246+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:b652d489-1d09-4d14-a81f-45cbe1d5f83f,IP:5,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-35
X-CID-INFO: VERSION:1.1.22,REQID:b652d489-1d09-4d14-a81f-45cbe1d5f83f,IP:5,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-35
X-CID-META: VersionHash:120426c,CLOUDID:c96be9eb-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:24|17|19|44|38|102,TC:nil,Content:0,
        EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 886b32d10673477db2b5947a0d3fb511-20230424
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2085282739; Mon, 24 Apr 2023 12:51:39 +0800
From:   Hao Ge <gehao@kylinos.cn>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gehao618@163.com, Hao Ge <gehao@kylinos.cn>
Subject: [PATCH V2] fs: fix undefined behavior in bit shift for SB_NOUSER
Date:   Mon, 24 Apr 2023 12:51:22 +0800
Message-Id: <20230424045122.370511-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230424030005.363457-1-gehao@kylinos.cn>
References: <20230424030005.363457-1-gehao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shifting signed 32-bit value by 31 bits is undefined, so changing
significant bit to unsigned. The UBSAN warning calltrace like below:

UBSAN: shift-out-of-bounds in fs/nsfs.c:306:32
left shift of 1 by 31 places cannot be represented in type 'int'
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-rc4+ #2
Call trace:
<TASK>
dump_backtrace+0x134/0x1e0
show_stack+0x2c/0x3c
dump_stack_lvl+0xb0/0xd4
dump_stack+0x14/0x1c
ubsan_epilogue+0xc/0x3c
__ubsan_handle_shift_out_of_bounds+0xb0/0x14c
nsfs_init+0x4c/0xb0
start_kernel+0x38c/0x738
__primary_switched+0xbc/0xc4
</TASK>

Fixes: e462ec50cb5f ("VFS: Differentiate mount flags (MS_*) from internal superblock flags")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---

v2: add Fixes for changelog
---
 include/linux/fs.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..86ab23a05b61 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1069,19 +1069,19 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NOATIME	1024	/* Do not update access times. */
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
-#define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
-#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
-#define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
-#define SB_I_VERSION	(1<<23) /* Update inode I_version field */
-#define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
+#define SB_POSIXACL	(1U<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1U<<17)	/* Use blk-crypto for encrypted files */
+#define SB_KERNMOUNT	(1U<<22) /* this is a kern_mount call */
+#define SB_I_VERSION	(1U<<23) /* Update inode I_version field */
+#define SB_LAZYTIME	(1U<<25) /* Update the on-disk [acm]times lazily */
 
 /* These sb flags are internal to the kernel */
-#define SB_SUBMOUNT     (1<<26)
-#define SB_FORCE    	(1<<27)
-#define SB_NOSEC	(1<<28)
-#define SB_BORN		(1<<29)
-#define SB_ACTIVE	(1<<30)
-#define SB_NOUSER	(1<<31)
+#define SB_SUBMOUNT     (1U<<26)
+#define SB_FORCE	(1U<<27)
+#define SB_NOSEC	(1U<<28)
+#define SB_BORN		(1U<<29)
+#define SB_ACTIVE	(1U<<30)
+#define SB_NOUSER	(1U<<31)
 
 /* These flags relate to encoding and casefolding */
 #define SB_ENC_STRICT_MODE_FL	(1 << 0)
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
