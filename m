Return-Path: <linux-fsdevel+bounces-11344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F3C852CA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7691F27510
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595FF5336E;
	Tue, 13 Feb 2024 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="LJLR6r+3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D252F7D;
	Tue, 13 Feb 2024 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817083; cv=none; b=d6xuO4laPZCcKMeNL0htDOphxml7J5eBRBoxxhlVCCRgPovqXu1296tj8FelPSg8ArwHuNdAt3C/RTD9ie7Yj7ozZaVW9HYXMuWpUrHL3Ov8fvraYynVIQrsaAwYKDlOJae0J49psPloyA7aSPyk7yTTfSCoD14iw/SvrvnrXDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817083; c=relaxed/simple;
	bh=Samgg5HXfwngqVGtKhyUchziucj3WKbVNDjN+/ay334=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDeP8j4PzGE/aOXzz79mX7lGwau2vyHFftXNJoljBeKxCQenQGqd7pgc8G9aA6fbK1QyjdQR5dBLFn+ahphxVuv5O6Gcbdx97tY7LIvKV91YdBSqmSvdIIzvdR6SVo8/KUvGzFvKB+WZxbrVAIIVgi7YSq8dty/wpwAguu1CdWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=LJLR6r+3; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TYx864DCXz9sp2;
	Tue, 13 Feb 2024 10:37:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707817078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MO0EI8w5WbkUQtm6TaQ0DQo1nNqS6QPeZXjuQJSUGbE=;
	b=LJLR6r+34CoFzdv2J3qP5MfDOQ6MMnj0VOgb57gkDihAt/g5yljWgrPF5I+ZK4MfCqdLSi
	vBMvmgP3hTSxUlA4ch0+pC0vjX+MdsTWc5PiIjFGjau9gw7S/J33U5ddWn4cjiM6DlMG0W
	Ur98/ltE05ZvGCzVpgYzQrW3OcQxJZP+oR1H5YbatkY+28PnDdNEeZSZ2gCzVWtzSnF5Q1
	YJGWDOj6+sAm2G6B++jG9Yh5Hun13hydNfMq8aFAgAB9nouxcBdVpJXDifnxYLgegAPikF
	o8MBpLKXTY6q6zwboZzhre51ySyXG0YGTKSCzYXVfa+9HC40mLev/vudl4ahOg==
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
	david@fromorbit.com,
	Dave Chinner <dchinner@redhat.com>
Subject: [RFC v2 11/14] xfs: expose block size in stat
Date: Tue, 13 Feb 2024 10:37:10 +0100
Message-ID: <20240213093713.1753368-12-kernel@pankajraghav.com>
In-Reply-To: <20240213093713.1753368-1-kernel@pankajraghav.com>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

For block size larger than page size, the unit of efficient IO is
the block size, not the page size. Leaving stat() to report
PAGE_SIZE as the block size causes test programs like fsx to issue
illegal ranges for operations that require block size alignment
(e.g. fallocate() insert range). Hence update the preferred IO size
to reflect the block size in this case.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
[mcgrof: forward rebase in consideration for commit
dd2d535e3fb29d ("xfs: cleanup calculating the stat optimal I/O size")]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/xfs/xfs_iops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index a0d77f5f512e..8791a9d80897 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -515,6 +515,8 @@ xfs_stat_blksize(
 	struct xfs_inode	*ip)
 {
 	struct xfs_mount	*mp = ip->i_mount;
+	unsigned long	default_size = max_t(unsigned long, PAGE_SIZE,
+					     mp->m_sb.sb_blocksize);
 
 	/*
 	 * If the file blocks are being allocated from a realtime volume, then
@@ -543,7 +545,7 @@ xfs_stat_blksize(
 			return 1U << mp->m_allocsize_log;
 	}
 
-	return PAGE_SIZE;
+	return default_size;
 }
 
 STATIC int
-- 
2.43.0


