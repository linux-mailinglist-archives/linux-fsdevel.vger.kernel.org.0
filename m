Return-Path: <linux-fsdevel+bounces-23117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78338927500
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 13:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B611F22BC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 11:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DD81AE0BE;
	Thu,  4 Jul 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="00kjlnBk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808AE1AE0B3;
	Thu,  4 Jul 2024 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092244; cv=none; b=XOwU4LAP5B9fC9HNck/EFuonwzz1lOUBzVT5ri2iZft1R4KE7sRcHb6m3Fl13FLQI1uPBgP/Ltdgf4zHR8PNvri4+/ecyd/L06bKSLBsmsWrdSX5sVtA0B3fOnBzINrvZixoG2Kq6hSLEkPW8NIQHGjsgZv+1/INZ6+tOiiodc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092244; c=relaxed/simple;
	bh=rQAtM3eB+HtmZkc8WZAg2fgPo0lq5IizW+w4WRAf8qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsjoADya8EV7ankc1RsOg22p761los2NykNkOFmJH55078Y7SD7CW8BmbMni4F3i3Q1ZBu6XlwhkswlXuHNjGOok3dsgYOe9ZoaDOSrqWDPIn2DQZtEOiO2qGEeiCn7Nu9LqPmogYSXdVUwO0UK9PAYY3T2tCqRbpGuvZxfCZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=00kjlnBk; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WFDmt3YWKz9sTk;
	Thu,  4 Jul 2024 13:23:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720092238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hpvVZhxiYoy4pHnc2n7weXG4jb43hSIPB2EVq7bVws=;
	b=00kjlnBkN+LFlFpx4Eq52EeamnWssvWwfljypGOm40D8wTb6EFYbFsfO4ZTKtAU+tkUyLD
	imYXE7KY44rOVP91eM+h1IFMWXnWBKPm71KVJaME2OcNTGJAnYRtVHREDEwyK2/Ozp4AIh
	HGejFkLqr9Jh3YeQEVFddQ2fM53b/Aakqd7mMAW1yONbIbr3IYBwcBpb7ULEWNivySKijP
	dBMS+vcw0iEwr6ViD07vvA9/F2AzHkarFSpNnn2fgyWvMFK8N1/T/4AX26a8PJ2RkWRrVG
	3q83gwfRzypqiqPaZxRQZga3SmyJr6cl0RP3UEebVQXHww4CBZ/FCZeVp6shLw==
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
	hch@lst.de,
	Zi Yan <ziy@nvidia.com>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v9 08/10] xfs: expose block size in stat
Date: Thu,  4 Jul 2024 11:23:18 +0000
Message-ID: <20240704112320.82104-9-kernel@pankajraghav.com>
In-Reply-To: <20240704112320.82104-1-kernel@pankajraghav.com>
References: <20240704112320.82104-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WFDmt3YWKz9sTk

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
index a00dcbc77e12b..da5c13150315e 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -562,7 +562,7 @@ xfs_stat_blksize(
 			return 1U << mp->m_allocsize_log;
 	}
 
-	return PAGE_SIZE;
+	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
 STATIC int
-- 
2.44.1


