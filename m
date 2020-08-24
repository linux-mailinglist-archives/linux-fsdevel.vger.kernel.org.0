Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C2324F0F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 03:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHXBn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Aug 2020 21:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgHXBnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Aug 2020 21:43:24 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4181EC061573;
        Sun, 23 Aug 2020 18:43:24 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id f19so5186276qtp.2;
        Sun, 23 Aug 2020 18:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p/Aa+4/PAdW4UzIOLAlILdbf31440xpvhPKoHCUn5Lg=;
        b=GJfleXBWQMZRAOCc58l26UD/2OnznQ2xXFpx5YS7Fs7cjuIeKUo3/hmL3O1/AQ54Gw
         YO9FZttNqQAeqMIqCjXe5pZFkNRiNsJFkcqjZRxre0JWraYrAI95JtpjQlc5zz/BDmgL
         vGgJrb6B+cYTsu7c1SXcNV418I5nnFTjRxiE3kaSNsY9uMhczkmsv04tcSvWa/F+gjfS
         PmMNi8utmjew4Lgte2XbsxM5DDqRs5XjLaNcr+EvQro5mJKf9IDSIRTL8Qlz9uPZwr3W
         gtxsiOFu10pRLbY2uvQIqfDExU55gkIN5X9auBAIgIj2wa8SsSH4+XfnWdHAjfLWh4FJ
         VQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p/Aa+4/PAdW4UzIOLAlILdbf31440xpvhPKoHCUn5Lg=;
        b=nlipwGCgHDDAaDDWV4MayuuQy4vDOVSvsYhHNV+1kPoBXgBHvawx8dYW3FToJT17Md
         J2Al/UPKYp2K/vyfC11jyR/zdiCd3VDTzr502lxgfl+wAT3QjJvfPtpOQWihI7L2Fdsb
         mHkucKOIc8G3fW+9VdnSN20owEfDeNyuqWQNUEYKEjZLY77mVZ5uuyxN+zuHCXd7lyhS
         LCf1IhlNQ7mIvZ/T4PFjp1x0KOgcxQ0Pz5X9Rt+ShdPicn4sEtWawSo/ZHNfmHdBqpFJ
         9YWtqdDhFAFwis5BCgXxoocjysDv6t9XimpsDje7bWmkjN86WQhYYH9PurGHgAJmmZHZ
         eYAA==
X-Gm-Message-State: AOAM533Ow6EtCzcopglcp13NF9XbN1Ca3wQgMPzcjM+bB4sf7yYxE2V3
        D+jH3tVSWgZjoxUZc9kLXp4=
X-Google-Smtp-Source: ABdhPJxhQgveld9b97WUsuzJNGeORAh9h3i0bi1kXDqhtpmrqPFEOAB2upif5n9TfDCs11oA+PTOpA==
X-Received: by 2002:ac8:3a84:: with SMTP id x4mr3004272qte.361.1598233401764;
        Sun, 23 Aug 2020 18:43:21 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id t8sm10205236qtc.50.2020.08.23.18.43.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Aug 2020 18:43:21 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        willy@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 2/2] xfs: avoid transaction reservation recursion
Date:   Mon, 24 Aug 2020 09:42:34 +0800
Message-Id: <20200824014234.7109-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200824014234.7109-1-laoar.shao@gmail.com>
References: <20200824014234.7109-1-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
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
fstrans or not, Per Willy. To achieve that, four new helpers are introduce in
this patch, per Dave:
- xfs_trans_context_set()
  Used in xfs_trans_alloc()
- xfs_trans_context_clear()
  Used in xfs_trans_commit() and xfs_trans_cancel()
- xfs_trans_context_update()
  Used in xfs_trans_roll()
- fstrans_context_active()
  To check whehter current is in fs transcation or not

[1]. Below check is to avoid memory reclaim recursion.
if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
        PF_MEMALLOC))
        goto redirty;

Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/iomap/buffered-io.c |  4 ++--
 fs/xfs/xfs_aops.c      |  5 +++--
 fs/xfs/xfs_linux.h     |  4 ----
 fs/xfs/xfs_trans.c     | 19 +++++++++----------
 fs/xfs/xfs_trans.h     | 23 +++++++++++++++++++++++
 include/linux/iomap.h  |  7 +++++++
 6 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..8043224ec079 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1500,9 +1500,9 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 
 	/*
 	 * Given that we do not allow direct reclaim to call us, we should
-	 * never be called in a recursive filesystem reclaim context.
+	 * never be called while in a filesystem transaction.
 	 */
-	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
+	if (WARN_ON_ONCE(fstrans_context_active()))
 		goto redirty;
 
 	/*
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index b35611882ff9..83e0a1840221 100644
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
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index ab737fed7b12..8a4f6db77e33 100644
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
index ed72867b1a19..5f3a4ff51b3c 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -153,8 +153,6 @@ xfs_trans_reserve(
 	int			error = 0;
 	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
 
-	/* Mark this thread as being in a transaction */
-	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
 
 	/*
 	 * Attempt to reserve the needed disk blocks by decrementing
@@ -163,10 +161,8 @@ xfs_trans_reserve(
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
 
@@ -241,8 +237,6 @@ xfs_trans_reserve(
 		tp->t_blk_res = 0;
 	}
 
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
-
 	return error;
 }
 
@@ -284,6 +278,8 @@ xfs_trans_alloc(
 	INIT_LIST_HEAD(&tp->t_dfops);
 	tp->t_firstblock = NULLFSBLOCK;
 
+	/* Mark this thread as being in a transaction */
+	xfs_trans_context_set(tp);
 	error = xfs_trans_reserve(tp, resp, blocks, rtextents);
 	if (error) {
 		xfs_trans_cancel(tp);
@@ -878,7 +874,8 @@ __xfs_trans_commit(
 
 	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
 
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	if (!regrant)
+		xfs_trans_context_clear(tp);
 	xfs_trans_free(tp);
 
 	/*
@@ -910,7 +907,8 @@ __xfs_trans_commit(
 			xfs_log_ticket_ungrant(mp->m_log, tp->t_ticket);
 		tp->t_ticket = NULL;
 	}
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+
+	xfs_trans_context_clear(tp);
 	xfs_trans_free_items(tp, !!error);
 	xfs_trans_free(tp);
 
@@ -971,7 +969,7 @@ xfs_trans_cancel(
 	}
 
 	/* mark this thread as no longer being in a transaction */
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_clear(tp);
 
 	xfs_trans_free_items(tp, dirty);
 	xfs_trans_free(tp);
@@ -1013,6 +1011,7 @@ xfs_trans_roll(
 	if (error)
 		return error;
 
+	xfs_trans_context_update(trans, *tpp);
 	/*
 	 * Reserve space in the log for the next transaction.
 	 * This also pushes items in the "AIL", the list of logged items,
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index b752501818d2..895f560229d6 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -243,4 +243,27 @@ void		xfs_trans_buf_copy_type(struct xfs_buf *dst_bp,
 
 extern kmem_zone_t	*xfs_trans_zone;
 
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
 #endif	/* __XFS_TRANS_H__ */
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4d1d3c3469e9..54194dd6009d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -271,4 +271,11 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 # define iomap_swapfile_activate(sis, swapfile, pagespan, ops)	(-EIO)
 #endif /* CONFIG_SWAP */
 
+/* Use the journal_info to indicate current is in a transaction */
+static inline bool
+fstrans_context_active(void)
+{
+	return current->journal_info != NULL;
+}
+
 #endif /* LINUX_IOMAP_H */
-- 
2.18.1

