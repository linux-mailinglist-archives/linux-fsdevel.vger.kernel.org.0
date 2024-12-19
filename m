Return-Path: <linux-fsdevel+bounces-37879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39F79F8615
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 21:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3D016A803
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 20:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2601C07EC;
	Thu, 19 Dec 2024 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mT9JuZVw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67911A01B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734640925; cv=none; b=h7PWQ+R2Q3zlrdwonD/mDux+7Z+5UFN+IzPuslJ/hHuJcQ84cfW49vnw9va6fdizppCn7sP4Q5MG8NPV7vQOgup8qxMCe5kU/MAKrVTKGpdN0igD2YdnkKfzWzuzZwZwUoyuUkeDVZFnipFQ4NKxHSZqsgghZc3KpOvc9LLBqjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734640925; c=relaxed/simple;
	bh=JElbi5YngIzLh/vBsQQgQ05vOX9HQBGKY+OMAXxg5ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tWE10msuRhQCKFL1elwETXtvt2yAhIqRf7ZuxdG4XEsWo35yAboffozfKbREgzyjprw51b5HfJmY6J1sfs+cziwm+aVMrVCs/+OmqKVz28UIpFwmnkGWYvzGn7KCRifkj4R9M3yDXU5XhMTOOdZ/DF8nge3TUHI0wyumLk81iyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mT9JuZVw; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6e9db19c8so84641785a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 12:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734640922; x=1735245722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOwfFQi7psnaDgnWfDmSxFnkoBVFjS/LaapkwqEKYXg=;
        b=mT9JuZVwtQdvl4KcJcseUYNvIcZhoiLdPW0ABgItSCMHDKG1YNXtBvZFgQAbIJZRYA
         t08aX1k91kzejIJfEVmKviU9rrJvsprBsJalRaJhGNq8+BitZug456jXbLZ58vY/s00a
         x3G9BgvjhXgcEF+KK8ozCRl72UGBcPX9rd6XhXC9GMujhbbH2vi+bSIE+ciAJHxmbCbQ
         orRxvTdE7+EOZg4IQM2uVZpaVocnBMLRLMZoF3acRsc647NPyNR1oEk2MnzXJag29zAB
         A8gi81Ci9KdC6plv3wevTg1iVQR5q+H/ab0W9sCAHn17R9M1rm3MDdX5k9KA/SBWrsc5
         e6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734640922; x=1735245722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOwfFQi7psnaDgnWfDmSxFnkoBVFjS/LaapkwqEKYXg=;
        b=YHbCV3QL9OGK0ow7ZcUm3L68wal0/QCKwEOcIP5arFQTsm658i4KGK38BPkXfRuADR
         VXXGnbC7YR2bSsHUJZIAwGkdV+5kFLQavq4cVpFgQ/KQxGviGxW7cjHL16IlGuLZdgsV
         lOC+AtNPjAzlccdBcjbTB9OZb2qYEVGuK03iggZ2WkxW1j12S+zb5lfj+Kmgy35LQHRM
         G2xeNc5EGr7IMhnJ9PDtSIf1L975necva4pa0aedvm066Fz6e9rV4SJgABJ51GLit83v
         VGl3JPPb+6YnmauF/e4Lhm9aTAr+Byn9TnUFXGbkxC3K0tXYd7/33keTKcm5RK5CKZPe
         Y/IQ==
X-Gm-Message-State: AOJu0YwC6Tywuid4HYv1ejtEBs5GS3IYLOnvZ42BjkJFa+gmSI6wIvN7
	C58FllUR8JjUbbKHTyV9yz1RJ5A41jcjXlVQOVijwn8IVy+rJLCuvvne3w==
X-Gm-Gg: ASbGncsWusiLypYYAJBaDN30GBAN6zyBI+18xBtPwybXYjjvMcjL1oi2O2EG5iklhlZ
	3H8bO7MrgSvTEQt9ws0CX+vYuoVLR+KFBYAw0NqITaU2OU8cRMXvKLaEZokZoqNcTRq/1MbmhHg
	t/Q6I+yCwyl1B1Sb1OsAnhdcBiAtGPu2pojfN/lfdAYmJyfPVn0ohGTXrD73wMMEtrkR6tp/QEM
	55IhtoL31txge1ZBeP4/VuBGuZrw9v8EVK2HwCfU5/zmUdPeZd6IJpFZhm5321vmU9dpPJGjqOH
	osq7CbxAxV9TRlswk3BQY+sVvZjtm2Et3aZP22p/5u250ctccGxv+RmNPD/opXM=
