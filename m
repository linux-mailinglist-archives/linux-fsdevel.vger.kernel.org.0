Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C69B9116BD9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfLILJL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:09:11 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60022 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfLILJL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hgsNh+fT7XazGhKfwbZ3imrhLLFK1tQZkw4s+6a+f8w=; b=p1ijQT2IStC/0e0XEWtiCRyeJ0
        0yE2IOmfJw+zqRaqMwoIfin/cked7lsVs7q+oGtW28hy2eT7eCaN2XB/wp5Zrjliq5m7LilrHVC6D
        lKT1rtZIhcmg4frBHs4Qbcd1NViXO6DvLbTVBmzNd5GU90tilgE3TkUIt/GEOhID+7puDLwrZ1j1P
        PemTgAMbC+09YrEzPCJBAwaf8emLpMKkREZy+qnj6gT66feROUfsLxGeKRiStdD8vCc67oBmWxsF3
        gIWTFCQsHnpEKRcuUbqicnPqrL9nTWc4QYfLP1btdRsf9CYaSdK8QY3TNbmEvvCAbBJDV3yu+lY+D
        NNkrrCZA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54056 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuT-0002TT-Pk; Mon, 09 Dec 2019 11:09:01 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuR-0004aa-OF; Mon, 09 Dec 2019 11:08:59 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/41] fs/adfs: map: move map-specific sb initialisation to
 map.c
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGuR-0004aa-OF@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:08:59 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move map specific superblock initialisation to map.c, rather than
having it spread into super.c.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/map.c   | 13 +++++++++----
 fs/adfs/super.c |  7 +------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/adfs/map.c b/fs/adfs/map.c
index 9be0b47da19c..82e1bf101fe6 100644
--- a/fs/adfs/map.c
+++ b/fs/adfs/map.c
@@ -355,14 +355,19 @@ struct adfs_discmap *adfs_read_map(struct super_block *sb, struct adfs_discrecor
 	unsigned int map_addr, zone_size, nzones;
 	int ret;
 
-	nzones    = asb->s_map_size;
+	nzones    = dr->nzones | dr->nzones_high << 8;
 	zone_size = (8 << dr->log2secsize) - le16_to_cpu(dr->zone_spare);
-	map_addr  = (nzones >> 1) * zone_size -
-		     ((nzones > 1) ? ADFS_DR_SIZE_BITS : 0);
-	map_addr  = signed_asl(map_addr, asb->s_map2blk);
 
+	asb->s_idlen = dr->idlen;
+	asb->s_map_size = nzones;
+	asb->s_map2blk = dr->log2bpmb - dr->log2secsize;
+	asb->s_log2sharesize = dr->log2sharesize;
 	asb->s_ids_per_zone = zone_size / (asb->s_idlen + 1);
 
+	map_addr = (nzones >> 1) * zone_size -
+		     ((nzones > 1) ? ADFS_DR_SIZE_BITS : 0);
+	map_addr = signed_asl(map_addr, asb->s_map2blk);
+
 	dm = kmalloc_array(nzones, sizeof(*dm), GFP_KERNEL);
 	if (dm == NULL) {
 		adfs_error(sb, "not enough memory");
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index cef16028e9f2..b2455e9ab923 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -289,6 +289,7 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 		return -ENOMEM;
 
 	sb->s_fs_info = asb;
+	sb->s_magic = ADFS_SUPER_MAGIC;
 	sb->s_time_gran = 10000000;
 
 	/* set default options */
@@ -356,12 +357,6 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	 * blocksize on this device should now be set to the ADFS log2secsize
 	 */
 
-	sb->s_magic		= ADFS_SUPER_MAGIC;
-	asb->s_idlen		= dr->idlen;
-	asb->s_map_size		= dr->nzones | (dr->nzones_high << 8);
-	asb->s_map2blk		= dr->log2bpmb - dr->log2secsize;
-	asb->s_log2sharesize	= dr->log2sharesize;
-
 	asb->s_map = adfs_read_map(sb, dr);
 	if (IS_ERR(asb->s_map)) {
 		ret =  PTR_ERR(asb->s_map);
-- 
2.20.1

