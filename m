Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188DC202229
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgFTHNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgFTHNd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:13:33 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBCDC06174E;
        Sat, 20 Jun 2020 00:13:32 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o38so296668qtf.6;
        Sat, 20 Jun 2020 00:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pSC21m1eui1uNlZl1glbSC5gcaO4v1zj7VkJ4qSp0fU=;
        b=e2L4QysiB7Rs0oLYYkXgYUsqWGC2n4PyIIfNCPzOY0/WA8mnDsnxsGhhuROrgRWFfu
         XTciaCUPRPqLsKr+5nAFgmwZgJcHwS0BDb+MvuIuIfl8liJnXdgyPYLpRFsZjaWbdPZk
         0yebGKNNeBX35Xnaq1jkBfCnYgKCj3hr/Ah2El+zHW6y1+2eEzqFv0DcpNm23stjwFeg
         q2m4SWuUXia8UhIhWQsSADiEShRkZnD1/UlDtc/MJKJinbe5Y0/qd16Y7LsjHzlwRMwj
         MFuvn3T9rS8WinGh4FP3kFw674OrctFtlLmWtECS3CJe8A7Y6xOyc2rWCMnv5IbP/oBv
         n6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pSC21m1eui1uNlZl1glbSC5gcaO4v1zj7VkJ4qSp0fU=;
        b=OROnbUVZWd5m+9gbe9wOR/KSDvJJ/+uynrZZTW/kxQ2uTGnFwaVO5AVqy6qLzlA3zD
         DMqdD5S0Si2uJT56dN/8SxrlUIVgopAr41WgouPc/wRWE+SkPEvDdQTKxcHuzAO+ey5p
         Mq+6XbaLPxK4ww51A4u67rX2QqCao7MLfcP1MnYWTO/Z5QE1LWN6y2tnz4+r22Tk5FYv
         fOh3nW1IySG34g4ib27+vlOAp4bRd91tmVgTz67KPpZ8asfU1h177ToSwYMSNA7GP+gR
         9cFbKCbkEw0kMpEF+7K41My+7sy4UE9MQd1pyqYC8zezldYh2I/D99E51Ac6muC3bm71
         ZMaQ==
X-Gm-Message-State: AOAM5301CNMbVpmKzAUKHOqVbljo/cyyUM7NzXt4JyYCU4Y0N7Is2wnw
        NuR60WkhtcB4xJRquxedZXA=
X-Google-Smtp-Source: ABdhPJxgc/10rPIqEI+tggd4mZ+POc95Rbap5AoTOakoSl1LP0PJSpF5u6WJIGFlsa8vRlqjs8ipcA==
X-Received: by 2002:aed:235b:: with SMTP id i27mr6756475qtc.356.1592637211543;
        Sat, 20 Jun 2020 00:13:31 -0700 (PDT)
Received: from dev.localdomain ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id k20sm9047272qtu.16.2020.06.20.00.13.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jun 2020 00:13:30 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@fromorbit.com, mhocko@kernel.org, darrick.wong@oracle.com,
        hch@infradead.org, akpm@linux-foundation.org, bfoster@redhat.com,
        vbabka@suse.cz
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] xfs: reintroduce PF_FSTRANS for transaction reservation recursion protection
Date:   Sat, 20 Jun 2020 03:12:54 -0400
Message-Id: <1592637174-19657-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
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

Besides reintroducing PF_FSTRANS, there're some other improvements in this
patch,
- Remove useless MACRO current_clear_flags_nested(), current_pid() and
  current_test_flags().
- Remove useless memalloc_nofs_{save, restore} in __kmem_vmalloc()

[1]. Bellow check is to avoid memory reclaim recursion.
if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
	PF_MEMALLOC))
	goto redirty;

Cc: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/iomap/buffered-io.c    |  4 ++--
 fs/xfs/kmem.c             |  7 -------
 fs/xfs/kmem.h             |  2 +-
 fs/xfs/libxfs/xfs_btree.c |  2 +-
 fs/xfs/xfs_aops.c         |  4 ++--
 fs/xfs/xfs_linux.h        |  4 ----
 fs/xfs/xfs_trans.c        | 12 ++++++------
 include/linux/sched.h     |  1 +
 8 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288..0f1945c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1500,9 +1500,9 @@ static void iomap_writepage_end_bio(struct bio *bio)
 
 	/*
 	 * Given that we do not allow direct reclaim to call us, we should
-	 * never be called in a recursive filesystem reclaim context.
+	 * never be called while in a filesystem transaction.
 	 */
