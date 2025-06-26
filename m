Return-Path: <linux-fsdevel+bounces-53081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1629BAE9C8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 13:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB931C26F99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 11:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F575275100;
	Thu, 26 Jun 2025 11:32:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1101DE2DC;
	Thu, 26 Jun 2025 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750937564; cv=none; b=gTpXyNhjPv/r+uz0TEbVmit7sKif940w/t+hXvSqRK3O7ryO8Kxvqlnhd5Z6xj2G8fKjku844Hy2zw7A7Kt3oiFcef4g5LEh4Kac3m+D+4W1Mhy5ydu4fR7Wh/Fy/Z9u01/G/aBTJ3icjD2xcZdsdKEAg2vCUefxLyMcVoeeCm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750937564; c=relaxed/simple;
	bh=cDQe/RO/gOW6Up5JUtL30QugNGUwFodfimvzdFGHspU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I45X9oq1pD8xqp8feGs5GDIgWrnAdXnQcAj18nn4MhgT1GYmgCFYEyhFNx1bKefA/rLsLxujYmuPk6ahTmRfXbW5STQbfupPSK2MscHY+Jh2tqfzRosCcp7ezj1W8JKReOIQCkqe7MdrrVJCkU+dp4l1r/frTUbla0j4ke0jDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bSc410RZSz9tc3;
	Thu, 26 Jun 2025 13:32:33 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	mcgrof@kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel@pankajraghav.com,
	gost.dev@samsung.com,
	Pankaj Raghav <p.raghav@samsung.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4] fs/buffer: remove the min and max limit checks in __getblk_slow()
Date: Thu, 26 Jun 2025 13:32:23 +0200
Message-ID: <20250626113223.181399-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All filesystems will already check the max and min value of their block
size during their initialization. __getblk_slow() is a very low-level
function to have these checks. Remove them and only check for logical
block size alignment.

As this check with logical block size alignment might never trigger, add
WARN_ON_ONCE() to the check. As WARN_ON_ONCE() will already print the
stack, remove the call to dump_stack().

Suggested-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
Changes since v3:
- Use WARN_ON_ONCE on the logical block size check and remove the call
  to dump_stack.
- Use IS_ALIGNED() to check for aligned instead of open coding the
  check.

 fs/buffer.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d61073143127..565fe88773c2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1122,14 +1122,9 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 {
 	bool blocking = gfpflags_allow_blocking(gfp);
 
-	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
-		     (size < 512 || size > PAGE_SIZE))) {
-		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
-					size);
-		printk(KERN_ERR "logical block size: %d\n",
-					bdev_logical_block_size(bdev));
-
-		dump_stack();
+	if (WARN_ON_ONCE(!IS_ALIGNED(size, bdev_logical_block_size(bdev)))) {
+		printk(KERN_ERR "getblk(): block size %d not aligned to logical block size %d\n",
+		       size, bdev_logical_block_size(bdev));
 		return NULL;
 	}
 

base-commit: b39f7d75dc41b5f5d028192cd5d66cff71179f35
-- 
2.49.0


