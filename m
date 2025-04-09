Return-Path: <linux-fsdevel+bounces-46088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3141A82670
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1B217B22A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DD5264A73;
	Wed,  9 Apr 2025 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g3mwdPSh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A221B2627EC
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206068; cv=none; b=rJsopHtKPew3FhTK5iSdv1jbIGPbUtujhFi0AHpJcBoLSprB3TTumLSHPLH0KvhELGoOYhVsZqZO2HqiRjlOozMtHRNNgWnJiY5/t9JPrzNfoMU84pQ+x4pLfGBJdzxn5zVWKY/weT979idQ72qLWR7SWrdFv5Q3JM/uCY5bOxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206068; c=relaxed/simple;
	bh=27DHst1S12oqLMIhtZ9NLeDleZ1uTNSrSckCS8D3bdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MD775pKEWGAdKCIJpV6aUvM4HEY1yG8mMi7SccUWegSCmzXL9U+I1p/yu2doH5xFJsKwP5U/hujudYt+uGG7N+kzPsId50zHqieCvMaSh6KOlM+42M/6PdHH6lfoPOVAl1cFSVWj9XCzIEAl611sn8q/p5Eo8b2T5YNVeVIjQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=g3mwdPSh; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85b3f92c866so126829339f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 06:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744206066; x=1744810866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ez1BnkBDoh4P/XSdyZjO5+p/KT887tz530CwsgerFI=;
        b=g3mwdPSh3gffxljaZdwwAhV/99lm0jGV7XmCV8AP7OaL3+RJkUHf76Yserd8NTHUAJ
         Uh51e+tOOBzM/Xlso3o7VxNqNkfKov299R3DCa7gHhAyN/GuzZhpOl7M0C+7PVGDQZZ6
         tZXrIJE7P4KCei0CV9gSKVzB0LxavMTWESfKQoyS4j1mw0eYk8gwLvZUsVUU4TptvPZL
         VKWB5Awd6YhLn+OzhQ2LykKd3gPUGxuMyOUtvi6uISESbISQDV/Yj2lIy/Yim7UkfHCE
         0yE8CSJ5yqsH3MixguLWE72yBjzOBrfCVmmHnZh7WVZqoVZbM60UUPYA564M7gvAoOvl
         OxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744206066; x=1744810866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ez1BnkBDoh4P/XSdyZjO5+p/KT887tz530CwsgerFI=;
        b=O7xO7onYMgxW75+Ht7LFM0cmf2FsA7rUDVeV1pLf9t/c/YMXIy3JpHXNDKDi78ju25
         lhniU4P+eDyhoGc5SezhbEPCIx7+5AmTEfTPckrN2b7C5F4KhRQ/TWed0nRBoU4zY9lO
         h/Ndh4e8FfwfkoYOsiKxi/7lWBsXk/hEt4e5DOmr3Z8yImJ+pm0GMPA6GPHaQA+idXgE
         4urYaEN8sx+jjhGYkjCfkK2QRrUbAU293r80n14KUwZ+b+uFAIRJ9BtWev4cx13edcSQ
         zyjesnc9h2xvyhzbJi4Oq9HW42YLt1EJ82YzZyHEBAeMITlK8K2PzZJEbnjjaudiXz9u
         +TIg==
X-Forwarded-Encrypted: i=1; AJvYcCVRaUQMZ37Z7wwrBowDWTpP/GUbmEDC1sn6xW76ozCqjOyUWPymsxm36BR7IMCxXpX0edxza93N6MQu9/V1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgbyp7sFjAGFsvmgePYJzOocyWcU/wC8JtTqxrOCAX704+REzr
	pabYmnD5P7zCfXGqb61niO9xTxUetAnsw8DjngIF8v4vKqq59E4ehmb5e3jgSA94RdvgYJ1Rm+j
	f
