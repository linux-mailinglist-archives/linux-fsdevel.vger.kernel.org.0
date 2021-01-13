Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DB02F489C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 11:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbhAMKYN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 05:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbhAMKYM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:24:12 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1A1C06179F;
        Wed, 13 Jan 2021 02:23:32 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id o11so1425024ote.4;
        Wed, 13 Jan 2021 02:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Hoa9myK143cV0+5FfOAtzs2mXHnYs56TUMaxDFngxI=;
        b=A27KBa9Qa0CiPAirttd1MC3c+k7HXbqbNcZaGLIuO02YysUlSXQe9nftLGDAbk+k1Y
         m5vlobOmcK2hqS2qzoIMlFmrlm78z+S5YpNhleNyEkdCDlJlMZcES7zOwZhpVJukDoJ2
         G+FqJ4ETTUSzfZYR716nzjqMzhCkMlQ2b5rYQ5iLd+G60zEIWQ2zHlTq6sZS+LfN9Ybv
         tekBdi0j5Nf8H44wvix5j6SwwlNGbKwSwkCWxj7UDmWeGm5H6CZCtAkXVp3L4YyVyagJ
         bp1r3zK3LekfVEfyXBfd7B/4W8GGe5gvL/tuUO9t0ZoNqLhWuY9jEgf6aI4mkHb8vFx6
         LfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Hoa9myK143cV0+5FfOAtzs2mXHnYs56TUMaxDFngxI=;
        b=ldS/u21y5uNTFsQGLyB3cXcpgoPZIWQ8s+qWu/vNyikTaUOIzKtxx5MWU3wSLUfNUx
         hc+eXilm8Zs5otpZS+IBvC1ATYI5dhBjRebPfnCPTNOkaSsSNkBz11sIZCNVkHNvhVio
         x3hQ0FIntlhvGCYApLjnt6j7g+fhyq10sqcDiOXdItMC1hiynwoWo3NOUjlrim+umxs1
         GAQm37co/e2/4cTlaPOHX6tVd8N3r/iVmdOw3I/Q031aUKhZ5DmDWcLiq4YrsWcWF+iw
         OVRrKZnMl8NYtEysmjBEOu9It9Q6ZUlIHzMV/W1wqtq+xjFsCTCh8ptQBjpNv1tQ2upV
         LmuQ==
X-Gm-Message-State: AOAM531DnY71IJlj9vYw4AsxwfSUF93uoSIjXNYlf1gqyXDcwiAQJSh5
        5dApXge8dhZ1wPxzXjrpjwI=
X-Google-Smtp-Source: ABdhPJzMbFRs70OCbw4e3J96c+SlsfFE7Ic6psQgivnf/qYiMFYIWrf1tQemCSk4aiSnqSS+tSYWsg==
X-Received: by 2002:a9d:12d7:: with SMTP id g81mr761901otg.103.1610533411738;
        Wed, 13 Jan 2021 02:23:31 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id z8sm335571oon.10.2021.01.13.02.23.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2021 02:23:31 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        oliver.sang@intel.com, Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v15 4/4] xfs: use current->journal_info to avoid transaction reservation recursion
Date:   Wed, 13 Jan 2021 18:22:24 +0800
Message-Id: <20210113102224.13655-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210113102224.13655-1-laoar.shao@gmail.com>
References: <20210113102224.13655-1-laoar.shao@gmail.com>
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
PF_FSTRANS back. To avoid wasting the space of PF_* flags in
task_struct,
we can reuse the current->journal_info to do that, per Willy. As the
check of transaction reservation recursion is used by XFS only, we can
move the check into xfs_vm_writepage(s), per Dave.

[oliver.sang@intel.com: reported a Assertion_failed in the prev version]

Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>
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
index 3645fd0d74b8..e2f3251d6cce 100644
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
-	if (!tp->t_pflags)
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
-	tp->t_pflags = -1;
 }
 
 #endif	/* __XFS_TRANS_H__ */
-- 
2.17.1

