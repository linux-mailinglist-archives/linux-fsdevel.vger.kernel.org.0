Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0934B6E1898
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 02:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjDNACx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 20:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjDNACr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:02:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5AD422F
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 17:02:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i8so7786704plt.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 17:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681430565; x=1684022565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJ+yGPB/3GoY7peOyZ+CblNlWIiKQ+IujQrkD9HaThI=;
        b=Q5yEf8VVu1Ha5eq/IcQ+axQUSkWqI3cYCE2Kl2IkuWdx1w75hbPtfoSsJofYJBihQd
         FdejaFuePUEcDFBLCYVwSzj6/nHxN8ZWKFNMqVP9NzM0m5oEsMrfbceo/4SASLO75sBr
         aEba65SItI85taRBIz86BVxWTKrG0fV1o3SBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681430565; x=1684022565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJ+yGPB/3GoY7peOyZ+CblNlWIiKQ+IujQrkD9HaThI=;
        b=Uzbx/im07sEHHzumFfSSSrU4wpsSlMt2eN+SiYZn8/ct8fnRbCcAba7dUmpH4jD3Ri
         TkITkB1OQcrX6K944NeYk6e2KQGPNj4VeqCeo9e6caeOEscrMamwq60yG7ZYYNfKS3I1
         6x4bfeGwlz56zaIXxgLoAbQ2f6NVy5NViKfoyIWfPcKwPFe6Po89piLQcSIji8DmezCJ
         nx16TQahxFaYntU4YSQEFk/31XWUe8PXZ0lG3P7KB7C1iyzXuepnrso96ZU8Ws8OG3cq
         s8yqPreltN+YhLBMBtMf+YEuDl7p4tj9045EbUGtbkDbIU/SGYa3f6oIlpb7jTrt8LnE
         4YfQ==
X-Gm-Message-State: AAQBX9eCy/3QP2yYw8VWiEKy9U3htd5cG9+nSVaj/pD0u9z23N2ktXQ9
        3+G6g9/0ljZRyeKmA9C6k9bcpA==
X-Google-Smtp-Source: AKy350YS2ahdtmW0Myogl0p0yMkCzdJ4qqgue5zCXLDXviJQG2FkadOI2sBQqO7OcBtOX00lPFsZRw==
X-Received: by 2002:a17:902:e810:b0:1a6:4a64:4d27 with SMTP id u16-20020a170902e81000b001a64a644d27mr935553plg.40.1681430565016;
        Thu, 13 Apr 2023 17:02:45 -0700 (PDT)
Received: from sarthakkukreti-glaptop.corp.google.com ([2620:15c:9d:200:72cc:7fa5:adcb:7c02])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090a891200b002470f179b92sm2212939pjn.43.2023.04.13.17.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 17:02:44 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v3 3/3] loop: Add support for provision requests
Date:   Thu, 13 Apr 2023 17:02:19 -0700
Message-ID: <20230414000219.92640-4-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230414000219.92640-1-sarthakkukreti@chromium.org>
References: <20221229071647.437095-1-sarthakkukreti@chromium.org>
 <20230414000219.92640-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/block/loop.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bc31bb7072a2..13c4b4f8b9c1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -327,6 +327,24 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	return ret;
 }
 
+static int lo_req_provision(struct loop_device *lo, struct request *rq, loff_t pos)
+{
+	struct file *file = lo->lo_backing_file;
+	struct request_queue *q = lo->lo_queue;
+	int ret;
+
+	if (!q->limits.max_provision_sectors) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	ret = file->f_op->fallocate(file, 0, pos, blk_rq_bytes(rq));
+	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
+		ret = -EIO;
+ out:
+	return ret;
+}
+
 static int lo_req_flush(struct loop_device *lo, struct request *rq)
 {
 	int ret = vfs_fsync(lo->lo_backing_file, 0);
@@ -488,6 +506,8 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 				FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_DISCARD:
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
+	case REQ_OP_PROVISION:
+		return lo_req_provision(lo, rq, pos);
 	case REQ_OP_WRITE:
 		if (cmd->use_aio)
 			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
@@ -754,6 +774,25 @@ static void loop_sysfs_exit(struct loop_device *lo)
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
@@ -1092,6 +1131,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	blk_queue_io_min(lo->lo_queue, bsize);
 
 	loop_config_discard(lo);
+	loop_config_provision(lo);
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
@@ -1304,6 +1344,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	}
 
 	loop_config_discard(lo);
+	loop_config_provision(lo);
 
 	/* update dio if lo_offset or transfer is changed */
 	__loop_update_dio(lo, lo->use_dio);
@@ -1830,6 +1871,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case REQ_OP_FLUSH:
 	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_PROVISION:
 		cmd->use_aio = false;
 		break;
 	default:
-- 
2.40.0.634.g4ca3ef3211-goog

