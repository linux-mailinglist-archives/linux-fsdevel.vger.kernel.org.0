Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB2D3B9E17
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 11:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhGBJZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 05:25:31 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:10238 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhGBJZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:25:30 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GGTxp4ZHrz1BTML;
        Fri,  2 Jul 2021 17:17:34 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Jul 2021 17:22:56 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Jul 2021 17:22:56 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH -next 1/1] iomap: Fix a false positive of UBSAN in iomap_seek_data()
Date:   Fri, 2 Jul 2021 17:21:09 +0800
Message-ID: <20210702092109.2601-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the evaluation expression "size - offset" after the "if (offset < 0)"
judgment statement to eliminate a false positive produced by the UBSAN.

No functional changes.

==========================================================================
UBSAN: Undefined behaviour in fs/iomap.c:1435:9
signed integer overflow:
0 - -9223372036854775808 cannot be represented in type 'long long int'
CPU: 1 PID: 462 Comm: syz-executor852 Tainted: G ---------r-  - 4.18.0+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ...
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xca/0x13e lib/dump_stack.c:113
 ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
 handle_overflow+0x193/0x1e2 lib/ubsan.c:190
 iomap_seek_data+0x128/0x140 fs/iomap.c:1435
 ext4_llseek+0x1e3/0x290 fs/ext4/file.c:494
 vfs_llseek fs/read_write.c:300 [inline]
 ksys_lseek+0xe9/0x160 fs/read_write.c:313
 do_syscall_64+0xca/0x5b0 arch/x86/entry/common.c:293
 entry_SYSCALL_64_after_hwframe+0x6a/0xdf
==========================================================================

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/iomap/seek.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index dab1b02eba5b..778e3e84c95e 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -83,13 +83,14 @@ loff_t
 iomap_seek_data(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
 {
 	loff_t size = i_size_read(inode);
-	loff_t length = size - offset;
+	loff_t length;
 	loff_t ret;
 
 	/* Nothing to be found before or beyond the end of the file. */
 	if (offset < 0 || offset >= size)
 		return -ENXIO;
 
+	length = size - offset;
 	while (length > 0) {
 		ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
 				  &offset, iomap_seek_data_actor);
-- 
2.25.1


