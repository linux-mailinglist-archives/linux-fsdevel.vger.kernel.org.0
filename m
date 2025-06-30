Return-Path: <linux-fsdevel+bounces-53320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C542BAED987
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 12:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9467A9BD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E0B247287;
	Mon, 30 Jun 2025 10:15:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9721A76DE;
	Mon, 30 Jun 2025 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278521; cv=none; b=AHOxwNQdOaYgAH9ZKNGywN2nRWhpkIWi30bNCI2QGPY+TIdOxapn3go+fT2FuRGg1CY1QW6U1dWc00Ue+VO7IeHmRPv0ClEDPJyzg1iwFItmB+NKI1OR4siJjg6oIL91LLNMPFQO7M7J/hIe3VQ3UF7SATdbf1+nY6jsVG/y/uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278521; c=relaxed/simple;
	bh=y/4YjTLWuIy0IC8lYRZeKfAEdR7HI1gNocKw3PUC0G4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQY791xGa1q8vYfRYl7t+vlrxxPEweusCgbwgakkbXXBij6CNi6QwX+6F+FI8z1UTavOdvWs+To2ecAJDlvhOUujsxOyZVDT6ff6pVlM7fIojS4e1h86qwXUPy8o1rzuUyAjsv/WNFB9aXnbi8c2vvJ/6/OcC2vEsLdkHgHYEJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bW28z4SQ0z9syT;
	Mon, 30 Jun 2025 12:15:15 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	mcgrof@kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: Baokun Li <libaokun1@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	Zhang Yi <yi.zhang@huawei.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] fs/libfs: don't assume blocksize <= PAGE_SIZE in generic_check_addressable
Date: Mon, 30 Jun 2025 12:15:09 +0200
Message-ID: <20250630101509.212291-1-p.raghav@samsung.com>
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

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/libfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 4d1862f589e8..81756dc0be6d 100644
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
+	if ((blocksize_bits < 9))
 		return -EINVAL;
 
 	if ((last_fs_block > (sector_t)(~0ULL) >> (blocksize_bits - 9)) ||

base-commit: b39f7d75dc41b5f5d028192cd5d66cff71179f35
-- 
2.49.0


