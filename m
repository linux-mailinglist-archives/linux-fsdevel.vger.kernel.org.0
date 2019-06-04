Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A9F34958
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 15:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfFDNtp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 09:49:45 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40240 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfFDNtp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oqaJOnwjLjdr1v26fNoKNwhQfrZXL1lm3Osl2Y1Kg3Y=; b=kbP1p5rJhglZBgXMNy7l5068Ud
        orGcUM1vK+bF4T8xmx7vx8xljbDQ8Fp0zVUEoXetCcuJ9qdUeNqa2C5KwF+wp2DwMRcwVojp8VBT8
        s6TnHVz3Fn0JSXSCP/7mplOqFOaZ2A5ABw7/gZLFZpW3U6Ncx+J1nTbeP2+jMjc+rbwWGqj+FUJZ5
        DGfKO6S00wg644ZhHOscPN3BBJPHKiATRb1rmVpqOOap1IVuPZV/2x9wg0jdsvnSFLFWHC/hzQ2nO
        iq3qoNUw5l+QqyfmpgTPlxcSCa6gwQ+q2LMbzXYKZNWdVDUcTinUYuHa6ZmGaLFxjBvyeooH/umlJ
        6jplfdAg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:34308 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9os-0001bE-IN; Tue, 04 Jun 2019 14:49:42 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9or-00084c-NT; Tue, 04 Jun 2019 14:49:42 +0100
In-Reply-To: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
References: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/12] fs/adfs: use format_version from disc_record
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hY9or-00084c-NT@rmk-PC.armlinux.org.uk>
Date:   Tue, 04 Jun 2019 14:49:41 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We only use the format version in one place during filesystem mount, so
it is pointless storing it in the superblock structure.  Also, we should
be using the version from the disc record in the map rather than the
boot block.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h  | 1 -
 fs/adfs/super.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index ab13b5dd34a3..1c31861aa115 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -60,7 +60,6 @@ struct adfs_sb_info {
 	__u32		s_map_size;	/* sector size of a map	*/
 	signed int	s_map2blk;	/* shift left by this for map->sector*/
 	unsigned int	s_log2sharesize;/* log2 share size */
-	__le32		s_version;	/* disc format version */
 	unsigned int	s_namelen;	/* maximum number of characters in name	 */
 };
 
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 90b9cbcdb4db..26b4b66df2c7 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -441,7 +441,6 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	asb->s_idlen		= dr->idlen;
 	asb->s_map_size		= dr->nzones | (dr->nzones_high << 8);
 	asb->s_map2blk		= dr->log2bpmb - dr->log2secsize;
-	asb->s_version 		= dr->format_version;
 	asb->s_log2sharesize	= dr->log2sharesize;
 
 	asb->s_map = adfs_read_map(sb, dr);
@@ -473,7 +472,7 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	 * If this is a F+ disk with variable length directories,
 	 * get the root_size from the disc record.
 	 */
-	if (asb->s_version) {
+	if (dr->format_version) {
 		root_obj.size = le32_to_cpu(dr->root_size);
 		asb->s_dir     = &adfs_fplus_dir_ops;
 		asb->s_namelen = ADFS_FPLUS_NAME_LEN;
-- 
2.7.4

