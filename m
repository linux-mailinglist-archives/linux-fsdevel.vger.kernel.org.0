Return-Path: <linux-fsdevel+bounces-14309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F40C987AF28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF52287553
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB6C199F19;
	Wed, 13 Mar 2024 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="1zEwGmy7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75852199EE0;
	Wed, 13 Mar 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349421; cv=none; b=knU55o38ajZYS5fRaxmjiX7cvLtBqjqqbovMrqS6UXnjrvIHjMbOdamkCII8nzJq9wZzVaUXDO5ULMcVbPXBKEsIPE8A4ZcjIaYmPWMPpv1xJMzWOnD4b+HfLX8kw8hnXZoOlfl4OZKivWz6RSSVOsiRtXL7VRyu4xjKK45dd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349421; c=relaxed/simple;
	bh=TxlF0K0AnCi7IfUOf9fZ9W/wQu6fwrGsP17GgzEpFC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWC1rdfrPmfReqh5YJNYh1VWN7eAWNmZpnz11YLiTi2LejLq355xxlTQ1ZU030hez4YxcqvAJSj82774S7K4Y3lR2c4gOT0Y0SsnfwQaXjQcctswKBK8kLbAylN5u3EEAXEln7OhbBPZsbtK/bUlvd5g0zu1mmkdKO17Xox3HlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=1zEwGmy7; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Tvxfv74R3z9sv7;
	Wed, 13 Mar 2024 18:03:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1710349416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHOAd9x0YRVSd/dvnN0auN+I3KtosAxaAU4ZYQzup9I=;
	b=1zEwGmy7yxhQYT3bkSq+Y8tjRwEtpGIPiHQ8HX5SqWTyU5bCefTd7tYonFqfWq0MxoazNT
	i1/Ype9sIPvQXhYTGeDAgZoWccjAL5Hbcf1jIb7liUIkQV/KMPw7lD+vBdoencCUyBPe1+
	VV0IO2fa1GoA3/Do51YEVKmtxtA6DXma9yKGF2hRt0kYlOrbAveBmUDcOmOxein9DrCrDP
	qPSRtgjqeFNZcuS9xLxEs0rJ4sFa7UUBFedirfY334tlBRmQDPCL/9qk0OeJGPCtw+OoaP
	RxOray1t/hXKdF8nnZEEVcAHMRsZgZocGVm8E0eSVcjKNjMZVsTJ0K9WwqtvNQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: gost.dev@samsung.com,
	chandan.babu@oracle.com,
	hare@suse.de,
	mcgrof@kernel.org,
	djwong@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	akpm@linux-foundation.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 10/11] xfs: make the calculation generic in xfs_sb_validate_fsb_count()
Date: Wed, 13 Mar 2024 18:02:52 +0100
Message-ID: <20240313170253.2324812-11-kernel@pankajraghav.com>
In-Reply-To: <20240313170253.2324812-1-kernel@pankajraghav.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
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


