Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D4DDE7D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 11:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfJUJSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 05:18:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42299 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfJUJSQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:18:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so8025657pff.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=18u8OclEbwwMCk6aNP/IK4nt9mUCfXoKw/CIOSf4ccY=;
        b=SWInYC2fQXmMkd4MNEeYkOXLvDvN6Kg+6Jthyu4DuJ75FjIpcRpy11IgR+8F9d6y7C
         yvr7y486PQdj6rE2BQYP8Ie8sstfZ1iZJ6nH5qmMFrELd9iAcadWfzjt/wyBPYn8XqWt
         SM8p2APs6/RhiXej8gooFB70kE8v1HYKXdsWM3LznX2i+hf5AzfUwcH+lKlm+sVMk+P9
         lMLLD8E2O0/kZcetCWrHE1pztcwBKn2nv3Oa7uTLlK5biUk/VtlRNDueCfk1erxAq/56
         meKbIcTuwOqOoxJATWPst+sK3SDGzvxHDoqI98d/JYCYhQajLTmpgN0Qrll+Npz+vsmY
         sugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=18u8OclEbwwMCk6aNP/IK4nt9mUCfXoKw/CIOSf4ccY=;
        b=sXtqqz/nHpNMg6/TOMG0GPb1/EAlBibl37wby1xJeZmcZ9u9sMVqyr4nUrtdR3MOy2
         A2EhY2JsVBdfk9aYUbFrTo8ZaIOV2UNi3Kvl1afdmqzVmrCYR3SR+VDr7nqweMTUBsfa
         mpIeMSF2Zfc7GaRb1Qois4cmDua9eOc1YBbiINYQUDiWM5AQjeM3Qx6nSVJOkDiNy+v7
         Y3pEKKxPCyVbWIneLCROPwJNV3KnevrVhWEWATpw1az2EtB9iAr6OTdLnInfsrTSgigx
         PXInekU7AiYWNKXiBv9CNiUpKwPZ6Yp9XDX1SHaitbfnO4+1Y1wne1Ops6f/INZ86KAl
         i4aw==
X-Gm-Message-State: APjAAAWjQFMiJGy2NffKPfr62uRD2Ez7uxf/e0kfvGzNMYVn0odO+enl
        z5VfKtvASs5bZMDl7kEAhfLqd+JPBw==
X-Google-Smtp-Source: APXvYqxMtOc5UjIK2QLX/3zyZ2d/nMm9bDVZj6AkMJXysyqEK8nRME/YbiOJ1bK9kYIP6e7CQfeXKg==
X-Received: by 2002:a63:4b06:: with SMTP id y6mr15017500pga.409.1571649495801;
        Mon, 21 Oct 2019 02:18:15 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id b69sm18238761pfb.132.2019.10.21.02.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:18:15 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:18:09 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v5 04/12] ext4: introduce new callback for IOMAP_REPORT
Message-ID: <f82e93ccc50014bf6c47318fd089a035d8032b28.1571647179.git.mbobrowski@mbobrowski.org>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571647178.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As part of the ext4_iomap_begin() cleanups that precede this patch,
here we also split up the IOMAP_REPORT branch into a completely
separate ->iomap_begin() callback named
ext4_iomap_begin_report(). Again, the raionale for this change is to
reduce the overall clutter that's starting to become apparent as we
start to port more functionality over to the iomap infrastructure.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/ext4.h  |   1 +
 fs/ext4/file.c  |   6 ++-
 fs/ext4/inode.c | 137 +++++++++++++++++++++++++++++-------------------
 3 files changed, 88 insertions(+), 56 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 03db3e71676c..d0d88f411a44 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3379,6 +3379,7 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
 }
 
 extern const struct iomap_ops ext4_iomap_ops;
+extern const struct iomap_ops ext4_iomap_report_ops;
 
 static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 {
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 8d2bbcc2d813..ab75aee3e687 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -494,12 +494,14 @@ loff_t ext4_llseek(struct file *file, loff_t offset, int whence)
 						maxbytes, i_size_read(inode));
 	case SEEK_HOLE:
 		inode_lock_shared(inode);
-		offset = iomap_seek_hole(inode, offset, &ext4_iomap_ops);
+		offset = iomap_seek_hole(inode, offset,
+					 &ext4_iomap_report_ops);
 		inode_unlock_shared(inode);
 		break;
 	case SEEK_DATA:
 		inode_lock_shared(inode);
