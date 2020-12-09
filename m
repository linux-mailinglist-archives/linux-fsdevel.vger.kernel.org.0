Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7452D42EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 14:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbgLINNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 08:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbgLINNH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:13:07 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2DDC061794;
        Wed,  9 Dec 2020 05:12:27 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id z3so807640qtw.9;
        Wed, 09 Dec 2020 05:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iBZKS7fZyjdTYTaO3rtutG8028bfWaEOmNu0KLWmO18=;
        b=HsxN5ATN5b8eLKXY4ZeibMTxltQSgGAeusNM1yE9jrmciX19XFhHuP6b8i+KYmQ7RA
         8i78cmkmxPwzPYRbL5jkQ3KA7RXrQJN4V5N4OwXQjmb+0t0RJXbDP2OlQI8hctib0CGh
         iG7lMvmjJ0zsDyuqROWpQws07Q0ZpoBOwd6ZgIT+8ChDIVchr2s/9GBhK7xwICRS6xe2
         bXq/h2nyxJc4y80zJnXc4zxqK492XYFV74pvyWTUknrfncjKW/WIqUfoQJ1SWampGOWI
         64p+yPxtiYDVGmdww+sT46Mza8xf0Pc2xVnpuEM4oSVTfLIiYWgx8uI63mTb2CCM8S0l
         Jd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iBZKS7fZyjdTYTaO3rtutG8028bfWaEOmNu0KLWmO18=;
        b=RUM8SpFK32atm6FLyIQcR15UIVfWMUQBE7B7crC6Nv9CH8aBvxJg2OwUvm1XYQfWrs
         QlrcQ/sXqXxJ6Cj8XfifTalSpb40fkUx8MvkoPD9VOk5HvhrA7Cb14rNv2mso4vTbs5B
         nTS+xQ05hcMqBKRJRQrdrW6g+Rhic8qPMUoRpyVNyu/39ViW3tkzdJGHPcCR32V9yJD8
         sfDuAiYbyVV2Bl1APFWRLwuhWDFI/Z0MN8RUPDDfnSf3JXqDUoRR6CfaqjpLgy8L96IL
         WeFPTgWCWJU1p7YGUnTkKdNzySw8K81iXumivGZ6GXvAQzcNXIMgq1hnSnW999glYt8P
         R/ug==
X-Gm-Message-State: AOAM531U/ua43eaUhnmF+lOU2ecjTGmwpdE23rvELgThPLZleBYSdagb
        WKIhZ/TVQiO/v9cj0jfaIEjxum0tzXXQpw==
X-Google-Smtp-Source: ABdhPJwwOCvQR3EmCa5QLZLnDJYam2cyyD1uwIzB+gbjBFnQ/bKUFYsFwLrllWPQx5I4SJCh6tS2eQ==
X-Received: by 2002:ac8:2bd2:: with SMTP id n18mr3081861qtn.260.1607519544946;
        Wed, 09 Dec 2020 05:12:24 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id u72sm938114qka.15.2020.12.09.05.12.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 05:12:23 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v12 2/4] xfs: use memalloc_nofs_{save,restore} in xfs transaction
Date:   Wed,  9 Dec 2020 21:11:44 +0800
Message-Id: <20201209131146.67289-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201209131146.67289-1-laoar.shao@gmail.com>
References: <20201209131146.67289-1-laoar.shao@gmail.com>
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

Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
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

