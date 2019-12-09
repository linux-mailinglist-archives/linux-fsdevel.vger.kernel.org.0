Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA52116BC6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfLILI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:08:27 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59966 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLILI1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=br2j7JFeolGV+3OWOOyEflvvPo5g6lJIcxY1NpPvC7k=; b=EOp6wT4Ydkcm/UY0t/H/THoByz
        bbfZbv/7PQYYVnzB4OHprRU3X+IvQIjgMubSFW1a8IJA24IykU4vBL3fBumn5ptNobFaewkFUf2qW
        zJ2KMhRnTPFr0P0+lae40ZRTtzFctw/DFFDevf7Ef6dtp0crndZ40yPNaeAhc+3OTI+xBtOpEWS6L
        t31W5LYzzgnPUTQ/3YZWjuKP9TixImFoq+OXebV6bAJgUNW4LOEewV9JOGo32hrCdGHhs/AJH+Dq8
        QlH18zq2WvpJTGhe/XxM1VXj0xfd25D7gyqp1TrcSTmnPDaUhMEPxUmrub0iGEBSgtHj6uLjELBtC
        AQOQf0iQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54040 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGts-0002Sa-E1; Mon, 09 Dec 2019 11:08:24 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGtr-0004Zf-PP; Mon, 09 Dec 2019 11:08:23 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/41] fs/adfs: inode: fix adfs_mode2atts()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGtr-0004Zf-PP@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:08:23 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix adfs_mode2atts() to actually update the file permissions on the
media rather than using the current inode mode.  Note also that
directories do not have read/write permissions stored on the media.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/inode.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 18a1d478669b..212a56fc7911 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -126,29 +126,29 @@ adfs_atts2mode(struct super_block *sb, struct inode *inode)
  * Convert Linux permission to ADFS attribute.  We try to do the reverse
  * of atts2mode, but there is not a 1:1 translation.
  */
-static int
-adfs_mode2atts(struct super_block *sb, struct inode *inode)
+static int adfs_mode2atts(struct super_block *sb, struct inode *inode,
+			  umode_t ia_mode)
 {
+	struct adfs_sb_info *asb = ADFS_SB(sb);
 	umode_t mode;
 	int attr;
-	struct adfs_sb_info *asb = ADFS_SB(sb);
 
 	/* FIXME: should we be able to alter a link? */
 	if (S_ISLNK(inode->i_mode))
 		return ADFS_I(inode)->attr;
 
+	/* Directories do not have read/write permissions on the media */
 	if (S_ISDIR(inode->i_mode))
-		attr = ADFS_NDA_DIRECTORY;
-	else
-		attr = 0;
+		return ADFS_NDA_DIRECTORY;
 
-	mode = inode->i_mode & asb->s_owner_mask;
+	attr = 0;
+	mode = ia_mode & asb->s_owner_mask;
 	if (mode & S_IRUGO)
 		attr |= ADFS_NDA_OWNER_READ;
 	if (mode & S_IWUGO)
 		attr |= ADFS_NDA_OWNER_WRITE;
 
-	mode = inode->i_mode & asb->s_other_mask;
+	mode = ia_mode & asb->s_other_mask;
 	mode &= ~asb->s_owner_mask;
 	if (mode & S_IRUGO)
 		attr |= ADFS_NDA_PUBLIC_READ;
@@ -328,7 +328,7 @@ adfs_notify_change(struct dentry *dentry, struct iattr *attr)
 	if (ia_valid & ATTR_CTIME)
 		inode->i_ctime = attr->ia_ctime;
 	if (ia_valid & ATTR_MODE) {
-		ADFS_I(inode)->attr = adfs_mode2atts(sb, inode);
+		ADFS_I(inode)->attr = adfs_mode2atts(sb, inode, attr->ia_mode);
 		inode->i_mode = adfs_atts2mode(sb, inode);
 	}
 
-- 
2.20.1

