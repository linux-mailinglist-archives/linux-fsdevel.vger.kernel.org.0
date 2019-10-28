Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73251E6FF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 11:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbfJ1KwU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 06:52:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38357 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730933AbfJ1KwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:52:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id c13so6653291pfp.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 03:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O4XNryIx8YarFTM6JxSehZON+26PJYhWJHjyK+bvHnw=;
        b=pHpFwWBAVWX7Hh/xJENmt6rr76MjiohwtoLkEj6l++53QShJjEBSErJi+jS+V64Zli
         AmYGOMGMIoI3rG55iPoJxOXtrwPaLPmhdJXMqYQVtrniDiPYhPy2ootXRfy6wlhEoE5e
         ZxNIE2ABxHgFdP0umdfPzd3F5ItRniZh6vSXUQcap6fGDD1plhrXwfK9quc1kZymIYOi
         Zft9bPKjpOPfXZ3IaW0ApAsty1xfelff2IWj+9wz1oLnV+rQqe2HHu72w+3QU+/H+qIH
         mA60OnzZn64r77UsORMpzspDXCv79HXEWZCKdaKexw6sW47qVyY/Ni4N6LxkBYvMtv4T
         Q3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O4XNryIx8YarFTM6JxSehZON+26PJYhWJHjyK+bvHnw=;
        b=K9XDmo77Arpthd4xrxfoz16V6wnVi3XxRkQ04lRxE9AL75jUM7+ayUi9H4ykw5pxN0
         vv6mTVrt/pNYZUhBJVDGEugy/9tBdvCW83ZuBvfrGo6qt6btQbnVtHJfhaI+r6LEXMHX
         Cd8abTmiTxcE2RJQ0anPaoRMqiFNFfRzHyPRY41zfFgGT6zpjbC2hNHM+41tLkcqKIv2
         63mLeLD4TZuQRCNOISQcMk9An/vOr/u/6CiAKv2foFYHRww32PUgnS3tQz1hdW/ywjo6
         ze7JnTx7Je7T0Vf2/+qgU3ydu3hB9Qv4z993TAZsw9RWq+LGuen8lZ5yvImAVxFpWttr
         4FRg==
X-Gm-Message-State: APjAAAXYaOw0wgDUeIs6sBXVXdVm+xbvaXr1wSsqhXd/m+d+NlcAhGXu
        SbXNJn/wwr6Kg+EkwjPvfrpb
X-Google-Smtp-Source: APXvYqwvbWdHKLanX82SlOMLhrPo6UDi2scS/nQtXxZ79yL1nnboGnUBBqrIiv1Ce+NjLuuPRJqyVQ==
X-Received: by 2002:a63:b5b:: with SMTP id a27mr20774244pgl.262.1572259939758;
        Mon, 28 Oct 2019 03:52:19 -0700 (PDT)
Received: from poseidon.bobrowski.net (d114-78-127-22.bla803.nsw.optusnet.com.au. [114.78.127.22])
        by smtp.gmail.com with ESMTPSA id q2sm10889089pfh.34.2019.10.28.03.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 03:52:19 -0700 (PDT)
Date:   Mon, 28 Oct 2019 21:52:13 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v6 06/11] ext4: introduce new callback for IOMAP_REPORT
Message-ID: <1c115e4dfc0d0b10d195c85dd48271cfc5167580.1572255425.git.mbobrowski@mbobrowski.org>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572255424.git.mbobrowski@mbobrowski.org>
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
---
 fs/ext4/ext4.h  |   1 +
 fs/ext4/file.c  |   6 ++-
 fs/ext4/inode.c | 134 +++++++++++++++++++++++++++++-------------------
 3 files changed, 85 insertions(+), 56 deletions(-)

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
index 325abba6482c..50b4835cd927 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3513,74 +3513,32 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
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
@@ -3642,6 +3600,74 @@ const struct iomap_ops ext4_iomap_ops = {
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

