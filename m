Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DD7398EB0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 17:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhFBPdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 11:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbhFBPdH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:33:07 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF3BC061756;
        Wed,  2 Jun 2021 08:31:24 -0700 (PDT)
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 6FC412E1941;
        Wed,  2 Jun 2021 18:29:21 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id ToGaT5OtQN-TL1OKjK7;
        Wed, 02 Jun 2021 18:29:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1622647761; bh=2+bDRRkh+g0BuDQDsR1CfhbxTKlOSdY5bWPnuop4ErA=;
        h=Message-Id:References:Date:Subject:To:From:In-Reply-To:Cc;
        b=jDwenv1mEjQUU2XBr/gbopWKQpcgKaDmQM1hZwM0YBdaM7C/kccGGLArjkU/GElsh
         TFR4/xaOVPLRu+Q6Wfl8FH43zYXVwSj1P5kZQ7e2VT56fCec9oOTdHXQ38LsKj5tB2
         xHatxQ0rArNKTvevIpZkIb6r8B3RZ+AmNBrCWdn4=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 42DbdVHlBw-TLoiblUl;
        Wed, 02 Jun 2021 18:29:21 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     warwish@yandex-team.ru, linux-fsdevel@vger.kernel.org,
        dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH 07/10] vfs: reduce stack footprint in __blkdev_put()
Date:   Wed,  2 Jun 2021 18:29:00 +0300
Message-Id: <20210602152903.910190-8-warwish@yandex-team.ru>
In-Reply-To: <20210602152903.910190-1-warwish@yandex-team.ru>
References: <20210602152903.910190-1-warwish@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stack usage reduced (measured with allyesconfig):

./fs/block_dev.c        __blkdev_put    224     80      -144

Signed-off-by: Anton Suvorov <warwish@yandex-team.ru>
---
 fs/block_dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6cc4d4cfe0c2..cef3a4aa46dc 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -64,10 +64,8 @@ static void bdev_write_inode(struct block_device *bdev)
 		spin_unlock(&inode->i_lock);
 		ret = write_inode_now(inode, true);
 		if (ret) {
-			char name[BDEVNAME_SIZE];
-			pr_warn_ratelimited("VFS: Dirty inode writeback failed "
-					    "for block device %s (err=%d).\n",
-					    bdevname(bdev, name), ret);
+			pr_warn_ratelimited("VFS: Dirty inode writeback failed for block device %pg (err=%d).\n",
+					    bdev, ret);
 		}
 		spin_lock(&inode->i_lock);
 	}
-- 
2.25.1

