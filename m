Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310A16989C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 02:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBPBOM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 20:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBPBOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:14:11 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441483C2BF;
        Wed, 15 Feb 2023 17:14:10 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676510048;
        bh=UR4vbRpjhoZfLc+MuBzlPXgF1uQAu6tpAvHYcRD8A1Q=;
        h=From:Date:Subject:To:Cc:From;
        b=iyYb3idp+As89CUlExHZ3mu8uPoPO7RGrXeni/3AEYmdR7ig965KPb7CGhXqWO1jF
         3rxonGsdI5wVc9OhpoG6+bW6DXgnoq33CVUyMaya6ihnNE1eIX+UKUo50M0nmYMt5n
         lfPttNKtu/Sd36k1fmoP485BI5Q23i8zSLq3gsco=
Date:   Thu, 16 Feb 2023 01:14:06 +0000
Subject: [PATCH] chardev: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230216-kobj_type-chardev-v1-1-94e213b73e85@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAF2D7WMC/x2N0QqCQBBFf0XmuYF1C6l+JSJ23WtOySqzJYr47
 w09nnM53I0KVFDoWm2kmKXImA3qQ0VtH/ITLMmYvPNH5+uG32N8PT7rBLZdE2buXDqfcGkiPMi
 6GAo4ashtb2X+DoPJSdHJ8j+63ff9B1lCcQl4AAAA
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676510046; l=1082;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=UR4vbRpjhoZfLc+MuBzlPXgF1uQAu6tpAvHYcRD8A1Q=;
 b=8GAC7gGXwSeDxPLUuXlTzzPKDXM0MmNqYTSid6lYULq4FC6fzQV+Vi4TrhiCxTAX1nZLoc0UO
 XOHl9K/yhP4Ahma+SFr/YbdySPVM/bGcOeQ/p2OQbESiLZpNPezahNv
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

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/char_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index 13deb45f1ec6..b33331cb97cd 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -624,11 +624,11 @@ static void cdev_dynamic_release(struct kobject *kobj)
 	kobject_put(parent);
 }
 
-static struct kobj_type ktype_cdev_default = {
+static const struct kobj_type ktype_cdev_default = {
 	.release	= cdev_default_release,
 };
 
-static struct kobj_type ktype_cdev_dynamic = {
+static const struct kobj_type ktype_cdev_dynamic = {
 	.release	= cdev_dynamic_release,
 };
 

---
base-commit: 033c40a89f55525139fd5b6342281b09b97d05bf
change-id: 20230216-kobj_type-chardev-f0d84e96be2e

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