-		offset = iomap_seek_data(inode, offset, &ext4_iomap_ops);
+		offset = iomap_seek_data(inode, offset,
+					 &ext4_iomap_report_ops);
 		inode_unlock_shared(inode);
 		break;
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3dc92bd8a944..ebeedbf3900f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3501,74 +3501,32 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			    unsigned flags, struct iomap *iomap)
 {
-	unsigned int blkbits = inode->i_blkbits;
-	unsigned long first_block, last_block;
-	struct ext4_map_blocks map;
-	bool delalloc = false;
 	int ret;
+	struct ext4_map_blocks map;
+	u8 blkbits = inode->i_blkbits;
 
 	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
 		return -EINVAL;
-	first_block = offset >> blkbits;
-	last_block = min_t(loff_t, (offset + length - 1) >> blkbits,
-			   EXT4_MAX_LOGICAL_BLOCK);
-
-	if (flags & IOMAP_REPORT) {
-		if (ext4_has_inline_data(inode)) {
-			ret = ext4_inline_data_iomap(inode, iomap);
-			if (ret != -EAGAIN) {
-				if (ret == 0 && offset >= iomap->length)
-					ret = -ENOENT;
-				return ret;
-			}
-		}
-	} else {
-		if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
-			return -ERANGE;
-	}
 
-	map.m_lblk = first_block;
-	map.m_len = last_block - first_block + 1;
-
-	if (flags & IOMAP_REPORT) {
-		ret = ext4_map_blocks(NULL, inode, &map, 0);
-		if (ret < 0)
-			return ret;
-
-		if (ret == 0) {
-			ext4_lblk_t end = map.m_lblk + map.m_len - 1;
-			struct extent_status es;
-
-			ext4_es_find_extent_range(inode, &ext4_es_is_delayed,
-						  map.m_lblk, end, &es);
+	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
+		return -ERANGE;
 
-			if (!es.es_len || es.es_lblk > end) {
-				/* entire range is a hole */
-			} else if (es.es_lblk > map.m_lblk) {
-				/* range starts with a hole */
-				map.m_len = es.es_lblk - map.m_lblk;
-			} else {
-				ext4_lblk_t offs = 0;
+	/*
+	 * Calculate the first and last logical blocks respectively.
+	 */
+	map.m_lblk = offset >> blkbits;
+	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
+			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
 
-				if (es.es_lblk < map.m_lblk)
-					offs = map.m_lblk - es.es_lblk;
-				map.m_lblk = es.es_lblk + offs;
-				map.m_len = es.es_len - offs;
-				delalloc = true;
-			}
-		}
-	} else if (flags & IOMAP_WRITE) {
+	if (flags & IOMAP_WRITE)
 		ret = ext4_iomap_alloc(inode, &map, flags);
-	} else {
+	else
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
-	}
 
 	if (ret < 0)
 		return ret;
 
 	ext4_set_iomap(inode, iomap, &map, offset, length);
-	if (delalloc && iomap->type == IOMAP_HOLE)
-		iomap->type = IOMAP_DELALLOC;
 
 	return 0;
 }
@@ -3630,6 +3588,77 @@ const struct iomap_ops ext4_iomap_ops = {
 	.iomap_end		= ext4_iomap_end,
 };
 
+static bool ext4_iomap_is_delalloc(struct inode *inode,
+				   struct ext4_map_blocks *map)
+{
+	struct extent_status es;
+	ext4_lblk_t offset = 0, end = map->m_lblk + map->m_len - 1;
+
+	ext4_es_find_extent_range(inode, &ext4_es_is_delayed,
+				  map->m_lblk, end, &es);
+
+	if (!es.es_len || es.es_lblk > end)
+		return false;
+
+	if (es.es_lblk > map->m_lblk) {
+		map->m_len = es.es_lblk - map->m_lblk;
+		return false;
+	}
+
+	if (es.es_lblk <= map->m_lblk)
+		offset = map->m_lblk - es.es_lblk;
+
+	map->m_lblk = es.es_lblk + offset;
+	map->m_len = es.es_len - offset;
+
+	return true;
+}
+
+static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
+				   loff_t length, unsigned int flags,
+				   struct iomap *iomap)
+{
+	int ret;
+	bool delalloc = false;
+	struct ext4_map_blocks map;
+	u8 blkbits = inode->i_blkbits;
+
+	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
+		return -EINVAL;
+
+	if (ext4_has_inline_data(inode)) {
+		ret = ext4_inline_data_iomap(inode, iomap);
+		if (ret != -EAGAIN) {
+			if (ret == 0 && offset >= iomap->length)
+				ret = -ENOENT;
+			return ret;
+		}
+	}
+
+	/*
+	 * Calculate the first and last logical blocks respectively.
+	 */
+	map.m_lblk = offset >> blkbits;
+	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
+			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+
+	ret = ext4_map_blocks(NULL, inode, &map, 0);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		delalloc = ext4_iomap_is_delalloc(inode, &map);
+
+	ext4_set_iomap(inode, iomap, &map, offset, length);
+	if (delalloc && iomap->type == IOMAP_HOLE)
+		iomap->type = IOMAP_DELALLOC;
+
+	return 0;
+}
+
+const struct iomap_ops ext4_iomap_report_ops = {
+	.iomap_begin = ext4_iomap_begin_report,
+};
+
 static int ext4_end_io_dio(struct kiocb *iocb, loff_t offset,
 			    ssize_t size, void *private)
 {
-- 
2.20.1

--<M>--
