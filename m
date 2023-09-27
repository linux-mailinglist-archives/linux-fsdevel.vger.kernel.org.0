Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E47B0053
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjI0JfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjI0Jes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:34:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C0119E;
        Wed, 27 Sep 2023 02:34:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 41F3D1FD64;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5oL3zzk7aBWSiW2h8pYJhcBd87nT48/i5kz3mlJh90=;
        b=VxWyNg9R5RlMkiQSfkj2UYuqtUrf3hwcvc5HylmbTrnQepEPMHb5swu6/q+YDMI4qZnLOZ
        oyQsT7QxcFBxcm/IJ8kO0Px9ZQNmw18YqC/xXm6YK+cIygHFm4m54byLoMQb02stPw/ERl
        WZXqb2gXdC91hZsVUnVVnFY/Qt20j9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5oL3zzk7aBWSiW2h8pYJhcBd87nT48/i5kz3mlJh90=;
        b=DkrJriAiY9cxBDHeZzcr6QH7ZrXSQ1ViYv9AXwgRxdsD9xEgW/6eb2BmNieALtsvY4KyIv
        k7CKMQ0MDivWjtAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2929313AC6;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BAgKCjT3E2UZEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 44DF5A07E2; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 13/29] nvmet: Convert to bdev_open_by_path()
Date:   Wed, 27 Sep 2023 11:34:19 +0200
Message-Id: <20230927093442.25915-13-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2246; i=jack@suse.cz; h=from:subject; bh=RxVKNNY4F2L4gdEmRf2gfv2YRojDzya85DrN24azQj4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/ccmTw9KbKfKkVfEbK7NpxvUcITk8/FTPWgLWbM +QsEi0mJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3HAAKCRCcnaoHP2RA2R5wB/ 9ojwH/fGDSVue4IQj5x/zVaP/MNwEkNe//OCjEg7erUnb+a3B3cUvSs9SkrV7emtix97qbs96ZAycC xcM1bXQ+7/QGjjefhAhcNAzrtWQTDXfcX9oigj8vaUE3q9lEIWXK45912dl5tQqa58NWAhOeX+lIKu DwC6eoEcF3Yr2UrsUPfB7027H8d6i8CeAu2E8FPTHJTSaCj8kjJj2q2kdrPPCXi/PmZErHcZi6zQdi 1ixGROW5hW114GanqgVP5JUspreDLNbvjKlxuE0780hTJo477LQJLlhRgfJXfq4FL2xtGp6GMR8fq2 Ztb+AsKujcsC+kSFCDBL4eFlLUv5Mr
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

Convert nvmet to use bdev_open_by_path() and pass the handle around.

CC: linux-nvme@lists.infradead.org
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/nvme/target/io-cmd-bdev.c | 20 +++++++++++---------
 drivers/nvme/target/nvmet.h       |  1 +
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 468833675cc9..f11400a908f2 100644
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

