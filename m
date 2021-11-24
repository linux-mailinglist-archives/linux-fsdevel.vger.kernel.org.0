Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303FD45B2EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 04:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhKXD72 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 22:59:28 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31901 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhKXD72 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 22:59:28 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HzRy83VzbzcZxP;
        Wed, 24 Nov 2021 11:56:16 +0800 (CST)
Received: from kwepemm600019.china.huawei.com (7.193.23.64) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 11:56:17 +0800
Received: from localhost.localdomain (10.175.127.227) by
 kwepemm600019.china.huawei.com (7.193.23.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 11:56:08 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <mike.kravetz@oracle.com>, <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH] hugetlbfs: avoid overflow in hugetlbfs_fallocate
Date:   Wed, 24 Nov 2021 12:08:18 +0800
Message-ID: <20211124040818.2219374-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600019.china.huawei.com (7.193.23.64)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

luojiajun report a problem[1] two years ago which seems still exists in
mainline. vfs_fallocate can avoid 'offset + len' trigger overflow, but
'offset + len + hpage_size - 1' may overflow too and will lead to a
wrong 'end'. luojiajun give a solution which can fix the wrong 'end'
but leave the overflow still happened. We should fix it by transfer
'offset' to unsigned long long.

[1] https://patchwork.kernel.org/project/linux-mm/patch/1554775226-67213-1-git-send-email-luojiajun3@huawei.com/

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/hugetlbfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 49d2e686be74..8012a14901de 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -651,7 +651,8 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 	 * as well as being converted to page offsets.
 	 */
 	start = offset >> hpage_shift;
-	end = (offset + len + hpage_size - 1) >> hpage_shift;
+	end = ((unsigned long long)offset + len + hpage_size - 1)
+		>> hpage_shift;
 
 	inode_lock(inode);
 
-- 
2.31.1

