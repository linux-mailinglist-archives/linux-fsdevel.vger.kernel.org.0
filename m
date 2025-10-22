Return-Path: <linux-fsdevel+bounces-65228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA20DBFE7F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 01:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDC53A81E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 23:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3153309EF7;
	Wed, 22 Oct 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Xam4zb5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com [209.85.167.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEBF3074A7
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761174825; cv=none; b=B51fdMo1z2rPM1wW1drEaYMkPtGqfKi2TWQO6EwMM9QkjhzM6NrtfY2345QAkBiefFHC5AQQ8Z12VQvW6+egf0OzUVrSDr5J4BBg8AxjpipaOCuA7N4t+yo9bYd4Fj0mQ8XfHOkw2TDa7SPwwbAl8kZ08w6DyIwL1Q5GKrVOMFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761174825; c=relaxed/simple;
	bh=1OFERuWCzicdiztTF/q7QW5F9IVu0Slo/TPxet3gSrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsOTuvk4Nyc2kCBLNYvNMWWJeisJBbWFdzdrbuv35HotE2vf47qe92aAoZkedeEkk9qprxmXcedDNRjvyz4BCfq44Ne3jJbsYVhzlNcB4hxOW0xzfmdRiFDnXpvbO/dXOHW+89J9FODeWamydNB95MPFsvMZNVE4NgnIXMk2y7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Xam4zb5r; arc=none smtp.client-ip=209.85.167.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f98.google.com with SMTP id 2adb3069b0e04-592f1f75c46so18308e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 16:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761174820; x=1761779620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=;
        b=Xam4zb5r16Y/IKCWvP6QITJYoF7heFJEsed8B8UaZanQH8/Vewr+LukGzqTyZt/+oz
         7+V26lZY/FyKcX4U4BcWRvwLwazfXkLMm48UCoJwW6ztXSgfCNKFE+CaIINgpfyuJVK+
         xzzxMQYBaAgQXF3rBZ2b6vQYemDhCe39JDVvycZR5FQNriI+FanqPZzQxF07BUEntRBy
         5EQ2yj1jif4Qo7ynIVspsunPeJr/FaLSt23CSyRt1CXTaQJrNnWCV28gZUc9WT+9oUfa
         kJIEOa2OWtw4AlR32nnWWx8T1+SUFiU3M0x685wNVBcosmCIYd71NVC4CNKmK28om9hQ
         RaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761174820; x=1761779620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=;
        b=kUypWiM7qQyLVeWYEDxSF1u9hKapWXVbPUqTgSSbVHcPkBJrTO2MHqo+lnpJQqJvOt
         WT4S94fUWAsllcMDqNj1ceScgxG6wLTgLPkdqtna5TxwL+8O2Ae27jrOLicBlVl/IQGJ
         7x98t/ozJ5NDhoHz15MyQFwCkXGJ5edVtLm3y5FoYr5w/BO+8sK0QSo9UXRqsIPnlJux
         5FkyFG2a3N7Z7ModUZ3PL5qBUuhAOYQIiQVKQQSbr7s9aP8/43sPvBc13+n4W0gLOve5
         ZHGJq4P2if0gdXg+vpEb6cWN/7fc1tyTM0lPp6CB6F56XXdYplEQeGYrSiU2pdHlQ6Lo
         UFhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmgbQ97s5wFvymPTupSj9txwPSUZBYt9UJtyYn7y6iOvhkYv8Ilq6VMCFq6JRxKfbbfTlmGO7VSPrP0wsP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/DktbUXbxF6gTMbKvctAlrG2k2VQcy8yzAzulMWzvSwkw4BN
	+lmTQxmLlYKzGhXtgSw2n2WFlFq5XhinX1RdTIHXDlqDVAPP87vSfsDQ+ZkILmiMpznSuIeGbsZ
	PIx5LVp8RJpSRcZgu/+WCEAmhye+J7lqEGbK4B7OAWJ9jXBbcH9qJ
X-Gm-Gg: ASbGncsvot9nxN48nnzcfw9I2maufTz7qjO0ulwXkzXpWxQQTiks7KE0nyhYI2/4Dfn
	qRMrArKppX4x7Y4eWenlRFrGfYHIRhTFSqq1By9hxy5CkcwDoUbFNy4b437gInO79Nmpj91/MZd
	KxmAsLV5g+2EomVRCzUCPGIWtiWVjgbplPZOL0S8R0fJdU/TawfswQOyvOmhQzpvZd+C8rMgn91
	7FQpwSzS/506ZcdEFpKwwQjoaWcPIECXzkxsJtwbPrVHPZHK1Aw/A3FfIAjNRzz0Oe8NbZJ0tqn
	qNC1xje/DYPCAqxKN9WyJ6c7axDr4a+OnfhWiqTZ4HDWRkRv/2vvnDHay4ipY2EhXYgEqriPswI
	JLbPp91DStqr4xkRM
X-Google-Smtp-Source: AGHT+IGpBSpTcUsGiFW1y6xN6RAigIl6sP5f7WQURKVhSLye12F+OPVHcs9jbRx67/PqsX7m7H0LAVn7y4om
X-Received: by 2002:a05:6512:2209:b0:57a:2be1:d766 with SMTP id 2adb3069b0e04-591d854a5a5mr3690398e87.4.1761174820364;
        Wed, 22 Oct 2025 16:13:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-592f4ce7a08sm35160e87.29.2025.10.22.16.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:13:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B07D23406A7;
	Wed, 22 Oct 2025 17:13:38 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id AD471E4181C; Wed, 22 Oct 2025 17:13:38 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/3] io_uring/uring_cmd: call io_should_terminate_tw() when needed
