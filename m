Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8532076AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 17:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404079AbgFXPGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 11:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403991AbgFXPGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:06:22 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9B5C061573;
        Wed, 24 Jun 2020 08:06:22 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 80so2097068qko.7;
        Wed, 24 Jun 2020 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BLinj9Kg0W1/34KrqwmkEhLauk6NHTmIpjaR2XnC5qs=;
        b=SLXKFqjZG3FQG2tZdxU/Ss/zollqCbWEQXMya7rMx4rr4DSab5IXUwelYXnsqu6TEv
         +40cvniBKzWETgRrHpSjGDbG9cza1NcmfGwQoeJJUXU9x+lxVkVm265zy3TrUBYa/3X0
         xL2XdG2g+DQaXAedWpWLByIod4YNC+DTxb/iKfekG0+mae3gq/3Cy5E3KCwpW4/ss7zu
         O3VYUrRldjczm6MxHGVJ5pXGc2kQTtRThrAnE97sf7USiqGN/QSIFk3egGTGoGzIFuFw
         dRW/DgaN8jU6rql7jTYwWkmLNBA0ND0J/FreCzoNK2NAYuS+cUVLcRoYQ1ELDAy89fEU
         tSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BLinj9Kg0W1/34KrqwmkEhLauk6NHTmIpjaR2XnC5qs=;
        b=YHZmr9DMDq6dZrg7CFtmnIvdZdZYxWkKMD+IIH4nX/l6u+HcONwgWpWJbz6I7pWzO3
         ZgekxhyB6UtLiachl8PIIdL2Fnu7+6IbyI6NnB4tWc73vkRhzK3GWD+CEMmzxUcQZKY1
         +I7//XoQApxrLZXMCLxXHb2XvyCHf35qSZePzx1JHLCPIy9LwltyY7oy65qgPTuBqWag
         QTG2VaVd/7MsZOMoz7eLiBzlLAQIg8Og01dKbO5K9upaVvus16pA5eKz9BaoBPoU3qBg
         ZXhBignlaHX6EsfCUlP9K3owL7/oAeoHGsjBtIfRbY2f1+CjmbuWS4Cr03o7Y4VEwiZ7
         4xHg==
X-Gm-Message-State: AOAM530Yj6xn63BimGUmfI2xyUV+26rSkWwlVu6BcCyEWY0MnpqfMLRI
        90YeLmzPQCQbI0+PAjLMH68=
X-Google-Smtp-Source: ABdhPJxVU1E9AO2pt3jX2R6NoPKTzpapTWz8JPYLuKeelKxaG9eZDZ8E0U+1nG/Y3rqY9wwKZmRPJQ==
X-Received: by 2002:a37:59c4:: with SMTP id n187mr4057972qkb.303.1593011182036;
        Wed, 24 Jun 2020 08:06:22 -0700 (PDT)
Received: from dev.localdomain ([183.134.211.54])
        by smtp.gmail.com with ESMTPSA id x26sm3435188qtp.54.2020.06.24.08.06.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:06:21 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@fromorbit.com, mhocko@kernel.org, darrick.wong@oracle.com,
        hch@infradead.org, akpm@linux-foundation.org, bfoster@redhat.com,
        vbabka@suse.cz, holger@applied-asynchrony.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2] xfs: reintroduce PF_FSTRANS for transaction reservation recursion protection
Date:   Wed, 24 Jun 2020 11:05:42 -0400
Message-Id: <1593011142-10209-1-git-send-email-laoar.shao@gmail.com>
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

[1]. Bellow check is to avoid memory reclaim recursion.
if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
	PF_MEMALLOC))
	goto redirty;

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>
---
 fs/iomap/buffered-io.c    |  4 ++--
 fs/xfs/libxfs/xfs_btree.c |  2 +-
 fs/xfs/xfs_aops.c         |  4 ++--
 fs/xfs/xfs_trans.c        | 12 ++++++------
 include/linux/sched.h     |  1 +
 5 files changed, 12 insertions(+), 11 deletions(-)

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
diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 2d25bab..4a7c8b7 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -2814,7 +2814,7 @@ struct xfs_btree_split_args {
 	struct xfs_btree_split_args	*args = container_of(work,
 						struct xfs_btree_split_args, work);
 	unsigned long		pflags;
-	unsigned long		new_pflags = PF_MEMALLOC_NOFS;
+	unsigned long		new_pflags = PF_MEMALLOC_NOFS | PF_FSTRANS;
 
 	/*
 	 * we are in a transaction context here, but may also be doing work
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index b356118..79da028 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -62,7 +62,7 @@ static inline bool xfs_ioend_is_append(struct iomap_ioend *ioend)
 	 * We hand off the transaction to the completion thread now, so
 	 * clear the flag here.
 	 */
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS | PF_FSTRANS);
 	return 0;
 }
 
@@ -125,7 +125,7 @@ static inline bool xfs_ioend_is_append(struct iomap_ioend *ioend)
 	 * thus we need to mark ourselves as being in a transaction manually.
 	 * Similarly for freeze protection.
 	 */
-	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS | PF_FSTRANS);
 	__sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
 
 	/* we abort the update if there was an IO error */
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 3c94e5f..011f52f 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -153,7 +153,7 @@
 	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
 
 	/* Mark this thread as being in a transaction */
-	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS | PF_FSTRANS);
 
 	/*
 	 * Attempt to reserve the needed disk blocks by decrementing
@@ -163,7 +163,7 @@
 	if (blocks > 0) {
 		error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
 		if (error != 0) {
-			current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+			current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS | PF_FSTRANS);
 			return -ENOSPC;
 		}
 		tp->t_blk_res += blocks;
@@ -240,7 +240,7 @@
 		tp->t_blk_res = 0;
 	}
 
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS | PF_FSTRANS);
 
 	return error;
 }
@@ -861,7 +861,7 @@
 
 	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
 
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS | PF_FSTRANS);
 	xfs_trans_free(tp);
 
 	/*
@@ -893,7 +893,7 @@
 			xfs_log_ticket_ungrant(mp->m_log, tp->t_ticket);
 		tp->t_ticket = NULL;
 	}
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS | PF_FSTRANS);
 	xfs_trans_free_items(tp, !!error);
 	xfs_trans_free(tp);
 
@@ -954,7 +954,7 @@
 	}
 
 	/* mark this thread as no longer being in a transaction */
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS | PF_FSTRANS);
 
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

