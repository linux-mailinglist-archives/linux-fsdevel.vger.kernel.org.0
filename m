Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DAC23C248
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 01:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgHDXur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 19:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgHDXur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 19:50:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B41EC06174A;
        Tue,  4 Aug 2020 16:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9KAVH8XxKK6xJEgnKPVNlHuH4H6EARdVe0XtOFXtKX4=; b=HfKdcwHNyINidsUuEmksj7WOWw
        gcF1Clylu7b5CIaIEQ0g3f4Rl1Bal3syUpMEoH6IT7MqjkXLuzULZUvuTtHo+T7VI2u8gFd+bxHkz
        gYnP2nXpnGlIYCaxS3tpCClV51yspi6P8azCK35CsaoSf4ObKafUzILFNAcn1jDngAxJLgfhjLe78
        NU2k4VNT5Mx4rf1z85uMTl2xkJeVh81VlVFTTZb59UyBnmLX/CS6psX1TAEPXYRLlzsy4Yrlq4ROX
        yeJ2MlbllcxgkLBwmv4mr1dl7BQRSz95nUjX72ip6+nDqqgb+MWiYSvBOFOCwVynXdek+af+yZfVI
        jTH/jJ/A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k36ha-00083x-4K; Tue, 04 Aug 2020 23:50:38 +0000
Date:   Wed, 5 Aug 2020 00:50:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, hch@infradead.org,
        darrick.wong@oracle.com, mhocko@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <shaoyafang@didiglobal.com>
Subject: Re: [PATCH v4 1/2] xfs: avoid double restore PF_MEMALLOC_NOFS if
 transaction reservation fails
Message-ID: <20200804235038.GL23808@casper.infradead.org>
References: <20200801154632.866356-1-laoar.shao@gmail.com>
 <20200801154632.866356-2-laoar.shao@gmail.com>
 <20200804232005.GD2114@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804232005.GD2114@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 05, 2020 at 09:20:05AM +1000, Dave Chinner wrote:
> Also, please convert these to memalloc_nofs_save()/restore() calls
> as that is the way we are supposed to mark these regions now.

I have a patch for that!


From 7830a7dc66f349e16ef34bd408b9962f4c4bcdba Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Fri, 27 Mar 2020 13:01:57 -0400
Subject: [PATCH 3/6] xfs: Convert to memalloc_nofs_save
To: linux-kernel@vger.kernel.org,
    linux-mm@kvack.org
Cc: linux-xfs@vger.kernel.org,
    dm-devel@redhat.com,
    Mikulas Patocka <mpatocka@redhat.com>,
    Jens Axboe <axboe@kernel.dk>,
    NeilBrown <neilb@suse.de>

Instead of using custom macros to set/restore PF_MEMALLOC_NOFS, use
memalloc_nofs_save() like the rest of the kernel.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/xfs/kmem.c      |  2 +-
 fs/xfs/xfs_aops.c  |  4 ++--
 fs/xfs/xfs_buf.c   |  2 +-
 fs/xfs/xfs_linux.h |  6 ------
 fs/xfs/xfs_trans.c | 14 +++++++-------
 fs/xfs/xfs_trans.h |  2 +-
 6 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
index f1366475c389..c2d237159bfc 100644
--- a/fs/xfs/kmem.c
+++ b/fs/xfs/kmem.c
@@ -35,7 +35,7 @@ kmem_alloc(size_t size, xfs_km_flags_t flags)
  * __vmalloc() will allocate data pages and auxiliary structures (e.g.
  * pagetables) with GFP_KERNEL, yet we may be under GFP_NOFS context here. Hence
  * we need to tell memory reclaim that we are in such a context via
- * PF_MEMALLOC_NOFS to prevent memory reclaim re-entering the filesystem here
+ * memalloc_nofs to prevent memory reclaim re-entering the filesystem here
  * and potentially deadlocking.
  */
 static void *
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index b35611882ff9..e3a4806e519d 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -62,7 +62,7 @@ xfs_setfilesize_trans_alloc(
 	 * We hand off the transaction to the completion thread now, so
 	 * clear the flag here.
 	 */
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	memalloc_nofs_restore(tp->t_memalloc);
 	return 0;
 }
 
