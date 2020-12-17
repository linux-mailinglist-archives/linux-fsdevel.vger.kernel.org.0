Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E742DCA71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 02:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389102AbgLQBNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 20:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgLQBNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 20:13:32 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0441FC06138C;
        Wed, 16 Dec 2020 17:12:33 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id e15so12549429vsa.0;
        Wed, 16 Dec 2020 17:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9alW6vAYyuzuIAm2W1sBzzo1XFQKdglwiDiVNpF1K2U=;
        b=Wi5ul+TpVrtbHopu2Iwb3DlGk1ZxVzDtLAsRdQMTu0GERUdvG2WVNpqpfK16fgUS9h
         yhq0822cOkKhzQ7ZRWz8Npvm048BUEnToPYJy+xnZwyVe3RDHJLz0OF/hw55IGWeldgE
         5eN4vwFCW486dOUy2PHx60b2avDZZplCXBLtp/MZ7UGJPsDYcXQeO1lq3yyxiP14Ndbr
         c3KSA6WFYM51Cm3HJNKmNc96A2rjtwuTYDUHTxjQG6h9I+beliWreu54pMsFr24ff8cW
         Bl8HuQt0co6Qc5ubOg4BSBFIANtBrd9eSaTpbhD0uV6moRHkdHgfcLJJB4b+Q/X3+GZ2
         HG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9alW6vAYyuzuIAm2W1sBzzo1XFQKdglwiDiVNpF1K2U=;
        b=uFFdvix69oFsXkVgW99anWq3fTBojBLKzgr09ZQtvW7byQjFIM+Fn8u1ZRGxBNu3EB
         rkezMZDqUpnZ6xLcLkkeNFjmwfehkWS2Rr0Sgh7mZD0Ki+z22f+WrzdcLzXUVr74zfJy
         1+acVqK5qFaPKzUYbhqsDOtFDRxmm9Nr46/IAB0Aj9pjltoiSmLIW2pOdu3JlfAqYikI
         4HnxsO7zvFPo2JV+bSeSBnODuWd3urT3DHtVDGOfkTqzFygtfhA4FGt+UBWOK++eY4i3
         qLG5kKZW/qJz55Fk27bJLNYHL9PqNzbbB47j9DcJwOz8gvikImevIaqmZJ5uXcGEkAAo
         lH6A==
X-Gm-Message-State: AOAM530Pp50QnzwiQPC65yWMJh3w5EajK6BWFwvcL1vdm8D9BbgpocrN
        K9RQaO3xemd9ncDG50WWr7E3LBue5e/NBivF
X-Google-Smtp-Source: ABdhPJymD38OIInUxz/A6UMIS832ePfAYJx4qTFdpzI+xn54beO/QqmFh11xxFmKvkJ1ebq2NwfIEA==
X-Received: by 2002:a67:1142:: with SMTP id 63mr15960710vsr.24.1608167552295;
        Wed, 16 Dec 2020 17:12:32 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id i63sm2900760uad.4.2020.12.16.17.12.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 17:12:31 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 4/4] xfs: use current->journal_info to avoid transaction reservation recursion
Date:   Thu, 17 Dec 2020 09:11:57 +0800
Message-Id: <20201217011157.92549-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201217011157.92549-1-laoar.shao@gmail.com>
References: <20201217011157.92549-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PF_FSTRANS which is used to avoid transaction reservation recursion, is
dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
PF_MEMALLOC_NOFS") and replaced by PF_MEMALLOC_NOFS which means to avoid
filesystem reclaim recursion.

As these two flags have different meanings, we'd better reintroduce
PF_FSTRANS back. To avoid wasting the space of PF_* flags in task_struct,
we can reuse the current->journal_info to do that, per Willy. As the
check of transaction reservation recursion is used by XFS only, we can
move the check into xfs_vm_writepage(s), per Dave.

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
 fs/xfs/xfs_trans.h     | 26 +++++++++++++++++++-------
 3 files changed, 36 insertions(+), 14 deletions(-)

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
 
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index 12380eaaf7ce..0c8140147b9b 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -268,29 +268,41 @@ xfs_trans_item_relog(
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
+	/*
+	 * If xfs_trans_context_swap() handed the NOFS context to a
+	 * new transaction we do not clear the context here.
+	 */
+	if (current->journal_info != tp)
+		return;
+
+	current->journal_info = NULL;
 	memalloc_nofs_restore(tp->t_pflags);
 }
 
 static inline void
 xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
 {
+	ASSERT(current->journal_info == tp);
+	current->journal_info = ntp;
 	ntp->t_pflags = tp->t_pflags;
-	/*
-	 * For the rolling transaction, we have to set NOFS in the old
-	 * transaction's t_pflags so that when we clear the context on
-	 * the old transaction we don't actually change the thread's NOFS
-	 * state.
-	 */
-	tp->t_pflags = current->flags | PF_MEMALLOC_NOFS;
 }
 
 #endif	/* __XFS_TRANS_H__ */
-- 
2.18.4

