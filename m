Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E217855F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjHWKtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjHWKt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:49:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51D4170D;
        Wed, 23 Aug 2023 03:49:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4B5DF21EE8;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3B6UgT9e7WKZ37HAk6nN2zOCpV17ZlB8IFJRAHx8NXM=;
        b=Y9P3yIwFVU8uJFYeA/Sr/kQJAiEfdv2Tzx5tFN9eIi8cB3PHr+7CA6Nzl4FHjN8AkG2OFq
        5rHRfx5vEpASvOIdOzJEk6ShJ0ww/rs27Kq5i8Y2Tj3SvBc76cBFfUsZfsiPV8mb2LikxO
        BdPti3RrEbMQbLdRL7xCf8ME3UiD6G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3B6UgT9e7WKZ37HAk6nN2zOCpV17ZlB8IFJRAHx8NXM=;
        b=BDS64H785FsCIhPMUVVqXiF2AWAVjUcwlnl9WZ7LosB5Cu1F3QqE2NU01xYFV7aU6gv1YG
        DlKTpWmWvzlWg4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C47B13458;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hNDCDhrk5WQ3IAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2E6ADA077F; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/29] rnbd-srv: Convert to use bdev_open_by_path()
Date:   Wed, 23 Aug 2023 12:48:17 +0200
Message-Id: <20230823104857.11437-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5258; i=jack@suse.cz; h=from:subject; bh=L68h0rktksNTIyOKoltNtkT4sxTVsTqvIKO35TqqZOg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5ePzX6hs38iQkAhCZYkYBKSCs2iGdpQWjSOtEMUv W94Q1HeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj8wAKCRCcnaoHP2RA2TvfCA DM9z3Vmi6OjqZU7ghu5q6r1OKhuXoEBG0R4YaFNVI7EKKH/wbM+D7xH5ZKvuPpo7ZGs8nHpHAXFuSV D64rshtvIzGLFlY4lMPE8VUl4mg9a4bjHDxQm2ImoTcRhmtwSLCQhWm9bGr8TtGqexOqeJCh/RMTMy APXd4iQCx7GYg/XZwUPxTmN3D0tA5T75G7ueSiL3qWgdnvFWAc2kfZXdBc6jC+6zcM4Mt4UsxpPISw IhVJIONEzHly/QK1qFL0EpK3t9kp3MVPsdapaAfntRIDXDe136GaCd5DlPE+qystmKWNLZPAI4ggKR jp9wgn5qZpYMmcCc5dgbkEWF81+dLp
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

Convert rnbd-srv to use bdev_open_by_path() and pass the handle
around.

CC: Jack Wang <jinpu.wang@ionos.com>
CC: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Acked-by: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/rnbd/rnbd-srv.c | 27 ++++++++++++++-------------
 drivers/block/rnbd/rnbd-srv.h |  2 +-
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index c186df0ec641..65de51f3dfd9 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -145,7 +145,7 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 	priv->sess_dev = sess_dev;
 	priv->id = id;
 
