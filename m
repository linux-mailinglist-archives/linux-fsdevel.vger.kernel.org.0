Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36967470D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjGDMWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjGDMWg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:22:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E6D10EA;
        Tue,  4 Jul 2023 05:22:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E8EBF20564;
        Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oFpQScuO74Wb/MMo5/PwU0VkkU8xfizCNEX+yBiHYxE=;
        b=N5jZEMQU6Pgvz3tRd18Yo1/LxhuHRQKFd0K9mY2q+KSbUQbi9Eg6x0DMw3/OSBLSmWxuZV
        pL1gFQ7rbouWR4ap7tB+Jugsu4tP5YlgaC/WkEboScVZq3SJWgQBZXm5chC4epOO78MO7m
        JLcZYV2WQIzcI61/B7m4wkUcxhxfR+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oFpQScuO74Wb/MMo5/PwU0VkkU8xfizCNEX+yBiHYxE=;
        b=Y2qUNGb3VlUD6Uih7oS1QkkbidyX1uLyJ+Sa2cXUj89bHO4eQv6eZK8n4vd1MkSlr15BsG
        rFqFrHp5jVRO+5DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBB8013A97;
        Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id icy1MQEPpGQnMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D0754A076D; Tue,  4 Jul 2023 14:22:24 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Subject: [PATCH 11/32] dm: Convert to blkdev_get_handle_by_dev()
Date:   Tue,  4 Jul 2023 14:21:38 +0200
Message-Id: <20230704122224.16257-11-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2807; i=jack@suse.cz; h=from:subject; bh=XeDjEIT1p9+MdDtB0DyCNgxyoNTaPF7DUrlNzaXtSIM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7UHFKsSVynaLOp/FheWju2iEmpkghUNeLrh2gQ MFkgdDKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO1AAKCRCcnaoHP2RA2ST4CA C9agmaJLWVzqIJPzboONp8Xr/aw4rXGvMeHGLqgMuoAr3T0E26qyrSfkGrdgPfs2tHAzNJFXHMc/wa XgV1DUzYSYWD/s/n9w2wbRF16GvqWxbvL8PGYce+A1xyK8QbbnhmoREk0dOOZc/Mja+mASR8d/T9L/ d0LtJfeK7tdMWr9fu51au5tj5ie6tS1O8eka/XhXuEpG39sVgP34wd6WSnCLxxfEqiKokKVfFextol YAlMeYvfbTIFsp90fa15NkTR8QJd8gq6IQnbop8RKTL7XkZRsudtLs4b6iPtH4kS4hMqayRl3icuOY cHj1ndGNo2WYi+0RkDM70LbDgZ00/z
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert device mapper to use blkdev_get_handle_by_dev() and pass the
handle around.

CC: Alasdair Kergon <agk@redhat.com>
CC: Mike Snitzer <snitzer@kernel.org>
CC: dm-devel@redhat.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/md/dm.c               | 20 +++++++++++---------
 include/linux/device-mapper.h |  1 +
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index f0f118ab20fa..d73905149bef 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -742,7 +742,7 @@ static struct table_device *open_table_device(struct mapped_device *md,
 		dev_t dev, blk_mode_t mode)
 {
 	struct table_device *td;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	u64 part_off;
 	int r;
 
@@ -751,9 +751,9 @@ static struct table_device *open_table_device(struct mapped_device *md,
 		return ERR_PTR(-ENOMEM);
 	refcount_set(&td->count, 1);
 
-	bdev = blkdev_get_by_dev(dev, mode, _dm_claim_ptr, NULL);
-	if (IS_ERR(bdev)) {
-		r = PTR_ERR(bdev);
+	bdev_handle = blkdev_get_handle_by_dev(dev, mode, _dm_claim_ptr, NULL);
+	if (IS_ERR(bdev_handle)) {
+		r = PTR_ERR(bdev_handle);
 		goto out_free_td;
 	}
 
@@ -763,20 +763,22 @@ static struct table_device *open_table_device(struct mapped_device *md,
 	 * called.
 	 */
 	if (md->disk->slave_dir) {
-		r = bd_link_disk_holder(bdev, md->disk);
+		r = bd_link_disk_holder(bdev_handle->bdev, md->disk);
 		if (r)
 			goto out_blkdev_put;
 	}
 
 	td->dm_dev.mode = mode;
-	td->dm_dev.bdev = bdev;
-	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off, NULL, NULL);
+	td->dm_dev.bdev = bdev_handle->bdev;
+	td->dm_dev.bdev_handle = bdev_handle;
+	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev_handle->bdev, &part_off,
+						NULL, NULL);
 	format_dev_t(td->dm_dev.name, dev);
 	list_add(&td->list, &md->table_devices);
 	return td;
 
 out_blkdev_put:
-	blkdev_put(bdev, _dm_claim_ptr);
+	blkdev_handle_put(bdev_handle);
 out_free_td:
 	kfree(td);
 	return ERR_PTR(r);
@@ -789,7 +791,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
 {
 	if (md->disk->slave_dir)
 		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
-	blkdev_put(td->dm_dev.bdev, _dm_claim_ptr);
+	blkdev_handle_put(td->dm_dev.bdev_handle);
 	put_dax(td->dm_dev.dax_dev);
 	list_del(&td->list);
 	kfree(td);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 69d0435c7ebb..772ab4d74d94 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -165,6 +165,7 @@ void dm_error(const char *message);
 
 struct dm_dev {
 	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	struct dax_device *dax_dev;
 	blk_mode_t mode;
 	char name[16];
-- 
2.35.3

