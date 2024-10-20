Return-Path: <linux-fsdevel+bounces-32446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE059A54B2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 17:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C3D1C20B4D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 15:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96418193064;
	Sun, 20 Oct 2024 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu2er5s3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154F6190486;
	Sun, 20 Oct 2024 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729436713; cv=none; b=OQVlEeixrbHiIxsgsiM/3eZF1dkKWiTUkROK0w2gk7/XOo4rFqMzYZtDPdGGZ6TR4khn5gElsjXyp7F2COYDz9qT/v/0ZdIXViH1PDVXx0KEGdAdbNMgSC7LoKjSAqf0xcF5Wxzn3fo8+zfLz00alIRcgy4F75T3+VngclRjBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729436713; c=relaxed/simple;
	bh=hXv2YV71HxsVhLhf9jc60VEfbfO88cvvtCsLrmWz7V4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fr7fFxjI7YNuzPVdlZV8oKsIPoCDTaXfuax9u1yYXSOsR1iXuKfdqyteM/JO7WqyCjAQAEJqrvKlWYBy++kVtxg0oX9ZZf8JFVrGEWijhtEb7oQz285hNVUp699a77s1QIxMRrsy/Wh8DM6BgCivA9eB2lUxpJje8y+bxOkveog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eu2er5s3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so2512804b3a.1;
        Sun, 20 Oct 2024 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729436710; x=1730041510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ycJNDp5mVdZxjSBwbFEBUbv39Fubtc/VHsm79+fXMy4=;
        b=Eu2er5s3U8DA3ZSVohLmK+pY77geZwZlWekvQDn0DcTHjx2aCXrTTmh+ikCWn+ffLA
         B9pkHcsM5AwrjKB1QDjS8NIlX6wmeOu6DdwpBbnDkJ/aJPxY9FTVk8N6M1N9m9NN2GDA
         qhnBiXKlgIgDWEFav8yZzZneIJLkU4TwrFquwgtuNHeNXcNX7Sd4SCNLcKWLyuIsz1NG
         PvQ6Ar+KvV4jbj/tKlq2GATKgCADCQ2K1PBiXjVrPAIuNFGmY4Q6OZwzjDQaPPUg9ddp
         Z0K+6jnEl4fPScV82O5n776bWAcBqgnnHtGdefc0z+8s3D0eipd2UZosd09HGDB7f6sc
         THSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729436710; x=1730041510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ycJNDp5mVdZxjSBwbFEBUbv39Fubtc/VHsm79+fXMy4=;
        b=QL3xbzxrxjCPUbnq2ZY3g9Fl2jPx5b78taykdd9gAB4ebVl4LM98OZq8D2XF93McDh
         pj2QccwDpjhXKD07ZsaOfe6M4gqloqn5Qn06hQbeufhoFetK8fqbtEZKBc+36b3EkhNR
         PNYOjLkaV0r7R44zzw1sbMehNcv4S3LpVyF36ReJdTn8EJY/9tUqipBUVqCmwuIrdKc8
         /NPqBBCmXYk28U5fv8feudghjAoWoLK4ZFF0UIUed4AVjnF5Fm3vLdKQE44ck4SAUUyM
         nfuWdw5As8qvVaoNsZqoab3YjTO9tKBTUFVr3g4TfOW1U/oiAECe00nlT1EaB6bCDTZa
         7bsg==
X-Forwarded-Encrypted: i=1; AJvYcCW7JQPT/JRi73QBoxnZD53zn3u0KbTehbI669Ov+a1zsugXph7Jl3yngabGqKAY9+vuIf34c/U41/DeBL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6OgkTGa9zTYu7C0YHVafPy1s9wpn31P4tnsXGGakJHFCgJ4gT
	dLZSW1nkOApA/fQ4TxDZ7/tJ5YwlxpJRFp1XBnZmHOo6antv/V8R
X-Google-Smtp-Source: AGHT+IFrHwJHZG9g8PrdKTxgBmHERiTLU+NyWOxXTrQYTKcaOihzFUdzzW0bEkJu0I0ErGunMrT2tA==
X-Received: by 2002:a05:6a00:2314:b0:71e:7887:81ac with SMTP id d2e1a72fcca58-71ea31e9406mr12966650b3a.16.1729436709908;
        Sun, 20 Oct 2024 08:05:09 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7eaeaafbb9dsm1366382a12.8.2024.10.20.08.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 08:05:09 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-aio@kvack.org,
	linux-kernel@vger.kernel.org,
	Mohammed Anees <pvmohammedanees2003@gmail.com>
