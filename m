Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34670E4198
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 04:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390194AbfJYCge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 22:36:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfJYCge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LNcjTYweWLROtw0+6qrNHyWm/b7rJm5aqhasGw1fHRo=; b=ltU+LTDxyHZPF5Jxfikl7ZqUf
        qt4kuz8YHvTATIsdetvN3qTKKizR/L/tm/EMXIT9TsOkhzVpEwLlC14qPt+ZmL7LLrtLySLe9eLn6
        08jWeRDuJSNQsQ946gxkQP277ssOSt9Axv3XUEvUz8KXlYn3bdmrrkcqglYI5bNgwAf1nQZRX4S+4
        jZpqWfwOG2AgFn/0kB5akizHJXo9PNkjmyZwYOecOkZJjYJcR9rd/h5IN5OKUgK3e9rql8bpmVDCn
        0snLY98YepM7EZnimKmZJU0eaHCXMODtIYMYTC4ZrHngYPLBAjjOGB88rc7bVk9B8VwkGsS7hDtue
        BuP0xwz6A==;
Received: from p91006-ipngnfx01marunouchi.tokyo.ocn.ne.jp ([153.156.43.6] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNpSr-0003ey-4I; Fri, 25 Oct 2019 02:36:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] xfs: consolidate preallocation in xfs_file_fallocate
Date:   Fri, 25 Oct 2019 11:36:09 +0900
Message-Id: <20191025023609.22295-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025023609.22295-1-hch@lst.de>
References: <20191025023609.22295-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove xfs_zero_file_space and reorganize xfs_file_fallocate so that a
single call to xfs_alloc_file_space covers all modes that preallocate
blocks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_bmap_util.c | 37 -------------------------------------
 fs/xfs/xfs_bmap_util.h |  2 --
 fs/xfs/xfs_file.c      | 32 ++++++++++++++++++++++++--------
 3 files changed, 24 insertions(+), 47 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 9b0572a7b03a..11658da40640 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1133,43 +1133,6 @@ xfs_free_file_space(
 	return error;
 }
 
-/*
- * Preallocate and zero a range of a file. This mechanism has the allocation
- * semantics of fallocate and in addition converts data in the range to zeroes.
- */
-int
-xfs_zero_file_space(
-	struct xfs_inode	*ip,
-	xfs_off_t		offset,
-	xfs_off_t		len)
-{
-	struct xfs_mount	*mp = ip->i_mount;
-	uint			blksize;
-	int			error;
-
-	trace_xfs_zero_file_space(ip);
-
-	blksize = 1 << mp->m_sb.sb_blocklog;
-
-	/*
-	 * Punch a hole and prealloc the range. We use hole punch rather than
-	 * unwritten extent conversion for two reasons:
-	 *
-	 * 1.) Hole punch handles partial block zeroing for us.
-	 *
-	 * 2.) If prealloc returns ENOSPC, the file range is still zero-valued
-	 * by virtue of the hole punch.
-	 */
-	error = xfs_free_file_space(ip, offset, len);
-	if (error || xfs_is_always_cow_inode(ip))
-		return error;
-
-	return xfs_alloc_file_space(ip, round_down(offset, blksize),
-				     round_up(offset + len, blksize) -
-				     round_down(offset, blksize),
-				     XFS_BMAPI_PREALLOC);
-}
-
 static int
 xfs_prepare_shift(
 	struct xfs_inode	*ip,
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index 7a78229cf1a7..3e0fa0d363d1 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -59,8 +59,6 @@ int	xfs_alloc_file_space(struct xfs_inode *ip, xfs_off_t offset,
 			     xfs_off_t len, int alloc_type);
 int	xfs_free_file_space(struct xfs_inode *ip, xfs_off_t offset,
 			    xfs_off_t len);
-int	xfs_zero_file_space(struct xfs_inode *ip, xfs_off_t offset,
-			    xfs_off_t len);
 int	xfs_collapse_file_space(struct xfs_inode *, xfs_off_t offset,
 				xfs_off_t len);
 int	xfs_insert_file_space(struct xfs_inode *, xfs_off_t offset,
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 156238d5af19..525b29b99116 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -880,16 +880,30 @@ xfs_file_fallocate(
 		}
 
 		if (mode & FALLOC_FL_ZERO_RANGE) {
-			error = xfs_zero_file_space(ip, offset, len);
+			/*
+			 * Punch a hole and prealloc the range.  We use a hole
+			 * punch rather than unwritten extent conversion for two
+			 * reasons:
+			 *
+			 *   1.) Hole punch handles partial block zeroing for us.
+			 *   2.) If prealloc returns ENOSPC, the file range is
+			 *       still zero-valued by virtue of the hole punch.
+			 */
+			unsigned int blksize = i_blocksize(inode);
+
+			trace_xfs_zero_file_space(ip);
+
+			error = xfs_free_file_space(ip, offset, len);
+			if (error)
+				goto out_unlock;
+
+			len = round_up(offset + len, blksize) -
+			      round_down(offset, blksize);
+			offset = round_down(offset, blksize);
 		} else if (mode & FALLOC_FL_UNSHARE_RANGE) {
 			error = xfs_reflink_unshare(ip, offset, len);
 			if (error)
 				goto out_unlock;
-
-			if (!xfs_is_always_cow_inode(ip)) {
-				error = xfs_alloc_file_space(ip, offset, len,
-						XFS_BMAPI_PREALLOC);
-			}
 		} else {
 			/*
 			 * If always_cow mode we can't use preallocations and
@@ -899,12 +913,14 @@ xfs_file_fallocate(
 				error = -EOPNOTSUPP;
 				goto out_unlock;
 			}
+		}
 
+		if (!xfs_is_always_cow_inode(ip)) {
 			error = xfs_alloc_file_space(ip, offset, len,
 						     XFS_BMAPI_PREALLOC);
+			if (error)
+				goto out_unlock;
 		}
-		if (error)
-			goto out_unlock;
 	}
 
 	if (file->f_flags & O_DSYNC)
-- 
2.20.1

