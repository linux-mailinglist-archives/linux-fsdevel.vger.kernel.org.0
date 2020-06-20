Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D26F201FEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 04:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbgFTCxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 22:53:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54910 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732119AbgFTCxh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 22:53:37 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 820CC923E92422E49FE3;
        Sat, 20 Jun 2020 10:53:33 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 20 Jun 2020
 10:53:21 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.cz>
CC:     <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>,
        <yi.zhang@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3 2/5] ext4: remove ext4_buffer_uptodate()
Date:   Sat, 20 Jun 2020 10:54:24 +0800
Message-ID: <20200620025427.1756360-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200620025427.1756360-1-yi.zhang@huawei.com>
References: <20200620025427.1756360-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After we add async write error check in ext4_journal_get_write_access(),
we can remove the partial fix for filesystem inconsistency problem
caused by reading old data from disk, which in commit <7963e5ac9012>
"ext4: treat buffers with write errors as containing valid data" and
<cf2834a5ed57> "ext4: treat buffers contining write errors as valid in
ext4_sb_bread()".

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  | 13 -------------
 fs/ext4/inode.c |  4 ++--
 fs/ext4/super.c |  2 +-
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 60374eda1f51..f22940e5de5a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3501,19 +3501,6 @@ extern const struct iomap_ops ext4_iomap_ops;
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
index 40ec5c7ef0d3..f68afc5c0b2d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -883,7 +883,7 @@ struct buffer_head *ext4_bread(handle_t *handle, struct inode *inode,
 	bh = ext4_getblk(handle, inode, block, map_flags);
 	if (IS_ERR(bh))
 		return bh;
-	if (!bh || ext4_buffer_uptodate(bh))
+	if (!bh || buffer_uptodate(bh))
 		return bh;
 	ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1, &bh);
 	wait_on_buffer(bh);
@@ -910,7 +910,7 @@ int ext4_bread_batch(struct inode *inode, ext4_lblk_t block, int bh_count,
 
 	for (i = 0; i < bh_count; i++)
 		/* Note that NULL bhs[i] is valid because of holes. */
-		if (bhs[i] && !ext4_buffer_uptodate(bhs[i]))
+		if (bhs[i] && !buffer_uptodate(bhs[i]))
 			ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1,
 				    &bhs[i]);
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8d3925c31b8a..513d1e270f6d 100644
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

