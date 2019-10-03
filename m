Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B83CFC9D5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 13:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfJCLdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 07:33:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42446 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbfJCLdR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:33:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id z12so1584249pgp.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2019 04:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wXJL+3AD3aKOFERUOXOliVqfjgOSq99u8FG7OBy1SCk=;
        b=KiKML+7gTBJuPuoSaPd/QfGV3u0yicjHPF/spLeus1ZoCzv/SM+Hgxxg29JLYpH52D
         NWlZwot2iU0yQMnbHoZklack8i6Sdbr4Jq1KTaSmsfsRAsTQ9LsPtXOPIffITOjwDB0o
         bQELWUsIRrAVsic16VbWr5rl4zJcntvCSJ7Hl8dqSoK2SwtL1zmjrPFk1wTDES/ghBPn
         PGEavmodbPM8mEwFnTYxJPeFt35/FcKzlGqWBPOPm3LJBqIi5VTvJeiCSvk7ieTkKnf8
         mrROT4jdgXdv5nJtCkfO4ws4V0SZLX5Uuj5cR0XdXCdMBvn84AdiI+m9OAV5DaIwC1CG
         wejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wXJL+3AD3aKOFERUOXOliVqfjgOSq99u8FG7OBy1SCk=;
        b=lHbu/04mSJmXe9ywDj9PoLbK/FW2NqoQ4JsSXrs3FhTDlFbuHFUWFN/duaNvSowNgW
         VtzaGJh5dU7h8ML6tAxtHcosLfHxI5fUVvJ01/7Q628Zcv68UUG58VQ0v4Pge3+pkYFh
         fH5HbrkZ0/eIUkOavFXgEGaeWOeKoyrtn168s7/AAGFoWUCXZmIdoT99l6Mdg6ySAGHO
         jsgeLCkmWPx7RFNiiCjIoropGCH0qbB5uwA8Y8b7GET6pAZkeUZENH3ae/WOTzvZayg2
         ZfJsRylBDAUBV2EcEEtSV9s45SNsRe+onBOfJ3OwK/2cL8b/DEsR4OSA2fXFKsF+IDJb
         g1LQ==
X-Gm-Message-State: APjAAAV24bTGty7uyXrWdIY9sI0ENZPyQd8pvgh9fefui3W8J2wNuT+e
        JnK1Cju7ETTxvivE5wwFxjR1
X-Google-Smtp-Source: APXvYqzNU1FetWZb0NDh/S0iIS0J5685jlQhI2vRHfVcRw93kyHCaPrshwcCHJtOI4slnj27nAq7JQ==
X-Received: by 2002:a63:1222:: with SMTP id h34mr9451335pgl.344.1570102396510;
        Thu, 03 Oct 2019 04:33:16 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id v5sm3739383pfv.76.2019.10.03.04.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 04:33:15 -0700 (PDT)
Date:   Thu, 3 Oct 2019 21:33:09 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v4 1/8] ext4: move out iomap field population into separate
 helper
Message-ID: <8b4499e47bea3841194850e1b3eeb924d87e69a5.1570100361.git.mbobrowski@mbobrowski.org>
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

Separate the iomap field population chunk into a separate simple
helper routine. This helps reducing the overall clutter within the
ext4_iomap_begin() callback, especially as we move across more code to
make use of iomap infrastructure.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/inode.c | 65 ++++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 516faa280ced..1ccdc14c4d69 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3406,10 +3406,43 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	return inode->i_state & I_DIRTY_DATASYNC;
 }
 
+static int ext4_set_iomap(struct inode *inode, struct iomap *iomap, u16 type,
+			  unsigned long first_block, struct ext4_map_blocks *map)
+{
+	u8 blkbits = inode->i_blkbits;
+
+	iomap->flags = 0;
+	if (ext4_inode_datasync_dirty(inode))
+		iomap->flags |= IOMAP_F_DIRTY;
+	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
+	iomap->offset = (u64) first_block << blkbits;
+	iomap->length = (u64) map->m_len << blkbits;
+
+	if (type) {
+		iomap->type = type;
+		iomap->addr = IOMAP_NULL_ADDR;
+	} else {
+		if (map->m_flags & EXT4_MAP_MAPPED) {
+			iomap->type = IOMAP_MAPPED;
+		} else if (map->m_flags & EXT4_MAP_UNWRITTEN) {
+			iomap->type = IOMAP_UNWRITTEN;
+		} else {
+			WARN_ON_ONCE(1);
+			return -EIO;
+		}
+		iomap->addr = (u64) map->m_pblk << blkbits;
+	}
+
+	if (map->m_flags & EXT4_MAP_NEW)
+		iomap->flags |= IOMAP_F_NEW;
+	return 0;
+}
+
 static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			    unsigned flags, struct iomap *iomap)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	u16 type = 0;
 	unsigned int blkbits = inode->i_blkbits;
 	unsigned long first_block, last_block;
 	struct ext4_map_blocks map;
@@ -3523,33 +3556,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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
-
-	return 0;
+	if (!ret)
+		type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
+	return ext4_set_iomap(inode, iomap, type, first_block, &map);
 }
 
 static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
-- 
2.20.1

