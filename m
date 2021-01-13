Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0282F489A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 11:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbhAMKYG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 05:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbhAMKYG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:24:06 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC99C061795;
        Wed, 13 Jan 2021 02:23:25 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id j20so1417027otq.5;
        Wed, 13 Jan 2021 02:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxclDVwqVJvNjL6ogvvc7lutzmJKTCIl3aL2mVuveRU=;
        b=ayzzHhYzcClTcR5UidZ9RaV7JooeTbg7NYZeAKxe+8VXLL4MzCKSEQ+HRiDI3hcGRV
         lpycfcOJxoosIgx3X6xdop/IL+4QW5enr6e+YLrZMvNP/zfEA+JQ8ZoTOOZ9AUAdCYKL
         N2YwIn+bjH9pdPanotuQS37H/zfAVEh5kjkWNLHyLlIAgOk+O6L1ngtZGclIZyM/urzg
         gszDoW00rAbwKLEld222Gf8/1aG465V1HN89e/8R+i0WLj4Z7uusaomm/YBxTNnEaAVA
         9Da+RFc607qjDU/QocHb0I+2wQHexo0B1KZsab0gPXqreVTPPXHqSxmzRQzni59RCt02
         lgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxclDVwqVJvNjL6ogvvc7lutzmJKTCIl3aL2mVuveRU=;
        b=GU13158BfKW+mygrNbFs6Dto4HjdH29hVxX+ml96iHaCw5rEAzOP3kKGcH1gNY4ix1
         +h7NUawlce5P0wJa62EiliMU6YbTeNtFgkVHBD4Se0Nt00ZIFgaYqPccdOozu9t40VuZ
         fM5078sRndHqb9o9vBN9BQ1wIxHSqvMxT8oRNvZATtn+tXmHYJI9zNWPdNPGyE6FA88b
         Wx0zS16Pz6bJiMIdyqvWzi0GmnZvRuMZ4mfqhsC1nemt4/P/Mbc6zLoNj4kwPnK8xeaZ
         +BzTAHVHroM04nkTV/tDOvIGiDNePJ4A4v9HSJc94JPd/bTs4Ysw0DUJxRle2OyL+hMU
         KNVA==
X-Gm-Message-State: AOAM533wAaNhSyfEJG4Tp9GRC+eyXDaBZPHwpSeQjUMs6tx/H066pwii
        rkedtOyjCZDQgVRTBpDrD54=
X-Google-Smtp-Source: ABdhPJy3SuuCBXWeZ64qnoWABbZ8wtAGotjYfWPZu33kh0kuO2TTGVs0UOsxp8cqTnyLedLhUOmebA==
X-Received: by 2002:a9d:694a:: with SMTP id p10mr722519oto.149.1610533405317;
        Wed, 13 Jan 2021 02:23:25 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id z8sm335571oon.10.2021.01.13.02.23.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2021 02:23:24 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        oliver.sang@intel.com, Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v15 3/4] xfs: refactor the usage around xfs_trans_context_{set,clear}
Date:   Wed, 13 Jan 2021 18:22:23 +0800
Message-Id: <20210113102224.13655-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210113102224.13655-1-laoar.shao@gmail.com>
References: <20210113102224.13655-1-laoar.shao@gmail.com>
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

This patch is based on Darrick's work[1] to fix the issue in xfs/141 in the
earlier version and Dave's suggestion[2].

[1]. https://lore.kernel.org/linux-xfs/20201104001649.GN7123@magnolia
[2]. https://lore.kernel.org/linux-xfs/20201218000705.GR632069@dread.disaster.area

Cc: Dave Chinner <david@fromorbit.com>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/xfs/xfs_trans.c | 25 +++++++++++--------------
 fs/xfs/xfs_trans.h | 10 +++++++++-
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 43107af569fe..b76e850c9ae7 100644
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
index 44b11c64a15e..3645fd0d74b8 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -277,7 +277,15 @@ xfs_trans_context_set(struct xfs_trans *tp)
 static inline void
 xfs_trans_context_clear(struct xfs_trans *tp)
 {
-	memalloc_nofs_restore(tp->t_pflags);
+	if (!tp->t_pflags)
+		memalloc_nofs_restore(tp->t_pflags);
+}
+
+static inline void
+xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
+{
+	ntp->t_pflags = tp->t_pflags;
+	tp->t_pflags = -1;
 }
 
 #endif	/* __XFS_TRANS_H__ */
-- 
2.17.1

