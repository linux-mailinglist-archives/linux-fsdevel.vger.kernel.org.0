Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD0D2D2AD3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 13:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgLHM3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 07:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgLHM3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:29:42 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7A7C061749;
        Tue,  8 Dec 2020 04:29:02 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id s85so9425369vsc.3;
        Tue, 08 Dec 2020 04:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pgSeCCz06zc01NYEBqvpTOWErTmzAHAFxmMqyUPOtHQ=;
        b=LIEQrvCCS7AMJ+yA5QpAvO1LIf6X7Qo+UhUF5ubDd8YU7OaZ/UEk1wmKxt7Ks8qZuF
         yMqvzHE2V0M4PfZtPIVvaKm/iTHhvn3Zj0zHLyCp7m3a9GwT4yv3h/IWFVtoanP8ooxx
         0kax4+qn0S9SF7KZkqZ001IsV4FJDqyTd8uDBMgHnPSqJ6XgwymArBCJpky8/8+meO88
         LKXCfvvqxgRVTCVwyZvqExNt1LtD0DKThyZsh6TSiEw4gneSJdGIDaHcXlVh26lRX+zl
         boBvxeG5WxQJXIrpoYf+tXDa7Fq+tF5fsDKMJyCeHzV2Xwa9MPRzxb3msbnQP7X1UHGz
         8X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pgSeCCz06zc01NYEBqvpTOWErTmzAHAFxmMqyUPOtHQ=;
        b=gAa0pjUMb06TfjmQH+NMzWdA4kepRIuLG9yzZXbGt+8yVO2iigAV16AHVUEsX1gKAw
         5IEutWrfny4qTkW9LoWwWJ9dgwxUNw6WP7cXiHgO3Yqg/7ClSE3MBmJF7pX946iWOeut
         SZvhRb9L7wnqEE4GyTz7icLUqM+oN7eCVBofU0P7S8vxgjM32GKbxmZWWsegAsABoZCx
         BEaOrKZaluXoAo15K342WupL5OUowhRqIiUnD85QCERWec3Ucupdm2p86tqTIRtQ+57n
         l2f/JJCP0lpN5kJgiNHh0x1YdS7b8E0jvFOC+6iuU0uEYIeWFpLtS2pLK1GFgLwWLCr9
         yX+w==
X-Gm-Message-State: AOAM530OgC70Lhmx3MtP6Z0jjuDz4cstOnRZSb8RJskrE4RF4CIG1TFJ
        NiYha7dKY7KdxACiARbYGac=
X-Google-Smtp-Source: ABdhPJxwq0qLVhny4+PWca6HecBgfzy2W5i5g0ACVywhjZodUzzBhDNvmyWsRu13x1lfjEsitooBpQ==
X-Received: by 2002:a67:cb0e:: with SMTP id b14mr16134666vsl.60.1607430541363;
        Tue, 08 Dec 2020 04:29:01 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id w202sm2001106vkd.25.2020.12.08.04.28.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 04:29:00 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v11 2/4] xfs: use memalloc_nofs_{save,restore} in xfs transaction
Date:   Tue,  8 Dec 2020 20:28:22 +0800
Message-Id: <20201208122824.16118-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201208122824.16118-1-laoar.shao@gmail.com>
References: <20201208122824.16118-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new API to mark the start and end of XFS transactions.
For now, just save and restore the memalloc_nofs flags.

The new helpers as follows,
- xfs_trans_context_set
  Mark the start of XFS transactions
- xfs_trans_context_clear
  Mark the end of XFS transactions

Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/xfs/xfs_aops.c  |  4 ++--
 fs/xfs/xfs_linux.h |  4 ----
 fs/xfs/xfs_trans.c | 13 +++++++------
 fs/xfs/xfs_trans.h | 12 ++++++++++++
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 4304c6416fbb..2371187b7615 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -62,7 +62,7 @@ xfs_setfilesize_trans_alloc(
 	 * We hand off the transaction to the completion thread now, so
 	 * clear the flag here.
 	 */
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_clear(tp);
 	return 0;
 }
 
@@ -125,7 +125,7 @@ xfs_setfilesize_ioend(
 	 * thus we need to mark ourselves as being in a transaction manually.
 	 * Similarly for freeze protection.
 	 */
-	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_set(tp);
 	__sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
 
 	/* we abort the update if there was an IO error */
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 5b7a1e201559..6ab0f8043c73 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -102,10 +102,6 @@ typedef __u32			xfs_nlink_t;
 #define xfs_cowb_secs		xfs_params.cowb_timer.val
 
 #define current_cpu()		(raw_smp_processor_id())
-#define current_set_flags_nested(sp, f)		\
-		(*(sp) = current->flags, current->flags |= (f))
-#define current_restore_flags_nested(sp, f)	\
-		(current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))
 
 #define NBBY		8		/* number of bits per byte */
 
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index c94e71f741b6..11d390f0d3f2 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -154,7 +154,7 @@ xfs_trans_reserve(
 	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
 
 	/* Mark this thread as being in a transaction */
-	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_set(tp);
 
 	/*
 	 * Attempt to reserve the needed disk blocks by decrementing
@@ -164,7 +164,7 @@ xfs_trans_reserve(
 	if (blocks > 0) {
 		error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
 		if (error != 0) {
-			current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+			xfs_trans_context_clear(tp);
 			return -ENOSPC;
 		}
 		tp->t_blk_res += blocks;
@@ -241,7 +241,7 @@ xfs_trans_reserve(
 		tp->t_blk_res = 0;
 	}
 
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_clear(tp);
 
 	return error;
 }
@@ -878,7 +878,7 @@ __xfs_trans_commit(
 
 	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
 
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_clear(tp);
 	xfs_trans_free(tp);
 
 	/*
@@ -910,7 +910,8 @@ __xfs_trans_commit(
 			xfs_log_ticket_ungrant(mp->m_log, tp->t_ticket);
 		tp->t_ticket = NULL;
 	}
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+
+	xfs_trans_context_clear(tp);
 	xfs_trans_free_items(tp, !!error);
 	xfs_trans_free(tp);
 
@@ -971,7 +972,7 @@ xfs_trans_cancel(
 	}
 
 	/* mark this thread as no longer being in a transaction */
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_clear(tp);
 
 	xfs_trans_free_items(tp, dirty);
 	xfs_trans_free(tp);
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index 084658946cc8..44b11c64a15e 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -268,4 +268,16 @@ xfs_trans_item_relog(
 	return lip->li_ops->iop_relog(lip, tp);
 }
 
+static inline void
+xfs_trans_context_set(struct xfs_trans *tp)
+{
+	tp->t_pflags = memalloc_nofs_save();
+}
+
+static inline void
+xfs_trans_context_clear(struct xfs_trans *tp)
+{
+	memalloc_nofs_restore(tp->t_pflags);
+}
+
 #endif	/* __XFS_TRANS_H__ */
-- 
2.18.4

