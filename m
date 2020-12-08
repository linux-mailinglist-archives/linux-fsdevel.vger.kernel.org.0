Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E4C2D20B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 03:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgLHCRM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 21:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLHCRM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:17:12 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00604C061794;
        Mon,  7 Dec 2020 18:16:31 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id f16so5173332uav.12;
        Mon, 07 Dec 2020 18:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=17HkpCiChNHQ4avz8nKjAF3KcVK7dbos9sXYlvZmUH8=;
        b=n/6QvM94DVIaoeHBWFUPjpkUZ4j/O5mJ+jA51Lh73p9x0+uvtbpC0HoWRQmED0QNOq
         kbgfzNCduM870rEJF1Zc1TwG+7LcNlDmZGRxchpk/beFs1Gh54SOlns9uzuykTCO/BYk
         f5Afyptne44QeiapkKKJask7G5pp4eTafU585QQUqM+QZJ/0vUBVklkT6GGWJabA2Fco
         wguxfefiuacN/SobE+skErGhpSQKQp1gL34VJVhqYhtKNHprE8sEQZc66vfDv6bgXOwU
         RgMchxarJfGlW5KL/ScQydw2XNnuK9kB8NZkbiMHWUXJ1P7IOcyc3+TW/bYg/2tVpNMu
         yfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=17HkpCiChNHQ4avz8nKjAF3KcVK7dbos9sXYlvZmUH8=;
        b=Ahgeml3KFA56mIz9QylQUd2VGEzkbzFGaAp2DDwxfV390F3epzmxpgdB4uopmk7utD
         nDHCPF1ETwK0mgPW72cRd7Z7+JIJ9LiQO8vV6tr8yuAV27gou6m2pyPdMueHjJGrjyDS
         zZ7SwnPkRb/fZ6bzTyHfMBJCQPQXarQrHBsxOqZdShw917mgLE05z9rjZ2/fvf5DHP7a
         Hu6VKGAfP+4SH4m+DOVcVK2UbHwvWI4LewRy91eicbGVEkf/gyfecf6RB+oiiFe5h+q4
         /MzpMLYA3nu+RJSuNTwvlfaivu3sx9F32JfmlD8yVU7GnegqNRU9kOKfVKo7/K7cfrpX
         NNGQ==
X-Gm-Message-State: AOAM5332sqE4w/bjP/q6njUGJqi3Kmm4jmppwtteahXzQK0wtrkGhnWi
        zXwXNA82CjIlmXAxmI/ApZg=
X-Google-Smtp-Source: ABdhPJxAuBY/UnZNHubFCUfZmsEIfpluIuaN3ITsWJDSJ7t1vF3FgkWeihIAtqpg2YGnqcv789xk4w==
X-Received: by 2002:ab0:558a:: with SMTP id v10mr6786221uaa.63.1607393791205;
        Mon, 07 Dec 2020 18:16:31 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id o192sm1936000vko.19.2020.12.07.18.16.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 18:16:30 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v10 3/4] xfs: refactor the usage around xfs_trans_context_{set,clear}
Date:   Tue,  8 Dec 2020 10:15:42 +0800
Message-Id: <20201208021543.76501-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201208021543.76501-1-laoar.shao@gmail.com>
References: <20201208021543.76501-1-laoar.shao@gmail.com>
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

