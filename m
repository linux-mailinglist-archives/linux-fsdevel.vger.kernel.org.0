Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63762D0137
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 07:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLFGmh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 01:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgLFGmg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 01:42:36 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4E2C0613D4;
        Sat,  5 Dec 2020 22:41:56 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id s2so2128508oij.2;
        Sat, 05 Dec 2020 22:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yf7zPQOJGOGST1kr7aRDb+hEVvmcjR4NTe2pf0HQRUE=;
        b=QePB48uCarK3ddowCiXI+o6c6RAi6TQftuyLc76APBu0NfSAmdrsEXIeFLp6tdrJdO
         pB+m9RjVOLxQ5eznWFcPJaKeZlWFvlU6VNkRADlR8IKnNFX7tEeGrF7DFl5U+8ojK+GS
         C1xSa2YZsYwi9hpNuVVorGcMNoogrQeJA7D/aYlJ8uwZ91tX431R4VpHcYs7ZqABFOTp
         tzazXtxOawiufJSNwe4QvFXCp6KQLFoDjE+lvB/6yw2rB8g8234wvFa1IIjn00Vh365q
         ipwnCMdlm1hHAKQ+dkb35RRq30y7DGJKjlugmAxf8iG13WDvRJ4oFXrG/dTBZ+KxTBhE
         Aqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yf7zPQOJGOGST1kr7aRDb+hEVvmcjR4NTe2pf0HQRUE=;
        b=XXZMcOg96X8JMWAM0/P8nb4dJX8tD9+XL1ekffy+lF+bfU9BkMbhwWQInDmQVMtSO5
         F1GFbsWjCyrdyq5UiQW4wPzfCXMAF5rgfMwHozj888LkYR85smhCdehOcginD8yEJBow
         RGWrIOnAjXcDMe4h/fM6HTqZn4UA/oxwbEY90LsUu5UV8sT0bfSMlpNwrqnSXkDvJd+G
         ShvliLL242mwigbVVrX7/9TcGEnIeCsnqKqXulsWK27nIWxvqYUpCwho2zBtFIuQSREi
         NjvF0vYZgDR5TlSgnqqGZ+mOcJ85+do6YhNdKhUHni2DavSO220N5nX3uIGPkoEUe5/2
         S4RQ==
X-Gm-Message-State: AOAM530URO4ldsP+CkwwB5+iot6XwQrTPAgW1PSjUma05tV6WJGDUPEb
        08QKjJrtAiXigCTrBCofo1lAkrbXo0NQkw==
X-Google-Smtp-Source: ABdhPJwHxlLgoXfodNhX/Rsnt84ieUkqXh0UaPXjPCSJQav7RfU1+W5SjuDerhP+7UyY/90pR8R6zg==
X-Received: by 2002:aca:eccb:: with SMTP id k194mr4957090oih.112.1607236915440;
        Sat, 05 Dec 2020 22:41:55 -0800 (PST)
Received: from localhost.localdomain ([122.225.203.131])
        by smtp.gmail.com with ESMTPSA id y18sm1817553ooj.20.2020.12.05.22.41.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2020 22:41:54 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, hch@infradead.org,
        david@fromorbit.com, mhocko@kernel.org,
        000akpm@linux-foundation.org, dhowells@redhat.com,
        jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v9 2/2] xfs: avoid transaction reservation recursion
Date:   Sun,  6 Dec 2020 14:40:46 +0800
Message-Id: <20201206064046.2921-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201206064046.2921-1-laoar.shao@gmail.com>
References: <20201206064046.2921-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
fstrans or not, Per Willy. To achieve that, some new helpers are introduce
in this patch, per Dave:
- xfs_trans_context_set()
  Used in xfs_trans_alloc()
- xfs_trans_context_clear()
  Used in xfs_trans_commit() and xfs_trans_cancel()
- xfs_trans_context_active()
  To check whehter current is in fs transcation or not

Darrick helped fix the error occurred in xfs/141.[2]

No obvious error occurred when I run xfstests in my test machine.

[1]. Below check is to avoid memory reclaim recursion.
if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
        PF_MEMALLOC))
        goto redirty;

