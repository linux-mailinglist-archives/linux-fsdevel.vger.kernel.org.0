Return-Path: <linux-fsdevel+bounces-26038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0D3952BEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96D17B2231D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934EE1E3CC8;
	Thu, 15 Aug 2024 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="bmHxN5xn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF691E3CBC;
	Thu, 15 Aug 2024 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712989; cv=none; b=kgNWPwEhhV4x0SZPBORRmIFqy5a/Cwx7Bng3BPRYFulz9BMXatsL2jRIMVlYHEe8KyoKesYfDXgpWiKPQ8Of0GqGQlZS1F3qRmG8P9sBq/VpHm1OQ8Ld0fj3pO7U7wzyfXpc9mUe/YZeF0kIqUzPT5Zpnhemh/0Su90C/pH/ZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712989; c=relaxed/simple;
	bh=DJ2EmpR/3LYu+ZcXHm2ZIaZfhdO6TbSJQLVoebv5eCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUsp2fOUtl3YHYy05iQPM9J98UpqkWXmF8c2FSItMXkehFQSL3G5yZGaLG37kHPszoNuq+IzsGXen4QldArMg20OwsnnAVRTTE1+dkW6/KJ6Rbhu82J0oGKWvtxSEEObDHqqTUabV5vhhylHqk4fEg0CeGVLhbS2DUA471tTI3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=bmHxN5xn; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WkzpY3KLZz9tHx;
	Thu, 15 Aug 2024 11:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1723712981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFCQeRoYKCpIwc/V7VVfVT8xrzJ1wqzaVy/cCyGH2d4=;
	b=bmHxN5xnLg35Iz86PnXix1HzhYebVNPB+WjyRU4E3jgDRG4++HgKyq6jFbdDZJ5G9DcfMx
	npD2ioepW1fqtg7r0lLJF0fudyKYiqkBvKa7Yi+unwvJD5rwOCuMyvg1L8uZ3JTQAoH+Qx
	ieLj0l8s6ki0jkk2Z6Elh2HLY8V4hqDrdq8TjaMG9lrguXfSLcL9oYNR6ZdRJX8WF3wI88
	W+DTZGv97zZ5dZnVhePG6YoQmnz9SoYBBXNwIJN8Dq7m+kdH+nWX0Udc5RmmPySxtaofTk
	Bfy5kmT/sVmIsG1933qAxTMREHPS0yGV7y3ON1WyPtNVrAj7y+qto8+oiBTlBg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: brauner@kernel.org,
	akpm@linux-foundation.org
Cc: chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org,
	djwong@kernel.org,
	hare@suse.de,
	gost.dev@samsung.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	david@fromorbit.com,
	Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	john.g.garry@oracle.com,
	cl@os.amperecomputing.com,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	ryan.roberts@arm.com,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v12 08/10] xfs: expose block size in stat
Date: Thu, 15 Aug 2024 11:08:47 +0200
Message-ID: <20240815090849.972355-9-kernel@pankajraghav.com>
In-Reply-To: <20240815090849.972355-1-kernel@pankajraghav.com>
References: <20240815090849.972355-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WkzpY3KLZz9tHx

From: Pankaj Raghav <p.raghav@samsung.com>

For block size larger than page size, the unit of efficient IO is
the block size, not the page size. Leaving stat() to report
PAGE_SIZE as the block size causes test programs like fsx to issue
illegal ranges for operations that require block size alignment
(e.g. fallocate() insert range). Hence update the preferred IO size
to reflect the block size in this case.

This change is based on a patch originally from Dave Chinner.[1]

[1] https://lwn.net/ml/linux-fsdevel/20181107063127.3902-16-david@fromorbit.com/

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_iops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index a1c4a350a6dbf..2b8dbe8bf1381 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -567,7 +567,7 @@ xfs_stat_blksize(
 			return 1U << mp->m_allocsize_log;
 	}
 
-	return PAGE_SIZE;
+	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
 STATIC int
-- 
2.44.1


