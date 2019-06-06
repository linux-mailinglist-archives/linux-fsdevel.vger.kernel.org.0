Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E09136977
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 03:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfFFBpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 21:45:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:36145 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfFFBpY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:45:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 18:45:23 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 05 Jun 2019 18:45:22 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH RFC 08/10] fs/xfs: Teach xfs to use new dax_layout_busy_page()
Date:   Wed,  5 Jun 2019 18:45:41 -0700
Message-Id: <20190606014544.8339-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606014544.8339-1-ira.weiny@intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

dax_layout_busy_page() can now operate on a sub-range of the
address_space provided.

Have xfs specify the sub range to dax_layout_busy_page()

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/xfs/xfs_file.c  | 19 +++++++++++++------
 fs/xfs/xfs_inode.h |  5 +++--
 fs/xfs/xfs_ioctl.c | 15 ++++++++++++---
 fs/xfs/xfs_iops.c  | 14 ++++++++++----
 4 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ebddf911644c..350eb5546d36 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -300,7 +300,11 @@ xfs_file_aio_write_checks(
 	if (error <= 0)
 		return error;
 
-	error = xfs_break_layouts(inode, iolock, BREAK_WRITE);
+	/*
+	 * BREAK_WRITE ignores offset/len tuple just specify the whole file
+	 * (0 - ULONG_MAX to be safe.
+	 */
+	error = xfs_break_layouts(inode, iolock, 0, ULONG_MAX, BREAK_WRITE);
 	if (error)
 		return error;
 
@@ -740,14 +744,15 @@ xfs_wait_dax_page(
 static int
 xfs_break_dax_layouts(
 	struct inode		*inode,
-	bool			*retry)
+	bool			*retry,
+	loff_t                   off,
+	loff_t                   len)
 {
 	struct page		*page;
 
 	ASSERT(xfs_isilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL));
 
-	/* We default to the "whole file" */
-	page = dax_layout_busy_page(inode->i_mapping, 0, ULONG_MAX);
+	page = dax_layout_busy_page(inode->i_mapping, off, len);
 	if (!page)
 		return 0;
 
@@ -761,6 +766,8 @@ int
 xfs_break_layouts(
 	struct inode		*inode,
 	uint			*iolock,
+	loff_t                   off,
+	loff_t                   len,
 	enum layout_break_reason reason)
 {
 	bool			retry;
@@ -772,7 +779,7 @@ xfs_break_layouts(
 		retry = false;
 		switch (reason) {
 		case BREAK_UNMAP:
-			error = xfs_break_dax_layouts(inode, &retry);
+			error = xfs_break_dax_layouts(inode, &retry, off, len);
 			if (error || retry)
 				break;
 			/* fall through */
@@ -814,7 +821,7 @@ xfs_file_fallocate(
 		return -EOPNOTSUPP;
 
 	xfs_ilock(ip, iolock);
-	error = xfs_break_layouts(inode, &iolock, BREAK_UNMAP);
+	error = xfs_break_layouts(inode, &iolock, offset, len, BREAK_UNMAP);
 	if (error)
 		goto out_unlock;
 
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 558173f95a03..1b0948f5267c 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -475,8 +475,9 @@ enum xfs_prealloc_flags {
 
 int	xfs_update_prealloc_flags(struct xfs_inode *ip,
 				  enum xfs_prealloc_flags flags);
-int	xfs_break_layouts(struct inode *inode, uint *iolock,
-		enum layout_break_reason reason);
+int xfs_break_layouts(struct inode *inode, uint *iolock,
+		      loff_t off, loff_t len,
+		      enum layout_break_reason reason);
 
 /* from xfs_iops.c */
 extern void xfs_setup_inode(struct xfs_inode *ip);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d7dfc13f30f5..a702e44a63b8 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -605,6 +605,7 @@ xfs_ioc_space(
 	enum xfs_prealloc_flags	flags = 0;
 	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
 	int			error;
+	loff_t                  break_length;
 
 	if (inode->i_flags & (S_IMMUTABLE|S_APPEND))
 		return -EPERM;
@@ -625,9 +626,6 @@ xfs_ioc_space(
 		return error;
 
 	xfs_ilock(ip, iolock);
-	error = xfs_break_layouts(inode, &iolock, BREAK_UNMAP);
-	if (error)
-		goto out_unlock;
 
 	switch (bf->l_whence) {
 	case 0: /*SEEK_SET*/
@@ -673,6 +671,17 @@ xfs_ioc_space(
 		goto out_unlock;
 	}
 
+	/* break layout for the whole file if len ends up 0 */
+	if (bf->l_len == 0)
+		break_length = ULONG_MAX;
+	else
+		break_length = bf->l_len;
+
+	error = xfs_break_layouts(inode, &iolock, bf->l_start, break_length,
+				  BREAK_UNMAP);
+	if (error)
+		goto out_unlock;
+
 	switch (cmd) {
 	case XFS_IOC_ZERO_RANGE:
 		flags |= XFS_PREALLOC_SET;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 74047bd0c1ae..5529bc7a516b 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1052,10 +1052,16 @@ xfs_vn_setattr(
 		xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
 		iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
 
-		error = xfs_break_layouts(inode, &iolock, BREAK_UNMAP);
-		if (error) {
-			xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
-			return error;
+		if (iattr->ia_size < inode->i_size) {
+			loff_t                  off = iattr->ia_size;
+			loff_t                  len = inode->i_size - iattr->ia_size;
+
+			error = xfs_break_layouts(inode, &iolock, off, len,
+						  BREAK_UNMAP);
+			if (error) {
+				xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
+				return error;
+			}
 		}
 
 		error = xfs_vn_setattr_size(dentry, iattr);
-- 
2.20.1

