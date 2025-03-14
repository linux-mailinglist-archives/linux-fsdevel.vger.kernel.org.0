Return-Path: <linux-fsdevel+bounces-44044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 135CFA61D15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965977AC92E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 20:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8FD192D66;
	Fri, 14 Mar 2025 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+wSEbl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD2CA32
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985184; cv=none; b=Lz8DEIEGSabXZuyULMCl3VFZFd/HLIeyhcwx8AjwhUSsnq2oLI83s3TChVQ+Mla/MrhDbkk+t8jmow6sComR62fWWk7pRlIbDalMzs8FU4BOJCjrd9t3fsQ4b9brnF76KLw8Hhmea74fLJarnhLXAPf5PhfCUbXwyJG0ilM6rKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985184; c=relaxed/simple;
	bh=f5pbtW4TgfWu64hsxkJC1ihGGEIc5Aq5f0CZXQTf3qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C5bfq78LpxJztZIBP56XO8k0KlQA0W5ZnP/+j9FvEukc1jzhqmFY7P8Yfheiy0E+FSvwEdXDkiFr40ZoEfc+lyj3yHpljL03TnEIaq9FKaeocSAVnidzcYGXavF9YksokbbbYs2PzGMPNOidCYZbEpWaXFo3m0ZDWA1V2RMMEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+wSEbl7; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6feab7c5f96so23421317b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 13:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741985181; x=1742589981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tul7IanylAebekRjiVBISUN9XmW3H7S8h0biYHSmHQ0=;
        b=N+wSEbl7dIGtUmYddhdnUscqkC7CiplkwVtQi24WhvUzkZ0Y/sJCku2ROGy550wp6J
         JPZGsycbaVXDKxmSr19RZ0n35op7susJgy+grDQnWOhhjJymF3Hx8+GuIIbBOj8tmK1N
         gKcOMGDkSPvhz0zVhI9zrQpGCJ4JIpJwBCge3hFRK9lvJQ2TKZdLxTUQKXvnR4u38TeU
         l2wJahWXFh6InzPi1BlNQXODadOIBq6o9CP4Tkac7HDzPczTaJJVDr42SCovNnmPqLSO
         u0s89cKsogcWkc7onx2nF7vbg8Xk3TRGWD40nuqCr0Izg0ryMn4kZXyMovHyBhWp+OMy
         mGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741985181; x=1742589981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tul7IanylAebekRjiVBISUN9XmW3H7S8h0biYHSmHQ0=;
        b=HGdxrK5TggPZ+Smqk2fvM04keqGFXq3eilF57bcLAJJvFdxmUqbSqsBjbZECNSRFBl
         ugEuQBiaCQzqzTOgwZCv3emMSdHnkibTFlzeDRg8CMQNbUD+Av9qwlA8CJMrKfe96ft6
         GocsBAfSST/Vw8cxhQfmazQIdMmsW/hnV7Jgu4cfzkQXKcQ8YTyxNNmo6HSCC+O23gT+
         jAjxAaaJNOE2Gp80jiXWbHivx2bYXB9drKfNtdp4kRMmy81n0wBPNiZuuXp47kgZuKid
         6FPW7iDA4dsx/fcp1Tv2kBAlVtF5V5yL/73a+rGPSW/+AkSZSU5Kq3OIrJNsyboJoz7K
         wg2w==
X-Forwarded-Encrypted: i=1; AJvYcCXkqd4PubpefP2H1lTYofgws0HqjH3TW3NkdRiaeZP48mEoZtcpmWsI7NgUzDeYcmHigRYYUeI1yr4JXOpe@vger.kernel.org
X-Gm-Message-State: AOJu0YxzQM+rDIr7fH9lQFfHfQd+FJ9eoYtTBR1n7T3B+YFx3sG8UfYG
	6khVzSNYK4H9IaCdomxq+SBkuuVAXLpxGyfqallIJYkR7jv/EjSP