-	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
+	if (WARN_ON_ONCE(current->flags & PF_FSTRANS))
 		goto redirty;
 
 	/*
diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
index f136647..9875a23 100644
--- a/fs/xfs/kmem.c
+++ b/fs/xfs/kmem.c
@@ -41,18 +41,11 @@
 static void *
 __kmem_vmalloc(size_t size, xfs_km_flags_t flags)
 {
-	unsigned nofs_flag = 0;
 	void	*ptr;
 	gfp_t	lflags = kmem_flags_convert(flags);
 
-	if (flags & KM_NOFS)
-		nofs_flag = memalloc_nofs_save();
-
 	ptr = __vmalloc(size, lflags);
 
-	if (flags & KM_NOFS)
-		memalloc_nofs_restore(nofs_flag);
-
 	return ptr;
 }
 
diff --git a/fs/xfs/kmem.h b/fs/xfs/kmem.h
index 34cbcfd..ccc63de 100644
--- a/fs/xfs/kmem.h
+++ b/fs/xfs/kmem.h
@@ -34,7 +34,7 @@
 	BUG_ON(flags & ~(KM_NOFS | KM_MAYFAIL | KM_ZERO | KM_NOLOCKDEP));
 
 	lflags = GFP_KERNEL | __GFP_NOWARN;
-	if (flags & KM_NOFS)
+	if (current->flags & PF_FSTRANS || flags & KM_NOFS)
 		lflags &= ~__GFP_FS;
 
 	/*
diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 2d25bab..65d0afe 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -2814,7 +2814,7 @@ struct xfs_btree_split_args {
 	struct xfs_btree_split_args	*args = container_of(work,
 						struct xfs_btree_split_args, work);
 	unsigned long		pflags;
-	unsigned long		new_pflags = PF_MEMALLOC_NOFS;
+	unsigned long		new_pflags = PF_FSTRANS;
 
 	/*
 	 * we are in a transaction context here, but may also be doing work
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index b356118..02733eb 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -62,7 +62,7 @@ static inline bool xfs_ioend_is_append(struct iomap_ioend *ioend)
 	 * We hand off the transaction to the completion thread now, so
 	 * clear the flag here.
 	 */
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	current_restore_flags_nested(&tp->t_pflags, PF_FSTRANS);
 	return 0;
 }
 
@@ -125,7 +125,7 @@ static inline bool xfs_ioend_is_append(struct iomap_ioend *ioend)
 	 * thus we need to mark ourselves as being in a transaction manually.
 	 * Similarly for freeze protection.
 	 */
-	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	current_set_flags_nested(&tp->t_pflags, PF_FSTRANS);
 	__sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
 
 	/* we abort the update if there was an IO error */
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 9f70d2f..ab737fe 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -102,12 +102,8 @@
 #define xfs_cowb_secs		xfs_params.cowb_timer.val
 
 #define current_cpu()		(raw_smp_processor_id())
-#define current_pid()		(current->pid)
-#define current_test_flags(f)	(current->flags & (f))
 #define current_set_flags_nested(sp, f)		\
 		(*(sp) = current->flags, current->flags |= (f))
-#define current_clear_flags_nested(sp, f)	\
-		(*(sp) = current->flags, current->flags &= ~(f))
 #define current_restore_flags_nested(sp, f)	\
 		(current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))
 
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 3c94e5f..1c1b982 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -153,7 +153,7 @@
 	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
 
 	/* Mark this thread as being in a transaction */
-	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	current_set_flags_nested(&tp->t_pflags, PF_FSTRANS);
 
 	/*
 	 * Attempt to reserve the needed disk blocks by decrementing
@@ -163,7 +163,7 @@
 	if (blocks > 0) {
 		error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
 		if (error != 0) {
-			current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+			current_restore_flags_nested(&tp->t_pflags, PF_FSTRANS);
 			return -ENOSPC;
 		}
 		tp->t_blk_res += blocks;
@@ -240,7 +240,7 @@
 		tp->t_blk_res = 0;
 	}
 
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	current_restore_flags_nested(&tp->t_pflags, PF_FSTRANS);
 
 	return error;
 }
@@ -861,7 +861,7 @@
 
 	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
 
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	current_restore_flags_nested(&tp->t_pflags, PF_FSTRANS);
 	xfs_trans_free(tp);
 
 	/*
@@ -893,7 +893,7 @@
 			xfs_log_ticket_ungrant(mp->m_log, tp->t_ticket);
 		tp->t_ticket = NULL;
 	}
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	current_restore_flags_nested(&tp->t_pflags, PF_FSTRANS);
 	xfs_trans_free_items(tp, !!error);
 	xfs_trans_free(tp);
 
@@ -954,7 +954,7 @@
 	}
 
 	/* mark this thread as no longer being in a transaction */
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	current_restore_flags_nested(&tp->t_pflags, PF_FSTRANS);
 
 	xfs_trans_free_items(tp, dirty);
 	xfs_trans_free(tp);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b62e6aa..02045e8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1511,6 +1511,7 @@ static inline int is_global_init(struct task_struct *tsk)
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
+#define PF_FSTRANS		0x01000000	/* Inside a filesystem transaction */
 #define PF_UMH			0x02000000	/* I'm an Usermodehelper process */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
-- 
1.8.3.1

