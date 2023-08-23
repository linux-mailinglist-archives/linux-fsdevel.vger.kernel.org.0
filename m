Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3593785631
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjHWKur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjHWKuG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:50:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50642E5D;
        Wed, 23 Aug 2023 03:49:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A27542074F;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MBsPveD1xI53cn0DT68/0aGElxKX0zddJPsr7N619Ak=;
        b=CDGV6etjiImeGEUO+0BUVbX7RrWvHoApelFxQwE+MvKkuapFoSM3992rna3Bq9ee4PSIw6
        +LXG9cXNVM1eYwTwr/bQdOFAS6mHFaO1dN/yAeP3C+dn99TY4Go53DK6Qw+n5oqjlDEuxc
        PqGpPheiFx2BLmX9XP87j/wbjP/DRao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MBsPveD1xI53cn0DT68/0aGElxKX0zddJPsr7N619Ak=;
        b=N6z3QTU6ieH93k9KF4kE1tM6zgWhTjKW3zovp7A1dMknTyjGy4QJojKcRNyAdb0/bhpQHV
        8PGnGalNM2lFCrBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9240E13592;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kmaxIxrk5WRMIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5625FA078D; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/29] nvmet: Convert to bdev_open_by_path()
Date:   Wed, 23 Aug 2023 12:48:24 +0200
Message-Id: <20230823104857.11437-13-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2146; i=jack@suse.cz; h=from:subject; bh=P3kIXEticntI8ldLR8W/RXMKkQjvvAD6UtqoFr/c9Kw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5eP5SvEBatGZsIjgJiA6c5YnzkSHf0MP6rkeUG43 o8ebsHqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj+QAKCRCcnaoHP2RA2TUwB/ 4wcLZc14Yrt0gDhGdTJgkH8N4G8qwWxdOI88u2Lhfw2i3xYxHB4dmlkDvPGtGjq3hru2kNmml/zFpD aPXPQZSkA2xl0l5ycYbfKZ2qzVnS9dHCTaAh9XilOwY2ZOE+nPcazmIxaALS0e5vH27HAdIdVGXgfX +Ub5T4XFFXhhZeUarI3y6eUEhQwi4B9QxU0SV7K79+qmqy7HICDwIK8sJkE6uYE9ESXiqe/GE4GYFw 9G11zl4Aiw6O8tf+86EMdVp4YqdlAvfOVfDX7gDHNIAa4FpwiNqdy3Iy2XrbiBysP54gJ0Id1iFCh3 6kIb4sVIV1B9A4YMizL+G7Z/Y87xCZ
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

Convert nvmet to use bdev_open_by_path() and pass the handle around.

CC: linux-nvme@lists.infradead.org
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/nvme/target/io-cmd-bdev.c | 20 +++++++++++---------
 drivers/nvme/target/nvmet.h       |  1 +
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 2733e0158585..0bf05c19d8b5 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -50,9 +50,10 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 {
-	if (ns->bdev) {
-		blkdev_put(ns->bdev, NULL);
+	if (ns->bdev_handle) {
+		bdev_release(ns->bdev_handle);
 		ns->bdev = NULL;
+		ns->bdev_handle = NULL;
 	}
 }
 
@@ -84,17 +85,18 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	if (ns->buffered_io)
 		return -ENOTBLK;
 
-	ns->bdev = blkdev_get_by_path(ns->device_path,
-			BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
-	if (IS_ERR(ns->bdev)) {
-		ret = PTR_ERR(ns->bdev);
+	ns->bdev_handle = bdev_open_by_path(ns->device_path,
+				BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
+	if (IS_ERR(ns->bdev_handle)) {
+		ret = PTR_ERR(ns->bdev_handle);
 		if (ret != -ENOTBLK) {
-			pr_err("failed to open block device %s: (%ld)\n",
-					ns->device_path, PTR_ERR(ns->bdev));
+			pr_err("failed to open block device %s: (%d)\n",
+					ns->device_path, ret);
 		}
-		ns->bdev = NULL;
+		ns->bdev_handle = NULL;
 		return ret;
 	}
+	ns->bdev = ns->bdev_handle->bdev;
 	ns->size = bdev_nr_bytes(ns->bdev);
 	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8cfd60f3b564..360e385be33b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -58,6 +58,7 @@
 
 struct nvmet_ns {
 	struct percpu_ref	ref;
+	struct bdev_handle	*bdev_handle;
 	struct block_device	*bdev;
 	struct file		*file;
 	bool			readonly;
-- 
2.35.3

