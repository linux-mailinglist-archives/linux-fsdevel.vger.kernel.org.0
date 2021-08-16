Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A813ED213
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 12:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhHPKim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 06:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhHPKim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:38:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1920C061764;
        Mon, 16 Aug 2021 03:38:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r9so23997888lfn.3;
        Mon, 16 Aug 2021 03:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfJatabbDRuLjub7mFadaE4bzboEivABMiAWlTI3GXI=;
        b=FRcS1yQ12WU7K0ZrS2Mhi1L27mX8U82kp/YGBiFsbIYoKjAefR8yXpjynkLeKOfHYb
         U0FrZU0SQuNc0RxvrQ1up2dlos0z2hheRmKN2oWXX0r5zmlrIC3Fvvo1qSvEm2eM1IjR
         tAFI+qqwks7gCwE0pOb6EvnmY7D0A1MWSazaarkx1NPPhdX3dZ7AMdznWSiHHTnqB57S
         2eWJDIIe/5hrQbpmLGVxU7O8cYSKi7GXwq2jevYN1eaoHBVwC7lrcXIGFWa36l4cn/cf
         3/fFmlE69w09gXSJ/6xTtjGbH13yE5833d1l3vrCGzNhownB42FmTIfNtBKjnoPep9iY
         ILHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfJatabbDRuLjub7mFadaE4bzboEivABMiAWlTI3GXI=;
        b=rSEw+W6BbfYmDuXAf4CQTjioo/909kewQicxHScGkaJQncettL8bVHPOaxI5KJBDeH
         f6hp88tGlpaXoZ+JZoBFUcoyUksA6ufrjxlqwQnJ/ZmSwwtsi7TdFDUqrsqZfiGn2LDg
         Z7/bPQzCSnhRud7/J75ihuszxD2rAgJUbhzIYfkF3vpUPco+Im0rxNZ6FT/UwZdcjxYP
         hRlSA9KmUZqp3OA8eT2oI1gfKwYKHErhIv2buusAYoUh28SFy5JH/N75oFXtFEsS+HT1
         iyvdoQGiMpILHylikio/BXDhZT07LZC9y2rMri34oX7ip0jBisOXB0efNQPLP3OpVzmP
         EvlA==
X-Gm-Message-State: AOAM530BQi/6Hz2MR323UX5kz2SeqJ/u2ZWEgSlEbPNVAJrWbCUs8m3W
        PzhtEGk4jVLU56vUHtBHxKr/NSI6zkx6M13J
X-Google-Smtp-Source: ABdhPJzs6220+8j1LIoVUYyvXJU+Edf3AwZGR/I89cb68hlCM2Bx8p3TwSGwCvE0yxT4Bgq0Mf12BA==
X-Received: by 2002:a05:6512:3f16:: with SMTP id y22mr10805648lfa.356.1629110288803;
        Mon, 16 Aug 2021 03:38:08 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id l6sm1136044ljj.40.2021.08.16.03.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 03:38:08 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/ntfs3: Use linux/log2 is_power_of_2 function
Date:   Mon, 16 Aug 2021 13:37:32 +0300
Message-Id: <20210816103732.177207-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We do not need our own implementation for this function in this
driver. It is much better to use generic one.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/ntfs_fs.h | 5 -----
 fs/ntfs3/run.c     | 3 ++-
 fs/ntfs3/super.c   | 9 +++++----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 0c3ac89c3115..c8ea6dd38c21 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -972,11 +972,6 @@ static inline struct buffer_head *ntfs_bread(struct super_block *sb,
 	return NULL;
 }
 
-static inline bool is_power_of2(size_t v)
-{
-	return v && !(v & (v - 1));
-}
-
 static inline struct ntfs_inode *ntfs_i(struct inode *inode)
 {
 	return container_of(inode, struct ntfs_inode, vfs_inode);
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 5cdf6efe67e0..ce6bff3568df 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
+#include <linux/log2.h>
 #include <linux/nls.h>
 
 #include "debug.h"
@@ -376,7 +377,7 @@ bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len,
 			if (!used) {
 				bytes = 64;
 			} else if (used <= 16 * PAGE_SIZE) {
-				if (is_power_of2(run->allocated))
+				if (is_power_of_2(run->allocated))
 					bytes = run->allocated << 1;
 				else
 					bytes = (size_t)1
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 6be13e256c1a..c1b7127f5e61 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -29,6 +29,7 @@
 #include <linux/exportfs.h>
 #include <linux/fs.h>
 #include <linux/iversion.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/nls.h>
 #include <linux/parser.h>
@@ -735,13 +736,13 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	boot_sector_size = (u32)boot->bytes_per_sector[1] << 8;
 	if (boot->bytes_per_sector[0] || boot_sector_size < SECTOR_SIZE ||
-	    !is_power_of2(boot_sector_size)) {
+	    !is_power_of_2(boot_sector_size)) {
 		goto out;
 	}
 
 	/* cluster size: 512, 1K, 2K, 4K, ... 2M */
 	sct_per_clst = true_sectors_per_clst(boot);
-	if (!is_power_of2(sct_per_clst))
+	if (!is_power_of_2(sct_per_clst))
 		goto out;
 
 	mlcn = le64_to_cpu(boot->mft_clst);
@@ -757,14 +758,14 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	/* Check MFT record size */
 	if ((boot->record_size < 0 &&
 	     SECTOR_SIZE > (2U << (-boot->record_size))) ||
-	    (boot->record_size >= 0 && !is_power_of2(boot->record_size))) {
+	    (boot->record_size >= 0 && !is_power_of_2(boot->record_size))) {
 		goto out;
 	}
 
 	/* Check index record size */
 	if ((boot->index_size < 0 &&
 	     SECTOR_SIZE > (2U << (-boot->index_size))) ||
-	    (boot->index_size >= 0 && !is_power_of2(boot->index_size))) {
+	    (boot->index_size >= 0 && !is_power_of_2(boot->index_size))) {
 		goto out;
 	}
 
-- 
2.30.2

