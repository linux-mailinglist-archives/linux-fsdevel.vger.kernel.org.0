Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E82679788
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjAXMSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjAXMSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9A4442EB
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 93B611FE1D;
        Tue, 24 Jan 2023 12:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V1bsdbxl58ZoO/U0lADB2VOZb2Ox82ek7358rYvVJaw=;
        b=rH4H6A9Mw9+BzCg1exNOmIQcPitTU3KImyHEqTuPeESAyLsJsffP1T7uPO14yUr5/HdEW8
        S7zT8oUn/51V9F1wM5GNXTHohxNOKtvjIitLRtpXMU7yteQLCzvFSnx6ikj1hDDqmgQnal
        Tneipk2+lILoTNJW7DzB33QiYg4G6xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V1bsdbxl58ZoO/U0lADB2VOZb2Ox82ek7358rYvVJaw=;
        b=8kfc6ZxDADpsDjjMjouq3Ue9FIF5Gl0yowotyIutGcvOXtlkDtyNS4zBpSYL3qbN6wZ4Yd
        9Nu9+o1SMdWo/LDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84EA0139FB;
        Tue, 24 Jan 2023 12:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gKZyIIbMz2PRNwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 17BA8A06C6; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 04/22] udf: Factor out block mapping into udf_map_block()
Date:   Tue, 24 Jan 2023 13:17:50 +0100
Message-Id: <20230124121814.25951-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3783; i=jack@suse.cz; h=from:subject; bh=XARw2uPOVJRk2CwMY7RattNwAYAlkAf7Q6VYc3n+OTA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8xw9J8zQPM8PK0LLa2PBcA8p3xRk5IWcmMwt/zs MUcyLhGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/McAAKCRCcnaoHP2RA2YVvCA CdTVfHbGfttD9q5JJIuyoyYVaxkbXclC+oAWQzfWpxAoemZPH6AISUTbzOHx7RIoTi8VL7D0HqDx/8 mdh+214M5W9x6eXjZ4XjQByos1NwoUXOEjCtdUijUxbyCvIMEF4c3b7w+DYUZ5elkLtUU8IGGjvsuG q28Ca1HWx0ODBT7GlJHXlQ8k4n0XWWhvmtda0Uvj2o3u9Xoi3ALQC5xrqNdcwWsWFlSjyMrWpSZNgi SKF08ifj86z9GS5i7V9kpo6WTjdUJ6E3oHCifsun8dHHrNSpTnsAr4Mbpu8c0haQkTwquh3FFX3DSr 16kaKoFQwiY1kiAQm/YEQtnXSvJ66R
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create new block mapping function udf_map_block() that takes new
udf_map_rq structure describing mapping request. We will convert other
places to use this function for block mapping.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c   | 70 +++++++++++++++++++++++++++++++++---------------
 fs/udf/udfdecl.h |  1 +
 2 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index ff414fff354a..53d2d8fef158 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -52,6 +52,8 @@
 #define FE_DELETE_PERMS	(FE_PERM_U_DELETE | FE_PERM_G_DELETE | \
 			 FE_PERM_O_DELETE)
 
+struct udf_map_rq;
+
 static umode_t udf_convert_permissions(struct fileEntry *);
 static int udf_update_inode(struct inode *, int);
 static int udf_sync_inode(struct inode *inode);
@@ -320,43 +322,67 @@ int udf_expand_file_adinicb(struct inode *inode)
 	return err;
 }
 
-static int udf_get_block(struct inode *inode, sector_t block,
-			 struct buffer_head *bh_result, int create)
+#define UDF_MAP_CREATE	0x01	/* Mapping can allocate new blocks */
+
+#define UDF_BLK_MAPPED	0x01	/* Block was successfully mapped */
+#define UDF_BLK_NEW	0x02	/* Block was freshly allocated */
+
+struct udf_map_rq {
+	sector_t lblk;
+	udf_pblk_t pblk;
+	int iflags;		/* UDF_MAP_ flags determining behavior */
+	int oflags;		/* UDF_BLK_ flags reporting results */
+};
+
+static int udf_map_block(struct inode *inode, struct udf_map_rq *map)
 {
 	int err, new;
-	sector_t phys = 0;
-	struct udf_inode_info *iinfo;
+	struct udf_inode_info *iinfo = UDF_I(inode);
 
-	if (!create) {
-		phys = udf_block_map(inode, block);
-		if (phys)
-			map_bh(bh_result, inode->i_sb, phys);
+	map->oflags = 0;
+	if (!(map->iflags & UDF_MAP_CREATE)) {
+		map->pblk = udf_block_map(inode, map->lblk);
+		if (map->pblk != 0)
+			map->oflags |= UDF_BLK_MAPPED;
 		return 0;
 	}
 
-	err = -EIO;
-	new = 0;
-	iinfo = UDF_I(inode);
-
 	down_write(&iinfo->i_data_sem);
 	/*
 	 * Block beyond EOF and prealloc extents? Just discard preallocation
 	 * as it is not useful and complicates things.
 	 */
-	if (((loff_t)block) << inode->i_blkbits > iinfo->i_lenExtents)
+	if (((loff_t)map->lblk) << inode->i_blkbits > iinfo->i_lenExtents)
 		udf_discard_prealloc(inode);
 	udf_clear_extent_cache(inode);
-	phys = inode_getblk(inode, block, &err, &new);
-	if (!phys)
-		goto abort;
-
+	map->pblk = inode_getblk(inode, map->lblk, &err, &new);
+	up_write(&iinfo->i_data_sem);
+	if (err)
+		return err;
+	map->oflags |= UDF_BLK_MAPPED;
 	if (new)
-		set_buffer_new(bh_result);
-	map_bh(bh_result, inode->i_sb, phys);
+		map->oflags |= UDF_BLK_NEW;
+	return 0;
+}
 
-abort:
-	up_write(&iinfo->i_data_sem);
-	return err;
+static int udf_get_block(struct inode *inode, sector_t block,
+			 struct buffer_head *bh_result, int create)
+{
+	int err;
+	struct udf_map_rq map = {
+		.lblk = block,
+		.iflags = create ? UDF_MAP_CREATE : 0,
+	};
+
+	err = udf_map_block(inode, &map);
+	if (err < 0)
+		return err;
+	if (map.oflags & UDF_BLK_MAPPED) {
+		map_bh(bh_result, inode->i_sb, map.pblk);
+		if (map.oflags & UDF_BLK_NEW)
+			set_buffer_new(bh_result);
+	}
+	return 0;
 }
 
 static struct buffer_head *udf_getblk(struct inode *inode, udf_pblk_t block,
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 88667a80795d..d791458fe52a 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -138,6 +138,7 @@ static inline unsigned int udf_dir_entry_len(struct fileIdentDesc *cfi)
 
 /* file.c */
 extern long udf_ioctl(struct file *, unsigned int, unsigned long);
+
 /* inode.c */
 extern struct inode *__udf_iget(struct super_block *, struct kernel_lb_addr *,
 				bool hidden_inode);
-- 
2.35.3

