Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04317B002E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjI0Jer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjI0Jeq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:34:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC969C0;
        Wed, 27 Sep 2023 02:34:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E2311F8BF;
        Wed, 27 Sep 2023 09:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yvuKb46iatxm+O8PdgcZjlt7qiboGT1NiUAmYUfo6D8=;
        b=tJxZXhUZ3Hv7Y4HzH9ypTOKEFVSvxcwyRyFcbq14aMp3pmUvg075RUX2m8NxpBYQZzGFxM
        KKnXhLBgA6M1Vtf/Hkdj+HURoGA9f5+VGAIg+pCLEFxUq4XUGGWU4bXnpn0FerE1Dnskps
        vA+oVlG/AX1cNQlWItcbAvCW3VMTTMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807283;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yvuKb46iatxm+O8PdgcZjlt7qiboGT1NiUAmYUfo6D8=;
        b=GUI+cgC2TVwnhFqev/LVYIFESf/2rZrdeGZST1vr5p6NxYDS/s0osYOZ0JnqUndHanBh/P
        L91wr+EoEbobPcCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E6C11338F;
        Wed, 27 Sep 2023 09:34:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RivqGjP3E2X6EgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DFF95A05BC; Wed, 27 Sep 2023 11:34:42 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/29] block: Provide bdev_open_* functions
Date:   Wed, 27 Sep 2023 11:34:07 +0200
Message-Id: <20230927093442.25915-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4009; i=jack@suse.cz; h=from:subject; bh=ftxebZb0mN+mmlqK0XS39fDig1WohJDebKnx2ATIZ/8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/cRk3fqxwXaJ3HPrCVtpIaBtaqyPMA2OSma/nzF yN4uJeeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3EQAKCRCcnaoHP2RA2WA0B/ 9JZk+NzrYpD98P7nTbzVzNxuoiZ/EQs/5XFT920cETLbVLeuqvzKrL3RzMiROq+AgEUTPAZlV3CHOU lFg2UqUtpnTHOMyJoDfAIc1iBKO1xmCt46ChllAj1whKmuj1+gC4vtJThEokV0zDtS+Gw7j+JW3KEu Dk+/jJ40FJPwK5FssbHoLwkjfyyAVxoHnrDD5NmRQCZkFX84lKTGcO7fulLLtvbfrArKr+C6jJFT5r Wg+qCgb6JQf584VEZ4uiK/lafWv/irAD7lfHi6YRC1ILq724D6TZHZrw9Rn8Zt+bksGxfCwnJojO5B g49B1OH5iEnxOUSfn5qsQ1GGf4fkND
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

Create struct bdev_handle that contains all parameters that need to be
passed to blkdev_put() and provide bdev_open_* functions that return
this structure instead of plain bdev pointer. This will eventually allow
us to pass one more argument to blkdev_put() (renamed to bdev_release())
without too much hassle.

Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c           | 48 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h | 10 +++++++++
 2 files changed, 58 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index f3b13aa1b7d4..bdc7d739882b 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -829,6 +829,25 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 }
 EXPORT_SYMBOL(blkdev_get_by_dev);
 
+struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
+				     const struct blk_holder_ops *hops)
+{
+	struct bdev_handle *handle = kmalloc(sizeof(*handle), GFP_KERNEL);
+	struct block_device *bdev;
+
+	if (!handle)
+		return ERR_PTR(-ENOMEM);
+	bdev = blkdev_get_by_dev(dev, mode, holder, hops);
+	if (IS_ERR(bdev)) {
+		kfree(handle);
+		return ERR_CAST(bdev);
+	}
+	handle->bdev = bdev;
+	handle->holder = holder;
+	return handle;
+}
+EXPORT_SYMBOL(bdev_open_by_dev);
+
 /**
  * blkdev_get_by_path - open a block device by name
  * @path: path to the block device to open
@@ -867,6 +886,28 @@ struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
 }
 EXPORT_SYMBOL(blkdev_get_by_path);
 
+struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
+		void *holder, const struct blk_holder_ops *hops)
+{
+	struct bdev_handle *handle;
+	dev_t dev;
+	int error;
+
+	error = lookup_bdev(path, &dev);
+	if (error)
+		return ERR_PTR(error);
+
+	handle = bdev_open_by_dev(dev, mode, holder, hops);
+	if (!IS_ERR(handle) && (mode & BLK_OPEN_WRITE) &&
+	    bdev_read_only(handle->bdev)) {
+		bdev_release(handle);
+		return ERR_PTR(-EACCES);
+	}
+
+	return handle;
+}
+EXPORT_SYMBOL(bdev_open_by_path);
+
 void blkdev_put(struct block_device *bdev, void *holder)
 {
 	struct gendisk *disk = bdev->bd_disk;
@@ -903,6 +944,13 @@ void blkdev_put(struct block_device *bdev, void *holder)
 }
 EXPORT_SYMBOL(blkdev_put);
 
+void bdev_release(struct bdev_handle *handle)
+{
+	blkdev_put(handle->bdev, handle->holder);
+	kfree(handle);
+}
+EXPORT_SYMBOL(bdev_release);
+
 /**
  * lookup_bdev() - Look up a struct block_device by name.
  * @pathname: Name of the block device in the filesystem.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index eef450f25982..03d3adc3ff34 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1479,14 +1479,24 @@ extern const struct blk_holder_ops fs_holder_ops;
 #define sb_open_mode(flags) \
 	(BLK_OPEN_READ | (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
 
+struct bdev_handle {
+	struct block_device *bdev;
+	void *holder;
+};
+
 struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct block_device *blkdev_get_by_path(const char *path, blk_mode_t mode,
 		void *holder, const struct blk_holder_ops *hops);
+struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
+		const struct blk_holder_ops *hops);
+struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
+		void *holder, const struct blk_holder_ops *hops);
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
 void blkdev_put(struct block_device *bdev, void *holder);
+void bdev_release(struct bdev_handle *handle);
 
 /* just for blk-cgroup, don't use elsewhere */
 struct block_device *blkdev_get_no_open(dev_t dev);
-- 
2.35.3