Subject: [PATCH] fs: aio: Transition from Linked List to Hash Table for Active Request Management in AIO
Date: Sun, 20 Oct 2024 20:34:58 +0530
Message-ID: <20241020150458.50762-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a linked list is used to manage active requests, as the
number of requests increases, the time complexity for these operations
leads to performance degradation. Switching to a hash table
significantly improves access speed and overall efficiency.

The following changes are to be implemented to facilitate this:

1. Replace the struct list_head active_reqs with struct rhashtable
active_reqs in the kioctx structure to store active requests.

2. Change all linked list operations for active requests (e.g.,
list_add_tail, list_del, list_empty) to their corresponding hash table
operations (rhashtable_lookup_insert_fast, rhashtable_remove_fast,
rhashtable_lookup_fast).

Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
 fs/aio.c | 83 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 25 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index e8920178b50f..dd22748e29a2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -42,6 +42,8 @@
 #include <linux/percpu-refcount.h>
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
+#include <linux/jhash.h>
+#include <linux/rhashtable.h>
 
 #include <linux/uaccess.h>
 #include <linux/nospec.h>
@@ -146,7 +148,7 @@ struct kioctx {
 
 	struct {
 		spinlock_t	ctx_lock;
-		struct list_head active_reqs;	/* used for cancellation */
+		struct rhashtable active_reqs;	/* used for cancellation */
 	} ____cacheline_aligned_in_smp;
 
 	struct {
@@ -207,8 +209,8 @@ struct aio_kiocb {
 
 	struct io_event		ki_res;
 
-	struct list_head	ki_list;	/* the aio core uses this
-						 * for cancellation */
+	struct rhash_head node; /* the aio core uses this for cancellation */
+
 	refcount_t		ki_refcnt;
 
 	/*
@@ -218,6 +220,28 @@ struct aio_kiocb {
 	struct eventfd_ctx	*ki_eventfd;
 };
 
+struct active_req_rhash_cmp_arg {
+	__u64 obj;
+};
+
+static int active_req_rhash_cmp(struct rhashtable_compare_arg *args, const void *obj)
+{
+	const struct active_req_rhash_cmp_arg *x = args->key;
+	const struct aio_kiocb *entry = obj;
+
+	return (entry->ki_res.obj == x->obj) ? 0 : 1;
+};
+
+static struct rhashtable_params active_req_rhash_params = {
+	.head_offset = offsetof(struct aio_kiocb, node),
+	.key_offset  = offsetof(struct aio_kiocb, ki_res) +
+				   offsetof(struct io_event, obj),
+	.key_len	 = sizeof(__u64),
+	.hashfn      = jhash,
+	.obj_cmpfn	 = active_req_rhash_cmp,
+	.automatic_shrinking   = true,
+};
+
 /*------ sysctl variables----*/
 static DEFINE_SPINLOCK(aio_nr_lock);
 static unsigned long aio_nr;		/* current system wide number of aio requests */
@@ -596,13 +620,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 
 	req = container_of(iocb, struct aio_kiocb, rw);
 
-	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
+	if (WARN_ON_ONCE(req->node.next))
 		return;
 
 	ctx = req->ki_ctx;
 
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
-	list_add_tail(&req->ki_list, &ctx->active_reqs);
+	rhashtable_insert_fast(&ctx->active_reqs, &req->node, active_req_rhash_params);
 	req->ki_cancel = cancel;
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
@@ -647,15 +671,23 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
 static void free_ioctx_users(struct percpu_ref *ref)
 {
 	struct kioctx *ctx = container_of(ref, struct kioctx, users);
-	struct aio_kiocb *req;
+	struct rhashtable_iter it;
+	struct aio_kiocb *entry;
+
+	it.ht = &ctx->active_reqs;
+	it.p = NULL;
+	it.slot = 0;
+	it.skip = 0;
+	it.end_of_table = 0;
 
 	spin_lock_irq(&ctx->ctx_lock);
 
-	while (!list_empty(&ctx->active_reqs)) {
-		req = list_first_entry(&ctx->active_reqs,
-				       struct aio_kiocb, ki_list);
-		req->ki_cancel(&req->rw);
-		list_del_init(&req->ki_list);
+	it.walker.tbl = rcu_dereference_protected(ctx->active_reqs.tbl, 1);
+	list_add(&it.walker.list, &it.walker.tbl->walkers);
+
+	while ((entry = rhashtable_walk_next(&it)) != NULL) {
+		entry->ki_cancel(&entry->rw);
+		rhashtable_remove_fast(&ctx->active_reqs, &entry->node, active_req_rhash_params);
 	}
 
 	spin_unlock_irq(&ctx->ctx_lock);
@@ -777,7 +809,7 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	mutex_lock(&ctx->ring_lock);
 	init_waitqueue_head(&ctx->wait);
 
-	INIT_LIST_HEAD(&ctx->active_reqs);
+	rhashtable_init(&ctx->active_reqs, &active_req_rhash_params);
 
 	if (percpu_ref_init(&ctx->users, free_ioctx_users, 0, GFP_KERNEL))
 		goto err;
@@ -1066,7 +1098,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 
 	percpu_ref_get(&ctx->reqs);
 	req->ki_ctx = ctx;
-	INIT_LIST_HEAD(&req->ki_list);
+	req->node.next = NULL;
 	refcount_set(&req->ki_refcnt, 2);
 	req->ki_eventfd = NULL;
 	return req;
@@ -1484,7 +1516,7 @@ static void aio_remove_iocb(struct aio_kiocb *iocb)
 	unsigned long flags;
 
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
-	list_del(&iocb->ki_list);
+	rhashtable_remove_fast(&ctx->active_reqs, &iocb->node, active_req_rhash_params);
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
 
@@ -1492,7 +1524,9 @@ static void aio_complete_rw(struct kiocb *kiocb, long res)
 {
 	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
 
-	if (!list_empty_careful(&iocb->ki_list))
+	if (rhashtable_lookup_fast(&iocb->ki_ctx->active_reqs,
+							   &iocb->node,
+							   active_req_rhash_params) == 0)
 		aio_remove_iocb(iocb);
 
 	if (kiocb->ki_flags & IOCB_WRITE) {
@@ -1758,7 +1792,7 @@ static void aio_poll_complete_work(struct work_struct *work)
 		list_del_init(&req->wait.entry);
 		poll_iocb_unlock_wq(req);
 	} /* else, POLLFREE has freed the waitqueue, so we must complete */
-	list_del_init(&iocb->ki_list);
+	rhashtable_remove_fast(&ctx->active_reqs, &iocb->node, active_req_rhash_params);
 	iocb->ki_res.res = mangle_poll(mask);
 	spin_unlock_irq(&ctx->ctx_lock);
 
@@ -1813,7 +1847,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		struct kioctx *ctx = iocb->ki_ctx;
 
 		list_del_init(&req->wait.entry);
-		list_del(&iocb->ki_list);
+		rhashtable_remove_fast(&ctx->active_reqs, &iocb->node, active_req_rhash_params);
 		iocb->ki_res.res = mangle_poll(mask);
 		if (iocb->ki_eventfd && !eventfd_signal_allowed()) {
 			iocb = NULL;
@@ -1949,7 +1983,9 @@ static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 			 * Actually waiting for an event, so add the request to
 			 * active_reqs so that it can be cancelled if needed.
 			 */
-			list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
+			rhashtable_insert_fast(&ctx->active_reqs,
+								   &aiocb->node,
+								   active_req_rhash_params);
 			aiocb->ki_cancel = aio_poll_cancel;
 		}
 		if (on_queue)
@@ -2191,13 +2227,10 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 		return -EINVAL;
 
 	spin_lock_irq(&ctx->ctx_lock);
-	/* TODO: use a hash or array, this sucks. */
-	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
-		if (kiocb->ki_res.obj == obj) {
-			ret = kiocb->ki_cancel(&kiocb->rw);
-			list_del_init(&kiocb->ki_list);
-			break;
-		}
+	kiocb = rhashtable_lookup_fast(&ctx->active_reqs, &obj, active_req_rhash_params);
+	if (kiocb) {
+		ret = kiocb->ki_cancel(&kiocb->rw);
+		rhashtable_remove_fast(&ctx->active_reqs, &kiocb->node, active_req_rhash_params);
 	}
 	spin_unlock_irq(&ctx->ctx_lock);
 
-- 
2.47.0


