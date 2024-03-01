Return-Path: <linux-fsdevel+bounces-13314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A823F86E64A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FEB1C24CA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 16:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ED975803;
	Fri,  1 Mar 2024 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="nwU+P+9a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DCC74E1B;
	Fri,  1 Mar 2024 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311534; cv=none; b=IWzlGKWpD7FjLcgqSoyrMy8D1Up4WgnrV23qtug9aanedwZC8HT6aE2OQUjirO+oSAzfT4ULqIblHbHkuzv2mvTwr2PbRjkjeZxaSQeBhIMwG5FL6DRpRhT/zdcAHSKZAXHcoQr2XA434M+bXrczTKJvKbDEYJKKx9I8Zh82lPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311534; c=relaxed/simple;
	bh=TxlF0K0AnCi7IfUOf9fZ9W/wQu6fwrGsP17GgzEpFC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXWPNRy/YiVjsNKMRffI88j/pOGBGOjY9jivCGxpBqcc6FSRSQDyGLJ5Iq5DdyTXl45buN1svVV+16XotBE87R+5d2qXUVy2E8tz4jvPDVUYzt8t9RUJSAt/8TOxkHgPHPd+/a1VKc9adTDo+nNOU8YGReQajJ3m93PWH0UJcP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=nwU+P+9a; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TmYqY3ft9z9tW7;
	Fri,  1 Mar 2024 17:45:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709311529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHOAd9x0YRVSd/dvnN0auN+I3KtosAxaAU4ZYQzup9I=;
	b=nwU+P+9a3uF5NA7u6ijpi6mGj8WO2v/jjNlHzx7ZxLokEZE5PEgAPYYwNjrPK+Tms9wLwQ
	Pyz3Y6zKfMOGrh0h2VqWh2Xebs6ECkTHOJxrSP7lJmYSxooolgOm898sH7IfMtja4+xGbf
	QGn8iUq+WZZldhVy+gb1dxTa7Ny3C2BlNxq8eJnkFSDSoR0286+8t8p0UrDuC+8w/zds3S
	J+TgIDqaXHtYS/JGkjQDAQcq9WsaFH8ovt/DcyClf+Qc4mFxK3M8JiIMBwy0/MNjgfSVTg
	I9Fss6QCWHr13cCBIdBsFbx2KvYCliOGQ3dKcsxyAWzBWPURp+SXGtiqkS2XGA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: djwong@kernel.org,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	hare@suse.de,
	david@fromorbit.com,
	akpm@linux-foundation.org,
	gost.dev@samsung.com,
	linux-kernel@vger.kernel.org,
	chandan.babu@oracle.com,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 12/13] xfs: make the calculation generic in xfs_sb_validate_fsb_count()
Date: Fri,  1 Mar 2024 17:44:43 +0100
Message-ID: <20240301164444.3799288-13-kernel@pankajraghav.com>
In-Reply-To: <20240301164444.3799288-1-kernel@pankajraghav.com>
References: <20240301164444.3799288-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TmYqY3ft9z9tW7

From: Pankaj Raghav <p.raghav@samsung.com>

Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
make the calculation generic so that page cache count can be calculated
correctly for LBS.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/xfs/xfs_mount.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index aabb25dc3efa..9cf800586da7 100644
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
2.43.0


