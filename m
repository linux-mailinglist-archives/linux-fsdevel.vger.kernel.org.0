Return-Path: <linux-fsdevel+bounces-45379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 538DCA76C9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 19:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5561A7A465F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A96215073;
	Mon, 31 Mar 2025 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTJINWJR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0224E1DF270
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743442607; cv=none; b=kMGL1GNvrbmU/wrWGSTNlGfXH0y6x4QrkZNMIdAy/mlfzpgkCKzJQHXGp0ReFZqErATSNswWBErLDhPUzbbS5mySu+gqw1mc1kY2kCdwLiYQkMIG8X0w/7IN+8kWCXMO1J/9O+VLOcftlwJK1md12sqfrJnbqcz/Vsqo8Hv5PXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743442607; c=relaxed/simple;
	bh=zyvtuCmcRMhTWypB7AR+uVmJcGhENlboVLFjpvkxJ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQFvfUKBkefvAAQIXOuFDYoJqtzNRJYNy3gYCQFSrNu6heMGbBczroB543Y2q7V/f3d4SUOnqDrpk5tMaqNl0C+QeteBP+JP0a7gGxlCr2da3nR4DsSreFxArfVEw8rXOVUtinzpBuJdh9AqeY1cApeXXL1Vm6W/AWDeE6wrV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTJINWJR; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso3892173276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 10:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743442603; x=1744047403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CqlXJO8zAVBoHffmuW1fiD4O94qu5RKH8ImDdOEHU8E=;
        b=TTJINWJRGlYD9/L4nc2c2abTj49J2ivhK0/LTlO+K++n/gLsGxII3ZZ7lKEF9ulbH5
         wWutLnEJ79XNlXuraLQAzMA2xb0BIR8wcoU12+ejl2cgI6lSIVgLkWO2SXALmcO9WOIW
         UlAXMwo/8m0rlCrC/Cn2KPLcm9b14nmR5B0JSzl4ADGp88Sgam9+qmO5JvYOYDolTKRi
         HPoyjsFgLhcnZyr7AIc8RecsII1wvZUiGW7XmK19IXqOdRyUcm7vd17oP1XUPCXK3vdw
         DK0lNCg+ZqKTYS73V/60jhUBDOYU6fYFdPLwQIj+520Ilp3FKWpIJDSph2WkrzMvUiLF
         vmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743442603; x=1744047403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqlXJO8zAVBoHffmuW1fiD4O94qu5RKH8ImDdOEHU8E=;
        b=TrGTfw2u8shGbQRDZMkFW99V3L+a9n2foenOL7CI44TlhT2n7boifK8zrtT3iNsEfj
         CNe2B6oJv9Y3x2xJVOiR6nxr5CPvVZ2tVNJh+V8tgl6dJVXwgtiw9mmbdSlx6Cq02UxS
         Yr33GweCYuoZEZJlvoiSMkWuGEXml4njNa6jWnbScTc2MNctPZV4bCGuKEGY8nwymRsl
         BIT78qetmkdegd9Z9C9uYrHy4acBPUnb/X3EUYKey00oHALdoMaKfMId545GGO3MnXaX
         9uTpB/+nhs0TNUMRse/scYxPJ00g6iTKFkQ5JD1vRvd+wJ2pueZaFH6SrDszHWiLpe4u
         MjXg==
X-Forwarded-Encrypted: i=1; AJvYcCW8BDjxUikS/nRU0yhbBNjUQsIgj4ZPM1WMN+6UMDJcOL5t1rgjeLgl53lYu0m5eVihHGrUz504Cr/N+Bc/@vger.kernel.org
X-Gm-Message-State: AOJu0YxwO8JwwXM8Mt+5+mnZMe4cLSdSGj4PwF0n5rEDnZDTIECunsQQ
	HsX7XGpTQMQsLyvaqqz1OZgQS2gqYfFwSZnENPW4/iIjHQQwBqvM
X-Gm-Gg: ASbGncsUFyYGegM8OXCYBnK94MQN9bqvKltqYKLj91uZlW9OklBGUvZef/UPs9J4ZNP
	6SbeW+ayCbj+bXIYqg5e+U2O64DgmodXDz5ZmKdOPCr7I3wP7H+FWZflc/22YmbQ+rrH2AeTfOi
	2Vr6BfMR5aNCUVfqxBlJRDjuI9YFp+634r3eqQ3RXNncVAPdcvRbdi1djRPBHAbWOH8DjLwE+e5
	11OpLi1HDE/OQ2jZjxDIRM2d9cNDykMP2ljiQgslKa1+fa3TC9h8bpYqxdwc69YZPLYQegw28Ft
	I6nPp3i/NfyasOcFLanMP1x+bLmL03Z6q6piQuobpQ==
