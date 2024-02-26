Return-Path: <linux-fsdevel+bounces-12780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF91867045
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80711F2A850
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091AF76038;
	Mon, 26 Feb 2024 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="hAVlxzD2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D773F0F;
	Mon, 26 Feb 2024 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941038; cv=none; b=E2xolLJ2Gy6+WLV7/8dRej5EAwKl8yU20aCS7csecJMtSKE8gCugsGEQV9bf4egVBEKw/ILTnSi6bh4AzOXHSl3yWDBm+jMKnic+ibLS9LFWNyddN03sGL4TD2NxAYQzlURJrbYkltEtXWfLInqDk5PtEZtLlfNE1ll1wP8du9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941038; c=relaxed/simple;
	bh=FVDRi+FI/MUDSSs6VohUD1IoeSztA4fHLw2LTFv4FBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHm/29PNI4Qdk59FBJVbBv+3pUK5MLgChDdN50MBMDjj2suoiNk2oLZ1N8UkXWbtpN9g84ldTW2gFF5Bi+eMPDC79DChalkzPWWXoJYm0Ux1bnaG82OL7gbOIowNb1lLWaDUJpNNYJdCVV6MnyUo3GUK6h54SZNSrnOI3bzs440=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=hAVlxzD2; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Tjwpd5S1bz9sqr;
	Mon, 26 Feb 2024 10:50:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1708941033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HlYEwWAE6vZZcw5JeU6SUv0SKwh4LwGux0locayr8EQ=;
	b=hAVlxzD2LUL1rbpSWjPjfIWWZ+5drZJNxCuKnYF1eJy8lXLqGyC3JvVjJva165jpZA8JrK
	/NizHCJ/YjEL816L5LIhVDRvYkcIOLksj7bpIUgXlYkP3mVY1kr/aMoGEUbK03wka8yZ9S
	Sr6WVXmeCkUN9ZfZ97Ut4XQrp4ARMV4/DD2WK22lwFyIP5AfsEkvUGV3hnyVAFzwTdDNL0
	Q5nftWFtgrFUeqMaxatl83Cq1koGPzuefYzt7zvoWkCPf69Ydn5PYfAqOWucArjj7RmCxM
	LPwD8UfbzpoS3DW1EujY+tdRK5i5lGBa24C8u4KLR8TX8md71im/pzk2XnBEsQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	ziy@nvidia.com,
	hare@suse.de,
	djwong@kernel.org,
	gost.dev@samsung.com,
	linux-mm@kvack.org,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 12/13] xfs: make the calculation generic in xfs_sb_validate_fsb_count()
Date: Mon, 26 Feb 2024 10:49:35 +0100
Message-ID: <20240226094936.2677493-13-kernel@pankajraghav.com>
In-Reply-To: <20240226094936.2677493-1-kernel@pankajraghav.com>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
make the calculation generic so that page cache count can be calculated
correctly for LBS.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/xfs/xfs_mount.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index aabb25dc3efa..69af3b06be99 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -133,9 +133,15 @@ xfs_sb_validate_fsb_count(
 {
 	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
 	ASSERT(sbp->sb_blocklog >= BBSHIFT);
+	uint64_t mapping_count;
+	uint64_t bytes;
 
+	if (check_mul_overflow(nblocks, (1 << sbp->sb_blocklog), &bytes))
+		return -EFBIG;
+
+	mapping_count = bytes >> PAGE_SHIFT;
 	/* Limited by ULONG_MAX of page cache index */
-	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
+	if (mapping_count > ULONG_MAX)
 		return -EFBIG;
 	return 0;
 }
-- 
2.43.0


