Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04182D20AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 03:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgLHCRG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 21:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgLHCRF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:17:05 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A315C061793;
        Mon,  7 Dec 2020 18:16:25 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id q10so8743849vsr.13;
        Mon, 07 Dec 2020 18:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MbRb9UGYEBMJgQFNsuSpH4CcNAaUWcOZHEAGHzS236w=;
        b=hZb2tm/kTIdovRc7XAQAQOXA3Lsolu9P/iz5+eipoETzaasWoJDdoFAGCsBVuWxFdG
         z9CpG1HpkTsDgY4NGgzWDPpqpSbuemLgbczGFFz1sRWX5frjklqEmHWAB9Xj2V/bLH7p
         I4Fw7IiqOG1KNoXtTzKY16b4j5Hl42jTvVGbIpjM+n/p6x3C6h+cdzyKJDhMfTZphjhE
         mWN7V6DgQZrBBrD3yrguz58tDemN0tj0CNhQ7LFZKWguEDFjvc7DbqNRSWd0dfx6jS7a
         q21zXmOPMRLPbGQuexSZJwmmoGONPwKEacF2pxO0IQzdx8Ftm7CWxENp12enEPt1nzgR
         vL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MbRb9UGYEBMJgQFNsuSpH4CcNAaUWcOZHEAGHzS236w=;
        b=TVu02MWtp0KNx1envi6UuMMTPNFY79JagaOvEUbvmyTQlWtYTbPtU7FwHpqDno6ztu
         APgkCsyHj0J8d954go2y7VkFoth7YhY3F9kT3WG8Bx+TO4UOmE+VW74FYnUpdf0qbO9P
         j4LWRC76OkZcnGnR0Mu/TP4VSYEPUDiEEg0caSvZ6+NAXslCc7Q1OJI64Ow6P8+8+fLu
         wYtO6VsJP7aw0LBNUrwRtYcaqFbHEGHXt9Avc8cgioAxaK0UKu4Ew340D4aHNWeiLw4l
         4I6V7DHPx75IuJLzNOkvTML/4YF+O0y2Lfq75w0oq9sNucb8+jxGZ01/uuIENsH9FHWg
         ZSzA==
X-Gm-Message-State: AOAM531W74iW2OV0/7szoQGK1JYgRUUaZGQ7K7GnRECtkhN4cDDceWEC
        AwUw4wc0wvt3eoxUqX2gJp8=
X-Google-Smtp-Source: ABdhPJzoFQQrWwYmxH07BCF6h5dYgYueSy8jYmjam/tcCZdFDmrmpk+XFikMvOFRZ9NGquZ2TbEt3w==
X-Received: by 2002:a67:efd9:: with SMTP id s25mr14359523vsp.56.1607393784864;
        Mon, 07 Dec 2020 18:16:24 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id o192sm1936000vko.19.2020.12.07.18.16.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 18:16:24 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v10 2/4] xfs: use memalloc_nofs_{save,restore} in xfs transaction
Date:   Tue,  8 Dec 2020 10:15:41 +0800
Message-Id: <20201208021543.76501-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201208021543.76501-1-laoar.shao@gmail.com>
References: <20201208021543.76501-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

memalloc_nofs_{save,restore} API is introduced in
commit 7dea19f9ee63 ("mm: introduce memalloc_nofs_{save,restore} API"),
which gives a better abstraction of the usage around PF_MEMALLOC_NOFS. We'd
better use this API in XFS instead of using PF_MEMALLOC_NOFS directly as
well.

To prepare for the followup patch, two new helpers are introduced in XFS
to wrap the memalloc_nofs_{save,restore} API, as follows,

static inline void
xfs_trans_context_set(struct xfs_trans *tp)
{
	tp->t_pflags = memalloc_nofs_save();
}

static inline void
xfs_trans_context_clear(struct xfs_trans *tp)
{
	memalloc_nofs_restore(tp->t_pflags);
}

These two new helpers are added into xfs_tans.h as they are used in xfs
transaction only.

Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@kernel.org>
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

