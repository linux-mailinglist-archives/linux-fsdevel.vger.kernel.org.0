Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000262E03D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 02:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgLVBXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 20:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgLVBXE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 20:23:04 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C41C061285;
        Mon, 21 Dec 2020 17:22:24 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id f16so10540670otl.11;
        Mon, 21 Dec 2020 17:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tqH6gFEH/QkT/MrE5FvbhgIXvCJPwTVubT5FNjmPiw=;
        b=rDQ1n9sCgIQu8CDOMd1xFAyBAlEKruoRKOIr7lroKlEBdXGxXxqRL+/HRkqhY470yZ
         ThEj/dMgQVz5SeohLyCT4ei38OewCR4fa53uXDDKxbxdMzwZ8bO/pLCs211NHHCtkj4B
         tqeO9ujN3jBbA+0oJEpCROqGpvOjWM+Y9GhpLZqq2WLTb7RMoJVRhOMzjhvn/n+0jPQq
         2TQp7CLuIjOVAAP45FaczyXD2lE10kec7bwlH8BTDMddI+2dpt85H2lIb5tJZ/bfzWzN
         0Xqt9yDvXxoe2PboWou3NE8+sZcZVmSdVMK3geoPjV3Nx6EFKsN0Zve8KW5ut0UI2VG3
         xqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tqH6gFEH/QkT/MrE5FvbhgIXvCJPwTVubT5FNjmPiw=;
        b=THgwt5xw7PteuX+6i1hNZ1P5C77siDNBNaQl5YSEY25tJyy6dqAcd/XALIsNVSG7Vr
         6DQzmPXJeA6x9gWzuo+4A6cfc/Ttbcix9tjZtFVZ4lxpblqS9zdX2hw/aWPbO5jBpr50
         7tOnLCR7zfeo6hi/IRUxWmRTyexOTdFr03iTBsNMAjgWRT2iFNG7493h8UmlY6Qpyn5X
         5dDoT6x3yHNbQ9cjNXEZ5K2vzQkYpfV0ybAtbfppvrunpme+Orz3ziiA3zmkpM7crqfb
         Z/CKYzHf9LAYwwKYvvsP1161zxAhz9BjxtegTP78cAPYbR/VQftpj5Dw4byuiNC/pU56
         mKvQ==
X-Gm-Message-State: AOAM533uHbDsvxReUipLu7FMX58rb9FMNTfW72lxiASHSt729fq9hbKI
        fmvS7oLzPqjuY+EgnySsi90=
X-Google-Smtp-Source: ABdhPJwNKBYsLuiG7MmO1rP1TZQVCWEScL7Wn7rEabYIkS5ugbeuCCac5ztOmPJsmUppPC1+6neqmA==
X-Received: by 2002:a9d:66d4:: with SMTP id t20mr14111088otm.264.1608600143560;
        Mon, 21 Dec 2020 17:22:23 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id x20sm4070098oov.33.2020.12.21.17.22.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 17:22:23 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 4/4] xfs: use current->journal_info to avoid transaction reservation recursion
Date:   Tue, 22 Dec 2020 09:21:31 +0800
Message-Id: <20201222012131.47020-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201222012131.47020-1-laoar.shao@gmail.com>
References: <20201222012131.47020-1-laoar.shao@gmail.com>
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
 fs/xfs/xfs_aops.c      | 10 ++++++++++
 fs/xfs/xfs_trans.h     | 22 +++++++++++++++++++---
 3 files changed, 29 insertions(+), 10 deletions(-)

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
index 2371187b7615..eed4881d4461 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -568,6 +568,12 @@ xfs_vm_writepage(
 {
 	struct xfs_writepage_ctx wpc = { };
 
+	if (WARN_ON_ONCE(xfs_trans_context_active())) {
+		redirty_page_for_writepage(wbc, page);
+		unlock_page(page);
+		return 0;
+	}
+
 	return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);
 }
 
@@ -579,6 +585,10 @@ xfs_vm_writepages(
 	struct xfs_writepage_ctx wpc = { };
 
 	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
+
+	if (WARN_ON_ONCE(xfs_trans_context_active()))
+		return 0;
+
 	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
 }
 
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index b428704eeb20..e2f3251d6cce 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -268,24 +268,40 @@ xfs_trans_item_relog(
 	return lip->li_ops->iop_relog(lip, tp);
 }
 
+static inline bool
+xfs_trans_context_active(void)
+{
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
-	if (!tp->t_flags)
-		memalloc_nofs_restore(tp->t_pflags);
+	/*
+	 * If we handed over the context via xfs_trans_context_swap() then
+	 * the context is no longer needed to clear.
+	 */
+	if (current->journal_info != tp)
+		return;
+
+	current->journal_info = NULL;
+	memalloc_nofs_restore(tp->t_pflags);
 }
 
 static inline void
 xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
 {
+	ASSERT(current->journal_info == tp);
+	current->journal_info = ntp;
 	ntp->t_pflags = tp->t_pflags;
-	tp->t_flags = -1;
 }
 
 #endif	/* __XFS_TRANS_H__ */
-- 
2.18.4

