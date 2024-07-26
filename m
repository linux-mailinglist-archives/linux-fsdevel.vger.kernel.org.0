Return-Path: <linux-fsdevel+bounces-24317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6070693D2B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 14:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF461B2240B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 12:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331D717C7CD;
	Fri, 26 Jul 2024 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="RpBM3Xd9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3659117C7C8;
	Fri, 26 Jul 2024 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721995248; cv=none; b=Evs1ddDRa0FBAvT7cnOWI7bxYZxJTpqWafn4I+hnBrnSFV7z5GvraISmqp2ehFhWAsOUC0BZFwJIg5KlZXJ4l1kI8W1+fdrknl0B5LxwrQ7gSiBhaccu6UzlFyAUAEcHtu5J6AU6iqs/bG38N2krIEcX/1YyRmIV/uMoYMm6/q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721995248; c=relaxed/simple;
	bh=83e+0O9ruf6NHQsjOHUghZzAigZgO9pFvauSb7vbrvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1O4CM6bI5aLT38HUV3CoQPBvMzBDaKwnrMxyMiv0Z/beGqqiPYWYyIfswDxGtwO41l5V+AdRXb1xO+wBaGIwvlOts0IGhkrsx9O+YHx37MxWB9pDeQmVfm1ikyvOtPXTxF15pRFz11BB877Qx9VMqkPN4yqpFRk7uNIqaPhKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=RpBM3Xd9; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WVmY60pGjz9sbL;
	Fri, 26 Jul 2024 14:00:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1721995242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ndnSuxu0rcgI+ZEpYzFfnAXwgKuKHjCIUBMGSEb9FZY=;
	b=RpBM3Xd9hnXdfE7erL4HrWZmKKBLxwOcMTt3SFH3QB1WFE0iLXt34fNrq38jDaAE+2vQo5
	8OJ8H4Ko0fAuOd9NV3+1GdbOqIpJtMxhi2RAuhxGYqJ7NUkkn+IfO3o1LAwgNxNNde80SD
	psMGOYNGXTFTvWZO2Jr66T8q/sbZn6Cua/enZaGy2jn33nyW3o1gfHMYtYG/aV8eU+EWeu
	B2HAwF7XS6ocx6yL91QlXSF8ciD1u2bLJinHblTkKys02Xd4mPQ4QdDZBoxw9JI3KcymmJ
	EgTqVEKd/kfA5s/RnC9s0tbezcFFJ3/SlbwPr2hBfVGM6j/BwRHs1Y2I9feqUA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	willy@infradead.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	brauner@kernel.org,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	ryan.roberts@arm.com,
	hch@lst.de,
	Zi Yan <ziy@nvidia.com>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v11 08/10] xfs: expose block size in stat
Date: Fri, 26 Jul 2024 13:59:54 +0200
Message-ID: <20240726115956.643538-9-kernel@pankajraghav.com>
In-Reply-To: <20240726115956.643538-1-kernel@pankajraghav.com>
References: <20240726115956.643538-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 1cdc8034f54d9..6483b4c4cf355 100644
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


