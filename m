Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEB03E50D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 04:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbhHJCFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 22:05:11 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13408 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhHJCFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 22:05:10 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GkGQF3rqLzcmH6;
        Tue, 10 Aug 2021 10:01:09 +0800 (CST)
Received: from dggpeml500013.china.huawei.com (7.185.36.41) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 10:04:47 +0800
Received: from huawei.com (10.67.189.17) by dggpeml500013.china.huawei.com
 (7.185.36.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 10 Aug
 2021 10:04:47 +0800
From:   QiuXi <qiuxi1@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <akpm@linux-foundation.org>,
        <jannh@google.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <xiekunxun@huawei.com>,
        <young.liuyang@huawei.com>
Subject: [PATCH 1/1] coredump: fix memleak in dump_vma_snapshot()
Date:   Tue, 10 Aug 2021 10:04:41 +0800
Message-ID: <20210810020441.62806-1-qiuxi1@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.17]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500013.china.huawei.com (7.185.36.41)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dump_vma_snapshot() allocs memory for *vma_meta, when dump_vma_snapshot()
returns -EFAULT, the memory will be leaked, so we free it correctly.

Fixes: a07279c9a8cd7 ("binfmt_elf, binfmt_elf_fdpic: use a VMA list snapshot")
Cc: stable@vger.kernel.org # v5.10
Signed-off-by: QiuXi <qiuxi1@huawei.com>
---
 fs/coredump.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 07afb5ddb1c4..19fe5312c10f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1127,8 +1127,10 @@ int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
 
 	mmap_write_unlock(mm);
 
-	if (WARN_ON(i != *vma_count))
+	if (WARN_ON(i != *vma_count)) {
+		kvfree(*vma_meta);
 		return -EFAULT;
+	}
 
 	*vma_data_size_ptr = vma_data_size;
 	return 0;
-- 
2.12.3

