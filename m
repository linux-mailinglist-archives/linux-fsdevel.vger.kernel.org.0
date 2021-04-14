Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C678C35F4FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 15:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351415AbhDNNkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 09:40:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15679 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346798AbhDNNj5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:39:57 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FL3RC4z3BzpXtL;
        Wed, 14 Apr 2021 21:36:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 14 Apr 2021
 21:39:27 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [RFC PATCH v2 1/7] jbd2: remove the out label in __jbd2_journal_remove_checkpoint()
Date:   Wed, 14 Apr 2021 21:47:31 +0800
Message-ID: <20210414134737.2366971-2-yi.zhang@huawei.com>
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

The 'out' lable just return the 'ret' value and seems not required, so
remove this label and switch to return appropriate value immediately.
This patch also do some minor cleanup, no logical change.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/checkpoint.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 63b526d44886..bf5511d19ac5 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -564,13 +564,13 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 	struct transaction_chp_stats_s *stats;
 	transaction_t *transaction;
 	journal_t *journal;
-	int ret = 0;
 
 	JBUFFER_TRACE(jh, "entry");
 
-	if ((transaction = jh->b_cp_transaction) == NULL) {
+	transaction = jh->b_cp_transaction;
+	if (!transaction) {
 		JBUFFER_TRACE(jh, "not on transaction");
-		goto out;
+		return 0;
 	}
 	journal = transaction->t_journal;
 
@@ -579,9 +579,9 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 	jh->b_cp_transaction = NULL;
 	jbd2_journal_put_journal_head(jh);
 
-	if (transaction->t_checkpoint_list != NULL ||
-	    transaction->t_checkpoint_io_list != NULL)
-		goto out;
+	/* Is this transaction empty? */
+	if (transaction->t_checkpoint_list || transaction->t_checkpoint_io_list)
+		return 0;
 
 	/*
 	 * There is one special case to worry about: if we have just pulled the
@@ -593,10 +593,12 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 	 * See the comment at the end of jbd2_journal_commit_transaction().
 	 */
 	if (transaction->t_state != T_FINISHED)
-		goto out;
+		return 0;
 
-	/* OK, that was the last buffer for the transaction: we can now
-	   safely remove this transaction from the log */
+	/*
+	 * OK, that was the last buffer for the transaction, we can now
+	 * safely remove this transaction from the log.
+	 */
 	stats = &transaction->t_chp_stats;
 	if (stats->cs_chp_time)
 		stats->cs_chp_time = jbd2_time_diff(stats->cs_chp_time,
@@ -606,9 +608,7 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 
 	__jbd2_journal_drop_transaction(journal, transaction);
 	jbd2_journal_free_transaction(transaction);
-	ret = 1;
-out:
-	return ret;
+	return 1;
 }
 
 /*
-- 
2.25.4

