Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A83266746
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgIKRl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:41:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38370 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIKMmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599828124; x=1631364124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Moym42/sUeqiVApISDpT6H37I/hkr5wjw/ADzqGR7uQ=;
  b=DNAllh9jSRNnHf3T6GuifP7PsRZ64TvZuNO4hqk4D/He8LVnUJe6cCmZ
   rSWHvn5BBPQACrMRP72FP7Byu76ztJY9BntY6VLn5FJx+TGLxy1+ejWL9
   +gEzGHCGKCWlwc8LWOvzmo04q2mcvi0pSfIo5cTFaIFOuKy48RJrPWnfd
   AFBayOiHHbvj08hFYSQ6qp3/ccLEH66SoKuBjvuU/JOyPvkpXYIogMDMW
   AqlIg3KYzryq5i9lH4/3zDobCyVIrpn7AQlt+K6mcttGbb20epSdYcicd
   kmuD6nbOMw6W4DPOsxh9xbYRHL6MS4pPayL29mQNj5nfvGqgXFj7CKJG+
   w==;
IronPort-SDR: zYGF/TMBO7OMP4j4pP+9Nab0lEHQ44CCebfqhFcRcx9bT1HORRUb2xdxoRRz/2mg6bC414qfWF
 1r3XOeXko9BHV9aFGyVijHd+n7D0GPOPv+CN9NxK6dkqCVimPWZast00UAm86v5q7Hm2hRPpCn
 AQE1wMHzZVn+mDLxQv2LvATh7KjXPxYROMBsFXxLBO2FjyEYXOHOraKOnWc879NECrE4FR9juU
 kk/D+W7soKxx9AzG2TOdvp8OB4FUMFESi0NCO799QbjxF/P4X8DA/xOjt9+mT8P7+9RPIhLvHP
 FAU=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126041"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:58 +0800
IronPort-SDR: 1BwuoHAY8kf5hlnE/TA+2i0T/1vBAaRdyBxefTNO+XMQwBZDYcwuziuExJmX7j+jxNIs1hgdAB
 bCfvgQYckypQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:19 -0700
IronPort-SDR: ziaXOghq8oNifNeicDeJgkdxD6F7fRmbViSNaZfoksLjbW9wblK4q5GxqdyuRedKWinNdX+dU1
 btPR+Ju6T0AA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:56 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 35/39] btrfs: split alloc_log_tree()
Date:   Fri, 11 Sep 2020 21:32:55 +0900
Message-Id: <20200911123259.3782926-36-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a preparation for the next patch. This commit split
alloc_log_tree() to allocating tree structure part (remains in
alloc_log_tree()) and allocating tree node part (moved in
btrfs_alloc_log_tree_node()). The latter part is also exported to be used
in the next patch.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 27 ++++++++++++++++++++++++---
 fs/btrfs/disk-io.h |  2 ++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cd768030b7bb..4d1851e72031 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1269,7 +1269,6 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 					 struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root;
-	struct extent_buffer *leaf;
 
 	root = btrfs_alloc_root(fs_info, BTRFS_TREE_LOG_OBJECTID, GFP_NOFS);
 	if (!root)
@@ -1279,6 +1278,14 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
 	root->root_key.offset = BTRFS_TREE_LOG_OBJECTID;
 
+	return root;
+}
+
+int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root)
+{
+	struct extent_buffer *leaf;
+
 	/*
 	 * DON'T set SHAREABLE bit for log trees.
 	 *
@@ -1293,24 +1300,31 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 			NULL, 0, 0, 0);
 	if (IS_ERR(leaf)) {
 		btrfs_put_root(root);
-		return ERR_CAST(leaf);
+		return PTR_ERR(leaf);
 	}
 
 	root->node = leaf;
 
 	btrfs_mark_buffer_dirty(root->node);
 	btrfs_tree_unlock(root->node);
-	return root;
+
+	return 0;
 }
 
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *log_root;
+	int ret;
 
 	log_root = alloc_log_tree(trans, fs_info);
 	if (IS_ERR(log_root))
 		return PTR_ERR(log_root);
+	ret = btrfs_alloc_log_tree_node(trans, log_root);
+	if (ret) {
+		kfree(log_root);
+		return ret;
+	}
 	WARN_ON(fs_info->log_root_tree);
 	fs_info->log_root_tree = log_root;
 	return 0;
@@ -1322,11 +1336,18 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_root *log_root;
 	struct btrfs_inode_item *inode_item;
+	int ret;
 
 	log_root = alloc_log_tree(trans, fs_info);
 	if (IS_ERR(log_root))
 		return PTR_ERR(log_root);
 
+	ret = btrfs_alloc_log_tree_node(trans, log_root);
+	if (ret) {
+		kfree(log_root);
+		return ret;
+	}
+
 	log_root->last_trans = trans->transid;
 	log_root->root_key.offset = root->root_key.objectid;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 00dc39d47ed3..85c7d4de765e 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -111,6 +111,8 @@ blk_status_t btrfs_wq_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			extent_submit_bio_start_t *submit_bio_start);
 blk_status_t btrfs_submit_bio_done(void *private_data, struct bio *bio,
 			  int mirror_num);
+int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root);
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info);
 int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
-- 
2.27.0

