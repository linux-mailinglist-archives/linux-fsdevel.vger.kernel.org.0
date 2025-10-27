Return-Path: <linux-fsdevel+bounces-65801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBBFC11B45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 23:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12150560E6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 22:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571B732E128;
	Mon, 27 Oct 2025 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIqlrcvx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C99632C93B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604185; cv=none; b=YlHXmOC8DOuQDAZqzKyGZ6+jgGJBzB/FztoKgpBglN/3gMHwRWfIjb5lsotnLWOn2RYRy/INpyvwNDNqjmtQ7QUlKRRuvMXL8oYQN1zF9Iu4meMM98mCqNWbUD4pKCJQXO1SHGmN+bGxteKWpuu95FRCBW146DGGR422QZJYDgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604185; c=relaxed/simple;
	bh=a8Xvf6Akb/0UAtntnjY56r2wOTj02LSuPQ6VO28ehPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PK1jpAAhWVpBcFWCcJ7lKv4w3GDC7A6+UJsADNRpmIdg0rGaWRPZpgS4xI5Z9NF9LnlhvaP9I/qk/cXI3+KY8WbDkgF2wxE/df0gzpSAJrobUyjbGSX1ZhYca/VItnaK/hAHTpYmtpdALH0ERLmTobapenV/LluG74XDzinzQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIqlrcvx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7835321bc98so4320836b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 15:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761604183; x=1762208983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyyj5i2y7JkfomgY9crx/UaylieHjS5Kuhmhd5mkxmc=;
        b=iIqlrcvxhZyUtK2u2cBuNkhAoqL2j1y2/HiMWx0b95Mv0mezlnjQxpGD2iictmCNBL
         HzMnvysHY1hzsocaseY8heA2Bbe6Hdgr8pdIeQZ+iIMHf3PLhWZxubKGBVXQZ4WQIFbO
         qNvoqlN2aosQJYmoIqWe8rkd5+KS073ui7pTIqfDQB8HTDt7vvN0D1tYMV8//oARTQJW
         w2Zc3k/fpR+qYdBCciVqFm2dSgQllMGD3LpM6KWfCbl8mGVuuShHgHvf/IvklMM8unRT
         K6RwqFfbFusd0bTRxj+HsnqOTMA8J1CxW4bday4jjm62o80vDq1UwPfnnuW5hyHNwVF5
         /qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604183; x=1762208983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyyj5i2y7JkfomgY9crx/UaylieHjS5Kuhmhd5mkxmc=;
        b=C6GFihSNzOyeCE46MnKrefK4/ffQr7WY8ksFFmYovj0u2PRdtSO7g7BW6uBlp0/+WN
         O8vyzdreXBjOFJFr+hKZ8e4B4ftdX0HtZsOOUnY55M3aoZ3GcOLrIwShsoYcRx59DW9e
         iu3alb5JFD4YEPQyB8O+8rBABY/FCIOBj6/S5hgmVhInyjLKvdgXFD4+szA6VuwFGUM2
         +yGNtIzDn+dLMrRLdmUPLFwWj2C457t0FnH9L0IqhxeYc+ra60ZfszgF4FJNIq+Aryrd
         p/Aw4+3Gk5R4GakW0bv6KcSqkkQHuVQkQUhtosA3nknNnC1ondC8WGznqYh0+YEnr0St
         gIcg==
X-Gm-Message-State: AOJu0Yyml/bKtZQyN5Qu2bKjLxsvbeDgX6ykd4SHXW26UnN/2kPqYozh
	8WiNmxeg99n3giHJI/zqvA3D3dZsx/QJGL6/rKLSxFiuiM582VBFHT1h
X-Gm-Gg: ASbGncvNNY0j44VD+nvZNob9wxdD/xas0thrd+MxbSfaK6sAjoxjU6LjCMTXDjvl23R
	l28ldc2Zhbk+6f6Z5UzUlTndXTkdMB7RF9AZS+ASdG2yhp7NV6czA9tlG68rnjSGGT1o8W0xK0u
	/C5MXc9W6i1WW6hDu2x+Tz8u6Lm4ELOTVZYGXnEC04KrVTQs+i6J+sjP7yjDpLhCKQQz+QKct6R
	i1pYVTp/SKg4P20SvwtolQErf1Q6AizcTidbqtffsOL4PpohKNa72swZCzH2oSSQdbNtPMNZJma
	LrPoBq6NUnUb8LvBEIcDyoy+zXLO4m1TDRTdtCeriy7cRuEsoGgvlUFWvG9zpgHD2LT78xMtYg0
	7YqDb59f2hbabKQc7DSggzJbZSjtSVfYUphOq/r4yzG0cJq50t3bnnY2kVhhMzVRhLHW2cChKvw
	H518ccvGT1HOs/EJKUVuAgTosfpXQ=
X-Google-Smtp-Source: AGHT+IHoh/43f0u5NSEpsZFpEovANsgo5rNsNeWUaZqS/IupsEJqn4l3cJLrlRcX/4wib6Z5YoUTHQ==
X-Received: by 2002:a05:6a20:2588:b0:343:72ff:af80 with SMTP id adf61e73a8af0-344d4907334mr1564499637.58.1761604183541;
        Mon, 27 Oct 2025 15:29:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712791576dsm8338792a12.12.2025.10.27.15.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:29:43 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	xiaobing.li@samsung.com,
	csander@purestorage.com,
	kernel-team@meta.com
Subject: [PATCH v2 2/8] fuse: refactor io-uring logic for getting next fuse request
Date: Mon, 27 Oct 2025 15:28:01 -0700
Message-ID: <20251027222808.2332692-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027222808.2332692-1-joannelkoong@gmail.com>
References: <20251027222808.2332692-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the logic for getting the next fuse request.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 78 ++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 50 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index f6b12aebb8bb..415924b346c0 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -710,34 +710,6 @@ static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
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
@@ -834,11 +806,13 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
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
@@ -850,10 +824,12 @@ static void fuse_uring_next_fuse_req(struct fuse_ring_ent *ent,
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
@@ -871,6 +847,20 @@ static int fuse_ring_ent_set_commit(struct fuse_ring_ent *ent)
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
@@ -942,7 +932,8 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 	 * and fetching is done in one step vs legacy fuse, which has separated
 	 * read (fetch request) and write (commit result).
 	 */
-	fuse_uring_next_fuse_req(ent, queue, issue_flags);
+	if (fuse_uring_get_next_fuse_req(ent, queue))
+		fuse_uring_send(ent, cmd, 0, issue_flags);
 	return 0;
 }
 
@@ -1190,20 +1181,6 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
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
@@ -1219,8 +1196,9 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
 	if (!(issue_flags & IO_URING_F_TASK_DEAD)) {
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


