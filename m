Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25352280711
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733202AbgJASjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:55 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24722 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733116AbgJASjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577549; x=1633113549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OmAi2+NSsYKSgRbWdebZeHR8g9vYhF9/qIqK9TbTi2U=;
  b=JtmizhqLGtq7uThUo27tKFVUimZt9Lcm6MMLHewWvD+KcefxlsBK3UfG
   +7e3v8nJpgltSkXDLiaQC0cdTG1runN1kiM2I5UU2uHHO165dBXWrB3A7
   aUf4qmYWsMvfTBfRW3Yhz7SjL9exqSZQ6oIHcSisHYmQcil7JfWhNG+X0
   FbtwBpWSQQW5ekmZqOm8vEylVobA0nCCbAKFE6BatAg1RQ8uzdHLKFbRQ
   rc75diE5ssYutYtw6tiWKPyWWO5ZFi+uP18ulFUWoeWQLgWaFk+WcCzQL
   BMFtSWwEokftjeaiWmmLLsbqEH62viqn9ZjE8YtUzZfo705cQW2S4cRO3
   g==;
IronPort-SDR: zL9L6vN5LfZpQCgVwxb2W7efF2u2TexPl/36f3pJBaLNTetLn6xPKcJXRwl5XDBJtJKhBOPkL1
 mKNF6RyTjFtfFnaZWc7DzQ6/clkdNdWw4VqL8SOYvCFEKnWNfdeHYa51DCZUs0DlYeWs4AKC5P
 9UQLUewN6EJt/9++ry5XlFfJek/lWP5C4rTFDHCXYP6ufXKq4EfWm4i4vGb1Q85q7sjmYvB3M8
 e6cCzcyv4iLzLFTZA7vifjQSVcLk5W3u9dDH0ARFW3k6BImHhvBwnoxfPi3IaxdYqgGEKh3/7H
 ZMs=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036853"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:48 +0800
IronPort-SDR: ayaJdEs4eVd5VyhXX0FD+hVTmeGOL9vZbfniUBy25ui4m5FO3ZN+BePbXr78uG4ifum+6NPtV/
 HfWt+qAOm8BA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:45 -0700
IronPort-SDR: 8ptyzsGHOHhy1CtrmWpO/XObMg1y6Q6WyYQcobQfmlYsJDPnrJFJzcXlH/Wg7RXj41W6HhHJzD
 OvYExObw8mQg==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:48 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 40/41] btrfs: reorder log node allocation
Date:   Fri,  2 Oct 2020 03:36:47 +0900
Message-Id: <2999cb6cad58c822b1fa9d642605134d6a65f318.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 02b1f9b20bed..0c041ad096ac 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1257,16 +1257,10 @@ int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
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
index 42175b8d1bee..7a4bfedb2929 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3143,6 +3143,11 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
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
@@ -3292,12 +3297,14 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
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

