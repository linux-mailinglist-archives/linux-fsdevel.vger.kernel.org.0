Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19D764FBA0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 19:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLQSsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 13:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLQSsH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:48:07 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA22BDFB4;
        Sat, 17 Dec 2022 10:48:05 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso6206369wme.5;
        Sat, 17 Dec 2022 10:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jghot3JZGfw4NoEk9T1OvZadmJ48FJEB71fkAQxUvE=;
        b=WE0WzPGkqsj6zyGeajdPvYaf/k3hmevTcSGMxGArvTW9v5lOZPAr8Ozs1l+g2F8Zq7
         /oZUmvpwC33JlKpraDe+0S9fVTOOUA1E+G3z55lzjwcvvA45Kgd+BqUBlPCGmf8Uto6X
         O5E0YpjaBlecDdg6iVx8CN49OxG/tvWDzbBOkjrzAOB7YukX7rs3W8RQk5QRbRii/Q41
         Vs2Ph+qQEurOTUoN6Ky7VXrxVK0hyquoRvyAX/Fh+PCP/0H4E/3RcJ4Rl4zDR0x/Fk8/
         wmZcin4livQl5IPm1NTCtMscYHA2uN6NiSoHn33Z0GQixJFrpx3JwGv5YsTGhoxz3AbM
         GeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jghot3JZGfw4NoEk9T1OvZadmJ48FJEB71fkAQxUvE=;
        b=RQBz+Fzuxzqt9yT03PpxDq1RFAc4AacUoggpEZoxcGvv3yB72FLFK1G2ol8RsWJAiV
         M08DnnRrKA0sySST4rcrgq2HhG7DHVXDbGskh0RYGbQ39Ner5OX1JcOYvo27SifTEaUn
         2YGD4fOywTZksK7naB2JPK7MZf9xZzpNopPnPfdetDcnLr82GRxOM1yiHQBmUP1wwmZf
         ylYykROMADhQ40OmbuX7rmbwHSamVE1fG6UXQHTt34KXp064X7ldp7TjqMj8AIm1fTmB
         0uPQnHDbYG+9SpnXakdcnNa7JuixR+OJe8VzBdk88CPjmjgjm4qqmpHwaPl7/QG+JjbF
         sc8A==
X-Gm-Message-State: ANoB5pmwv2wQafi851MUu6GXsHb5mWWoiC8BUOKC8JbyvROvP7R79M2f
        vExd3yisP0PJ7VA5SiHWq+6SxJ+RWfI=
X-Google-Smtp-Source: AA0mqf5jdg0E2crSBPi//MjtyoxVPzR9kYPhFogbezogWbdeW/2YTw3h4tWpEGOh0czRE3laKTz+vg==
X-Received: by 2002:a05:600c:4e0e:b0:3cf:b73f:c061 with SMTP id b14-20020a05600c4e0e00b003cfb73fc061mr27304881wmq.16.1671302884427;
        Sat, 17 Dec 2022 10:48:04 -0800 (PST)
Received: from localhost.localdomain (host-79-17-30-229.retail.telecomitalia.it. [79.17.30.229])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c020800b003b4935f04a4sm7726062wmi.5.2022.12.17.10.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 10:48:03 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 1/3] fs/ufs: Use the offset_in_page() helper
Date:   Sat, 17 Dec 2022 19:47:47 +0100
Message-Id: <20221217184749.968-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221217184749.968-1-fmdefrancesco@gmail.com>
References: <20221217184749.968-1-fmdefrancesco@gmail.com>
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

