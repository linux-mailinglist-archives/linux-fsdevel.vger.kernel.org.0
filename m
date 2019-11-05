Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB6BEFCD3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 13:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbfKEMAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 07:00:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40393 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfKEMAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:00:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id r4so15139757pfl.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Nov 2019 04:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9DvOG+Bzv+9J/Y7WvEj6a/mdMF4pBTR9bq5BO8IzC1o=;
        b=IySyQPBdtAQQIY0PRyNHAxgm2468OhiEY0eml6eaF/5afuGwHCwY63QklmMHmzDrVn
         0b69uPXsT2MreXOnf6JKXXxTXnvKZ/eHUPLBSffZ1NgLL1tsCeEDMin7T0JRamYTp8Gl
         mKe/gQHgPCywWAoWrVqWiM/fnY7TbCGfbU794PH/6IN5T7OA+S0xs/iHRpGw4gMOnEQK
         kBsniYMYpS8GF2a/SVHrlAz0f7F5CXDQ9oKvp6DTlLBnqPeFrZqOdXU4iSPenKvnhcYq
         fEbVJS9qN2yqD9l27dPRD4CHeTDpGBb3qPx1fVGdV1TWfbVkW+4uS9kD4eDq0HjDJB/Q
         jb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9DvOG+Bzv+9J/Y7WvEj6a/mdMF4pBTR9bq5BO8IzC1o=;
        b=ff9O361os5E1+kKYPXZ6PcAiIk7QNT2AZf6JOEBkz/CIPXD/P+sWoH5NhurUNwMpkQ
         bf0eHhVG4251Bh8l9TLxLDxKPL6TpBZtLfnyj7vhscBqyQK95M42reSa21+rYEt6NeWY
         JB3XKVB1gmMkKvFsx3cBjcI1ohM1On2Pug53b++bOWFtxTm1/wve0SpYUlmAxGSAmWxs
         G5nApAuMwgQbu4Zqaiw85pvP24mjwm7BK8LIvdCrwcG2HBzjsevDhCqwWgvxVqyBfZ7k
         JrU/CPapagHUgopZkfg5yknJjybYucnUXHbrvYcQS278a8ho1RY43XtFLTrRueCrVTCv
         Bo4w==
X-Gm-Message-State: APjAAAVjnxfUDxcTFKE4b9wHZVX/WGFrtml1JV7jypGXVGWxtVpupJWl
        wVM0ID+kxlGQoulWGehKlzsN
X-Google-Smtp-Source: APXvYqx7GKubfC6doj+f7ebYapYbfwM+Ry9OnpW/snQnOT6awK9qf7gNmUrlqaH9hSBdoAbNO4EsLQ==
X-Received: by 2002:a63:1703:: with SMTP id x3mr36987546pgl.263.1572955202310;
        Tue, 05 Nov 2019 04:00:02 -0800 (PST)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id e8sm22115227pga.17.2019.11.05.03.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 04:00:01 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:59:56 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: [PATCH v7 04/11] ext4: move set iomap routines into a separate
 helper ext4_set_iomap()
Message-ID: <1ea34da65eecffcddffb2386668ae06134e8deaf.1572949325.git.mbobrowski@mbobrowski.org>
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

Separate the iomap field population code that is currently within
ext4_iomap_begin() into a separate helper ext4_set_iomap(). The intent
of this function is self explanatory, however the rationale behind
taking this step is to reeduce the overall clutter that we currently
have within the ext4_iomap_begin() callback.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 90 ++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b422d9b8c0bd..9e1ac9fe816b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3448,10 +3448,54 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	return inode->i_state & I_DIRTY_DATASYNC;
 }
 
+static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
+			   struct ext4_map_blocks *map, loff_t offset,
+			   loff_t length)
+{
+	u8 blkbits = inode->i_blkbits;
+
+	/*
+	 * Writes that span EOF might trigger an I/O size update on completion,
+	 * so consider them to be dirty for the purpose of O_DSYNC, even if
+	 * there is no other metadata changes being made or are pending.
+	 */
+	iomap->flags = 0;
+	if (ext4_inode_datasync_dirty(inode) ||
+	    offset + length > i_size_read(inode))
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
+	/*
+	 * Flags passed to ext4_map_blocks() for direct I/O writes can result
+	 * in m_flags having both EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits
+	 * set. In order for any allocated unwritten extents to be converted
+	 * into written extents correctly within the ->end_io() handler, we
+	 * need to ensure that the iomap->type is set appropriately. Hence, the
+	 * reason why we need to check whether the EXT4_MAP_UNWRITTEN bit has
+	 * been set first.
+	 */
+	if (map->m_flags & EXT4_MAP_UNWRITTEN) {
+		iomap->type = IOMAP_UNWRITTEN;
+		iomap->addr = (u64) map->m_pblk << blkbits;
+	} else if (map->m_flags & EXT4_MAP_MAPPED) {
+		iomap->type = IOMAP_MAPPED;
+		iomap->addr = (u64) map->m_pblk << blkbits;
+	} else {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+	}
+}
+
 static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	unsigned int blkbits = inode->i_blkbits;
 	unsigned long first_block, last_block;
 	struct ext4_map_blocks map;
@@ -3565,47 +3609,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			return ret;
 	}
 
-	/*
-	 * Writes that span EOF might trigger an I/O size update on completion,
-	 * so consider them to be dirty for the purposes of O_DSYNC, even if
-	 * there is no other metadata changes being made or are pending here.
-	 */
-	iomap->flags = 0;
-	if (ext4_inode_datasync_dirty(inode) ||
-	    offset + length > i_size_read(inode))
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
-		/*
-		 * Flags passed into ext4_map_blocks() for direct I/O writes
-		 * can result in m_flags having both EXT4_MAP_MAPPED and
-		 * EXT4_MAP_UNWRITTEN bits set. In order for any allocated
-		 * unwritten extents to be converted into written extents
-		 * correctly within the ->end_io() handler, we need to ensure
-		 * that the iomap->type is set appropriately. Hence the reason
-		 * why we need to check whether EXT4_MAP_UNWRITTEN is set
-		 * first.
-		 */
-		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
-			iomap->type = IOMAP_UNWRITTEN;
-		} else if (map.m_flags & EXT4_MAP_MAPPED) {
-			iomap->type = IOMAP_MAPPED;
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