X-Google-Smtp-Source: AGHT+IG/IIQosASwEDxTMSGHlTEeywTCzjz6FF76LarJraWxRJkU3rkWC5Rr+1km7K7UWBx4T0Yd5g==
X-Received: by 2002:a05:620a:19a4:b0:7b6:c92e:2e6f with SMTP id af79cd13be357-7b9ba754a42mr57515485a.22.1734640922637;
        Thu, 19 Dec 2024 12:42:02 -0800 (PST)
Received: from localhost.localdomain (lnsm3-toronto63-142-127-175-73.internet.virginmobile.ca. [142.127.175.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2df6d3sm78889585a.46.2024.12.19.12.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 12:42:02 -0800 (PST)
From: Etienne Martineau <etmartin4313@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu
Cc: joannelkoong@gmail.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	laoar.shao@gmail.com,
	senozhatsky@chromium.org,
	jlayton@kernel.org,
	etmartin@cisco.com,
	Etienne Martineau <etmartin4313@gmail.com>
Subject: [RFC] fuse: Abort connection if FUSE server get stuck
Date: Thu, 19 Dec 2024 15:41:49 -0500
Message-Id: <20241219204149.11958-2-etmartin4313@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219204149.11958-1-etmartin4313@gmail.com>
References: <20241219204149.11958-1-etmartin4313@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Etienne Martineau <etmartin4313@gmail.com>
---
 fs/fuse/dev.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h | 13 +++++++++
 fs/fuse/inode.c  |  7 +++++
 3 files changed, 88 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 27ccae63495d..351787363444 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -21,6 +21,8 @@
 #include <linux/swap.h>
 #include <linux/splice.h>
 #include <linux/sched.h>
+#include <linux/completion.h>
+#include <linux/sched/sysctl.h>
 
 #define CREATE_TRACE_POINTS
 #include "fuse_trace.h"
@@ -307,11 +309,75 @@ const struct fuse_iqueue_ops fuse_dev_fiq_ops = {
 };
 EXPORT_SYMBOL_GPL(fuse_dev_fiq_ops);
 
+static void fuse_timeout_checkpoint_in(struct fuse_req *req)
+{
+	int idx;
+	struct fuse_conn *fc = req->fm->fc;
+
+	if (!sysctl_hung_task_timeout_secs)
+		return;
+	req->checkpoint_time = jiffies;
+	idx = (req->checkpoint_time >> FUSE_TIMEOUT_JIFFIES) % FUSE_TIMEOUT_DISTRIBUTION;
+	atomic_inc(&fc->timeout_distribution[idx]);
+}
+
+static void fuse_timeout_checkpoint_out(struct fuse_req *req)
+{
+	int idx;
+	struct fuse_conn *fc = req->fm->fc;
+
+	if (!sysctl_hung_task_timeout_secs)
+		return;
+	idx = (req->checkpoint_time >> FUSE_TIMEOUT_JIFFIES) % FUSE_TIMEOUT_DISTRIBUTION;
+	atomic_dec(&fc->timeout_distribution[idx]);
+}
+
+/*
+ * The fuse timeout logic maintain a time distribution sliding window
+ * made of FUSE_TIMEOUT_DISTRIBUTION entries where each entries span over a
+ * number of jiffies defined by FUSE_TIMEOUT_JIFFIES in base 2.
+ * Just before sending the request to the server, we increment the coresponding
+ * distribution entry and once the request is ack back, we decrement that same
+ * entry because we remember req->checkpoint_time.
+ * Now, a timeout can be detected by simply looking at the old entries in the
+ * distribution and see if there is something hanging past a certain point.
+ */
+void fuse_check_timeout(struct work_struct *wk)
+{
+	int idx, x;
+	struct timespec64 t;
+	struct fuse_conn *fc = container_of(wk, struct fuse_conn, work.work);
+
+	if (!atomic_read(&fc->num_waiting))
+		goto out;
+
+	/* Current position in the distribution */
+	idx = (jiffies >> FUSE_TIMEOUT_JIFFIES) % FUSE_TIMEOUT_DISTRIBUTION;
+
+	/* Walk back and trigger abort when detecting old entries in the second half */
+	for (x = 0; x < FUSE_TIMEOUT_DISTRIBUTION; x++,
+			idx == 0 ? idx = FUSE_TIMEOUT_DISTRIBUTION-1 : idx--) {
+		/* First half, keep going */
+		if (x < FUSE_TIMEOUT_DISTRIBUTION>>1)
+			continue;
+		if (atomic_read(&fc->timeout_distribution[idx])) {
+			pr_info("fuse %u is stuck, aborting\n", fc->dev);
+			fuse_abort_conn(fc);
+			return;
+		}
+	}
+out:
+	if (sysctl_hung_task_timeout_secs)
+		queue_delayed_work(system_wq, &fc->work,
+			sysctl_hung_task_timeout_secs * (HZ / 2));
+}
+
 static void fuse_send_one(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		fuse_len_args(req->args->in_numargs,
 			      (struct fuse_arg *) req->args->in_args);
+	fuse_timeout_checkpoint_in(req);
 	trace_fuse_request_send(req);
 	fiq->ops->send_req(fiq, req);
 }
@@ -359,6 +425,7 @@ void fuse_request_end(struct fuse_req *req)
 	if (test_and_set_bit(FR_FINISHED, &req->flags))
 		goto put_request;
 
+	fuse_timeout_checkpoint_out(req);
 	trace_fuse_request_end(req);
 	/*
 	 * test_and_set_bit() implies smp_mb() between bit
@@ -2260,6 +2327,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		LIST_HEAD(to_end);
 		unsigned int i;
 
+		cancel_delayed_work(&fc->work);
 		/* Background queuing checks fc->connected under bg_lock */
 		spin_lock(&fc->bg_lock);
 		fc->connected = 0;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 74744c6f2860..243d482a057d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -44,6 +44,12 @@
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5
 
+/** Request timeout handling */
+#define FUSE_TIMEOUT_DISTRIBUTION_SHIFT 3
+#define FUSE_TIMEOUT_DISTRIBUTION (1L << FUSE_TIMEOUT_DISTRIBUTION_SHIFT)
+#define FUSE_TIMEOUT_JIFFIES (order_base_2( \
+	(sysctl_hung_task_timeout_secs * HZ) >> FUSE_TIMEOUT_DISTRIBUTION_SHIFT))
+
 /** Maximum of max_pages received in init_out */
 extern unsigned int fuse_max_pages_limit;
 
