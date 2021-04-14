Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E299835F507
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 15:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351448AbhDNNkL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 09:40:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16918 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351446AbhDNNkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:40:09 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FL3SV0VWQzjZS5;
        Wed, 14 Apr 2021 21:37:46 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 14 Apr 2021
 21:39:27 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [RFC PATCH v2 3/7] jbd2: don't abort the journal when freeing buffers
Date:   Wed, 14 Apr 2021 21:47:33 +0800
Message-ID: <20210414134737.2366971-4-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210414134737.2366971-1-yi.zhang@huawei.com>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now, we can make sure to abort the journal once the original buffer was
failed to write back to disk, we can remove the journal abort logic in
jbd2_journal_try_to_free_buffers() which was introduced in
<c044f3d8360d> ("jbd2: abort journal if free a async write error
metadata buffer"), because it may costs and propably not safe.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/transaction.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 9396666b7314..3e0db4953fe4 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2118,7 +2118,6 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
 {
 	struct buffer_head *head;
 	struct buffer_head *bh;
-	bool has_write_io_error = false;
 	int ret = 0;
 
 	J_ASSERT(PageLocked(page));
@@ -2143,26 +2142,10 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page)
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
2.25.4

