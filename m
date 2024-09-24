Return-Path: <linux-fsdevel+bounces-29943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6054B983F7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BEC41F23FE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 07:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CBF1494CA;
	Tue, 24 Sep 2024 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nKBJ1OBu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A09D1487DC;
	Tue, 24 Sep 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163705; cv=none; b=YtKeztoTzanAW0V2W+aS5XDdXSUjKTjseAYTsNdKMUB+vDc9Gz4Oe74oQXtdG9qQbKOtW8ZaqiO4BvgOjQKRvKXW1QnjzpOeEjC1vj7zPUdgK1ftn4p5wtertUQOtr3wWmflT8jLIXuqoqq+Ra6pQVCEIHyLjGCXTXBT5fnnIMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163705; c=relaxed/simple;
	bh=cENzFFA5n8jcryp5DheR2B9BhTpYhnn6FFAGeoIDolY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2TB7d2AJ4eacxGDli/zChQO4dhb0JzGQpi6tioQdbbUyo6uRPK+dC5GRpzqooV1n7ILggJv751cyZcU8QUVx7erWl0vb0AzFEGDrH7muKDxJBi3Sq3EQwtokCQDYrysQJAqXfYFb1L48FHfKTjvM9FZJeo4eoB4EX6vT1IKRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nKBJ1OBu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XgpcWjaaxOxWsVSLuljd4lIdBMwsD3f3bTuuKxJfP4E=; b=nKBJ1OBu0tzvGWddDZMeuUGX3m
	p/krd5AYS9BZnRa9fzF7Tj7dq7F7bLVD/D+djj83KN3AKuW5X28AqNyFhzCpiFrE7hpUSEx8k/dkN
	fFdqO9V5jr/odgCFJgr1yzQ0m/id7srCdoAb/lZU3ED+mcPgRid971KmyT1lgaK6z04AnXmn0Po+P
	KgYWGAhOrwj9ki8vOHGnP22vNEaK/UrnCzsmJDT8FuDY8eX3/2Wiy0aOeq7rWjRMwv/aDq/l7QSJa
	bdGXxPhboa/X1hsIhUPponAXqPHVfK0W7g54uAgdFF3KozI1uTrtIH/ubdqzQKffB4X0l8lc/v12o
	Zwrs8ozg==;
Received: from 2a02-8389-2341-5b80-b62d-f525-8e84-d569.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b62d:f525:8e84:d569] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1st0B5-00000001SND-1j2o;
	Tue, 24 Sep 2024 07:41:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/10] xfs: share more code in xfs_buffered_write_iomap_begin
Date: Tue, 24 Sep 2024 09:40:50 +0200
Message-ID: <20240924074115.1797231-9-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240924074115.1797231-1-hch@lst.de>
References: <20240924074115.1797231-1-hch@lst.de>
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
index abc3b9f1115ce7..aff9e8305399ee 100644
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