-	bio = bio_alloc(sess_dev->bdev, 1,
+	bio = bio_alloc(sess_dev->bdev_handle->bdev, 1,
 			rnbd_to_bio_flags(le32_to_cpu(msg->rw)), GFP_KERNEL);
 	if (bio_add_page(bio, virt_to_page(data), datalen,
 			offset_in_page(data)) != datalen) {
@@ -219,7 +219,7 @@ void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
 	rnbd_put_sess_dev(sess_dev);
 	wait_for_completion(&dc); /* wait for inflights to drop to zero */
 
-	blkdev_put(sess_dev->bdev, NULL);
+	bdev_release(sess_dev->bdev_handle);
 	mutex_lock(&sess_dev->dev->lock);
 	list_del(&sess_dev->dev_list);
 	if (!sess_dev->readonly)
@@ -534,7 +534,7 @@ rnbd_srv_get_or_create_srv_dev(struct block_device *bdev,
 static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 					struct rnbd_srv_sess_dev *sess_dev)
 {
-	struct block_device *bdev = sess_dev->bdev;
+	struct block_device *bdev = sess_dev->bdev_handle->bdev;
 
 	rsp->hdr.type = cpu_to_le16(RNBD_MSG_OPEN_RSP);
 	rsp->device_id = cpu_to_le32(sess_dev->device_id);
@@ -559,7 +559,7 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 static struct rnbd_srv_sess_dev *
 rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
 			      const struct rnbd_msg_open *open_msg,
-			      struct block_device *bdev, bool readonly,
+			      struct bdev_handle *handle, bool readonly,
 			      struct rnbd_srv_dev *srv_dev)
 {
 	struct rnbd_srv_sess_dev *sdev = rnbd_sess_dev_alloc(srv_sess);
@@ -571,7 +571,7 @@ rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
 
 	strscpy(sdev->pathname, open_msg->dev_name, sizeof(sdev->pathname));
 
-	sdev->bdev		= bdev;
+	sdev->bdev_handle	= handle;
 	sdev->sess		= srv_sess;
 	sdev->dev		= srv_dev;
 	sdev->readonly		= readonly;
@@ -676,7 +676,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	struct rnbd_srv_dev *srv_dev;
 	struct rnbd_srv_sess_dev *srv_sess_dev;
 	const struct rnbd_msg_open *open_msg = msg;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 	blk_mode_t open_flags = BLK_OPEN_READ;
 	char *full_path;
 	struct rnbd_msg_open_rsp *rsp = data;
@@ -714,15 +714,15 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		goto reject;
 	}
 
-	bdev = blkdev_get_by_path(full_path, open_flags, NULL, NULL);
-	if (IS_ERR(bdev)) {
-		ret = PTR_ERR(bdev);
+	bdev_handle = bdev_open_by_path(full_path, open_flags, NULL, NULL);
+	if (IS_ERR(bdev_handle)) {
+		ret = PTR_ERR(bdev_handle);
 		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %d\n",
 		       full_path, srv_sess->sessname, ret);
 		goto free_path;
 	}
 
-	srv_dev = rnbd_srv_get_or_create_srv_dev(bdev, srv_sess,
+	srv_dev = rnbd_srv_get_or_create_srv_dev(bdev_handle->bdev, srv_sess,
 						  open_msg->access_mode);
 	if (IS_ERR(srv_dev)) {
 		pr_err("Opening device '%s' on session %s failed, creating srv_dev failed, err: %ld\n",
@@ -731,7 +731,8 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		goto blkdev_put;
 	}
 
-	srv_sess_dev = rnbd_srv_create_set_sess_dev(srv_sess, open_msg, bdev,
+	srv_sess_dev = rnbd_srv_create_set_sess_dev(srv_sess, open_msg,
+				bdev_handle,
 				open_msg->access_mode == RNBD_ACCESS_RO,
 				srv_dev);
 	if (IS_ERR(srv_sess_dev)) {
@@ -747,7 +748,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	 */
 	mutex_lock(&srv_dev->lock);
 	if (!srv_dev->dev_kobj.state_in_sysfs) {
-		ret = rnbd_srv_create_dev_sysfs(srv_dev, bdev);
+		ret = rnbd_srv_create_dev_sysfs(srv_dev, bdev_handle->bdev);
 		if (ret) {
 			mutex_unlock(&srv_dev->lock);
 			rnbd_srv_err(srv_sess_dev,
@@ -790,7 +791,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	}
 	rnbd_put_srv_dev(srv_dev);
 blkdev_put:
-	blkdev_put(bdev, NULL);
+	bdev_release(bdev_handle);
 free_path:
 	kfree(full_path);
 reject:
diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index 1027656dedb0..343cc682b617 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -46,7 +46,7 @@ struct rnbd_srv_dev {
 struct rnbd_srv_sess_dev {
 	/* Entry inside rnbd_srv_dev struct */
 	struct list_head		dev_list;
-	struct block_device		*bdev;
+	struct bdev_handle		*bdev_handle;
 	struct rnbd_srv_session		*sess;
 	struct rnbd_srv_dev		*dev;
 	struct kobject                  kobj;
-- 
2.35.3

