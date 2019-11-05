Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94492EFCD5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 13:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfKEMAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 07:00:22 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41793 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfKEMAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:00:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id d29so2936139plj.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Nov 2019 04:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rm51/8A1FKCRPHUWGAek8qkPPsfDsFDO53iwbaAiymA=;
        b=cgWsMGk3ooN4Zx1i2OmisZ2e3J13bSH2R7g3MeS32R8ie1nAI6BiB289EX4mM6VUgX
         nZn3CoVWzehrY3qLXzA2MFDhyOoZpqX7UWH7JgKnJZXbb2fBDh3yQDpgrPXYNQ0C2Qgf
         asH3QROVITNEOl+yWtHEJ7QqNk6UXK7Sip/58rnZl+VjEm0tXL23yiRh21W4Wgy2AeGc
         kokqVnSR8LTbx3W9IA61J4D1hM0orcTdn8N1WYTXpjAEDl3S18GJCXMg8QLCN8dI3HxT
         KZMjFYD6Uk9bOaInP6YA5H1dD+G5m3gbv2fihUB8e0zgPLKn5c2HVqN568tWL/zneYbp
         L6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rm51/8A1FKCRPHUWGAek8qkPPsfDsFDO53iwbaAiymA=;
        b=FIXJfHPeg1XzdL3smD89b1DVGk9wIiZ6ET8yVzSBb+CAnH/wqCTDztBAOWLL1o11PL
         xNXUnmT6Ik0J7w29z3JSZ2nMTo5Ue4Y4Le9JRO65zSxx5vtqrPB9VYoNqNkswHkLuEGX
         ok6RBJwVLKEWJY/6cswimf8TAaKCDSxkuQjAvMunhCTVJtMYd5qofCz5tjGpLYc7Zcz8
         v7N40kb/PAmOna0aOQ7SYn6XY0DE26v9zjtrr1BlkEjrGkt5BPRGg33K+OuLEwXiuxzH
         2iLjwuQ4/96v2fsL8OQ8c/wUFA/kyGrLZQobQDknRrBoY00oDMVK3hiNPx7iUCIFAl7X
         EmNA==
X-Gm-Message-State: APjAAAWu9vhpbAqhA0N84td2S+eoXLY6MP+7fh7/M3YKdiINJAPNJhSY
        UkTIZNoVzJK86NLhjrSzdDL+
X-Google-Smtp-Source: APXvYqx+yuz+55P2OkZTQLdWFLk8ay5ouJrH/tCnzKQV+MRpP8dWD/8n0jFlcPxnqGIx3Owh1cKOog==
X-Received: by 2002:a17:902:7e45:: with SMTP id a5mr9164172pln.315.1572955220806;
        Tue, 05 Nov 2019 04:00:20 -0800 (PST)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id q34sm23038586pjb.15.2019.11.05.04.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 04:00:20 -0800 (PST)
Date:   Tue, 5 Nov 2019 23:00:14 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: [PATCH v7 05/11] ext4: split IOMAP_WRITE branch in
 ext4_iomap_begin() into helper
Message-ID: <50eef383add1ea529651640574111076c55aca9f.1572949325.git.mbobrowski@mbobrowski.org>
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

In preparation for porting across the ext4 direct I/O path over to the
iomap infrastructure, split up the IOMAP_WRITE branch that's currently
within ext4_iomap_begin() into a separate helper
ext4_alloc_iomap(). This way, when we add in the necessary code for
direct I/O, we don't end up with ext4_iomap_begin() becoming a
monstrous twisty maze.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 113 ++++++++++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 52 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9e1ac9fe816b..b540f2903faa 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3493,6 +3493,63 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	}
 }
 
+static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
+			    unsigned int flags)
+{
+	handle_t *handle;
+	u8 blkbits = inode->i_blkbits;
+	int ret, dio_credits, retries = 0;
+
+	/*
+	 * Trim the mapping request to the maximum value that we can map at
+	 * once for direct I/O.
+	 */
+	if (map->m_len > DIO_MAX_BLOCKS)
+		map->m_len = DIO_MAX_BLOCKS;
+	dio_credits = ext4_chunk_trans_blocks(inode, map->m_len);
+
+retry:
+	/*
+	 * Either we allocate blocks and then don't get an unwritten extent, so
+	 * in that case we have reserved enough credits. Or, the blocks are
+	 * already allocated and unwritten. In that case, the extent conversion
+	 * fits into the credits as well.
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
+	 * If we've allocated blocks beyond EOF, we need to ensure that they're
+	 * truncated if we crash before updating the inode size metadata within
+	 * ext4_iomap_end(). For faults, we don't need to do that (and cannot
+	 * due to orphan list operations needing an inode_lock()). If we happen
+	 * to instantiate blocks beyond EOF, it is because we race with a
+	 * truncate operation, which already has added the inode onto the
+	 * orphan list.
+	 */
+	if (!(flags & IOMAP_FAULT) && map->m_lblk + map->m_len >
+	    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
+		int err;
+
+		err = ext4_orphan_add(handle, inode);
+		if (err < 0)
+			ret = err;
+	}
+
+journal_stop:
+	ext4_journal_stop(handle);
+	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+		goto retry;
+
+	return ret;
+}
+
+
 static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
@@ -3553,62 +3610,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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
+		ret = ext4_iomap_alloc(inode, &map, flags);
 	} else {
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
-		if (ret < 0)
-			return ret;
 	}
 
+	if (ret < 0)
+		return ret;
+
 	ext4_set_iomap(inode, iomap, &map, offset, length);
 	if (delalloc && iomap->type == IOMAP_HOLE)
 		iomap->type = IOMAP_DELALLOC;
-- 
2.20.1

