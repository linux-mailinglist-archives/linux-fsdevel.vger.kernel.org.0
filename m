Return-Path: <linux-fsdevel+bounces-62953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 071DDBA710E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 15:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785DB1899C3D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5F82DAFD8;
	Sun, 28 Sep 2025 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASaFrQ+L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B8B1E47A5
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759066211; cv=none; b=BBD38FobCst4UHtBAUxBOyjUTs2ZdlX14d1yYf57tNNur1Ngc+d5eZu4AMSABeyWdFpCt8Wk6c9OrdX/hw5fHU8gfL0gTPiLxig4WXeszT2BuOpMYYPs41CyFKfvxl7e3cm4ebxV7zYECreESV6UM7Pe+ScHV+jPRacaB3+RW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759066211; c=relaxed/simple;
	bh=EukTDNm3rw5hT7VKtwpc2Jgxc3rvOCzdCBRnOBdRQGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqieCwwDyKj/vxY+7TJstCJjJC2aIUx34GVu6LqZxSiLCQeWQGtp+ub6SuoGK68/UXNij1+3xD6wG8s5+180FPFHPWy1PrYFEG1n/2HLMnQp193GOaq08PAVImD4znQrgbGZT1XNcMiLmqj9eHWVwvMM5kLrlEqf+aEvGbeKiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASaFrQ+L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759066206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YwYJDHHHsyDTjwkzRPFtuA/BgBRSibIHonqz+k92G+I=;
	b=ASaFrQ+LtlehGn0MexwKckUrYenan2+4ly9htT5Gzif1ax/CYEhJexRYZMGK/CdTP/6YoJ
	LdWjK8MXb96JzOdoh2cgp9Hg6jrieLxMFFjuFdLwBgbKhQqBMRTeB4bT9GGKG16n5ewdxQ
	4uY0lzRfd/2yQ4qxtzEP36uu7N5m6vA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-jwllaGWdOieDoffTcDAzRQ-1; Sun,
 28 Sep 2025 09:30:00 -0400
X-MC-Unique: jwllaGWdOieDoffTcDAzRQ-1
X-Mimecast-MFC-AGG-ID: jwllaGWdOieDoffTcDAzRQ_1759066199
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 171101800578;
	Sun, 28 Sep 2025 13:29:59 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 19EC91956056;
	Sun, 28 Sep 2025 13:29:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 5/6] loop: try to handle loop aio command via NOWAIT IO first
Date: Sun, 28 Sep 2025 21:29:24 +0800
Message-ID: <20250928132927.3672537-6-ming.lei@redhat.com>
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

Try to handle loop aio command via NOWAIT IO first, then we can avoid to
queue the aio command into workqueue. This is usually one big win in
case that FS block mapping is stable, Mikulas verified [1] that this way
improves IO perf by close to 5X in 12jobs sequential read/write test,
in which FS block mapping is just stable.

Fallback to workqueue in case of -EAGAIN. This way may bring a little
cost from the 1st retry, but when running the following write test over
loop/sparse_file, the actual effect on randwrite is obvious:

```
truncate -s 4G 1.img    #1.img is created on XFS/virtio-scsi
losetup -f 1.img --direct-io=on
fio --direct=1 --bs=4k --runtime=40 --time_based --numjobs=1 --ioengine=libaio \
	--iodepth=16 --group_reporting=1 --filename=/dev/loop0 -name=job --rw=$RW
```

- RW=randwrite: obvious IOPS drop observed
- RW=write: a little drop(%5 - 10%)

This perf drop on randwrite over sparse file will be addressed in the
following patch.

BLK_MQ_F_BLOCKING has to be set for calling into .read_iter() or .write_iter()
which might sleep even though it is NOWAIT, and the only effect is that rcu read
lock is replaced with srcu read lock.

Link: https://lore.kernel.org/linux-block/a8e5c76a-231f-07d1-a394-847de930f638@redhat.com/ [1]
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 62 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 99eec0a25dbc..57e33553695b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -90,6 +90,8 @@ struct loop_cmd {
 #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
 #define LOOP_DEFAULT_HW_Q_DEPTH 128
 
+static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd);
+
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
@@ -321,6 +323,15 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 
 	if (!atomic_dec_and_test(&cmd->ref))
 		return;
+
+	/* -EAGAIN could be returned from bdev's ->ki_complete */
+	if (cmd->ret == -EAGAIN) {
+		struct loop_device *lo = rq->q->queuedata;
+
+		loop_queue_work(lo, cmd);
+		return;
+	}
+
 	kfree(cmd->bvec);
 	cmd->bvec = NULL;
 	if (req_op(rq) == REQ_OP_WRITE)
@@ -436,16 +447,40 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	int nr_bvec = lo_cmd_nr_bvec(cmd);
 	int ret;
 
-	ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
-	if (unlikely(ret))
-		return ret;
+	/* prepared already for aio from nowait code path */
+	if (!cmd->use_aio) {
+		ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
+		if (unlikely(ret))
+			goto fail;
+	}
 
+	cmd->iocb.ki_flags &= ~IOCB_NOWAIT;
 	ret = lo_submit_rw_aio(lo, cmd, nr_bvec, rw);
+fail:
 	if (ret != -EIOCBQUEUED)
 		lo_rw_aio_complete(&cmd->iocb, ret);
 	return -EIOCBQUEUED;
 }
 
+static int lo_rw_aio_nowait(struct loop_device *lo, struct loop_cmd *cmd,
+			    int rw)
+{
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	loff_t pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset;
+	int nr_bvec = lo_cmd_nr_bvec(cmd);
+	int ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
+
+	if (unlikely(ret))
+		goto fail;
+
+	cmd->iocb.ki_flags |= IOCB_NOWAIT;
+	ret = lo_submit_rw_aio(lo, cmd, nr_bvec, rw);
+fail:
+	if (ret != -EIOCBQUEUED && ret != -EAGAIN)
+		lo_rw_aio_complete(&cmd->iocb, ret);
+	return ret;
+}
+
 static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 {
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
@@ -1903,6 +1938,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *rq = bd->rq;
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	struct loop_device *lo = rq->q->queuedata;
+	int rw = 0;
 
 	blk_mq_start_request(rq);
 
@@ -1915,9 +1951,24 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case REQ_OP_WRITE_ZEROES:
 		cmd->use_aio = false;
 		break;
-	default:
+	case REQ_OP_READ:
+		rw = ITER_DEST;
+		cmd->use_aio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
+		break;
+	case REQ_OP_WRITE:
+		rw = ITER_SOURCE;
 		cmd->use_aio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 		break;
+	default:
+		return BLK_STS_IOERR;
+	}
+
+	if (cmd->use_aio) {
+		int res = lo_rw_aio_nowait(lo, cmd, rw);
+
+		if (res != -EAGAIN)
+			return BLK_STS_OK;
+		/* fallback to workqueue for handling aio */
 	}
 
 	loop_queue_work(lo, cmd);
@@ -2069,7 +2120,8 @@ static int loop_add(int i)
 	lo->tag_set.queue_depth = hw_queue_depth;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-	lo->tag_set.flags = BLK_MQ_F_STACKING | BLK_MQ_F_NO_SCHED_BY_DEFAULT;
+	lo->tag_set.flags = BLK_MQ_F_STACKING | BLK_MQ_F_NO_SCHED_BY_DEFAULT |
+		BLK_MQ_F_BLOCKING;
 	lo->tag_set.driver_data = lo;
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
-- 
2.47.0


