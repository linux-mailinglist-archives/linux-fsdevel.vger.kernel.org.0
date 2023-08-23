Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54710785620
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjHWKud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjHWKuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:50:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E01E62;
        Wed, 23 Aug 2023 03:49:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 10AA520752;
        Wed, 23 Aug 2023 10:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgUNyIPDqYp3LYCC5+mNZ2FCjGJLNbuM1N9RZ9x6eOg=;
        b=21w4FoOZ5IPLezdWegn4c6m1GrnbMjdEorE6NFhPjJUZbzf3CJ461210BnmamikSsMpra+
        N05DswsBPtMl5UWhneuiGT/Y9s2O3t41RjWHHxVjynC7VrbEtaRrf6ZnnnPJfiaQkW8vFn
        tmN7GQHcORTHyr2ZqiRPsILazMvp+wI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787739;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgUNyIPDqYp3LYCC5+mNZ2FCjGJLNbuM1N9RZ9x6eOg=;
        b=uzg4W9UM/y0bf6h8Y1AW3k7w9hX1RmXcIZmZmHeS+b+GYiX42KhRKYG3axZyfNng6Z8cRl
        WYJMWo8OLyySntBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F371413592;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZaFyOxrk5WRpIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 820E5A0797; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 21/29] erofs: Convert to use bdev_open_by_path()
Date:   Wed, 23 Aug 2023 12:48:32 +0200
Message-Id: <20230823104857.11437-21-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3389; i=jack@suse.cz; h=from:subject; bh=4IVdwN+Q5zXieS6CXQNwhh7/CLqTEj/id+l4gyBHh4Y=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5eQALuGGKaLBFGTZ6muYDbIFD8tkFlOWm8ShbuQz c+NJZHqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXkAAAKCRCcnaoHP2RA2eR9B/ 9C5ILJpLtXoW/fhxe/C4WFplhU60G60DIc6BjWz3oiSflcIHd2p8+9oS0CEiN+sSCh/CxXcjajnjki TZw6FGnVl8nvwEx4/cKEzsUOtf7IbZAxZLCsitjMMY7v4mf0y4KdEPQVlRdHvWMuvNC+5ERkUB1gIG s+EK2kjmsGYhWW85cYf7LGYbuC8xs+tmb5mxALbZhBxhEuGx2anc/3/1aDjMHBvOnJCIk8NAPUOg1g 0BEun/ehoc5La/eqVt0C2X88wFH1kQVJSvlygKkbpGtldoKZ0yZ+99ImqV/o2VblHcfhAJcjs9K3o8 J0bVRZUb/zFNsG+qH3L3rH2wkjY2Jx
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

Convert erofs to use bdev_open_by_path() and pass the handle around.

CC: Gao Xiang <xiang@kernel.org>
CC: Chao Yu <chao@kernel.org>
CC: linux-erofs@lists.ozlabs.org
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>
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
index 566f68ddfa36..366a46fe7fdc 100644
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
+		bdev_handle = bdev_open_by_path(dif->path, BLK_OPEN_READ,
+						sb->s_type, NULL);
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
+		bdev_release(dif->bdev_handle);
 	erofs_fscache_unregister_cookie(dif->fscache);
 	dif->fscache = NULL;
 	kfree(dif->path);
-- 
2.35.3

