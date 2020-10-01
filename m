Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818692806F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733143AbgJASjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:16 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24779 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733109AbgJASjI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577548; x=1633113548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n831lhAdxLYEN4MUkMzrkg2IF6/VSOBYsrPc+3Ofl2w=;
  b=SQtRYAAlLTdRyYKKLAdAz9a6bL40SaKYkzoMx0ZzysV+eisY1/9asBR/
   MNMp0yPWdV4aaTAYoAb6FzsHfd+bdTFqnowNKuaV7VC4E2NS5+Tjxja3B
   q9FeZbRutdcSsxb8odoQxxl/ZrlGnwDPS0x4VtlmFyDWnz6sh0dtqLCmE
   yT25Z4/j79RFtbG7Oct5CeU3kaRYMsQpf6MrkepVeXMUiezw0jC9rGyC7
   THD7/5U6L+2H9MN2u07pcAaiDwUPDF6ryP30soEfS1zbZWPe7lRtiR2DC
   nunDqEp4tHZWH4Idw7pzculkY+ogLiK7L8bgshJH3Xkp6o8hHjPslD4GR
   A==;
IronPort-SDR: jRC5orpsQIkc5RJvdN7gNXfFtk99RIkm/ZCyek9PBSeNykQB0+jt44Uy1Wg8Aeq4jaMWynxgDP
 k6rotnOal9yVdsrfNynTq6rqacfjErfULoTROPgq5POBfD2UWNz12uNjpRbAlaHgsDJBF0gMj4
 +jpilcn3z8pDRNdgH7veEY/CoZdfMpkhTfDYZqhCK23mkfmKzYkSh1LUpDrnv/85b7evQg0f0J
 5iyFlyxF+YyZM/M1/R6l/DTF2fMWNdNSEEodEUafYzrxP95qYOwFQ+IVTnMi2JX0zV9hPkTafB
 icI=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036849"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:47 +0800
IronPort-SDR: biFGsTBWqGD1HYdcpfYnZjBQqHbWu7WllNzgtlEj4F0uSJKxV4jh6Gk3KZRgM4ET75DqeJNgmN
 rLtHsop2lE2g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:44 -0700
IronPort-SDR: UB/1dVSEOc4P1WzFi9fMDpKB0fmiG7rCUPeP1Fo0vO6uPxFroJ1DYaGBKPoPuGK6DM7VgVcFAT
 Wfayqlk9tskg==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:46 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 39/41] btrfs: serialize log transaction on ZONED mode
Date:   Fri,  2 Oct 2020 03:36:46 +0900
Message-Id: <2d84e29552ae6771c987992ec59bd11f3178532f.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 2/3 patch to enable tree-log on ZONED mode.

Since we can start more than one log transactions per subvolume
simultaneously, nodes from multiple transactions can be allocated
interleaved. Such mixed allocation results in non-sequential writes at the
time of log transaction commit. The nodes of the global log root tree
(fs_info->log_root_tree), also have the same mixed allocation problem.

This patch serializes log transactions by waiting for a committing
transaction when someone tries to start a new transaction, to avoid the
mixed allocation problem. We must also wait for running log transactions
from another subvolume, but there is no easy way to detect which subvolume
root is running a log transaction. So, this patch forbids starting a new
log transaction when other subvolumes already allocated the global log root
tree.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/tree-log.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5f585cf57383..42175b8d1bee 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -106,6 +106,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 				       struct btrfs_root *log,
 				       struct btrfs_path *path,
 				       u64 dirid, int del_all);
+static void wait_log_commit(struct btrfs_root *root, int transid);
 
 /*
  * tree logging is a special write ahead log used to make sure that
@@ -140,16 +141,25 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 			   struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	bool zoned = btrfs_fs_incompat(fs_info, ZONED);
 	int ret = 0;
 
 	mutex_lock(&root->log_mutex);
 
+again:
 	if (root->log_root) {
+		int index = (root->log_transid + 1) % 2;
+
 		if (btrfs_need_log_full_commit(trans)) {
 			ret = -EAGAIN;
 			goto out;
 		}
 
+		if (zoned && atomic_read(&root->log_commit[index])) {
+			wait_log_commit(root, root->log_transid - 1);
+			goto again;
+		}
+
 		if (!root->log_start_pid) {
 			clear_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state);
 			root->log_start_pid = current->pid;
@@ -158,8 +168,13 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 		}
 	} else {
 		mutex_lock(&fs_info->tree_log_mutex);
-		if (!fs_info->log_root_tree)
+		if (zoned && fs_info->log_root_tree) {
+			ret = -EAGAIN;
+			mutex_unlock(&fs_info->tree_log_mutex);
+			goto out;
+		} else if (!fs_info->log_root_tree) {
 			ret = btrfs_init_log_root_tree(trans, fs_info);
+		}
 		mutex_unlock(&fs_info->tree_log_mutex);
 		if (ret)
 			goto out;
@@ -193,14 +208,22 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
  */
 static int join_running_log_trans(struct btrfs_root *root)
 {
+	bool zoned = btrfs_fs_incompat(root->fs_info, ZONED);
 	int ret = -ENOENT;
 
 	if (!test_bit(BTRFS_ROOT_HAS_LOG_TREE, &root->state))
 		return ret;
 
 	mutex_lock(&root->log_mutex);
+again:
 	if (root->log_root) {
+		int index = (root->log_transid + 1) % 2;
+
 		ret = 0;
+		if (zoned && atomic_read(&root->log_commit[index])) {
+			wait_log_commit(root, root->log_transid - 1);
+			goto again;
+		}
 		atomic_inc(&root->log_writers);
 	}
 	mutex_unlock(&root->log_mutex);
-- 
2.27.0

