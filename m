Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59526778D00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbjHKLGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbjHKLF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:05:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF41010DE;
        Fri, 11 Aug 2023 04:05:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 56FCE1F8A4;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691751906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxloC2aNuNh+I9TyXlePCyzE1Yd0mrW064xgIfzrgPI=;
        b=mgBexqvGGXhYIvZpDO+h+RSeZSZvRuVoGRabY6qrZ6lr2J7kjuGoOz5DaNZCJe2x+bx23N
        XaNUwsPwYKOgal3UBswPCjqMGeMtig+6rkum6BjLhOLJZPrqrIH4Lt3viQPKcJszRC1+2v
        nyioYgZKrgfFqOvPZCVzDBUJMk23c3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691751906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxloC2aNuNh+I9TyXlePCyzE1Yd0mrW064xgIfzrgPI=;
        b=V6OZVccO//IOpDNky8QrXYh0AlQjJpKzEkXYApB+dxTKiS56VtzWQPraD16FLOySq0XjGn
        yxQdXMma1ewxBjBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 462AB13A95;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XrTPEOIV1mRqRQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4581EA0797; Fri, 11 Aug 2023 13:05:05 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 23/29] f2fs: Convert to bdev_open_by_dev/path()
Date:   Fri, 11 Aug 2023 13:04:54 +0200
Message-Id: <20230811110504.27514-23-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2242; i=jack@suse.cz; h=from:subject; bh=gXhkH4DHBaWcCLU4mZG3eLeDQyPPEcfvTwTt9MBb0vI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXWp7/Zc8HF73Mv8jDbfnCCGN8lBP9y2bBtqjCQ 9sC1F2aJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYV1gAKCRCcnaoHP2RA2a5eB/ wLf6nAu6TkEA4dk2EF3PqULDVlx3dhwNNIGvkWpa4/5lc5sbGHtZ0v0K7vK555uacVX16s9jiozhLP AEh3nIDG59WvvqOzW3dLBugQfYzFx3Q5gNDXFJSdbkOMoOOt14FtmCTikuXEVJJ9/GbQ9yjprSLke0 pFyuPIZ3fEh0drhWARB3grIQp1pbZDiiJ3p18dh3Hm9CUoFdF3eN/LDfmLTnjcX5yJyDn6Ze2bYgJe xiQwowJYj9kUVNj8RbwxFsVhjBok/9VfYwiShXCRZSmHXUzLbk0mGbSaNv+mJg1wDwf4IgRW9XtXV6 8tlezwXcFPoSOOQIle3foL2UytnRD6
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert f2fs to use bdev_open_by_dev/path() and pass the handle around.

CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 17 +++++++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e18272ae3119..2ec6c10df636 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1234,6 +1234,7 @@ struct f2fs_bio_info {
 #define FDEV(i)				(sbi->devs[i])
 #define RDEV(i)				(raw_super->devs[i])
 struct f2fs_dev_info {
+	struct bdev_handle *bdev_handle;
 	struct block_device *bdev;
 	char path[MAX_PATH_LEN];
 	unsigned int total_segments;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index aa1f9a3a8037..885dcbd81859 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1561,7 +1561,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 	int i;
 
 	for (i = 0; i < sbi->s_ndevs; i++) {
-		blkdev_put(FDEV(i).bdev, sbi->sb);
+		bdev_release(FDEV(i).bdev_handle);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
 #endif
@@ -4196,9 +4196,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 		if (max_devices == 1) {
 			/* Single zoned block device mount */
-			FDEV(0).bdev =
-				blkdev_get_by_dev(sbi->sb->s_bdev->bd_dev, mode,
-						  sbi->sb, NULL);
+			FDEV(0).bdev_handle = bdev_open_by_dev(
+					sbi->sb->s_bdev->bd_dev, mode, sbi->sb,
+					NULL);
 		} else {
 			/* Multi-device mount */
 			memcpy(FDEV(i).path, RDEV(i).path, MAX_PATH_LEN);
@@ -4216,12 +4216,13 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 					(FDEV(i).total_segments <<
 					sbi->log_blocks_per_seg) - 1;
 			}
-			FDEV(i).bdev = blkdev_get_by_path(FDEV(i).path, mode,
-							  sbi->sb, NULL);
+			FDEV(i).bdev_handle = bdev_open_by_path(FDEV(i).path,
+					mode, sbi->sb, NULL);
 		}
-		if (IS_ERR(FDEV(i).bdev))
-			return PTR_ERR(FDEV(i).bdev);
+		if (IS_ERR(FDEV(i).bdev_handle))
+			return PTR_ERR(FDEV(i).bdev_handle);
 
+		FDEV(i).bdev = FDEV(i).bdev_handle->bdev;
 		/* to release errored devices */
 		sbi->s_ndevs = i + 1;
 
-- 
2.35.3

