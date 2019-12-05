Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B67411438A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 16:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfLEP3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 10:29:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39694 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLEP3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:29:18 -0500
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1ict48-0005V9-14
        for linux-fsdevel@vger.kernel.org; Thu, 05 Dec 2019 15:29:16 +0000
Received: by mail-wm1-f70.google.com with SMTP id v8so1116513wml.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 07:29:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LC6DDS7dzR3mgMabSVrO4Lfc9Ry73+/2Egm44NEkV5Y=;
        b=oLX4zlOc4PorskiJWL/SyhI+XzieM1OU+6GDpZ08D9KFkw/UdSrouL0tFflZL0LXkG
         6O6H3ggeZnmKboj4coAl3mTd4WZbMFrW9dRIX5ZiNKl4lA9X71r6SUEVhVAybkPx9hIL
         ke5UndrKquU55APQ3YYmmIgkk+l+I1Fzm1qNpjPX9m2ALCBdFWhpxfKaaSxQKsQGlgxS
         XnT/efAVgRGmLUHXbfQlj/MNTDnkn33EHnq20sJbtybbkpP1gZ3S3qGp8jr120EH0nni
         it8e6LXDnLRjSWu2qcSMqznDsrRZ4ko9h5eDtZSyVUaBPwU20Oi4p5J6iTBad0NCh9j1
         rBbQ==
X-Gm-Message-State: APjAAAVGy9XIOKyM4xtXIVCFdaIKRZFegQVYRZ1D+it0+8Sr7NI5Ee+n
        FlREm8f+XGxvTirJE4T1+6OgDy/VyQs/Fz0Xfo+/2dDgBHtSJDyhXcY6obREVIEC/44jDeYPOEN
        ciMo8w0djMYLqJxdA7wSbt6eqdZgIE6pwKyAavLXUziE=
X-Received: by 2002:a5d:4281:: with SMTP id k1mr11236633wrq.72.1575559755747;
        Thu, 05 Dec 2019 07:29:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqww3fLVvHw4i2+mxqUfxSNjvtsmae9g98lTbmDUho19nYRX5yQGivaJ4A4RPXoES4jgYCTINg==
X-Received: by 2002:a5d:4281:: with SMTP id k1mr11236599wrq.72.1575559755411;
        Thu, 05 Dec 2019 07:29:15 -0800 (PST)
Received: from localhost (host40-61-dynamic.57-82-r.retail.telecomitalia.it. [82.57.61.40])
        by smtp.gmail.com with ESMTPSA id g74sm179791wme.5.2019.12.05.07.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 07:29:14 -0800 (PST)
Date:   Thu, 5 Dec 2019 16:29:13 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: exfat: properly support discard in
 clr_alloc_bitmap()
Message-ID: <20191205152913.GJ3276@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the discard code in clr_alloc_bitmap() is just dead code.
Move code around so that the discard operation is properly attempted
when enabled.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 drivers/staging/exfat/exfat_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index d2d3447083c7..463eb89c676a 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -192,8 +192,6 @@ static s32 clr_alloc_bitmap(struct super_block *sb, u32 clu)
 
 	exfat_bitmap_clear((u8 *)p_fs->vol_amap[i]->b_data, b);
 
-	return sector_write(sb, sector, p_fs->vol_amap[i], 0);
-
 #ifdef CONFIG_EXFAT_DISCARD
 	if (opts->discard) {
 		ret = sb_issue_discard(sb, START_SECTOR(clu),
@@ -202,9 +200,13 @@ static s32 clr_alloc_bitmap(struct super_block *sb, u32 clu)
 		if (ret == -EOPNOTSUPP) {
 			pr_warn("discard not supported by device, disabling");
 			opts->discard = 0;
+		} else {
+			return ret;
 		}
 	}
 #endif /* CONFIG_EXFAT_DISCARD */
+
+	return sector_write(sb, sector, p_fs->vol_amap[i], 0);
 }
 
 static u32 test_alloc_bitmap(struct super_block *sb, u32 clu)
-- 
2.20.1

