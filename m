Return-Path: <linux-fsdevel+bounces-24318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCBA93D2BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 14:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0F31C20C82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 12:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A6717C9F7;
	Fri, 26 Jul 2024 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="qj6gQzzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCAD17C7D9;
	Fri, 26 Jul 2024 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721995251; cv=none; b=dp+506f4CaZcD/eHbInsU/EewvjFI2TvsvVBhIuL7VgqC1nFLmL8jiO4yvg4IMZRGl9exbexwrKBduooqdjCRZOZsN/ds+PYyQJX5sRRmIhdQgzjkTrCZxfHUj8GIk9XvUIEoCESCv1V0l1ZNLi0EwMcC39nBysrLb2ybe1nkXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721995251; c=relaxed/simple;
	bh=oVLFbpMiPlCmMAMNE+tGeHJKbYbbrzfNiFNSfbDXslo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBOMtlsBjabyHEImMPAawvS7OqDIGy75vxIZ8nijtEVnSrDul23TfdjVpDT7Bka+M2MGc5nr3JrI5FHW5lhcMMnUZWmLs+TVQ7T+YEejRNaWCZXHebECuTIk3vgLqxfl5JP2UYVhRgYt9gLsWa+pqLWq3XEIVFfkn/pPT1BIAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=qj6gQzzY; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WVmYB3Fs6z9t0P;
	Fri, 26 Jul 2024 14:00:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1721995246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rdOu+47Xth5hXKbmOu06fRFiMFY0Pwf2tkrEBizRPk=;
	b=qj6gQzzYjN9Zakp2rV1btHRBF4MwxpplHYSFNtQ3E+vJk34EKw5Sp8/mrqhBBwj1McnfKu
	GBxMa28j4v9xwaS6NioIYBZOh2Df0NSrn+lZrtJyyHecW9F9GX5guzxEYav+Hijg7/Re3S
	Ozy2tLCNgKiVA/H32MKmTQQlN55sZ00Q5fRsEe8nzr01Xj7jELk//lcCP2Dyf0SqIIxzmt
	DMGClEnuHQQnmK8cwbZLuOeB7iqtTwvAEy8BHwzQFS2RuHetelvNnHCoaN4dsiUKxVm4jR
	egGJEghTAqte+Qm9c5NzXkWMAeMQ6p0CAXgJsbt94fT/rGImaNC4iyCCAmgdlw==
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
Subject: [PATCH v11 09/10] xfs: make the calculation generic in xfs_sb_validate_fsb_count()
Date: Fri, 26 Jul 2024 13:59:55 +0200
Message-ID: <20240726115956.643538-10-kernel@pankajraghav.com>
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

Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
make the calculation generic so that page cache count can be calculated
correctly for LBS.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_mount.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 09eef1721ef4f..3949f720b5354 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -132,11 +132,16 @@ xfs_sb_validate_fsb_count(
 	xfs_sb_t	*sbp,
 	uint64_t	nblocks)
 {
+	uint64_t		max_bytes;
+
 	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
 	ASSERT(sbp->sb_blocklog >= BBSHIFT);
 
+	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
+		return -EFBIG;
+
 	/* Limited by ULONG_MAX of page cache index */
-	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
+	if (max_bytes >> PAGE_SHIFT > ULONG_MAX)
 		return -EFBIG;
 	return 0;
 }
-- 
2.44.1


