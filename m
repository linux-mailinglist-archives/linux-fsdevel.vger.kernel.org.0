Return-Path: <linux-fsdevel+bounces-64233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E74BDE368
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 13:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2B115055F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 11:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4F631CA4A;
	Wed, 15 Oct 2025 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JkKxcD66"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408031B126
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526487; cv=none; b=HT0SI7SLRoZBjr1q7BC9dLPWYPZpTEcc0UjR1ka9UV5ekx4N3KLLs6F8wcAd2xTMyjxHqE+yBZ1YMvR/FB/oO2a0VkExw86zGyg5gsPHCXnklOS6RfAWdZiYAiFGwt9PklxDLGMXTZrWhBAyxmjFnnnTkGXsN4VF14k6VChzcV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526487; c=relaxed/simple;
	bh=1u2LIoxahkJPWhM7Uax5orPrW0Cr6PAxL4VGLLRXoxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0Bx8qg0Gp3qLGXxf0EBZ+GfJcH6sfDXEm3sjSeOwrFkrsiuY0VUVXRVU0Zc987fLuJPz2d3fj9yyb+lpoFdmUgF3vndpxGbrSSpIWQeAJebFnLAtKIOaezswqECg3qoumKjRmmGRnrYZRU3RBqQzvn1ITpP12IbkojV7M/krQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JkKxcD66; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760526484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZsKTAfdvZpb0rFfRSbII2hejfskdrL2xbYcDgpfqUg=;
	b=JkKxcD66SaORgln7yd2AH62JZBxqDGAOJ89b0h/nGUTHOJGZVi50OAz5vIdy21lETg/loo
	eLCrgyldzUsxMJkxJHiS2fsb7ARXcVmhUGgC1XID0uDjRIqFefdFiipkiJBiK8tdD00lMe
	qjPIS18ymNXVMbJfWwQJ90f71uNxZ1Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-S0q8KOtUPSmeGsPh5Of4Mg-1; Wed,
 15 Oct 2025 07:08:01 -0400
X-MC-Unique: S0q8KOtUPSmeGsPh5Of4Mg-1
X-Mimecast-MFC-AGG-ID: S0q8KOtUPSmeGsPh5Of4Mg_1760526480
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41DD21956094;
	Wed, 15 Oct 2025 11:08:00 +0000 (UTC)
Received: from localhost (unknown [10.72.120.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5504E19560AD;
	Wed, 15 Oct 2025 11:07:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 3/6] loop: add lo_submit_rw_aio()
Date: Wed, 15 Oct 2025 19:07:28 +0800
Message-ID: <20251015110735.1361261-4-ming.lei@redhat.com>
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

Refactor lo_rw_aio() by extracting the I/O submission logic into a new
helper function lo_submit_rw_aio(). This further improves code organization
by separating the I/O preparation, submission, and completion handling into
distinct phases.

Prepare for using NOWAIT to improve loop performance.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b065892106a6..3ab910572bd9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -393,38 +393,32 @@ static int lo_rw_aio_prep(struct loop_device *lo, struct loop_cmd *cmd,
 	return 0;
 }
 
-static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
-		     loff_t pos, int rw)
+static int lo_submit_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
+			    int nr_bvec, int rw)
 {
-	struct iov_iter iter;
-	struct bio_vec *bvec;
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
-	struct bio *bio = rq->bio;
 	struct file *file = lo->lo_backing_file;
-	unsigned int offset;
-	int nr_bvec = lo_cmd_nr_bvec(cmd);
+	struct iov_iter iter;
 	int ret;
 
-	ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
-	if (unlikely(ret))
-		return ret;
-
 	if (cmd->bvec) {
-		offset = 0;
-		bvec = cmd->bvec;
+		iov_iter_bvec(&iter, rw, cmd->bvec, nr_bvec, blk_rq_bytes(rq));
+		iter.iov_offset = 0;
 	} else {
+		struct bio *bio = rq->bio;
+		struct bio_vec *bvec = __bvec_iter_bvec(bio->bi_io_vec,
+				bio->bi_iter);
+
 		/*
 		 * Same here, this bio may be started from the middle of the
 		 * 'bvec' because of bio splitting, so offset from the bvec
 		 * must be passed to iov iterator
 		 */
-		offset = bio->bi_iter.bi_bvec_done;
-		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
+		iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
+		iter.iov_offset = bio->bi_iter.bi_bvec_done;
 	}
 	atomic_set(&cmd->ref, 2);
 
-	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
-	iter.iov_offset = offset;
 
 	if (rw == ITER_SOURCE) {
 		kiocb_start_write(&cmd->iocb);
@@ -433,7 +427,20 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		ret = file->f_op->read_iter(&cmd->iocb, &iter);
 
 	lo_rw_aio_do_completion(cmd);
+	return ret;
+}
+
+static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
+		     loff_t pos, int rw)
+{
+	int nr_bvec = lo_cmd_nr_bvec(cmd);
+	int ret;
+
+	ret = lo_rw_aio_prep(lo, cmd, nr_bvec, pos);
+	if (unlikely(ret))
+		return ret;
 
+	ret = lo_submit_rw_aio(lo, cmd, nr_bvec, rw);
 	if (ret != -EIOCBQUEUED)
 		lo_rw_aio_complete(&cmd->iocb, ret);
 	return -EIOCBQUEUED;
-- 
2.47.0


