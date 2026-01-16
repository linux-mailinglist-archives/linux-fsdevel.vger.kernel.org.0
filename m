Return-Path: <linux-fsdevel+bounces-74262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A54D38A19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E615301667D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1F917993;
	Fri, 16 Jan 2026 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoFWgfgQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A250B315775
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606289; cv=none; b=au2jB3RT1iyzhPX6hxMRngsVV3NthvcCatm9Mg4unrvjB2wX07F+uYjoH6/pqRK8i9UZ4/ORbQiqmLa9MgPDi82iRKQUSR2dg6RTFWXSLL+2eId9v1+u30Gq0oflzeFio7UhGI6AfKvl0OxM3Gw7svUjmsKVlYaQMOvYLjTsPtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606289; c=relaxed/simple;
	bh=I4PCjUhCFFP1GB1VqUWFB+sDj0RF8PYOH5kRYPwdMU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHlqWulbTwJ+C8y+rPZuh2GJjr6tC5XBxiK2wpI9Bo8nDK2VlQlTutkt56F/cFys2TaEc7q+DschYNdO8TtEF/1eiAd6Xivfh5DI+r9hoDNF9PU8TuB5BSyOqqi6K966OgTwoWnO5FrIK1hB2xir1UBMwHAoWxyMSAAS6ipOdvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoFWgfgQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81f4e136481so1232610b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606287; x=1769211087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g67IYzmx504GLKJLdQ6KeR6Js5spiNZKZTk6IyeAF4o=;
        b=UoFWgfgQKrXm4hf3nr1+vIbJrpKUSEWPpyBLWbjhfDbKtFZk/jytABE4ykK7CB014q
         oXlpcpCh6KgATyAcb27S6GHrOqIp860DbhkeCgCce1lR7180fUsaRP02yxdTiq/DvUiT
         28vhECbB/840330yWuLsIUNg6PGM3y8Exxyd/KJeKiXLlqddvkG9ByzO+cVXCzx8Tfqg
         MrPIYbVCCzP4ZQqB3l0OhqVaDIhAI6s2t677GFknujuhfeTHg9Q4LLb4xB1eQ9xSP4BM
         a4Bjftn9oJXCT2B9ivs6m0oDCMf1n+HmrtxcO23VtIZMlj+QGoRUpgCZgBm9s2ELqEFd
         TSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606287; x=1769211087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g67IYzmx504GLKJLdQ6KeR6Js5spiNZKZTk6IyeAF4o=;
        b=D6Qtc85L/ou4llmB+Qq3AndYdQcPzxvnLIa6LLhJF5FwjmNnv1avVAtoylKgguNa8B
         8vsmf1GlXF6sGg+SSp5It3Vwi3knM0aygQk9uMIgarxlJdP21VFqA7p83fV8qTkItlh2
         p972t+IvKirmnOfID2Ly6QISJDNabMcJOx6B8QeSllFQevLIa78SGM/fegpINsO8c1Ek
         psfAYfQ0bpQSX2yaB3E5QTyJDXa6+FoI800F/NRbU+F4OM5eENREKy5XVpzKncPUkZ4Q
         brUmNMXqsr9oiLq3L2QRGBT/j2jbYQcFi6E3lGFwvtv+k7XDOreEllwDAkuXHhPhVXtK
         p6hA==
X-Forwarded-Encrypted: i=1; AJvYcCXhlOra++A5nPhqxnCf2435ZQPtVt8m9n7DkY1V3cvluHXYQTeFWYUMmIgvSyvRqwILwQ/7PfSi0BfnaLgg@vger.kernel.org
X-Gm-Message-State: AOJu0YwXAhaLdRTWfGO+s0WylxMZPu8JT2/IxJKfutYBtzs3V+xH64cz
	xvFlsEm5pHIzAW6ijE+vba1I79IlJw0GdY+OvlsRONjfSWH8mHKC8UIH
X-Gm-Gg: AY/fxX64ejD0XpHYMRPHLnaqiwhjII5Oy66nZD0PEhsweeZJfm0NHVEJaojnAwQMc3w
	RPmD4uv1w5Iv5Im4yQ/iyziV0HoruY5Zgo6rh9imJvqYZTcth9eehpaB5y0rpqTDf3+ZbmH2eBP
	z4gyRw/NqORXznYS+PqSOuN0WQ+rBSvk5dHu2Cvqnc7jFOIprQhRK9PYBqXHglSps94xNahmghX
	Wy09TVVHoMOmgl/w1MWnXjZ7gyMJGJJF0fp5HUvw8PP9DPuaFlaqmKngEkD8dppN/r9SHGSBh1y
	7IeBoKXxLotcAZLL25k5Radtnpm1T2dhnx9WG5zRat6UP91KxVshriEu+g1sWbuEFpecGvjD2lr
	L/t8PW16G+l4oZOOkIMRzpyBzHlLeVwN4mgnb+EGRcwdPD7Vb1Im2c+So2rIQ1RSXvIUgHTHsJz
	yYykcU
X-Received: by 2002:a05:6a00:1a86:b0:81d:70d9:2e96 with SMTP id d2e1a72fcca58-81fa184dca4mr4340511b3a.54.1768606286990;
        Fri, 16 Jan 2026 15:31:26 -0800 (PST)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12913cesm2916239b3a.48.2026.01.16.15.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:26 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	miklos@szeredi.hu
Cc: bschubert@ddn.com,
	csander@purestorage.com,
	krisman@suse.de,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com,
	xiaobing.li@samsung.com,
	safinaskar@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 13/25] fuse: refactor io-uring logic for getting next fuse request
Date: Fri, 16 Jan 2026 15:30:32 -0800
Message-ID: <20260116233044.1532965-14-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116233044.1532965-1-joannelkoong@gmail.com>
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
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


