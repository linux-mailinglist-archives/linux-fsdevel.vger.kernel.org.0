Return-Path: <linux-fsdevel+bounces-17744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086308B207E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA82A282480
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA7512DD83;
	Thu, 25 Apr 2024 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="iUOZlanZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19FD12D757;
	Thu, 25 Apr 2024 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045115; cv=none; b=BhACvAIeRT195VFcyEsiDr/S7FljJRGoD9hPkeHM7PtsJaQPmmJq8kvzSuQX6fQuGMqzspLiBsPyDssodDo4k/0GmMjIkWEq57ehk5qx/hJpp6FDsoZDXMkY7Cup2xt3zP3bQUoZdLkv6WxFg5BJomAyCfJPUFs3q4anqg+53tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045115; c=relaxed/simple;
	bh=LOG1uIi2Kur+Bl8EXQ2K17O8DkU858vtOXODZaKzses=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3BnmdqUUHSVx306rxnsr12jtDmpVqsv7jbTdGo1gAdubtk095hToR38KiiyUNUh0xFvcB/Pm9eX9lVh30aQKj2PMh3369xLsy9zswfTMi7cU/uNR2W64g4R65qMtasFf2HMrN5Pioe/KyujKRBsMLqLNhUi34iW5XNzbg9nCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=iUOZlanZ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VQDPy34JRz9s7Q;
	Thu, 25 Apr 2024 13:38:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714045110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7L6awWLepRreCjOlDARDMkw2Tlyq8BMiql1zMtjdTDw=;
	b=iUOZlanZ2C3/jZz2S8ABbp1qPpO2hBWafHSyLzmGwpJXYKBBM8sP2yDLliwXN8E31p5Sm8
	pXxktiBVBG9c/vnRc3jIanZQ7+QirXLJ4CE+3CC+ctJRrk5MY5schTRVXhHiQTLxJkV4RO
	c/tOp1e03rMQKQ/PQfLmkA1ODo58Njdtw8zsPmf0KQum0MFlRpkd6Qyf+RN49/2sImpc/b
	4mMPhHbF5Z9qmwgtpMU2ltkFqJdHcPvxkiocluP7yumz76XrCgrCJcQXZtH24p6XHSkbhI
	hGXfFkOa6pEt/ZQyEsK/MDTurV+oXp9dwW14zJA9Q5DjnJhld/76witYmemPeg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	djwong@kernel.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: [PATCH v4 10/11] xfs: make the calculation generic in xfs_sb_validate_fsb_count()
Date: Thu, 25 Apr 2024 13:37:45 +0200
Message-Id: <20240425113746.335530-11-kernel@pankajraghav.com>
In-Reply-To: <20240425113746.335530-1-kernel@pankajraghav.com>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
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
 fs/xfs/xfs_mount.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index df370eb5dc15..56d71282972a 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -133,9 +133,16 @@ xfs_sb_validate_fsb_count(
 {
 	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
 	ASSERT(sbp->sb_blocklog >= BBSHIFT);
+	uint64_t max_index;
+	uint64_t max_bytes;
+
+	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
+		return -EFBIG;
 
 	/* Limited by ULONG_MAX of page cache index */
-	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
+	max_index = max_bytes >> PAGE_SHIFT;
+
+	if (max_index > ULONG_MAX)
 		return -EFBIG;
 	return 0;
 }
-- 
2.34.1


