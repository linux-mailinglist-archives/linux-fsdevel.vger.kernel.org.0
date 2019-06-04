Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10B0E34963
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 15:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfFDNuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 09:50:18 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40284 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfFDNuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TyW1PGHPgz7oyYNFLE8lSFTrpLcxbxLueGs8ifFEHLI=; b=ZdZuuJXBEj4K9dWTzN6Q+egRsm
        /ZEf/G/XgOlZiJVdSHpSyNXqscqBWd9js6Vw3JAbZLINGCA8J5rqgJGy9muk2PgCwn3SDjGBckixe
        mfqATXWNKTcfOSyiGQRlqtAlTSFV8s9uSGKp9sOZ54GqSa1Liway0g7u7rTWojwLbim3l7l0x90GK
        wZQVWFzB6frxM8bzdpyOS0EjfsSR20H6i8IQQTmUV2xRLAuE3Gy7mpVpuiuXV1QBAZVSwWTAivcf8
        mNir1N5x1tQkfS6mumymj5S5+FdZSsJSg9F08Hb5y8MBSRIw4U30SJamvyJpXymPCCB6KfMtlZo8E
        mv+l0A8Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:34836 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9pO-0001c7-Ps; Tue, 04 Jun 2019 14:50:14 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9pO-00085R-8P; Tue, 04 Jun 2019 14:50:14 +0100
In-Reply-To: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
References: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/12] fs/adfs: super: fix use-after-free bug
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hY9pO-00085R-8P@rmk-PC.armlinux.org.uk>
Date:   Tue, 04 Jun 2019 14:50:14 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix a use-after-free bug during filesystem initialisation, where we
access the disc record (which is stored in a buffer) after we have
released the buffer.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index c17ece0a3b61..c370b8618469 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -384,6 +384,7 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	struct buffer_head *bh;
 	struct object_info root_obj;
 	unsigned char *b_data;
+	unsigned int blocksize;
 	struct adfs_sb_info *asb;
 	struct inode *root;
 	int ret = -EINVAL;
@@ -429,8 +430,10 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 		goto error_badfs;
 	}
 
+	blocksize = 1 << dr->log2secsize;
 	brelse(bh);
-	if (sb_set_blocksize(sb, 1 << dr->log2secsize)) {
+
+	if (sb_set_blocksize(sb, blocksize)) {
 		bh = sb_bread(sb, ADFS_DISCRECORD / sb->s_blocksize);
 		if (!bh) {
 			adfs_msg(sb, KERN_ERR,
-- 
2.7.4