@@ -438,6 +444,8 @@ struct fuse_req {
 
 	/** fuse_mount this request belongs to */
 	struct fuse_mount *fm;
+
+	unsigned long checkpoint_time;
 };
 
 struct fuse_iqueue;
@@ -923,8 +931,12 @@ struct fuse_conn {
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
+
+	atomic_t timeout_distribution[FUSE_TIMEOUT_DISTRIBUTION];
+	struct delayed_work work;
 };
 
+
 /*
  * Represents a mounted filesystem, potentially a submount.
  *
@@ -1190,6 +1202,7 @@ void fuse_request_end(struct fuse_req *req);
 /* Abort all requests */
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
+void fuse_check_timeout(struct work_struct *wk);
 
 /**
  * Invalidate inode attributes
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3ce4f4e81d09..9f8fe17801c4 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -23,6 +23,8 @@
 #include <linux/exportfs.h>
 #include <linux/posix_acl.h>
 #include <linux/pid_namespace.h>
+#include <linux/completion.h>
+#include <linux/sched/sysctl.h>
 #include <uapi/linux/magic.h>
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
@@ -1002,6 +1004,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 		struct fuse_iqueue *fiq = &fc->iq;
 		struct fuse_sync_bucket *bucket;
 
+		cancel_delayed_work_sync(&fc->work);
 		if (IS_ENABLED(CONFIG_FUSE_DAX))
 			fuse_dax_conn_free(fc);
 		if (fiq->ops->release)
@@ -1785,6 +1788,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
+	INIT_DELAYED_WORK(&fc->work, fuse_check_timeout);
+	if (sysctl_hung_task_timeout_secs)
+		queue_delayed_work(system_wq, &fc->work,
+			sysctl_hung_task_timeout_secs * (HZ / 2));
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
-- 
2.34.1


