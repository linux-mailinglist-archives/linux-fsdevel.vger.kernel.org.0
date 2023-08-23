Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2CB7855DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjHWKt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjHWKtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:49:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DD8E6C;
        Wed, 23 Aug 2023 03:49:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 825602074B;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDa8QKvYnmJDoZHbxWzm6xqgd2SW7/I8wTnEiUzz4E4=;
        b=l4xBShbNhXIN1lGgpuzQ/b8TMa+XUzGYGFtX0hufPhcoVG2YG5zVYdnzLv6PB4NWQ9+c3b
        sbkckQDrmwMTvgtQnXKx7PjpduVamTDlIininWA2Ouyw6O1oKuL1XqD+nEUplwj5/mDkwI
        WU//VRrmcD5xTGSJ0xZ15bDazyWROQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDa8QKvYnmJDoZHbxWzm6xqgd2SW7/I8wTnEiUzz4E4=;
        b=uClKkuyGX10Jq252OfAREN478bgImlwZufg7WKf/9aeLBLD1mBaU1drY07nhS7PgngolBf
        GFjmgzXqr9/M0cBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7259413592;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8njmGxrk5WREIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4590EA0789; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/29] dm: Convert to bdev_open_by_dev()
Date:   Wed, 23 Aug 2023 12:48:21 +0200
Message-Id: <20230823104857.11437-10-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2823; i=jack@suse.cz; h=from:subject; bh=CcBp9Qjeng+kTFK7/zJefsP3/sKhUy44g8Xq6Pwp0tk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5eP2GfLWJQaaX0VPJYJEnTOKYZfyWfdvNXzelc8b /eM9qUmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj9gAKCRCcnaoHP2RA2Z1WB/ 4jeNPEE6nNXQyjpCYwz2RlnrqWlTZQ/Wa65VjOkPf9BzdowIrqG9yRt6dHmdDu8AHaFOA4pmJNuIJM c8tGrHdXRGHEEWoXm0KSkNgpTxJA/Csc3oshv8TiVorCaDBYoyVyCgEYJnGvbo7X/HzW3WgbR+XE2T Q8Ydsou0re0jCCAMTTNO0eIO9Yyb+/PYCOY5m0HHJsnM6ocEAFlgGFYROMkxhfCHVDCN0b7h90aPKj ctr12iQCXwzHMziuRlXY2sW8KuPQz98Zgwk/OOweuSaHfXjtGtA8PS+Ehg/31zlUc5cJF9oPkRAv/N 7xca2/TAyOAYpG2FhL8XdZgQDugrkv
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert device mapper to use bdev_open_by_dev() and pass the handle
around.

CC: Alasdair Kergon <agk@redhat.com>
CC: Mike Snitzer <snitzer@kernel.org>
CC: dm-devel@redhat.com
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/md/dm.c               | 20 +++++++++++---------
 include/linux/device-mapper.h |  1 +
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index f0f118ab20fa..efde77d34f15 100644
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
+	bdev_handle = bdev_open_by_dev(dev, mode, _dm_claim_ptr, NULL);
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
+	bdev_release(bdev_handle);
 out_free_td:
 	kfree(td);
 	return ERR_PTR(r);
@@ -789,7 +791,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
 {
 	if (md->disk->slave_dir)
 		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
-	blkdev_put(td->dm_dev.bdev, _dm_claim_ptr);
+	bdev_release(td->dm_dev.bdev_handle);
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

