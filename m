Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1D5235313
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Aug 2020 17:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgHAPrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 11:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgHAPrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 11:47:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF998C06174A;
        Sat,  1 Aug 2020 08:47:11 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so8725591pjd.3;
        Sat, 01 Aug 2020 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7sn5nj5K2mT9YPFbrjVs3ZZ1R61/BfXwFYxBFfJ6XlE=;
        b=WXZy8PnFAFEjF9HExI/OyY8vbo2HOFHAGUtecaNRc66uU3xuZCgsq11Exl4W7OxFx5
         78FMft2ckNv1uf3smNQ4MOXhhjUV2e26n3QaC0pBrPk/s4TfXeeaGcZZWgSYODQuicHN
         js3VQYmCt57Tz3LNvcCjiT27K/uKz+ZLP0VT/vFpMKn6/hK3Re3vodYZ+zzQ5PEkyR7/
         TH1+l2Q4DAMkjjOZhPHiTXzsCpJfpu2ptcaiJg23xJppl4LMJ8HdrVatpydBLKdsOFCB
         ZFuHYI48eILqIG1YFQA4rB4Lwj5Dq7Q8AF51IaOUSaZNUqUATIp0Z31feclYEPDkfL4m
         AqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7sn5nj5K2mT9YPFbrjVs3ZZ1R61/BfXwFYxBFfJ6XlE=;
        b=jww/JKIDl+lpXbHOFoNwGpvTkfm6EuVy+jtH2Okuh8ccBjF1X3xYsFgHUvzzMhoETD
         NW5gx2GyrqRRb904RjjgoAQKDb5MoXf7T7i2p6lXjfO6GeB86X3Hbr75gKbiiQSzvYJf
         A+0+6HfkGeYihJcAnGcovmyw7EuYbE1kqeamfPg1y99V27jrjubpxRX9D6FStOr+J+dk
         wiVRPnJyWkDstw7D7qRvQTLIYh4qz7Uu4tP2Hg7vNup6SjZXQ1bmpDgLJYvM/rtt0fV7
         fPhBtOEJrl/ni4ih/bPW/XQAl8s0iq5iLGRMbjM3kCq1QlwhdDO7M/ucc1T9lYxxsunH
         mTHQ==
X-Gm-Message-State: AOAM5322a6wPE9GszbTUKEg6I7NkATHtyurjXjs0V7relo4wmg5+cgkJ
        QHUu2w4jaj4Jzn5EyNHV1pM=
X-Google-Smtp-Source: ABdhPJyEY70AqCN170uMP2H1hBdWEjUl5eZqpIuyCIkzjjCerv+GZNmTs1ydRMBZzWuLBgP2trglpQ==
X-Received: by 2002:a17:90a:bb81:: with SMTP id v1mr8792826pjr.168.1596296831292;
        Sat, 01 Aug 2020 08:47:11 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id j26sm13717331pfe.200.2020.08.01.08.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 08:47:10 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        mhocko@kernel.org, willy@infradead.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <shaoyafang@didiglobal.com>
Subject: [PATCH v4 2/2] xfs: avoid transaction reservation recursion
Date:   Sat,  1 Aug 2020 11:46:32 -0400
Message-Id: <20200801154632.866356-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200801154632.866356-1-laoar.shao@gmail.com>
References: <20200801154632.866356-1-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yafang Shao <shaoyafang@didiglobal.com>

PF_FSTRANS which is used to avoid transaction reservation recursion, is
dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
memalloc_nofs_{save,restore} API") and replaced by PF_MEMALLOC_NOFS which
means to avoid filesystem reclaim recursion. That change is subtle.
Let's take the exmple of the check of WARN_ON_ONCE(current->flags &
PF_MEMALLOC_NOFS)) to explain why this abstraction from PF_FSTRANS to
PF_MEMALLOC_NOFS is not proper.
Below comment is quoted from Dave,
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

As a result, we should reintroduce PF_FSTRANS. As current->journal_info
isn't used in XFS, we can reuse it to indicate whehter the task is in
fstrans or not.

