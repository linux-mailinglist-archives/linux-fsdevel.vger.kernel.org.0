Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6BF64967D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Dec 2022 22:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiLKVbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 16:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiLKVbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 16:31:22 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD7ADE93;
        Sun, 11 Dec 2022 13:31:21 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so3631074wmb.5;
        Sun, 11 Dec 2022 13:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iT8jy7hXGuLdSI3WnW19MAFpxEEAB5GqxCDkyx7KpM4=;
        b=bHIaQoWiU/RqdS0GRKzMghm5tUXLJ+904G799bZNyECaA+xGQUUX5VrxuxK60g4z1n
         ngvtGi9jl+kCHdtgF0pR7EywnsK79hRXBKqaeJB7YvykSu+dv3RGDRBDup5d+lIuKe3/
         B+3y71WOzZdUAnsPbvB6H4Fndjt0fS/VtB1i37X3gr896cbtSB+Qxi2unLBTDyxx6UcC
         F5mzvNnVp3c/baEZLDKJKe4KKn3YpB8VlNJs0i5ZCxfwqT+1oDdT12CFjm+pxWPckD8M
         cAUtAtvKLgwtxI0Q1IO2y0ezzQ0OJpGi5mBU6ghnuvBKIM8TOToMwV0KANPkWM42kE62
         macw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iT8jy7hXGuLdSI3WnW19MAFpxEEAB5GqxCDkyx7KpM4=;
        b=0juqYqG7XVTesbxuRUg9S87e5Nza6+NxJw6jykgZKYwQZpwAes1nJugVw6Oa13H6Ar
         Vz9vaYciAoL1o/Czciw4/gViDw3qXkybQiPuR1as2p30BfEFwyEkTxSUs1cVjEWFUhZ9
         N1UIaaLpWfvyU2t9ZRNIidZxdF50HfFmuG8EXprPWMFjyi2aP/QK8KKoNj1eql7QcOF9
         ccCdLDpjyL8Hh8wfZNWwfuK3t+nItDw8LUFe2yF7cjOydgnnhoTyVRjWE43thwi9OAxW
         a98OIma1XsQ7yOgnlBH0O9M6wLqSxOndINnL9ujbtqwiCjAntpLMH8tlNDFmss0rpzet
         Otig==
X-Gm-Message-State: ANoB5pmMx6BEumNACpGgKgySa7RAAx9pkCNo7l1+Dc+qLjbRqkeQuXg3
        uaWNZ7mE/oDDb/saZhf8K70=
X-Google-Smtp-Source: AA0mqf5zWAFa4VcpAunSbDQqJ17B48IWR0tqfODzum12dcsBaja0xsp9d+A8KtyFeJosx1va5PbGOw==
X-Received: by 2002:a05:600c:3584:b0:3d1:bf7c:391c with SMTP id p4-20020a05600c358400b003d1bf7c391cmr10228233wmq.4.1670794279732;
        Sun, 11 Dec 2022 13:31:19 -0800 (PST)
Received: from localhost.localdomain (host-95-247-100-134.retail.telecomitalia.it. [95.247.100.134])
        by smtp.gmail.com with ESMTPSA id m127-20020a1c2685000000b003d1d5a83b2esm6866350wmm.35.2022.12.11.13.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 13:31:19 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 1/3] fs/ufs: Use the offset_in_page() helper
Date:   Sun, 11 Dec 2022 22:31:09 +0100
Message-Id: <20221211213111.30085-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221211213111.30085-1-fmdefrancesco@gmail.com>
References: <20221211213111.30085-1-fmdefrancesco@gmail.com>
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
2.38.1

