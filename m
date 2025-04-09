Return-Path: <linux-fsdevel+bounces-46085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAC7A8266E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AD31BA63CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9244D263F4B;
	Wed,  9 Apr 2025 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W5ygwhuc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFFB25C6E7
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206066; cv=none; b=EEn7YMBMC1vv2qY3ck4GbDWNr+7wVbkudHZBpP1JgbzI6g5gFYpxWSF6abgjRVnsfgjLMKD+Euu5wLjDDhrtlktQQi9rYAFOUmxRTdyxoywU6zE5kFA2dji6SZczwwhVY8f+Duzt1ASTSMTVivebRW7W5hNxKwyhFiWlulnCpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206066; c=relaxed/simple;
	bh=zuxlLmuecWxhF7HszDSq63lAbf31f923lFK+DIkLLjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiAkSqMuYuWhFrN10eFNTD5aJXj20CpMu/IL1m6bY6FmIojTjcErj8iVINPkRJMkvdCj5xQ4aojp37oqkYqoRVYyOwxsKYdku82EddvOnboaM9terTlRwV0qpHKYXenuAm82eb87zZO1I/MgMFd3thtm63r/OwI23CW2lPaQtSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=W5ygwhuc; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso65526235ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744206063; x=1744810863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvkiZRlirJGnWsP0AYjs2Wu7b2S9Zip2/izFiqNb4LM=;
        b=W5ygwhucnXEU2nF7WrOBCXTq9YWNvCkBaelo7tfD1HEIjyG3qWsK1BQ7yyLiyg+pNo
         drLef8E9HB4sbOETPZJTxAYHcv1QEavDuIehKEHUST1A6UK4e/Bf56XraB9uoel48p73
         oVAo7QNczfhBhDJIhSOwts7X8ZFxOBoNs9uYI5A52D2fphFJhpEFIkC2gvxTe1pJbgGa
         os2mjpPFFcz8jXvi+fsP/c1yQXcZFBENfJL0DSUq7n+3l+qyMQ4wMSF54Hzb+B9z/Mql
         ixgu0J9eeeuacMJ6mHRQaFDWL4rM8YafPBjHt3uH3kucfJxHc9YUcxhS6WL26gp+liza
         2Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744206063; x=1744810863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvkiZRlirJGnWsP0AYjs2Wu7b2S9Zip2/izFiqNb4LM=;
        b=Y3RIyz3vKufcuV+Aj/fZgjQJr+bp6euGsh3mdcYUV2QL6cvmvY96RPhD/GnVWdDboL
         H/Wgdwev8Efd5dLCwH/SJhXsMJk6/X/9aWvqrumFH80hclKrgWHEFFpbBuRtmPnak5zK
         zIcY/xdbe724hs86zO6lgYudgUAvGafEAkXyFLSMo6iFq0QSZqYj/1NCLTaLny/EYwGd
         65Hwo0ev6hqxdRzIuGW1ZznFIiGLb0gJbf1sxDfB/Hea57Ank146fvOO68mXsGZZ6NXY
         swM9DFWmLhhoMax0WcwLne4AUfWVYdBcW/JxUmuJEV3tmiseFK0QXaZQYv2888oGd3NS
         cY0g==
X-Forwarded-Encrypted: i=1; AJvYcCVhRMwM7blvd6Aiewi9SkxdjKVSkSMyBylRwdefj/eF029ErhsrAQdh7MC3uoQgw7en+PXZEDwy10b9Q0x+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywozzv/4ncuq6Q+wdoIe/6bGlWm/HnHbl2cs0nkUxdNQ0R7uB8v
	Y3Cj/ILf7zv8IinMNANoTFSgRkH2Ao0/+eEemWruXWEA70cmcxzjKYSBxCNE5tA=
X-Gm-Gg: ASbGncs3+DKWRFCeU4wHHok1vlLdvUVqiuALJ8IswTFYdnOax04P7GDknUSKAF9kW5P
	weyh+hruUYw/aN0rHeufwFWW3Ez0ERgeBvF8tgLcKFQYqEbQcd1hiNEABcnvxQ1sj1swQgwd7eH
	H6/o8ZJmrUE2ZYxwa9znwxjyHHUOmS+WSaE4pLZYKDN/gmEBOvgbqI1+WhJTqZQHvqxX5j00LbM
	gIWiw49cL4P/+ddZ0haw6LuaJLzvFQov13kTTaBw1XG3Lwh1KfhSU9Blr4FzaQR1Ya3uyR96Mk8
	rTzt2kvP1l3WvGxv7ocaTCl986VGiI2XjH/+UvIyjy6g