[1]. Below check is to avoid memory reclaim recursion.
if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
        PF_MEMALLOC))
        goto redirty;

Signed-off-by: Yafang Shao <shaoyafang@didiglobal.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 fs/iomap/buffered-io.c    |  4 ++--
 fs/xfs/libxfs/xfs_btree.c |  2 ++
 fs/xfs/xfs_aops.c         |  3 +++
 fs/xfs/xfs_linux.h        | 19 +++++++++++++++++++
 fs/xfs/xfs_trans.c        |  8 +++++++-
 5 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..b3f66b6b5116 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1500,9 +1500,9 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 
 	/*
 	 * Given that we do not allow direct reclaim to call us, we should
-	 * never be called in a recursive filesystem reclaim context.
+	 * never be called while in a filesystem transaction.
 	 */
-	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
+	if (WARN_ON_ONCE(current->journal_info))
 		goto redirty;
 
 	/*
diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 2d25bab68764..0795511f9e6a 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -2825,6 +2825,7 @@ xfs_btree_split_worker(
 	if (args->kswapd)
 		new_pflags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
 
+	xfs_trans_context_start();
 	current_set_flags_nested(&pflags, new_pflags);
 
 	args->result = __xfs_btree_split(args->cur, args->level, args->ptrp,
@@ -2832,6 +2833,7 @@ xfs_btree_split_worker(
 	complete(args->done);
 
 	current_restore_flags_nested(&pflags, new_pflags);
+	xfs_trans_context_end();
 }
 
 /*
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index b35611882ff9..39ef95acdd8e 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -63,6 +63,8 @@ xfs_setfilesize_trans_alloc(
 	 * clear the flag here.
 	 */
 	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_end();
+
 	return 0;
 }
 
@@ -125,6 +127,7 @@ xfs_setfilesize_ioend(
 	 * thus we need to mark ourselves as being in a transaction manually.
 	 * Similarly for freeze protection.
 	 */
+	xfs_trans_context_start();
 	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
 	__sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
 
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 9f70d2f68e05..1192b660a968 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -111,6 +111,25 @@ typedef __u32			xfs_nlink_t;
 #define current_restore_flags_nested(sp, f)	\
 		(current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))
 
+static inline void xfs_trans_context_start(void)
+{
+	long flags = (long)current->journal_info;
+
+	/*
+	 * Reuse journal_info to indicate whehter the current is in fstrans
+	 * or not.
+	 */
+	current->journal_info = (void *)(flags + 1);
+}
+
+static inline void xfs_trans_context_end(void)
+{
+	long flags = (long)current->journal_info;
+
+	WARN_ON_ONCE(flags <= 0);
+	current->journal_info = ((void *)(flags - 1));
+}
+
 #define NBBY		8		/* number of bits per byte */
 
 /*
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 9ff41970d0c7..38d94679ad41 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -153,6 +153,7 @@ xfs_trans_reserve(
 	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
 
 	/* Mark this thread as being in a transaction */
+	xfs_trans_context_start();
 	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
 
 	/*
@@ -859,6 +860,7 @@ __xfs_trans_commit(
 	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
 
 	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_end();
 	xfs_trans_free(tp);
 
 	/*
@@ -891,6 +893,7 @@ __xfs_trans_commit(
 		tp->t_ticket = NULL;
 	}
 	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_end();
 	xfs_trans_free_items(tp, !!error);
 	xfs_trans_free(tp);
 
@@ -952,6 +955,7 @@ xfs_trans_cancel(
 
 	/* mark this thread as no longer being in a transaction */
 	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+	xfs_trans_context_end();
 
 	xfs_trans_free_items(tp, dirty);
 	xfs_trans_free(tp);
@@ -1005,8 +1009,10 @@ xfs_trans_roll(
 	tres.tr_logflags = XFS_TRANS_PERM_LOG_RES;
 	tp = *tpp;
 	error = xfs_trans_reserve(tp, &tres, 0, 0);
-	if (error)
+	if (error) {
 		current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
+		xfs_trans_context_end();
+	}
 
 	return error;
 }
-- 
2.18.1

