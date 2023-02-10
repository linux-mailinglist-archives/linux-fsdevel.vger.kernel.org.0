Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D19D691691
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 03:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjBJCO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 21:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBJCOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:14:55 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02DE6F23D;
        Thu,  9 Feb 2023 18:14:47 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675995286;
        bh=PzdaMVxSEN1MS1ApJxFjAZ9RkslBEF+CPIjqjevsB98=;
        h=From:Date:Subject:To:Cc:From;
        b=g6QlAfPToQwM18srJO+qvWKrgP3Hoca0n6ZJZPqgHeu2DblLPaxYHyZfoIxRPpaTP
         bAJaCtbx8Q8N/40J2xy99MxX0Vqb9i3BbYy8IqBqEC1HJiFl5E90ibyp/qAZTtliFZ
         fQQ50TkHcURdEZTDIhRd8SAVGR3sMiWJTiMFT4xs=
Date:   Fri, 10 Feb 2023 02:14:44 +0000
Subject: [PATCH] zonefs: make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230210-kobj_type-zonefs-v1-1-9a9c5b40e037@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAJOo5WMC/x2N0QrCMAwAf2Xk2UCb+qK/IiLtzFx0pKOZoo79u
 8HHOzhuBeMmbHDsVmj8EpOqDnHXQT9mvTHK1RkoUAoUAz5quV+Wz8z4rcqDYY60P0QKKZUEnpV
 sjKVl7UcP9TlNLufGg7z/n9N5237JuT6pdwAAAA==
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675995284; l=1028;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=PzdaMVxSEN1MS1ApJxFjAZ9RkslBEF+CPIjqjevsB98=;
 b=rR1az0+ORQFoQO0bkjkP7ciZtCZ2UX/pMF+cwVbpXltMGiUzaaEnnkSHCid7eCQFAxjW3BQYm
 zeAr28pD04zAbYG1DTzSPqdsY2Ge70/0d55u6MoM27nYeppUPqEfrUR
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/zonefs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
index 9920689dc098..8ccb65c2b419 100644
--- a/fs/zonefs/sysfs.c
+++ b/fs/zonefs/sysfs.c
@@ -79,7 +79,7 @@ static const struct sysfs_ops zonefs_sysfs_attr_ops = {
 	.show	= zonefs_sysfs_attr_show,
 };
 
-static struct kobj_type zonefs_sb_ktype = {
+static const struct kobj_type zonefs_sb_ktype = {
 	.default_groups = zonefs_sysfs_groups,
 	.sysfs_ops	= &zonefs_sysfs_attr_ops,
 	.release	= zonefs_sysfs_sb_release,

---
base-commit: e544a07438522ab3688416e6e2e34bf0ee6d8755
change-id: 20230210-kobj_type-zonefs-a124912033b3

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

