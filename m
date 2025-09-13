Return-Path: <linux-fsdevel+bounces-61206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FBEB56047
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 12:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B895679ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 10:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2292EAB96;
	Sat, 13 Sep 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oQZyTZbN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFBD25785D
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757760025; cv=none; b=TfVy1izdIE3cYrjU6+/PNB9GeFowsVZSoXyhTTgKFPKOaKYE+jn/PAvlmGD3fXCJDceOUNG3Ybwh32Tz6LSjU6Hcd75pk2X9U5XbOfJ9Dfx/IcpeIWlJ0vZ3ESfnY6QeQPUTXuiZrjw4fdO3WGQAxhSHM+ob6qT5eP+hUHe64Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757760025; c=relaxed/simple;
	bh=7kwY4K3spBa+KkC0kt2vnh741tWhEjIo0BO1Ky8KVtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxDwcGltKNX3E9HAkuxnZf7mIzcEIiChoiixgLpLnbUNm8jfIb/v3LxKE1c+Ut8P6kqgKqd+VSIWvzXkX+hSApoRBSt+hZQ31NraWZEjh1+ez0fIp5X/1h1BMoWGbgl8PpGRbP3T7LTbvCFZIW3XhDXXlPcUnbN39Vsgw2AI05o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oQZyTZbN; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757760021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bROeHm5yLYSDjWrQN66sseRBMeR9fQM3QsxmZdeOcXQ=;
	b=oQZyTZbNyW/V3QofscmZ36jTcOBrwoxdDW+F5I4yeeWfEE1HrGuUapma1InOUtDCIgIfgh
	yZSf1e8xOKvILCOIH80InZ9gQD48TeJYYVo9aT89UPE9YEvcYy3um3oqYKkSdqdyc+qrOK
	P7QFy8e6rOatT2OcdhZJs6RPaKzAZ1M=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] initrd: Fix logged Minix/Ext2 block numbers in identify_ramdisk_image()
Date: Sat, 13 Sep 2025 12:39:54 +0200
Message-ID: <20250913103959.1788193-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Both Minix and Ext2 filesystems are located at 'start_block + 1'. Update
the log messages to report the correct block numbers.

Replace printk(KERN_NOTICE) with pr_notice() to avoid checkpatch
warnings.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 init/do_mounts_rd.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa..9283fdd605f0 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -148,9 +148,8 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	/* Try minix */
 	if (minixsb->s_magic == MINIX_SUPER_MAGIC ||
 	    minixsb->s_magic == MINIX_SUPER_MAGIC2) {
-		printk(KERN_NOTICE
-		       "RAMDISK: Minix filesystem found at block %d\n",
-		       start_block);
+		pr_notice("RAMDISK: Minix filesystem found at block %d\n",
+			  start_block + 1);
 		nblocks = minixsb->s_nzones << minixsb->s_log_zone_size;
 		goto done;
 	}
@@ -158,9 +157,8 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	/* Try ext2 */
 	n = ext2_image_size(buf);
 	if (n) {
-		printk(KERN_NOTICE
-		       "RAMDISK: ext2 filesystem found at block %d\n",
-		       start_block);
+		pr_notice("RAMDISK: ext2 filesystem found at block %d\n",
+			  start_block + 1);
 		nblocks = n;
 		goto done;
 	}
-- 
2.51.0


