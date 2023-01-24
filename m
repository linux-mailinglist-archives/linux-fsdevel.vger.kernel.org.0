Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0069F679798
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjAXMSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjAXMSZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D1744BD6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9CC6C1FE50;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nckLWcQzsYvX8kXlysykKtgVwsDmxdKUhzMbUlGajww=;
        b=h1PamkActe46zxM/o0FOQoUhAUmlZkcOJt2Fg2n89OxIByPYsqEoYGQ40ug0FuI7/yePAe
        PoXafF2l8uAi20SaXYHH5BowhGMQV0sGk0Ls4JrsaTjA81RiumP6wnMDEgZC7TYE0qT4vg
        BCCwH9PIpG2+MMaZa5lOuJuiFWl3M38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nckLWcQzsYvX8kXlysykKtgVwsDmxdKUhzMbUlGajww=;
        b=WMMLL9Ip62Ogmr1jINivRVV0XmGa+2BIwSKhqnzGbxf8Q2Blh29usBN1SVQIXlxCv9CRvf
        HU6GVlRCjR+3+dAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BF8E139FF;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R0EoIofMz2MCOAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7709AA06B6; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 20/22] udf: Do not allocate blocks on page writeback
Date:   Tue, 24 Jan 2023 13:18:06 +0100
Message-Id: <20230124121814.25951-20-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3801; i=jack@suse.cz; h=from:subject; bh=UDPzjm9gM+wpwcTYtHdj1kWWmX468c2GslrFahsGWUA=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJLPn6nzd8x+7ejftTjMNHkKf4XZXAExJYezfAmW1gea90jk OTt1MhqzMDByMMiKKbKsjryofW2eUdfWUA0ZmEGsTCBTGLg4BWAilVXs/93yI/Wd5l13aO98ZXpTZj ZvcNQvm8a0E2+4jrjFMGtnSpl1TtSbqulhN9m/k+3GUvangrdzzsocSbrzaWOxxn1VRRbPqKQdid6/ 9W9Oa+PU6500dWXZlC7nBb/+MH6W4tvn9jWfme+My/sPrDe2K7UInurvqt23t3tKbMDH2J0PpuffNL v8ru0XT17clYi7bk9L4ovcjjmGcvpHRnmvbU482p3g9aO2ZGfzVfVftgpWH793bHoh8H/NqbXv1ZMc +n9IxPVyHp33bP7eM4l8mT8XLxXpWHwkUC1WY+8V62kcWm0FG4T65HJCfB+mnU55tnj3YrWio/bC75 tvn3QoZYypifoirTDzv9nqpXyuAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now when we allocate blocks on write page fault there should be no block
allocation happening on page writeback. So just ignore the 'create' flag
passed to udf_get_block(). Note that we can spot dirty buffers without
underlying blocks allocated in writeback when we race with expanding
truncate. However in that case these buffers do not contain valid data
so we can safely ignore them and we would just create ourselves problem
when to trim the tail extent.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 7fd0aa2439e9..8f55b37ddcad 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -68,6 +68,8 @@ static void udf_prealloc_extents(struct inode *, int, int,
 static void udf_merge_extents(struct inode *, struct kernel_long_ad *, int *);
 static int udf_update_extents(struct inode *, struct kernel_long_ad *, int,
 			      int, struct extent_position *);
+static int udf_get_block_wb(struct inode *inode, sector_t block,
+			    struct buffer_head *bh_result, int create);
 
 static void __udf_clear_extent_cache(struct inode *inode)
 {
@@ -186,7 +188,7 @@ static void udf_write_failed(struct address_space *mapping, loff_t to)
 static int udf_writepages(struct address_space *mapping,
 			struct writeback_control *wbc)
 {
-	return mpage_writepages(mapping, wbc, udf_get_block);
+	return mpage_writepages(mapping, wbc, udf_get_block_wb);
 }
 
 static int udf_read_folio(struct file *file, struct folio *folio)
@@ -367,23 +369,15 @@ static int udf_map_block(struct inode *inode, struct udf_map_rq *map)
 	return err;
 }
 
-static int udf_get_block(struct inode *inode, sector_t block,
-			 struct buffer_head *bh_result, int create)
+static int __udf_get_block(struct inode *inode, sector_t block,
+			   struct buffer_head *bh_result, int flags)
 {
 	int err;
 	struct udf_map_rq map = {
 		.lblk = block,
-		.iflags = create ? UDF_MAP_CREATE : 0,
+		.iflags = flags,
 	};
 
-	/*
-	 * We preallocate blocks only for regular files. It also makes sense
-	 * for directories but there's a problem when to drop the
-	 * preallocation. We might use some delayed work for that but I feel
-	 * it's overengineering for a filesystem like UDF.
-	 */
-	if (!S_ISREG(inode->i_mode))
-		map.iflags |= UDF_MAP_NOPREALLOC;
 	err = udf_map_block(inode, &map);
 	if (err < 0)
 		return err;
@@ -395,6 +389,34 @@ static int udf_get_block(struct inode *inode, sector_t block,
 	return 0;
 }
 
+int udf_get_block(struct inode *inode, sector_t block,
+		  struct buffer_head *bh_result, int create)
+{
+	int flags = create ? UDF_MAP_CREATE : 0;
+
+	/*
+	 * We preallocate blocks only for regular files. It also makes sense
+	 * for directories but there's a problem when to drop the
+	 * preallocation. We might use some delayed work for that but I feel
+	 * it's overengineering for a filesystem like UDF.
+	 */
+	if (!S_ISREG(inode->i_mode))
+		flags |= UDF_MAP_NOPREALLOC;
+	return __udf_get_block(inode, block, bh_result, flags);
+}
+
+/*
+ * We shouldn't be allocating blocks on page writeback since we allocate them
+ * on page fault. We can spot dirty buffers without allocated blocks though
+ * when truncate expands file. These however don't have valid data so we can
+ * safely ignore them. So never allocate blocks from page writeback.
+ */
+static int udf_get_block_wb(struct inode *inode, sector_t block,
+			    struct buffer_head *bh_result, int create)
+{
+	return __udf_get_block(inode, block, bh_result, 0);
+}
+
 /* Extend the file with new blocks totaling 'new_block_bytes',
  * return the number of extents added
  */
-- 
2.35.3

