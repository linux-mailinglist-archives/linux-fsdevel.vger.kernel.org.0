Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C5B26674A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgIKRlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:41:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38415 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgIKMmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599828124; x=1631364124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jDNOKaXClWIV7lgnR8edIQwjLBXqUIKTiHrpP/FSDC0=;
  b=kXpuvYWQx0g3lTisTzw7uPKq2fb5zq9lgxDh25vvr5LYw2enTudEOSWK
   B2RJ1nqFBApyn5v5dq2VPzP+TtfIUV+TfHMt2RfXoehsiTRTQXOmZ17fl
   WYwS2HCAqW4Vf9S4hmy4Z9/uDP+3UJlpv4EtwpYRz7vQkqd9SC+P25tRa
   c7kCQEbk3R1ifrJoQZ63HQd50kXk4b+ZyE2dgfA5eYz9VUqunGCANXUm8
   0z8mvTVxJ3LGpiOaNK0n5S3v2DaXnSCKvNko15aMHf6Mbzl+DQIngS6tp
   ozyS6cxr5us8PG0NWo7RVuay1jgLJuz4Ho/xCV9btkJBhWa6zbSxXxG83
   A==;
IronPort-SDR: d3BI6iNpKkxxU4u0RoI1Vww2Jj6EdOVX42wOvHizGA68Im45kMgn/WfnX4IM0ZPry/WmCF3vhP
 x+a8OLX8brDL4eqmWab6UrMEVv1FfUjJWTnX9VDpYO+wZqxqz/vyEZ+UqJeQlU2xNLw6eiX0Mr
 j1DPiT09MATze4GrqJ3DXvfvWsL9oG1WC5nRIEa1eQS4cxU37rW5ELw+ALzwM3o8bxVrjLdLZQ
 w4isSEZ3uM7n6AYYSURXs8ff8Mapyr+9LBbeDWiBoHfWuSCLTCal3dJPXVnfK+DQy7HPDf2HjX
 NoI=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126049"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:34:01 +0800
IronPort-SDR: cAXb7ZQEiPyPbF0f1lX4WdWiBl8anmSoaVBrAUG0ShjgGqJgHqNl5qLt69BbXPP6EPchp5zoHI
 nhILytPWDxMA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:22 -0700
IronPort-SDR: expOSwhFUzxYPUwkeBn6RkqSoUu1jLz1+B3KU8WsN90H20hVOBw/M44NX7YgYh65Ni6FznUgZg
 yjHV/uCoHzdw==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:59 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 37/39] btrfs: serialize log transaction on ZONED mode
Date:   Fri, 11 Sep 2020 21:32:57 +0900
Message-Id: <20200911123259.3782926-38-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index 4b6a68a81eac..1ffb9a0341e2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -108,6 +108,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 				       struct btrfs_root *log,
 				       struct btrfs_path *path,
 				       u64 dirid, int del_all);
+static void wait_log_commit(struct btrfs_root *root, int transid);
 
 /*
  * tree logging is a special write ahead log used to make sure that
@@ -142,16 +143,25 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
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
@@ -160,8 +170,13 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
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
@@ -195,14 +210,22 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
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

