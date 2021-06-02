Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A445398E9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhFBPcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhFBPcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:32:21 -0400
X-Greylist: delayed 78 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Jun 2021 08:30:37 PDT
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D451AC061574;
        Wed,  2 Jun 2021 08:30:37 -0700 (PDT)
Received: from sas1-6b1512233ef6.qloud-c.yandex.net (sas1-6b1512233ef6.qloud-c.yandex.net [IPv6:2a02:6b8:c14:44af:0:640:6b15:1223])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 127D62E1A0B;
        Wed,  2 Jun 2021 18:29:21 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-6b1512233ef6.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id 26KXIAE1hn-TK1Sxcka;
        Wed, 02 Jun 2021 18:29:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1622647760; bh=rZfoT/F84j27juZBJ33q9fQrzmHqKaf/Bc0i0dABbDQ=;
        h=Message-Id:References:Date:Subject:To:From:In-Reply-To:Cc;
        b=qN9P9qFuvQip5KAYgKRE3AIppIUEBZvY1H7evs0vPDH9QZEXK21Iu2MGzx8u2lNge
         QBsjMdzeK6GWfF8HoI432FS6cNyHq+R/nzdgGtTNbdfYmt5/91VK8OpQbQ/oN/YJ8U
         FNf6X1WiV5CduBj4MRrTxMYlvZv/iASSdKAF08Ds=
Authentication-Results: sas1-6b1512233ef6.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 42DbdVHlBw-TKoi8GXV;
        Wed, 02 Jun 2021 18:29:20 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     warwish@yandex-team.ru, linux-fsdevel@vger.kernel.org,
        dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH 06/10] target: reduce stack footprint in iblock_show_configfs_dev_params()
Date:   Wed,  2 Jun 2021 18:28:59 +0300
Message-Id: <20210602152903.910190-7-warwish@yandex-team.ru>
In-Reply-To: <20210602152903.910190-1-warwish@yandex-team.ru>
References: <20210602152903.910190-1-warwish@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stack usage reduced (measured with allyesconfig):

./drivers/target/target_core_iblock.c   iblock_show_configfs_dev_params 192     56      -136

Signed-off-by: Anton Suvorov <warwish@yandex-team.ru>
---
 drivers/target/target_core_iblock.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 44d9d028f716..b3425a5bbac2 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -634,12 +634,11 @@ static ssize_t iblock_show_configfs_dev_params(struct se_device *dev, char *b)
 {
 	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
 	struct block_device *bd = ib_dev->ibd_bd;
-	char buf[BDEVNAME_SIZE];
 	ssize_t bl = 0;
 
 	if (bd)
-		bl += sprintf(b + bl, "iBlock device: %s",
-				bdevname(bd, buf));
+		bl += sprintf(b + bl, "iBlock device: %pg",
+				bd);
 	if (ib_dev->ibd_flags & IBDF_HAS_UDEV_PATH)
 		bl += sprintf(b + bl, "  UDEV PATH: %s",
 				ib_dev->ibd_udev_path);
-- 
2.25.1

