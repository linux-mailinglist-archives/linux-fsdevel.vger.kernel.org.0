Return-Path: <linux-fsdevel+bounces-64235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D9FBDE332
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 13:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9135D34D95D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 11:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE07630CD8C;
	Wed, 15 Oct 2025 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUYwCgVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF531BC99
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526497; cv=none; b=RBJYqA6Yk9X1fNFzMtE0yL05wNtYjZWEAZP3xjTTRYZHbKweYyzeVuoFM4M2Nl1NQvz7uxCQU0+H1othPA0U2/jpXN/cyHijcw4Blxtxr5KQ+OVf8TbJujnpynuDoBAAYt/uUR6KGfzf65sFBfbIHCtnikCxY8S5dRyef4EJXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526497; c=relaxed/simple;
	bh=wYMMU6RKSBpQUIAIFPhZYSeABFNjZ5+I6A9XJuGQrMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGUuBoWkjUSwElUhv3vAI7QnZuN5QUNqIlbRuKSebkh3P4L1NyM6flduoOm+FG0odKTapn0Mso7Bs0w9ya2HYrWr+XEleLm0yRUX9vDaOf/lSZChixKHK2nleiTTPzN3rc9LZ1D258yX6TQPZQDsYsSBHoDonlkosxdwXMsOFgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HUYwCgVC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760526494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVHsnHE4hjkZl+Gr5YHQ4AlHTRJOOj9GU8/HyaEb32U=;
	b=HUYwCgVCVTgyy7zlFsCJ9Tg8L2RX/b2fguxQMet8Zrb2CoKzExp5wePkXPgDbhbYev5tRc
	dbtslEui0wl5ab6MnI6Q1EETLiGcT92Wu4ozFo1Ctcg6Y1Cy/vjSwxLlliuqoTXy0QtCU2
	6B7ybw3ARg/CqApgXmZ/kpC/qHikM6c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-N1rJ_745PoaFAM3n0ERnoQ-1; Wed,
 15 Oct 2025 07:08:10 -0400
X-MC-Unique: N1rJ_745PoaFAM3n0ERnoQ-1
X-Mimecast-MFC-AGG-ID: N1rJ_745PoaFAM3n0ERnoQ_1760526489
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA3CE195609F;
	Wed, 15 Oct 2025 11:08:08 +0000 (UTC)
Received: from localhost (unknown [10.72.120.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A947830001A1;
	Wed, 15 Oct 2025 11:08:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 5/6] loop: try to handle loop aio command via NOWAIT IO first
Date: Wed, 15 Oct 2025 19:07:30 +0800
Message-ID: <20251015110735.1361261-6-ming.lei@redhat.com>
In-Reply-To: <20251015110735.1361261-1-ming.lei@redhat.com>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
 drivers/block/loop.c | 68 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 99eec0a25dbc..f752942d0889 100644
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
@@ -430,22 +441,51 @@ static int lo_submit_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	return ret;
 }
 
+static bool lo_backfile_support_nowait(const struct loop_device *lo)
+{
+	return lo->lo_backing_file->f_mode & FMODE_NOWAIT;
+}
+
 static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		     loff_t pos, int rw)
 {
 	int nr_bvec = lo_cmd_nr_bvec(cmd);
 	int ret;
 
-	ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
-	if (unlikely(ret))
-		return ret;
+	/* prepared already if we have tried nowait */
+	if (!cmd->use_aio || !lo_backfile_support_nowait(lo)) {
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
@@ -1903,6 +1943,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *rq = bd->rq;
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	struct loop_device *lo = rq->q->queuedata;
+	int rw = 0;
 
 	blk_mq_start_request(rq);
 
@@ -1915,9 +1956,25 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case REQ_OP_WRITE_ZEROES:
 		cmd->use_aio = false;
 		break;
-	default:
+	case REQ_OP_READ:
+		rw = ITER_DEST;
 		cmd->use_aio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 		break;
+	case REQ_OP_WRITE:
+		rw = ITER_SOURCE;
+		cmd->use_aio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
+		break;
+	default:
+		return BLK_STS_IOERR;
+	}
+
+	/* try NOWAIT if the backing file supports the mode */
+	if (cmd->use_aio && lo_backfile_support_nowait(lo)) {
+		int res = lo_rw_aio_nowait(lo, cmd, rw);
+
+		if (res != -EAGAIN && res != -EOPNOTSUPP)
+			return BLK_STS_OK;
+		/* fallback to workqueue for handling aio */
 	}
 
 	loop_queue_work(lo, cmd);
@@ -2069,7 +2126,8 @@ static int loop_add(int i)
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


