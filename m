Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CAC747124
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjGDMYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjGDMXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:23:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D196410E6;
        Tue,  4 Jul 2023 05:22:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6C71B22874;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7i8k/5CibSjZ95U3jjtcJsDG4sP3stLS7hsXkBeDpTs=;
        b=LcIkvCW/U1My5T0vHR8bW5cU/Ne0CsdqMTg8sRu+qy9YQLDzZV/jDsEk57bU7gl+5twFX7
        nuvll5EDauOPCYKDe8GwnU3bJ3fOVByjkVmnVKcnJEzMDK0cjoi7STdwQLFqH0WydgW1Gj
        YoXGFDZGpwomW4bW1M3YX6l6SyutujM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7i8k/5CibSjZ95U3jjtcJsDG4sP3stLS7hsXkBeDpTs=;
        b=HPXHG/JNsoM0EL1ZTFI9BgL6HEOgBYDRTuikCzdUBVSQNxLkgBQa/sBvrsQwbTUnvOlokB
        nqyr4JcPLiSVi6Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EDE11346D;
        Tue,  4 Jul 2023 12:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0/clFwIPpGRKMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1F560A0780; Tue,  4 Jul 2023 14:22:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org
Subject: [PATCH 22/32] erofs: Convert to use blkdev_get_handle_by_path()
Date:   Tue,  4 Jul 2023 14:21:49 +0200
Message-Id: <20230704122224.16257-22-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3316; i=jack@suse.cz; h=from:subject; bh=L3+APebG1bJulJB7poCZtzBNMfx805/C7kKAmw0mQSI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7damkIliALyswruev6W+uzuF/QlirIJYUNZux0 SqpwCbaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO3QAKCRCcnaoHP2RA2UOQCA DKcpVYIHX0lIXLo8fkBfJcHyEpkMxTvhw4ENyR9TF4Eno16UzDwEzk1GjAGH2UPGSb+gqvnWThV5Ur 1J/6MLYlKWlpHsd1FYXTI6Lzog/A3GSE+nxuNQiEz8dIYaZJDIzYRIYx7KjNdEoZK9nc2iZJUTvePL 7Jb2Ekr+3ey8J8YOY/dvjq6sZ3rG93Fo7a+jGzuWE55Obm3KPN3uEWm0Awc6Ghg7+m647BeXvjoPqx MB9BLQF6vwIO4qNh8BOrtmdI8j4P/UkoRFs8NmK0d3iDx/TE5P5LvGkX4NocPUkEkjwAG2iQlPiilt AgFWxUgonHGpeHgnNpaCMkXjKal8KK
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert erofs to use blkdev_get_handle_by_path() and pass the handle
around.

CC: Gao Xiang <xiang@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: linux-erofs@lists.ozlabs.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/erofs/data.c     |  4 ++--
 fs/erofs/internal.h |  2 +-
 fs/erofs/super.c    | 20 ++++++++++----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index db5e4b7636ec..1fa60cfff267 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -222,7 +222,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return 0;
 		}
-		map->m_bdev = dif->bdev;
+		map->m_bdev = dif->bdev_handle->bdev;
 		map->m_daxdev = dif->dax_dev;
 		map->m_dax_part_off = dif->dax_part_off;
 		map->m_fscache = dif->fscache;
@@ -240,7 +240,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
 				map->m_pa -= startoff;
-				map->m_bdev = dif->bdev;
+				map->m_bdev = dif->bdev_handle->bdev;
 				map->m_daxdev = dif->dax_dev;
 				map->m_dax_part_off = dif->dax_part_off;
 				map->m_fscache = dif->fscache;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 36e32fa542f0..fabd3bb0c194 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -47,7 +47,7 @@ typedef u32 erofs_blk_t;
 struct erofs_device_info {
 	char *path;
 	struct erofs_fscache *fscache;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9d6a3c6158bd..a4742cc05f95 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -230,7 +230,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	void *ptr;
 
 	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *pos), EROFS_KMAP);
@@ -254,13 +254,13 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 			return PTR_ERR(fscache);
 		dif->fscache = fscache;
 	} else if (!sbi->devs->flatdev) {
-		bdev = blkdev_get_by_path(dif->path, BLK_OPEN_READ, sb->s_type,
-					  NULL);
-		if (IS_ERR(bdev))
-			return PTR_ERR(bdev);
-		dif->bdev = bdev;
-		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off,
-						  NULL, NULL);
+		bdev_handle = blkdev_get_handle_by_path(dif->path,
+				BLK_OPEN_READ, sb->s_type, NULL);
+		if (IS_ERR(bdev_handle))
+			return PTR_ERR(bdev_handle);
+		dif->bdev_handle = bdev_handle;
+		dif->dax_dev = fs_dax_get_by_bdev(bdev_handle->bdev,
+				&dif->dax_part_off, NULL, NULL);
 	}
 
 	dif->blocks = le32_to_cpu(dis->blocks);
@@ -815,8 +815,8 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 	struct erofs_device_info *dif = ptr;
 
 	fs_put_dax(dif->dax_dev, NULL);
-	if (dif->bdev)
-		blkdev_put(dif->bdev, &erofs_fs_type);
+	if (dif->bdev_handle)
+		blkdev_handle_put(dif->bdev_handle);
 	erofs_fscache_unregister_cookie(dif->fscache);
 	dif->fscache = NULL;
 	kfree(dif->path);
-- 
2.35.3

