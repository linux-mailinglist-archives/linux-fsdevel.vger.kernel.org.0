Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74123708BB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 00:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjERWea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 18:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjERWeH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 18:34:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5B010CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 15:33:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae408f4d1aso20867215ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 15:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684449239; x=1687041239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1nBFbl2kNhqRXHkgIUn6lQxv3BWL5XvL+95Aso43MI=;
        b=JnT3Nm6byGtDawfZcACo1v8lokc0XTySqmTYShweWMVp8qL45gp07eq/6jgdwoVlR0
         nZXUqAFvVJd7nS83y/ZXaFd7TsKRuQjPPI8JmvPWUHujsZkS7P4hHgSkTkmF2pkjGl9K
         DSB916FWMBFpvSJ5MLATv/gve4uyaJyVrwk+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684449239; x=1687041239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1nBFbl2kNhqRXHkgIUn6lQxv3BWL5XvL+95Aso43MI=;
        b=VeRD3fL7YstadbvWnvvLFRpHmGS7K0cyWsB1DHv23cqYWhbGo+tsGdn6enYjmiIZwO
         w60lEpHyjYOZ3n8hZxJOeVXZJHJb59uXGCbKfWHDsngk5kgJv2wFKNJflkNu5Ro8iFZp
         WXOgnMwFnDoL4EKkIbihxwDv02oVxiGQqpElKoGIw6eFVhb8VMPnvpCrBq88pyCx9MtE
         nqcMtDc4xU0rkrJIomaStCmJJur7afVduEPNm1ksi5jX5kinAkVNw6sLyyRc5MKouH+M
         BZGVQQraFFdDBdi7iadrSfFnUgjWogByL08gpZCzb4ef+wIZCuquSM2UHW8MBUs1f91e
         jWfQ==
X-Gm-Message-State: AC+VfDyKMRpq8A/g3SAMsXXzt2XNa3v5pfyTNjRf41LffGiCkdtTKtde
        uFtRL1ufHwWsIF7Db871d0Dpvg==
X-Google-Smtp-Source: ACHHUZ7zJhYjfPa+ZbTaOHzNa4SnFtqdlL9pTqh+Bv9ufbfnFBxQYSdHmDSrGjM9o2XMte6XYk8eIA==
X-Received: by 2002:a17:903:2689:b0:1ac:8837:df8 with SMTP id jf9-20020a170903268900b001ac88370df8mr699263plb.6.1684449239382;
        Thu, 18 May 2023 15:33:59 -0700 (PDT)
Received: from sarthakkukreti-glaptop.corp.google.com ([100.107.238.113])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902b10400b001aafb802efbsm1996502plr.12.2023.05.18.15.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 15:33:59 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v7 5/5] loop: Add support for provision requests
Date:   Thu, 18 May 2023 15:33:26 -0700
Message-ID: <20230518223326.18744-6-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230518223326.18744-1-sarthakkukreti@chromium.org>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for provision requests to loopback devices.
Loop devices will configure provision support based on
whether the underlying block device/file can support
the provision request and upon receiving a provision bio,
will map it to the backing device/storage. For loop devices
over files, a REQ_OP_PROVISION request will translate to
an fallocate mode 0 call on the backing file.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 drivers/block/loop.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bc31bb7072a2..7fe1a6629754 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -311,16 +311,20 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 {
 	/*
 	 * We use fallocate to manipulate the space mappings used by the image
-	 * a.k.a. discard/zerorange.
+	 * a.k.a. discard/provision/zerorange.
 	 */
 	struct file *file = lo->lo_backing_file;
 	int ret;
 
-	mode |= FALLOC_FL_KEEP_SIZE;
+	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE) &&
+	    !bdev_max_discard_sectors(lo->lo_device))
+		return -EOPNOTSUPP;
 
-	if (!bdev_max_discard_sectors(lo->lo_device))
+	if (mode == 0 && !bdev_max_provision_sectors(lo->lo_device))
 		return -EOPNOTSUPP;
 
+	mode |= FALLOC_FL_KEEP_SIZE;
+
 	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
 	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
 		return -EIO;
@@ -488,6 +492,8 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 				FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_DISCARD:
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
+	case REQ_OP_PROVISION:
+		return lo_fallocate(lo, rq, pos, 0);
 	case REQ_OP_WRITE:
 		if (cmd->use_aio)
 			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
@@ -754,6 +760,25 @@ static void loop_sysfs_exit(struct loop_device *lo)
 				   &loop_attribute_group);
 }
 
+static void loop_config_provision(struct loop_device *lo)
+{
+	struct file *file = lo->lo_backing_file;
+	struct inode *inode = file->f_mapping->host;
+
+	/*
+	 * If the backing device is a block device, mirror its provisioning
+	 * capability.
+	 */
+	if (S_ISBLK(inode->i_mode)) {
+		blk_queue_max_provision_sectors(lo->lo_queue,
+			bdev_max_provision_sectors(I_BDEV(inode)));
+	} else if (file->f_op->fallocate) {
+		blk_queue_max_provision_sectors(lo->lo_queue, UINT_MAX >> 9);
+	} else {
+		blk_queue_max_provision_sectors(lo->lo_queue, 0);
+	}
+}
+
 static void loop_config_discard(struct loop_device *lo)
 {
 	struct file *file = lo->lo_backing_file;
@@ -1092,6 +1117,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	blk_queue_io_min(lo->lo_queue, bsize);
 
 	loop_config_discard(lo);
+	loop_config_provision(lo);
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
@@ -1304,6 +1330,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	}
 
 	loop_config_discard(lo);
+	loop_config_provision(lo);
 
 	/* update dio if lo_offset or transfer is changed */
 	__loop_update_dio(lo, lo->use_dio);
@@ -1830,6 +1857,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case REQ_OP_FLUSH:
 	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_PROVISION:
 		cmd->use_aio = false;
 		break;
 	default:
-- 
2.40.1.698.g37aff9b760-goog

