Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815D26385F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 10:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiKYJO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 04:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKYJOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:14:51 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0510313E9F;
        Fri, 25 Nov 2022 01:14:50 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NJTh24qjfzHtd9;
        Fri, 25 Nov 2022 17:14:10 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 17:14:48 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 17:14:48 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 2/2] fs: clear a UBSAN shift-out-of-bounds warning
Date:   Fri, 25 Nov 2022 17:13:58 +0800
Message-ID: <20221125091358.1963-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20221125091358.1963-1-thunder.leizhen@huawei.com>
References: <20221125091358.1963-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

UBSAN: shift-out-of-bounds in fs/locks.c:2572:16
left shift of 1 by 63 places cannot be represented in type 'long long int'
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
 ubsan_epilogue+0xa/0x44 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds+0x1e7/0x208 lib/ubsan.c:322
 locks_remove_posix+0xba/0x290 fs/locks.c:2572
 filp_close+0x61/0xa0 fs/open.c:1424
 close_fd+0x56/0x70 fs/file.c:664
 __do_sys_close fs/open.c:1439 [inline]
 __se_sys_close fs/open.c:1437 [inline]
 __x64_sys_close+0x1a/0x50 fs/open.c:1437
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
</TASK>

INT_LIMIT() tries to do what type_max() does, except that type_max()
doesn't rely upon undefined behaviour, might as well use type_max()
instead.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/fs.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e654435f16512c1..a384741b1449457 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1131,9 +1131,8 @@ struct file_lock_context {
 
 /* The following constant reflects the upper bound of the file/locking space */
 #ifndef OFFSET_MAX
-#define INT_LIMIT(x)	(~((x)1 << (sizeof(x)*8 - 1)))
-#define OFFSET_MAX	INT_LIMIT(loff_t)
-#define OFFT_OFFSET_MAX	INT_LIMIT(off_t)
+#define OFFSET_MAX	type_max(loff_t)
+#define OFFT_OFFSET_MAX	type_max(off_t)
 #endif
 
 extern void send_sigio(struct fown_struct *fown, int fd, int band);
-- 
2.25.1