Date: Wed, 22 Oct 2025 17:13:25 -0600
Message-ID: <20251022231326.2527838-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251022231326.2527838-1-csander@purestorage.com>
References: <20251022231326.2527838-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most uring_cmd task work callbacks don't check IO_URING_F_TASK_DEAD. But
it's computed unconditionally in io_uring_cmd_work(). Add a helper
io_uring_cmd_should_terminate_tw() and call it instead of checking
IO_URING_F_TASK_DEAD in the one callback, fuse_uring_send_in_task().
Remove the now unused IO_URING_F_TASK_DEAD.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 fs/fuse/dev_uring.c            | 2 +-
 include/linux/io_uring/cmd.h   | 7 ++++++-
 include/linux/io_uring_types.h | 1 -
 io_uring/uring_cmd.c           | 6 +-----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index f6b12aebb8bb..71b0c9662716 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1214,11 +1214,11 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
 {
 	struct fuse_ring_ent *ent = uring_cmd_to_ring_ent(cmd);
 	struct fuse_ring_queue *queue = ent->queue;
 	int err;
 
-	if (!(issue_flags & IO_URING_F_TASK_DEAD)) {
+	if (!io_uring_cmd_should_terminate_tw(cmd)) {
 		err = fuse_uring_prepare_send(ent, ent->fuse_req);
 		if (err) {
 			fuse_uring_next_fuse_req(ent, queue, issue_flags);
 			return;
 		}
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 7509025b4071..b84b97c21b43 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef _LINUX_IO_URING_CMD_H
 #define _LINUX_IO_URING_CMD_H
 
 #include <uapi/linux/io_uring.h>
-#include <linux/io_uring_types.h>
+#include <linux/io_uring.h>
 #include <linux/blk-mq.h>
 
 /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
 #define IORING_URING_CMD_CANCELABLE	(1U << 30)
 /* io_uring_cmd is being issued again */
@@ -143,10 +143,15 @@ static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
 			io_uring_cmd_tw_t task_work_cb)
 {
 	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, 0);
 }
 
+static inline bool io_uring_cmd_should_terminate_tw(struct io_uring_cmd *cmd)
+{
+	return io_should_terminate_tw(cmd_to_io_kiocb(cmd)->ctx);
+}
+
 static inline struct task_struct *io_uring_cmd_get_task(struct io_uring_cmd *cmd)
 {
 	return cmd_to_io_kiocb(cmd)->tctx->task;
 }
 
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index c2ea6280901d..278c4a25c9e8 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -37,11 +37,10 @@ enum io_uring_cmd_flags {
 	IO_URING_F_IOPOLL		= (1 << 10),
 
 	/* set when uring wants to cancel a previously issued command */
 	IO_URING_F_CANCEL		= (1 << 11),
 	IO_URING_F_COMPAT		= (1 << 12),
-	IO_URING_F_TASK_DEAD		= (1 << 13),
 };
 
 struct io_wq_work_node {
 	struct io_wq_work_node *next;
 };
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index d1e3ba62ee8e..35bdac35cf4d 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -114,17 +114,13 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 EXPORT_SYMBOL_GPL(io_uring_cmd_mark_cancelable);
 
 static void io_uring_cmd_work(struct io_kiocb *req, io_tw_token_t tw)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
-	unsigned int flags = IO_URING_F_COMPLETE_DEFER;
-
-	if (io_should_terminate_tw(req->ctx))
-		flags |= IO_URING_F_TASK_DEAD;
 
 	/* task_work executor checks the deffered list completion */
-	ioucmd->task_work_cb(ioucmd, flags);
+	ioucmd->task_work_cb(ioucmd, IO_URING_F_COMPLETE_DEFER);
 }
 
 void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 			io_uring_cmd_tw_t task_work_cb,
 			unsigned flags)
-- 
2.45.2


