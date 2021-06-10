Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6447D3A2A00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 13:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFJLRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 07:17:55 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5488 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFJLRu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:17:50 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G11YB2S0YzZf9N;
        Thu, 10 Jun 2021 19:13:02 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 10
 Jun 2021 19:15:52 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <jack@suse.cz>, <tytso@mit.edu>
CC:     <adilger.kernel@dilger.ca>, <david@fromorbit.com>,
        <hch@infradead.org>, <yi.zhang@huawei.com>
Subject: [RFC PATCH v4 6/8] jbd2: simplify journal_clean_one_cp_list()
Date:   Thu, 10 Jun 2021 19:24:38 +0800
Message-ID: <20210610112440.3438139-7-yi.zhang@huawei.com>
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

Now that __try_to_free_cp_buf() remove checkpointed buffer or transaction
when the buffer is not 'busy', which is only called by
journal_clean_one_cp_list(). This patch simplify this function by remove
__try_to_free_cp_buf() and invoke __cp_buffer_busy() directly.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/checkpoint.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 1abdae44a3d8..51d1eb2ffeb9 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -91,25 +91,6 @@ static inline bool __cp_buffer_busy(struct journal_head *jh)
 	return (jh->b_transaction || buffer_locked(bh) || buffer_dirty(bh));
 }
 
-/*
- * Try to release a checkpointed buffer from its transaction.
- * Returns 1 if we released it and 2 if we also released the
- * whole transaction.
- *
- * Requires j_list_lock
- */
-static int __try_to_free_cp_buf(struct journal_head *jh)
-{
-	int ret = 0;
-	struct buffer_head *bh = jh2bh(jh);
-
-	if (!jh->b_transaction && !buffer_locked(bh) && !buffer_dirty(bh)) {
-		JBUFFER_TRACE(jh, "remove from checkpoint list");
-		ret = __jbd2_journal_remove_checkpoint(jh) + 1;
-	}
-	return ret;
-}
-
 /*
  * __jbd2_log_wait_for_space: wait until there is space in the journal.
  *
@@ -440,7 +421,6 @@ static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
 {
 	struct journal_head *last_jh;
 	struct journal_head *next_jh = jh;
-	int ret;
 
 	if (!jh)
 		return 0;
@@ -449,13 +429,11 @@ static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
 	do {
 		jh = next_jh;
 		next_jh = jh->b_cpnext;
-		if (!destroy)
-			ret = __try_to_free_cp_buf(jh);
-		else
-			ret = __jbd2_journal_remove_checkpoint(jh) + 1;
-		if (!ret)
+
+		if (!destroy && __cp_buffer_busy(jh))
 			return 0;
-		if (ret == 2)
+
+		if (__jbd2_journal_remove_checkpoint(jh))
 			return 1;
 		/*
 		 * This function only frees up some memory
-- 
2.31.1

