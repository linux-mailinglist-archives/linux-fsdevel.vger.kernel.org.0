Return-Path: <linux-fsdevel+bounces-28995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E446397287F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214E91C225BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6B7172BD0;
	Tue, 10 Sep 2024 04:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cbmfoy73"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A1170A23;
	Tue, 10 Sep 2024 04:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943246; cv=none; b=hTHQkTiru66Cm9zw1JXNXEkiMhRCE3CLW5JiFCUw1cYN5mKfY3bYWBkVM2RiUoR/HfOvFC89YlbnvGdhuc8Y8ruUfRfHpYPWKd7VHKmSj0OffjnqREXcm+US6FIeFITtMYEtzwKRQb0RlyVQUC9cxq46MhHlkHJSXMYoz8ijCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943246; c=relaxed/simple;
	bh=QFMPvI8mcrN6fd6iDyWCLnmZzQZ9nygIE6HljTAcyg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ9jy0NU9pCKxE3tqKSfxez9ETIW/FHhNdgeGYd9VY6DIGmEMKatS6kFh3++2zui1qLIUnOZAp7GuLueYGCCdJCcITl7GIoEHDBjLvbzdCYMzPlASCXGeeEs+Ri5kB9uCtaHvI77m4gIL/Cnue57PfPtXmsv4OB4hh5i1uA7PSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cbmfoy73; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kLOl+pyQimDpiiohvXI28+01P/Taj3EFFYpexl++pq0=; b=Cbmfoy73HehFs5xYUiXSepS9Wx
	vgB07STWaijW4IpHS+dz1qZ/7sjTWfG0qxFn1a8g/lAUx+Y5wD9fNw11Cl/F9aX92O2DmxKKETtm4
	Bz4fY7N8QMwJG+tuoJVHS2ccp1Y0dg40QGBOu7Q8l7t8glCJJsJk+G63A99Ac7mEN6yjHAOqEDiJF
	uKnZovShZ5P2WVNky49Q0xACozThFsBqLiHt3ttL9bpHE3yd3m11GzkJ6ngr+24iUjQgw52i/Hcuj
	Hc7JmRmPfDBTJkqO1yQ2F4RvrjscVtyMn7x464v68+/am/bLymnBbkzQwNyvVBcjKY493C5nNo1/a
	NODWfAyg==;
Received: from ppp-2-84-49-240.home.otenet.gr ([2.84.49.240] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snsgG-00000004F2k-0dcF;
	Tue, 10 Sep 2024 04:40:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/12] xfs: share more code in xfs_buffered_write_iomap_begin
Date: Tue, 10 Sep 2024 07:39:12 +0300
Message-ID: <20240910043949.3481298-11-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910043949.3481298-1-hch@lst.de>
References: <20240910043949.3481298-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Introduce a local iomap_flags variable so that the code allocating new
delalloc blocks in the data fork can fall through to the found_imap
label and reuse the code to unlock and fill the iomap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 1d068cac69b4cc..12510380a495f8 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -975,6 +975,7 @@ xfs_buffered_write_iomap_begin(
 	int			allocfork = XFS_DATA_FORK;
 	int			error = 0;
 	unsigned int		lockmode = XFS_ILOCK_EXCL;
+	unsigned int		iomap_flags = 0;
 	u64			seq;
 
 	if (xfs_is_shutdown(mp))
@@ -1145,6 +1146,11 @@ xfs_buffered_write_iomap_begin(
 		}
 	}
 
+	/*
+	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
+	 * them out if the write happens to fail.
+	 */
+	iomap_flags |= IOMAP_F_NEW;
 	if (allocfork == XFS_COW_FORK) {
 		error = xfs_bmapi_reserve_delalloc(ip, allocfork, offset_fsb,
 				end_fsb - offset_fsb, prealloc_blocks, &cmap,
@@ -1162,19 +1168,11 @@ xfs_buffered_write_iomap_begin(
 	if (error)
 		goto out_unlock;
 
-	/*
-	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
-	 * them out if the write happens to fail.
-	 */
-	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_NEW);
-	xfs_iunlock(ip, lockmode);
 	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
-
 found_imap:
-	seq = xfs_iomap_inode_sequence(ip, 0);
+	seq = xfs_iomap_inode_sequence(ip, iomap_flags);
 	xfs_iunlock(ip, lockmode);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
 
 convert_delay:
 	xfs_iunlock(ip, lockmode);
-- 
2.45.2


