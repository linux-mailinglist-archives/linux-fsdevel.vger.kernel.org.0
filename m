Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4AAEFCE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 13:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbfKEMDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 07:03:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44104 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730816AbfKEMDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:03:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id q16so9296850pll.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Nov 2019 04:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cFgPyT+ODS1OrE0hwd9zKr2rgvqb/PsZ4tSjiSvlbbI=;
        b=tM4Lzb8r0Y3azoMYlfMr2tjxpkD/t7EJ1W+mHQD92JAZkhZunDsIbNAgsVmy4HAx2A
         6XKVJ9zMtcDBeHKOrEFwttX7/gYRBPxxLztFmcYKxf+awDYrMblE8mC5ag+3B20Hxk8B
         ci4OKEqZLcDocpfv++pNjbpTt06caKr8nEOZyIisK9ccoyDIeRgJJn6WZQQBM9khjFuK
         7Ta/owPGktqqQnwatf170XRX5YtaAzsgbyEUZeqsSbfc9F7qFUHTjHfww5Q4peJ9ndq+
         +aHm+wsTZAIOezIPc4XV7P4zEXsuP/MuC3UcoVRfwejs74M4sZ8ieJuR9yBRNu4ypS3Y
         X2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cFgPyT+ODS1OrE0hwd9zKr2rgvqb/PsZ4tSjiSvlbbI=;
        b=DPMpQrxwdE86D/IBN6OmbSLYPHtt/yMg8F421xfDJbt0cJXluCvLDfDIEqcNVyKFmP
         An2KrxjUKNAi8V4QwME05XdioPxaFZkMaHbyceKsAvCWAf4f9r4v/h0yTkZ/14ejB2yB
         Foy5OrkeT/vPFOjt/C7XKSfzpQp4ZMFAanC0m6JNsLXzMXur1PCuHHtX4gI1GPcj4uKn
         keZRU+FdotjaMy5Wh6Z0pSq/FhqlfnVP+QCFEin4AXluxw8qQggqrZ2yOa4JfcBmptxu
         kQ4XMQhQlfkeAI4Qv7FbiV9TIDrZrHvijVaerLRRAvkLXAah7Vdk3f888DHmNb0Zo7nB
         phOg==
X-Gm-Message-State: APjAAAWSml9nqZYTS4aTyR4k+gLNLX9+Dzbjd8iqoIIrs7X/pQ/Jq9GE
        a4AVlajSQeqTu8OXMAezM7WOzrzbtA==
X-Google-Smtp-Source: APXvYqy//gLInV/z0P1L70ZmRo5JX29PhNoALIeBgwlxEJoIk1PjOVNaCNOIr+X57s2rUsVBZUhuTw==
X-Received: by 2002:a17:902:7c8f:: with SMTP id y15mr5008661pll.341.1572955417149;
        Tue, 05 Nov 2019 04:03:37 -0800 (PST)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id n3sm21268023pff.102.2019.11.05.04.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 04:03:36 -0800 (PST)
Date:   Tue, 5 Nov 2019 23:03:31 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: [PATCH v7 06/11] ext4: introduce new callback for IOMAP_REPORT
Message-ID: <5c97a569e26ddb6696e3d3ac9fbde41317e029a0.1572949325.git.mbobrowski@mbobrowski.org>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572949325.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As part of the ext4_iomap_begin() cleanups that precede this patch, we
also split up the IOMAP_REPORT branch into a completely separate
->iomap_begin() callback named ext4_iomap_begin_report(). Again, the
raionale for this change is to reduce the overall clutter within
ext4_iomap_begin().

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/ext4.h  |   1 +
 fs/ext4/file.c  |   6 ++-
 fs/ext4/inode.c | 134 +++++++++++++++++++++++++++++-------------------
 3 files changed, 85 insertions(+), 56 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3616f1b0c987..5c6c4acea8b1 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3388,6 +3388,7 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
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
index b540f2903faa..b5ba6767b276 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3553,74 +3553,32 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
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
@@ -3682,6 +3640,74 @@ const struct iomap_ops ext4_iomap_ops = {
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
+	offset = map->m_lblk - es.es_lblk;
+	map->m_len = es.es_len - offset;
+
+	return true;
+}
+
+static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
+				   loff_t length, unsigned int flags,
+				   struct iomap *iomap, struct iomap *srcmap)
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
+	 * Calculate the first and last logical block respectively.
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