X-Gm-Gg: ASbGncuUFtJmBAGin5PYi9r7Tf16mzteSMS91oZf97p4/NZnKT7loNxCjlex+98BQN0
	K1BaGAvFLkbHlea72gpePy6fmgkP5Jf4AA/CpEFXfutM8ZAzFUQxdX8bQZzP/R0QOJhst5iztzI
	zsQHC4/X1tDEwzhtirOpUeJCSQtKmXe+Ye/qdT7sCoq8RbeZTyNEQYCWzHrD36/pnT9yy8HqDfR
	X1yEyZZQyRTjx76AH7ay2Qct0PbIIzTs4sdYInXMiO8D04lN8bCtwmMLgzT2z4nxQfByxevy1g8
	hbYQdURHr06jEle1Uy5onyM38Ff951T627CUUnT4VQ==
X-Google-Smtp-Source: AGHT+IHTOTD8RFXUrb8mQaXXwR3N8qwocH5XsZZc4CTqBQSfo1DRr/wg/owZSzS6yzdGJV9IjDV3QA==
X-Received: by 2002:a05:690c:4982:b0:6ef:761e:cfc with SMTP id 00721157ae682-6ff4608f376mr47906797b3.25.1741985181229;
        Fri, 14 Mar 2025 13:46:21 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32c7a74fsm10344387b3.88.2025.03.14.13.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:46:20 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v1] fuse: support configurable number of uring queues
Date: Fri, 14 Mar 2025 13:44:37 -0700
Message-ID: <20250314204437.726538-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current uring design, the number of queues is equal to the number
of cores on a system. However, on high-scale machines where there are
hundreds of cores, having such a high number of queues is often
overkill and resource-intensive. As well, in the current design where
the queue for the request is set to the cpu the task is currently
executing on (see fuse_uring_task_to_queue()), there is no guarantee
that requests for the same file will be sent to the same queue (eg if a
task is preempted and moved to a different cpu) which may be problematic
for some servers (eg if the server is append-only and does not support
unordered writes).

In this commit, the server can configure the number of uring queues
(passed to the kernel through the init reply). The number of queues must
be a power of two, in order to make queue assignment for a request
efficient. If the server specifies a non-power of two, then it will be
automatically rounded down to the nearest power of two. If the server
does not specify the number of queues, then this will automatically
default to the current behavior where the number of queues will be equal
to the number of cores with core and numa affinity. The queue id hash
is computed on the nodeid, which ensures that requests for the same file
will be forwarded to the same queue.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c       | 48 +++++++++++++++++++++++++++++++++++----
 fs/fuse/dev_uring_i.h     | 11 +++++++++
 fs/fuse/fuse_i.h          |  1 +
 fs/fuse/inode.c           |  4 +++-
 include/uapi/linux/fuse.h |  6 ++++-
 5 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 64f1ae308dc4..f173f9e451ac 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -209,9 +209,10 @@ void fuse_uring_destruct(struct fuse_conn *fc)
 static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 {
 	struct fuse_ring *ring;
-	size_t nr_queues = num_possible_cpus();
+	size_t nr_queues = fc->uring_nr_queues;
 	struct fuse_ring *res = NULL;
 	size_t max_payload_size;
+	unsigned int nr_cpus = num_possible_cpus();
 
 	ring = kzalloc(sizeof(*fc->ring), GFP_KERNEL_ACCOUNT);
 	if (!ring)
@@ -237,6 +238,13 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 
 	fc->ring = ring;
 	ring->nr_queues = nr_queues;
+	if (nr_queues == nr_cpus) {
+		ring->core_affinity = 1;
+	} else {
+		WARN_ON(!nr_queues || nr_queues > nr_cpus ||
+			!is_power_of_2(nr_queues));
+		ring->qid_hash_bits = ilog2(nr_queues);
+	}
 	ring->fc = fc;
 	ring->max_payload_sz = max_payload_size;
 	atomic_set(&ring->queue_refs, 0);
@@ -1217,12 +1225,24 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
 	fuse_uring_send(ent, cmd, err, issue_flags);
 }
 
