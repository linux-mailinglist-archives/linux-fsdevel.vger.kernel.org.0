Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0901EC9D68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 13:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfJCLdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 07:33:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37535 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730051AbfJCLdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:33:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id c17so1610751pgg.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2019 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6AOkLlwuybn5QUKCBXJB6MO5HcsFkduQo3SQQbLA8/A=;
        b=YYwtUYEwJ86x9rDamH/d1OfHLVxi3Z+5XGejkvJM4xPQII3wODn6442r7KqaA43TsX
         9Ls/GVSO+6XaXL3NrnJIah7rMDEtzFnXgTCgnlxds14J44K2a2XisleKq49LhVpxPgcV
         tpTaAj91HjM+sAkxhDWy1dPNZxM/Ywezqvn0P00gXvc5T+FohlEmrKL9k/UtKAO135CQ
         3k7JsUf6LBEwLdGhjGNJKTCWX9SIEODFs0BADYANUpU+umFaDcDt6KqLWUkurMRegynM
         pa3Uqs8Tei+4fhymk13omxfQOxuZUen6HzudZ0JP97xERzPVxAbJh0xuossBVhcmvbd7
         V8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6AOkLlwuybn5QUKCBXJB6MO5HcsFkduQo3SQQbLA8/A=;
        b=L7/jqNGT7+u9dQ1U0RZ2O0m8qHNPF2ABpHjQQtQ+Xm5ZktoDDXEnC972O9pPWlMf6y
         Bf0gF98AyZLUEeOWBFVRGunnAhph7RJqhLe6yqyilWzvkEKDoSy1Si/W5GQ0l3+T9qt9
         ivzBaipxU6PvAi6qP9zJRc582+Tc16xSt0O8GuGITmARRD/wqsc5ctxxoN0LOEM3cFYx
         CCAWSOKqLKLixL8PiUQsNzsCTAYLkqep6xAd6WPOQjniYG5P1TWOWZUVj6wtt3MUWi3G
         ztIH9bYHyOqH5F84B9VKmz5fPC8j/JYZ7Rg8PU4mp48VQIpW2JY9rw2l6KiLI0ZitbwA
         VpcA==
X-Gm-Message-State: APjAAAVTA5s9bnGQghghgvO5LyhVLBsuoD2H7zimraezKeg2URX7XdrQ
        35PqMDQ/uZO9IrByVRJI+Rl4
X-Google-Smtp-Source: APXvYqzRWK4OgVuq2ai7BmvLfyxp7k+r3mMQTbLftGqsz9Ks8JO0vsWniMJl7FTCUaCwx1gckmm+3A==
X-Received: by 2002:a62:e21a:: with SMTP id a26mr10664076pfi.80.1570102431656;
        Thu, 03 Oct 2019 04:33:51 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id g12sm3020757pfb.97.2019.10.03.04.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 04:33:51 -0700 (PDT)
Date:   Thu, 3 Oct 2019 21:33:45 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v4 3/8] ext4: introduce new callback for IOMAP_REPORT
 operations
Message-ID: <cb2dcb6970da1b53bdf85583f13ba2aaf1684e96.1570100361.git.mbobrowski@mbobrowski.org>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570100361.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As part of ext4_iomap_begin() cleanups and port across direct I/O path
to make use of iomap infrastructure, we split IOMAP_REPORT operations
into a separate ->iomap_begin() handler.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/ext4.h  |   1 +
 fs/ext4/file.c  |   6 ++-
 fs/ext4/inode.c | 129 ++++++++++++++++++++++++++++--------------------
 3 files changed, 80 insertions(+), 56 deletions(-)

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
index caeb3dec0dec..1dace576b8bd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3439,6 +3439,72 @@ static int ext4_set_iomap(struct inode *inode, struct iomap *iomap, u16 type,
 	return 0;
 }
 
