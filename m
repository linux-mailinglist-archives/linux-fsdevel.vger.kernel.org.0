Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FF92DCA6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 02:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbgLQBNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 20:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389016AbgLQBNI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 20:13:08 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC86EC0617A7;
        Wed, 16 Dec 2020 17:12:27 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id s23so8628534uaq.10;
        Wed, 16 Dec 2020 17:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cd4JF0ZR2KfQvs7FahxcUpavGYokTwPG9ns84faHko4=;
        b=RK/hYKSW5JgHtrKLNvLNfWz0OmgDAm6pj82G4IIu4cjEoJmIANVtGWiHaW4cZij0Vn
         H0/APDsdXUyiwkheJ0U00RGGiXbsNtKxcx6K3mhyeH1Y3j74E6jpCP/7OUUrPkRZQT1d
         NmGn1WsVpKz50SFslWF9wUkiGfkPHopeAe/75ouEB7Jp5JIejC875Kfz5qIlcrGfNaxv
         P2+uW/7atJ5G52HMEA1tgVzOu3p9cFlzlRWmuTu3KPtDVJxKo1O9GujkyLBU/NTZnHSM
         Dj6E0Q5eGRB/OHz9sp6+1OtrF/5Qy0xrf6hBENTopc0cMRcUrOs2Iw89hidknMqb1l6B
         oRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cd4JF0ZR2KfQvs7FahxcUpavGYokTwPG9ns84faHko4=;
        b=WrC0OLORi1xlTy4Y9WC/Zp5+ezJv5bbC5wTHfp4a2Z3LNSflgaP/LIv/qGahLyNZYZ
         fX94Gpv8UIXk0a0mJNXqGMTxtZTTPpir8b7CtHADaPUvxfQp8E4a9yqeezHhkf9WCE4Q
         DZjbCVuPSfkVUSmrJHvDAQYdM1t73e7eA+Y0ABH1d3K+xL2m+HYmAafYobFIMFW/xbfr
         mu3h9xOmdS9EQkh9HiZ+kILxP6SrATgRs2Tyvqf77ZlUHkTnX5OdgwR4vY9gsJtPVI5h
         vNY99d7gMXzZ94t735U+CZ53d3xSKD600GzFhWuZxNMURnBNqNcb5qt5hg75IC8aUNjN
         qo8w==
X-Gm-Message-State: AOAM532GB9O4qCIv+zh34FbesnuIQyjCpS6lEiOknsIdnVUmfVw3L3be
        BMa1DgMu55cTESTqD+i2nbs=
X-Google-Smtp-Source: ABdhPJxvwR0b2U/ZCHfDQPXvCX31ndWFVYmWR6GBXd8PtNbPGK6MzLrtIs1Rt0qPK/w+9XAPP4mtTQ==
X-Received: by 2002:a9f:204e:: with SMTP id 72mr7554308uam.19.1608167546985;
        Wed, 16 Dec 2020 17:12:26 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id i63sm2900760uad.4.2020.12.16.17.12.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 17:12:26 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 3/4] xfs: refactor the usage around xfs_trans_context_{set,clear}
Date:   Thu, 17 Dec 2020 09:11:56 +0800
Message-Id: <20201217011157.92549-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201217011157.92549-1-laoar.shao@gmail.com>
References: <20201217011157.92549-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The xfs_trans context should be active after it is allocated, and
deactive when it is freed.
The rolling transaction should be specially considered, because in the
case when we clear the old transaction the thread's NOFS state shouldn't
be changed, as a result we have to set NOFS in the old transaction's
t_pflags in xfs_trans_context_swap().

So these helpers are refactored as,
- xfs_trans_context_set()
  Used in xfs_trans_alloc()
- xfs_trans_context_clear()
  Used in xfs_trans_free()

And a new helper is instroduced to handle the rolling transaction,
- xfs_trans_context_swap()
  Used in rolling transaction

