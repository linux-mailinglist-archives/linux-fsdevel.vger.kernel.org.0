Return-Path: <linux-fsdevel+bounces-52226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B866CAE0522
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 14:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178AA1897EB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB53D230BEC;
	Thu, 19 Jun 2025 12:11:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F53085B2;
	Thu, 19 Jun 2025 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335075; cv=none; b=C7Xb1kea/ZuAtfETus1BHcA/6ptTbG4i+jypIB7zKO9AOIJ6WcH/+ZCsqnrm0/Xe2VfeDdobFY+Eczu4vVA7gCsAgP1PZHpCWZdXGv7ulgABU7DjeOZMksH1gjXjsvSrb0e9K7sjGd7ctuPmMmPGI1gCEwLWpUBcbc1FYW8rzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335075; c=relaxed/simple;
	bh=A2ie+kUQrkB5Lxc2V7zJYm8SbzcSncNfJ5+TypUD6uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LiCz1m+OmEwFoM5T+lE2QC+1A9YRz/BX+OO2CvjzXUghfmtmoEtxQ8VRrqzu7pQtOPVX9N+Af4mH6nxNSQNm9zFVr+KnxZROq2hS95s1fhfBdQDj+/U/nGVXqwpyS7mnOigTbtmE75dkJijy9hSDslamEwrhHuoLJvG5RFlBDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bNKFf55g0z9sWt;
	Thu, 19 Jun 2025 14:11:02 +0200 (CEST)
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
Subject: [PATCH v2] fs/buffer: use min folio order to calculate upper limit in __getblk_slow()
Date: Thu, 19 Jun 2025 14:10:58 +0200
Message-ID: <20250619121058.140122-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bNKFf55g0z9sWt

The maximum IO size that a block device can read as a single block is
based on the min folio order and not the PAGE_SIZE as we have bs > ps
support for block devices[1].

Calculate the upper limit based on the on min folio order.

[1] https://lore.kernel.org/linux-block/20250221223823.1680616-1-mcgrof@kernel.org/

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
Changes since v1:
- Rebased on top of vfs/vfs-6.17.misc as it has a merge conflict.
- Added RVB tag from Jan Kara.

 fs/buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a14d281c6a74..445df839a0f0 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1121,9 +1121,10 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 	     unsigned size, gfp_t gfp)
 {
 	bool blocking = gfpflags_allow_blocking(gfp);
+	int blocklog = PAGE_SHIFT + mapping_min_folio_order(bdev->bd_mapping);
 
 	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
-		     (size < 512 || size > PAGE_SIZE))) {
+		     (size < 512 || size > (1U << blocklog)))) {
 		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
 					size);
 		printk(KERN_ERR "logical block size: %d\n",

base-commit: 6ae58121126dcf8efcc2611f216a36a5e50b8ad9
-- 
2.49.0


