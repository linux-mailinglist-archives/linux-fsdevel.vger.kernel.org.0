Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED3CDE7CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 11:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJUJSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 05:18:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35872 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUJSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:18:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23so7419076pgk.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 02:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uhr7V5NpNUmBS09lYlHI9gm1T70q5nld9gXzZNWIP9M=;
        b=EjfnoZXGJCECXhbJyNT0mLZaadAz1pzvclgYndAIeDR7+1q/NIFOrHKM2wHklXkJrh
         V5a7L6lx6z0YYYCj0YY1AzzEvoIhASLPi/Bnb7xQ6n8uxBvz9oTmjPNbqPW+t53z+Oei
         faZzl856guL090GeKvvB8iKM4iaB1Z6nDUkwCA3dpmaxQNjBCfKewRPEgl6ZFsUakeuV
         slo/Be322+qVqlLVtI3Qbr5Qu2/kH/10Et94HBkdlKYDZaM58asHacVGuanvO5C7ekrh
         c8Gtia0h3VYeNoGqZBLD+7IFrXucQsfoFRt45tUPSD/Hz2xIsehyrT1OOcZj9F1bMnc1
         pcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uhr7V5NpNUmBS09lYlHI9gm1T70q5nld9gXzZNWIP9M=;
        b=qrOP110b49/6tFUnYyYLkFcUIHXVuAz+U4498+U8HCkpxhd6HsSXwD53uTwczc1jqJ
         d5S1e4KToWfVLAh3FwokUv4RtfV5Rg1UN5rLnCdqb7snnT1PC9DXdwEBFjS57hK3uh+E
         /pn+KHXcpjYZeHTsiQpyc5iSZll6clDEAIP2WPsQ8cHeW7stf7as5ImILpgipz/LnGlV
         becAYk99qTFA3r85SNK42iSeqAvPC/ErhVgIn1WZ3yThazEWx8cbfnwwTbWZeslaaAGA
         yrvMCxkxKffuAKh0HQyWHdvL5U7FkssfI/8G13GcvgwebtA5OiMotfKb2uXjvns7UwyX
         kTcg==
X-Gm-Message-State: APjAAAXT9iSSrEWWs1MxRSiL67F09nCOKKEKzlhqzZRCq5Jbvycrnafx
        NvHw/C1dpQN9UZYBRPLy8Ql+
X-Google-Smtp-Source: APXvYqyV7bc+piwPPiOLGo6jLn+l79FNZIn6V8gm1yfcG4jB0kG80Kwu/HyrfxTDoV0i8qV6Ye3XkQ==
X-Received: by 2002:a17:90a:cb0b:: with SMTP id z11mr27695975pjt.122.1571649487060;
        Mon, 21 Oct 2019 02:18:07 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id x65sm16867815pgb.75.2019.10.21.02.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:18:06 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:18:00 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v5 03/12] ext4: split IOMAP_WRITE branch in
 ext4_iomap_begin() into helper
Message-ID: <80f6c773a80a731c5c1f5e4d8ebb75d6da58a587.1571647179.git.mbobrowski@mbobrowski.org>
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

In preparation for porting across the ext4 direct I/O path for reads
and writes over to the iomap infrastructure, split up the IOMAP_WRITE
chunk of code into a separate helper ext4_alloc_iomap(). This way,
when we add the necessary bits for direct I/O, we don't end up with
ext4_iomap_begin() becoming a behemoth twisty maze.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/inode.c | 112 ++++++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 52 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0dd29ae5cc8c..3dc92bd8a944 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3442,6 +3442,62 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
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
+	 * already allocated and and unwritten. In that case, the extent
+	 * conversion fits into the credits too.
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
+	 * If we have allocated blocks beyond EOF, we need to ensure that
+	 * they're truncated if we crash before updating the inode size
+	 * metadata within ext4_iomap_end(). For faults, we don't need to do
+	 * that (and cannot due to the orphan list operations needing an
+	 * inode_lock()). If we happen to instantiate blocks beyond EOF, it is
+	 * because we race with a truncate operation, which already has added
+	 * the inode onto the orphan list.
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
 static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			    unsigned flags, struct iomap *iomap)
 {
@@ -3502,62 +3558,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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

--<M>--