This patch is based on Darrick's work to fix the issue in xfs/141 in the
earlier version. [1]

1. https://lore.kernel.org/linux-xfs/20201104001649.GN7123@magnolia

Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/xfs/xfs_trans.c | 25 +++++++++++--------------
 fs/xfs/xfs_trans.h | 13 +++++++++++++
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 11d390f0d3f2..aa213c3e2408 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -67,6 +67,10 @@ xfs_trans_free(
 	xfs_extent_busy_sort(&tp->t_busy);
 	xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
 
+
+	/* Detach the transaction from this thread. */
+	xfs_trans_context_clear(tp);
+
 	trace_xfs_trans_free(tp, _RET_IP_);
 	if (!(tp->t_flags & XFS_TRANS_NO_WRITECOUNT))
 		sb_end_intwrite(tp->t_mountp->m_super);
@@ -119,7 +123,9 @@ xfs_trans_dup(
 
 	ntp->t_rtx_res = tp->t_rtx_res - tp->t_rtx_res_used;
 	tp->t_rtx_res = tp->t_rtx_res_used;
-	ntp->t_pflags = tp->t_pflags;
+
+	/* Associate the new transaction with this thread. */
+	xfs_trans_context_swap(tp, ntp);
 
 	/* move deferred ops over to the new tp */
 	xfs_defer_move(ntp, tp);
@@ -153,9 +159,6 @@ xfs_trans_reserve(
 	int			error = 0;
 	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
 
-	/* Mark this thread as being in a transaction */
-	xfs_trans_context_set(tp);
-
 	/*
 	 * Attempt to reserve the needed disk blocks by decrementing
 	 * the number needed from the number available.  This will
@@ -163,10 +166,9 @@ xfs_trans_reserve(
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
 
@@ -241,8 +243,6 @@ xfs_trans_reserve(
 		tp->t_blk_res = 0;
 	}
 
-	xfs_trans_context_clear(tp);
-
 	return error;
 }
 
@@ -284,6 +284,8 @@ xfs_trans_alloc(
 	INIT_LIST_HEAD(&tp->t_dfops);
 	tp->t_firstblock = NULLFSBLOCK;
 
+	/* Mark this thread as being in a transaction */
+	xfs_trans_context_set(tp);
 	error = xfs_trans_reserve(tp, resp, blocks, rtextents);
 	if (error) {
 		xfs_trans_cancel(tp);
@@ -878,7 +880,6 @@ __xfs_trans_commit(
 
 	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
 
-	xfs_trans_context_clear(tp);
 	xfs_trans_free(tp);
 
 	/*
@@ -911,7 +912,6 @@ __xfs_trans_commit(
 		tp->t_ticket = NULL;
 	}
 
-	xfs_trans_context_clear(tp);
 	xfs_trans_free_items(tp, !!error);
 	xfs_trans_free(tp);
 
@@ -971,9 +971,6 @@ xfs_trans_cancel(
 		tp->t_ticket = NULL;
 	}
 
-	/* mark this thread as no longer being in a transaction */
-	xfs_trans_context_clear(tp);
-
 	xfs_trans_free_items(tp, dirty);
 	xfs_trans_free(tp);
 }
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index 44b11c64a15e..12380eaaf7ce 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -280,4 +280,17 @@ xfs_trans_context_clear(struct xfs_trans *tp)
 	memalloc_nofs_restore(tp->t_pflags);
 }
 
+static inline void
+xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
+{
+	ntp->t_pflags = tp->t_pflags;
+	/*
+	 * For the rolling transaction, we have to set NOFS in the old
+	 * transaction's t_pflags so that when we clear the context on
+	 * the old transaction we don't actually change the thread's NOFS
+	 * state.
+	 */
+	tp->t_pflags = current->flags | PF_MEMALLOC_NOFS;
+}
+
 #endif	/* __XFS_TRANS_H__ */
-- 
2.18.4

