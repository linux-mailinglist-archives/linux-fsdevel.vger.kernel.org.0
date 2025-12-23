Return-Path: <linux-fsdevel+bounces-71901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FEECD784B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42AB5304A100
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B185C1FE45D;
	Tue, 23 Dec 2025 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndOJ7X3l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889B71DF736
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450210; cv=none; b=NZCuX+7f9eBsDQw/W3KeNx8SHkTSDqDVuuzwYSDPc6CHXvYB8wQL1obXIsxNPnRmxPUvZLsx4i8Y+pyXjK18sqUaTixU/vvR6iBp/heuH9DMAaVnUZPCLzq0yNqSvEF1gen3OghMhuwMQTe+9UDKllXbPlkimwYq50qKtEV/UAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450210; c=relaxed/simple;
	bh=I4PCjUhCFFP1GB1VqUWFB+sDj0RF8PYOH5kRYPwdMU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihX10TMX6q74h546ljn3vy6gqg2w39lL70jArFD5TugKfNsj9vqRuzi8vcDdbwRB/EXhcin2FiQTXIt9T9YMe4zeOPsGl+Zgx2XOKnfpuV79uuXsBdUAaq2gcwPwsnIGdh835XdC+XwhGZjoqlYpuGbxqrw9q4EgNDD2ckjjEE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndOJ7X3l; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso3733706b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 16:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766450206; x=1767055006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g67IYzmx504GLKJLdQ6KeR6Js5spiNZKZTk6IyeAF4o=;
        b=ndOJ7X3lkazLLB5T6iJ18y5gMUZX+EUkSk8oET20oJb44t7DbL8TAVdiCz4BFetVeD
         ErLw4i7CWa32cJZt1H8ZgUA09XThJ7CmZ1uMcTS6JvEGMZBhuDu1ZpouB7fBB3eaWypk
         ES/SoIjbWAIl2ucJ90ro+1LsBikOb7lsCuDv7NOO3QIbCJunOGKRIHLOg7ueB2ECaEgh
         sTuepEnnZ9y/RvFnu+t+uf20BRqD6M96KeUkZbnDnY9Bcn31QMO4JbckUfpzu4CvCyWn
         PgwIvqyx1HT8fjX4IWF0Hlgmef24CWUrROXMj2Zxrd8dKWsRHtQLXsQJ662ky1WymSII
         dcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766450206; x=1767055006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g67IYzmx504GLKJLdQ6KeR6Js5spiNZKZTk6IyeAF4o=;
        b=UsGVApj1ZzFmQsiiC7HtKLQB9Kfr1ND7UAQel8iYyoEDXqQSckev20bb1kgHUuKDBQ
         5ZMwoH0VL6h6MCVrxcDSk1Grqj59AdzxbLPJs1hJtXDpPmTx1vfhttRavBvQi2ZXAmO/
         TBXTKSryLF2bK6PN04qpwVhYeakTWIEbc13t+wF8InbNXDOYIVcIWCxt63RzIk5fTVvy
         ic9iIMJpI67ceRCixD/DbXr+pSF5FAFkw5mIi3I6NihPT055FuUreGC3trK5TasTOmGg
         QUXUaRnLyd8H9emI1HUQf4BrW2AEbnpyNishL+XjpE7HuqTp/vneLXGQmZfMMsud2KPt
         itUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxQG/kCLwvhIOFWoynSOKdwDC1dUWCfz2AxroLmH8MQo/1Z+b/4VbSd13tciYzped7PThpigSnZjKIrS0P@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8DrG6FoUORjTV6FLqhdKW5xGXCNOBSxcfNQnSTbXGiqNqTxDQ
	8zkjMc6Fby+NOogYJ7nlxvFUqAkzhHVPKJOSvKyvG3iyTY8XbwtU9QyK
X-Gm-Gg: AY/fxX7Hw/jFckhhqJZGEchqpRoZ9+lhDucGgHph4xiSBw9Wk384cTx6wXFAH3QmnFG
	EXrGyC4tEq0K3g/yB7R1K7RlEVxVZSqwa4DhOKdzHzjy3PRBOQrwXMddwv0LtqmAbNLWahY02iS
	9xF+fpDvt/AiZUaSP/hTHZw0Nh8JD0BFeas2U0nyTz8OsFM53hBVz53WdBg9zths/a5hE2iOIbP
	2zur4nLNHZYxCDf2jHmjAakQW9IurvSJaYwzmCtD5w5bO30Pk285WEb+XjyMBOwSpDzq0dMdXMO
	a/haHvkiYaOXo05AQAo5gXH8HKBiYwk+PjKoREZU8AyUIqxHG5nX+9Lfsj1T5PhAjimb2vN9he8
	/n7Eyjbtr0RG11GtLkrwq75Q2GhDn+V8H9Fb1DV7S3aQna+68tjRFaE8YY1pGsf/eFVkbKW9ji3
	/5rk2oJyin1jRKL/0fGJUsO3MQVJf7
X-Google-Smtp-Source: AGHT+IHJpkmBRKq5Hh6VMxIgjdednIBQpwnsYQEJizs7Dwe0EIAKbTjb73hdhO3a3piwfpc/zRbqmw==
X-Received: by 2002:a05:6a00:3286:b0:7aa:3fed:40ff with SMTP id d2e1a72fcca58-7ff64116e68mr11530579b3a.13.1766450206497;
        Mon, 22 Dec 2025 16:36:46 -0800 (PST)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e797787sm11558631b3a.60.2025.12.22.16.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:36:46 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 13/25] fuse: refactor io-uring logic for getting next fuse request
Date: Mon, 22 Dec 2025 16:35:10 -0800
Message-ID: <20251223003522.3055912-14-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251223003522.3055912-1-joannelkoong@gmail.com>
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
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


