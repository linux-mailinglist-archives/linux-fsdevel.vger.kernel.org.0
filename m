Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE05116C0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfLILLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:11:33 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60226 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfLILLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Tw31orVi51lDDYaqsZpg4T3gBfIcr6V7LgHrA3KY2sU=; b=M4LNoNSA2eH+ja/nvlR2gTelr3
        mPs54NGnD4l2Cxk/KGjxxl8S6+Ud8RSR84mp8aNAGImwuSqR4udRsvMs17fs/ndPKWmrZTMrX5YhM
        dtRD+4aUaT8T8VBBP1izXZpaHSb02VkimPPLnWonLtfqhNjg9iNdYLiOGc52yQ5f9zvf/ug8Pu2sH
        nsWDyq6PqAwr0xuch9DFjTbraGI5CaQeouyKB6qt4QIrCp8wml2KW8k1XHnt5D7My5QCnaO2iBJy4
        5POc64WunR7pbV7KBxJQV7bibqKQucIQYhioG3XXhmee1PlCKz+iLo7vL7kgFN2gX0PIcAROGWZnM
        nh4OmodQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49876 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwr-0002Xu-2x; Mon, 09 Dec 2019 11:11:29 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwq-0004eD-Ib; Mon, 09 Dec 2019 11:11:28 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 38/41] fs/adfs: super: extract filesystem block probe
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGwq-0004eD-Ib@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:11:28 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Separate the filesystem block probing from the superblock filling so
we can support other ADFS filesystem formats, such as the single-zone
E and E+ floppy image formats which do not have a boot block.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/super.c | 149 +++++++++++++++++++++++++-----------------------
 1 file changed, 78 insertions(+), 71 deletions(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 9c93122925cf..4c06b2d5a861 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -277,13 +277,80 @@ static const struct super_operations adfs_sops = {
 	.show_options	= adfs_show_options,
 };
 
-static int adfs_fill_super(struct super_block *sb, void *data, int silent)
+static int adfs_probe(struct super_block *sb, unsigned int offset, int silent,
+		      int (*validate)(struct super_block *sb,
+				      struct buffer_head *bh,
+				      struct adfs_discrecord **bhp))
 {
+	struct adfs_sb_info *asb = ADFS_SB(sb);
 	struct adfs_discrecord *dr;
 	struct buffer_head *bh;
-	struct object_info root_obj;
+	unsigned int blocksize = BLOCK_SIZE;
+	int ret, try;
+
+	for (try = 0; try < 2; try++) {
+		/* try to set the requested block size */
+		if (sb->s_blocksize != blocksize &&
+		    !sb_set_blocksize(sb, blocksize)) {
+			if (!silent)
+				adfs_msg(sb, KERN_ERR,
+					 "error: unsupported blocksize");
+			return -EINVAL;
+		}
+
+		/* read the buffer */
+		bh = sb_bread(sb, offset >> sb->s_blocksize_bits);
+		if (!bh) {
+			adfs_msg(sb, KERN_ERR,
+				 "error: unable to read block %u, try %d",
+				 offset >> sb->s_blocksize_bits, try);
+			return -EIO;
+		}
+
+		/* validate it */
+		ret = validate(sb, bh, &dr);
+		if (ret) {
+			brelse(bh);
+			return ret;
+		}
+
+		/* does the block size match the filesystem block size? */
+		blocksize = 1 << dr->log2secsize;
+		if (sb->s_blocksize == blocksize) {
+			asb->s_map = adfs_read_map(sb, dr);
+			brelse(bh);
+			return PTR_ERR_OR_ZERO(asb->s_map);
+		}
+
+		brelse(bh);
+	}
+
+	return -EIO;
+}
+
+static int adfs_validate_bblk(struct super_block *sb, struct buffer_head *bh,
+			      struct adfs_discrecord **drp)
+{
+	struct adfs_discrecord *dr;
 	unsigned char *b_data;
-	unsigned int blocksize;
+
+	b_data = bh->b_data + (ADFS_DISCRECORD % sb->s_blocksize);
+	if (adfs_checkbblk(b_data))
+		return -EILSEQ;
+
+	/* Do some sanity checks on the ADFS disc record */
+	dr = (struct adfs_discrecord *)(b_data + ADFS_DR_OFFSET);
+	if (adfs_checkdiscrecord(dr))
+		return -EILSEQ;
+
+	*drp = dr;
+	return 0;
+}
+
+static int adfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct adfs_discrecord *dr;
+	struct object_info root_obj;
 	struct adfs_sb_info *asb;
 	struct inode *root;
 	int ret = -EINVAL;
@@ -308,72 +375,19 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	if (parse_options(sb, asb, data))
 		goto error;
 
-	sb_set_blocksize(sb, BLOCK_SIZE);
-	if (!(bh = sb_bread(sb, ADFS_DISCRECORD / BLOCK_SIZE))) {
-		adfs_msg(sb, KERN_ERR, "error: unable to read superblock");
-		ret = -EIO;
-		goto error;
-	}
-
-	b_data = bh->b_data + (ADFS_DISCRECORD % BLOCK_SIZE);
-
-	if (adfs_checkbblk(b_data)) {
-		ret = -EINVAL;
-		goto error_badfs;
-	}
-
-	dr = (struct adfs_discrecord *)(b_data + ADFS_DR_OFFSET);
-
-	/*
-	 * Do some sanity checks on the ADFS disc record
-	 */
-	if (adfs_checkdiscrecord(dr)) {
-		ret = -EINVAL;
-		goto error_badfs;
-	}
-
-	blocksize = 1 << dr->log2secsize;
-	brelse(bh);
-
-	if (sb_set_blocksize(sb, blocksize)) {
-		bh = sb_bread(sb, ADFS_DISCRECORD / sb->s_blocksize);
-		if (!bh) {
-			adfs_msg(sb, KERN_ERR,
-				 "error: couldn't read superblock on 2nd try.");
-			ret = -EIO;
-			goto error;
-		}
-		b_data = bh->b_data + (ADFS_DISCRECORD % sb->s_blocksize);
-		if (adfs_checkbblk(b_data)) {
-			adfs_msg(sb, KERN_ERR,
-				 "error: disc record mismatch, very weird!");
-			ret = -EINVAL;
-			goto error_free_bh;
-		}
-		dr = (struct adfs_discrecord *)(b_data + ADFS_DR_OFFSET);
-	} else {
+	/* Try to probe the filesystem boot block */
+	ret = adfs_probe(sb, ADFS_DISCRECORD, silent, adfs_validate_bblk);
+	if (ret == -EILSEQ) {
 		if (!silent)
 			adfs_msg(sb, KERN_ERR,
-				 "error: unsupported blocksize");
+				 "error: can't find an ADFS filesystem on dev %s.",
+				 sb->s_id);
 		ret = -EINVAL;
-		goto error;
 	}
+	if (ret)
+		goto error;
 
-	/*
-	 * blocksize on this device should now be set to the ADFS log2secsize
-	 */
-
-	asb->s_map = adfs_read_map(sb, dr);
-	if (IS_ERR(asb->s_map)) {
-		ret =  PTR_ERR(asb->s_map);
-		goto error_free_bh;
-	}
-
-	brelse(bh);
-
-	/*
-	 * set up enough so that we can read an inode
-	 */
+	/* set up enough so that we can read an inode */
 	sb->s_op = &adfs_sops;
 
 	dr = adfs_map_discrecord(asb->s_map);
@@ -417,13 +431,6 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 	return 0;
 
-error_badfs:
-	if (!silent)
-		adfs_msg(sb, KERN_ERR,
-			 "error: can't find an ADFS filesystem on dev %s.",
-			 sb->s_id);
-error_free_bh:
-	brelse(bh);
 error:
 	sb->s_fs_info = NULL;
 	kfree(asb);
-- 
2.20.1

