Return-Path: <linux-fsdevel+bounces-26351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA57957F8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 09:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FE71F23598
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 07:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73C8184549;
	Tue, 20 Aug 2024 07:27:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90216BE33;
	Tue, 20 Aug 2024 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138820; cv=none; b=a4wVXUCTPrTtjTW9UhgN8cZXNZV/7t3YHu5yfgMSt8F3HD0N2Z3+VKiPxL6fi9lWz2ikd1vVU+dylqMPTMETk8rgN0mmrr//yem/dvsJSd6FQALwMzJs8DhRH7awThzqDklSjFa/Wglpz7m8i4AmXfPyqlt0QDXT4p1LuGMK2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138820; c=relaxed/simple;
	bh=Mm+786GwMepZHE+J+39pBbQn8RxkXtSdL3hx6i0yj6M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DeEHHxNxZHgcmlM7ITVIGH+TjmDFDPDGfayNW/JXNcngQ/z6/OLp5YSCzozd5QcgKMU0QvTO+mAkPtA7wIxuWg5iWhyk5YoreKyge7OsVtGLschZUcaGFWV6rGdLf99RbiScpNYVIWBxLxJwJWx9M0SWVnbrbky8n9G+g5KGMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 47K7QKN2057700;
	Tue, 20 Aug 2024 15:26:20 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Wp17S4Vfjz2K5Dpd;
	Tue, 20 Aug 2024 15:19:48 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 20 Aug 2024 15:26:18 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [RFC PATCH 1/1] fs: jbd2: try to launch cp transaction when bh refer cma
Date: Tue, 20 Aug 2024 15:26:09 +0800
Message-ID: <20240820072609.570513-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 47K7QKN2057700

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

cma_alloc() keep failed when an bunch of IO operations happened on an
journal enabled ext4 device which is caused by a jh->bh->b_page
can not be migrated out of CMA area as the jh has one cp_transaction
pending on it. We solve this by launching jbd2_log_do_checkpoint forcefully
somewhere. Since journal is common mechanism to all JFSs and
cp_transaction has a little fewer opportunity to be launched, this patch
would like to introduce a timing point at which the
cp_transaction->t_checkpoint_list is shrunk if CMA page used for
journalling.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 fs/jbd2/checkpoint.c | 27 +++++++++++++++++++++++++++
 fs/jbd2/journal.c    |  4 ++++
 include/linux/jbd2.h |  2 ++
 3 files changed, 33 insertions(+)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 951f78634adf..8c6c1dba1f0f 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/blkdev.h>
 #include <trace/events/jbd2.h>
+#include <linux/mm.h>
 
 /*
  * Unlink a buffer from a transaction checkpoint list.
@@ -137,6 +138,32 @@ __flush_batch(journal_t *journal, int *batch_count)
 	*batch_count = 0;
 }
 
+#ifdef CONFIG_CMA
+void drain_cma_bh(journal_t *journal)
+{
+	struct journal_head	*jh;
+	struct buffer_head	*bh;
+
+	if (!journal->j_checkpoint_transactions)
+		return;
+
+	jh = journal->j_checkpoint_transactions->t_checkpoint_list;
+	while (jh) {
+		bh = jh2bh(jh);
+
+		if (bh && get_pageblock_migratetype(bh->b_page) == MIGRATE_CMA) {
+			mutex_lock_io(&journal->j_checkpoint_mutex);
+			jbd2_log_do_checkpoint(journal);
+			mutex_unlock(&journal->j_checkpoint_mutex);
+			return;
+		}
+
+		jh = jh->b_cpnext;
+	}
+}
+#else
+void drain_cma_bh(journal_t *journal) {}
+#endif
 /*
  * Perform an actual checkpoint. We take the first transaction on the
  * list of transactions to be checkpointed and send all its buffers
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 1ebf2393bfb7..dd92cb7404fc 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -41,6 +41,7 @@
 #include <linux/bitops.h>
 #include <linux/ratelimit.h>
 #include <linux/sched/mm.h>
+#include <linux/swap.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/jbd2.h>
@@ -1273,6 +1274,9 @@ static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
 	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
 	trace_jbd2_shrink_scan_enter(journal, sc->nr_to_scan, count);
 
+	if (current_is_kswapd())
+		drain_cma_bh(journal);
+
 	nr_shrunk = jbd2_journal_shrink_checkpoint_list(journal, &nr_to_scan);
 
 	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 5157d92b6f23..fc152382a6ae 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -105,6 +105,8 @@ typedef struct jbd2_journal_handle handle_t;	/* Atomic operation type */
 typedef struct journal_s	journal_t;	/* Journal control structure */
 #endif
 
+void drain_cma_bh(journal_t *journal);
+
 /*
  * Internal structures used by the logging mechanism:
  */
-- 
2.25.1