[2]. https://lore.kernel.org/linux-xfs/20201104001649.GN7123@magnolia/

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
 fs/xfs/xfs_aops.c      | 23 +++++++++++++++++++++--
 fs/xfs/xfs_linux.h     |  4 ----
 fs/xfs/xfs_trans.c     | 25 +++++++++++++------------
 fs/xfs/xfs_trans.h     | 23 +++++++++++++++++++++++
 5 files changed, 57 insertions(+), 25 deletions(-)

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
index 4304c6416fbb..1541ea5956fa 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -62,7 +62,8 @@ xfs_setfilesize_trans_alloc(
 	 * We hand off the transaction to the completion thread now, so
 	 * clear the flag here.
 	 */
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_clear(tp);
+
 	return 0;
 }
 
@@ -125,7 +126,7 @@ xfs_setfilesize_ioend(
 	 * thus we need to mark ourselves as being in a transaction manually.
 	 * Similarly for freeze protection.
 	 */
-	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_set(tp);
 	__sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
 
 	/* we abort the update if there was an IO error */
@@ -568,6 +569,16 @@ xfs_vm_writepage(
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
 
@@ -579,6 +590,14 @@ xfs_vm_writepages(
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
index c94e71f741b6..09ae5c181299 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -67,6 +67,11 @@ xfs_trans_free(
 	xfs_extent_busy_sort(&tp->t_busy);
 	xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
 
+	/* Detach the transaction from this thread. */
+	ASSERT(current->journal_info != NULL);
+	if (current->journal_info == tp)
+		xfs_trans_context_clear(tp);
+
 	trace_xfs_trans_free(tp, _RET_IP_);
 	if (!(tp->t_flags & XFS_TRANS_NO_WRITECOUNT))
 		sb_end_intwrite(tp->t_mountp->m_super);
@@ -119,7 +124,11 @@ xfs_trans_dup(
 
 	ntp->t_rtx_res = tp->t_rtx_res - tp->t_rtx_res_used;
 	tp->t_rtx_res = tp->t_rtx_res_used;
+
+	/* Associate the new transaction with this thread. */
+	ASSERT(current->journal_info == tp);
 	ntp->t_pflags = tp->t_pflags;
+	current->journal_info = ntp;
 
 	/* move deferred ops over to the new tp */
 	xfs_defer_move(ntp, tp);
@@ -153,8 +162,6 @@ xfs_trans_reserve(
 	int			error = 0;
 	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
 
-	/* Mark this thread as being in a transaction */
-	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
 
 	/*
 	 * Attempt to reserve the needed disk blocks by decrementing
@@ -163,10 +170,8 @@ xfs_trans_reserve(
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
 
@@ -241,8 +246,6 @@ xfs_trans_reserve(
 		tp->t_blk_res = 0;
 	}
 
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
-
 	return error;
 }
 
@@ -284,6 +287,8 @@ xfs_trans_alloc(
 	INIT_LIST_HEAD(&tp->t_dfops);
 	tp->t_firstblock = NULLFSBLOCK;
 
+	/* Mark this thread as being in a transaction */
+	xfs_trans_context_set(tp);
 	error = xfs_trans_reserve(tp, resp, blocks, rtextents);
 	if (error) {
 		xfs_trans_cancel(tp);
@@ -878,7 +883,6 @@ __xfs_trans_commit(
 
 	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
 
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
 	xfs_trans_free(tp);
 
 	/*
@@ -910,7 +914,7 @@ __xfs_trans_commit(
 			xfs_log_ticket_ungrant(mp->m_log, tp->t_ticket);
 		tp->t_ticket = NULL;
 	}
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+
 	xfs_trans_free_items(tp, !!error);
 	xfs_trans_free(tp);
 
@@ -970,9 +974,6 @@ xfs_trans_cancel(
 		tp->t_ticket = NULL;
 	}
 
-	/* mark this thread as no longer being in a transaction */
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
-
 	xfs_trans_free_items(tp, dirty);
 	xfs_trans_free(tp);
 }
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index 084658946cc8..ceb530bf5c4b 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -268,4 +268,27 @@ xfs_trans_item_relog(
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
2.18.4

