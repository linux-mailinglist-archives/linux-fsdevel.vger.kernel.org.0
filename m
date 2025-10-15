Return-Path: <linux-fsdevel+bounces-64231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DF1BDE35F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 13:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81029503890
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 11:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240ED31BCB2;
	Wed, 15 Oct 2025 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAI1Z1ou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BDC31BCAB
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526477; cv=none; b=RIr38ttZ1SmkbTeS/ySbcO2h+7tmFjV2vJCWy9BeDoZUVOpBAmbWaMFslWTys1agPHpRi5IaqpNahTnX9yvwUfGp6vQUGb1ZpKOgdZQyjrlonY6u7ALxxGLhtvwi71zvWRD7g6wb1n8TbTZw/+7kCZ3RjBywv73Yfsz9WJqwg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526477; c=relaxed/simple;
	bh=WFQy7Mc6x2CvbixLnZF28ReifYRSw3+8WX5aDrTwlcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9j/4ROrOfUYnM2GS69umAfOx9MvEJqIh9+I0XIpK39gFGaJJIWL9G5yPY5+tqvLA65803Sjfyv2f6shGE/6kLiYFoPiQsTBuAN0DVR7PmG7Vn6LaimbnsExUWeBiKj2meD1V0McCY9wZmuPrZCuJrfMZ3jybPao52PU7fszwOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VAI1Z1ou; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760526474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8pAXgWyE9GjvTf/aoS6e1A6VsLWuClIIEsEZgzQGcw=;
	b=VAI1Z1ou7g3nkGuI9J7UbzFfiBVk5hW4A77anI+pQyxWz3OcJrhULn3xnf9IMMman02B9+
	gywAMQ7ys/yskVC3eterPuG/xO2o4LldAvNodx/tJZ2cxASn+RpNeuW8CY4G7IOyGF4Ga2
	L68mHC/mMhDXOmsLhtptP90tJHGKYNU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-zRYexjqbMcSD-HnLJMSisg-1; Wed,
 15 Oct 2025 07:07:51 -0400
X-MC-Unique: zRYexjqbMcSD-HnLJMSisg-1
X-Mimecast-MFC-AGG-ID: zRYexjqbMcSD-HnLJMSisg_1760526470
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0A031808997;
	Wed, 15 Oct 2025 11:07:50 +0000 (UTC)
Received: from localhost (unknown [10.72.120.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A71DD30001A1;
	Wed, 15 Oct 2025 11:07:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 1/6] loop: add helper lo_cmd_nr_bvec()
Date: Wed, 15 Oct 2025 19:07:26 +0800
Message-ID: <20251015110735.1361261-2-ming.lei@redhat.com>
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

Add lo_cmd_nr_bvec() and prepare for refactoring lo_rw_aio().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 053a086d547e..af443651dff5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -337,6 +337,19 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
 	lo_rw_aio_do_completion(cmd);
 }
 
+static inline unsigned lo_cmd_nr_bvec(struct loop_cmd *cmd)
+{
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	struct req_iterator rq_iter;
+	struct bio_vec tmp;
+	int nr_bvec = 0;
+
+	rq_for_each_bvec(tmp, rq, rq_iter)
+		nr_bvec++;
+
+	return nr_bvec;
+}
+
 static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		     loff_t pos, int rw)
 {
@@ -348,12 +361,9 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	struct file *file = lo->lo_backing_file;
 	struct bio_vec tmp;
 	unsigned int offset;
-	int nr_bvec = 0;
+	int nr_bvec = lo_cmd_nr_bvec(cmd);
 	int ret;
 
-	rq_for_each_bvec(tmp, rq, rq_iter)
-		nr_bvec++;
-
 	if (rq->bio != rq->biotail) {
 
 		bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
-- 
2.47.0


