Return-Path: <linux-fsdevel+bounces-53324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65374AEDA09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 12:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21813AE52B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 10:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E76257452;
	Mon, 30 Jun 2025 10:40:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BFE2475CB;
	Mon, 30 Jun 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280029; cv=none; b=jQdKhiUdYh9Nd3G7NdEo/u2KLhMXoxQi8ItCqj3XljgP5B6fN8QONUtmGhnyDB64aB+Dx0Xev1oOIn3iQ8B2bgWExZmxnC9asDJ9A2PTcJHo+GaxZOQWodFP6bqqJrRgRXeQGf3dElik0r9Drm+j33GZC7oQ7nUiJxFtvO+wD54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280029; c=relaxed/simple;
	bh=7eOYym6I7H8HHs2QY52x9mBtw9X9NrH9Lscp9i8ZlT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5jbQbPsbxSuUUpZRZ1upw4CDCTZXqYgfchvUnfO7Oe7A6uoTsXOC5pT2SnHhYnCIwNQA7Zp25RHNGF4iiWUquppLFROFDkHvNB9DRf1wGYl4PdDQ1jFVK3CyXzTVtyyWGTmlqY1YhcokUbGh9WVpqwiynGx+CUem7MPqo/4Ib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bW2jz4364z9svm;
	Mon, 30 Jun 2025 12:40:23 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	mcgrof@kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: Baokun Li <libaokun1@huawei.com>,
	linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	Zhang Yi <yi.zhang@huawei.com>,
	linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2] fs/libfs: don't assume blocksize <= PAGE_SIZE in generic_check_addressable
Date: Mon, 30 Jun 2025 12:40:18 +0200
Message-ID: <20250630104018.213985-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since [1], it is possible for filesystems to have blocksize > PAGE_SIZE
of the system.

Remove the assumption and make the check generic for all blocksizes in
generic_check_addressable().

[1] https://lore.kernel.org/linux-xfs/20240822135018.1931258-1-kernel@pankajraghav.com/

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
Changes since v1:
- Removed the unnecessary parantheses.
- Added RVB from Jan Kara (Thanks).

 fs/libfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 4d1862f589e8..f99ecc300647 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1584,13 +1584,17 @@ EXPORT_SYMBOL(generic_file_fsync);
 int generic_check_addressable(unsigned blocksize_bits, u64 num_blocks)
 {
 	u64 last_fs_block = num_blocks - 1;
-	u64 last_fs_page =
-		last_fs_block >> (PAGE_SHIFT - blocksize_bits);
+	u64 last_fs_page, max_bytes;
+
+	if (check_shl_overflow(num_blocks, blocksize_bits, &max_bytes))
+		return -EFBIG;
+
+	last_fs_page = (max_bytes >> PAGE_SHIFT) - 1;
 
 	if (unlikely(num_blocks == 0))
 		return 0;
 
-	if ((blocksize_bits < 9) || (blocksize_bits > PAGE_SHIFT))
+	if (blocksize_bits < 9)
 		return -EINVAL;
 
 	if ((last_fs_block > (sector_t)(~0ULL) >> (blocksize_bits - 9)) ||

base-commit: b39f7d75dc41b5f5d028192cd5d66cff71179f35
-- 
2.49.0


