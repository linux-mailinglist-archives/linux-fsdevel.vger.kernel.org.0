Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB17A206A39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 04:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbgFXCas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 22:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387928AbgFXCas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:30:48 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196E6C061573;
        Tue, 23 Jun 2020 19:30:48 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u14so466406pjj.2;
        Tue, 23 Jun 2020 19:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kz8igf69x/YCiVig6vuZapMiGHROM0tqo1mJUJV97Sc=;
        b=pGNEcL3rrZ37V1G8NfKUZ2sLL2/BjX+eXkKe75m6uLtjgXeSq5GUyZ1HLpBHA1GTT1
         J4MkxnlN1I8pVKtV7jnvPekSm5CPWnIuxAQHGe9y4YAFrybqaFH6YkYzgH7YHh0URQeQ
         FB3hCGjeeAnU3/229aVelPoVK3hlYItN/UPQdUzEoe+oRbF3vaxRPjwUegrqyNU/Ll9H
         AZm6gz03142rhQgNlrSAlEOUIGvr1bMZ6VNqQu2zcrliNvCmVaGQoi/tw+sUO2osgjy5
         JgjNqGkFv3asOrIzooTIiFpihqQB5ja3E6v15PF9/DCqvwkFZM+nDyb0+yV9tTr4YIvT
         2IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kz8igf69x/YCiVig6vuZapMiGHROM0tqo1mJUJV97Sc=;
        b=bh8DpvsMoEay7oPiSiladqepxhvsHLZOtfZZrkLyuZ9FPdsC+Groa4/Ln+hyXjA1V+
         KCMkr/NDfs3ve3jai9z9snOvzcdr/7Cb3LupRiIPq02gkUG3T/5nefmkb7ZS6szhuPln
         H3VlyDVwyXWxv8hVbR239zifLhbDOrJML1hU68+XWXCtPefKx1kEtX1v+U2qlWnZ0yr/
         06R+IPnmbH0I7SkapK9cxO7JHV3qKLjDD62frYkD8OZH31wPoHQGLXPIkiMxB7CCNiBh
         kfiXGBDG1m+cLFoHIXHJVQizAgtiBDVGyjfrLAZbOB1fpGfvFZqnrLElWbdnTWBOdX9e
         LDkg==
X-Gm-Message-State: AOAM531e1EZMuqlUkTSk47Ha28C5/uzOGLhgVux6La9c3dLqfZu4WkrS
        9ZmpkrTqHGKLleyCJ9yUUMc=
X-Google-Smtp-Source: ABdhPJxVmnEqE6f3AMcz5CJcIKSQMfeo50pGi7YL4Y7vjAr9Aebva5jQdjfLnHyvzEK2IQmWrwj+rg==
X-Received: by 2002:a17:902:c14a:: with SMTP id 10mr27237916plj.222.1592965847375;
        Tue, 23 Jun 2020 19:30:47 -0700 (PDT)
Received: from dc803.localdomain (FL1-125-199-162-203.hyg.mesh.ad.jp. [125.199.162.203])
        by smtp.gmail.com with ESMTPSA id h3sm18206070pfr.2.2020.06.23.19.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 19:30:46 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] exfat: optimize exfat_zeroed_cluster()
Date:   Wed, 24 Jun 2020 11:30:40 +0900
Message-Id: <20200624023041.30247-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace part of exfat_zeroed_cluster() with exfat_update_bhs().
And remove exfat_sync_bhs().

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2
 - Rebase to latest exfat-dev

 fs/exfat/fatent.c | 53 +++++++++--------------------------------------
 1 file changed, 10 insertions(+), 43 deletions(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 82ee8246c080..c3c9afee7418 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -229,21 +229,6 @@ int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
 	return 0;
 }
 
-static inline int exfat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
-{
-	int i, err = 0;
-
-	for (i = 0; i < nr_bhs; i++)
-		write_dirty_buffer(bhs[i], 0);
-
-	for (i = 0; i < nr_bhs; i++) {
-		wait_on_buffer(bhs[i]);
-		if (!err && !buffer_uptodate(bhs[i]))
-			err = -EIO;
-	}
-	return err;
-}
-
 int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
 {
 	struct super_block *sb = dir->i_sb;
@@ -265,41 +250,23 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
 	}
 
 	/* Zeroing the unused blocks on this cluster */
-	n = 0;
 	while (blknr < last_blknr) {
-		bhs[n] = sb_getblk(sb, blknr);
-		if (!bhs[n]) {
-			err = -ENOMEM;
-			goto release_bhs;
-		}
-		memset(bhs[n]->b_data, 0, sb->s_blocksize);
-		exfat_update_bh(bhs[n], 0);
-
-		n++;
-		blknr++;
-
-		if (n == nr_bhs) {
-			if (IS_DIRSYNC(dir)) {
-				err = exfat_sync_bhs(bhs, n);
-				if (err)
-					goto release_bhs;
+		for (n = 0; n < nr_bhs && blknr < last_blknr; n++, blknr++) {
+			bhs[n] = sb_getblk(sb, blknr);
+			if (!bhs[n]) {
+				err = -ENOMEM;
+				goto release_bhs;
 			}
-
-			for (i = 0; i < n; i++)
-				brelse(bhs[i]);
-			n = 0;
+			memset(bhs[n]->b_data, 0, sb->s_blocksize);
 		}
-	}
 
-	if (IS_DIRSYNC(dir)) {
-		err = exfat_sync_bhs(bhs, n);
+		err = exfat_update_bhs(bhs, n, IS_DIRSYNC(dir));
 		if (err)
 			goto release_bhs;
-	}
-
-	for (i = 0; i < n; i++)
-		brelse(bhs[i]);
 
+		for (i = 0; i < n; i++)
+			brelse(bhs[i]);
+	}
 	return 0;
 
 release_bhs:
-- 
2.25.1