X-Gm-Gg: ASbGncue7ixsjkvRkPBKZUXEE/tGt2jUPGTFibZfxmcyRxjyZ6xGbg0i51Payp+zksn
	IGM7ANnFakRvA4h1SU4Efl6Tn2EdMCL3fQxWsMNbIDl4ucEM/HpteHKV6jGfdJsE8MZP2kPKjrQ
	vuZ37eqYD1FyOYhIZuluTbmUTKmaYOaWCEmkLbD36AuqM5hwfB1T6yELIfIYuLPXsa+w7kNtp1Y
	81XFAzf52bNTOf0VHTjJIAvG+pcyWUsrGXLk56wOjbvdVmzFZflChTMOgeq081otdy/4QnUBv7Y
	uav4J0q3vbRQbls4WZ4Yz6md8YKsUlHvhbioOY5sRadjIvm8SWT70j8=
X-Google-Smtp-Source: AGHT+IFW2Fyl8Ve7PRrc2IiSrj0fh4NJ12qB3srO6FA/0CYOgdkfnTwoGNdFBJf7eo1f/sG8hS25RA==
X-Received: by 2002:a05:6602:4019:b0:85b:46d7:1886 with SMTP id ca18e2360f4ac-86162828f69mr289311339f.7.1744206065750;
        Wed, 09 Apr 2025 06:41:05 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2eaeesm242546173.126.2025.04.09.06.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:41:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/5] io_uring: wait for cancelations on final ring put
Date: Wed,  9 Apr 2025 07:35:22 -0600
Message-ID: <20250409134057.198671-5-axboe@kernel.dk>
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

We still offload the cancelation to a workqueue, as not to introduce
dependencies between the exiting task waiting on cleanup, and that
task needing to run task_work to complete the process.

This means that once the final ring put is done, any request that was
inflight and needed cancelation will be done as well. Notably requests
that hold references to files - once the ring fd close is done, we will
have dropped any of those references too.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/io_uring_types.h |  2 ++
 io_uring/io_uring.c            | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index b44d201520d8..4d26aef281fb 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -450,6 +450,8 @@ struct io_ring_ctx {
 	struct io_mapped_region		param_region;
 	/* just one zcrx per ring for now, will move to io_zcrx_ifq eventually */
 	struct io_mapped_region		zcrx_region;
+
+	struct completion		*exit_comp;
 };
 
 /*
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ce00b616e138..4b3e3ff774d6 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2891,6 +2891,7 @@ static __cold void io_ring_exit_work(struct work_struct *work)
 	struct io_ring_ctx *ctx = container_of(work, struct io_ring_ctx, exit_work);
 	unsigned long timeout = jiffies + HZ * 60 * 5;
 	unsigned long interval = HZ / 20;
+	struct completion *exit_comp;
 	struct io_tctx_exit exit;
 	struct io_tctx_node *node;
 	int ret;
@@ -2955,6 +2956,10 @@ static __cold void io_ring_exit_work(struct work_struct *work)
 
 	io_kworker_tw_end();
 
+	exit_comp = READ_ONCE(ctx->exit_comp);
+	if (exit_comp)
+		complete(exit_comp);
+
 	init_completion(&exit.completion);
 	init_task_work(&exit.task_work, io_tctx_exit_cb);
 	exit.ctx = ctx;
@@ -3017,9 +3022,21 @@ static __cold void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 static int io_uring_release(struct inode *inode, struct file *file)
 {
 	struct io_ring_ctx *ctx = file->private_data;
+	DECLARE_COMPLETION_ONSTACK(exit_comp);
 
 	file->private_data = NULL;
+	WRITE_ONCE(ctx->exit_comp, &exit_comp);
 	io_ring_ctx_wait_and_kill(ctx);
+
+	/*
+	 * Wait for cancel to run before exiting task
+	 */
+	do {
+		if (current->io_uring)
+			io_fallback_tw(current->io_uring, false);
+		cond_resched();
+	} while (wait_for_completion_interruptible(&exit_comp));
+
 	return 0;
 }
 
-- 
2.49.0


