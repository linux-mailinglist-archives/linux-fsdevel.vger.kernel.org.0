Return-Path: <linux-fsdevel+bounces-52022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7446ADE66D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 11:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6911D3B1535
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 09:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC862820A4;
	Wed, 18 Jun 2025 09:17:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1C2202F70;
	Wed, 18 Jun 2025 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238247; cv=none; b=Dy9/VYuGIYVqRxC8EdWsBPn6z3inTtKaNlucns71HRiGIpEKFqs1n7Zc6NdM0HAmPlKWFftEFEnhGTaNoiAJqexGKNOIeyi7NvYdfms9aZhk0px+18YmusV7oe07sr9QFQn6XW1NtrnsA9sP1EzGhoDWHWbSiq3gfRjWiA+eK3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238247; c=relaxed/simple;
	bh=4guzzl8+uPUhHITQeQqcp6+BE4ne+X0iPtJ7/i9d4V8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMi5O6PSJtvSrzDfU8BEXo2G2dA5EJkx9y9uTk8fbzbIfCsYdW1gOcRazYC9DQ3JiH2sN/dI3Drxj9yp3Dlc23xNcKxMJdaqynqrAaZ+UT8lZMHT09R6Nvrrw5TaaTi3+Zi4HId2Rxp5azRmDE8g7aXBt0gEClIZ8V1vNymFkKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bMdRc1fpdz9tG4;
	Wed, 18 Jun 2025 11:17:16 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	mcgrof@kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] fs/buffer: use min folio order to calculate upper limit in __getblk_slow()
Date: Wed, 18 Jun 2025 11:17:10 +0200
Message-ID: <20250618091710.119946-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The maximum IO size that a block device can read as a single block is
based on the min folio order and not the PAGE_SIZE as we have bs > ps
support for block devices[1].

Calculate the upper limit based on the on min folio order.

[1] https://lore.kernel.org/linux-block/20250221223823.1680616-1-mcgrof@kernel.org/

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
I found this while I was adding bs > ps support to ext4. Ext4 uses this
routine to read the superblock.

 fs/buffer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8cf4a1dc481e..98f90da69a0a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1121,10 +1121,11 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 	     unsigned size, gfp_t gfp)
 {
 	bool blocking = gfpflags_allow_blocking(gfp);
+	int blocklog = PAGE_SHIFT + mapping_min_folio_order(bdev->bd_mapping);
 
 	/* Size must be multiple of hard sectorsize */
-	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
-			(size < 512 || size > PAGE_SIZE))) {
+	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
+		     (size < 512 || size > (1U << blocklog)))) {
 		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
 					size);
 		printk(KERN_ERR "logical block size: %d\n",

base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
-- 
2.49.0


