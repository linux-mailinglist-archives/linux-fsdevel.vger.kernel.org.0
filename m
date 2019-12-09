Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFB3116C0B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfLILLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:11:37 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60234 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfLILLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=feL+iWE9UAJphkctLhFGh2wmZe4kFrdighguoKV2TSs=; b=stOBJtNvYCjPJkLnWMwlvdhmjh
        QklWJKA+4jbC0gaw8A6m9Bx4O1l6KO3tKxZzW5JZI1Q2RJKfhNgMSs0xEYIL7s+Xrr25Q2vbwus7S
        3bznbFGoXghelREKsnoeZzHBt3rCqwbD6D7BhPujNBC+70T328FPpXTulB1xGiqFzkTfUdWhk1nLi
        /N7A2mH+tR6VFXl1gtHQWxAR3OdRdoFEw1R7/ol8HJWkEFyfDbIFYc8qJKTNd6rk4trdu3go/ITGI
        r0CuPG8jTIKqWqzl7t3NeykUNFGLYcFrRKFGYAGI6/PYlHLgrcKtFmGdSeGxW6Tb6dVEBrpHW1X2l
        MutZz8Bg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49880 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGww-0002Y2-6Y; Mon, 09 Dec 2019 11:11:34 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwv-0004eL-M0; Mon, 09 Dec 2019 11:11:33 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 39/41] fs/adfs: super: add support for E and E+ floppy image
 formats
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGwv-0004eL-M0@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:11:33 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for ADFS E and E+ floppy image formats, which, unlike their
hard disk variants, do not have a filesystem boot block - they have a
single map zone, with the map fragment stored at sector 0.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/super.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 4c06b2d5a861..a3cc8ecb50da 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -347,6 +347,20 @@ static int adfs_validate_bblk(struct super_block *sb, struct buffer_head *bh,
 	return 0;
 }
 
+static int adfs_validate_dr0(struct super_block *sb, struct buffer_head *bh,
+			      struct adfs_discrecord **drp)
+{
+	struct adfs_discrecord *dr;
+
+	/* Do some sanity checks on the ADFS disc record */
+	dr = (struct adfs_discrecord *)(bh->b_data + 4);
+	if (adfs_checkdiscrecord(dr) || dr->nzones_high || dr->nzones != 1)
+		return -EILSEQ;
+
+	*drp = dr;
+	return 0;
+}
+
 static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct adfs_discrecord *dr;
@@ -376,7 +390,9 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 		goto error;
 
 	/* Try to probe the filesystem boot block */
-	ret = adfs_probe(sb, ADFS_DISCRECORD, silent, adfs_validate_bblk);
+	ret = adfs_probe(sb, ADFS_DISCRECORD, 1, adfs_validate_bblk);
+	if (ret == -EILSEQ)
+		ret = adfs_probe(sb, 0, silent, adfs_validate_dr0);
 	if (ret == -EILSEQ) {
 		if (!silent)
 			adfs_msg(sb, KERN_ERR,
-- 
2.20.1

