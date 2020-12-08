Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A7B2D2AD6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 13:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgLHM3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 07:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgLHM3s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:29:48 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714CEC061794;
        Tue,  8 Dec 2020 04:29:08 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id x26so9427581vsq.1;
        Tue, 08 Dec 2020 04:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=17HkpCiChNHQ4avz8nKjAF3KcVK7dbos9sXYlvZmUH8=;
        b=VeGWhsY1ue+SdOpldgrBQjuMDFPzbeLB+nGnFuBPWQVn7U663xva9hNTEgeNdDn7UX
         KwpN2bNKxAKXXQpY9BtZol09EntEehekiNiJf98pTeZ1zLn8RCrKXkGImE4vahbzP1ts
         X4WYV7qMvbzVatTDq+SI+R4AMhj7Q3vPxnPfsc+H4nPBV7QCgyDf1syrik+wSXzj6+oF
         vXkxQCZlik43K56ximqrGGLKrxa3RBR+7I+wTKg+6LP8lkhMcqifMQH3jLlNi7C6mVo8
         hWsLzqKIrpHMH6uXkp1EJ86OPY8KYzK86g42wThpvvukUzVbdLw+3kx1tjdaF3vL7hit
         jOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=17HkpCiChNHQ4avz8nKjAF3KcVK7dbos9sXYlvZmUH8=;
        b=RNpW913vDDf5dkbMtlGk7RFiC03S0yCGtSlt1drj8fFybfsRMsXsKt6Q3sLvwZssjE
         JXPDEqnvxNC6ZMRMQplLEqQSVPsy6A53w7sK4eomuw+6RbqDJCEUGlCdYY7dU0Ods7fd
         Ejqobeh0wpHuZmBhcqGxaDUFVQBWEfhomPOV+XPs1R7+QVZPc4H9EJCa7YfuUqKxxhnG
         950Vx60TQXFW9vOTuZQffW7DXIDybzVq/ZFLE/g/dhJzl8yxpuVWrMzIDs2XamDlxFQa
         u6wuEcMunlTz4haEPSW/QfRE3k+32kwt9KsPGhaTWq2w8KPdmBJ1M2PGOAZhMAXnNrNk
         RHbQ==
X-Gm-Message-State: AOAM530WAkwvKGDGUxwDAGMw4ftJSX4CPj6hcBfRzLx9L326q8qqRnjO
        PVvFz8V7WtDncuFqQ2d5VNM=
X-Google-Smtp-Source: ABdhPJzB7us8JzVAWeOHv8/fHrg99szKANSxsykkf7kNaONPTq8lgv76MK10x5L5LcEp8esxH8xd7g==
X-Received: by 2002:a67:bd0a:: with SMTP id y10mr15127725vsq.28.1607430547745;
        Tue, 08 Dec 2020 04:29:07 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id w202sm2001106vkd.25.2020.12.08.04.29.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 04:29:07 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v11 3/4] xfs: refactor the usage around xfs_trans_context_{set,clear}
Date:   Tue,  8 Dec 2020 20:28:23 +0800
Message-Id: <20201208122824.16118-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201208122824.16118-1-laoar.shao@gmail.com>
References: <20201208122824.16118-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The xfs_trans context should be active after it is allocated, and
deactive when it is freed.

So these two helpers are refactored as,
- xfs_trans_context_set()
  Used in xfs_trans_alloc()
- xfs_trans_context_clear()
  Used in xfs_trans_free()

This patch is based on Darrick's work to fix the issue in xfs/141 in the
earlier version. [1]

1. https://lore.kernel.org/linux-xfs/20201104001649.GN7123@magnolia

Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/xfs/xfs_trans.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 11d390f0d3f2..fe20398a214e 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -67,6 +67,9 @@ xfs_trans_free(
 	xfs_extent_busy_sort(&tp->t_busy);
 	xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
 
+	/* Detach the transaction from this thread. */
+	xfs_trans_context_clear(tp);
+
 	trace_xfs_trans_free(tp, _RET_IP_);
 	if (!(tp->t_flags & XFS_TRANS_NO_WRITECOUNT))
 		sb_end_intwrite(tp->t_mountp->m_super);
@@ -153,9 +156,6 @@ xfs_trans_reserve(
 	int			error = 0;
 	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
 
-	/* Mark this thread as being in a transaction */
-	xfs_trans_context_set(tp);
-
 	/*
 	 * Attempt to reserve the needed disk blocks by decrementing
 	 * the number needed from the number available.  This will
@@ -163,10 +163,9 @@ xfs_trans_reserve(
 	 */
 	if (blocks > 0) {
 		error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
-		if (error != 0) {
-			xfs_trans_context_clear(tp);
+		if (error != 0)
 			return -ENOSPC;
-		}
+
 		tp->t_blk_res += blocks;
 	}
 
@@ -241,8 +240,6 @@ xfs_trans_reserve(
 		tp->t_blk_res = 0;
 	}
 
-	xfs_trans_context_clear(tp);
-
 	return error;
 }
 
@@ -284,6 +281,8 @@ xfs_trans_alloc(
 	INIT_LIST_HEAD(&tp->t_dfops);
 	tp->t_firstblock = NULLFSBLOCK;
 
+	/* Mark this thread as being in a transaction */
+	xfs_trans_context_set(tp);
 	error = xfs_trans_reserve(tp, resp, blocks, rtextents);
 	if (error) {
 		xfs_trans_cancel(tp);
@@ -878,7 +877,6 @@ __xfs_trans_commit(
 
 	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
 
-	xfs_trans_context_clear(tp);
 	xfs_trans_free(tp);
 
 	/*
@@ -911,7 +909,6 @@ __xfs_trans_commit(
 		tp->t_ticket = NULL;
 	}
 
-	xfs_trans_context_clear(tp);
 	xfs_trans_free_items(tp, !!error);
 	xfs_trans_free(tp);
 
@@ -971,9 +968,6 @@ xfs_trans_cancel(
 		tp->t_ticket = NULL;
 	}
 
-	/* mark this thread as no longer being in a transaction */
-	xfs_trans_context_clear(tp);
-
 	xfs_trans_free_items(tp, dirty);
 	xfs_trans_free(tp);
 }
-- 
2.18.4

