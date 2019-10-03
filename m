Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B77F8C9D65
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 13:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfJCLdh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 07:33:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45051 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbfJCLdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:33:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so1557054pfn.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2019 04:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+N688scx55BcMGJgY/zOCjDlwz2KzjSE8ddaPohFY0E=;
        b=zzKOzKKZtly+mFN3ealckpbKhxnAwGijM0px+Gds+HuFC/E8eo8ztmS6FEOC7Hk3SL
         0rQf0bc+5OkOErLHFbrCyi+uN0yB3/LVzeOpqwPlOZVXBU1/XyClzP+77hxS/nBmxuK0
         mjqUC0Trvo6mHIuZTlqW5UXVZiriqE4tKVr/SVM+Ykz3u8x7G/1QfAMzFB0uYzzTBZjQ
         sYhSliffJJIt+vp590WhLOb5+EH2BXhU0K9RqQrOuPh/0PrK1+h/NjlCYzH5jq2fsW69
         iJM/jB07b2JlpGmfAobubgqLYmQXK5imbA+fi0X6Wj21t+4aphisEbNqyHLxgX3mjVL7
         J72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+N688scx55BcMGJgY/zOCjDlwz2KzjSE8ddaPohFY0E=;
        b=VSEi1YOW24Y3ORqZJvfYL0u8aY+6scexYs2jJ0d6LIPeEX/Z/WQXawFKgiVdYiB21a
         mzo9IM5EdtBTWEyM+DY1pcD8QxN/Keovm5p2w3sJEp4dyNX8jd/Y7y1/RlZ1yKIC2aEK
         sr0RwurJCafFSIAF5cseFiw9ehK0AD4YfdM5YFoZLZb1xLyBSALqrYHdnppVss0kpDal
         28VuKd0quPBjWrg41+8Pk7MHPHIKI0/jTTCD8BG2ryZc1SMW0y6uvPlkDF0gaj+WgPj8
         uF1vPIydLzayYLHUF1TJWAS84BM9UrSkFbApXwcBqpwnuVnpfss4GurcFREGqeHMyCgA
         e78w==
X-Gm-Message-State: APjAAAWGX6n0NVjhNz+9z8wj7U57OSYCtHCBytj2q3zMyJHPqZaBGnSO
        ikBqOJ7+OhO2Oy8aD9FcTbeW
X-Google-Smtp-Source: APXvYqwLy6fkqxzhil1uG0EHPhoAW0xi5uYFwTyd2OdQ1dGiqCwaLfxCRqjX6zouqBurFLss8JPiBw==
X-Received: by 2002:a63:8441:: with SMTP id k62mr5855049pgd.257.1570102416474;
        Thu, 03 Oct 2019 04:33:36 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id w7sm1791303pjn.1.2019.10.03.04.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 04:33:35 -0700 (PDT)
Date:   Thu, 3 Oct 2019 21:33:29 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v4 2/8] ext4: move out IOMAP_WRITE path into separate helper
Message-ID: <99b317af0f20a170fba2e70695d7cca1597fb19a.1570100361.git.mbobrowski@mbobrowski.org>
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

In preparation for porting across the direct I/O path to iomap, split
out the IOMAP_WRITE logic into a separate helper. This way, we don't
need to clutter the ext4_iomap_begin() callback.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/inode.c | 110 ++++++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 50 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1ccdc14c4d69..caeb3dec0dec 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3439,6 +3439,62 @@ static int ext4_set_iomap(struct inode *inode, struct iomap *iomap, u16 type,
 	return 0;
 }
 
