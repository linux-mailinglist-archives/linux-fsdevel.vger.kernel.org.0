Return-Path: <linux-fsdevel+bounces-26435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A070095949E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38671C20D7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844E716F0E8;
	Wed, 21 Aug 2024 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yMPk/GwZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171C16D4D4;
	Wed, 21 Aug 2024 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221884; cv=none; b=ui82vG1xljaii+ZW/emxyZx//hUojOc+7j5zxcgsGspoTJMYIZbrC3ZPzRn/GXDvAxl3aOA0ZFRKUa5HOxa8zgSHVNwT7FEuwid6/YMnkZyCB6znRf0vNDPyF1yqBAJ3/uFw6JRMwLnzhjCzsgEI8yYRBXTHooov9IMfFK6YbWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221884; c=relaxed/simple;
	bh=+NdG1kCwaliZzAQZOcdJAlZqRpuTUGhbpRb2bsYWZXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYJZczW3cY5r4l6IH/TrKa2QtwYiRD11hjivE4NiYDYLHEqQ60BMtQU3+8r+oWrFWfNo/XwZ/0cy/Fc7pOP5zYnerlA/V561zkqxoAmXpqVXVoOSBUk5UoJgFWi/UiPojiWEfzsVKdBAIejelTSqW+8HmCYEBOEBNXTmWX+nwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yMPk/GwZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5dRb2FOCAtKiyzIKWuqXAjQXmiwkQGtbalsiqji/vfU=; b=yMPk/GwZpeLZ045+TZlBX02icT
	6n/IUiFsH0qsDyYarAUFUGBu1VPa+iRfdn7u9+X19nO83o9KeOb5zWRyZx0WAtIeApggX9dQT5Y40
	Wnn+Bnbql8rEGX5XzTCMN4VQ2ykTwrNURtICymNxxK9UpgCbBtO4r3CB4MRfL2PeU7OGi3FLfOrRb
	IWKr2I34rhx3XL6BXBEBqZDuqsm5v4V726qpK3lhYlk4+U2Jx7rtes6kCV7sbRarys5Yw8nrkjrau
	Vmetd1mMLbz7ddbf9lsUHCSzFZmQAk3/fCGG9u7JqntbYT1wulhcHWSReQJ7NVXHOvR+Ku5xTNvS7
	5Wzz36CQ==;
Received: from 2a02-8389-2341-5b80-94d5-b2c4-989b-ff6e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:94d5:b2c4:989b:ff6e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgesL-00000007iTF-28hm;
	Wed, 21 Aug 2024 06:31:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 4/6] xfs: call xfs_flush_unmap_range from xfs_free_file_space
Date: Wed, 21 Aug 2024 08:30:30 +0200
Message-ID: <20240821063108.650126-5-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821063108.650126-1-hch@lst.de>
References: <20240821063108.650126-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Call xfs_flush_unmap_range from xfs_free_file_space so that
xfs_file_fallocate doesn't have to predict which mode will call it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_bmap_util.c |  8 ++++++++
 fs/xfs/xfs_file.c      | 21 ---------------------
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index fe2e2c93097550..187a0dbda24fc4 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -848,6 +848,14 @@ xfs_free_file_space(
 	if (len <= 0)	/* if nothing being freed */
 		return 0;
 
+	/*
+	 * Now AIO and DIO has drained we flush and (if necessary) invalidate
+	 * the cached range over the first operation we are about to run.
+	 */
+	error = xfs_flush_unmap_range(ip, offset, len);
+	if (error)
+		return error;
+
 	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
 	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4cdc54dc96862e..5b9e49da06013c 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -890,27 +890,6 @@ xfs_file_fallocate(
 	 */
 	inode_dio_wait(inode);
 
-	/*
-	 * Now AIO and DIO has drained we flush and (if necessary) invalidate
-	 * the cached range over the first operation we are about to run.
-	 *
-	 * We care about zero and collapse here because they both run a hole
-	 * punch over the range first. Because that can zero data, and the range
-	 * of invalidation for the shift operations is much larger, we still do
-	 * the required flush for collapse in xfs_prepare_shift().
-	 *
-	 * Insert has the same range requirements as collapse, and we extend the
-	 * file first which can zero data. Hence insert has the same
-	 * flush/invalidate requirements as collapse and so they are both
-	 * handled at the right time by xfs_prepare_shift().
-	 */
-	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE |
-		    FALLOC_FL_COLLAPSE_RANGE)) {
-		error = xfs_flush_unmap_range(ip, offset, len);
-		if (error)
-			goto out_unlock;
-	}
-
 	error = file_modified(file);
 	if (error)
 		goto out_unlock;
-- 
2.43.0


