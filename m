Return-Path: <linux-fsdevel+bounces-11345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97708852CA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C13289B86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5465F535D1;
	Tue, 13 Feb 2024 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="WxRaE/Va"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957653386;
	Tue, 13 Feb 2024 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817086; cv=none; b=QwjRZK2ZjypTsHIHiZfFDf41Ti6uLHrKYEYFnZWg5zE5P6jhKn89vUDeip/TAHh7ry+iyfTN5YPdnT7HiBARQnrIu2Mxtk/jPk6IxmFHFAZuqVljddn1a4WYiaQRqGjWh20yd2jT0YeaK4vBM72lyOkjCKVM5lN+BOtg2qW9dtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817086; c=relaxed/simple;
	bh=RR0ZwTzL0jbBJPQjhhUZZUPuDNlet8wM3A8lBNHMJrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ct/9Z27HiHD0KU2XzuqzzsTka21OjlExPtwkVLgLpAG1VsY8HlW13MFUVJPcbwFDCH9oILSrke8Ml167dglkwaRNnsLddmh7REzaOM28D6dGtjZnCE6XAI22nhv+0R7x9g1F7uUTKKteCE7xzx1NyhWVbG5H4T0O4GXJbzdAuO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=WxRaE/Va; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TYx894brXz9sq8;
	Tue, 13 Feb 2024 10:38:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707817081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzZe/GhW0AKuEEGxmrsisVmOwc1fDz2jZ00nW20jdYY=;
	b=WxRaE/VaFusCFl5KQNguCwied061qANl5HTR9V9OJtzJe7ZG6mjmEis1M1BAnz6yvnvEHC
	Nzf87hlFBc4f43/BSJaMthC/KNrvWMe4PJaq0ITrrMSZgEwSJkSKiPG4hjT8OYYNVT1U05
	5ckop88rRS+YSwN0H/gTEa2H+P1LDxjxKr4efXJ9CIgXLF4TUZHddADytDu7kvt01z+2VT
	GdFqmNf7DPnSJu4Tame5pp+JQjC4DSsYSHACxPoPkZFDSKwCrsSdshkNN9EgvAgYFytnql
	Leiu+FIkvhBgHBxs8VORK/8FPFWm2a6oCwlNjL0S2A9yNcrXB4yCGzHqPGEWGw==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org,
	gost.dev@samsung.com,
	akpm@linux-foundation.org,
	kbusch@kernel.org,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	p.raghav@samsung.com,
	linux-kernel@vger.kernel.org,
	hare@suse.de,
	willy@infradead.org,
	linux-mm@kvack.org,
	david@fromorbit.com
Subject: [RFC v2 12/14] xfs: make the calculation generic in xfs_sb_validate_fsb_count()
Date: Tue, 13 Feb 2024 10:37:11 +0100
Message-ID: <20240213093713.1753368-13-kernel@pankajraghav.com>
In-Reply-To: <20240213093713.1753368-1-kernel@pankajraghav.com>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TYx894brXz9sq8

From: Pankaj Raghav <p.raghav@samsung.com>

Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
make the calculation generic so that page cache count can be calculated
correctly for LBS.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/xfs/xfs_mount.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index aabb25dc3efa..bfbaaecaf668 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -133,9 +133,13 @@ xfs_sb_validate_fsb_count(
 {
 	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
 	ASSERT(sbp->sb_blocklog >= BBSHIFT);
+	unsigned long mapping_count;
+	uint64_t bytes = nblocks << sbp->sb_blocklog;
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