X-Google-Smtp-Source: AGHT+IHk6aWCFGHXE5h9KrwOJX6QjDf7ywP500620xCPyLlc5cgbphTPkgNEJ16zMjZmmB6z5JfAIw==
X-Received: by 2002:a05:6902:168f:b0:e60:5d76:f79d with SMTP id 3f1490d57ef6-e6b83afd0demr12658918276.43.1743442602739;
        Mon, 31 Mar 2025 10:36:42 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e6b71352689sm1946350276.57.2025.03.31.10.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 10:36:42 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	kernel-team@meta.com,
	Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH RESEND v2] fuse: optimize over-io-uring request expiration check
Date: Mon, 31 Mar 2025 10:36:22 -0700
Message-ID: <20250331173622.2788500-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when checking whether a request has timed out, we check
fpq processing, but fuse-over-io-uring has one fpq per core and 256
entries in the processing table. For systems where there are a
large number of cores, this may be too much overhead.

Instead of checking the fpq processing list, check ent_w_req_queue
and ent_in_userspace.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>

---
Changelog:
v2: https://lore.kernel.org/linux-fsdevel/20250203193022.2583830-1-joannelkoong@gmail.com/
v1: https://lore.kernel.org/linux-fsdevel/20250123235251.1139078-1-joannelkoong@gmail.com/
* Remove commit queue check, which should be fine since if the request
  has expired while on this queue, it will be shortly processed anyways
---
 fs/fuse/dev.c        |  2 +-
 fs/fuse/dev_uring.c  | 26 +++++++++++++++++++++-----
 fs/fuse/fuse_dev_i.h |  1 +
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 696ab0403120..3055af8089d7 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -45,7 +45,7 @@ bool fuse_request_expired(struct fuse_conn *fc, struct list_head *list)
 	return time_is_before_jiffies(req->create_time + fc->timeout.req_timeout);
 }
 
-bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head *processing)
+static bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head *processing)
 {
 	int i;
 
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index accdce2977c5..43d77a2c63de 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -140,6 +140,21 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
 	}
 }
 
+static bool ent_list_request_expired(struct fuse_conn *fc, struct list_head *list)
+{
+	struct fuse_ring_ent *ent;
+	struct fuse_req *req;
+
+	ent = list_first_entry_or_null(list, struct fuse_ring_ent, list);
+	if (!ent)
+		return false;
+
+	req = ent->fuse_req;
+
+	return time_is_before_jiffies(req->create_time +
+				      fc->timeout.req_timeout);
+}
+
 bool fuse_uring_request_expired(struct fuse_conn *fc)
 {
 	struct fuse_ring *ring = fc->ring;
@@ -157,7 +172,8 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
 		spin_lock(&queue->lock);
 		if (fuse_request_expired(fc, &queue->fuse_req_queue) ||
 		    fuse_request_expired(fc, &queue->fuse_req_bg_queue) ||
-		    fuse_fpq_processing_expired(fc, queue->fpq.processing)) {
+		    ent_list_request_expired(fc, &queue->ent_w_req_queue) ||
+		    ent_list_request_expired(fc, &queue->ent_in_userspace)) {
 			spin_unlock(&queue->lock);
 			return true;
 		}
@@ -494,7 +510,7 @@ static void fuse_uring_cancel(struct io_uring_cmd *cmd,
 	spin_lock(&queue->lock);
 	if (ent->state == FRRS_AVAILABLE) {
 		ent->state = FRRS_USERSPACE;
-		list_move(&ent->list, &queue->ent_in_userspace);
+		list_move_tail(&ent->list, &queue->ent_in_userspace);
 		need_cmd_done = true;
 		ent->cmd = NULL;
 	}
@@ -714,7 +730,7 @@ static int fuse_uring_send_next_to_ring(struct fuse_ring_ent *ent,
 	cmd = ent->cmd;
 	ent->cmd = NULL;
 	ent->state = FRRS_USERSPACE;
-	list_move(&ent->list, &queue->ent_in_userspace);
+	list_move_tail(&ent->list, &queue->ent_in_userspace);
 	spin_unlock(&queue->lock);
 
 	io_uring_cmd_done(cmd, 0, 0, issue_flags);
@@ -764,7 +780,7 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
 	clear_bit(FR_PENDING, &req->flags);
 	ent->fuse_req = req;
 	ent->state = FRRS_FUSE_REQ;
-	list_move(&ent->list, &queue->ent_w_req_queue);
+	list_move_tail(&ent->list, &queue->ent_w_req_queue);
 	fuse_uring_add_to_pq(ent, req);
 }
 
@@ -1180,7 +1196,7 @@ static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
 
 	spin_lock(&queue->lock);
 	ent->state = FRRS_USERSPACE;
-	list_move(&ent->list, &queue->ent_in_userspace);
+	list_move_tail(&ent->list, &queue->ent_in_userspace);
 	ent->cmd = NULL;
 	spin_unlock(&queue->lock);
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index b3c2e32254ba..20f7c10102b2 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -65,6 +65,7 @@ bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock);
 
 bool fuse_request_expired(struct fuse_conn *fc, struct list_head *list);
 bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head *processing);
+bool fuse_request_expired(struct fuse_conn *fc, struct list_head *list);
 
 #endif
 
-- 
2.47.1


