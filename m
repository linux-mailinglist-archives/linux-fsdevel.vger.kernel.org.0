Return-Path: <linux-fsdevel+bounces-64236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D46BDE371
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 13:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E44D504A83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 11:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6345731CA59;
	Wed, 15 Oct 2025 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaAjM5MC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4FF31CA4A
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526499; cv=none; b=VThK105PmGx3Hg1O/5Uo8n05kkQ0S5o9DFtAC69+wVBrcXYhtox/aPjExeNAwpSKgUpvKj8ioyT1dVMb3nsclBwwYph4WYjAVRro+2Z6VpY1lXxpBGNBlxCL3hKYIDTtLc2H+HQRXd3IfDCfTSBy0V1KWIyOUmcgw/Ofr+F7KP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526499; c=relaxed/simple;
	bh=fJ+lgpyul5LCFPrbO3rr5dR4/r00JPb/lSi1+jAZLvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frjGavU13VgKHR6nuiTBGFSnivJgdiMHBqvnt1man+6St0zAzv/pFaZg17R+FRJ/t2DNowUxyKcHNVBx3zT7MKcX+dXPf5uZ/jtqOBL2W4xXK7VpaUqMFU7JcGHbwNpMPkMtp7JgMuaVncaAGORGJU7dI+cDqZPeQ0LT8FkUiWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaAjM5MC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760526497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxEbBrxuUTR/dTladV/C8Wh8SZt/ora9zcsJYo3QO8U=;
	b=FaAjM5MCivURvt/YbMunXdOueRp+XkwD4BwSFPk+NHbgY53FegVbEfX5tpHngHWz7XN1DM
	3+cnVLihuCU9Sfh+zTN4Y8HGyA1Denl6tYXip/g/ml5SU5pcW3f9Pvd2OwxSJcoDE7f2jt
	nW2ozP8xfolVexP/RQpc+Ncc+yLF3SQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-0NMCo_oKMBKNvDwcXi6i0A-1; Wed,
 15 Oct 2025 07:08:14 -0400
X-MC-Unique: 0NMCo_oKMBKNvDwcXi6i0A-1
X-Mimecast-MFC-AGG-ID: 0NMCo_oKMBKNvDwcXi6i0A_1760526493
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8E041800345;
	Wed, 15 Oct 2025 11:08:12 +0000 (UTC)
Received: from localhost (unknown [10.72.120.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA27519560AD;
	Wed, 15 Oct 2025 11:08:11 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 6/6] loop: add hint for handling aio via IOCB_NOWAIT
Date: Wed, 15 Oct 2025 19:07:31 +0800
Message-ID: <20251015110735.1361261-7-ming.lei@redhat.com>
In-Reply-To: <20251015110735.1361261-1-ming.lei@redhat.com>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add hint for using IOCB_NOWAIT to handle loop aio command for avoiding
to cause write(especially randwrite) perf regression on sparse backed file.

Try IOCB_NOWAIT in the following situations:

- backing file is block device

OR

- READ aio command

OR

- there isn't any queued blocking async WRITEs, because NOWAIT won't cause
contention with blocking WRITE, which often implies exclusive lock

With this simple policy, perf regression of randwrite/write on sparse
backing file is fixed.

Link: https://lore.kernel.org/dm-devel/7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f752942d0889..e42bdfc73c20 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -68,6 +68,7 @@ struct loop_device {
 	struct rb_root          worker_tree;
 	struct timer_list       timer;
 	bool			sysfs_inited;
+	unsigned 		lo_nr_blocking_writes;
 
 	struct request_queue	*lo_queue;
 	struct blk_mq_tag_set	tag_set;
@@ -467,6 +468,33 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	return -EIOCBQUEUED;
 }
 
