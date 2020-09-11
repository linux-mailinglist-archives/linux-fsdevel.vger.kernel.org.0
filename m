Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A732B26675C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgIKRmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:42:14 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38370 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgIKMiM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827891; x=1631363891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YrTGp2LIGBKlHvCMIO3KoLbvWpsovAWjthYmnU6OJQE=;
  b=cQ+NOn7zRzTeU++KFGRmn5U4aXtn0x6PDY7ik/Czj8awl2ieu8kmFh1w
   QJj2X01ZWrogYh0z9tlG8TPAjSD7AGqm6UXM9NsAFG5jKJPwb28+wFa1r
   5diek6TKzO2iysZD1E7QlkDUppGsKeOzRt1cfmw9BfPyj75l/RoqzjnBx
   HUSSUdVc274kBCSNyDQWEPBtYBN1R5rElA1QtWU6BHyAAmrqOEHsBQtCB
   6Jxs91Kil47CEd+F50SM40TL6dnGwA3K49qPSfSCP+0CxoHsOQos/rS0r
   +IKD4qavJbDEWwxVKRubLZWkcfUkWQuZurP1PBI37NVVK/Wh1Mw2MIUns
   w==;
IronPort-SDR: TXnOYPSLoi7bhmPyHYAs1SqWXVdxi1ywjTlTZYRVXk+5B8BBscGk0RxKz4KAfWpON90nm5hfKS
 FtQW6acGop1wM2O/DNo5fX8sKemZGHfhl4E/6KlkrAriz8JWJRmLxU/7XOWdltMVVF55NofC9Y
 njOqRi2inmXRSmbESjKbKZ40jdsqI0Z7DZexCVfCtRo0AHXMN7eTcdo0GOKVWa08ZRAoDmpavS
 SBlmYczic8+fs4kYMwYW/ek2oy5h9osdpJZ5c7d5TE6fJxV52zKwJueOLRzUg/sI1TFV//iIUp
 dZc=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126014"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:44 +0800
IronPort-SDR: COtVDYBQgL9JkL1414se0/K8eEe0o6lCE0Kq7UsZOJBUZRP3J8VInnoEHB80m5RrfGczq/XTqO
 gkVXdMTfSIXQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:05 -0700
IronPort-SDR: qanchY6wwna8Cy8yY5TkXUe45Z5kF609toNzWjz3LS6VIjyIHHrg8mPO5fxHlshPtPv4Wc9EE8
 ES7tmV93lSeg==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:42 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 25/39] btrfs: introduce dedicated data write path for ZONED mode
Date:   Fri, 11 Sep 2020 21:32:45 +0900
Message-Id: <20200911123259.3782926-26-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index 422940d7bb4b..2bd001df4a75 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1355,6 +1355,29 @@ static int cow_file_range_async(struct btrfs_inode *inode,
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
@@ -1825,17 +1848,24 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
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

