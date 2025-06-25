Return-Path: <linux-fsdevel+bounces-52864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 218DEAE7A67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19BFF7A3CA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BD527C158;
	Wed, 25 Jun 2025 08:37:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB6820D4E7;
	Wed, 25 Jun 2025 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840639; cv=none; b=Vub0wcinjVz0oTXyassEreTLYYxmL35GsBDyWqQ9cZEkT1TRzOvQG2IfFZhSIka99aLZT6Ib65oCVrVklyIMiX8/OyUlZArhHCi7pB7b+5pSVtlcN7M4sPHvtOk9KdzS+KTnOBNlgAV35eM1AVusPDLTraDk8+yulj7qnLhnh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840639; c=relaxed/simple;
	bh=+ymYFCYyzrhnTDccGkxrXRgCQ9ZpY4v1A/adjJaSuu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ww4NtSamupKUyCq+7raH2CO/pJoXn5ractWNRt6byDqDQZb4O970yhL5+niq6wcz/l57swTjNxb+nVuFF4cwKX1BHqLCtqgTy3mdqzt8BJG6J2aCgyzuqp9sQDZnzIQxNf5JcfvUtsjM6+sHONLJjHqSYhelLwnr+g7v6Voa8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bRwD84mDJz9tWd;
	Wed, 25 Jun 2025 10:37:12 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	mcgrof@kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: kernel@pankajraghav.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gost.dev@samsung.com,
	Pankaj Raghav <p.raghav@samsung.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3] fs/buffer: remove the min and max limit checks in __getblk_slow()
Date: Wed, 25 Jun 2025 10:37:04 +0200
Message-ID: <20250625083704.167993-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bRwD84mDJz9tWd

All filesystems will already check the max and min value of their block
size during their initialization. __getblk_slow() is a very low-level
function to have these checks. Remove them and only check for logical
block size alignment.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
Changes since v2:
- Removed the max and min checks in __getblk_slow().

 fs/buffer.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a14d281c6a74..a1aa01ebc0ce 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1122,13 +1122,9 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 {
 	bool blocking = gfpflags_allow_blocking(gfp);
 
-	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
-		     (size < 512 || size > PAGE_SIZE))) {
-		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
-					size);
-		printk(KERN_ERR "logical block size: %d\n",
-					bdev_logical_block_size(bdev));
-
+	if (unlikely(size & (bdev_logical_block_size(bdev) - 1))) {
+		printk(KERN_ERR "getblk(): block size %d not aligned to logical block size %d\n",
+		       size, bdev_logical_block_size(bdev));
 		dump_stack();
 		return NULL;
 	}

base-commit: 6ae58121126dcf8efcc2611f216a36a5e50b8ad9
-- 
2.49.0


