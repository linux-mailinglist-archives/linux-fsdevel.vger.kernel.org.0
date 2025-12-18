Return-Path: <linux-fsdevel+bounces-71640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAEBCCAF53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 09:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E47330C129E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 08:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16763332EBF;
	Thu, 18 Dec 2025 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBVvY/0T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD15332911
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046897; cv=none; b=nNwAxmJfmimUfaLqf76vbcapV5DOCZKRBZtDZI5MG26YLInEZOj7XwKGIC3uASf5hGY+1knkvTMnaEWs4Pnw8ZBoVjZrdyjWRwRw1x2wfdyy7LrHkhrgF7h4TNaaHc36BxMSRS8/VMz09r32Az7lKtLyGILYMkID9UPWqi7lxDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046897; c=relaxed/simple;
	bh=I4PCjUhCFFP1GB1VqUWFB+sDj0RF8PYOH5kRYPwdMU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBoMaXYvdhg3kYk7bYsLhIsP1l42BaxhG9Du5xSHRI+ajfheDigjBKSvQukUYd3qGV/1sU9xaJOnIzUXp3Vv7m+EVzQgVYiVbWy9m39ikXtNrYPMFme2RmpuUj+3fHM66q4nwefh57H1iO+UUqhaccKn6SuHIKzdXRBShMrLHKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBVvY/0T; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so380554a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 00:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766046895; x=1766651695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g67IYzmx504GLKJLdQ6KeR6Js5spiNZKZTk6IyeAF4o=;
        b=NBVvY/0Tt4msSrRSU1M/AsRbSwMwDeEXaIk5HJIrc5Vf1AyiSeNSQotOqvuFfP4PEP
         TKPhFS3xjOlzNvyhvphPfbJBNp+3tDxXRVOjcOZzzYd1ZPwQKELFLKLTeyr0nV63sj3v
         bP9oidz6ktWgNY7AaiIA48x0WXtxpBc13o6EZ+NXxjc0skNz4ir39U32k/OegAdD1R/7
         Ai7SkWlTqw9zt8UGhcPHblXlugnieOB/xjYu2OTEWe+0lko1UJl6pDGRSKbfNiyOiTr/
         6LKDLxDw84ge0xj7krZjlFAtpKIRQW1UhGrhZBoKZbTIHJ99ukCihPY/Ht97CWWTr1pM
         46IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766046895; x=1766651695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g67IYzmx504GLKJLdQ6KeR6Js5spiNZKZTk6IyeAF4o=;
        b=nhZ+Lpx1WcyCz1FfiBF+zu3jTgMvHXEpHqWoaEeqpIW6JrfMdbNJH260wh6Jk0o6zW
         un/Jx0U+L9KaeziIzvHXfs5n8YtpKhS2gb17qRW44tHgh/Hf7ysIld+D//OxPD/7Hb2G
         6+TLob59cmFj14euWRwFZ1NypitXYv+DkB1mw56BfRrHLc58qFE6agM5N7BTWWHmljuw
         Tp9JMbL6MPFVQFi6Rw7MqM6GUanwrgPXzvukhCPdQJ2W1flatA+gac84gRX4Ix5WpAfI
         A9p5pwmVuu08ERLg1uSNllxzyHDz6wILhR/gMGqVD2XWUeIH3cO6rq5lJw4J50leW2W2
         HbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/9QNvPy+NlTSpvxDznVu8aRjbTaX3GDBjAUsuDMB/wVNVSKFFZM7plZBdSW/YFK370QyE5KrPacp1bOaz@vger.kernel.org
X-Gm-Message-State: AOJu0YzLBFppLiQNN4p9GfCUsDcTS111apB4z3wM3gucgG1AuxyznPQ7
	hJkTQufCDdS/KUHwYdof6CwcInCdevHOpg2uAtrOw6eu+Wq/RNFR7bNs
X-Gm-Gg: AY/fxX7EnAXv//m9VAE9AF9wVs3xSK+FY3KijKytQwlAq10DfliFtR2fkL2KbIProTC
	ruzs1ZlKtcU+oIlpqg8s8bPPHdFL7fJutWktWjYvfdaxELDuzVngzoRw0vpQnnXIGPfRzS9uxWi
	LMcwlQgMqwvGbKiKyeruGJMujSaR1Gnzt6PUCv2WTa3B4MhMzNzoqPfA5ida6Oz1gfeg8D/i8JC
	hSMNexSqNVdWPRPAtDwSOIibQ3qTOgHrAzB5ylXLINZUEVjaWFONBEEh4Jk0/7pChoKuchIq4Cu
	CxhXHei91r3MhM2VPXS8IMIFu9TkCIHy6Wc6s2oCSZkCpYTw4KflyhZYTAXau7IcCIiGq65PhQb
	UHIfe0+MXmwrzfSgnAz7llGEdfmEK+g23CU3PJYApU6X4WOkpEi9gcK2d2kIPs1zGsoP+5uGrbr
	FCeGmv7VPz/OZHQAAwOQ==
