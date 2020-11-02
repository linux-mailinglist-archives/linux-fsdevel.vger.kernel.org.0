Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4492A317C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 18:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbgKBR1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 12:27:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:49870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgKBR1j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:27:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ECAC6B2C7
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 17:27:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7E2A61E12FF; Mon,  2 Nov 2020 18:27:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] quota: Don't overflow quota file offsets
Date:   Mon,  2 Nov 2020 18:27:32 +0100
Message-Id: <20201102172733.23444-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201102172733.23444-1-jack@suse.cz>
References: <20201102172733.23444-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The on-disk quota format supports quota files with upto 2^32 blocks. Be
careful when computing quota file offsets in the quota files from block
numbers as they can overflow 32-bit types. Since quota files larger than
4GB would require ~26 millions of quota users, this is mostly a
theoretical concern now but better be careful, fuzzers would find the
problem sooner or later anyway...

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/quota_tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
index a6f856f341dc..c5562c871c8b 100644
--- a/fs/quota/quota_tree.c
+++ b/fs/quota/quota_tree.c
@@ -62,7 +62,7 @@ static ssize_t read_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
 
 	memset(buf, 0, info->dqi_usable_bs);
 	return sb->s_op->quota_read(sb, info->dqi_type, buf,
-	       info->dqi_usable_bs, blk << info->dqi_blocksize_bits);
+	       info->dqi_usable_bs, (loff_t)blk << info->dqi_blocksize_bits);
 }
 
 static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
@@ -71,7 +71,7 @@ static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
 	ssize_t ret;
 
 	ret = sb->s_op->quota_write(sb, info->dqi_type, buf,
-	       info->dqi_usable_bs, blk << info->dqi_blocksize_bits);
+	       info->dqi_usable_bs, (loff_t)blk << info->dqi_blocksize_bits);
 	if (ret != info->dqi_usable_bs) {
 		quota_error(sb, "dquota write failed");
 		if (ret >= 0)
@@ -284,7 +284,7 @@ static uint find_free_dqentry(struct qtree_mem_dqinfo *info,
 			    blk);
 		goto out_buf;
 	}
-	dquot->dq_off = (blk << info->dqi_blocksize_bits) +
+	dquot->dq_off = ((loff_t)blk << info->dqi_blocksize_bits) +
 			sizeof(struct qt_disk_dqdbheader) +
 			i * info->dqi_entry_size;
 	kfree(buf);
@@ -559,7 +559,7 @@ static loff_t find_block_dqentry(struct qtree_mem_dqinfo *info,
 		ret = -EIO;
 		goto out_buf;
 	} else {
-		ret = (blk << info->dqi_blocksize_bits) + sizeof(struct
+		ret = ((loff_t)blk << info->dqi_blocksize_bits) + sizeof(struct
 		  qt_disk_dqdbheader) + i * info->dqi_entry_size;
 	}
 out_buf:
-- 
2.16.4

