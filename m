Return-Path: <linux-fsdevel+bounces-61495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BF0B5892C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5ECA188A571
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0951A01C6;
	Tue, 16 Sep 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9HBXzM3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137ED72639;
	Tue, 16 Sep 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982289; cv=none; b=ZsBAAcUgD4eh6SFC+TlsKfm84EKlFe3fwVYwUCznEVbUcnOQ+MzJylB2Z7WTeMagoLkfaXTOYxjEDHV4SZmlc4/t0RRGGxWV+RdntvyC0LivUli5n+pFemTmz/ln1s4eE+tVsCqJnmXJ/tyy/3tBPHN/7YqNJjR+77Od3AikUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982289; c=relaxed/simple;
	bh=MHL8E7KPFYVSVP2rXPiKzeKeAHc/xinyTyNMUaMVLMo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwWOd50iTEQ+zg9zXOpA2dIh/6x0Dtu20amokMVlfAVqaSok2v/aYsBY4RzJtwMjiDobQLMOBUbRSIPUa37ZPLJERa+aCUf1UCRIQx2S5bDZhSAqLaD9bEvh0FoCUXadMOtbJYAo3U3leseiIViLrVPhBE1sHzx5CFW52WVZDUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9HBXzM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2076C4CEF1;
	Tue, 16 Sep 2025 00:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982288;
	bh=MHL8E7KPFYVSVP2rXPiKzeKeAHc/xinyTyNMUaMVLMo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=O9HBXzM3gs/PoMjTt78xJmXk4E9YvUvr4BoxgJinDZ/9dNMaY92EeaaWlamg7SPTE
	 x9QmMsis67Xawb6UP7xYCpn+d9XA3loJsrvxC6rnpUy17xDv2FOZdD9exC4zeJWz3X
	 rk5+X3PXw0i8FDpSKCqkLI0/tdZi/93xy2BC/R7UgrNQfzsOxlaIM9aPxENVCYzE+x
	 XGmFr+OzQOTchNg7mTQ8zFDEs2UfiLzP9w5oWc72udxFWjyr387kmuq770e4IZmJ7k
	 fiINZt9D4FyAGazp44ITU93EMIEJR7umIEG9ARHoSX57k0x9DbXmnX/ruNUtO68Yxc
	 u/jKn+Qfu4aaw==
Date: Mon, 15 Sep 2025 17:24:48 -0700
Subject: [PATCH 3/8] fuse: capture the unique id of fuse commands being sent
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798150092.381990.6046110863068073279.stgit@frogsfrogsfrogs>
In-Reply-To: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
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

(Notice that req moves from 0 to 6)

Move the callsites to trace_fuse_request_send to after the unique id has
been set by introducing a helper to do that for standard fuse_req
requests.  FUSE_FORGET requests are not covered by this because they
appear to be synthesized into the event stream without a fuse_req
object and are never replied to.

Requests that are aborted without ever having been submitted to the fuse
server retain the behavior that only the fuse_request_end tracepoint
shows up in the trace record, and with req==0.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h    |    5 +++++
 fs/fuse/dev.c       |   27 +++++++++++++++++++++++----
 fs/fuse/dev_uring.c |    4 ++--
 fs/fuse/virtio_fs.c |    3 +--
 4 files changed, 31 insertions(+), 8 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8edca9ad13a9d1..e93a3c3f11d901 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1254,6 +1254,11 @@ static inline ssize_t fuse_simple_idmap_request(struct mnt_idmap *idmap,
 int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 			   gfp_t gfp_flags);
 
+/**
+ * Assign a unique id to a fuse request
+ */
+void fuse_request_assign_unique(struct fuse_iqueue *fiq, struct fuse_req *req);
+
 /**
  * End a finished request
  */
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index dcd338b65b2fc7..f06208e4364642 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -370,12 +370,32 @@ void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 	}
 }
 
+static inline void fuse_request_assign_unique_locked(struct fuse_iqueue *fiq,
+						     struct fuse_req *req)
+{
+	if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
+		req->in.h.unique = fuse_get_unique_locked(fiq);
+
+	/* tracepoint captures in.h.unique and in.h.len */
+	trace_fuse_request_send(req);
+}
+
+inline void fuse_request_assign_unique(struct fuse_iqueue *fiq,
+				       struct fuse_req *req)
+{
+	if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
+		req->in.h.unique = fuse_get_unique(fiq);
+
+	/* tracepoint captures in.h.unique and in.h.len */
+	trace_fuse_request_send(req);
+}
+EXPORT_SYMBOL_GPL(fuse_request_assign_unique);
+
 static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	spin_lock(&fiq->lock);
 	if (fiq->connected) {
-		if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
-			req->in.h.unique = fuse_get_unique_locked(fiq);
+		fuse_request_assign_unique_locked(fiq, req);
 		list_add_tail(&req->list, &fiq->pending);
 		fuse_dev_wake_and_unlock(fiq);
 	} else {
@@ -398,7 +418,6 @@ static void fuse_send_one(struct fuse_iqueue *fiq, struct fuse_req *req)
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		fuse_len_args(req->args->in_numargs,
 			      (struct fuse_arg *) req->args->in_args);
-	trace_fuse_request_send(req);
 	fiq->ops->send_req(fiq, req);
 }
 
@@ -688,10 +707,10 @@ static bool fuse_request_queue_background_uring(struct fuse_conn *fc,
 {
 	struct fuse_iqueue *fiq = &fc->iq;
 
-	req->in.h.unique = fuse_get_unique(fiq);
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		fuse_len_args(req->args->in_numargs,
 			      (struct fuse_arg *) req->args->in_args);
+	fuse_request_assign_unique(fiq, req);
 
 	return fuse_uring_queue_bq_req(req);
 }
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 249b210becb1cc..7b541aeea1813f 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -7,6 +7,7 @@
 #include "fuse_i.h"
 #include "dev_uring_i.h"
 #include "fuse_dev_i.h"
+#include "fuse_trace.h"
 
 #include <linux/fs.h>
 #include <linux/io_uring/cmd.h>
@@ -1268,8 +1269,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	if (!queue)
 		goto err;
 
-	if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
-		req->in.h.unique = fuse_get_unique(fiq);
+	fuse_request_assign_unique(fiq, req);
 
 	spin_lock(&queue->lock);
 	err = -ENOTCONN;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 76c8fd0bfc75d5..a880294549a6bd 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1480,8 +1480,7 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	struct virtio_fs_vq *fsvq;
 	int ret;
 
-	if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
-		req->in.h.unique = fuse_get_unique(fiq);
+	fuse_request_assign_unique(fiq, req);
 
 	clear_bit(FR_PENDING, &req->flags);
 


