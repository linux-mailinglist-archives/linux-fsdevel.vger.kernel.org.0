Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E9A24CF9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgHUHkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgHUHkV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AC0C061344
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u20so680065pfn.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WxMUvNLFoM8CqgnAU/FexkWAf/EILGzRJKuKOkapjZs=;
        b=fQi6hg2lyIXY/tp2l5XOHtW4GiLOPYUvJ9Jr6FnWnG3kPcU99T8Gtfvit2LRq0kXAc
         zvaztwb5qb3/YiI5V17A91xL06hsJQj6je+Avg/r4+jVP7DjEMq0U7XwbGSEICgTwRjI
         BYzTB3Kv9npv0UhNa0l+VtyleNqkc9XT0x6Gv2mnTeG4TkOFpZvl+VEfzZuTxb6os814
         UbTcE9PUWSlIhy59UIeNTzn2kLwQWeIYDmUptVjRclK5l51jXYp2U786nFY2cLU0fG7I
         QspN9ijLN3riItYOBzLi2XV/YXDkpW0xpQI4E0PIKvuffJWFrgCgPmcZRaCN0JTxNBR2
         Yj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WxMUvNLFoM8CqgnAU/FexkWAf/EILGzRJKuKOkapjZs=;
        b=LfUTAmeF1/ZCE3jD5kmsAVDvjvkVjxKgYx00D9nb+q3mUYNGnmEFOxFoGaytnTZ0op
         QpQWrY5uz/zMJr2hUnODJvbP8HOsr4UosPC6cllJaebkJ1+jnBMo+jYCyGDbBMyLk9kZ
         2lO/NRQOgKria5yiGG3TIcOOcTWuqZiHdiZrGBZfFGL7Np+Uq4pFFV4yUR9pH04IHZe3
         FcwDvIr4oh19lRsuZfJM2lWcbEFIOgFqagxrN1PgS6kgb4HR6c9gHUBZFA+mH7mjXxE6
         OVXUeJKSPHSILMDS6kMAVyU5TIxDlBCEZNVHWNNrJw9/+KdJvYqUBcVV+IsG+940v4yb
         p/VA==
X-Gm-Message-State: AOAM532niCNeNhyKVOHnvkSAzUlAUMpYQeoFi4LwtRrEjcs6GIYZ3uc/
        X3uOEJgenFCDVdreoKn/3UnCBQ==
X-Google-Smtp-Source: ABdhPJzKGa7BAFakQj/fH6OwBwbA7yTK86To7UfDRqnod0zu9Ve1yVQN5nfGzPIxB8zbNFFaAKmJIw==
X-Received: by 2002:a05:6a00:15d0:: with SMTP id o16mr1486151pfu.230.1597995620998;
        Fri, 21 Aug 2020 00:40:20 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:19 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/9] btrfs: send: use btrfs_file_extent_end() in send_write_or_clone()
Date:   Fri, 21 Aug 2020 00:39:53 -0700
Message-Id: <af4ae9204aa3d36a2703dc1aaeb365b7340ed238.1597994106.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

send_write_or_clone() basically has an open-coded copy of
btrfs_file_extent_end() except that it (incorrectly) aligns to PAGE_SIZE
instead of sectorsize. Fix and simplify the code by using
btrfs_file_extent_end().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 44 +++++++++++---------------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e70f5ceb3261..37ce21361782 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5400,51 +5400,29 @@ static int send_write_or_clone(struct send_ctx *sctx,
 			       struct clone_root *clone_root)
 {
 	int ret = 0;
-	struct btrfs_file_extent_item *ei;
 	u64 offset = key->offset;
-	u64 len;
-	u8 type;
+	u64 end;
 	u64 bs = sctx->send_root->fs_info->sb->s_blocksize;
 
-	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
-			struct btrfs_file_extent_item);
-	type = btrfs_file_extent_type(path->nodes[0], ei);
-	if (type == BTRFS_FILE_EXTENT_INLINE) {
-		len = btrfs_file_extent_ram_bytes(path->nodes[0], ei);
-		/*
-		 * it is possible the inline item won't cover the whole page,
-		 * but there may be items after this page.  Make
-		 * sure to send the whole thing
-		 */
-		len = PAGE_ALIGN(len);
-	} else {
-		len = btrfs_file_extent_num_bytes(path->nodes[0], ei);
-	}
-
-	if (offset >= sctx->cur_inode_size) {
-		ret = 0;
-		goto out;
-	}
-	if (offset + len > sctx->cur_inode_size)
-		len = sctx->cur_inode_size - offset;
-	if (len == 0) {
-		ret = 0;
-		goto out;
-	}
+	end = min(btrfs_file_extent_end(path), sctx->cur_inode_size);
+	if (offset >= end)
+		return 0;
 
-	if (clone_root && IS_ALIGNED(offset + len, bs)) {
+	if (clone_root && IS_ALIGNED(end, bs)) {
+		struct btrfs_file_extent_item *ei;
 		u64 disk_byte;
 		u64 data_offset;
 
+		ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
+				    struct btrfs_file_extent_item);
 		disk_byte = btrfs_file_extent_disk_bytenr(path->nodes[0], ei);
 		data_offset = btrfs_file_extent_offset(path->nodes[0], ei);
 		ret = clone_range(sctx, clone_root, disk_byte, data_offset,
-				  offset, len);
+				  offset, end - offset);
 	} else {
-		ret = send_extent_data(sctx, offset, len);
+		ret = send_extent_data(sctx, offset, end - offset);
 	}
-	sctx->cur_inode_next_write_offset = offset + len;
-out:
+	sctx->cur_inode_next_write_offset = end;
 	return ret;
 }
 
-- 
2.28.0

