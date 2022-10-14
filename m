Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A3D5FEB23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 10:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJNIuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 04:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiJNIt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:49:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D5832BA7;
        Fri, 14 Oct 2022 01:49:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c9-20020a05600c100900b003c6da0f9b62so2546530wmc.1;
        Fri, 14 Oct 2022 01:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOV3h57ut5GHhGlnLsxkEHBnkvFbonX9ORLLuFusyi0=;
        b=GfG0sfEgh2ptierbWCnoguBubKf8JDmmicxf1uJSpFpGObOsFWBqAhZpEYJ5Krl+yo
         ZD1cwtaOtRSGc/If6NW2e99cfjHy447Mfkim3JBoO6lFHYVO43xdxReqY6l8QyFBn4Qc
         tGp1dAr825o3wC1fJ3+NYRhGU424uQwhoZSV5IZH/fycyAueUF0kXNr3kuIlzRScRjEM
         aqxVZim71FxWOLPQbEMG0l3htKZad0jBeYIJY2DLYtsbqGW8wiG+xF4GplnsrmQkllp0
         oM0aAGnq+3SiJfldcLJyIp7maRrgbF8Lv6EtCNGsqquNz1rjsbw3Zxsk5zbVXT/52SAq
         oChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOV3h57ut5GHhGlnLsxkEHBnkvFbonX9ORLLuFusyi0=;
        b=yFc18Ic5uajmvY858S5SmYtEssLPjsgZ3xhbt5SLxBd5DKgGxNVdPiEKVGqQcyiRVx
         hOYbYRKrNermmCe3SP/LNZrws7EhYTeigD8acNBYogs4HL3q1t/oryvNT0GKvT3DQ/vL
         ASvTa9n4jk01jTgw/pty0FaBVcQOp7Fd8oEFtN7rXdsvEFXIkp0ljWQpwfboFF6bArc3
         H1a2JhbnJYZKSUpQPynem1jCiNBLmeh9vXDhInQtZOUywg7QAGrYweNLFT8t9a+o2jIG
         A5/RbJgP5ZAlal12VYy1tiq6LUlR8P8HYAH6tm62y37HbLePfFlN/pm6ZR8UaYEP888E
         mefw==
X-Gm-Message-State: ACrzQf3+WPZYFCGsXiYY2zWNaDDGanw5mkjHffyFN+3lEqjki/eraPHS
        DpNQ/Rn2M9k1CHTWYbgLgs8=
X-Google-Smtp-Source: AMsMyM77yv8Pg3D5oDIyozFj8+3/IZB1l6YKqrDliEThMChfauLgTj828aJxH3GHPZOHomGULwIXmw==
X-Received: by 2002:a05:600c:4f93:b0:3b4:c026:85a1 with SMTP id n19-20020a05600c4f9300b003b4c02685a1mr9583025wmq.39.1665737394358;
        Fri, 14 Oct 2022 01:49:54 -0700 (PDT)
Received: from hrutvik.c.googlers.com.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm1547372wmz.34.2022.10.14.01.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:49:54 -0700 (PDT)
From:   Hrutvik Kanabar <hrkanabar@gmail.com>
To:     Hrutvik Kanabar <hrutvik@google.com>
Cc:     Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH RFC 7/7] fs/f2fs: support `DISABLE_FS_CSUM_VERIFICATION` config option
Date:   Fri, 14 Oct 2022 08:48:37 +0000
Message-Id: <20221014084837.1787196-8-hrkanabar@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221014084837.1787196-1-hrkanabar@gmail.com>
References: <20221014084837.1787196-1-hrkanabar@gmail.com>
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

From: Hrutvik Kanabar <hrutvik@google.com>

When `DISABLE_FS_CSUM_VERIFICATION` is enabled, bypass checksum
verification.

Signed-off-by: Hrutvik Kanabar <hrutvik@google.com>
---
 fs/f2fs/checkpoint.c | 3 ++-
 fs/f2fs/compress.c   | 3 ++-
 fs/f2fs/f2fs.h       | 2 ++
 fs/f2fs/inode.c      | 3 +++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 0c82dae082aa..cc5043fbffcb 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -864,7 +864,8 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
 	}
 
 	crc = f2fs_checkpoint_chksum(sbi, *cp_block);
-	if (crc != cur_cp_crc(*cp_block)) {
+	if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
+	    crc != cur_cp_crc(*cp_block)) {
 		f2fs_put_page(*cp_page, 1);
 		f2fs_warn(sbi, "invalid crc value");
 		return -EINVAL;
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d315c2de136f..d0bce92dbf38 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -772,7 +772,8 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 		u32 provided = le32_to_cpu(dic->cbuf->chksum);
 		u32 calculated = f2fs_crc32(sbi, dic->cbuf->cdata, dic->clen);
 
-		if (provided != calculated) {
+		if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
+		    provided != calculated) {
 			if (!is_inode_flag_set(dic->inode, FI_COMPRESS_CORRUPT)) {
 				set_inode_flag(dic->inode, FI_COMPRESS_CORRUPT);
 				printk_ratelimited(
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e6355a5683b7..b27f1ec9b49f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1976,6 +1976,8 @@ static inline u32 f2fs_crc32(struct f2fs_sb_info *sbi, const void *address,
 static inline bool f2fs_crc_valid(struct f2fs_sb_info *sbi, __u32 blk_crc,
 				  void *buf, size_t buf_size)
 {
+	if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION))
+		return true;
 	return f2fs_crc32(sbi, buf, buf_size) == blk_crc;
 }
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 9f0d3864d9f1..239bb08e45b1 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -181,6 +181,9 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page)
 #endif
 		return true;
 
+	if (IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION))
+		return true;
+
 	ri = &F2FS_NODE(page)->i;
 	provided = le32_to_cpu(ri->i_inode_checksum);
 	calculated = f2fs_inode_chksum(sbi, page);
-- 
2.38.0.413.g74048e4d9e-goog

