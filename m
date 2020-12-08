Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE82D2D2AD9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 13:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgLHM34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 07:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgLHM3z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:29:55 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5372DC06179C;
        Tue,  8 Dec 2020 04:29:15 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id v185so3879683vkf.8;
        Tue, 08 Dec 2020 04:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SCJswpmGJEGFbwz05j4RZWMsgw6JAy/Mmr2L5jj9uEA=;
        b=Pa0hh0vbM9LlaK0szyyjbvMVJWXmiBlOWeL3p5IydY4lL8MlJCkqFa/M2gF4W/pvD2
         DiHyUdzDLbqPAM2VqVIZtfz2hQA4jZDNMiumfddLfzFjojUIQkqCFBPSYZsNKQVM16WS
         bYQdiZZKfzwdwAAPcnHIB09CYSsTbf1bXVIr/+8P/+0ULYAIcGpD7epETMlbSvx45FNf
         1yyIq0G36lq14SNpxVurZwMQXwI11T+Sbz3QQTKsx6jD35DZd3mIDSE9vf4bj9VIvncv
         WsUXpHu1/+kqTYO9t7r9ZgpmbQcJ6/9Rrj0pH9N9AkGxbUHjsIgQdNRgCIgBIC9rdlX8
         /QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCJswpmGJEGFbwz05j4RZWMsgw6JAy/Mmr2L5jj9uEA=;
        b=i2New9b5QBt4h0ayHq6ClwCKkQxuzOjKnj+Hm0CT3LlLjGImeC0VKhUKEGV9KwDmCX
         YjcrVy1h4EwPe5Hf9XuFKPk7fEP1Dhf/jYtbUoCTraE3JxtrDHKEah3Bc1DMNGbiUFU0
         HHnX7/KrHlgCRQyPXtkTNZXA2yPtxgRtMpVbsQyRo0J6A/YVVxEeh943Js4LU6fsLOQQ
         qb6eStPtHB4BZYY9SX3jtLyvwtyGuFujy9KBvCkjUUcgyaSbuTT6cpxIl9l9rpPlCALl
         Nr6H60/ZbIqunKU86qCbIA53IZpsHpJ5oAGazeYf3IdNpAE9xdiQZ7ZSnugB0h8KtSmu
         1kbw==
X-Gm-Message-State: AOAM530R86GvJUb8lvbIVAl1mbA+oYUeQnFyVKLsvjK/HmngXPw4MPCN
        ny1avnFFD73obe7DDr6NO8M=
X-Google-Smtp-Source: ABdhPJwxocpjJFAsDhcNEMMocXCU1Hico4niSWWZOUk0TiwIEsQdMQi+GgoeMGqxNUAinDMJVZ8OIw==
X-Received: by 2002:a1f:410c:: with SMTP id o12mr6541288vka.19.1607430554170;
        Tue, 08 Dec 2020 04:29:14 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id w202sm2001106vkd.25.2020.12.08.04.29.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 04:29:13 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v11 4/4] xfs: use current->journal_info to avoid transaction reservation recursion
Date:   Tue,  8 Dec 2020 20:28:24 +0800
Message-Id: <20201208122824.16118-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201208122824.16118-1-laoar.shao@gmail.com>
References: <20201208122824.16118-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PF_FSTRANS which is used to avoid transaction reservation recursion, is
dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
memalloc_nofs_{save,restore} API") and replaced by PF_MEMALLOC_NOFS which
means to avoid filesystem reclaim recursion.

As these two flags have different meanings, we'd better reintroduce
PF_FSTRANS back. To avoid wasting the space of PF_* flags in task_struct,
we can reuse the current->journal_info to do that, per Willy. As the
check of transaction reservation recursion is used by XFS only, we can
move the check into xfs_vm_writepage(s), per Dave.

To better abstract that behavoir, two new helpers are introduced, as
follows,
- xfs_trans_context_active
  To check whehter current is in fs transcation or not
- xfs_trans_context_swap
  Transfer the transaction context when rolling a permanent transaction

These two new helpers are instroduced in xfs_trans.h.

Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@redhat.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/iomap/buffered-io.c |  7 -------
 fs/xfs/xfs_aops.c      | 17 +++++++++++++++++
 fs/xfs/xfs_trans.c     |  3 +++
 fs/xfs/xfs_trans.h     | 22 ++++++++++++++++++++++
 4 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 10cc7979ce38..3c53fa6ce64d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1458,13 +1458,6 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 			PF_MEMALLOC))
 		goto redirty;
 
-	/*
-	 * Given that we do not allow direct reclaim to call us, we should
-	 * never be called in a recursive filesystem reclaim context.
-	 */
-	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
-		goto redirty;
-
 	/*
 	 * Is this page beyond the end of the file?
 	 *
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 2371187b7615..0da0242d42c3 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -568,6 +568,16 @@ xfs_vm_writepage(
 {
 	struct xfs_writepage_ctx wpc = { };
 
+	/*
+	 * Given that we do not allow direct reclaim to call us, we should
+	 * never be called while in a filesystem transaction.
+	 */
+	if (WARN_ON_ONCE(xfs_trans_context_active())) {
+		redirty_page_for_writepage(wbc, page);
+		unlock_page(page);
+		return 0;
+	}
+
 	return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);
 }
 
@@ -579,6 +589,13 @@ xfs_vm_writepages(
 	struct xfs_writepage_ctx wpc = { };
 
 	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
+	/*
+	 * Given that we do not allow direct reclaim to call us, we should
+	 * never be called while in a filesystem transaction.
+	 */
+	if (WARN_ON_ONCE(xfs_trans_context_active()))
+		return 0;
+
 	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
 }
 
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index fe20398a214e..08d4916ffb13 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -124,6 +124,9 @@ xfs_trans_dup(
 	tp->t_rtx_res = tp->t_rtx_res_used;
 	ntp->t_pflags = tp->t_pflags;
 
+	/* Associate the new transaction with this thread. */
+	xfs_trans_context_swap(tp, ntp);
+
 	/* move deferred ops over to the new tp */
 	xfs_defer_move(ntp, tp);
 
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index 44b11c64a15e..d596a375e3bf 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -268,16 +268,38 @@ xfs_trans_item_relog(
 	return lip->li_ops->iop_relog(lip, tp);
 }
 
+static inline bool
+xfs_trans_context_active(void)
+{
+	/* Use journal_info to indicate current is in a transaction */
+	return current->journal_info != NULL;
+}
+
 static inline void
 xfs_trans_context_set(struct xfs_trans *tp)
 {
+	ASSERT(!current->journal_info);
+	current->journal_info = tp;
 	tp->t_pflags = memalloc_nofs_save();
 }
 
 static inline void
 xfs_trans_context_clear(struct xfs_trans *tp)
 {
+	ASSERT(current->journal_info == tp);
+	current->journal_info = NULL;
 	memalloc_nofs_restore(tp->t_pflags);
 }
 
+/*
+ * Transfer the transaction context when rolling a permanent
+ * transaction.
+ */
+static inline void
+xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
+{
+	ASSERT(current->journal_info == tp);
+	current->journal_info = ntp;
+}
+
 #endif	/* __XFS_TRANS_H__ */
-- 
2.18.4

