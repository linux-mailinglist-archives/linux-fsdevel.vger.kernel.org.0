Return-Path: <linux-fsdevel+bounces-62949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F199BA70ED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 15:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20F3179A9D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 13:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE93E2DEA70;
	Sun, 28 Sep 2025 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2GhHIFV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6B2DE717
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759066189; cv=none; b=JF3pUNr5OUt5dSthJMjTKplR3/kO9daagIciGeWhDfI4WLkQDe2QEM0epwotY2Y5two8AUH6/IOeH/TEC05T/D8q827UUuZCXuAqz6C3asPFQExKivI3D8XW3Ph+341hZJbTGA9q3LCU5bKPOnUjiECZ8fbdCKwlYeNhzUjyT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759066189; c=relaxed/simple;
	bh=ZKQYV7aISWHH9C10tbIWtRgz1+vhqEO64vVYOFrQ8UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mF5xZo/Bm+Ijpg6gdmDThIY4a3d+nNXtjvbsYVxtPKzEfyPHXQMgT6POAxGIjj091BUaV68HVaF7IjwKfNbpF4UIehaiJN/FSz7VgF2n4Havvjq3NjQm4d22rxuVFmORhSr+++qWzV/mCoujeXdbLlEHNtci20S8/Udx0IfKGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2GhHIFV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759066186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMONmUM6gayoqIXLJGw4GQd0IzRDlol0YYWX4b80ytA=;
	b=H2GhHIFV+sGwwQMwXAWHpfd46m/kt69sON3dpZG3ELUpDl3BLwSTg/Up6BOlFovme29e7g
	8LAssUTFFPmsPtaKG64SP6wxV+9wD0ZxNHtaIwzba2eogL77/Uo98ShPWhZdUwKzH0ofse
	O15LXfYB97xtgQ2fpVI3r13RkvVf4zs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-mOVN4p68OxaZ2a1KbwXgEQ-1; Sun,
 28 Sep 2025 09:29:42 -0400
X-MC-Unique: mOVN4p68OxaZ2a1KbwXgEQ-1
X-Mimecast-MFC-AGG-ID: mOVN4p68OxaZ2a1KbwXgEQ_1759066181
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ADFA1800451;
	Sun, 28 Sep 2025 13:29:41 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2607430001A4;
	Sun, 28 Sep 2025 13:29:39 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 1/6] loop: add helper lo_cmd_nr_bvec()
Date: Sun, 28 Sep 2025 21:29:20 +0800
Message-ID: <20250928132927.3672537-2-ming.lei@redhat.com>
In-Reply-To: <20250928132927.3672537-1-ming.lei@redhat.com>
References: <20250928132927.3672537-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add lo_cmd_nr_bvec() and prepare for refactoring lo_rw_aio().

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


