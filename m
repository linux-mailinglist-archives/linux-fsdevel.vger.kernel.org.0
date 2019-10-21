Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDF4DE7C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 11:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfJUJRj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 05:17:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39870 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJUJRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:17:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id p12so7412167pgn.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 02:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rUMwzfPqQnexCuPnoPPRBkWR9Nj5O+UH+rMWyIHFImE=;
        b=EkRgWNsitfbghj5GOO4WW5mAgLl4I6+Rzu1urruuR4nJX08alERyRdRbv0ttXkaand
         FHPMFL3258iDVa+3/L/8tHJ9yADNLwLYvkbzoKi5fmt3vjWKW8DLv7nOwFohFZs9Ntjz
         4MOL+4BSZKFhpfk3PYMXN1uRxsLlJKC8BPqUCNShJbDJHgnpnf5hD6QkntjeOORdjiKu
         vTb8lwOpDY73NU6ZyYsRAlvuN/BKpdY/s8m99MdhJgbyNDY9TTYixFjrHHyXIm07PXgF
         kwZA9ILo4FWm0E6HsNpSU17epMZ7iqSGXgRXJh2WbaX3seOoINCSoUTaOoqKCbo6W14C
         kblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rUMwzfPqQnexCuPnoPPRBkWR9Nj5O+UH+rMWyIHFImE=;
        b=Yp5Tpy2uIkzKJeLNDrVlV67FyeCaNj5vwO5vQlz9mcCMzqixwMPd4IkHvrmFS+2hha
         it6cSR4CqDJousFNkGigW+fbPXoDsYzqj+kk/tq93Gz/MQJeJc99xhvD9hsLvdet3+6p
         N/4AQne6dOQmQY7k9gbKbI8V1XTLEkd/uMMSAM2QSmI5J6K8IsR4xFH3AIMGC6i0Maqb
         EqmSkWIWKKpIeGi5QnZ9sVJTRJOcCUD/6mB6UqYC6v+syr77uUMDYTMqpiAZejICF2C5
         SKtz6hGy9AKwrz0IRqLhiR75kpWYRv6sQY0NM8dIDJo15XbV/XdNI1SRG+zGpft/DJHM
         5E7w==
X-Gm-Message-State: APjAAAUW2LqbtJzv7hWX01/0K1YNGMHdHVyDpw6OUHEQrIGGQmzPc3AL
        Kj757hq6q/oXp1ZLQRgQSZhP
X-Google-Smtp-Source: APXvYqxE9774p0aEzmEmorzugllFUqXlybztcuqnF4ec1gMYAAn1YGq8IdSSgwMXAQNmQqP+EVgBJw==
X-Received: by 2002:a63:a055:: with SMTP id u21mr24321471pgn.102.1571649458487;
        Mon, 21 Oct 2019 02:17:38 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id r30sm15297972pfl.42.2019.10.21.02.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:17:37 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:17:31 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v5 01/12] ext4: move set iomap routines into separate helper
 ext4_set_iomap()
Message-ID: <7dd1a1a895fd7e55c659b10bba16976faab4cd85.1571647178.git.mbobrowski@mbobrowski.org>
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

Separate the iomap field population chunk of code that is currently
within ext4_iomap_begin() into a new helper called
ext4_set_iomap(). The intent of this function is self explanatory,
however the rationale behind doing so is to also reduce the overall
clutter that we currently have within the ext4_iomap_begin() callback.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/inode.c | 59 +++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 516faa280ced..158eea9a1944 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3406,10 +3406,39 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	return inode->i_state & I_DIRTY_DATASYNC;
 }
 
+static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
+			   struct ext4_map_blocks *map, loff_t offset,
+			   loff_t length)
+{
+	u8 blkbits = inode->i_blkbits;
+
+	iomap->flags = 0;
+	if (ext4_inode_datasync_dirty(inode))
+		iomap->flags |= IOMAP_F_DIRTY;
+
+	if (map->m_flags & EXT4_MAP_NEW)
+		iomap->flags |= IOMAP_F_NEW;
+
+	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
+	iomap->offset = (u64) map->m_lblk << blkbits;
+	iomap->length = (u64) map->m_len << blkbits;
+
+	if (map->m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)) {
+		if (map->m_flags & EXT4_MAP_MAPPED)
+			iomap->type = IOMAP_MAPPED;
+		else if (map->m_flags & EXT4_MAP_UNWRITTEN)
+			iomap->type = IOMAP_UNWRITTEN;
+		iomap->addr = (u64) map->m_pblk << blkbits;
+	} else {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+	}
+}
+
 static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			    unsigned flags, struct iomap *iomap)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	unsigned int blkbits = inode->i_blkbits;
 	unsigned long first_block, last_block;
 	struct ext4_map_blocks map;
@@ -3523,31 +3552,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			return ret;
 	}
 
-	iomap->flags = 0;
-	if (ext4_inode_datasync_dirty(inode))
-		iomap->flags |= IOMAP_F_DIRTY;
-	iomap->bdev = inode->i_sb->s_bdev;
-	iomap->dax_dev = sbi->s_daxdev;
-	iomap->offset = (u64)first_block << blkbits;
-	iomap->length = (u64)map.m_len << blkbits;
-
-	if (ret == 0) {
-		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
-		iomap->addr = IOMAP_NULL_ADDR;
-	} else {
-		if (map.m_flags & EXT4_MAP_MAPPED) {
-			iomap->type = IOMAP_MAPPED;
-		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
-			iomap->type = IOMAP_UNWRITTEN;
-		} else {
-			WARN_ON_ONCE(1);
-			return -EIO;
-		}
-		iomap->addr = (u64)map.m_pblk << blkbits;
-	}
-
-	if (map.m_flags & EXT4_MAP_NEW)
-		iomap->flags |= IOMAP_F_NEW;
+	ext4_set_iomap(inode, iomap, &map, offset, length);
+	if (delalloc && iomap->type == IOMAP_HOLE)
+		iomap->type = IOMAP_DELALLOC;
 
 	return 0;
 }
-- 
2.20.1

--<M>--
