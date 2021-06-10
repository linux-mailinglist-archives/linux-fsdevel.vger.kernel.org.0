Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702B13A29F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 13:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhFJLRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 07:17:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3940 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFJLRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:17:49 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G11Xv0xmNz6wtQ;
        Thu, 10 Jun 2021 19:12:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 10
 Jun 2021 19:15:51 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <jack@suse.cz>, <tytso@mit.edu>
CC:     <adilger.kernel@dilger.ca>, <david@fromorbit.com>,
        <hch@infradead.org>, <yi.zhang@huawei.com>
Subject: [RFC PATCH v4 3/8] jbd2: don't abort the journal when freeing buffers
Date:   Thu, 10 Jun 2021 19:24:35 +0800
Message-ID: <20210610112440.3438139-4-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610112440.3438139-1-yi.zhang@huawei.com>
References: <20210610112440.3438139-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we can be sure the journal is aborted once a buffer has failed
to be written back to disk, we can remove the journal abort logic in
jbd2_journal_try_to_free_buffers() which was introduced in
commit c044f3d8360d ("jbd2: abort journal if free a async write error
metadata buffer"), because it may cost and propably is not safe.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index e8fc45fd751f..8804e126805f 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2123,7 +2123,6 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
 {
 	struct buffer_head *head;
 	struct buffer_head *bh;
-	bool has_write_io_error = false;
 	int ret = 0;
 
 	J_ASSERT(PageLocked(page));
@@ -2148,26 +2147,10 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
 		jbd2_journal_put_journal_head(jh);
 		if (buffer_jbd(bh))
 			goto busy;
-
-		/*
-		 * If we free a metadata buffer which has been failed to
-		 * write out, the jbd2 checkpoint procedure will not detect
-		 * this failure and may lead to filesystem inconsistency
-		 * after cleanup journal tail.
-		 */
-		if (buffer_write_io_error(bh)) {
-			pr_err("JBD2: Error while async write back metadata bh %llu.",
-			       (unsigned long long)bh->b_blocknr);
-			has_write_io_error = true;
-		}
 	} while ((bh = bh->b_this_page) != head);
 
 	ret = try_to_free_buffers(page);
-
 busy:
-	if (has_write_io_error)
-		jbd2_journal_abort(journal, -EIO);
-
 	return ret;
 }
 
-- 
2.31.1