X-Google-Smtp-Source: AGHT+IF36kiX97IX8oYRAdsiUjrXc1nff3hi3JC3PBUjQfHi0RlevA3PTzyZY9ZvWEsLxoZVfPqn+g==
X-Received: by 2002:a05:6e02:3cc3:b0:3d3:e287:3e7a with SMTP id e9e14a558f8ab-3d77c2cc28bmr27919245ab.19.1744206063178;
        Wed, 09 Apr 2025 06:41:03 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2eaeesm242546173.126.2025.04.09.06.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:41:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] io_uring: mark exit side kworkers as task_work capable
Date: Wed,  9 Apr 2025 07:35:20 -0600
Message-ID: <20250409134057.198671-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409134057.198671-1-axboe@kernel.dk>
References: <20250409134057.198671-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two types of work here:

1) Fallback work, if the task is exiting
2) The exit side cancelations

and both of them may do the final fput() of a file. When this happens,
fput() will schedule delayed work. This slows down exits when io_uring
needs to wait for that work to finish. It is possible to flush this via
flush_delayed_fput(), but that's a big hammer as other unrelated files
could be involved, and from other tasks as well.

Add two io_uring helpers to temporarily clear PF_NO_TASKWORK for the
worker threads, and run any queued task_work before setting the flag
again. Then we can ensure we only flush related items that received
their final fput as part of work cancelation and flushing.

For now these are io_uring private, but could obviously be made
generically available, should there be a need to do so.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index c6209fe44cb1..bff99e185217 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -238,6 +238,20 @@ static inline void io_req_add_to_cache(struct io_kiocb *req, struct io_ring_ctx
 	wq_stack_add_head(&req->comp_list, &ctx->submit_state.free_list);
 }
 
+static __cold void io_kworker_tw_start(void)
+{
+	if (WARN_ON_ONCE(!(current->flags & PF_NO_TASKWORK)))
+		return;
+	current->flags &= ~PF_NO_TASKWORK;
+}
+
+static __cold void io_kworker_tw_end(void)
+{
+	while (task_work_pending(current))
+		task_work_run();
+	current->flags |= PF_NO_TASKWORK;
+}
+
 static __cold void io_ring_ctx_ref_free(struct percpu_ref *ref)
 {
 	struct io_ring_ctx *ctx = container_of(ref, struct io_ring_ctx, refs);
@@ -253,6 +267,8 @@ static __cold void io_fallback_req_func(struct work_struct *work)
 	struct io_kiocb *req, *tmp;
 	struct io_tw_state ts = {};
 
+	io_kworker_tw_start();
+
 	percpu_ref_get(&ctx->refs);
 	mutex_lock(&ctx->uring_lock);
 	llist_for_each_entry_safe(req, tmp, node, io_task_work.node)
@@ -260,6 +276,7 @@ static __cold void io_fallback_req_func(struct work_struct *work)
 	io_submit_flush_completions(ctx);
 	mutex_unlock(&ctx->uring_lock);
 	percpu_ref_put(&ctx->refs);
+	io_kworker_tw_end();
 }
 
 static int io_alloc_hash_table(struct io_hash_table *table, unsigned bits)
@@ -2876,6 +2893,8 @@ static __cold void io_ring_exit_work(struct work_struct *work)
 	struct io_tctx_node *node;
 	int ret;
 
+	io_kworker_tw_start();
+
 	/*
 	 * If we're doing polled IO and end up having requests being
 	 * submitted async (out-of-line), then completions can come in while
@@ -2932,6 +2951,8 @@ static __cold void io_ring_exit_work(struct work_struct *work)
 		 */
 	} while (!wait_for_completion_interruptible_timeout(&ctx->ref_comp, interval));
 
+	io_kworker_tw_end();
+
 	init_completion(&exit.completion);
 	init_task_work(&exit.task_work, io_tctx_exit_cb);
 	exit.ctx = ctx;
-- 
2.49.0


