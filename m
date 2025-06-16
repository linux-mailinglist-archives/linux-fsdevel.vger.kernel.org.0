Return-Path: <linux-fsdevel+bounces-51711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A03ADA842
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 08:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 888977A61F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 06:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2D21DE2BD;
	Mon, 16 Jun 2025 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzTxUX8Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B0972626;
	Mon, 16 Jun 2025 06:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750055444; cv=none; b=dPKZ+KyRuCYPWDcbf20TMeHLz9s0Muietd16isTyVFvYvrVLvnuGYeEEbYf3KdU+Fli2mDEiK7MIw7TKf3/9YePbE0bQOUgTNaP6Y+7H3JpZyYOu1xhv9FwGG4uzWBQRvlGK+YltZ/Zf6Xn/KyYpFhQGle1Cga+xm5Vvi5GYJCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750055444; c=relaxed/simple;
	bh=/CwtFfDuVXOHXbw7WvrWwerepPdxp0HV/s2hw8G1vGA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=t3eUpXYbZsHJou73d/airFpJaioTI0lOZ28eoj4giACV/hrK3xvc9eYB5iT9wEPQ08WJnkmADRk9zeFsASuKqz3KFwHFgEc3SsFSlGNeFAiJ9yr3Z3Z7H/t+0uyefaPK36NW+OSdH3x+ZPP7u+sGCa0a0xz1v7hc81TkTytCoZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzTxUX8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A202C4CEEA;
	Mon, 16 Jun 2025 06:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750055443;
	bh=/CwtFfDuVXOHXbw7WvrWwerepPdxp0HV/s2hw8G1vGA=;
	h=From:To:Subject:Date:From;
	b=VzTxUX8ZhEgBkywNza7SWYPPCHO6CQ7b+FJX0ZpeR4LLj3LhtT/AGmR5b2JdI+lqj
	 p8oLLAzdPb78qqEm9Qgelj2vdZIaV8E6IA8/cX8zid1k3cZzNIzU0m1CyiI9tWpEWT
	 5q1xgIf36PaxZ7xaFZ0WZn7OvhKWl+hlavnXEMZ/hGUkxFv0z6I+Ldu/KifWcFMNLW
	 +M62kruP+z0cV+65ycGyfQc//WSOJ+nn2PRGUuA5ksbAUdtJlVG1jpix3FjL/9wsJT
	 zoej005D9ve3U4acCXj2y+AK32IB2ugGCT99mpScnOGgkoSKaYwma/cs4M1Yf4XPHF
	 c0vBblQlIZKtA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@vger.kernel.org
Subject: [PATCH] block: Improve read ahead size for rotational devices
Date: Mon, 16 Jun 2025 15:28:56 +0900
Message-ID: <20250616062856.1629897-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a device that does not advertize an optimal I/O size, the function
blk_apply_bdi_limits() defaults to an initial setting of the ra_pages
field of struct backing_dev_info to VM_READAHEAD_PAGES, that is, 128 KB.

This low I/O size value is far from being optimal for hard-disk devices:
when reading files from multiple contexts using buffered I/Os, the seek
overhead between the small read commands generated to read-ahead
multiple files will significantly limit the performance that can be
achieved.

This fact applies to all ATA devices as ATA does not define an optimal
I/O size and the SCSI SAT specification does not define a default value
to expose to the host.

Modify blk_apply_bdi_limits() to use a device max_sectors limit to
calculate the ra_pages field of struct backing_dev_info, when the device
is a rotational one (BLK_FEAT_ROTATIONAL feature is set). For a SCSI
disk, this defaults to 2560 KB, which significantly improve performance
for buffered reads. Using XFS and sequentially reading randomly selected
(large) files stored on a SATA HDD, the maximum throughput achieved with
8 readers reading files with 1MB buffered I/Os increases from 122 MB/s
to 167 MB/s (+36%). The improvement is even larger when reading files
using 128 KB buffered I/Os, with a throughput increasing from 57 MB/s to
165 MB/s (+189%).

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-settings.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index a000daafbfb4..66d402de9026 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -58,16 +58,24 @@ EXPORT_SYMBOL(blk_set_stacking_limits);
 void blk_apply_bdi_limits(struct backing_dev_info *bdi,
 		struct queue_limits *lim)
 {
+	u64 io_opt = lim->io_opt;
+
 	/*
 	 * For read-ahead of large files to be effective, we need to read ahead
-	 * at least twice the optimal I/O size.
+	 * at least twice the optimal I/O size. For rotational devices that do
+	 * not report an optimal I/O size (e.g. ATA HDDs), use the maximum I/O
+	 * size to avoid falling back to the (rather inefficient) small default
+	 * read-ahead size.
 	 *
 	 * There is no hardware limitation for the read-ahead size and the user
 	 * might have increased the read-ahead size through sysfs, so don't ever
 	 * decrease it.
 	 */
+	if (!io_opt && (lim->features & BLK_FEAT_ROTATIONAL))
+		io_opt = (u64)lim->max_sectors << SECTOR_SHIFT;
+
 	bdi->ra_pages = max3(bdi->ra_pages,
-				lim->io_opt * 2 / PAGE_SIZE,
+				io_opt * 2 >> PAGE_SHIFT,
 				VM_READAHEAD_PAGES);
 	bdi->io_pages = lim->max_sectors >> PAGE_SECTORS_SHIFT;
 }
-- 
2.49.0


