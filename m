Return-Path: <linux-fsdevel+bounces-40653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1836EA263C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC89B7A2466
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F4713C9B3;
	Mon,  3 Feb 2025 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+qs+25a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590ED25A656
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738611051; cv=none; b=JWBGN+ka2XkeLcTtr2eIFYyuR0NBCVztI5XLrZ2wJqqi+YhvUhf7+CXO680KQHIpxFN/864LQ5JLk+equQmmdGBdDQhKzWLuczrTayxG+MR+cpF645XmaZolTgBDoGN+abPO1g8+P7hcOOj0xoaxCFnN6fMoJbyuSTwL89ZxvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738611051; c=relaxed/simple;
	bh=PQ7MNpkqZ1rH5tbEqvcspuc6jA9CJhgKuMSNVpaLj9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iiCe5yKUzN8gDQm5tPxgjYrP+7kuCS0cLFAOf48UucqXvB+2pj+zpjjN3QAd4Si55bbovZE8oAYK/IysYbrUfsMW9X7F2QUnWqy2l52pjUP2/VaHBDugH4e6zE26kWwxz7M5UIITi6Z0eTXqC5gFO9WfC/d9HA7nxrVqI7iT4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+qs+25a; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e587cca1e47so4982155276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 11:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738611048; x=1739215848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKjd5BtUwbtAO4znWzwS1MbxXFIXOwhKHPA6+ecBCaA=;
        b=j+qs+25aM8gvIEviiXTXV+ffVOt3aNaKuGLuV0ZKfYSZY2D9bJtVuLlYHVFAC5zJst
         1okn3y35cUiyiKOGZdn5GZaiEifrltMKcr2AFTbBH7RLkZmw/h7jOirdc8X2VUO4V0Ac
         WrAQBNUcGvGiCMA0WdFH478i9ErHTxOw3hwQLaNIbtghDrsN2GGiBAfo6RW3uJjfUaz9
         YjWbkRwPp0blnWH7ub5EiZRdHl/uRbTLudDJiRjYlzO02LBSU3bMDQeUFA2YBfY4CD12
         dSHg+QkUBUc3UVJwoB2lPXjNbCEONi334ehvZsxqJS04J1eV7LIGHc7qkkgStXaGtoJd
         nF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738611048; x=1739215848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKjd5BtUwbtAO4znWzwS1MbxXFIXOwhKHPA6+ecBCaA=;
        b=MBsVkyRg9TVU/vAQqmdlKHfqr+kyalvwhkmsKt/TmbhNMZp5IBm8ZY/LTDu+eQ7rn6
         sIfbK32nBDnY6ZUSAUwXMFMhMCfMbD3H330syc3k+/Vn1gW6onZpp5T/flFm5o5YZSdg
         yIYviKjQbd7vZddtsGhT4oMbG5GysVyPPN2is+HmtkOdpINeXbxrZOcf9741ltEQEzQX
         hkj+RNzA8hQo/abqz/c3kMDvt6uKDYlZszQXAuvCifxpZJsJbeS+B3dGzKG3ZCFEaKCr
         k7zNQwemcEskoyB6cJFyFPlMKS7qMP02H4HsKo1NeBgPr2j7pfX7OCO2u+EzsN0LVp8P
         VGwA==
X-Forwarded-Encrypted: i=1; AJvYcCUKpygyRZExgEgWD9KAHXn5M4SxYAnOyeJlPYVcMbVvDRzh6clfw6N2JjiiFwoMEWlrVDm+V64pdVo/L2aG@vger.kernel.org
X-Gm-Message-State: AOJu0YxTurgB3yjQSol8Qjza+N3hdZxxnEtguryWHmTleGRrEibnlsC8
	Z8a2qbqHrh2w5JKFN/dL/Keai/bA8tbLH5bK+Ck7TpjPWu95fQDl
X-Gm-Gg: ASbGnctiudvblA6FYExZRNLLOjWa/bkBvOe9KF0PdGArVV7Wo7wdlfKJJhCAkw4GToS
	xRjOchZNWZNB9GysRyV2WLFko1ooRciFvEbFYhEPyAWrGogXrI/PzmktSHzpkMgr6jPmcru7/RI
	9iN0pJvtm85jOH1KlYfmuOHK/8Jc04G4EbMc0ZJkyJkIKx3OlglX32ywbjDwomoScOos5O7Eq2i
	eZCDccZZj7xCKzoPxbHATj7RPnwd/X1OOtw8q80Ql5jcRZ5RSOuoVGpVLVwb3HXOKNdpP52Egyy
	AtZ/djH4ng==
X-Google-Smtp-Source: AGHT+IHY1EPQbIysVRnle8pdxa2K5INr9mRJeKIs8eb6jP5YNLlDpTP/fGCWutrxn7CpKtHEga6EXQ==
X-Received: by 2002:a05:690c:3585:b0:6f9:72a9:f7cd with SMTP id 00721157ae682-6f972aa0451mr21895297b3.9.1738611048052;
        Mon, 03 Feb 2025 11:30:48 -0800 (PST)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f8c486e60csm22266387b3.92.2025.02.03.11.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 11:30:47 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v2] fuse: optimize over-io-uring request expiration check
Date: Mon,  3 Feb 2025 11:30:22 -0800
Message-ID: <20250203193022.2583830-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
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
---
 fs/fuse/dev.c        |  2 +-
 fs/fuse/dev_uring.c  | 26 +++++++++++++++++++++-----
 fs/fuse/fuse_dev_i.h |  1 -
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3c03aac480a4..80a11ef4b69a 100644
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
index ab8c26042aa8..50f5b4e32ed5 100644
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
@@ -495,7 +511,7 @@ static void fuse_uring_cancel(struct io_uring_cmd *cmd,
 	spin_lock(&queue->lock);
 	if (ent->state == FRRS_AVAILABLE) {
 		ent->state = FRRS_USERSPACE;
-		list_move(&ent->list, &queue->ent_in_userspace);
+		list_move_tail(&ent->list, &queue->ent_in_userspace);
 		need_cmd_done = true;
 		ent->cmd = NULL;
 	}
@@ -715,7 +731,7 @@ static int fuse_uring_send_next_to_ring(struct fuse_ring_ent *ent,
 	cmd = ent->cmd;
 	ent->cmd = NULL;
 	ent->state = FRRS_USERSPACE;
-	list_move(&ent->list, &queue->ent_in_userspace);
+	list_move_tail(&ent->list, &queue->ent_in_userspace);
 	spin_unlock(&queue->lock);
 
 	io_uring_cmd_done(cmd, 0, 0, issue_flags);
@@ -769,7 +785,7 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
 	spin_unlock(&fiq->lock);
 	ent->fuse_req = req;
 	ent->state = FRRS_FUSE_REQ;
-	list_move(&ent->list, &queue->ent_w_req_queue);
+	list_move_tail(&ent->list, &queue->ent_w_req_queue);
 	fuse_uring_add_to_pq(ent, req);
 }
 
@@ -1185,7 +1201,7 @@ static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
 
 	spin_lock(&queue->lock);
 	ent->state = FRRS_USERSPACE;
-	list_move(&ent->list, &queue->ent_in_userspace);
+	list_move_tail(&ent->list, &queue->ent_in_userspace);
 	ent->cmd = NULL;
 	spin_unlock(&queue->lock);
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 3c4ae4d52b6f..19c29c6000a7 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -63,7 +63,6 @@ void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
 void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req);
 
 bool fuse_request_expired(struct fuse_conn *fc, struct list_head *list);
-bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head *processing);
 
 #endif
 
-- 
2.43.5


