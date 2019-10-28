Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDECE6FEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 11:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388354AbfJ1Kvj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 06:51:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33792 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388297AbfJ1Kvj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:51:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so6666732pfa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 03:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r8YoWjyUgBX7hg6bA3g/5JaU64FOGb9lDuPU6JwSpsg=;
        b=1xjffGMZQbimtgpqqLmvKbopiqBHlfMzYLjHo/SSClMjFOATCvAgrtpmSxZ0ahHKHN
         DuzetyHRbEk1yFFdUl5WeuyVmz/LZVsNZdvbJ0GCqyFLEDLzmiOJt4zfkk9iEsqJ2nFc
         1heL4zBCw9Z5mOS1+p9s1yQB+t44UbQT7xPkDcc6dyeV3lSW1Q731siVQ6AYSvBEtrY2
         zviYrjCwhK4fLS1PnSyG0gyISXqKl8hLl/yEBbrTEU39bQMkzNllBikbeaX3iNvzxyvp
         y+eBB5aSWxd8uYxj9KtdW2+mp4BYZdz6iYVSByPU2iYFW/8eaTcMjHwY1PYzBi6Fmkj2
         7V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r8YoWjyUgBX7hg6bA3g/5JaU64FOGb9lDuPU6JwSpsg=;
        b=XdpdeMxZvzNlC6yAGlCZPklj2MxEZHQDDb+GKF/BaETNlU+wKdqJoCfHCIHmw3UgQm
         Q3IwINfm/TyiKtC+ft/axfq7iJi1KHCVmD7hnJb7gqaAqGNDG6o9CS+5DoX9SoEFpm5Q
         KrG/lWDG9v94gMijcQo+AkEyCrHQ1LcQgdijo5g7rrrUIM4n6/MAB0oBEXZBE3FYuYoo
         dtrEEvMe8N/OlzrPEdS/eCiTc+iWiBkSKiWLupp+yTf41JeVHAM7ooAO3fCNjqFTYdo5
         MQxE79FkxsYzNn1M/DALAdYx10Aun5fTpmxAiH6yIa3QRWH8YaC7RQSonXQC801fQkI8
         vH8w==
X-Gm-Message-State: APjAAAXl8Ew0+2MFLbv7iqjuFNOENt+vRGWi/mzcD79Sl3ao3m8dCW/I
        BxKHMvHheF51Cs4WAlDWsPu+
X-Google-Smtp-Source: APXvYqxTvUaJSCF/Y1b/4DtjRqpZfhfhH29U0azdsoQkUmCqWhDGIU+P24PhRaiGFQMX1EjPjpWrfQ==
X-Received: by 2002:a17:90a:c717:: with SMTP id o23mr21431592pjt.88.1572259898061;
        Mon, 28 Oct 2019 03:51:38 -0700 (PDT)
Received: from poseidon.bobrowski.net (d114-78-127-22.bla803.nsw.optusnet.com.au. [114.78.127.22])
        by smtp.gmail.com with ESMTPSA id a24sm11430889pgd.93.2019.10.28.03.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 03:51:37 -0700 (PDT)
Date:   Mon, 28 Oct 2019 21:51:31 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v6 04/11] ext4: move set iomap routines into a separate
 helper ext4_set_iomap()
Message-ID: <36c0b0028215ed0a39697512054f3fa4799b0701.1572255425.git.mbobrowski@mbobrowski.org>
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

Separate the iomap field population code that is currently within
ext4_iomap_begin() into a separate helper ext4_set_iomap(). The intent
of this function is self explanatory, however the rationale behind
taking this step is to reeduce the overall clutter that we currently
have within the ext4_iomap_begin() callback.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 92 +++++++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 42 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index da2ca81e3d9c..073b7c873bb2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3406,10 +3406,56 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
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
+	if (map->m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)) {
+		/*
+		 * Flags passed to ext4_map_blocks() for direct I/O writes can
+		 * result in m_flags having both EXT4_MAP_MAPPED and
+		 * EXT4_MAP_UNWRITTEN bits set. In order for any allocated
+		 * unwritten extents to be converted into written extents
+		 * correctly within the ->end_io() handler, we need to ensure
+		 * that the iomap->type is set appropriately. Hence, the reason
+		 * why we need to check whether the EXT4_MAP_UNWRITTEN bit has
+		 * been set first.
+		 */
+		if (map->m_flags & EXT4_MAP_UNWRITTEN)
+			iomap->type = IOMAP_UNWRITTEN;
+		else if (map->m_flags & EXT4_MAP_MAPPED)
+			iomap->type = IOMAP_MAPPED;
+
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
@@ -3523,47 +3569,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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

