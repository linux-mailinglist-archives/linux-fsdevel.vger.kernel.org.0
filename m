Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5581CC572
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 01:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgEIXqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 19:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728775AbgEIXqG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:06 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E3CC05BD11;
        Sat,  9 May 2020 16:46:04 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAN-004iRs-H3; Sat, 09 May 2020 23:45:59 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 11/20] amifb: get rid of pointless access_ok() calls
Date:   Sun, 10 May 2020 00:45:48 +0100
Message-Id: <20200509234557.1124086-11-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

addresses passed only to get_user() and put_user()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/video/fbdev/amifb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/amifb.c b/drivers/video/fbdev/amifb.c
index 20e03e00b66d..6062104f3afb 100644
--- a/drivers/video/fbdev/amifb.c
+++ b/drivers/video/fbdev/amifb.c
@@ -1855,8 +1855,6 @@ static int ami_get_var_cursorinfo(struct fb_var_cursorinfo *var,
 	var->yspot = par->crsr.spot_y;
 	if (size > var->height * var->width)
 		return -ENAMETOOLONG;
-	if (!access_ok(data, size))
-		return -EFAULT;
 	delta = 1 << par->crsr.fmode;
 	lspr = lofsprite + (delta << 1);
 	if (par->bplcon0 & BPC0_LACE)
@@ -1935,8 +1933,6 @@ static int ami_set_var_cursorinfo(struct fb_var_cursorinfo *var,
 		return -EINVAL;
 	if (!var->height)
 		return -EINVAL;
-	if (!access_ok(data, var->width * var->height))
-		return -EFAULT;
 	delta = 1 << fmode;
 	lofsprite = shfsprite = (u_short *)spritememory;
 	lspr = lofsprite + (delta << 1);
-- 
2.11.0

