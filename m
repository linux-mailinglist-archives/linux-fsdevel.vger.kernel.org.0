Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2FC2A461B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 14:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgKCNSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 08:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbgKCNSd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:18:33 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31A7C0613D1;
        Tue,  3 Nov 2020 05:18:32 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id h62so15865726oth.9;
        Tue, 03 Nov 2020 05:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qv1wGdsij+9w5z85zBACLm0WGUMqCz1dz7LNa3UTDtk=;
        b=nLL1uzXCYA1FaoNOMbGrHfODfoC31v1Tm0VUBWwPlAjqM5N7X4FEuuaqNMkVlzqdV6
         +ICaG0vi2MvwTlbA2/ErhlMIAuD3CDu0IELcctFzBMhETIiKqwTVyVNDQqHgPsn2cDi+
         7/w+v42iu1bGbtA+1vHMETVIiPA0vJMqxtd5R8QdOBxpBKfnhIrFBj4X/PmMyGoxBMou
         rbzy/2m+ag5FWc4IV2LbPnYeneq2dBZzXvUgzFkA7Q78PhPoP49zXPJ29/co+ASfwt99
         TESDvAhHJWWxe7GlUU9J/Qegb23xy4RUltF/4ow00JzI9495kDNre72fqsdbVKF6Iqqr
         C7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qv1wGdsij+9w5z85zBACLm0WGUMqCz1dz7LNa3UTDtk=;
        b=WDEGQlAsgbiv7JGDbZojnPwrr4a1a95x44ol3Sjtyp46BQlQDa6fsDdWu3YJxasN+D
         fu/rI9qmATNFaRB3hpNEazFJeIskNZvpTvCObMdrEfy05DUlt2euo8wwrzA7ilPkfNcW
         /YjIL5dCaJHF2li/im1G9txN2xvYfgJgDH7nlnOqPfrU9gSogxPR3FhP5Zysl4AAiL4q
         V/KF1OUdwwGfGkEEh/k+dcW9k9s+8If1nW4g6NDnNXWFGr53CcRTIwOYDC4wx6TJG6G9
         4VHwTEu2LJYsXOnLqJsRxl+4PV87oaHjvok1f5WyuxuZjUybsOOipQAmBoJ0GSV1pjCX
         b2VQ==
X-Gm-Message-State: AOAM530PJQaPn11f6I8wqFm8xsUgPjocsZJO9isRsGuA4nrDJ+l/IvIa
        zNXsQ8P/wI1BWX3yZDwuBO8=
X-Google-Smtp-Source: ABdhPJyXf4V3twjJit4yagiweFA1fx+ddVWP5CNLhVwvuGxduXs0ohrKBigLkgLPtmMkz8WCmOBXuw==
X-Received: by 2002:a9d:7419:: with SMTP id n25mr15724612otk.183.1604409512309;
        Tue, 03 Nov 2020 05:18:32 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id f18sm4396138otf.55.2020.11.03.05.18.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 05:18:31 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org
Cc:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 resend 2/2] xfs: avoid transaction reservation recursion
Date:   Tue,  3 Nov 2020 21:17:54 +0800
Message-Id: <20201103131754.94949-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20201103131754.94949-1-laoar.shao@gmail.com>
References: <20201103131754.94949-1-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PF_FSTRANS which is used to avoid transaction reservation recursion, is
dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
memalloc_nofs_{save,restore} API") and replaced by PF_MEMALLOC_NOFS which
means to avoid filesystem reclaim recursion. That change is subtle.
Let's take the exmple of the check of WARN_ON_ONCE(current->flags &
PF_MEMALLOC_NOFS)) to explain why this abstraction from PF_FSTRANS to
PF_MEMALLOC_NOFS is not proper.
Below comment is quoted from Dave,
> It wasn't for memory allocation recursion protection in XFS - it was for
> transaction reservation recursion protection by something trying to flush
> data pages while holding a transaction reservation. Doing
> this could deadlock the journal because the existing reservation
> could prevent the nested reservation for being able to reserve space
> in the journal and that is a self-deadlock vector.
> IOWs, this check is not protecting against memory reclaim recursion
> bugs at all (that's the previous check [1]). This check is
> protecting against the filesystem calling writepages directly from a
> context where it can self-deadlock.
> So what we are seeing here is that the PF_FSTRANS ->
> PF_MEMALLOC_NOFS abstraction lost all the actual useful information
> about what type of error this check was protecting against.

As a result, we should reintroduce PF_FSTRANS. As current->journal_info
isn't used in XFS, we can reuse it to indicate whehter the task is in
fstrans or not, Per Willy. To achieve that, four new helpers are introduce
in this patch, per Dave:
- xfs_trans_context_set()
  Used in xfs_trans_alloc()
- xfs_trans_context_clear()
  Used in xfs_trans_commit() and xfs_trans_cancel()
- xfs_trans_context_update()
  Used in xfs_trans_roll()
- xfs_trans_context_active()
  To check whehter current is in fs transcation or not
[1]. Below check is to avoid memory reclaim recursion.
if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
        PF_MEMALLOC))
        goto redirty;

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>
---
 fs/iomap/buffered-io.c |  7 -------
 fs/xfs/xfs_aops.c      | 23 +++++++++++++++++++++--
 fs/xfs/xfs_linux.h     |  4 ----
 fs/xfs/xfs_trans.c     | 19 +++++++++----------
 fs/xfs/xfs_trans.h     | 30 ++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 23 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8180061..2f090b6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1469,13 +1469,6 @@ static void iomap_writepage_end_bio(struct bio *bio)
 		goto redirty;
 
 	/*
-	 * Given that we do not allow direct reclaim to call us, we should
-	 * never be called in a recursive filesystem reclaim context.
-	 */
-	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
-		goto redirty;
-
-	/*
 	 * Is this page beyond the end of the file?
 	 *
 	 * The page index is less than the end_index, adjust the end_offset
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 55d126d..b25196a 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -62,7 +62,8 @@ static inline bool xfs_ioend_is_append(struct iomap_ioend *ioend)
 	 * We hand off the transaction to the completion thread now, so
 	 * clear the flag here.
 	 */
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_clear(tp);
+
 	return 0;
 }
 
