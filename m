Return-Path: <linux-fsdevel+bounces-62950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC3ABA70F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 15:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56A93BB0B5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 13:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B719A2DCF43;
	Sun, 28 Sep 2025 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvu9tkLp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FB42DEA64
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759066191; cv=none; b=iArFoTm0chf7f53swQ2yRmkCjCreVJvqrWgSiK/CtBKy49BvitVm0lyFi+pve3ToNZ/pSX27Q9IqLd8hqZJQ50SQowqeYP4nx/oNCa0J7BIX47umps1jQqxiWFcgXbd6IBYcMTHC+MMj5zmnMM3+DDt9xxxXe7VqmWfiXywMPQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759066191; c=relaxed/simple;
	bh=AH9gEPrvjU7qIX4nYobgT12HlGfe4gqEi6NrB+tX5Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIgHFdAq8oqsjyA9YmG0F1VwvYjfV41RqRwsaVYL1orCUOZDyrTQo5KsTvMPGt3dKWWXj3yt3PE21djYn/M87TvUo316GFp2eaABme6u+psWEPVVv2Ek8qU6Mw2IrvG52yEIkRGcwrow342vcHaA3xitsNphGrdOjuCNjU+vmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvu9tkLp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759066188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sMFkQGzj8/mCh4+XZZjvrz3BX1pQafwvYuD0xifvsk=;
	b=hvu9tkLp/4GdMVhUqnI95TYxUMe66Bn7mp+h4pTn6oJVCrTL1j+aLK4MaVjbJM/Nr8/4jp
	OVUUho/uEo7X290p5HZd5vtr6uIuJAB8u2HhW3qH9UfYPyoM93AKKkx6ZLTlGwOi8NM1d5
	PLcwPecWl9hmNKX/cTK0lDBRg/F4Tmw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-xVlJy9AzNAeFR_TXO0k_Xw-1; Sun,
 28 Sep 2025 09:29:47 -0400
X-MC-Unique: xVlJy9AzNAeFR_TXO0k_Xw-1
X-Mimecast-MFC-AGG-ID: xVlJy9AzNAeFR_TXO0k_Xw_1759066186
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE6551800451;
	Sun, 28 Sep 2025 13:29:45 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2C081956095;
	Sun, 28 Sep 2025 13:29:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 2/6] loop: add helper lo_rw_aio_prep()
Date: Sun, 28 Sep 2025 21:29:21 +0800
Message-ID: <20250928132927.3672537-3-ming.lei@redhat.com>
In-Reply-To: <20250928132927.3672537-1-ming.lei@redhat.com>
References: <20250928132927.3672537-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add helper lo_rw_aio_prep() to make lo_rw_aio() more readable.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 63 ++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index af443651dff5..b065892106a6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -350,21 +350,15 @@ static inline unsigned lo_cmd_nr_bvec(struct loop_cmd *cmd)
 	return nr_bvec;
 }
 
-static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
-		     loff_t pos, int rw)
+static int lo_rw_aio_prep(struct loop_device *lo, struct loop_cmd *cmd,
+			  unsigned nr_bvec, loff_t pos)
 {
-	struct iov_iter iter;
-	struct req_iterator rq_iter;
-	struct bio_vec *bvec;
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
-	struct bio *bio = rq->bio;
-	struct file *file = lo->lo_backing_file;
-	struct bio_vec tmp;
-	unsigned int offset;
-	int nr_bvec = lo_cmd_nr_bvec(cmd);
-	int ret;
 
 	if (rq->bio != rq->biotail) {
+		struct req_iterator rq_iter;
+		struct bio_vec *bvec;
+		struct bio_vec tmp;
 
 		bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
 				     GFP_NOIO);
@@ -382,8 +376,42 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 			*bvec = tmp;
 			bvec++;
 		}
-		bvec = cmd->bvec;
+	} else {
+		cmd->bvec = NULL;
+	}
+
+	cmd->iocb.ki_pos = pos;
+	cmd->iocb.ki_filp = lo->lo_backing_file;
+	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
+	if (cmd->use_aio) {
+		cmd->iocb.ki_complete = lo_rw_aio_complete;
+		cmd->iocb.ki_flags = IOCB_DIRECT;
+	} else {
+		cmd->iocb.ki_complete = NULL;
+		cmd->iocb.ki_flags = 0;
+	}
+	return 0;
+}
+
+static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
+		     loff_t pos, int rw)
+{
+	struct iov_iter iter;
+	struct bio_vec *bvec;
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	struct bio *bio = rq->bio;
+	struct file *file = lo->lo_backing_file;
+	unsigned int offset;
+	int nr_bvec = lo_cmd_nr_bvec(cmd);
+	int ret;
+
+	ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
+	if (unlikely(ret))
+		return ret;
+
+	if (cmd->bvec) {
 		offset = 0;
+		bvec = cmd->bvec;
 	} else {
 		/*
 		 * Same here, this bio may be started from the middle of the
@@ -398,17 +426,6 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
 	iter.iov_offset = offset;
 
-	cmd->iocb.ki_pos = pos;
-	cmd->iocb.ki_filp = file;
-	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
-	if (cmd->use_aio) {
-		cmd->iocb.ki_complete = lo_rw_aio_complete;
-		cmd->iocb.ki_flags = IOCB_DIRECT;
-	} else {
-		cmd->iocb.ki_complete = NULL;
-		cmd->iocb.ki_flags = 0;
-	}
-
 	if (rw == ITER_SOURCE) {
 		kiocb_start_write(&cmd->iocb);
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
-- 
2.47.0


