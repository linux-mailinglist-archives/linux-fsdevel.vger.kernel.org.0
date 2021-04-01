Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD67350BA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhDABKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232927AbhDABJi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:09:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F0F961057;
        Thu,  1 Apr 2021 01:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239378;
        bh=d9PyP+DMme6x2XRuEvTzaMXD0rDeInLCm2Rmsz+0xWY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qaYSzoke5aP+OrA9knn2atGhAXOVLR+mlKzBKQE5S+vHUUazCx3nFiyr3EF1LXZUh
         FpsaUq6AGI5zZglKmiBq2G8Y+6uRtZju81IsZ9kvQtn8YXaxDGZ+eHGpvVE7ZFHjxE
         kF9VMhJKaHNOjF/c9m4rrCFTHBQ58msqtXHi7jEpffSOyiLp5Es9FBmuGjjxEjNIHv
         ifSc42AFJn2+TECBL08ljh6aROcrq1eLbGjpzfn3rnvKKziYDhtftppkZ9uKRgiIqY
         U+tLYcLOyCwbuDkMG8xuD2YzRwDdUk5d3LCRboKgLrMJOlxr8GmQ8eOlJXVbyq2SXJ
         ZbApZhkxckyHA==
Subject: [PATCH 09/18] xfs: add error injection to test swapext recovery
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:09:37 -0700
Message-ID: <161723937722.3149451.14317094160816696523.stgit@magnolia>
In-Reply-To: <161723932606.3149451.12366114306150243052.stgit@magnolia>
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add an errortag so that we can test recovery of swapext log items.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_errortag.h |    4 +++-
 fs/xfs/libxfs/xfs_swapext.c  |    5 +++++
 fs/xfs/xfs_error.c           |    3 +++
 3 files changed, 11 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
index 6ca9084b6934..52a69bf29570 100644
--- a/fs/xfs/libxfs/xfs_errortag.h
+++ b/fs/xfs/libxfs/xfs_errortag.h
@@ -58,7 +58,8 @@
 #define XFS_ERRTAG_BUF_IOERROR				35
 #define XFS_ERRTAG_REDUCE_MAX_IEXTENTS			36
 #define XFS_ERRTAG_BMAP_ALLOC_MINLEN_EXTENT		37
-#define XFS_ERRTAG_MAX					38
+#define XFS_ERRTAG_SWAPEXT_FINISH_ONE			38
+#define XFS_ERRTAG_MAX					39
 
 /*
  * Random factors for above tags, 1 means always, 2 means 1/2 time, etc.
@@ -101,5 +102,6 @@
 #define XFS_RANDOM_BUF_IOERROR				XFS_RANDOM_DEFAULT
 #define XFS_RANDOM_REDUCE_MAX_IEXTENTS			1
 #define XFS_RANDOM_BMAP_ALLOC_MINLEN_EXTENT		1
+#define XFS_RANDOM_SWAPEXT_FINISH_ONE			1
 
 #endif /* __XFS_ERRORTAG_H_ */
diff --git a/fs/xfs/libxfs/xfs_swapext.c b/fs/xfs/libxfs/xfs_swapext.c
index 9fb67cbd018f..082680635146 100644
--- a/fs/xfs/libxfs/xfs_swapext.c
+++ b/fs/xfs/libxfs/xfs_swapext.c
@@ -20,6 +20,8 @@
 #include "xfs_trace.h"
 #include "xfs_bmap_btree.h"
 #include "xfs_trans_space.h"
+#include "xfs_errortag.h"
+#include "xfs_error.h"
 
 /* Information to help us reset reflink flag / CoW fork state after a swap. */
 
@@ -407,6 +409,9 @@ xfs_swapext_finish_one(
 		xfs_trans_log_inode(tp, sxi->sxi_ip2, XFS_ILOG_CORE);
 	}
 
+	if (XFS_TEST_ERROR(false, tp->t_mountp, XFS_ERRTAG_SWAPEXT_FINISH_ONE))
+		return -EIO;
+
 	if (xfs_swapext_has_more_work(sxi))
 		trace_xfs_swapext_defer(tp->t_mountp, sxi);
 
diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index 185b4915b7bf..9b6c38d0671b 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -56,6 +56,7 @@ static unsigned int xfs_errortag_random_default[] = {
 	XFS_RANDOM_BUF_IOERROR,
 	XFS_RANDOM_REDUCE_MAX_IEXTENTS,
 	XFS_RANDOM_BMAP_ALLOC_MINLEN_EXTENT,
+	XFS_RANDOM_SWAPEXT_FINISH_ONE,
 };
 
 struct xfs_errortag_attr {
@@ -168,6 +169,7 @@ XFS_ERRORTAG_ATTR_RW(iunlink_fallback,	XFS_ERRTAG_IUNLINK_FALLBACK);
 XFS_ERRORTAG_ATTR_RW(buf_ioerror,	XFS_ERRTAG_BUF_IOERROR);
 XFS_ERRORTAG_ATTR_RW(reduce_max_iextents,	XFS_ERRTAG_REDUCE_MAX_IEXTENTS);
 XFS_ERRORTAG_ATTR_RW(bmap_alloc_minlen_extent,	XFS_ERRTAG_BMAP_ALLOC_MINLEN_EXTENT);
+XFS_ERRORTAG_ATTR_RW(swapext_finish_one, XFS_RANDOM_SWAPEXT_FINISH_ONE);
 
 static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(noerror),
@@ -208,6 +210,7 @@ static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(buf_ioerror),
 	XFS_ERRORTAG_ATTR_LIST(reduce_max_iextents),
 	XFS_ERRORTAG_ATTR_LIST(bmap_alloc_minlen_extent),
+	XFS_ERRORTAG_ATTR_LIST(swapext_finish_one),
 	NULL,
 };
 

