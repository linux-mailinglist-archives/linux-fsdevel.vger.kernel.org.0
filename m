Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750282D42F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 14:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbgLINNh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 08:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbgLINN0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:13:26 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D4FC0617A6;
        Wed,  9 Dec 2020 05:12:37 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d14so415605qkc.13;
        Wed, 09 Dec 2020 05:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vo2hMZxAvlst2gwI48xlPnEAZTs7fn2tgVy4jkvkfak=;
        b=rA0uPedR6iMFDORqVibYIouE2sHlfBsLJl/kDe5KAyEAiHd/5lBoupnyE10Vk+5LPp
         fO01gbxW8xbv1FBkrvWBN1BtDVW1kS2tD8sTUeV0lwDNYEbHVGF0NYDMtZv+0T0Km9ZA
         /u7b/RQh7hCku29/FDMiRYzfjCp1IpWsu8tUf2zFYw21T59oj0Ke78GOTuAOQdpcrugq
         tt5gPAz5wwdiQWbFSGiBgYmXw5GX1SwqR1dY7OX1bOZjE2ZBOc929vIRTMPQfyWI7p/j
         /j0ajn4wLxea+xgZyyNTsRqR6tsXIKqS4R0QHYhpacoGraXbMeEqS43YUyPSw6Tk08aF
         mE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vo2hMZxAvlst2gwI48xlPnEAZTs7fn2tgVy4jkvkfak=;
        b=I3s0wFyIYq6Fki+MEZboppm7svGFHZqTAVbqAGOMUNlONJLsWM05GsrfRWnIBKGjoN
         q+nJnHmF8GHjhLhfhxmEgaJKX+MYD63kODAptL0VePj7N8Q8SJjOQyOoNpdBPH74hX5d
         p6Im2mOpig3N1QfKBG+FbJIC6v7hS5gsFYcIJ6KdN7aKKkki3oMn5ck2LvJf6UfLVVSc
         T2saIOBKegyfHgWE+B5F5/hqgdnxfy7SiqXFljviuorQfM9YmwEUUCtGgu+vvTMI1KOD
         zBVvJqEEcqc2tHawmOm2+jdn0EorSCcPicrTMtvMjUP1/cLgdxlTN6muxLU3mZx+6aj+
         rpRQ==
X-Gm-Message-State: AOAM531ofzAVz+mUtU8ZDEs0a+Yz0aW6oRAJ/OHNyRQ3OefUJ5qaCz4Z
        KMow81+btRGW9ymHKIpKd2c=
X-Google-Smtp-Source: ABdhPJzE8FiJCH3XNPdUh271c8izjZ1PbF4C+rKvyzEFeqiYiRR5QcVOZ62jupL5NknQ1sFGJAj5tw==
X-Received: by 2002:a37:8384:: with SMTP id f126mr2848840qkd.500.1607519557106;
        Wed, 09 Dec 2020 05:12:37 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id u72sm938114qka.15.2020.12.09.05.12.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 05:12:36 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v12 4/4] xfs: use current->journal_info to avoid transaction reservation recursion
Date:   Wed,  9 Dec 2020 21:11:46 +0800
Message-Id: <20201209131146.67289-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201209131146.67289-1-laoar.shao@gmail.com>
References: <20201209131146.67289-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PF_FSTRANS which is used to avoid transaction reservation recursion, is
dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
memalloc_nofs_{save,restore} API") and replaced by PF_MEMALLOC_NOFS which
means to avoid filesystem reclaim recursion.

As these two flags have different meanings, we'd better reintroduce
PF_FSTRANS back. To avoid wasting the space of PF_* flags in task_struct,
we can reuse the current->journal_info to do that, per Willy. As the
check of transaction reservation recursion is used by XFS only, we can
move the check into xfs_vm_writepage(s), per Dave.

To better abstract that behavoir, two new helpers are introduced, as
follows,
- xfs_trans_context_active
  To check whehter current is in fs transcation or not
- xfs_trans_context_swap
  Transfer the transaction context when rolling a permanent transaction

These two new helpers are instroduced in xfs_trans.h.

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
 fs/xfs/xfs_aops.c      | 17 +++++++++++++++++
 fs/xfs/xfs_trans.c     |  4 +++-
 fs/xfs/xfs_trans.h     | 23 +++++++++++++++++++++++
 4 files changed, 43 insertions(+), 8 deletions(-)

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
index 2371187b7615..0da0242d42c3 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -568,6 +568,16 @@ xfs_vm_writepage(
 {
 	struct xfs_writepage_ctx wpc = { };
 
+	/*
+	 * Given that we do not allow direct reclaim to call us, we should
+	 * never be called while in a filesystem transaction.
+	 */
+	if (WARN_ON_ONCE(xfs_trans_context_active())) {
+		redirty_page_for_writepage(wbc, page);
+		unlock_page(page);
+		return 0;
+	}
+
 	return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);
 }
 
@@ -579,6 +589,13 @@ xfs_vm_writepages(
 	struct xfs_writepage_ctx wpc = { };
 
 	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
+	/*
+	 * Given that we do not allow direct reclaim to call us, we should
+	 * never be called while in a filesystem transaction.
+	 */
+	if (WARN_ON_ONCE(xfs_trans_context_active()))
+		return 0;
+
 	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
 }
 
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 4f4645329bb2..7793391fe536 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -130,7 +130,9 @@ xfs_trans_dup(
 
 	ntp->t_rtx_res = tp->t_rtx_res - tp->t_rtx_res_used;
 	tp->t_rtx_res = tp->t_rtx_res_used;
-	ntp->t_pflags = tp->t_pflags;
+
+	/* Associate the new transaction with this thread. */
+	xfs_trans_context_swap(tp, ntp);
 
 	/* move deferred ops over to the new tp */
 	xfs_defer_move(ntp, tp);
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index 44b11c64a15e..e994b01eeb57 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -268,16 +268,39 @@ xfs_trans_item_relog(
 	return lip->li_ops->iop_relog(lip, tp);
 }
 
+static inline bool
+xfs_trans_context_active(void)
+{
+	/* Use journal_info to indicate current is in a transaction */
+	return current->journal_info != NULL;
+}
+
 static inline void
 xfs_trans_context_set(struct xfs_trans *tp)
 {
+	ASSERT(!current->journal_info);
+	current->journal_info = tp;
 	tp->t_pflags = memalloc_nofs_save();
 }
 
 static inline void
 xfs_trans_context_clear(struct xfs_trans *tp)
 {
+	ASSERT(current->journal_info == tp);
+	current->journal_info = NULL;
 	memalloc_nofs_restore(tp->t_pflags);
 }
 
+/*
+ * Transfer the transaction context when rolling a permanent
+ * transaction.
+ */
+static inline void
+xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
+{
+	ASSERT(current->journal_info == tp);
+	ntp->t_pflags = tp->t_pflags;
+	current->journal_info = ntp;
+}
+
 #endif	/* __XFS_TRANS_H__ */
-- 
2.18.4

