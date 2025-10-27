Return-Path: <linux-fsdevel+bounces-65687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C40C0C9F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 10:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED873BCCBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 09:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0DA2E9EB2;
	Mon, 27 Oct 2025 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="trvEWBip"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77232E5B08
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556571; cv=none; b=OJUFKQiISJnllSRhmpVWzvaXKrh+pmziVQhCnIWgv4oZFlzyRHjY22ZwiuD0X3hZ00sKsdvD0EUDeW1kyyYQBqKzAtzPDGuwM5lMtAfmu/5bu6gKLKeolDHdd6DYMzg8I1+zxf4y4fPR/AC3Gwi0m1v/IazYjp39fchzFnbewfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556571; c=relaxed/simple;
	bh=l0YDN5/qAZwEiZo+g6rYu60+lcisIhOsveEpfjVujx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saN6utlyoyoWyTnk93OVfr2lTq5G12YHItrk2jgkZOs91TNdo7SK+Rj5jzg4T1PM8zceArtnHi/NXNOomuzdFX8Hapk/NlWmMT8UPmCC6T2e3VYGdtRVpK+sdmzgPbS4qZEvwA4VqCSUMGL+9eJZRG7Xmn4ZE0meyWOXBSuR9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=trvEWBip; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1761556566; x=1793092566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u+LYL+QwYPRjlpJN4R95LEKZaZQ1wZgY9QdXtwl3ixQ=;
  b=trvEWBipu1pXwI4bZORHSELhLLGuoSoaJX261ekzqlkRm6fObK2aiPTa
   A4yPlnBmLCr/q1NA3Ap94VswlFPp9yDTjrjjRM1xDQRH8i3zEofIFQEtQ
   IsucRV1D91qctM/RuYovYHn0blAAr490VfZqqYn8QdUI4hP8tCjx/7lcw
   JQRAOUkIwnwjImRtUeeojAreY1bgSc/YR92fZ3WecVJQSdDcKnwQnkFyH
   UMor0hj7eeVwuk8OHAGpSG6UBbhhFRG4kelU1BDQDqQTJyiE2VKyrGUlk
   PpAFpXXOzMR5+Dd3w1FxWNm9G1EKcRQsLijUiqahsKIp7CvP77px9MOtJ
   A==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 18:05:56 +0900
X-IronPort-AV: E=Sophos;i="6.19,227,1754924400"; 
   d="scan'208";a="51569546"
Received: from unknown (HELO cscsh-7000014390..) ([43.82.111.225])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 27 Oct 2025 18:05:56 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1] exfat: zero out post-EOF page cache on file extension
Date: Mon, 27 Oct 2025 17:03:41 +0800
Message-ID: <20251027090340.2417757-2-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfstests generic/363 was failing due to unzeroed post-EOF page
cache that allowed mmap writes beyond EOF to become visible
after file extension.

For example, in following xfs_io sequence, 0x22 should not be
written to the file but would become visible after the extension:

  xfs_io -f -t -c "pwrite -S 0x11 0 8" \
    -c "mmap 0 4096" \
    -c "mwrite -S 0x22 32 32" \
    -c "munmap" \
    -c "pwrite -S 0x33 512 32" \
    $testfile

This violates the expected behavior where writes beyond EOF via
mmap should not persist after the file is extended. Instead, the
extended region should contain zeros.

Fix this by using truncate_pagecache() to truncate the page cache
after the current EOF when extending the file.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
---
 fs/exfat/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index f246cf439588..c9901a8cfe94 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -25,6 +25,8 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_chain clu;
 
+	truncate_pagecache(inode, i_size_read(inode));
+
 	ret = inode_newsize_ok(inode, size);
 	if (ret)
 		return ret;
@@ -638,6 +640,9 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	inode_lock(inode);
 
+	if (pos > i_size_read(inode))
+		truncate_pagecache(inode, i_size_read(inode));
+
 	valid_size = ei->valid_size;
 
 	ret = generic_write_checks(iocb, iter);
-- 
2.43.0


