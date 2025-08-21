Return-Path: <linux-fsdevel+bounces-58437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FB7B2E9BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07031CC31FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE17018991E;
	Thu, 21 Aug 2025 00:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkKEYke2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18779190685
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737488; cv=none; b=sI76h72qd46OJDZlj7zYg+Zh1/BJQpk8dcNMMPFi1/xqVoDB89wd2ripaGyRWBbwuHpW26gD5vvB3KgaSU9rTtsYr7nGVt9/TtmdHiwVAAsSSC9JxNgBTZEewbwfxjtifrSVIUXDeW22Aa3QX/dnURvqyR50n4k94PzKg3QC7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737488; c=relaxed/simple;
	bh=bynaqyxP2GE2Tm66bcM0Si/TURu/8fF2771Se0Oc4zo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqaKqQOxJuT1xFgokQJ1HNu+GjXAz1eOLAObY2pdXVC14JkVWFeRY4m3F09dnI0gQbAlFHDzX8TxKU4zCWpqPi/VhpAgq1+dlWji2xCq8prGR9vDAYkgtv39WhEOsOjchdgAw89x/ajAX2LhV/4jfWstTNMe+60VcJXJYSJLiyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkKEYke2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81C8C4CEE7;
	Thu, 21 Aug 2025 00:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737487;
	bh=bynaqyxP2GE2Tm66bcM0Si/TURu/8fF2771Se0Oc4zo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EkKEYke202MxbDqNZZfL8AVIfNXWt7kaf8jHeVIFi5w5YtERl3mK200BfJYYCILp2
	 3vOfTa44Hz7gTUgvSsawHzrmzzv9WwBFhZxt/KtDj/WZDhLNTvaX6BjDWyYuxK3Pdy
	 iIH6kluGJHJZRacWhKipGSID09dBV7J4MOwtKMGa1Dz4vnMX8EboHPj/SDwV+rHL4T
	 27M9LAt8oQTdYxbsgteZG9xVmH5y1giiYQ0JFOMQ9F6h5t/dgTjVtxuWuZgW9riIUP
	 +czacxsgPfVOrFLac7T4OsqM24afSe4B7IX2tZ4a2g4v8wJ1yZ1sSJ/t2+vOjHSz06
	 2tdgomMV2kjsg==
Date: Wed, 20 Aug 2025 17:51:27 -0700
Subject: [PATCH 3/7] fuse: capture the unique id of fuse commands being sent
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573708609.15537.12935438672031544498.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The fuse_request_{send,end} tracepoints capture the value of
req->in.h.unique in the trace output.  It would be really nice if we
could use this to match a request to its response for debugging and
latency analysis, but the call to trace_fuse_request_send occurs before
the unique id has been set:

fuse_request_send:    connection 8388608 req 0 opcode 1 (FUSE_LOOKUP) len 107
fuse_request_end:     connection 8388608 req 6 len 16 error -2

Move the callsites to trace_fuse_request_send to after the unique id has
been set, or right before we decide to cancel a request having not set
one.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dev.c       |    6 +++++-
 fs/fuse/dev_uring.c |    8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6f2b277973ca7d..05d6e7779387a4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -376,10 +376,15 @@ static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	if (fiq->connected) {
 		if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
 			req->in.h.unique = fuse_get_unique_locked(fiq);
+
+		/* tracepoint captures in.h.unique */
+		trace_fuse_request_send(req);
+
 		list_add_tail(&req->list, &fiq->pending);
 		fuse_dev_wake_and_unlock(fiq);
 	} else {
 		spin_unlock(&fiq->lock);
+		trace_fuse_request_send(req);
 		req->out.h.error = -ENOTCONN;
 		clear_bit(FR_PENDING, &req->flags);
 		fuse_request_end(req);
@@ -398,7 +403,6 @@ static void fuse_send_one(struct fuse_iqueue *fiq, struct fuse_req *req)
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		fuse_len_args(req->args->in_numargs,
 			      (struct fuse_arg *) req->args->in_args);
-	trace_fuse_request_send(req);
 	fiq->ops->send_req(fiq, req);
 }
 
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 249b210becb1cc..14f263d4419392 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -7,6 +7,7 @@
 #include "fuse_i.h"
 #include "dev_uring_i.h"
 #include "fuse_dev_i.h"
+#include "fuse_trace.h"
 
 #include <linux/fs.h>
 #include <linux/io_uring/cmd.h>
@@ -1265,12 +1266,17 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 
 	err = -EINVAL;
 	queue = fuse_uring_task_to_queue(ring);
-	if (!queue)
+	if (!queue) {
+		trace_fuse_request_send(req);
 		goto err;
+	}
 
 	if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
 		req->in.h.unique = fuse_get_unique(fiq);
 
+	/* tracepoint captures in.h.unique */
+	trace_fuse_request_send(req);
+
 	spin_lock(&queue->lock);
 	err = -ENOTCONN;
 	if (unlikely(queue->stopped))


