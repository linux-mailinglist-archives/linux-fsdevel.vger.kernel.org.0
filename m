Return-Path: <linux-fsdevel+bounces-55316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4330B097D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A844618982F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90E25C704;
	Thu, 17 Jul 2025 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5XxWS/1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CAE241676
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794827; cv=none; b=dDCeLib24R7nG/OlMsYoSaiIhWCD49VYcM/aOxWYOFcryLOExD6FqXVyTiUw13YDIcYcwc/weAL923iFY1D66ERWQq953MZa+PzQv5BLzFF5e10YdZDjiM/ifyTYxZuaQxZ+Ix1KZVW0IVXyp2mQ3vtBWt2iO0kOoc2HERXdFC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794827; c=relaxed/simple;
	bh=gy2o8cYeyZnI/gTdw7YBWei2oBEfeK8EymkH8KYBBGQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTdNYSmFvSMnDKUfXBAN/5vLAn5P9dGzwohLvbg0S/UKAbQGaGu6ZMDrQOijMn8BHbvV/UkNYjPXy8ExQnB9l+nB1RLivDWmcoYYoPES/5+13pE5gC7innXPR3PmQZNDBbI3c+mZ9e9a05Dcmb3V9HKBlSR1o5XIjSygRV4ZuDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5XxWS/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67714C4CEE3;
	Thu, 17 Jul 2025 23:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794827;
	bh=gy2o8cYeyZnI/gTdw7YBWei2oBEfeK8EymkH8KYBBGQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=g5XxWS/1wc9c33CwioooVE19UOgXYjrnA6tOSs/L+7JOKwBgN49maRLHA6WMJHdEv
	 yUrxNVfqH7syRKBz+w2sD7YpbXOLCtAd7W74JVKqGaenq47gldlTaMV2me2zglppTH
	 hs13wEWJJyOSoEzc6dEbd/G2XxFP/fMANQPzuf3N9b+B4fFKg2EmzAKnj237fJRlnj
	 JOUc9MMWwlG79SKA4RTrUdlTIY8tIp4BSM6erOE62h9Slgtjcb+OanT5IR9F6MsRiJ
	 BynLQWfxkO5xw5D08ddus3UvmRmY1Ab+OTVvSraO5/G6lUEeQXLiS00lQ50NfgSzEC
	 ykveyzKcurpcA==
Date: Thu, 17 Jul 2025 16:27:06 -0700
Subject: [PATCH 3/7] fuse: capture the unique id of fuse commands being sent
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279449522.710975.4006041367649303770.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
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
index 5387e4239d6aa6..8dd74cbfbcc6fc 100644
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