+static u16 ext4_iomap_check_delalloc(struct inode *inode,
+				     struct ext4_map_blocks *map)
+{
+	struct extent_status es;
+	ext4_lblk_t end = map->m_lblk + map->m_len - 1;
+
+	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, map->m_lblk,
+				  end, &es);
+
+	/* Entire range is a hole */
+	if (!es.es_len || es.es_lblk > end)
+		return IOMAP_HOLE;
+	if (es.es_lblk <= map->m_lblk) {
+		ext4_lblk_t offset = 0;
+
+		if (es.es_lblk < map->m_lblk)
+			offset = map->m_lblk - es.es_lblk;
+		map->m_lblk = es.es_lblk + offset;
+		map->m_len = es.es_len - offset;
+		return IOMAP_DELALLOC;
+	}
+
+	/* Range starts with a hole */
+	map->m_len = es.es_lblk - map->m_lblk;
+	return IOMAP_HOLE;
+}
+
+static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
+				   loff_t length, unsigned flags,
+				   struct iomap *iomap)
+{
+	int ret;
+	u16 type = 0;
+	struct ext4_map_blocks map;
+	u8 blkbits = inode->i_blkbits;
+	unsigned long first_block, last_block;
+
+	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
+		return -EINVAL;
+	first_block = offset >> blkbits;
+	last_block = min_t(loff_t, (offset + length - 1) >> blkbits,
+			   EXT4_MAX_LOGICAL_BLOCK);
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
+	map.m_lblk = first_block;
+	map.m_len = last_block = first_block + 1;
+	ret = ext4_map_blocks(NULL, inode, &map, 0);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		type = ext4_iomap_check_delalloc(inode, &map);
+	return ext4_set_iomap(inode, iomap, type, first_block, &map);
+}
+
+const struct iomap_ops ext4_iomap_report_ops = {
+	.iomap_begin = ext4_iomap_begin_report,
+};
+
 static int ext4_iomap_alloc(struct inode *inode,
 			    unsigned flags,
 			    unsigned long first_block,
@@ -3498,12 +3564,10 @@ static int ext4_iomap_alloc(struct inode *inode,
 static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			    unsigned flags, struct iomap *iomap)
 {
-	u16 type = 0;
-	unsigned int blkbits = inode->i_blkbits;
-	unsigned long first_block, last_block;
-	struct ext4_map_blocks map;
-	bool delalloc = false;
 	int ret;
+	struct ext4_map_blocks map;
+	u8 blkbits = inode->i_blkbits;
+	unsigned long first_block, last_block;
 
 	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
 		return -EINVAL;
@@ -3511,64 +3575,21 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	last_block = min_t(loff_t, (offset + length - 1) >> blkbits,
 			   EXT4_MAX_LOGICAL_BLOCK);
 
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
+	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
+		return -ERANGE;
 
 	map.m_lblk = first_block;
 	map.m_len = last_block - first_block + 1;
 
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
-
-			if (!es.es_len || es.es_lblk > end) {
-				/* entire range is a hole */
-			} else if (es.es_lblk > map.m_lblk) {
-				/* range starts with a hole */
-				map.m_len = es.es_lblk - map.m_lblk;
-			} else {
-				ext4_lblk_t offs = 0;
-
-				if (es.es_lblk < map.m_lblk)
-					offs = map.m_lblk - es.es_lblk;
-				map.m_lblk = es.es_lblk + offs;
-				map.m_len = es.es_len - offs;
-				delalloc = true;
-			}
-		}
-	} else if (flags & IOMAP_WRITE) {
+	if (flags & IOMAP_WRITE)
 		ret = ext4_iomap_alloc(inode, flags, first_block, &map);
-	} else {
+	else
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
-		if (ret < 0)
-			return ret;
-	}
 
 	if (ret < 0)
 		return ret;
-
-	if (!ret)
-		type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
-	return ext4_set_iomap(inode, iomap, type, first_block, &map);
+	return ext4_set_iomap(inode, iomap, ret ? 0 : IOMAP_HOLE, first_block,
+			      &map);
 }
 
 static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
-- 
2.20.1

