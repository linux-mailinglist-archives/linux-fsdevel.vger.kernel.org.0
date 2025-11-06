Return-Path: <linux-fsdevel+bounces-67309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B09FC3B514
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 14:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF511AA3F5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 13:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454BC339716;
	Thu,  6 Nov 2025 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d7TWaYt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59CD338F45;
	Thu,  6 Nov 2025 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436153; cv=none; b=dYm/10d2BsFv2yehdR9JuWG9aRAR9e9H6rSUb/5hOTHjU4SDiVsBtJXA63hQTQfXiewZiF5VLPpsfbeInxYDpVDPVviZ+s0ln7oClb1F9L5J4wefCbL5UHh2/dHROS7RvUcjHk9NCLwvvTbwh0i5TKkGer2WuTzK4XhJ+nZ8nU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436153; c=relaxed/simple;
	bh=H9PjB1BOQvcWVXcQuw6Cj0DkLIusSBIbCtYE3cjTE4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSiMVMDTUj//onjYYT16dQm/2E4yDr/itt7HlTrAf97vMMFrdmVIr7ZmvB6CSvVZ8kmV6V3clFLOs8kumoTA0UOoWWGRNhPqDfJPxWVzIx9Abn/vtLfPKaj1aPUi3NLBFt9V0zTuYMzPxruS/M47RaOUR9UQ+prjzOMLFdRKFIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d7TWaYt3; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762436152; x=1793972152;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H9PjB1BOQvcWVXcQuw6Cj0DkLIusSBIbCtYE3cjTE4s=;
  b=d7TWaYt3aTOK64F49rx5pvvUI/BqV+l/SGtXc44mq1emOh/xzPAczWgy
   DJRmAlqSkD+69cI4/QgmMeIwZHZwe1/3UqTRWNmTfSV6F0BAhFBjUWMjc
   dPrBNoerdjxJjPlLlzfx8AtipKPeJA8n9GBgOlBRsuTzOapJvoP86YxOy
   jtQUeqHjTz+efMP/EjcCpFdbHuC461uo/l+5eA/c8lTsJ8H1+ko51v0E9
   I1La7JvfjGHHx0OX+1VacCffGw0FW0cbhaUiu0jvNmLVtsXHKiw1n6D2B
   leXvmzU9gpZ3i49AiRe8vJjiAAAGtsjdbeFCRyRD1BrvW4A0QuoPVs/Ge
   Q==;
X-CSE-ConnectionGUID: ZwPoesHHRfCVREHTGYY0fQ==
X-CSE-MsgGUID: /2j6E4vqSaaR0Ij3ZmtG0A==
X-IronPort-AV: E=Sophos;i="6.19,284,1754928000"; 
   d="scan'208";a="131604209"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2025 21:35:51 +0800
IronPort-SDR: 690ca437_T//LLX04QeiRo31wTtWAZsU7PYy2ZY2aUGw7Dw4tYuWBmud
 CzR/qjSJiO9zt8/oat0peH3eBgfCbUggXha1hJA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2025 05:35:51 -0800
WDCIronportException: Internal
Received: from wdap-elfv1o5mea.ad.shared (HELO gcv.wdc.com) ([10.224.178.11])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Nov 2025 05:35:48 -0800
From: Hans Holmberg <hans.holmberg@wdc.com>
To: linux-xfs@vger.kernel.org
Cc: Carlos Maiolino <cem@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org,
	Hans Holmberg <hans.holmberg@wdc.com>
Subject: [RFC] xfs: fake fallocate success for always CoW inodes
Date: Thu,  6 Nov 2025 14:35:30 +0100
Message-ID: <20251106133530.12927-1-hans.holmberg@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't support preallocations for CoW inodes and we currently fail
with -EOPNOTSUPP, but this causes an issue for users of glibc's
posix_fallocate[1]. If fallocate fails, posix_fallocate falls back on
writing actual data into the range to try to allocate blocks that way.
That does not actually gurantee anything for CoW inodes however as we
write out of place.

So, for this case, users of posix_fallocate will end up writing data
unnecessarily AND be left with a broken promise of being able to
overwrite the range without ending up with -ENOSPC.

So, to avoid the useless data copy that just increases the risk of
-ENOSPC, warn the user and fake that the allocation was successful.

User space using fallocate[2] for preallocation will now be notified of
the missing support for CoW inodes via a logged warning in stead of via
the return value. This is not great, but having posix_fallocate write
useless data and still not guarantee overwrites is arguably worse.

A mount option to choose between these two evils would be good to add,
but we would need to agree on the default value first.

[1] https://man7.org/linux/man-pages/man3/posix_fallocate.3.html
[2] https://man7.org/linux/man-pages/man2/fallocate.2.html

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 fs/xfs/xfs_bmap_util.c | 15 ++++++++++++++-
 fs/xfs/xfs_file.c      |  7 -------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 06ca11731e43..ff7f6aa41fc8 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -659,8 +659,21 @@ xfs_alloc_file_space(
 	xfs_bmbt_irec_t		imaps[1], *imapp;
 	int			error;
 
-	if (xfs_is_always_cow_inode(ip))
+	/*
+	 * If always_cow mode we can't use preallocations and thus should not
+	 * create them.
+	 */
+	if (xfs_is_always_cow_inode(ip)) {
+		/*
+		 * In stead of failing the fallocate, pretend it was successful
+		 * to avoid glibc posix_fallocate to fall back on writing actual
+		 * data that won't guarantee that the range can be overwritten
+		 * either.
+		 */
+		xfs_warn_once(mp,
+"Always CoW inodes do not support preallocations, faking fallocate success.");
 		return 0;
+	}
 
 	trace_xfs_alloc_file_space(ip);
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 2702fef2c90c..91e2693873c0 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1312,13 +1312,6 @@ xfs_falloc_allocate_range(
 	loff_t			new_size = 0;
 	int			error;
 
-	/*
-	 * If always_cow mode we can't use preallocations and thus should not
-	 * create them.
-	 */
-	if (xfs_is_always_cow_inode(XFS_I(inode)))
-		return -EOPNOTSUPP;
-
 	error = xfs_falloc_newsize(file, mode, offset, len, &new_size);
 	if (error)
 		return error;
-- 
2.34.1


