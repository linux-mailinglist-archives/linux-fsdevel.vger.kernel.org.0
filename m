Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797B21FCCE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 13:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgFQL6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 07:58:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6354 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726769AbgFQL6o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:58:44 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7A3DCCC54D72601CC209;
        Wed, 17 Jun 2020 19:58:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 17 Jun 2020
 19:58:35 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.cz>
CC:     <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>,
        <yi.zhang@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2 4/5] ext4: remove ext4_buffer_uptodate()
Date:   Wed, 17 Jun 2020 19:59:46 +0800
Message-ID: <20200617115947.836221-5-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200617115947.836221-1-yi.zhang@huawei.com>
References: <20200617115947.836221-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After we add ext4_end_buffer_async_write() callback into block layer to
detect metadata buffer's async write error in the background, we can
remove the partial fix for filesystem inconsistency problem caused by
reading old data from disk in commit <7963e5ac9012> "ext4: treat buffers
with write errors as containing valid data" and <cf2834a5ed57> "ext4:
treat buffers contining write errors as valid in ext4_sb_bread()".

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  | 13 -------------
 fs/ext4/inode.c |  4 ++--
 fs/ext4/super.c |  2 +-
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 82ae41a828dd..a3699677a119 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3497,19 +3497,6 @@ extern const struct iomap_ops ext4_iomap_ops;
 extern const struct iomap_ops ext4_iomap_overwrite_ops;
 extern const struct iomap_ops ext4_iomap_report_ops;
 
-static inline int ext4_buffer_uptodate(struct buffer_head *bh)
-{
-	/*
-	 * If the buffer has the write error flag, we have failed
-	 * to write out data in the block.  In this  case, we don't
-	 * have to read the block because we may read the old data
-	 * successfully.
-	 */
-	if (!buffer_uptodate(bh) && buffer_write_io_error(bh))
-		set_buffer_uptodate(bh);
-	return buffer_uptodate(bh);
-}
-
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 52be85f96159..8ccb6996c384 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -875,7 +875,7 @@ struct buffer_head *ext4_bread(handle_t *handle, struct inode *inode,
 	bh = ext4_getblk(handle, inode, block, map_flags);
 	if (IS_ERR(bh))
 		return bh;
-	if (!bh || ext4_buffer_uptodate(bh))
+	if (!bh || buffer_uptodate(bh))
 		return bh;
 	ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1, &bh);
 	wait_on_buffer(bh);
@@ -902,7 +902,7 @@ int ext4_bread_batch(struct inode *inode, ext4_lblk_t block, int bh_count,
 
 	for (i = 0; i < bh_count; i++)
 		/* Note that NULL bhs[i] is valid because of holes. */
-		if (bhs[i] && !ext4_buffer_uptodate(bhs[i]))
+		if (bhs[i] && !buffer_uptodate(bhs[i]))
 			ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1,
 				    &bhs[i]);
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3e867ff452cd..9cb85aa72ba3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -154,7 +154,7 @@ ext4_sb_bread(struct super_block *sb, sector_t block, int op_flags)
 
 	if (bh == NULL)
 		return ERR_PTR(-ENOMEM);
-	if (ext4_buffer_uptodate(bh))
+	if (buffer_uptodate(bh))
 		return bh;
 	ll_rw_block(REQ_OP_READ, REQ_META | op_flags, 1, &bh);
 	wait_on_buffer(bh);
-- 
2.25.4