-static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
+static unsigned int hash_qid(struct fuse_ring *ring, u64 nodeid)
+{
+	if (ring->nr_queues == 1)
+		return 0;
+
+	return hash_long(nodeid, ring->qid_hash_bits);
+}
+
+static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring,
+							struct fuse_req *req)
 {
 	unsigned int qid;
 	struct fuse_ring_queue *queue;
 
-	qid = task_cpu(current);
+	if (ring->core_affinity)
+		qid = task_cpu(current);
+	else
+		qid = hash_qid(ring, req->in.h.nodeid);
 
 	if (WARN_ONCE(qid >= ring->nr_queues,
 		      "Core number (%u) exceeds nr queues (%zu)\n", qid,
@@ -1253,7 +1273,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	int err;
 
 	err = -EINVAL;
-	queue = fuse_uring_task_to_queue(ring);
+	queue = fuse_uring_task_to_queue(ring, req);
 	if (!queue)
 		goto err;
 
@@ -1293,7 +1313,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent = NULL;
 
-	queue = fuse_uring_task_to_queue(ring);
+	queue = fuse_uring_task_to_queue(ring, req);
 	if (!queue)
 		return false;
 
@@ -1344,3 +1364,21 @@ static const struct fuse_iqueue_ops fuse_io_uring_ops = {
 	.send_interrupt = fuse_dev_queue_interrupt,
 	.send_req = fuse_uring_queue_fuse_req,
 };
+
+void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsigned int nr_queues)
+{
+	if (!nr_queues) {
+		fc->uring_nr_queues = num_possible_cpus();
+		return;
+	}
+
+	if (!is_power_of_2(nr_queues)) {
+		unsigned int old_nr_queues = nr_queues;
+
+		nr_queues = rounddown_pow_of_two(nr_queues);
+		pr_debug("init: uring_nr_queues=%u is not a power of 2. "
+			 "Rounding down uring_nr_queues to %u\n",
+			 old_nr_queues, nr_queues);
+	}
+	fc->uring_nr_queues = min(nr_queues, num_possible_cpus());
+}
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index ce823c6b1806..81398b5b8bf2 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -122,6 +122,12 @@ struct fuse_ring {
 	 */
 	unsigned int stop_debug_log : 1;
 
+	/* Each core has its own queue */
+	unsigned int core_affinity : 1;
+
+	/* Only used if core affinity is not set */
+	unsigned int qid_hash_bits;
+
 	wait_queue_head_t stop_waitq;
 
 	/* async tear down */
@@ -143,6 +149,7 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
 void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req);
 bool fuse_uring_queue_bq_req(struct fuse_req *req);
 bool fuse_uring_request_expired(struct fuse_conn *fc);
+void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsigned int nr_queues);
 
 static inline void fuse_uring_abort(struct fuse_conn *fc)
 {
@@ -200,6 +207,10 @@ static inline bool fuse_uring_request_expired(struct fuse_conn *fc)
 	return false;
 }
 
+static inline void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsigned int nr_queues)
+{
+}
+
 #endif /* CONFIG_FUSE_IO_URING */
 
 #endif /* _FS_FUSE_DEV_URING_I_H */
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 38a782673bfd..7c3010bda02d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -962,6 +962,7 @@ struct fuse_conn {
 #ifdef CONFIG_FUSE_IO_URING
 	/**  uring connection information*/
 	struct fuse_ring *ring;
+	uint8_t uring_nr_queues;
 #endif
 
 	/** Only used if the connection opts into request timeouts */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fd48e8d37f2e..c168247d87f2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1433,8 +1433,10 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				else
 					ok = false;
 			}
-			if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
+			if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled()) {
 				fc->io_uring = 1;
+				fuse_uring_set_nr_queues(fc, arg->uring_nr_queues);
+			}
 
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5ec43ecbceb7..0d73b8fcd2be 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -232,6 +232,9 @@
  *
  *  7.43
  *  - add FUSE_REQUEST_TIMEOUT
+ *
+ * 7.44
+ * - add uring_nr_queues to fuse_init_out
  */
 
 #ifndef _LINUX_FUSE_H
@@ -915,7 +918,8 @@ struct fuse_init_out {
 	uint32_t	flags2;
 	uint32_t	max_stack_depth;
 	uint16_t	request_timeout;
-	uint16_t	unused[11];
+	uint8_t		uring_nr_queues;
+	uint8_t		unused[21];
 };
 
 #define CUSE_INIT_INFO_MAX 4096
-- 
2.47.1


