Return-Path: <linux-fsdevel+bounces-40019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B31A1ADAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 00:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D45C3A2533
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 23:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD301D5AB9;
	Thu, 23 Jan 2025 23:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJK4rPr4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE581BDAB5
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737676394; cv=none; b=PwGkqiNYKxzLuLtoBoFTF/HO5FJMS2+L4Rbr2lz7vwVuwNajsCxvtWxs1AaOHhJm6Ao9nMdJGUTmM+iQncd4oyudZ4jDVLqa7++/vxDghuSeNnVZ/oCQsfuR/rD4iP8et8HlTQd2ALlSToSN8QfCESrA6ZKUNjfdS4nJKXsRqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737676394; c=relaxed/simple;
	bh=dItczH8xCjgIBdMP0B0DxjT3jrx6jIrHcMrRAh9gufA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohY7LK4h4SQVGLc2a2DO4rNROcm3MzYcuuPN2GOnuNA9ZjfAO7AKoRdvuvDS1TZU3FeDSO++x3eReLUIgPThX4gjrgKQAL9JjQ3vJdGq6PDHKS+YjgKRHj6meLHxfiJZ60lmnM1CnCxeaEhqVIekbcyzly5spj6rethliSDpRtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJK4rPr4; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e46ebe19489so2141361276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 15:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737676391; x=1738281191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p16f8fwizrsUqDiaK4oklmN7p9+QV/wME/Xi61xxXE4=;
        b=bJK4rPr4i05uWlaMZwQp3SYaIICTzh4uy0HONH1YhYVKAMf+kLjJzzEldXWtnF0+36
         DYrtAYD7gl+U1uNPHtOV+uUwngy1NNt9NOSfzmP0DDzB4/86NLPpunN+GbFFK0eQXDo/
         dEWMHUf5rAzJw7uNAPeizjaQq/36BugJj/fdISAhz84iMQnnKzgKp6UbmDqHxBOTK2Yj
         f9fNm/D1TxEbOuVDkcih+DOB+FlhSEML2/zTEt0lRQFjfO2j6EUiYLA6pu/+OZ+7hH5R
         aBdA3nIfKDAUDR52Jdy8Jv71iu62QYFB7IUaqvxV1eWXKcJE65DhtjrNZ5rVm7AbyvlU
         udEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737676391; x=1738281191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p16f8fwizrsUqDiaK4oklmN7p9+QV/wME/Xi61xxXE4=;
        b=eKr6UYN5cS+WPJ+0Hfd5HShaF9FQmyjXfy+OZ9c1DPOyDetpxXDZPEwXZjOb3VQtN/
         h3OlnJPrmoMrjcUZ6vNUObaTmdvMCp1jiWO62E5zViaT+UTJH4ve+n8MEv3u30OTL87f
         wrlMW3KPqKuTLM7oK+M1f9gKqV3NZM6A7gsSMjccQGsaeRC+bDMFhpL+2jKu2h4Swy04
         1KzCJ0uMGIaBQxfOKpSRoCnl7LO7WAgVAiZFTK1KsjwbrVpavGN/eKVb5oYR+tORzwoq
         K1/fMsUWTjEG3qQaiszMKfInJEB2EuKSeCg8RMlS6emDO7+PxppUrqCPTqSl/TVw5gvC
         KMcg==
X-Forwarded-Encrypted: i=1; AJvYcCU+/Owtd/gZWYEiybkudrU6sRzpmKc3Ji5LkklpuFgfz93SYmFPjfMSyt1NwcjJRtemxKlZ15Q8N+DdiOBa@vger.kernel.org
X-Gm-Message-State: AOJu0YyqH3K2PytHTXDyfye1yIeYswfVVWXuMSKgPkodHDaMDmfhL+s3
	rDY7rB6g2SIBncoFXcX++M4aKoaYnBDtQxovF9BwRn67c70fiaOk
X-Gm-Gg: ASbGncvYewW6OshRWdH8LbYpfEeP3fBiES4sUpYWRM3cEU+tJTxnhYT+w9/Dj3yS9uP
	chmzYot99CaSiXZ8L823yAZfnpNmIbn24c5QNm09kcRv2GdeSvaQyvQNPXSmtEqLeXwkwjECkrn
	/5epLiOSw09nZ6CX5vaO9bSLKuTwenTBgNAmAEpvj3wJxAtcZYPfgAexaphflUIA85wma4kT3EP
	jSoeQFCVoUt5MgSITC6rS0nVOXi03QZ7AkV+sqdv7xEQnE050jPblu72yp96KOk/wD3afw5CwUo
	EYE=
X-Google-Smtp-Source: AGHT+IGA6kO1axOFbzWuvIJ915PdveEuCRsq2tqoUFwYlysssruaxrZQYGUefwFB+jybCiEvS4J3gw==
X-Received: by 2002:a05:690c:6c83:b0:6ef:4696:f1d0 with SMTP id 00721157ae682-6f6eb67bcadmr227847617b3.12.1737676391349;
        Thu, 23 Jan 2025 15:53:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e583b88db9bsm135338276.48.2025.01.23.15.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 15:53:11 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v1] fuse: optimize over-io-uring request expiration check
Date: Thu, 23 Jan 2025 15:52:51 -0800
Message-ID: <20250123235251.1139078-1-joannelkoong@gmail.com>
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

Instead of checking the fpq processing list, check ent_w_req_queue,
ent_in_userspace, and ent_commit_queue.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c        |  2 +-
 fs/fuse/dev_uring.c  | 23 ++++++++++++++++++++---
 fs/fuse/fuse_dev_i.h |  1 -
 3 files changed, 21 insertions(+), 5 deletions(-)

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
index 5c9b5a5fb7f7..dfa6c5337bbf 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -90,6 +90,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, int error)
 		fuse_uring_flush_bg(queue);
 		spin_unlock(&fc->bg_lock);
 	}
+	ent->fuse_req = NULL;
 
 	spin_unlock(&queue->lock);
 
@@ -97,8 +98,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, int error)
 		req->out.h.error = error;
 
 	clear_bit(FR_SENT, &req->flags);
-	fuse_request_end(ent->fuse_req);
-	ent->fuse_req = NULL;
+	fuse_request_end(req);
 }
 
 /* Abort all list queued request on the given ring queue */
@@ -140,6 +140,21 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
 	}
 }
 
+static bool ent_list_request_expired(struct fuse_conn *fc, struct list_head *list)
+{
+	struct fuse_ring_ent *ent;
+	struct fuse_req *req;
+
+	list_for_each_entry(ent, list, list) {
+		req = ent->fuse_req;
+		if (req)
+			return time_is_before_jiffies(req->create_time +
+						      fc->timeout.req_timeout);
+	}
+
+	return false;
+}
+
 bool fuse_uring_request_expired(struct fuse_conn *fc)
 {
 	struct fuse_ring *ring = fc->ring;
@@ -157,7 +172,9 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
 		spin_lock(&queue->lock);
 		if (fuse_request_expired(fc, &queue->fuse_req_queue) ||
 		    fuse_request_expired(fc, &queue->fuse_req_bg_queue) ||
-		    fuse_fpq_processing_expired(fc, queue->fpq.processing)) {
+		    ent_list_request_expired(fc, &queue->ent_w_req_queue) ||
+		    ent_list_request_expired(fc, &queue->ent_in_userspace) ||
+		    ent_list_request_expired(fc, &queue->ent_commit_queue)) {
 			spin_unlock(&queue->lock);
 			return true;
 		}
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


