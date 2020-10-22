Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5085B29563F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 03:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442438AbgJVB7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 21:59:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15241 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2442392AbgJVB7i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 21:59:38 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5B2AA69CE9909862139D;
        Thu, 22 Oct 2020 09:59:37 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 22 Oct 2020 09:59:31 +0800
From:   Luo Meng <luomeng12@huawei.com>
To:     <jlayton@kernel.org>, <bfields@fieldses.org>,
        <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <luomeng12@huawei.com>
Subject: [PATCH] locks: Fix UBSAN undefined behaviour in flock64_to_posix_lock
Date:   Thu, 22 Oct 2020 10:03:41 +0800
Message-ID: <20201022020341.2434316-1-luomeng12@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the sum of fl->fl_start and l->l_len overflows,
UBSAN shows the following warning:

UBSAN: Undefined behaviour in fs/locks.c:482:29
signed integer overflow: 2 + 9223372036854775806
cannot be represented in type 'long long int'
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xe4/0x14e lib/dump_stack.c:118
 ubsan_epilogue+0xe/0x81 lib/ubsan.c:161
 handle_overflow+0x193/0x1e2 lib/ubsan.c:192
 flock64_to_posix_lock fs/locks.c:482 [inline]
 flock_to_posix_lock+0x595/0x690 fs/locks.c:515
 fcntl_setlk+0xf3/0xa90 fs/locks.c:2262
 do_fcntl+0x456/0xf60 fs/fcntl.c:387
 __do_sys_fcntl fs/fcntl.c:483 [inline]
 __se_sys_fcntl fs/fcntl.c:468 [inline]
 __x64_sys_fcntl+0x12d/0x180 fs/fcntl.c:468
 do_syscall_64+0xc8/0x5a0 arch/x86/entry/common.c:293
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fix it by moving -1 forward.

Signed-off-by: Luo Meng <luomeng12@huawei.com>
---
 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1f84a03601fe..8489787ca97e 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -542,7 +542,7 @@ static int flock64_to_posix_lock(struct file *filp, struct file_lock *fl,
 	if (l->l_len > 0) {
 		if (l->l_len - 1 > OFFSET_MAX - fl->fl_start)
 			return -EOVERFLOW;
-		fl->fl_end = fl->fl_start + l->l_len - 1;
+		fl->fl_end = fl->fl_start - 1 + l->l_len;
 
 	} else if (l->l_len < 0) {
 		if (fl->fl_start + l->l_len < 0)
-- 
2.25.4

