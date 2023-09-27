Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268047B0050
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjI0Je6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjI0Jes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:34:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C19410E;
        Wed, 27 Sep 2023 02:34:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 095572195A;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMVbv/3EOmX708hzl7JNIFZnWE61SRiFVAY5Go7q+I0=;
        b=QM4vQWmirLd161K0b+7vXe7ixtKxbRZNMNaOPpvPsk3sgM4XQcXAqYsBNHw0kw/bxLU3ZE
        /9NaNKByK2l5IIhpgUxEbztB1V3YQGfEhvJhUPtHb41kaJRGjeuoKgzr5bdlPYYTW1ADsG
        AV80hfCXRVNtzesbFXFdRAEsQPhMKaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMVbv/3EOmX708hzl7JNIFZnWE61SRiFVAY5Go7q+I0=;
        b=rWLKZ4mT6Wn3d40XOL2/0GYtgs3EHGsZVG8EIwqkolaeLsB+BJAWMCQuDDJKJoZdfggl5q
        66j9SRieanv1g3Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAEF21338F;
        Wed, 27 Sep 2023 09:34:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qyFVOTP3E2UNEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0F400A07D4; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/29] rnbd-srv: Convert to use bdev_open_by_path()
Date:   Wed, 27 Sep 2023 11:34:12 +0200
Message-Id: <20230927093442.25915-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5308; i=jack@suse.cz; h=from:subject; bh=VZUYTcEsZUwQH8kJGICsZn+S1pMKE1JNKtZ4wYjpZ8s=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGFKFv4stupnOeiyca9bhD017Uk+vlBN+w7zkuVN26Nd8xROH O8vXdzIaszAwcjDIiimyrI68qH1tnlHX1lANGZhBrEwgUxi4OAVgIptCORgalObOd1T6cUghzFFE83 fjU52ua/zaullJG9hXVXgtM3PhvZEhr8Rv8OBln2ZUZaG/woXTOQ1MNQ7nlk2TTWN4anB2UqRL/iln FuedWy5cLV7awn+WweLey8X839yknUvdA47t7zF+sjxtUuyU3Pd7FyXmHFy6XcKi8GvbytaF99kNWt oYjZ9depNv5CTl+CZE7vBNHp6pmfO+Jla+zXE78sxP8pyRlnCFi6t220+GXx/PxrzJ0mjdr+uU+Ir7 ooKKzCal1Fvx80P/RE/tEQ9Iq3Ty+Hflck1j1J3cTU0/jqYpZO/n9nRVKv1hfJ2/bs3zo6J5bS171T kk90ouKJ0es/FXQU6jbIyxzHM5AA==
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

Convert rnbd-srv to use bdev_open_by_path() and pass the handle
around.

CC: Jack Wang <jinpu.wang@ionos.com>
CC: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Acked-by: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christian Brauner <brauner@kernel.org>
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

