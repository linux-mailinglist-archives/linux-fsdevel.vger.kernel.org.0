Return-Path: <linux-fsdevel+bounces-23675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 377659311A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 11:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A71284645
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 09:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9E0189F2E;
	Mon, 15 Jul 2024 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="LjKjycMp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD03187355;
	Mon, 15 Jul 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036758; cv=none; b=oaGSUPOa/VwRSPm4DBTkxN66BbAVgglUTnv7UHrdB06N7ah4eigWpz76+vEVB73l8YXfiGCJO9fnOSH0AgFhizn7bWEnCKQ3mNRGmlpvQgSu4stjyPVNq6gBLNafcK+j7PCPI+vWWs87vdDmXN8Bju9YlmpgyrC9mSyt/ytyot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036758; c=relaxed/simple;
	bh=oVLFbpMiPlCmMAMNE+tGeHJKbYbbrzfNiFNSfbDXslo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWSb8VGshhGyXfCRs3sZaUTALX/nEM7WxBmeci7u+rNA2atC1+Ozu7hYjeRy8/tLzGe2F02TakXMyexJ//3Le7PIXtbUuZs1XSFv+zkRflLnV5L+SVm71X79S1IYA6kFoZSyGLRp/j45Bm05FY8eyuo85Hz7CoDHHKmieQVb18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=LjKjycMp; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WMy4X3K9Nz9sSR;
	Mon, 15 Jul 2024 11:45:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1721036748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rdOu+47Xth5hXKbmOu06fRFiMFY0Pwf2tkrEBizRPk=;
	b=LjKjycMp1JEsvMEyQlRKY5b/IKkTDm817V3NAYJL7hkSwZxP8p0DtgxH5w0EzV+A3e8FeM
	JgyJbWsnMJ0ZfuAPMJShVoGTe68pSeNk1rmVA17mRSdMS9NAFECJUUrgXDX7B9FzXlwp4v
	dpgEJZg8kbjiCzq0n/dCNmzooXD0JNv8a2+fCuDng9DC6lJ8J7up51X4kjlyHP7koCSBno
	fgOPG0ASE7GOusgq/KlzStXXfMBbPnkM6bhdB1B9oM3+UoPWjir3nzjxHZYQJF4QktB+/s
	j8trDYX3s1AYR5wqHb3hZWnNV7YSZ8CHiQp1ZrcUgzruRmiPVt3ffkTRsiwEUA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	willy@infradead.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	brauner@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com,
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
Subject: [PATCH v10 09/10] xfs: make the calculation generic in xfs_sb_validate_fsb_count()
Date: Mon, 15 Jul 2024 11:44:56 +0200
Message-ID: <20240715094457.452836-10-kernel@pankajraghav.com>
In-Reply-To: <20240715094457.452836-1-kernel@pankajraghav.com>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
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


