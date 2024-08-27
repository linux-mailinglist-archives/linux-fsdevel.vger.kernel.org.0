Return-Path: <linux-fsdevel+bounces-27316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E32D960270
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 08:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA61F22F5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 06:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C244F158DA0;
	Tue, 27 Aug 2024 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tk10eFis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAA54F87;
	Tue, 27 Aug 2024 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741502; cv=none; b=QMZ/rjnh49pxLzf8AZ+Bl6E8ajXkvvTFdyQ3HBANbuaXQnxvwOo7Aa7V9h1sUnL0LkkqvLqoPKcyEhM0B64jr0gB5WRKn15BGhFlp2FpazKBx8eMZS3U49Db7KgwWBMS4yUszrWd2YL34NVA6Pxt6hOiwceYBi5ZEdyhyQKOgkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741502; c=relaxed/simple;
	bh=+NdG1kCwaliZzAQZOcdJAlZqRpuTUGhbpRb2bsYWZXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQVYTSxqT+B9gM1eYhNlrtt3oljicxpD+uNX+FHHzpudZbNoCpq1pQOjIcgl8Y6yOKliqzgbkBUJpeUnjStfHfJ7w9ybt/d2OX/TdwRRVstXoC5WMhF+3XSdMHTv/C51MpJw7yVpE9FCD8RY5OsjfX7SBZPi6fvUw9FAIwrIA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tk10eFis; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5dRb2FOCAtKiyzIKWuqXAjQXmiwkQGtbalsiqji/vfU=; b=tk10eFisrHzPv7legCS0PeZkEK
	WVos2rprbklZVLAy+l31p0AiLJpTu9mBCQYkDKc+UM4dyTri9Up/QdHwN9Wk5aKhxxRas//iO+YT2
	Psb6+ekQ2NYHE5dORI4dTiFRKyaycmZELlEe3Ez4sp2T9Mz/1/GuBiJJ4oNPsFHDPU9pm0V7Fvy/U
	YlD+m/EX3mK4JqyHNYTxat5kKd64jw5eug8pDUognvnS2MBOtcpAkxw/03B1Bjh4fJiq1LRj7XdhU
	96F7oUoA5jBKHDs22DlRhqDk8ky3ST9fj4HV7LB1/cC4KXhX3ejHoN7C41ZrANrSxZqSZ85dg92hp
	NANJCkzw==;
Received: from 2a02-8389-2341-5b80-0483-5781-2c2b-8fb4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:483:5781:2c2b:8fb4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siq3F-0000000A6FD-3iLa;
	Tue, 27 Aug 2024 06:51:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>
Cc: Brian Foster <bfoster@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 4/6] xfs: call xfs_flush_unmap_range from xfs_free_file_space
Date: Tue, 27 Aug 2024 08:50:48 +0200
Message-ID: <20240827065123.1762168-5-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827065123.1762168-1-hch@lst.de>
References: <20240827065123.1762168-1-hch@lst.de>
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


