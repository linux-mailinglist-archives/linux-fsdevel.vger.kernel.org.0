Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3616361385A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 14:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiJaNsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 09:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiJaNsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:48:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5FD101FD
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 06:48:14 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1Dsj2M67zpW4W;
        Mon, 31 Oct 2022 21:44:41 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 21:48:12 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <hch@infradead.org>, <viro@zeniv.linux.org.uk>,
        <dhowells@redhat.com>, <cuigaosheng1@huawei.com>
CC:     <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2] fs: fix undefined behavior in bit shift for SB_NOUSER
Date:   Mon, 31 Oct 2022 21:48:11 +0800
Message-ID: <20221031134811.178127-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shifting signed 32-bit value by 31 bits is undefined, so changing most
significant bit to unsigned, and mark all of the flags as unsigned so
that we don't mix types. The UBSAN warning calltrace like below:

UBSAN: shift-out-of-bounds in fs/namespace.c:2330:33
left shift of 1 by 31 places cannot be represented in type 'int'
Call Trace:
 <TASK>
 dump_stack_lvl+0x7d/0xa5
 dump_stack+0x15/0x1b
 ubsan_epilogue+0xe/0x4e
 __ubsan_handle_shift_out_of_bounds+0x1e7/0x20c
 graft_tree+0x36/0xf0
 do_add_mount+0x98/0x100
 path_mount+0xbd6/0xd50
 init_mount+0x6a/0xa3
 devtmpfs_setup+0x47/0x7e
 devtmpfsd+0x1a/0x50
 kthread+0x126/0x160
 ret_from_fork+0x1f/0x30
 </TASK>

Fixes: e462ec50cb5f ("VFS: Differentiate mount flags (MS_*) from internal superblock flags")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
v2:
- Mark all of the flags as unsigned instead of just one so that
- we don't mix types, and add the proper whitespaces around the
- shift operator everywhere, thanks!
 include/linux/fs.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index fa5ba1b1cbcd..0e92a85e212f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1384,19 +1384,19 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NOATIME	1024	/* Do not update access times. */
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
-#define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
-#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
-#define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
-#define SB_I_VERSION	(1<<23) /* Update inode I_version field */
-#define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
+#define SB_POSIXACL	(1U << 16) /* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1U << 17) /* Use blk-crypto for encrypted files */
+#define SB_KERNMOUNT	(1U << 22) /* this is a kern_mount call */
+#define SB_I_VERSION	(1U << 23) /* Update inode I_version field */
+#define SB_LAZYTIME	(1U << 25) /* Update the on-disk [acm]times lazily */
 
 /* These sb flags are internal to the kernel */
-#define SB_SUBMOUNT     (1<<26)
-#define SB_FORCE    	(1<<27)
-#define SB_NOSEC	(1<<28)
-#define SB_BORN		(1<<29)
-#define SB_ACTIVE	(1<<30)
-#define SB_NOUSER	(1<<31)
+#define SB_SUBMOUNT	(1U << 26)
+#define SB_FORCE	(1U << 27)
+#define SB_NOSEC	(1U << 28)
+#define SB_BORN		(1U << 29)
+#define SB_ACTIVE	(1U << 30)
+#define SB_NOUSER	(1U << 31)
 
 /* These flags relate to encoding and casefolding */
 #define SB_ENC_STRICT_MODE_FL	(1 << 0)
-- 
2.25.1