X-Google-Smtp-Source: AGHT+IF/p/y/kl1yM86joGXG9jG/grAJ6/PcF91F297eKjLjiVmKHBpD6HoiFcTcH44dMX7EBNIOag==
X-Received: by 2002:a17:90a:d450:b0:34c:f92a:ad05 with SMTP id 98e67ed59e1d1-34cf92ac1ebmr5215054a91.11.1766046895285;
        Thu, 18 Dec 2025 00:34:55 -0800 (PST)
Received: from localhost ([2a03:2880:ff:42::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dccd14sm1774089a91.16.2025.12.18.00.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:34:55 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 13/25] fuse: refactor io-uring logic for getting next fuse request
Date: Thu, 18 Dec 2025 00:33:07 -0800
Message-ID: <20251218083319.3485503-14-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218083319.3485503-1-joannelkoong@gmail.com>
References: <20251218083319.3485503-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the logic for getting the next fuse request.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 78 ++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 50 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5ceb217ced1b..1efee4391af5 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -714,34 +714,6 @@ static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
 	return err;
 }
 
-/*
- * Write data to the ring buffer and send the request to userspace,
- * userspace will read it
- * This is comparable with classical read(/dev/fuse)
- */
-static int fuse_uring_send_next_to_ring(struct fuse_ring_ent *ent,
-					struct fuse_req *req,
-					unsigned int issue_flags)
-{
-	struct fuse_ring_queue *queue = ent->queue;
-	int err;
-	struct io_uring_cmd *cmd;
-
-	err = fuse_uring_prepare_send(ent, req);
-	if (err)
-		return err;
-
-	spin_lock(&queue->lock);
-	cmd = ent->cmd;
-	ent->cmd = NULL;
-	ent->state = FRRS_USERSPACE;
-	list_move_tail(&ent->list, &queue->ent_in_userspace);
-	spin_unlock(&queue->lock);
-
-	io_uring_cmd_done(cmd, 0, issue_flags);
-	return 0;
-}
-
 /*
  * Make a ring entry available for fuse_req assignment
  */
@@ -838,11 +810,13 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 }
 
 /*
- * Get the next fuse req and send it
+ * Get the next fuse req.
+ *
+ * Returns true if the next fuse request has been assigned to the ent.
+ * Else, there is no next fuse request and this returns false.
  */
-static void fuse_uring_next_fuse_req(struct fuse_ring_ent *ent,
-				     struct fuse_ring_queue *queue,
-				     unsigned int issue_flags)
+static bool fuse_uring_get_next_fuse_req(struct fuse_ring_ent *ent,
+					 struct fuse_ring_queue *queue)
 {
 	int err;
 	struct fuse_req *req;
@@ -854,10 +828,12 @@ static void fuse_uring_next_fuse_req(struct fuse_ring_ent *ent,
 	spin_unlock(&queue->lock);
 
 	if (req) {
-		err = fuse_uring_send_next_to_ring(ent, req, issue_flags);
+		err = fuse_uring_prepare_send(ent, req);
 		if (err)
 			goto retry;
 	}
+
+	return req != NULL;
 }
 
 static int fuse_ring_ent_set_commit(struct fuse_ring_ent *ent)
@@ -875,6 +851,20 @@ static int fuse_ring_ent_set_commit(struct fuse_ring_ent *ent)
 	return 0;
 }
 
+static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
+			    ssize_t ret, unsigned int issue_flags)
+{
+	struct fuse_ring_queue *queue = ent->queue;
+
+	spin_lock(&queue->lock);
+	ent->state = FRRS_USERSPACE;
+	list_move_tail(&ent->list, &queue->ent_in_userspace);
+	ent->cmd = NULL;
+	spin_unlock(&queue->lock);
+
+	io_uring_cmd_done(cmd, ret, issue_flags);
+}
+
 /* FUSE_URING_CMD_COMMIT_AND_FETCH handler */
 static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 				   struct fuse_conn *fc)
@@ -946,7 +936,8 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 	 * and fetching is done in one step vs legacy fuse, which has separated
 	 * read (fetch request) and write (commit result).
 	 */
-	fuse_uring_next_fuse_req(ent, queue, issue_flags);
+	if (fuse_uring_get_next_fuse_req(ent, queue))
+		fuse_uring_send(ent, cmd, 0, issue_flags);
 	return 0;
 }
 
@@ -1194,20 +1185,6 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return -EIOCBQUEUED;
 }
 
-static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
-			    ssize_t ret, unsigned int issue_flags)
-{
-	struct fuse_ring_queue *queue = ent->queue;
-
-	spin_lock(&queue->lock);
-	ent->state = FRRS_USERSPACE;
-	list_move_tail(&ent->list, &queue->ent_in_userspace);
-	ent->cmd = NULL;
-	spin_unlock(&queue->lock);
-
-	io_uring_cmd_done(cmd, ret, issue_flags);
-}
-
 /*
  * This prepares and sends the ring request in fuse-uring task context.
  * User buffers are not mapped yet - the application does not have permission
@@ -1224,8 +1201,9 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
 	if (!tw.cancel) {
 		err = fuse_uring_prepare_send(ent, ent->fuse_req);
 		if (err) {
-			fuse_uring_next_fuse_req(ent, queue, issue_flags);
-			return;
+			if (!fuse_uring_get_next_fuse_req(ent, queue))
+				return;
+			err = 0;
 		}
 	} else {
 		err = -ECANCELED;
-- 
2.47.3