+static int ext4_iomap_alloc(struct inode *inode,
+			    unsigned flags,
+			    unsigned long first_block,
+			    struct ext4_map_blocks *map)
+{
+	handle_t *handle;
+	u8 blkbits = inode->i_blkbits;
+	int ret, dio_credits, retries = 0;
+
+	/*
+	 * Trim mapping request to the maximum value that we can map
+	 * at once for direct I/O.
+	 */
+	if (map->m_len > DIO_MAX_BLOCKS)
+		map->m_len = DIO_MAX_BLOCKS;
+	dio_credits = ext4_chunk_trans_blocks(inode, map->m_len);
+retry:
+	/*
+	 * Either we allocate blocks and then we don't get unwritten
+	 * extent so we have reserved enough credits, or the blocks
+	 * are already allocated and unwritten. In that case, the
+	 * extent conversion fits in the credits as well.
+	 */
+	handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS, dio_credits);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	ret = ext4_map_blocks(handle, inode, map, EXT4_GET_BLOCKS_CREATE_ZERO);
+	if (ret < 0)
+		goto journal_stop;
+
+	/*
+	 * If we have allocated blocks beyond the EOF, we need to make
+	 * sure that they get truncate if we crash before updating the
+	 * inode size metadata in ext4_iomap_end(). For faults, we
+	 * don't need to do that (and cannot due to the orphan list
+	 * operations needing an inode_lock()). If we happen to
+	 * instantiate blocks beyond EOF, it is because we race with a
+	 * truncate operation, which already has added the inode onto
+	 * the orphan list.
+	 */
+	if (!(flags & IOMAP_FAULT) && first_block + map->m_len >
+	    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
+		int err;
+
+		err = ext4_orphan_add(handle, inode);
+		if (err < 0)
+			ret = err;
+	}
+journal_stop:
+	ext4_journal_stop(handle);
+	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+		goto retry;
+	return ret;
+}
+
 static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			    unsigned flags, struct iomap *iomap)
 {
@@ -3500,62 +3556,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			}
 		}
 	} else if (flags & IOMAP_WRITE) {
-		int dio_credits;
-		handle_t *handle;
-		int retries = 0;
-
-		/* Trim mapping request to maximum we can map at once for DIO */
-		if (map.m_len > DIO_MAX_BLOCKS)
-			map.m_len = DIO_MAX_BLOCKS;
-		dio_credits = ext4_chunk_trans_blocks(inode, map.m_len);
-retry:
-		/*
-		 * Either we allocate blocks and then we don't get unwritten
-		 * extent so we have reserved enough credits, or the blocks
-		 * are already allocated and unwritten and in that case
-		 * extent conversion fits in the credits as well.
-		 */
-		handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS,
-					    dio_credits);
-		if (IS_ERR(handle))
-			return PTR_ERR(handle);
-
-		ret = ext4_map_blocks(handle, inode, &map,
-				      EXT4_GET_BLOCKS_CREATE_ZERO);
-		if (ret < 0) {
-			ext4_journal_stop(handle);
-			if (ret == -ENOSPC &&
-			    ext4_should_retry_alloc(inode->i_sb, &retries))
-				goto retry;
-			return ret;
-		}
-
-		/*
-		 * If we added blocks beyond i_size, we need to make sure they
-		 * will get truncated if we crash before updating i_size in
-		 * ext4_iomap_end(). For faults we don't need to do that (and
-		 * even cannot because for orphan list operations inode_lock is
-		 * required) - if we happen to instantiate block beyond i_size,
-		 * it is because we race with truncate which has already added
-		 * the inode to the orphan list.
-		 */
-		if (!(flags & IOMAP_FAULT) && first_block + map.m_len >
-		    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
-			int err;
-
-			err = ext4_orphan_add(handle, inode);
-			if (err < 0) {
-				ext4_journal_stop(handle);
-				return err;
-			}
-		}
-		ext4_journal_stop(handle);
+		ret = ext4_iomap_alloc(inode, flags, first_block, &map);
 	} else {
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
 		if (ret < 0)
 			return ret;
 	}
 
+	if (ret < 0)
+		return ret;
+
 	if (!ret)
 		type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
 	return ext4_set_iomap(inode, iomap, type, first_block, &map);
-- 
2.20.1

