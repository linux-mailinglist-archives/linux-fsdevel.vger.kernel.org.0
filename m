Return-Path: <linux-fsdevel+bounces-70509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26423C9D6C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345CF3A71B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CE024BD03;
	Wed,  3 Dec 2025 00:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTb7Q3Jc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778F6220F47
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722216; cv=none; b=ZJaWBlNdZRkXDECmyIhNyC/JAO/Oc43I9jsQ3bruQjgQhuqgBMxB3x81VSM1QJQ8HYFWufBV8xgz4oXugVyKJfECBuwJXCcevwBau/qbsQEuEegqs4ZniofZup5PmWhJ62SQP44t6oxG/kF+MiO8DkClL5ixDO7D5v0Ik7tE9jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722216; c=relaxed/simple;
	bh=I4PCjUhCFFP1GB1VqUWFB+sDj0RF8PYOH5kRYPwdMU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B62sHmUJfM2MGjA8EsAb+zrT1cQTy9nmg4XGjjITQb02suCTEXAJFE/PYpeJBatwfb37RDVQWlcg/tTwJsy2KsInMWBtupd9uMhrPrllDsWWLzxM4uHQU4HWTLe0x6hBMcI/A6CkI7JBWuiMi0JHkfs1FcFxHUL64ly457QBR9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTb7Q3Jc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34361025290so5027599a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722215; x=1765327015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g67IYzmx504GLKJLdQ6KeR6Js5spiNZKZTk6IyeAF4o=;
        b=JTb7Q3Jcmn7awzSe2c95jwvLWvwWlfXc7tAPR8krVKN90P4p4pIGJiVuLlJ5F9xg4t
         TWK/+atw/+fu1W0MOnwfbTcNdo2TZVPdcxCPVg2R06Zq838wnxPBbtIZPQsiXBgIPufw
         r26Z5F8QZ8i4Rb4fGUDVFW0uFIXkmywfblJot0Dvs8b9c/DvCt9UoWXAd4TRVfinOpcz
         d71FeUEoNpjQHOwSpM5du75W+i50hj8sFoOIKTuiEeXtv+XP8b+pYCo+Cez1C4xUpCHb
         Fifjz2G+9ipbU7G+tUaZjUV0wNCQEsNo3JQFhyIzcm80Yx6bcQMQ3QlwbbfSjvHETQq2
         f63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722215; x=1765327015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g67IYzmx504GLKJLdQ6KeR6Js5spiNZKZTk6IyeAF4o=;
        b=H/s/glfjTGxn+68ebsZbiv7S96XIFwstF8GJeEJT+FkHOSLe89+HBNyVridocD7tEH
         l5Gekug9QC2/1K2ZN+e46k/aKjlqFLAUYRx/4I157KQpAztbOSV8DZIorwkK4hBtnUti
         K3JIvzf2tpeKSXAEuhVy7CDMq8/ust7YpsBEac0wxLD9O9JMymXNN5RP81l/AtGZrR2F
         RimxGqK1NdU++5EqEV6wl2TDUwCh1/Q0vdmaxyPmw5PeoNu95olZ18hRJ76P9VZFup2N
         i7u6V5yw44lJDY919JK2nFfKIBPxuJAI3mcfMnuUchWYI4KDY48Mmthyo1KSKWiQC4gX
         PDNA==
X-Forwarded-Encrypted: i=1; AJvYcCUzxRc00JjeXXn0SQgCPDyigOeJJUpF7KaPiWfYyACh9zFmEr3uEoDd7rf5S+p+mbCs/Bp8icT71Ryl8MAh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xKyBjgnMpFRrNJc/oTb8+7tzwnyq1CtfgyUfMdCHAn13Rhyu
	75X3ly5rHDdKTbcbcEQExcKzDnG6COUJkIdGvVc7uO5+h57RLgo1nlUV
X-Gm-Gg: ASbGncuOEfYNLjDXAFAjer/sknKuw/3WPzn20MAv3whwX1GaW3WuMlZOYcoE83MMY/b
	S5NXyuF7QjGoNoSLjjYuASdQ6Aom49yvLSaimJ98R0lTP6yKNlA3UMOoLzLx4W2WhzKeTrdGNKo
	Jj0durYxgZ2uQNfSn1TKZOC/8HQfUGXuI3W3xholCyUyqYmW6Bt/ovmDet4gwp1KN1y0p3Avwo+
	mL4IiawwzRE4kUblGZnZZcyRBrBFmrmHcYcmSRDV/bLrsU9Vmf+WYpeI2/200YxNEDOV2EvmVUd
	02y5LZUPPxh5aWzF2cvfvcvT3W+G0khtHESyvFNzjVF5G6iIiYYLjd96+AtCDNvnW4NkI759tgl
	iS3y1gXeCMPOAKL6q035oQz5Ap6bRhu7WQWykNoIjj9XLjZfFwVj4CAlG07BV4rbKqmZQhXTKEd
	yx2us2tsJJhcrC/jjUMQ==
X-Google-Smtp-Source: AGHT+IEmMrKmYau6ubCLOnd41tW/2v1wfGh90/z9/DwV23To9h3XaBWAdOeePVBvtUlGw5F6XI1+Ww==
X-Received: by 2002:a17:90a:d2ce:b0:340:bc27:97bd with SMTP id 98e67ed59e1d1-349125fb0admr522039a91.9.1764722214878;
        Tue, 02 Dec 2025 16:36:54 -0800 (PST)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34910bd6665sm633512a91.12.2025.12.02.16.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:36:54 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 15/30] fuse: refactor io-uring logic for getting next fuse request
Date: Tue,  2 Dec 2025 16:35:10 -0800
Message-ID: <20251203003526.2889477-16-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203003526.2889477-1-joannelkoong@gmail.com>
References: <20251203003526.2889477-1-joannelkoong@gmail.com>
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