@@ -125,7 +125,7 @@ xfs_setfilesize_ioend(
 	 * thus we need to mark ourselves as being in a transaction manually.
 	 * Similarly for freeze protection.
 	 */
-	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	tp->t_memalloc = memalloc_nofs_save();
 	__sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
 
 	/* we abort the update if there was an IO error */
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 20b748f7e186..b2c3d01c690b 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -470,7 +470,7 @@ _xfs_buf_map_pages(
 		 * vm_map_ram() will allocate auxiliary structures (e.g.
 		 * pagetables) with GFP_KERNEL, yet we are likely to be under
 		 * GFP_NOFS context here. Hence we need to tell memory reclaim
-		 * that we are in such a context via PF_MEMALLOC_NOFS to prevent
+		 * that we are in such a context via memalloc_nofs to prevent
 		 * memory reclaim re-entering the filesystem here and
 		 * potentially deadlocking.
 		 */
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 9f70d2f68e05..e1daf242a53b 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -104,12 +104,6 @@ typedef __u32			xfs_nlink_t;
 #define current_cpu()		(raw_smp_processor_id())
 #define current_pid()		(current->pid)
 #define current_test_flags(f)	(current->flags & (f))
-#define current_set_flags_nested(sp, f)		\
-		(*(sp) = current->flags, current->flags |= (f))
-#define current_clear_flags_nested(sp, f)	\
-		(*(sp) = current->flags, current->flags &= ~(f))
-#define current_restore_flags_nested(sp, f)	\
-		(current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))
 
 #define NBBY		8		/* number of bits per byte */
 
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 3c94e5ff4316..4ef1a0ff0a11 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -118,7 +118,7 @@ xfs_trans_dup(
 
 	ntp->t_rtx_res = tp->t_rtx_res - tp->t_rtx_res_used;
 	tp->t_rtx_res = tp->t_rtx_res_used;
-	ntp->t_pflags = tp->t_pflags;
+	ntp->t_memalloc = tp->t_memalloc;
 
 	/* move deferred ops over to the new tp */
 	xfs_defer_move(ntp, tp);
@@ -153,7 +153,7 @@ xfs_trans_reserve(
 	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
 
 	/* Mark this thread as being in a transaction */
-	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	tp->t_memalloc = memalloc_nofs_save();
 
 	/*
 	 * Attempt to reserve the needed disk blocks by decrementing
@@ -163,7 +163,7 @@ xfs_trans_reserve(
 	if (blocks > 0) {
 		error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
 		if (error != 0) {
-			current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+			memalloc_nofs_restore(tp->t_memalloc);
 			return -ENOSPC;
 		}
 		tp->t_blk_res += blocks;
@@ -240,7 +240,7 @@ xfs_trans_reserve(
 		tp->t_blk_res = 0;
 	}
 
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	memalloc_nofs_restore(tp->t_memalloc);
 
 	return error;
 }
@@ -861,7 +861,7 @@ __xfs_trans_commit(
 
 	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
 
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	memalloc_nofs_restore(tp->t_memalloc);
 	xfs_trans_free(tp);
 
 	/*
@@ -893,7 +893,7 @@ __xfs_trans_commit(
 			xfs_log_ticket_ungrant(mp->m_log, tp->t_ticket);
 		tp->t_ticket = NULL;
 	}
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	memalloc_nofs_restore(tp->t_memalloc);
 	xfs_trans_free_items(tp, !!error);
 	xfs_trans_free(tp);
 
@@ -954,7 +954,7 @@ xfs_trans_cancel(
 	}
 
 	/* mark this thread as no longer being in a transaction */
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	memalloc_nofs_restore(tp->t_memalloc);
 
 	xfs_trans_free_items(tp, dirty);
 	xfs_trans_free(tp);
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index 8308bf6d7e40..7aa2d5ff9245 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -118,6 +118,7 @@ typedef struct xfs_trans {
 	unsigned int		t_rtx_res;	/* # of rt extents resvd */
 	unsigned int		t_rtx_res_used;	/* # of resvd rt extents used */
 	unsigned int		t_flags;	/* misc flags */
+	unsigned int		t_memalloc;	/* saved memalloc state */
 	xfs_fsblock_t		t_firstblock;	/* first block allocated */
 	struct xlog_ticket	*t_ticket;	/* log mgr ticket */
 	struct xfs_mount	*t_mountp;	/* ptr to fs mount struct */
@@ -144,7 +145,6 @@ typedef struct xfs_trans {
 	struct list_head	t_items;	/* log item descriptors */
 	struct list_head	t_busy;		/* list of busy extents */
 	struct list_head	t_dfops;	/* deferred operations */
-	unsigned long		t_pflags;	/* saved process flags state */
 } xfs_trans_t;
 
 /*
-- 
2.27.0

