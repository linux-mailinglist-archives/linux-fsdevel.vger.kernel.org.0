Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A301B6592AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 23:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiL2WvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 17:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiL2WvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:51:08 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CE920A;
        Thu, 29 Dec 2022 14:51:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id z16so2008646wrw.1;
        Thu, 29 Dec 2022 14:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jghot3JZGfw4NoEk9T1OvZadmJ48FJEB71fkAQxUvE=;
        b=o+bfXuHUlhYapQjk1affWWJ5VDYcRMCuwcxk/BkE7p2ZX5N8fbd8xHK0eN7DI4Tm4J
         FAQKxN2KRfhhFuESXYtXtPS4c8UIIey4brcGY3n+cqBU/4KpKQlV7ces3PUCueqcxWEf
         egWSvyrKN/YvDaACP5ZDTuUv8o82JypJ/DQcq3f1hABLw9fEPeemn5HuFMipMdJxYC3m
         VbUYSrPgehW8gPjFF2A8ruwbotv4aTL1aC478VWx3z7rt2/YdcwYHJn1XnZKceT4rL/6
         2/QQQ+FqPhNxiYy5EARt5CPc+mEXlKgZ7eCR02n4Xa8dHsHoSMuZ0TJ2v47kh2ueMKQr
         Yk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jghot3JZGfw4NoEk9T1OvZadmJ48FJEB71fkAQxUvE=;
        b=QD/c+425XYmyql7JvgmL8xsrCTf3azLtBaDI6UoIOdnYGq9P4lKIkoZLtN2KXe4dhJ
         ZrMZ0LJ4E+EEJtlGWKGqm/bAMu/ifvGeqwWqO4rU/ITQ9zWZf22bM3DAQUk8skJnFY6g
         WxukBdIUpnu+iUDalN7Mk0jJcyOUHsMaL1HznXqfSIrIXI44jOAC39Egpu/mVoxxcBSR
         ep7B2uFbMUkOANkImc8Ots07wr3hAvFXJGRzBJNWogociyXplsVOhkM1CDHoZ+UO4I4p
         3btUrh12/smJs1uVQ90IYQ+s6t1/iw5nRiyipI6u3RUETP8PhCiX41ObiqV5mqppAZfM
         8zsQ==
X-Gm-Message-State: AFqh2kpVwDsR85c41+6pxc8rmAz8CqXN77+8KSh7/bRE3rgkpfga1m2j
        nwt8ykaK34KbkOyG1j6A3NY2oZaZLrg=
X-Google-Smtp-Source: AMrXdXsaWAGUC+UA0qhQ6XWvSkTpLuxHWR1u6yMco/+swVl4+AlFMaIIsO+Vl2cKprfKRIfpwFcJiw==
X-Received: by 2002:adf:fd8c:0:b0:28e:f7a:9fec with SMTP id d12-20020adffd8c000000b0028e0f7a9fecmr1175004wrr.69.1672354265933;
        Thu, 29 Dec 2022 14:51:05 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id p3-20020adfcc83000000b0027a57c1a6fbsm13493312wrj.22.2022.12.29.14.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 14:51:05 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 1/4] fs/ufs: Use the offset_in_page() helper
Date:   Thu, 29 Dec 2022 23:50:57 +0100
Message-Id: <20221229225100.22141-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229225100.22141-1-fmdefrancesco@gmail.com>
References: <20221229225100.22141-1-fmdefrancesco@gmail.com>
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

