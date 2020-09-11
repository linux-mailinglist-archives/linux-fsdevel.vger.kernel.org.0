Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A820265FB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 14:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgIKMmT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 08:42:19 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38428 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgIKMk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599828057; x=1631364057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P/4bSAIH0zoQm4EVjKfdPeJBx6fTTnv8AGgc7UWj+Mo=;
  b=Rp4msHIQZ7hBeqaVTkeJza7MLmBA6U+Fm2ANfp7aiRhFlp3uIsGxh8fi
   xMziRVZKaUplSmc06RLX0xZFiYWgcE1qt4iESGjbUstFlfaxP77u6x9lk
   XHqB4t/i9cNgSCb3R1eQKf233zYkEIUKkP/q+JZS48HPscT6GtybwX6er
   Cn++damzFaqS4/QFBNDTZ+Jq/0qGR9FNu+m3jLcgthypCateSoQzBBynS
   gR2UlEEUcJcFsazRyskENLk7n9xurogHPpN+ij9fpIkhbS5qmzTZZfSVm
   P3p9bTeEze5RIeKZfEbhHoq4tByxC8FZbP7YpLUCrwzUEZokj6fMRSF7j
   A==;
IronPort-SDR: 1tbiYMOurfpeET5mEoZCSfpiXk0OqTqQVF7KbMr00UDWBEZF++ez8RqpjriExSV67jjFt8R9FX
 x2Uhw2A75jtHqRY88zWv+SciNacgagr5qw3+UZ8ySFNtDhKSuQCze2mdRnNUN8nBT80/lQSJBR
 2o29h8t+Gjy3oEHrS63D9D3MlzZb+Ys5PtDzjNGHJfnDgaTzMeGMg5vJuLq2UF7heQTTv6msAM
 GUJgaDVEAGOh54ih+ZiH5Ha5qZDogHZOW7tRCiFtUjgpzYvCU5kCXirnleKO2JzTo7gOhLzBVX
 zJU=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126032"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:55 +0800
IronPort-SDR: O5w++b4hvzqNBKiYxXyIhCBGxNQn90ZVcwPqDvt05NGHQll6/LIClPJDUMAimLZMpojzFiWKpq
 j9y77GJakOOQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:16 -0700
IronPort-SDR: W4MJlL8i3e/J2tW94uYpG3kq3bOualRAd9lM6Zy46iGu9aUYNmdxbmOeOEm59e8LityEfSgUtm
 R1dxR39DF5dw==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:53 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 33/39] btrfs: enable relocation in ZONED mode
Date:   Fri, 11 Sep 2020 21:32:53 +0900
Message-Id: <20200911123259.3782926-34-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To serialize allocation and submit_bio, we introduced mutex around them. As
a result, preallocation must be completely disabled to avoid a deadlock.

Since current relocation process relies on preallocation to move file data
extents, it must be handled in another way. In ZONED mode, we just truncate
the inode to the size that we wanted to pre-allocate. Then, we flush dirty
pages on the file before finishing relocation process.
run_delalloc_zoned() will handle all the allocation and submit IOs to the
underlying layers.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/relocation.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4ba1ab9cc76d..5bd1f2e61062 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2600,6 +2600,32 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 	if (ret)
 		return ret;
 
+	/*
+	 * In ZONED mode, we cannot preallocate the file region. Instead, we
+	 * dirty and fiemap_write the region.
+	 */
+
+	if (btrfs_fs_incompat(inode->root->fs_info, ZONED)) {
+		struct btrfs_root *root = inode->root;
+		struct btrfs_trans_handle *trans;
+
+		end = cluster->end - offset + 1;
+		trans = btrfs_start_transaction(root, 1);
+		if (IS_ERR(trans))
+			return PTR_ERR(trans);
+
+		inode->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
+		i_size_write(&inode->vfs_inode, end);
+		ret = btrfs_update_inode(trans, root, &inode->vfs_inode);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			btrfs_end_transaction(trans);
+			return ret;
+		}
+
+		return btrfs_end_transaction(trans);
+	}
+
 	inode_lock(&inode->vfs_inode);
 	for (nr = 0; nr < cluster->nr; nr++) {
 		start = cluster->boundary[nr] - offset;
@@ -2796,6 +2822,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		}
 	}
 	WARN_ON(nr != cluster->nr);
+	if (btrfs_fs_incompat(fs_info, ZONED) && !ret)
+		ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
 out:
 	kfree(ra);
 	return ret;
@@ -3431,8 +3459,12 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_path *path;
 	struct btrfs_inode_item *item;
 	struct extent_buffer *leaf;
+	u64 flags = BTRFS_INODE_NOCOMPRESS | BTRFS_INODE_PREALLOC;
 	int ret;
 
+	if (btrfs_fs_incompat(trans->fs_info, ZONED))
+		flags &= ~BTRFS_INODE_PREALLOC;
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -3447,8 +3479,7 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	btrfs_set_inode_generation(leaf, item, 1);
 	btrfs_set_inode_size(leaf, item, 0);
 	btrfs_set_inode_mode(leaf, item, S_IFREG | 0600);
-	btrfs_set_inode_flags(leaf, item, BTRFS_INODE_NOCOMPRESS |
-					  BTRFS_INODE_PREALLOC);
+	btrfs_set_inode_flags(leaf, item, flags);
 	btrfs_mark_buffer_dirty(leaf);
 out:
 	btrfs_free_path(path);
-- 
2.27.0

