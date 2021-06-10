Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE023A29FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 13:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhFJLRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 07:17:55 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5487 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhFJLRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:17:49 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G11Y930HPzZfZw;
        Thu, 10 Jun 2021 19:13:01 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 10
 Jun 2021 19:15:51 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <jack@suse.cz>, <tytso@mit.edu>
CC:     <adilger.kernel@dilger.ca>, <david@fromorbit.com>,
        <hch@infradead.org>, <yi.zhang@huawei.com>
Subject: [RFC PATCH v4 4/8] jbd2: remove redundant buffer io error checks
Date:   Thu, 10 Jun 2021 19:24:36 +0800
Message-ID: <20210610112440.3438139-5-yi.zhang@huawei.com>
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

Now that __jbd2_journal_remove_checkpoint() can detect buffer io error
and mark journal checkpoint error, then we abort the journal later
before updating log tail to ensure the filesystem works consistently.
So we could remove other redundant buffer io error checkes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/checkpoint.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index d27c10f4502f..75a4f622afaf 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -91,8 +91,7 @@ static int __try_to_free_cp_buf(struct journal_head *jh)
 	int ret = 0;
 	struct buffer_head *bh = jh2bh(jh);
 
-	if (jh->b_transaction == NULL && !buffer_locked(bh) &&
-	    !buffer_dirty(bh) && !buffer_write_io_error(bh)) {
+	if (!jh->b_transaction && !buffer_locked(bh) && !buffer_dirty(bh)) {
 		JBUFFER_TRACE(jh, "remove from checkpoint list");
 		ret = __jbd2_journal_remove_checkpoint(jh) + 1;
 	}
@@ -228,7 +227,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 	 * OK, we need to start writing disk blocks.  Take one transaction
 	 * and write it.
 	 */
-	result = 0;
 	spin_lock(&journal->j_list_lock);
 	if (!journal->j_checkpoint_transactions)
 		goto out;
@@ -295,8 +293,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			goto restart;
 		}
 		if (!buffer_dirty(bh)) {
-			if (unlikely(buffer_write_io_error(bh)) && !result)
-				result = -EIO;
 			BUFFER_TRACE(bh, "remove from checkpoint");
 			if (__jbd2_journal_remove_checkpoint(jh))
 				/* The transaction was released; we're done */
@@ -356,8 +352,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			spin_lock(&journal->j_list_lock);
 			goto restart2;
 		}
-		if (unlikely(buffer_write_io_error(bh)) && !result)
-			result = -EIO;
 
 		/*
 		 * Now in whatever state the buffer currently is, we
@@ -369,10 +363,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 	}
 out:
 	spin_unlock(&journal->j_list_lock);
-	if (result < 0)
-		jbd2_journal_abort(journal, result);
-	else
-		result = jbd2_cleanup_journal_tail(journal);
+	result = jbd2_cleanup_journal_tail(journal);
 
 	return (result < 0) ? result : 0;
 }
-- 
2.31.1

