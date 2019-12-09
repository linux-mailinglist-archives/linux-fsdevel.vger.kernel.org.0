Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0FC116C07
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfLILLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:11:22 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60214 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfLILLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eUnFoTipOhHhRffTyvR1bvNQKBnSBYateJE+p2lcP9Y=; b=ey3Knogxgi5rZCQ/PaErg/6E3C
        nSvb0MEbGNFu7J+xBDEv3g9Nuk3upy8Fl2Ov7u3j1oiQOVEs4vriWfKPcRzNOcmtl1B7/7d6UY6C3
        INCGOpUpiwi8yQgB5pjaufhCaoujHpesY3u+vZWs0ZDMWIQyioA2JkCwCDRatDtpMP4s2EGf3YUYu
        d/EU7vtroxstDdNe8RNS0Fg2LH673x1VtyWrNyK22o0po+swD5WT2x7ZcJV+Xx+7NEauUohGDHuRb
        4Do2x8kyzMW7sg+lAXmlX/8GdlMffkvcTJCynE2sh0tRxNFQtm5/OC47DAnyIVe56NUIYMd2l6iOI
        8tjnnpkQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49870 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwg-0002Xg-R3; Mon, 09 Dec 2019 11:11:18 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwg-0004dx-A6; Mon, 09 Dec 2019 11:11:18 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 36/41] fs/adfs: super: fix inode dropping
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGwg-0004dx-A6@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:11:18 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we have write support enabled, we must not drop inodes before they
have been written back, otherwise we lose updates to the filesystem on
umount.  Keep the inodes around unless we are built in read-only mode,
or we are mounted read-only.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/super.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index b2455e9ab923..9c93122925cf 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -231,6 +231,12 @@ static void adfs_free_inode(struct inode *inode)
 	kmem_cache_free(adfs_inode_cachep, ADFS_I(inode));
 }
 
+static int adfs_drop_inode(struct inode *inode)
+{
+	/* always drop inodes if we are read-only */
+	return !IS_ENABLED(CONFIG_ADFS_FS_RW) || IS_RDONLY(inode);
+}
+
 static void init_once(void *foo)
 {
 	struct adfs_inode_info *ei = (struct adfs_inode_info *) foo;
@@ -263,7 +269,7 @@ static void destroy_inodecache(void)
 static const struct super_operations adfs_sops = {
 	.alloc_inode	= adfs_alloc_inode,
 	.free_inode	= adfs_free_inode,
-	.drop_inode	= generic_delete_inode,
+	.drop_inode	= adfs_drop_inode,
 	.write_inode	= adfs_write_inode,
 	.put_super	= adfs_put_super,
 	.statfs		= adfs_statfs,
-- 
2.20.1

