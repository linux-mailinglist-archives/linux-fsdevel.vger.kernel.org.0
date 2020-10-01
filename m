Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20142806FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbgJASj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:29 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24779 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733072AbgJASjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577542; x=1633113542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=smnfPZ2PHSaLwMiHjwkNcdokXv96GnZf7zgeO0D351k=;
  b=a0P/R2rDPlAwFOjLkpC8TlCdY5R4XPElCHZSnUzS+YHyJ7FWxJAN3BYv
   OdjG1Wd+Kt+7s620AOfSi4s9w9mD1pii50BtGO/JjA/ONCOHGhs5ykULg
   A/XabMPT4Z6AdArlLxlsf3VOUALncpbw0r2xBGsolBAmvuWnGEeB7lL6h
   AvDiXnF7GmIeaQ4B9YiKduRIXp+IOTKngD75lt2PBM9GebZuWmanYDo42
   h7FwIyDoLr4I+lQh0xPJ3aQfOOin7UBVWKQ9GTdhUeNg1F902ryhf2Ha/
   6/6XHek4BIV56Ufx/voU43q9ll09xS5x7aew5/vybaVn97gFBpG/aKAR7
   Q==;
IronPort-SDR: BZKqcrLb/7Eu0KdHfq3djlX7gaj0/HYEQSzF7iAVWMzuM0eIInLhrrtOp9ElCpoKpK7iJrHRXK
 XXu+j5dLKmvpqGi8NalEgiMg9js47GhCPSExHv2kGS6FGQbUJEHIt/mSZ034nNFCMWrVwYDQT2
 pg7/oSxQJD1wuN+Jq2WwdDKlDRe/jkgrMUGFSauNVTSXbympaPOkMX5hjMqeMB+JQlALrm1wsW
 1B14oN8UflS+8cK7E+0ZZrtD9CXFLiEFdG4H5S3nVadx/tRqumBHqI9J864VmXRzrh9rwfLUON
 RL0=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036821"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:33 +0800
IronPort-SDR: yCMFQnJLSlp3zLn4VbYWTmL+9lC5b2B/ZJiwkyvAikGFx6iPbRe5sErKabgWp+9HdKL7AOO91f
 yGcLelSjFezQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:30 -0700
IronPort-SDR: SSMVERy9fPXzbSNZXrF/YmA0F3j+hHugr7nc8MZbOeoJzd1TACMeDxo2sym+WsZPJm9vl8E1F/
 C+l3RsjiizOQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:32 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 27/41] btrfs: introduce dedicated data write path for ZONED mode
Date:   Fri,  2 Oct 2020 03:36:34 +0900
Message-Id: <2a95e45089e9f9b1425e8fbe0acac966ee93d07b.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If more than one IO is issued for one file extent, these IO can be written
in a separate region on a device. Since we cannot map one file extent to
such a separate area, we need to follow the "one IO == one ordered extent"
rule.

Normal (buffered, uncompressed, not pre-allocated) write path (=
cow_file_range()) sometime does not follow the rule. It can write a part of
an ordered extent when specified a region to write e.g., called from
fdatasync().

This commit introduces a dedicated (uncompressed buffered) data write path
for ZONED mode. This write path CoW the region and write the region at
once.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 37d85c062f3a..46eba6c7792b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1350,6 +1350,29 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 	return 0;
 }
 
+static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
+				       struct page *locked_page, u64 start,
+				       u64 end, int *page_started,
+				       unsigned long *nr_written)
+{
+	int ret;
+
+	ret = cow_file_range(inode, locked_page, start, end,
+			     page_started, nr_written, 0);
+	if (ret)
+		return ret;
+
+	if (*page_started)
+		return 0;
+
+	__set_page_dirty_nobuffers(locked_page);
+	account_page_redirty(locked_page);
+	extent_write_locked_range(&inode->vfs_inode, start, end, WB_SYNC_ALL);
+	*page_started = 1;
+
+	return 0;
+}
+
 static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
 					u64 bytenr, u64 num_bytes)
 {
@@ -1820,17 +1843,24 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 {
 	int ret;
 	int force_cow = need_force_cow(inode, start, end);
+	int do_compress = inode_can_compress(inode) &&
+		inode_need_compress(inode, start, end);
+	bool zoned = btrfs_fs_incompat(inode->root->fs_info, ZONED);
 
 	if (inode->flags & BTRFS_INODE_NODATACOW && !force_cow) {
+		ASSERT(!zoned);
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 1, nr_written);
 	} else if (inode->flags & BTRFS_INODE_PREALLOC && !force_cow) {
+		ASSERT(!zoned);
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 0, nr_written);
-	} else if (!inode_can_compress(inode) ||
-		   !inode_need_compress(inode, start, end)) {
+	} else if (!do_compress && !zoned) {
 		ret = cow_file_range(inode, locked_page, start, end,
 				     page_started, nr_written, 1);
+	} else if (!do_compress && zoned) {
+		ret = run_delalloc_zoned(inode, locked_page, start, end,
+					 page_started, nr_written);
 	} else {
 		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
 		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
-- 
2.27.0

