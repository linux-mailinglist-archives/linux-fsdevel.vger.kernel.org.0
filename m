Return-Path: <linux-fsdevel+bounces-22334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4C291668A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6CA1C219F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 11:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E647214F9E0;
	Tue, 25 Jun 2024 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="vx1oCSPH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF0C146A83;
	Tue, 25 Jun 2024 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315911; cv=none; b=Q/xNd3Uul+ZgHL5M2F5eI1V9voaT5PEO3T0LfD1XJN38d8ARuCu0gUJ/mDTjwr8c0p3c5nHzgZ4aP1Ml6Hi1IKQ/AQ1BR80tyvW/kjozqar7VS1vaerxuv4aR46R0If+HgghMU6R6Jaqyg3Shy2ukuG83g3QOIVO+M0RiSycrxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315911; c=relaxed/simple;
	bh=AyfrCN4n2Ja8kvvlvILLd5RRFqJZdgITUeVkIqY60WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+UzYfZ63qgE1g2OlF3uw1TJYr75TwyvC6rA1Mdv0x+QIJHuEo9ac4tzBGeHYcV2ZJdo9Oj9IXG1tRN6WosYRIiMzJ3ifZr4JnvgyoaefDd2STYJsJrXB4uggWYrVCF0Qfgb7rpl0uBQOEkx9LGDuK8L353wpJbyuxHpTRUvMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=vx1oCSPH; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W7jgJ6MTzz9t2m;
	Tue, 25 Jun 2024 13:45:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1719315900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iyy/Uh+tbYC9uCouyOUGcxbKb95j1x/VN4vR3SasgEQ=;
	b=vx1oCSPHzXDRQPX8b0i9M9281m8Y9dOOLXEh58esfpUZkeQ8qW28s1hIC0KrbYg1kLnsh3
	oWAiH1+XP/YA/DwPHuXNj43HGL7MdYMm2In3JAiadupkUDFJk3eOXtt76e4Mwno0lT9WIM
	tPxEcF5ic88JEn7ZdwQvrgVwZYYFUpapyatVmWb/i90WXIE0dkAH/2UeIu9rwYItsz5eEh
	V72EssyWBjmBHvM3d+1n6usIDunh1o3k0ckFx7HIjSpWWYfwDMQLxYN20hEC4xE9uj4MAx
	V0CSExZkXvwCFAwmg8uJYqzFOhAD8rJovBw3MTipYl/qPFf/NFZTdyLHUBYB3Q==
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
	hch@lst.de,
	Zi Yan <zi.yan@sent.com>
Subject: [PATCH v8 09/10] xfs: make the calculation generic in xfs_sb_validate_fsb_count()
Date: Tue, 25 Jun 2024 11:44:19 +0000
Message-ID: <20240625114420.719014-10-kernel@pankajraghav.com>
In-Reply-To: <20240625114420.719014-1-kernel@pankajraghav.com>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W7jgJ6MTzz9t2m

From: Pankaj Raghav <p.raghav@samsung.com>

Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
make the calculation generic so that page cache count can be calculated
correctly for LBS.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/xfs/xfs_mount.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 09eef1721ef4..3949f720b535 100644
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


