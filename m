Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5E445B43C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 07:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhKXGPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 01:15:52 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15860 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhKXGPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:15:51 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HzVz11r5xz91Ht;
        Wed, 24 Nov 2021 14:12:13 +0800 (CST)
Received: from kwepemm600019.china.huawei.com (7.193.23.64) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 14:12:39 +0800
Received: from localhost.localdomain (10.175.127.227) by
 kwepemm600019.china.huawei.com (7.193.23.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 14:12:39 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <mike.kravetz@oracle.com>, <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH v2] hugetlbfs: avoid overflow in hugetlbfs_fallocate
Date:   Wed, 24 Nov 2021 14:24:52 +0800
Message-ID: <20211124062452.2343575-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600019.china.huawei.com (7.193.23.64)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

luojiajun report a problem[1] two years ago which seems still exists in
mainline. vfs_fallocate can avoid 'offset + len' trigger overflow, but
'offset + len + hpage_size - 1' may overflow too and will lead to a
wrong 'end'. luojiajun give a solution which can fix the wrong 'end'
but leave the overflow still happened. Fix it with DIV_ROUND_UP_ULL.

[1] https://patchwork.kernel.org/project/linux-mm/patch/1554775226-67213-1-git-send-email-luojiajun3@huawei.com/

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/hugetlbfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 49d2e686be74..92ac056e8011 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -651,7 +651,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 	 * as well as being converted to page offsets.
 	 */
 	start = offset >> hpage_shift;
-	end = (offset + len + hpage_size - 1) >> hpage_shift;
+	end = DIV_ROUND_UP_ULL(offset + len, hpage_size);
 
 	inode_lock(inode);
 
-- 
2.31.1