+static inline bool lo_aio_try_nowait(struct loop_device *lo,
+		struct loop_cmd *cmd)
+{
+	struct file *file = lo->lo_backing_file;
+	struct inode *inode = file->f_mapping->host;
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+
+	/* NOWAIT works fine for backing block device */
+	if (S_ISBLK(inode->i_mode))
+		return true;
+
+	/*
+	 * NOWAIT is supposed to be fine for READ without contending with
+	 * blocking WRITE
+	 */
+	if (req_op(rq) == REQ_OP_READ)
+		return true;
+
+	/*
+	 * If there is any queued non-NOWAIT async WRITE , don't try new
+	 * NOWAIT WRITE for avoiding contention
+	 *
+	 * Here we focus on handling stable FS block mapping via NOWAIT
+	 */
+	return READ_ONCE(lo->lo_nr_blocking_writes) == 0;
+}
+
 static int lo_rw_aio_nowait(struct loop_device *lo, struct loop_cmd *cmd,
 			    int rw)
 {
@@ -478,6 +506,9 @@ static int lo_rw_aio_nowait(struct loop_device *lo, struct loop_cmd *cmd,
 	if (unlikely(ret))
 		goto fail;
 
+	if (!lo_aio_try_nowait(lo, cmd))
+		return -EAGAIN;
+
 	cmd->iocb.ki_flags |= IOCB_NOWAIT;
 	ret = lo_submit_rw_aio(lo, cmd, nr_bvec, rw);
 fail:
@@ -778,12 +809,19 @@ static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
 	return sysfs_emit(buf, "%s\n", dio ? "1" : "0");
 }
 
+static ssize_t loop_attr_nr_blocking_writes_show(struct loop_device *lo,
+						 char *buf)
+{
+	return sysfs_emit(buf, "%u\n", lo->lo_nr_blocking_writes);
+}
+
 LOOP_ATTR_RO(backing_file);
 LOOP_ATTR_RO(offset);
 LOOP_ATTR_RO(sizelimit);
 LOOP_ATTR_RO(autoclear);
 LOOP_ATTR_RO(partscan);
 LOOP_ATTR_RO(dio);
+LOOP_ATTR_RO(nr_blocking_writes);
 
 static struct attribute *loop_attrs[] = {
 	&loop_attr_backing_file.attr,
@@ -792,6 +830,7 @@ static struct attribute *loop_attrs[] = {
 	&loop_attr_autoclear.attr,
 	&loop_attr_partscan.attr,
 	&loop_attr_dio.attr,
+	&loop_attr_nr_blocking_writes.attr,
 	NULL,
 };
 
@@ -867,6 +906,24 @@ static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
 }
 #endif
 
+static inline void loop_inc_blocking_writes(struct loop_device *lo,
+		struct loop_cmd *cmd)
+{
+	lockdep_assert_held(&lo->lo_work_lock);
+
+	if (req_op(blk_mq_rq_from_pdu(cmd)) == REQ_OP_WRITE)
+		lo->lo_nr_blocking_writes += 1;
+}
+
+static inline void loop_dec_blocking_writes(struct loop_device *lo,
+		struct loop_cmd *cmd)
+{
+	lockdep_assert_held(&lo->lo_work_lock);
+
+	if (req_op(blk_mq_rq_from_pdu(cmd)) == REQ_OP_WRITE)
+		lo->lo_nr_blocking_writes -= 1;
+}
+
 static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 {
 	struct request __maybe_unused *rq = blk_mq_rq_from_pdu(cmd);
@@ -949,6 +1006,8 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 		work = &lo->rootcg_work;
 		cmd_list = &lo->rootcg_cmd_list;
 	}
+	if (cmd->use_aio)
+		loop_inc_blocking_writes(lo, cmd);
 	list_add_tail(&cmd->list_entry, cmd_list);
 	queue_work(lo->workqueue, work);
 	spin_unlock_irq(&lo->lo_work_lock);
@@ -2048,6 +2107,8 @@ static void loop_process_work(struct loop_worker *worker,
 		cond_resched();
 
 		spin_lock_irq(&lo->lo_work_lock);
+		if (cmd->use_aio)
+			loop_dec_blocking_writes(lo, cmd);
 	}
 
 	/*
-- 
2.47.0


