Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0420D2D42EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 14:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbgLINNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 08:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbgLINNM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:13:12 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B80C06179C;
        Wed,  9 Dec 2020 05:12:31 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id c7so1100899qke.1;
        Wed, 09 Dec 2020 05:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U/1xqfI5qUo3gDO+06cA0eClvvlW5lp3NGGPYOZ6sWg=;
        b=qsxmL+1cQe00msicjBwK/HwlXWZBf7gT2pnAsOYkUDq77RjLamhFzAW0B0ceSk6Vi3
         AOPfASgjN8kTjwnBxQijmYZh/kDmttxjj1TrNK0HPm4Rr3xPtcNqwRq/zRyjoatPtcn0
         Mpft7TA6nZOBZe4owiGB90EKNoA2jwgb8v3otQbZm91LETiyUFMrlUFmsOFQpr16nL85
         OqyvHkUZjb7TpzHAI/FNYQCqPPGfViRt+za0XCzXfjMVF86nwOhf/CcSAOkwtWQwmyzX
         Uk7YxYSpynGnXKqhBXS19hrL3Keijw19VALRdQoljFvcw136cunMyLvsbokCZ7odw+B6
         8ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U/1xqfI5qUo3gDO+06cA0eClvvlW5lp3NGGPYOZ6sWg=;
        b=jLivbb9q6IHskEaUAEw1T7qL7lI/3LNEpNd9EiBkoGzfHrBjd70Uq1YwI3gJm7Eqia
         4Ugfrk0Qco070RdjQhmjHC8tPgZ/af2V9XidllwxB6aG58K+u2401jI0TREWqlsypOFA
         kvrbqY+1cu5+8ug+HXJDnQxYAbPHdbYruVN9XKkd2ueVzDRFalmcUF6LtzFMGbkpE2A8
         1XGqlJCYfPnOzmPGG5bO6pfb6leT/ymptc2jd/6YGzbDUL1qJ36PMG4s7yoM7i2nYAiT
         Ox3NmPYsexRqDbuSHweOSk0VXHKfsUU/Zax9ZW6KHwCkzKpgt2o12TxvNz9cI+LPVum7
         sejA==
X-Gm-Message-State: AOAM531Iul7UBQZPXU6vBvBx/8OJSnE0XvVviKxBvSC8WkK5Z6WSneOX
        Lowc1Co5vDaacfxIlWc+DNg=
X-Google-Smtp-Source: ABdhPJxB0/jAlENo3tmNLdMytrMRXbSsuKgW8S6j4ULYI9Bw/bihb/0tXNXtJPrr5KbOt6cyGOqcXA==
X-Received: by 2002:a05:620a:2290:: with SMTP id o16mr2832688qkh.101.1607519551095;
        Wed, 09 Dec 2020 05:12:31 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id u72sm938114qka.15.2020.12.09.05.12.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 05:12:30 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v12 3/4] xfs: refactor the usage around xfs_trans_context_{set,clear}
Date:   Wed,  9 Dec 2020 21:11:45 +0800
Message-Id: <20201209131146.67289-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201209131146.67289-1-laoar.shao@gmail.com>
References: <20201209131146.67289-1-laoar.shao@gmail.com>
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
 fs/xfs/xfs_trans.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 11d390f0d3f2..4f4645329bb2 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -67,6 +67,17 @@ xfs_trans_free(
 	xfs_extent_busy_sort(&tp->t_busy);
 	xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
 
+
+	/* Detach the transaction from this thread. */
+	ASSERT(current->journal_info != NULL);
+	/*
+	 * The PF_MEMALLOC_NOFS is bound to the transaction itself instead
+	 * of the reservation, so we need to check if tp is still the
+	 * current transaction before clearing the flag.
+	 */
+	if (current->journal_info == tp)
+		xfs_trans_context_clear(tp);
+
 	trace_xfs_trans_free(tp, _RET_IP_);
 	if (!(tp->t_flags & XFS_TRANS_NO_WRITECOUNT))
 		sb_end_intwrite(tp->t_mountp->m_super);
@@ -153,9 +164,6 @@ xfs_trans_reserve(
 	int			error = 0;
 	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
 
-	/* Mark this thread as being in a transaction */
-	xfs_trans_context_set(tp);
-
 	/*
 	 * Attempt to reserve the needed disk blocks by decrementing
 	 * the number needed from the number available.  This will
@@ -163,10 +171,9 @@ xfs_trans_reserve(
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
 
@@ -241,8 +248,6 @@ xfs_trans_reserve(
 		tp->t_blk_res = 0;
 	}
 
-	xfs_trans_context_clear(tp);
-
 	return error;
 }
 
@@ -284,6 +289,8 @@ xfs_trans_alloc(
 	INIT_LIST_HEAD(&tp->t_dfops);
 	tp->t_firstblock = NULLFSBLOCK;
 
+	/* Mark this thread as being in a transaction */
+	xfs_trans_context_set(tp);
 	error = xfs_trans_reserve(tp, resp, blocks, rtextents);
 	if (error) {
 		xfs_trans_cancel(tp);
@@ -878,7 +885,6 @@ __xfs_trans_commit(
 
 	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
 
-	xfs_trans_context_clear(tp);
 	xfs_trans_free(tp);
 
 	/*
@@ -911,7 +917,6 @@ __xfs_trans_commit(
 		tp->t_ticket = NULL;
 	}
 
-	xfs_trans_context_clear(tp);
 	xfs_trans_free_items(tp, !!error);
 	xfs_trans_free(tp);
 
@@ -971,9 +976,6 @@ xfs_trans_cancel(
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