@@ -125,7 +126,7 @@ static inline bool xfs_ioend_is_append(struct iomap_ioend *ioend)
 	 * thus we need to mark ourselves as being in a transaction manually.
 	 * Similarly for freeze protection.
 	 */
-	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_set(tp);
 	__sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
 
 	/* we abort the update if there was an IO error */
@@ -564,6 +565,16 @@ static inline bool xfs_ioend_needs_workqueue(struct iomap_ioend *ioend)
 {
 	struct xfs_writepage_ctx wpc = { };
 
+	/*
+	 * Given that we do not allow direct reclaim to call us, we should
+	 * never be called while in a filesystem transaction.
+	 */
+	if (xfs_trans_context_active()) {
+		redirty_page_for_writepage(wbc, page);
+		unlock_page(page);
+		return 0;
+	}
+
 	return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);
 }
 
@@ -575,6 +586,14 @@ static inline bool xfs_ioend_needs_workqueue(struct iomap_ioend *ioend)
 	struct xfs_writepage_ctx wpc = { };
 
 	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
+
+	/*
+	 * Given that we do not allow direct reclaim to call us, we should
+	 * never be called while in a filesystem transaction.
+	 */
+	if (xfs_trans_context_active())
+		return 0;
+
 	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
 }
 
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 5b7a1e2..6ab0f80 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -102,10 +102,6 @@
 #define xfs_cowb_secs		xfs_params.cowb_timer.val
 
 #define current_cpu()		(raw_smp_processor_id())
-#define current_set_flags_nested(sp, f)		\
-		(*(sp) = current->flags, current->flags |= (f))
-#define current_restore_flags_nested(sp, f)	\
-		(current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))
 
 #define NBBY		8		/* number of bits per byte */
 
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index c94e71f..b272d07 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -153,8 +153,6 @@
 	int			error = 0;
 	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
 
-	/* Mark this thread as being in a transaction */
-	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
 
 	/*
 	 * Attempt to reserve the needed disk blocks by decrementing
@@ -163,10 +161,8 @@
 	 */
 	if (blocks > 0) {
 		error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
-		if (error != 0) {
-			current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+		if (error != 0)
 			return -ENOSPC;
-		}
 		tp->t_blk_res += blocks;
 	}
 
@@ -241,8 +237,6 @@
 		tp->t_blk_res = 0;
 	}
 
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
-
 	return error;
 }
 
@@ -284,6 +278,8 @@
 	INIT_LIST_HEAD(&tp->t_dfops);
 	tp->t_firstblock = NULLFSBLOCK;
 
+	/* Mark this thread as being in a transaction */
+	xfs_trans_context_set(tp);
 	error = xfs_trans_reserve(tp, resp, blocks, rtextents);
 	if (error) {
 		xfs_trans_cancel(tp);
@@ -878,7 +874,8 @@
 
 	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
 
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	if (!regrant)
+		xfs_trans_context_clear(tp);
 	xfs_trans_free(tp);
 
 	/*
@@ -910,7 +907,8 @@
 			xfs_log_ticket_ungrant(mp->m_log, tp->t_ticket);
 		tp->t_ticket = NULL;
 	}
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+
+	xfs_trans_context_clear(tp);
 	xfs_trans_free_items(tp, !!error);
 	xfs_trans_free(tp);
 
@@ -971,7 +969,7 @@
 	}
 
 	/* mark this thread as no longer being in a transaction */
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_clear(tp);
 
 	xfs_trans_free_items(tp, dirty);
 	xfs_trans_free(tp);
@@ -1013,6 +1011,7 @@
 	if (error)
 		return error;
 
+	xfs_trans_context_update(trans, *tpp);
 	/*
 	 * Reserve space in the log for the next transaction.
 	 * This also pushes items in the "AIL", the list of logged items,
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index 0846589..c4877afc 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -268,4 +268,34 @@ void		xfs_trans_buf_copy_type(struct xfs_buf *dst_bp,
 	return lip->li_ops->iop_relog(lip, tp);
 }
 
+static inline void
+xfs_trans_context_set(struct xfs_trans *tp)
+{
+	ASSERT(!current->journal_info);
+	current->journal_info = tp;
+	tp->t_pflags = memalloc_nofs_save();
+}
+
+static inline void
+xfs_trans_context_update(struct xfs_trans *old, struct xfs_trans *new)
+{
+	ASSERT(current->journal_info == old);
+	current->journal_info = new;
+}
+
+static inline void
+xfs_trans_context_clear(struct xfs_trans *tp)
+{
+	ASSERT(current->journal_info == tp);
+	current->journal_info = NULL;
+	memalloc_nofs_restore(tp->t_pflags);
+}
+
+static inline bool
+xfs_trans_context_active(void)
+{
+	/* Use journal_info to indicate current is in a transaction */
+	return current->journal_info != NULL;
+}
+
 #endif	/* __XFS_TRANS_H__ */
-- 
1.8.3.1

