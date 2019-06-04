Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFBD234957
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 15:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfFDNtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 09:49:40 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40230 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfFDNtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7AbfYmua/QTkxL+3qT+/QlMVNoDU31inQX+Jf1Tk/xY=; b=NzsYUTD0R0CAFNI42hdZ8ko2Oz
        oEpf9rSA2rY9952YeYvGmXLC4J9zj4oVFf1I1qzDAaSmDbJ8NpMDLpcsllFnR3TcF/dIGvlR0dMKM
        d76Bfz8m6cEMMJpjJcUOw/UxqcSNXNbopSr7x4l84JNOXsdXVrjySEr1oY55FmMJYupssOp7k/OSq
        UhhQZb/0G2g8UdFhGor0yPy35i1aasCfACwc+p8db86Q/hvjLvc+GdM/4NYo2o63lWxmbyZVIefvJ
        3RoqegUyRROnvu4Q/6OMiVSILm7bymWFo3tm50bG7dNnsNdbup7UDL6WDjjaxwbV5oikI1vPvUXmy
        buyDacZg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:34820 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9on-0001b7-4S; Tue, 04 Jun 2019 14:49:37 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9om-00084V-8X; Tue, 04 Jun 2019 14:49:36 +0100
In-Reply-To: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
References: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/12] fs/adfs: add helper to get filesystem size
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hY9om-00084V-8X@rmk-PC.armlinux.org.uk>
Date:   Tue, 04 Jun 2019 14:49:36 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to get the filesystem size from the disc record and
eliminate the "s_size" member of the adfs superblock structure.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h  |  7 ++++++-
 fs/adfs/super.c | 17 +++--------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 5a72a0ea03bd..ab13b5dd34a3 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -58,7 +58,6 @@ struct adfs_sb_info {
 	__u32		s_ids_per_zone;	/* max. no ids in one zone */
 	__u32		s_idlen;	/* length of ID in map */
 	__u32		s_map_size;	/* sector size of a map	*/
-	unsigned long	s_size;		/* total size (in blocks) of this fs */
 	signed int	s_map2blk;	/* shift left by this for map->sector*/
 	unsigned int	s_log2sharesize;/* log2 share size */
 	__le32		s_version;	/* disc format version */
@@ -201,3 +200,9 @@ struct adfs_discrecord *adfs_map_discrecord(struct adfs_discmap *dm)
 {
 	return (void *)(dm[0].dm_bh->b_data + 4);
 }
+
+static inline u64 adfs_disc_size(const struct adfs_discrecord *dr)
+{
+	return (u64)le32_to_cpu(dr->disc_size_high) << 32 |
+		    le32_to_cpu(dr->disc_size);
+}
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 75000165f4d1..90b9cbcdb4db 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -220,12 +220,13 @@ static int adfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
 	struct adfs_sb_info *sbi = ADFS_SB(sb);
+	struct adfs_discrecord *dr = adfs_map_discrecord(sbi->s_map);
 	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
 
 	buf->f_type    = ADFS_SUPER_MAGIC;
 	buf->f_namelen = sbi->s_namelen;
 	buf->f_bsize   = sb->s_blocksize;
-	buf->f_blocks  = sbi->s_size;
+	buf->f_blocks  = adfs_disc_size(dr) >> sb->s_blocksize_bits;
 	buf->f_files   = sbi->s_ids_per_zone * sbi->s_map_size;
 	buf->f_bavail  =
 	buf->f_bfree   = adfs_map_free(sb);
@@ -335,8 +336,7 @@ static struct adfs_discmap *adfs_read_map(struct super_block *sb, struct adfs_di
 	i = zone - 1;
 	dm[0].dm_startblk = 0;
 	dm[0].dm_startbit = ADFS_DR_SIZE_BITS;
-	dm[i].dm_endbit   = (le32_to_cpu(dr->disc_size_high) << (32 - dr->log2bpmb)) +
-			    (le32_to_cpu(dr->disc_size) >> dr->log2bpmb) +
+	dm[i].dm_endbit   = (adfs_disc_size(dr) >> dr->log2bpmb) +
 			    (ADFS_DR_SIZE_BITS - i * zone_size);
 
 	if (adfs_checkmap(sb, dm))
@@ -352,16 +352,6 @@ static struct adfs_discmap *adfs_read_map(struct super_block *sb, struct adfs_di
 	return ERR_PTR(-EIO);
 }
 
-static inline unsigned long adfs_discsize(struct adfs_discrecord *dr, int block_bits)
-{
-	unsigned long discsize;
-
-	discsize  = le32_to_cpu(dr->disc_size_high) << (32 - block_bits);
-	discsize |= le32_to_cpu(dr->disc_size) >> block_bits;
-
-	return discsize;
-}
-
 static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct adfs_discrecord *dr;
@@ -451,7 +441,6 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	asb->s_idlen		= dr->idlen;
 	asb->s_map_size		= dr->nzones | (dr->nzones_high << 8);
 	asb->s_map2blk		= dr->log2bpmb - dr->log2secsize;
-	asb->s_size    		= adfs_discsize(dr, sb->s_blocksize_bits);
 	asb->s_version 		= dr->format_version;
 	asb->s_log2sharesize	= dr->log2sharesize;
 
-- 
2.7.4

