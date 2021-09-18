Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED59C4102AF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 03:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhIRBca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 21:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235000AbhIRBc3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 21:32:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02AC76112E;
        Sat, 18 Sep 2021 01:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631928667;
        bh=xuiaU4G94JZ0dj6J2nwdrhrGZ7owpzE72Ua/872ZRe4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kvWknvJxz/MOdA9ATXRi0S8rMr/0nfxuhTxHByrYJrTPYBaEJjfb/MCKD9KmvuLLF
         jY1zpRlpKBIjf+XDrpa4sjvur63liF6nAgzpSC7VGKr9IWs8pOGcEKpiIIjnGiUllo
         aXIx+qbbOmCOzVXEmsrrZZVPPTzy7SJfCpMbXgxSOnFUkp5wlSMJHe1cs+2JzGQpju
         Vq++B8Bkue0K22dgzhJhwEahvRT53fBQBBsih9NGge4kGMjsChdC+GJkZECQxSva0h
         OiGrTEnj8E1NkGD4lDxjInnyDKAwb27wMkwQ4sh1mLuVwIlHJQYWS7BJFFoaZmLW0I
         SVjPkGCtS1g5g==
Subject: [PATCH 4/5] xfs: implement FALLOC_FL_ZEROINIT_RANGE
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, jane.chu@oracle.com
Cc:     linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Date:   Fri, 17 Sep 2021 18:31:06 -0700
Message-ID: <163192866672.417973.1497612280233084622.stgit@magnolia>
In-Reply-To: <163192864476.417973.143014658064006895.stgit@magnolia>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Implement this new fallocate mode so that persistent memory users can,
upon receipt of a pmem poison notification, cause the pmem to be
reinitialized to a known value (zero) and clear any hardware poison
state that might be lurking.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c |   22 ++++++++++++++++++++++
 fs/xfs/xfs_bmap_util.h |    2 ++
 fs/xfs/xfs_file.c      |   11 ++++++++---
 fs/xfs/xfs_trace.h     |    1 +
 4 files changed, 33 insertions(+), 3 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 73a36b7be3bd..319e79bb7fd8 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -956,6 +956,28 @@ xfs_flush_unmap_range(
 	return 0;
 }
 
+int
+xfs_file_zeroinit_space(
+	struct xfs_inode	*ip,
+	xfs_off_t		offset,
+	xfs_off_t		len)
+{
+	struct inode		*inode = VFS_I(ip);
+	int			error;
+
+	trace_xfs_zeroinit_file_space(ip, offset, len);
+
+	if (IS_DAX(inode))
+		error = dax_zeroinit_range(inode, offset, len,
+				&xfs_read_iomap_ops);
+	else
+		error = iomap_zeroout_range(inode, offset, len,
+				&xfs_read_iomap_ops);
+	if (error == -ECANCELED)
+		return -EOPNOTSUPP;
+	return error;
+}
+
 int
 xfs_free_file_space(
 	struct xfs_inode	*ip,
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index 9f993168b55b..7bb425d0876c 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -61,6 +61,8 @@ int	xfs_collapse_file_space(struct xfs_inode *, xfs_off_t offset,
 				xfs_off_t len);
 int	xfs_insert_file_space(struct xfs_inode *, xfs_off_t offset,
 				xfs_off_t len);
+int	xfs_file_zeroinit_space(struct xfs_inode *ip, xfs_off_t offset,
+				xfs_off_t length);
 
 /* EOF block manipulation functions */
 bool	xfs_can_free_eofblocks(struct xfs_inode *ip, bool force);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 7aa943edfc02..886e819efa3b 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -899,7 +899,8 @@ xfs_break_layouts(
 #define	XFS_FALLOC_FL_SUPPORTED						\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
 		 FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |	\
-		 FALLOC_FL_INSERT_RANGE | FALLOC_FL_UNSHARE_RANGE)
+		 FALLOC_FL_INSERT_RANGE | FALLOC_FL_UNSHARE_RANGE |	\
+		 FALLOC_FL_ZEROINIT_RANGE)
 
 STATIC long
 xfs_file_fallocate(
@@ -950,13 +951,17 @@ xfs_file_fallocate(
 	 * handled at the right time by xfs_prepare_shift().
 	 */
 	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE |
-		    FALLOC_FL_COLLAPSE_RANGE)) {
+		    FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZEROINIT_RANGE)) {
 		error = xfs_flush_unmap_range(ip, offset, len);
 		if (error)
 			goto out_unlock;
 	}
 
-	if (mode & FALLOC_FL_PUNCH_HOLE) {
+	if (mode & FALLOC_FL_ZEROINIT_RANGE) {
+		error = xfs_file_zeroinit_space(ip, offset, len);
+		if (error)
+			goto out_unlock;
+	} else if (mode & FALLOC_FL_PUNCH_HOLE) {
 		error = xfs_free_file_space(ip, offset, len);
 		if (error)
 			goto out_unlock;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 4a8076ef8cb4..eccad0a5c40f 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1534,6 +1534,7 @@ DEFINE_SIMPLE_IO_EVENT(xfs_zero_eof);
 DEFINE_SIMPLE_IO_EVENT(xfs_end_io_direct_write);
 DEFINE_SIMPLE_IO_EVENT(xfs_end_io_direct_write_unwritten);
 DEFINE_SIMPLE_IO_EVENT(xfs_end_io_direct_write_append);
+DEFINE_SIMPLE_IO_EVENT(xfs_zeroinit_file_space);
 
 DECLARE_EVENT_CLASS(xfs_itrunc_class,
 	TP_PROTO(struct xfs_inode *ip, xfs_fsize_t new_size),

