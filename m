Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005E27B3D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 22:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfG3UAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 16:00:31 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:53185 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfG3UAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:00:31 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MLAF0-1hbZdd1VJq-00IAlM; Tue, 30 Jul 2019 22:00:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mikulas Patocka <mpatocka@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v5 16/29] compat_ioctl: move ATYFB_CLK handling to atyfb driver
Date:   Tue, 30 Jul 2019 21:55:32 +0200
Message-Id: <20190730195819.901457-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730195819.901457-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
 <20190730195819.901457-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0ZxSBrz/L44EWNzbRv73eLZ9rL3i0WOjEqW3ByO+yWHlG5mb1W7
 uZYyt/mHnDhNF5/3cHikieXcTxoRI9SKCP3A6kV/mnrd3IZNBwdIIPy5ag5HJSr5fmja9AP
 ngK564Niy37kfuJ33rToKE5tPXHU8NZustU3CCj6664tSYM2jhcIpvCic+w3qXngEh036DL
 3Q9yzWdV07Rb2faSlGosA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9fZ+4C+PBKw=:dsFl5vdmzgFilRAMPDWfF8
 n1bCvRStU4hPhqCc9cfPEQEwarWf8HuJUn5UZqPeQUVRZUSvzeoa0e/b/Bsdr6kPYtLQKDl86
 hT0/hqP4pYp89gNPZqPYDKtqfDKRGn8FwLqHG3d0b/6kCiUetQ79BjTleg50jEeJz4CwzczDP
 JCscKWrDAXqGeqY9ir13K18HEIbm9ZCC2jja+6XO2UuVrcNWbxyZOVA0mpW1TDcAouEAAODx6
 FGzi5u2ASC6nj3JWICwb7QbXkXIABd/zYsxjRWyiXvckzthwJmC+0xCYYWDpEy22z/qaJ5HLR
 pzbkaCrc97F5plaH+udhDlF1ev7aIpuh+guFDlq+k9be8Wdy3HZcmWQdbTNrhK+5Hrf1CpKXK
 yDvyHEwWnRgXoTtKRIg3s+do7xpeNgpsYH7pg42vb29baat8FJHwRVJgyQJAwx6dehVRECiD0
 M1JwtDP78bzH0wITzb79yHNP9ldb3jOEgSljUAOl1GSLReyTZqs8CnI0I/WswLpKdi3ontffL
 W/zpL4zEinmxkerkcEg9r68QlJXVFC35/Qz27JPLg2fBd5rClltlnZR/l/lDbvUumzfLHevLV
 jWoWTj8c5+cTswTNznndye5ftcUhx7F0e5Zh9kj2acOdhrSqbOaEGIZxiosbuziS4ZaB6Y31D
 iTj6VRNq5x2O/ACd1YiEDpugSWVpPRY+fdQOmx7Bxy/Te+e15vcQbVWUN0sQWnT4M98daRpks
 5SrWZpLrM0rNjYM8gtXpWszwMTjxd512fD0deQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are two obscure ioctl commands, in a driver that only
has compatible commands, so just let the driver handle this
itself.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/aty/atyfb_base.c | 12 +++++++++++-
 fs/compat_ioctl.c                    |  2 --
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 72bcfbe42e49..63bc76a1b2f9 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -48,7 +48,7 @@
 
 ******************************************************************************/
 
-
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
@@ -235,6 +235,13 @@ static int atyfb_pan_display(struct fb_var_screeninfo *var,
 			     struct fb_info *info);
 static int atyfb_blank(int blank, struct fb_info *info);
 static int atyfb_ioctl(struct fb_info *info, u_int cmd, u_long arg);
+#ifdef CONFIG_COMPAT
+static int atyfb_compat_ioctl(struct fb_info *info, u_int cmd, u_long arg)
+{
+	return atyfb_ioctl(info, cmd, (u_long)compat_ptr(arg));
+}
+#endif
+
 #ifdef __sparc__
 static int atyfb_mmap(struct fb_info *info, struct vm_area_struct *vma);
 #endif
@@ -290,6 +297,9 @@ static struct fb_ops atyfb_ops = {
 	.fb_pan_display	= atyfb_pan_display,
 	.fb_blank	= atyfb_blank,
 	.fb_ioctl	= atyfb_ioctl,
+#ifdef CONFIG_COMPAT
+	.fb_compat_ioctl = atyfb_compat_ioctl,
+#endif
 	.fb_fillrect	= atyfb_fillrect,
 	.fb_copyarea	= atyfb_copyarea,
 	.fb_imageblit	= atyfb_imageblit,
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index b65eef3d4787..a4e8fb7da968 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -696,8 +696,6 @@ COMPATIBLE_IOCTL(CAPI_CLR_FLAGS)
 COMPATIBLE_IOCTL(CAPI_NCCI_OPENCOUNT)
 COMPATIBLE_IOCTL(CAPI_NCCI_GETUNIT)
 /* Misc. */
-COMPATIBLE_IOCTL(0x41545900)		/* ATYIO_CLKR */
-COMPATIBLE_IOCTL(0x41545901)		/* ATYIO_CLKW */
 COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
-- 
2.20.0

