Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 763A9FA6DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 03:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfKMCu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 21:50:58 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:47954 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727241AbfKMCuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:50:55 -0500
Received: from mr5.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAD2or34025268
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 21:50:53 -0500
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAD2omAu012152
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 21:50:53 -0500
Received: by mail-qv1-f69.google.com with SMTP id i16so535214qvm.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 18:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8QTCb+WFX3FpJ3fVztSaFH+rTvdtPtL4YNVcXp9Kn7s=;
        b=qQCsNPmn+hXv+lNyTibnsOmHxFPgFsrUftwRfwUkrsSMFriHXTsg1k3j33TZjdDOeV
         IvKf8R5O0odHEkIF/PyTR/viGRsmtJrPmXzsJyWmrKzvLquH+1HJVkpKBe7nkGYJlpkq
         20NOiDF/2OqzxROkHavKDqc2NncyJG4JKWmEwELynoSrnHkgenj9QqqUWqWLtKOpFRZJ
         6MlkECdE8tIExsyIK1pHtMxraA0TcglwkGvqQgKJxyI7cd7E+OSR9naz35udJQ4QSnTb
         xoXqTEDVZCwloK4gwW8mToI80c1Hx+yfucRUl8teDsMWJJkcYoTHBfM9+MM+29uBAwVW
         OhmA==
X-Gm-Message-State: APjAAAW2X98sgq1Itqc5koS3TqZ0L+zUVAGUxYKagpL5Nq6JSs/gwY28
        yWsPRG8cv/bsVnD4DA5Sh3vdt/ssnJcPrl4lakSKD67Lsc4j2QKNL2Zw7Fn2fJpRRwCkA8NVplT
        Gy9fzz0PrmeEIJSE3PXqccf/UxFaLysPafamc
X-Received: by 2002:a37:c44b:: with SMTP id h11mr646980qkm.234.1573613448299;
        Tue, 12 Nov 2019 18:50:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyWCFwzxoLiz+DgZpL/3YHBFIyVsL+YXuOhgpxf7giev41idLzl1WPF245u/f3hwaBto4LWkw==
X-Received: by 2002:a37:c44b:: with SMTP id h11mr646972qkm.234.1573613448001;
        Tue, 12 Nov 2019 18:50:48 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id j71sm319265qke.90.2019.11.12.18.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 18:50:47 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        syzbot+787bcbef9b5fec61944b@syzkaller.appspotmail.com,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: exfat: convert WARN to a pr_info
Date:   Tue, 12 Nov 2019 21:50:34 -0500
Message-Id: <20191113025035.186051-1-valdis.kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot took a nosedive because it runs with panic_on_warn set. And
it's quite correct, it shouldn't have been a WARN in the first place.
Other locations just use a pr_info(), so do that here too.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Reported-by: syzbot+787bcbef9b5fec61944b@syzkaller.appspotmail.com
Fixes: c48c9f7ff32b ("staging: exfat: add exfat filesystem code to staging")
---
 drivers/staging/exfat/exfat_blkdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat_blkdev.c b/drivers/staging/exfat/exfat_blkdev.c
index 7bcd98b13109..8204720b2bf2 100644
--- a/drivers/staging/exfat/exfat_blkdev.c
+++ b/drivers/staging/exfat/exfat_blkdev.c
@@ -59,8 +59,8 @@ int exfat_bdev_read(struct super_block *sb, sector_t secno, struct buffer_head *
 	if (*bh)
 		return 0;
 
-	WARN(!p_fs->dev_ejected,
-	     "[EXFAT] No bh, device seems wrong or to be ejected.\n");
+	if (p_fs->dev_ejected)
+		pr_info("[EXFAT] No bh, device seems wrong or to be ejected.\n");
 
 	return -EIO;
 }
@@ -112,8 +112,8 @@ int exfat_bdev_write(struct super_block *sb, sector_t secno, struct buffer_head
 	return 0;
 
 no_bh:
-	WARN(!p_fs->dev_ejected,
-	     "[EXFAT] No bh, device seems wrong or to be ejected.\n");
+	if (p_fs->dev_ejected)
+		pr_info("[EXFAT] No bh, device seems wrong or to be ejected.\n");
 
 	return -EIO;
 }
-- 
2.24.0

