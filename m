Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADD57470DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjGDMWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjGDMWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:22:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C88610EF;
        Tue,  4 Jul 2023 05:22:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C013D2286B;
        Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wI0O6QZk2rEc1RIce7rD0sI79HF4BrsPfYN+HHvawjI=;
        b=nxZEl7gkLZRB3Qk+C2VRbcNYs01AVzg7kauEjP728K+c9bykDtjHa/gT5OOsq2TCrF2Lsl
        o0Y+Mtqx1DcFU2mZazhtKSFbD4fZwAWUJR12DSxuYHdLhFdIlBa0j2SsZNEI2c7Zwg6Qlw
        fCgO9mD5a/TMNeEvgW5qy4RBBucMIXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wI0O6QZk2rEc1RIce7rD0sI79HF4BrsPfYN+HHvawjI=;
        b=FR/g2qTlYkHOuD7Qh1IugIWDk+pnI/k2xrtFBHq50PgnV7QlsFSrEb4nT7FxJYNupiLyYJ
        VDBPEeq8AWeTBjDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0B5613A26;
        Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aCwhKwEPpGQeMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B86D8A0769; Tue,  4 Jul 2023 14:22:24 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Subject: [PATCH 07/32] rnbd-srv: Convert to use blkdev_get_handle_by_path()
Date:   Tue,  4 Jul 2023 14:21:34 +0200
Message-Id: <20230704122224.16257-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5198; i=jack@suse.cz; h=from:subject; bh=ovedL4qV3aCLNIfPI02uKXPPZO15KCTWgBAk/TANvW8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7QzotsXjQO0iZtZ7tFTnNzjgP/uqq64RSajH/0 +X3VpTmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQO0AAKCRCcnaoHP2RA2X3IB/ 9e55Cekvi+axZ0FMgvvOH1S3KdNqy8YAPTvYycm3zFojHPTXccu0KC8V0BaVM10MNsoFVYzZZOhSGa ItkiAwIPn7J1gmpOvjx/8Iqmq6gSWOwNT6rfCqZ8m3XOilcFHDzBvbEFsACpPH/vp/LOEMqP1lEdOe 7lpY0ZDmefTjQumaMA73CjZnWx+WqCIFJf7Z2Rvl3Sec/ncB+DX95FPM/3ZSdTDRze1v8w0rCX4jEk ktB1jqVWghTgPb+wkcyb4cKXyl5ZGOIgngLqRbPfxSQqzPRnXsw5rFGHkggy/KMTgu7f2Z4f3xvbfi XtT2Y9q0jbUb2mdDVcWdSN6gPZqAI2
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

Convert rnbd-srv to use blkdev_get_handle_by_path() and pass the handle
around.

CC: Jack Wang <jinpu.wang@ionos.com>
CC: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/rnbd/rnbd-srv.c | 28 +++++++++++++++-------------
 drivers/block/rnbd/rnbd-srv.h |  2 +-
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index c186df0ec641..606db77c1238 100644
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
+	blkdev_handle_put(sess_dev->bdev_handle);
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
@@ -714,15 +714,16 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		goto reject;
 	}
 
-	bdev = blkdev_get_by_path(full_path, open_flags, NULL, NULL);
-	if (IS_ERR(bdev)) {
-		ret = PTR_ERR(bdev);
+	bdev_handle = blkdev_get_handle_by_path(full_path, open_flags, NULL,
+						NULL);
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
@@ -731,7 +732,8 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		goto blkdev_put;
 	}
 
-	srv_sess_dev = rnbd_srv_create_set_sess_dev(srv_sess, open_msg, bdev,
+	srv_sess_dev = rnbd_srv_create_set_sess_dev(srv_sess, open_msg,
+				bdev_handle,
 				open_msg->access_mode == RNBD_ACCESS_RO,
 				srv_dev);
 	if (IS_ERR(srv_sess_dev)) {
@@ -747,7 +749,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	 */
 	mutex_lock(&srv_dev->lock);
 	if (!srv_dev->dev_kobj.state_in_sysfs) {
-		ret = rnbd_srv_create_dev_sysfs(srv_dev, bdev);
+		ret = rnbd_srv_create_dev_sysfs(srv_dev, bdev_handle->bdev);
 		if (ret) {
 			mutex_unlock(&srv_dev->lock);
 			rnbd_srv_err(srv_sess_dev,
@@ -790,7 +792,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	}
 	rnbd_put_srv_dev(srv_dev);
 blkdev_put:
-	blkdev_put(bdev, NULL);
+	blkdev_handle_put(bdev_handle);
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

