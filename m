Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB59E22DFC6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 16:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgGZO6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 10:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGZO6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 10:58:40 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F17CC0619D2;
        Sun, 26 Jul 2020 07:58:40 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so13024050qkc.6;
        Sun, 26 Jul 2020 07:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KAfwsQAYRTAnXNOuNdMTgyk/UNE7iK0HNM+7zF7RzbI=;
        b=H+wgeYHvVBXeQ59wBmmIoeWwfKiLmBfcZo3/KtPMpCCnsHYHcTGluSMDWjMhLV0UK2
         HoDGD1C3ZNzOB3YCZ43fHdW8/KqvHbt4ZpqykTmCj41YULtMi4OBc9/jTw+C/Qi4K/Mu
         gYZfQJraoAknWwKMXka5xaG/8eZFBj8P3XUuRI9fUpT8jr2mP7PE6hvstcQ1yTEgzPda
         OGKul3TPPtXs6uuKzy0g6Gc1iDHr+Tx3Mp0MtOwSak6pTVXcSA/SJoDg5SWiowgTeoj0
         NI5b2V7yHI4VIwcffwndDxlBXt3cEC08ZPu2d2GTXGwoUOFCgNVamIJPd8cV5/tNO06U
         FkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KAfwsQAYRTAnXNOuNdMTgyk/UNE7iK0HNM+7zF7RzbI=;
        b=ZD0qnXUiVZZ1mDSudwlECa7HXtS4Qp2OD7GH9xOZ2NbYtV4nFomn1FFfYYBjD4YjfX
         FFn9HXn0cDu8MRw2uw+XNWI8m0DJlt2UEM/tZyjXfZWd9ZNuNYZqQKtvhIvMM+nU6PMD
         Z75bj5OIEyKjwnx+Z7wj9nBIeE4alD9sl87aDq1ne+CRF4HqKMf05N18oe3lK2CSM8I1
         TVXFqwrS58+9TriMzgxHX45KNQZ9/bZKJqMq1ra0/eflkygmZFM8eSO/TP6hCCrYESje
         hZ6FGYpDN3S+nGAFtbQuTivBjgh4if31DvBfPMFikGX+9hRdtU8JabRyr91kKnd7vfOR
         ENLg==
X-Gm-Message-State: AOAM531CyELNfpnaD0Q40W258h/C+mE2v55IzO35SyfkRfKcPuWlAmTV
        NVoJ1V1BK+YCoXHH1PkAlrmIi9+GL5Y=
X-Google-Smtp-Source: ABdhPJwM/B+9Oh6lt9bJpucORvrEO+0Oid6n3VVdRJVaMJxcnf7D2M3HaOTjy14UUFdxFfgVa+tOhg==
X-Received: by 2002:a37:4d97:: with SMTP id a145mr18483770qkb.380.1595775519540;
        Sun, 26 Jul 2020 07:58:39 -0700 (PDT)
Received: from localhost.localdomain ([183.134.211.54])
        by smtp.gmail.com with ESMTPSA id y143sm15385178qka.22.2020.07.26.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 07:58:38 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        mhocko@kernel.org, willy@infradead.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3] xfs: introduce task->in_fstrans for transaction reservation recursion protection
Date:   Sun, 26 Jul 2020 10:57:26 -0400
Message-Id: <20200726145726.1484-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.18.1
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
Bellow comment is quoted from Dave,
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

As a result, we should reintroduce PF_FSTRANS. Because PF_FSTRANS is only
set by current, we can move it out of task->flags to avoid being out of PF_
flags. So a new flag in_fstrans is introduced.

[1]. Bellow check is to avoid memory reclaim recursion.
if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
	PF_MEMALLOC))
	goto redirty;

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>

---
v2 -> v3:
- retitle from "xfs: reintroduce PF_FSTRANS for transaction reservation recursion protection"
- replace PF_FSTRANS with in_fstrans, per Christoph.
---
 fs/iomap/buffered-io.c    |  4 ++--
 fs/xfs/libxfs/xfs_btree.c |  3 +++
 fs/xfs/xfs_aops.c         |  3 +++
 fs/xfs/xfs_linux.h        | 14 ++++++++++++++
 fs/xfs/xfs_trans.c        |  7 +++++++
 fs/xfs/xfs_trans.h        |  1 +
 include/linux/sched.h     |  2 ++
 7 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..a90d865fb435 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1500,9 +1500,9 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 
 	/*
 	 * Given that we do not allow direct reclaim to call us, we should
-	 * never be called in a recursive filesystem reclaim context.
+	 * never be called while in a filesystem transaction.
 	 */
