Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB1E653526
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 18:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbiLUR2i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 12:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiLUR2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:28:15 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E861AA2F;
        Wed, 21 Dec 2022 09:28:10 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r126-20020a1c4484000000b003d6b8e8e07fso1879437wma.0;
        Wed, 21 Dec 2022 09:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jghot3JZGfw4NoEk9T1OvZadmJ48FJEB71fkAQxUvE=;
        b=AM0+hwuKhzQzdVYUfOb9yOvy8esRc+T3neeFtmk4M1JgZT+wtLQ06C1cMtn2Mk7Cu0
         DADbLi09ofUMUQWPiSCj+Ao7UyncFobXxYNJQSWKhIVVa9cYc6qsy81IPsiRY19aloEV
         O6ZbjetK0Y42uzJko2GtPVATJzdZSvHrO3JtbuJHbYJpFAj/+kcPuK++Raq8H+wJ9uBp
         8KE6TYtDRGiXcViP/HRyLVpYCqJRhqPxwPpJMUkt16xoMOV2FlxcP1++G1J1XohrvFxv
         xddavz8CBuBHQpXbWuREqjEZwVAP/HJEGXGPawK5/hfO3yWTJDkxDv3m+PhR0g4lQ6Dp
         GvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jghot3JZGfw4NoEk9T1OvZadmJ48FJEB71fkAQxUvE=;
        b=rl680KRmeg8KS16+D0jnOGx00WIQTyxH6taFMqcRSXbB+l2gEzBw8pgRIDIckza07H
         gbNZd/dgjen68vArd5HnXUFAjVNxFIbRBeY4ams2i4+NEHlwI8kdoPL0xgcn108e7Cqf
         8BRyQvm8PAxjGmrPa4p8bVjylXMZv9VpQmAXKRNn/SAwodtNEJaV2By2Wnu5Nrr0UScf
         3U5g6nfj8blFT9d7ZiGy2bFr3GH6ERWhOB0DoGnrVJP+SjVAcbSG5XYGzvSoKIgMfg25
         2KYKd4DxDrmgIsvYrSuGI6Pp0Xzv/WiAN8ZF/CZLQZle8c77Eaci13JfWfCZN/BgJii0
         rhTQ==
X-Gm-Message-State: AFqh2kqIzk5EpE6eMdiQNozJJiueUPlPcLRQyKoRn+7XQQrpvw0o2a7d
        PwPMA2VCd7YsoRzN6VNa/m9b/rg2BjE=
X-Google-Smtp-Source: AMrXdXv6YTC9OD5QAs53Or70fPklPQ23fthVfpqFTvWYD/6Jt5JUk7IZZ8a/wwBNHXV/Ho+/khTLGw==
X-Received: by 2002:a05:600c:3ac3:b0:3d1:cfcb:7d19 with SMTP id d3-20020a05600c3ac300b003d1cfcb7d19mr2563989wms.32.1671643689523;
        Wed, 21 Dec 2022 09:28:09 -0800 (PST)
Received: from localhost.localdomain (host-95-251-45-63.retail.telecomitalia.it. [95.251.45.63])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b003cffd3c3d6csm3003260wmr.12.2022.12.21.09.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 09:28:08 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 1/3] fs/ufs: Use the offset_in_page() helper
Date:   Wed, 21 Dec 2022 18:28:00 +0100
Message-Id: <20221221172802.18743-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221221172802.18743-1-fmdefrancesco@gmail.com>
References: <20221221172802.18743-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the offset_in_page() helper because it is more suitable than doing
explicit subtractions between pointers to directory entries and kernel
virtual addresses of mapped pages.

Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/ufs/dir.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 391efaf1d528..69f78583c9c1 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -87,8 +87,7 @@ void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
 		  struct page *page, struct inode *inode,
 		  bool update_times)
 {
-	loff_t pos = page_offset(page) +
-			(char *) de - (char *) page_address(page);
+	loff_t pos = page_offset(page) + offset_in_page(de);
 	unsigned len = fs16_to_cpu(dir->i_sb, de->d_reclen);
 	int err;
 
@@ -371,8 +370,7 @@ int ufs_add_link(struct dentry *dentry, struct inode *inode)
 	return -EINVAL;
 
 got_it:
-	pos = page_offset(page) +
-			(char*)de - (char*)page_address(page);
+	pos = page_offset(page) + offset_in_page(de);
 	err = ufs_prepare_chunk(page, pos, rec_len);
 	if (err)
 		goto out_unlock;
@@ -497,8 +495,8 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 {
 	struct super_block *sb = inode->i_sb;
 	char *kaddr = page_address(page);
-	unsigned from = ((char*)dir - kaddr) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
-	unsigned to = ((char*)dir - kaddr) + fs16_to_cpu(sb, dir->d_reclen);
+	unsigned int from = offset_in_page(dir) & ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
+	unsigned int to = offset_in_page(dir) + fs16_to_cpu(sb, dir->d_reclen);
 	loff_t pos;
 	struct ufs_dir_entry *pde = NULL;
 	struct ufs_dir_entry *de = (struct ufs_dir_entry *) (kaddr + from);
@@ -522,7 +520,7 @@ int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
 		de = ufs_next_entry(sb, de);
 	}
 	if (pde)
-		from = (char*)pde - (char*)page_address(page);
+		from = offset_in_page(pde);
 
 	pos = page_offset(page) + from;
 	lock_page(page);
-- 
2.39.0

