Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC7E23B5FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 09:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgHDHq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 03:46:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727887AbgHDHq7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:46:59 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 11CC1270000FDC330E46;
        Tue,  4 Aug 2020 15:46:57 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 4 Aug 2020
 15:46:47 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <willy@infradead.org>, <hch@lst.de>, <yangyingliang@huawei.com>
Subject: [PATCH -next] sysctl: fix memleak in proc_sys_call_handler()
Date:   Tue, 4 Aug 2020 15:45:03 +0000
Message-ID: <20200804154503.3863200-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I got a memleak report when doing some fuzz test:

BUG: memory leak
unreferenced object 0xffff888103f3da00 (size 64):
comm "syz-executor.0", pid 2270, jiffies 4295404698 (age 46.593s)
hex dump (first 32 bytes):
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
backtrace:
[<000000004f2c0607>] kmalloc include/linux/slab.h:559 [inline]
[<000000004f2c0607>] kzalloc include/linux/slab.h:666 [inline]
[<000000004f2c0607>] proc_sys_call_handler+0x1d4/0x480 fs/proc/proc_sysctl.c:574
[<000000005ec6a16b>] call_write_iter include/linux/fs.h:1876 [inline]
[<000000005ec6a16b>] new_sync_write+0x3c5/0x5b0 fs/read_write.c:515
[<00000000bbeebb83>] vfs_write+0x4e8/0x670 fs/read_write.c:595
[<000000009d967c93>] ksys_write+0x10c/0x220 fs/read_write.c:648
[<00000000139f6002>] do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
[<00000000b7d61f44>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Go to free buff when copy_from_iter_full() is failed.

Fixes: 1dea05cbc0d7 ("sysctl: Convert to iter interfaces")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 fs/proc/proc_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 9f6b9c3e3fda..a4a3122f8a58 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -578,7 +578,7 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 	if (write) {
 		error = -EFAULT;
 		if (!copy_from_iter_full(kbuf, count, iter))
-			goto out;
+			goto out_free_buf;
 		kbuf[count] = '\0';
 	}
 
-- 
2.25.1

