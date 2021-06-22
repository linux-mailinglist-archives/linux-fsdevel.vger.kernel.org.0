Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F391C3B0BB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 19:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhFVRrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 13:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbhFVRrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:47:10 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DB2C061768;
        Tue, 22 Jun 2021 10:44:54 -0700 (PDT)
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 070992E15EC;
        Tue, 22 Jun 2021 20:44:50 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id abUHsbsy4U-in00RwjD;
        Tue, 22 Jun 2021 20:44:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1624383889; bh=9GlD6HleP2FtlpMNZDQZEVXlxMyxhvy+ki1vOkW/b5Q=;
        h=Message-Id:References:Date:Subject:To:From:In-Reply-To:Cc;
        b=IUaLW98pVcxMEZyFI3VToyZuTOLMyJ73BjurZWdww2pQ/n/+I+Fl2iAy0s28njOEI
         AJFdHnYpzFVZTWG0ye8YOUfMUK1acJXMg7zz3b2RoRSxvga+ZV6fA88gw5Vc59gR8x
         KZyOTVWJDYOZpZ26iOQUjfOZRLObNYrl7/EhthvY=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id gVbf2yAtam-in9m7erC;
        Tue, 22 Jun 2021 20:44:49 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     willy@infradead.org
Cc:     dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, warwish@yandex-team.ru
Subject: [PATCH v2 09/10] security: reduce stack footprint in loadpin_read_file()
Date:   Tue, 22 Jun 2021 20:44:23 +0300
Message-Id: <20210622174424.136960-10-warwish@yandex-team.ru>
In-Reply-To: <20210622174424.136960-1-warwish@yandex-team.ru>
References: <YLe9eDbG2c/rVjyu@casper.infradead.org>
 <20210622174424.136960-1-warwish@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stack usage reduced (measured with allyesconfig):

./security/loadpin/loadpin.c    loadpin_read_file       200     56      -144

Signed-off-by: Anton Suvorov <warwish@yandex-team.ru>
---
 security/loadpin/loadpin.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e..ad4e6756c038 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -78,11 +78,8 @@ static void check_pinning_enforcement(struct super_block *mnt_sb)
 	 * device, allow sysctl to change modes for testing.
 	 */
 	if (mnt_sb->s_bdev) {
-		char bdev[BDEVNAME_SIZE];
-
 		ro = bdev_read_only(mnt_sb->s_bdev);
-		bdevname(mnt_sb->s_bdev, bdev);
-		pr_info("%s (%u:%u): %s\n", bdev,
+		pr_info("%pg (%u:%u): %s\n", mnt_sb->s_bdev,
 			MAJOR(mnt_sb->s_bdev->bd_dev),
 			MINOR(mnt_sb->s_bdev->bd_dev),
 			ro ? "read-only" : "writable");
-- 
2.25.1

