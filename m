Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864A13B0BB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 19:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhFVRrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 13:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbhFVRrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:47:08 -0400
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679D7C061574;
        Tue, 22 Jun 2021 10:44:52 -0700 (PDT)
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 9E9912E15CD;
        Tue, 22 Jun 2021 20:44:48 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id bLstHoCjZs-im0mS5Pr;
        Tue, 22 Jun 2021 20:44:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1624383888; bh=PVwE/V6WdknLk21v0Tu8u034Wd5hW32tk6LK0cw4jis=;
        h=Message-Id:References:Date:Subject:To:From:In-Reply-To:Cc;
        b=yGNzeG6OBVsnpoMj94V9YhdHdmpb92KzH6Uva5Q7U/an/xsJIiqPtZixVh9pt0mO0
         HaNcLG9ZstDMykbjYfn+6VyPfxyTk2701/Yx4WyamK0fXzBf6gsRZA278AJCsfoe3w
         awOpxwr1Nde5SdRbOpLytx7U+UoV62pMXrNpD9NU=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id gVbf2yAtam-im9mBjs8;
        Tue, 22 Jun 2021 20:44:48 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     willy@infradead.org
Cc:     dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, warwish@yandex-team.ru
Subject: [PATCH v2 06/10] target: reduce stack footprint in iblock_show_configfs_dev_params()
Date:   Tue, 22 Jun 2021 20:44:20 +0300
Message-Id: <20210622174424.136960-7-warwish@yandex-team.ru>
In-Reply-To: <20210622174424.136960-1-warwish@yandex-team.ru>
References: <YLe9eDbG2c/rVjyu@casper.infradead.org>
 <20210622174424.136960-1-warwish@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stack usage reduced (measured with allyesconfig):

./drivers/target/target_core_iblock.c   iblock_show_configfs_dev_params 192     56      -136

Signed-off-by: Anton Suvorov <warwish@yandex-team.ru>
---
 drivers/target/target_core_iblock.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 44d9d028f716..a95f0b9bccf8 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -634,12 +634,10 @@ static ssize_t iblock_show_configfs_dev_params(struct se_device *dev, char *b)
 {
 	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
 	struct block_device *bd = ib_dev->ibd_bd;
-	char buf[BDEVNAME_SIZE];
 	ssize_t bl = 0;
 
 	if (bd)
-		bl += sprintf(b + bl, "iBlock device: %s",
-				bdevname(bd, buf));
+		bl += sprintf(b + bl, "iBlock device: %pg", bd);
 	if (ib_dev->ibd_flags & IBDF_HAS_UDEV_PATH)
 		bl += sprintf(b + bl, "  UDEV PATH: %s",
 				ib_dev->ibd_udev_path);
-- 
2.25.1