-	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
+	if (WARN_ON_ONCE(current->in_fstrans))
 		goto redirty;
 
 	/*
diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 2d25bab68764..7f55ab17d5dd 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -2815,6 +2815,7 @@ xfs_btree_split_worker(
 						struct xfs_btree_split_args, work);
 	unsigned long		pflags;
 	unsigned long		new_pflags = PF_MEMALLOC_NOFS;
+	unsigned int		in_fstrans;
 
 	/*
 	 * we are in a transaction context here, but may also be doing work
@@ -2825,6 +2826,7 @@ xfs_btree_split_worker(
 	if (args->kswapd)
 		new_pflags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
 
+	in_fstrans = xfs_trans_context_start();
 	current_set_flags_nested(&pflags, new_pflags);
 
 	args->result = __xfs_btree_split(args->cur, args->level, args->ptrp,
@@ -2832,6 +2834,7 @@ xfs_btree_split_worker(
 	complete(args->done);
 
 	current_restore_flags_nested(&pflags, new_pflags);
+	xfs_trans_context_end(in_fstrans);
 }
 
 /*
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index b35611882ff9..65fc997159fa 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -63,6 +63,8 @@ xfs_setfilesize_trans_alloc(
 	 * clear the flag here.
 	 */
 	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_end(tp->t_fstrans);
+
 	return 0;
 }
 
@@ -125,6 +127,7 @@ xfs_setfilesize_ioend(
 	 * thus we need to mark ourselves as being in a transaction manually.
 	 * Similarly for freeze protection.
 	 */
+	tp->t_fstrans = xfs_trans_context_start();
 	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
 	__sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
 
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 9f70d2f68e05..5cee22b1674f 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -111,6 +111,20 @@ typedef __u32			xfs_nlink_t;
 #define current_restore_flags_nested(sp, f)	\
 		(current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))
 
+static inline unsigned int xfs_trans_context_start(void)
+{
+	unsigned int flags = current->in_fstrans;
+
+	current->in_fstrans = 1;
+
+	return flags;
+}
+
+static inline void xfs_trans_context_end(unsigned int flags)
+{
+	current->in_fstrans = flags ? 1 : 0;
+}
+
 #define NBBY		8		/* number of bits per byte */
 
 /*
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 3c94e5ff4316..8936c650abc9 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -153,6 +153,7 @@ xfs_trans_reserve(
 	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
 
 	/* Mark this thread as being in a transaction */
+	tp->t_fstrans = xfs_trans_context_start();
 	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
 
 	/*
@@ -164,6 +165,7 @@ xfs_trans_reserve(
 		error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
 		if (error != 0) {
 			current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+			xfs_trans_context_end(tp->t_fstrans);
 			return -ENOSPC;
 		}
 		tp->t_blk_res += blocks;
@@ -241,6 +243,7 @@ xfs_trans_reserve(
 	}
 
 	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_end(tp->t_fstrans);
 
 	return error;
 }
@@ -862,6 +865,7 @@ __xfs_trans_commit(
 	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
 
 	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_end(tp->t_fstrans);
 	xfs_trans_free(tp);
 
 	/*
@@ -893,7 +897,9 @@ __xfs_trans_commit(
 			xfs_log_ticket_ungrant(mp->m_log, tp->t_ticket);
 		tp->t_ticket = NULL;
 	}
+
 	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_end(tp->t_fstrans);
 	xfs_trans_free_items(tp, !!error);
 	xfs_trans_free(tp);
 
@@ -955,6 +961,7 @@ xfs_trans_cancel(
 
 	/* mark this thread as no longer being in a transaction */
 	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_end(tp->t_fstrans);
 
 	xfs_trans_free_items(tp, dirty);
 	xfs_trans_free(tp);
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index 8308bf6d7e40..eeb307536efe 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -118,6 +118,7 @@ typedef struct xfs_trans {
 	unsigned int		t_rtx_res;	/* # of rt extents resvd */
 	unsigned int		t_rtx_res_used;	/* # of resvd rt extents used */
 	unsigned int		t_flags;	/* misc flags */
+	unsigned int		t_fstrans;	/* saved fstrans state */
 	xfs_fsblock_t		t_firstblock;	/* first block allocated */
 	struct xlog_ticket	*t_ticket;	/* log mgr ticket */
 	struct xfs_mount	*t_mountp;	/* ptr to fs mount struct */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 692e327d7455..82a0a3999cbb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -800,6 +800,8 @@ struct task_struct {
 	/* Stalled due to lack of memory */
 	unsigned			in_memstall:1;
 #endif
+	/* Inside a filesystem transaction */
+	unsigned			in_fstrans:1;
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
-- 
2.18.1

