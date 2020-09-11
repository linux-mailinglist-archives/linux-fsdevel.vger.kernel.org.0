Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA52A266747
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgIKRl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:41:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38372 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgIKMmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599828124; x=1631364124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EGkEEOwBzpfHNcgr098kjLm/afTRruKnzHCAAKn/Kjc=;
  b=TaNh3v6Z1YZjy+BJeMPVcUlSz7QDKebs72PBqYzK69esGC9oRbzsSxys
   HlgnLXlxTATrudalh2rTE++6sk58xwCR/GmJ8CyIdjd//WqsXHb6lovcB
   kgxnYlCTIdZBDQZcELeiGS8MQ/eDzvSI8ovNkkOj70tss7sAxIDTO7yMt
   kKJmlUD2zjVB16UVZwGx27BDHomYGnP/Kf7fhdnC2R9r/0sCLsMBqqIyX
   +SRFVo9ASAUFdR5otU9viDexi+nYzVEL/sg6u+3nwNfYXwJaCugE/0Tzl
   AMGc/r/9/uuNFvoGEi0j8kWvFRlotaHaxRxyszy+ySioKaBIra+id2BEX
   A==;
IronPort-SDR: G3BrYcoPNJmXT3t5u3ZxqJykRqivJxJPh4uB+0e4vVK6de4J/wNUc0re21qVclgoPKe0d3DpKT
 DDfgZGyJJFKd+5g3ZVnwktTA+LXd+9CPDh6RQHf6aTev+0mjoJGEZUDpySdXfe7iEE0nAnZt+9
 KLCDwvo24Ar6ROW0jwonHoJYIor2F9A6rcn09wMwqElLU9Mls++MjG8xFO+ZuI6xtzg9bPBoCI
 Xz9hNcOq/6fRE/iciSBdpE3mVymhfC9RJICLtP1ifW4l6VrzIe+PvNn4gY6Rj0ZI89Xpr1nmr8
 b4M=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126052"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:34:02 +0800
IronPort-SDR: Oir1RkoCVpzvzhvVMw0GdS73uzQUi8vJpC8AQENdgrr3cyIhmh2MR9iyq0zIzf0wSxOl+u7zEJ
 qk2q9EsV8YGQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:23 -0700
IronPort-SDR: 6pZrGdnHobUZD0ickYutQmhnFYw5uEk7PU1cQDdfd17Ups4Q+HR7LYg+ymtvBJBkKohhTJZH3C
 dJ145VECIeFA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:34:00 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 38/39] btrfs: reorder log node allocation
Date:   Fri, 11 Sep 2020 21:32:58 +0900
Message-Id: <20200911123259.3782926-39-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 3/3 patch to enable tree-log on ZONED mode.

The allocation order of nodes of "fs_info->log_root_tree" and nodes of
"root->log_root" is not the same as the writing order of them. So, the
writing causes unaligned write errors.

This patch reorders the allocation of them by delaying allocation of the
root node of "fs_info->log_root_tree," so that the node buffers can go out
sequentially to devices.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c  |  6 ------
 fs/btrfs/tree-log.c | 19 +++++++++++++------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4d1851e72031..0884412977a0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1315,16 +1315,10 @@ int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *log_root;
-	int ret;
 
 	log_root = alloc_log_tree(trans, fs_info);
 	if (IS_ERR(log_root))
 		return PTR_ERR(log_root);
-	ret = btrfs_alloc_log_tree_node(trans, log_root);
-	if (ret) {
-		kfree(log_root);
-		return ret;
-	}
 	WARN_ON(fs_info->log_root_tree);
 	fs_info->log_root_tree = log_root;
 	return 0;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1ffb9a0341e2..087c1d0c7307 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3147,6 +3147,11 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[index2]);
 	root_log_ctx.log_transid = log_root_tree->log_transid;
 
+	mutex_lock(&fs_info->tree_log_mutex);
+	if (!log_root_tree->node)
+		btrfs_alloc_log_tree_node(trans, log_root_tree);
+	mutex_unlock(&fs_info->tree_log_mutex);
+
 	/*
 	 * Now we are safe to update the log_root_tree because we're under the
 	 * log_mutex, and we're a current writer so we're holding the commit
@@ -3296,12 +3301,14 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 		.process_func = process_one_buffer
 	};
 
-	ret = walk_log_tree(trans, log, &wc);
-	if (ret) {
-		if (trans)
-			btrfs_abort_transaction(trans, ret);
-		else
-			btrfs_handle_fs_error(log->fs_info, ret, NULL);
+	if (log->node) {
+		ret = walk_log_tree(trans, log, &wc);
+		if (ret) {
+			if (trans)
+				btrfs_abort_transaction(trans, ret);
+			else
+				btrfs_handle_fs_error(log->fs_info, ret, NULL);
+		}
 	}
 
 	clear_extent_bits(&log->dirty_log_pages, 0, (u64)-1,
-- 
2.27.0

