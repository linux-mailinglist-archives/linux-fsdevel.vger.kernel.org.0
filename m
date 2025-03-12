Return-Path: <linux-fsdevel+bounces-43755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79586A5D533
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 06:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F8916D4A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 05:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1EB1DD9AD;
	Wed, 12 Mar 2025 05:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t/IlGc//"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531723595E;
	Wed, 12 Mar 2025 05:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741755641; cv=none; b=CA1ojzRhKIZ68/lVPBakwsATQq4oxKH35pnVfz0JeizpQBmFUSRK7YTnTmbcEdNb1YYnvXlaExUmZ21rVeAoHYMQZb1wW4lqGPv2KvXKIIaepsH8CbztNgettCWMkNU8F4uSxETbuZx+f4r+VOMIuppL4t+a6ESBg/NlMfvyZhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741755641; c=relaxed/simple;
	bh=OkfWCX8RTVVm9tKf1VzdYkRl9gs9wdSCj7hmibIgeMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpnzfJfxL7v8tH1i+ZWTRQMyFdKhJ5hRYAW3RUMDZHwukXRn/7jRrxti/3JrOWkQrZDg9G9oDoWuj9BsvQf1NaHoGrf3TZosbsO8mACyLVfuwkI4wCPykzpzdRtQjKSXtetIP3QWGRImqF+lo3d5XmXPqEPndsYqssWpZ3moYAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t/IlGc//; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=4VfUOjWo+32AuDiC0iqDr/l/PZ8nRE39G5zh1X+A1H0=; b=t/IlGc//5oKhH6cZ8+VHa8bIfM
	tvt1u6yhti395QXHvt9kcozQoMQbFXQZouoDZl+V2ogFnAQJqk/1QHNdwflgIwO/UhbQY6ft0lyU2
	6MpOs3RjEmatQ+7feZOUZaGhmt7nC11d8dLCRfIC7urgrHjiypoz6KwayU8iq8yAdeGDDc0t/BBIl
	epyGrqE59e6CTlhp4neui5oR2SlfVz3+AaYwkHb+AOyhJgu9BMAf5VKZhHlIWc8C4S6MQymNXAD84
	BcObPxnc+TcSehPM8PIDNsHyDEHH1zfY6rxeGK6Rf6liXSVNtNB3icLV8j33REoK6YIPEBIbrN6F7
	CrPzSN/Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsECj-00000007U8E-2579;
	Wed, 12 Mar 2025 05:00:29 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: liwang@redhat.com,
	brauner@kernel.org,
	hare@suse.de,
	willy@infradead.org,
	david@fromorbit.com,
	djwong@kernel.org
Cc: kbusch@kernel.org,
	john.g.garry@oracle.com,
	hch@lst.de,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	ltp@lists.linux.it,
	lkp@intel.com,
	oliver.sang@intel.com,
	oe-lkp@lists.linux.dev,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH] block: add BLK_FEAT_LBS to check for PAGE_SIZE limit
Date: Tue, 11 Mar 2025 22:00:28 -0700
Message-ID: <20250312050028.1784117-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

The commit titled "block/bdev: lift block size restrictions to 64k"
lifted the block layer's max supported block size to 64k inside the
helper blk_validate_block_size() now that we support large folios on
the block layer. However, block drivers have relied on the call for
queue_limits_commit_update() to validate and ensure the logical block
size < PAGE_SIZE.

We should take time to validate each block driver before enabling
support for larger logical block sizes, so that those that didn't
have support stay that way and don't need modifications.

Li Wang reported this as a regression on LTP via:

testcases/kernel/syscalls/ioctl/ioctl_loop06

Which uses the loopback driver to enable larger logical block sizes
first with LOOP_CONFIGURE and then LOOP_SET_BLOCK_SIZE. While
I see no reason why the loopback block driver can't support
larger logical block sizes than PAGE_SIZE, leave this validation
step as a secondary effort for each block driver.

Reported-by: Li Wang <liwang@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202503101538.84c33cd4-lkp@intel.com
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-settings.c   | 4 +++-
 include/linux/blkdev.h | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index c44dadc35e1e..5cdd0d7d2af2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -254,7 +254,9 @@ int blk_validate_limits(struct queue_limits *lim)
 	 */
 	if (!lim->logical_block_size)
 		lim->logical_block_size = SECTOR_SIZE;
-	else if (blk_validate_block_size(lim->logical_block_size)) {
+	else if (blk_validate_block_size(lim->logical_block_size) ||
+		 (lim->logical_block_size > PAGE_SIZE &&
+		   !(lim->features & BLK_FEAT_LBS))) {
 		pr_warn("Invalid logical block size (%d)\n", lim->logical_block_size);
 		return -EINVAL;
 	}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a97428e8bbbe..cdab3731a646 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -341,6 +341,9 @@ typedef unsigned int __bitwise blk_features_t;
 #define BLK_FEAT_ATOMIC_WRITES \
 	((__force blk_features_t)(1u << 16))
 
+/* Supports sector sizes > PAGE_SIZE */
+#define BLK_FEAT_LBS		((__force blk_features_t)(1u << 17))
+
 /*
  * Flags automatically inherited when stacking limits.
  */
-- 
2.47.2


